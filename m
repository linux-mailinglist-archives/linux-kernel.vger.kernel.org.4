Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773076BE876
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCQLmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCQLl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:41:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1FACE1C86
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:41:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A4021763;
        Fri, 17 Mar 2023 04:41:12 -0700 (PDT)
Received: from [10.57.53.217] (unknown [10.57.53.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51EEC3F885;
        Fri, 17 Mar 2023 04:40:27 -0700 (PDT)
Message-ID: <4a71fa7a-c986-2cc2-a214-e2f4f7d56a2b@arm.com>
Date:   Fri, 17 Mar 2023 11:40:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 9/9] coresight: Fix CTI module refcount leak by making
 it a helper device
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-10-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230310160610.742382-10-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 16:06, James Clark wrote:
> The CTI module has some hard coded refcounting code that has a leak.
> For example running perf and then trying to unload it fails:
> 
>    perf record -e cs_etm// -a -- ls
>    rmmod coresight_cti
> 
>    rmmod: ERROR: Module coresight_cti is in use
> 
> The coresight core already handles references of devices in use, so by
> making CTI a normal helper device, we get working refcounting for free.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 73 +++----------------
>   .../hwtracing/coresight/coresight-cti-core.c  | 56 +++++++++-----
>   .../hwtracing/coresight/coresight-cti-sysfs.c |  4 +-
>   drivers/hwtracing/coresight/coresight-cti.h   |  4 +-
>   include/linux/coresight.h                     | 28 +------
>   5 files changed, 53 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 3e6ccd9e8d4e..94d84404fb29 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -253,48 +253,6 @@ void coresight_disclaim_device(struct coresight_device *csdev)
>   }
>   EXPORT_SYMBOL_GPL(coresight_disclaim_device);
>   
> -/* enable or disable an associated CTI device of the supplied CS device */
> -static int
> -coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
> -{
> -	int ect_ret = 0;
> -	struct coresight_device *ect_csdev = csdev->ect_dev;
> -	struct module *mod;
> -
> -	if (!ect_csdev)
> -		return 0;
> -	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
> -		return 0;
> -
> -	mod = ect_csdev->dev.parent->driver->owner;
> -	if (enable) {
> -		if (try_module_get(mod)) {
> -			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
> -			if (ect_ret) {
> -				module_put(mod);
> -			} else {
> -				get_device(ect_csdev->dev.parent);
> -				csdev->ect_enabled = true;
> -			}
> -		} else
> -			ect_ret = -ENODEV;
> -	} else {
> -		if (csdev->ect_enabled) {
> -			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
> -			put_device(ect_csdev->dev.parent);
> -			module_put(mod);
> -			csdev->ect_enabled = false;
> -		}
> -	}
> -
> -	/* output warning if ECT enable is preventing trace operation */
> -	if (ect_ret)
> -		dev_info(&csdev->dev, "Associated ECT device (%s) %s failed\n",
> -			 dev_name(&ect_csdev->dev),
> -			 enable ? "enable" : "disable");
> -	return ect_ret;
> -}
> -
>   /*
>    * Set the associated ect / cti device while holding the coresight_mutex
>    * to avoid a race with coresight_enable that may try to use this value.
> @@ -302,8 +260,14 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
>   void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
>   				      struct coresight_device *ect_csdev)
>   {
> +	struct coresight_connection conn = {};
> +
>   	mutex_lock(&coresight_mutex);
> -	csdev->ect_dev = ect_csdev;
> +	conn.remote_fwnode = fwnode_handle_get(dev_fwnode(&ect_csdev->dev));
> +	conn.remote_dev = ect_csdev;
> +	conn.remote_port = conn.port = -1;
> +	coresight_add_conn(csdev->dev.parent, csdev->pdata, &conn);

> +	coresight_fixup_inputs(csdev);

Can this cause duplicate entries to be created for the other "existing"
output connections of csdev ? IIUC, we just need to create the input
connection for the connection we are creating now and not all of the
out_conns. They should have been populated at coresight_register().
Now you may not hit this, because we don't have any actual "defined"
connections in the DT. But we need to be safe here.


>   	mutex_unlock(&coresight_mutex);
>   }
>   EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
> @@ -320,12 +284,8 @@ static int coresight_enable_sink(struct coresight_device *csdev,
>   	if (!sink_ops(csdev)->enable)
>   		return -EINVAL;
>   
> -	ret = coresight_control_assoc_ectdev(csdev, true);
> -	if (ret)
> -		return ret;
>   	ret = sink_ops(csdev)->enable(csdev, mode, data);
>   	if (ret) {
> -		coresight_control_assoc_ectdev(csdev, false);
>   		return ret;
>   	}

super minor nit: You could remove the { } too

>   	csdev->enable = true;
> @@ -343,7 +303,6 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>   	ret = sink_ops(csdev)->disable(csdev);
>   	if (ret)
>   		return;
> -	coresight_control_assoc_ectdev(csdev, false);
>   	csdev->enable = false;
>   }
>   
> @@ -368,17 +327,11 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   		return outport;
>   
>   	if (link_ops(csdev)->enable) {
> -		ret = coresight_control_assoc_ectdev(csdev, true);
> -		if (!ret) {
> -			ret = link_ops(csdev)->enable(csdev, inport, outport);
> -			if (ret)
> -				coresight_control_assoc_ectdev(csdev, false);
> -		}
> +		ret = link_ops(csdev)->enable(csdev, inport, outport);
> +		if (!ret)
> +			csdev->enable = true;
>   	}
>   
> -	if (!ret)
> -		csdev->enable = true;
> -
>   	return ret;
>   }
>   
> @@ -407,7 +360,6 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   
>   	if (link_ops(csdev)->disable) {
>   		link_ops(csdev)->disable(csdev, inport, outport);
> -		coresight_control_assoc_ectdev(csdev, false);
>   	}
>   

super minor nit: You may remove the { } s.

>   	for (i = 0; i < nr_conns; i++)
> @@ -424,12 +376,8 @@ static int coresight_enable_source(struct coresight_device *csdev,
>   
>   	if (!csdev->enable) {
>   		if (source_ops(csdev)->enable) {
> -			ret = coresight_control_assoc_ectdev(csdev, true);
> -			if (ret)
> -				return ret;
>   			ret = source_ops(csdev)->enable(csdev, NULL, mode);
>   			if (ret) {
> -				coresight_control_assoc_ectdev(csdev, false);
>   				return ret;
>   			}
>   		}
> @@ -482,7 +430,6 @@ static bool coresight_disable_source(struct coresight_device *csdev)
>   	if (atomic_dec_return(csdev->refcnt) == 0) {
>   		if (source_ops(csdev)->disable)
>   			source_ops(csdev)->disable(csdev, NULL);
> -		coresight_control_assoc_ectdev(csdev, false);
>   		csdev->enable = false;
>   	}
>   	return !csdev->enable;
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 277c890a1f1f..dbce6680759f 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -555,7 +555,10 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
>   	mutex_lock(&ect_mutex);
>   
>   	/* exit if current is an ECT device.*/
> -	if ((csdev->type == CORESIGHT_DEV_TYPE_ECT) || list_empty(&ect_net))
> +	if ((csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
> +	     csdev->subtype.helper_subtype ==
> +		     CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI) ||

Should we add a helper to check this :
	is_coresight_ctidev(csdev) ?

> +	    list_empty(&ect_net))
>   		goto cti_add_done;
>   
>   	/* if we didn't find the csdev previously we used the fwnode name */
> @@ -580,6 +583,22 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
>   	mutex_unlock(&ect_mutex);
>   }
>   
> +static struct coresight_device *cti__get_cti_device(struct coresight_device *csdev)

minor nit: no perf tool naming style please ;-)

> +{
> +	int i;
> +	struct coresight_device *tmp;
> +
> +	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> +		tmp = csdev->pdata->out_conns[i].remote_dev;
> +
> +		if (tmp && tmp->type == CORESIGHT_DEV_TYPE_HELPER &&
> +		    tmp->subtype.helper_subtype ==
> +			    CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI)

As mentioned above, a helper to check this would benefit reading.

> +			return tmp;
> +	}
> +	return NULL;
> +}
> +
>   /*
>    * Removing the associated devices is easier.
>    * A CTI will not have a value for csdev->ect_dev.
> @@ -588,20 +607,21 @@ static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
>   {
>   	struct cti_drvdata *ctidrv;
>   	struct cti_trig_con *tc;
> +	struct coresight_device *cti_csdev = cti__get_cti_device(csdev);
>   	struct cti_device *ctidev;
>   
> +	if (!cti_csdev)
> +		return;
> +
>   	mutex_lock(&ect_mutex);
> -	if (csdev->ect_dev) {
> -		ctidrv = csdev_to_cti_drvdata(csdev->ect_dev);
> -		ctidev = &ctidrv->ctidev;
> -		list_for_each_entry(tc, &ctidev->trig_cons, node) {
> -			if (tc->con_dev == csdev) {
> -				cti_remove_sysfs_link(ctidrv, tc);
> -				tc->con_dev = NULL;
> -				break;
> -			}
> +	ctidrv = csdev_to_cti_drvdata(cti_csdev);
> +	ctidev = &ctidrv->ctidev;
> +	list_for_each_entry(tc, &ctidev->trig_cons, node) {
> +		if (tc->con_dev == csdev) {
> +			cti_remove_sysfs_link(ctidrv, tc);
> +			tc->con_dev = NULL;
> +			break;
>   		}
> -		csdev->ect_dev = NULL;
>   	}
>   	mutex_unlock(&ect_mutex);
>   }
> @@ -646,8 +666,6 @@ static void cti_remove_conn_xrefs(struct cti_drvdata *drvdata)
>   
>   	list_for_each_entry(tc, &ctidev->trig_cons, node) {
>   		if (tc->con_dev) {
> -			coresight_set_assoc_ectdev_mutex(tc->con_dev,
> -							 NULL);
>   			cti_remove_sysfs_link(drvdata, tc);
>   			tc->con_dev = NULL;
>   		}
> @@ -795,27 +813,27 @@ static void cti_pm_release(struct cti_drvdata *drvdata)
>   }
>   
>   /** cti ect operations **/
> -int cti_enable(struct coresight_device *csdev)
> +int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
>   {
>   	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
>   
>   	return cti_enable_hw(drvdata);
>   }
>   
> -int cti_disable(struct coresight_device *csdev)
> +int cti_disable(struct coresight_device *csdev, void *data)
>   {
>   	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
>   
>   	return cti_disable_hw(drvdata);
>   }
>   
> -static const struct coresight_ops_ect cti_ops_ect = {
> +static const struct coresight_ops_helper cti_ops_ect = {
>   	.enable = cti_enable,
>   	.disable = cti_disable,
>   };
>   
>   static const struct coresight_ops cti_ops = {
> -	.ect_ops = &cti_ops_ect,
> +	.helper_ops = &cti_ops_ect,
>   };
>   
>   /*
> @@ -922,8 +940,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>   
>   	/* set up coresight component description */
>   	cti_desc.pdata = pdata;
> -	cti_desc.type = CORESIGHT_DEV_TYPE_ECT;
> -	cti_desc.subtype.ect_subtype = CORESIGHT_DEV_SUBTYPE_ECT_CTI;
> +	cti_desc.type = CORESIGHT_DEV_TYPE_HELPER;
> +	cti_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI;
>   	cti_desc.ops = &cti_ops;
>   	cti_desc.groups = drvdata->ctidev.con_groups;
>   	cti_desc.dev = dev;
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index e528cff9d4e2..d25dd2737b49 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -112,11 +112,11 @@ static ssize_t enable_store(struct device *dev,
>   		ret = pm_runtime_resume_and_get(dev->parent);
>   		if (ret)
>   			return ret;
> -		ret = cti_enable(drvdata->csdev);
> +		ret = cti_enable(drvdata->csdev, CS_MODE_SYSFS, NULL);
>   		if (ret)
>   			pm_runtime_put(dev->parent);
>   	} else {
> -		ret = cti_disable(drvdata->csdev);
> +		ret = cti_disable(drvdata->csdev, NULL);
>   		if (!ret)
>   			pm_runtime_put(dev->parent);
>   	}
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index 8b106b13a244..cb9ee616d01f 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -215,8 +215,8 @@ int cti_add_connection_entry(struct device *dev, struct cti_drvdata *drvdata,
>   			     const char *assoc_dev_name);
>   struct cti_trig_con *cti_allocate_trig_con(struct device *dev, int in_sigs,
>   					   int out_sigs);
> -int cti_enable(struct coresight_device *csdev);
> -int cti_disable(struct coresight_device *csdev);
> +int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data);
> +int cti_disable(struct coresight_device *csdev, void *data);
>   void cti_write_all_hw_regs(struct cti_drvdata *drvdata);
>   void cti_write_intack(struct device *dev, u32 ackval);
>   void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index c6ee1634d813..cf7a8658ee88 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -40,8 +40,7 @@ enum coresight_dev_type {
>   	CORESIGHT_DEV_TYPE_LINK,
>   	CORESIGHT_DEV_TYPE_LINKSINK,
>   	CORESIGHT_DEV_TYPE_SOURCE,
> -	CORESIGHT_DEV_TYPE_HELPER,
> -	CORESIGHT_DEV_TYPE_ECT,
> +	CORESIGHT_DEV_TYPE_HELPER
>   };
>   
>   enum coresight_dev_subtype_sink {
> @@ -66,12 +65,7 @@ enum coresight_dev_subtype_source {
>   
>   enum coresight_dev_subtype_helper {
>   	CORESIGHT_DEV_SUBTYPE_HELPER_CATU,
> -};
> -
> -/* Embedded Cross Trigger (ECT) sub-types */
> -enum coresight_dev_subtype_ect {
> -	CORESIGHT_DEV_SUBTYPE_ECT_NONE,
> -	CORESIGHT_DEV_SUBTYPE_ECT_CTI,
> +	CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI
>   };
>   
>   /**
> @@ -84,8 +78,6 @@ enum coresight_dev_subtype_ect {
>    *			by @coresight_dev_subtype_source.
>    * @helper_subtype:	type of helper this component is, as defined
>    *			by @coresight_dev_subtype_helper.
> - * @ect_subtype:        type of cross trigger this component is, as
> - *			defined by @coresight_dev_subtype_ect
>    */
>   union coresight_dev_subtype {
>   	/* We have some devices which acts as LINK and SINK */
> @@ -95,7 +87,6 @@ union coresight_dev_subtype {
>   	};
>   	enum coresight_dev_subtype_source source_subtype;
>   	enum coresight_dev_subtype_helper helper_subtype;
> -	enum coresight_dev_subtype_ect ect_subtype;
>   };
>   
>   /**
> @@ -264,12 +255,9 @@ struct coresight_device {
>   	bool activated;	/* true only if a sink is part of a path */
>   	struct dev_ext_attribute *ea;
>   	struct coresight_device *def_sink;
> -	/* cross trigger handling */
> -	struct coresight_device *ect_dev;
>   	/* sysfs links between components */
>   	int nr_links;
>   	bool has_conns_grp;
> -	bool ect_enabled; /* true only if associated ect device is enabled */

nit: Update comments above the struct too ?


Thanks
Suzuki

>   	/* system configuration and feature lists */
>   	struct list_head feature_csdev_list;
>   	struct list_head config_csdev_list;
> @@ -377,23 +365,11 @@ struct coresight_ops_helper {
>   	int (*disable)(struct coresight_device *csdev, void *data);
>   };
>   
> -/**
> - * struct coresight_ops_ect - Ops for an embedded cross trigger device
> - *
> - * @enable	: Enable the device
> - * @disable	: Disable the device
> - */
> -struct coresight_ops_ect {
> -	int (*enable)(struct coresight_device *csdev);
> -	int (*disable)(struct coresight_device *csdev);
> -};
> -
>   struct coresight_ops {
>   	const struct coresight_ops_sink *sink_ops;
>   	const struct coresight_ops_link *link_ops;
>   	const struct coresight_ops_source *source_ops;
>   	const struct coresight_ops_helper *helper_ops;
> -	const struct coresight_ops_ect *ect_ops;
>   };
>   
>   #if IS_ENABLED(CONFIG_CORESIGHT)

