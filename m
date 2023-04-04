Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C176D5BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjDDJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjDDJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:21:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946B819BD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:21:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91CE0D75;
        Tue,  4 Apr 2023 02:22:15 -0700 (PDT)
Received: from [10.57.58.41] (unknown [10.57.58.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F87D3F6C4;
        Tue,  4 Apr 2023 02:21:29 -0700 (PDT)
Message-ID: <77d890a9-9927-da8e-1460-54513784683d@arm.com>
Date:   Tue, 4 Apr 2023 10:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 13/13] coresight: Fix CTI module refcount leak by
 making it a helper device
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        quic_jinlmao@quicinc.com, mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230329115329.2747724-1-james.clark@arm.com>
 <20230329115329.2747724-14-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230329115329.2747724-14-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 12:53, James Clark wrote:
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
>   drivers/hwtracing/coresight/coresight-core.c  | 99 ++++++-------------
>   .../hwtracing/coresight/coresight-cti-core.c  | 52 +++++-----
>   .../hwtracing/coresight/coresight-cti-sysfs.c |  4 +-
>   drivers/hwtracing/coresight/coresight-cti.h   |  4 +-
>   drivers/hwtracing/coresight/coresight-priv.h  |  4 +-
>   drivers/hwtracing/coresight/coresight-sysfs.c |  4 +
>   include/linux/coresight.h                     | 30 +-----
>   7 files changed, 70 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 65f5bd8516d8..458d91b4e23f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -254,60 +254,39 @@ void coresight_disclaim_device(struct coresight_device *csdev)
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
> - * Set the associated ect / cti device while holding the coresight_mutex
> + * Add a helper as an output device while holding the coresight_mutex
>    * to avoid a race with coresight_enable that may try to use this value.
>    */
> -void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
> -				      struct coresight_device *ect_csdev)
> +void coresight_add_helper_mutex(struct coresight_device *csdev,
> +				struct coresight_device *helper)

minor nit: It may be a good idea to rename this, in line with the
kernel naming convention :

	coresight_add_helper_unlocked()

Or if this is the only variant, it is OK to leave it as :
	coresight_add_helper()
with a big fat comment in the function description to indicate
that it takes the mutex and may be even add a :

might_sleep() and lockdep_assert_not_held(&coresight_mutex);

in the function.

>   {
> +	int i;
> +	struct coresight_connection conn = {};
> +
>   	mutex_lock(&coresight_mutex);
> -	csdev->ect_dev = ect_csdev;
> +	conn.dest_fwnode = fwnode_handle_get(dev_fwnode(&helper->dev));
> +	conn.dest_dev = helper;
> +	conn.dest_port = conn.src_port = -1;
> +	conn.src_dev = csdev;
> +
> +	/*
> +	 * Check for duplicates because this is called every time a helper
> +	 * device is re-loaded. Existing connections will get re-linked
> +	 * automatically.
> +	 */

Thanks for adding this comment here. It does look like the already added
output connection to the "origin" device would automatically resolve the
connection and add in the "in-connection" to the CTI device.

> +	for (i = 0; i < csdev->pdata->nr_outconns; ++i)
> +		if (csdev->pdata->out_conns[i]->dest_fwnode == conn.dest_fwnode)
> +			goto unlock;
> +
> +	coresight_add_out_conn(csdev->dev.parent, csdev->pdata, &conn);

This makes me wonder if we should return the new connection in 
coresight_add_out_conn() in case of success, rather than assuming the 
last one (which is always the case though.).

i.e.,
	new_conn = coresight_add_out_conn(...)
	if (new_conn)
		coresight_add_in_conn(new_conn);

> +	coresight_add_in_conn(
> +		csdev->pdata->out_conns[csdev->pdata->nr_outconns - 1]);
> +
> +unlock:
>   	mutex_unlock(&coresight_mutex);
>   }
> -EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
> +EXPORT_SYMBOL_GPL(coresight_add_helper_mutex);
>   
>   static int coresight_enable_sink(struct coresight_device *csdev,
>   				 enum cs_mode mode, void *data)
> @@ -321,12 +300,8 @@ static int coresight_enable_sink(struct coresight_device *csdev,
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
>   	csdev->enable = true;
> @@ -344,7 +319,6 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>   	ret = sink_ops(csdev)->disable(csdev);
>   	if (ret)
>   		return;
> -	coresight_control_assoc_ectdev(csdev, false);
>   	csdev->enable = false;
>   }
>   
> @@ -369,17 +343,11 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   		return PTR_ERR(outconn);
>   
>   	if (link_ops(csdev)->enable) {
> -		ret = coresight_control_assoc_ectdev(csdev, true);
> -		if (!ret) {
> -			ret = link_ops(csdev)->enable(csdev, inconn, outconn);
> -			if (ret)
> -				coresight_control_assoc_ectdev(csdev, false);
> -		}
> +		ret = link_ops(csdev)->enable(csdev, inconn, outconn);
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
> @@ -400,7 +368,6 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   
>   	if (link_ops(csdev)->disable) {
>   		link_ops(csdev)->disable(csdev, inconn, outconn);
> -		coresight_control_assoc_ectdev(csdev, false);
>   	}
>   
>   	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
> @@ -428,14 +395,9 @@ int coresight_enable_source(struct coresight_device *csdev, void *data,
>   
>   	if (!csdev->enable) {
>   		if (source_ops(csdev)->enable) {
> -			ret = coresight_control_assoc_ectdev(csdev, true);
> -			if (ret)
> -				return ret;
>   			ret = source_ops(csdev)->enable(csdev, data, mode);
> -			if (ret) {
> -				coresight_control_assoc_ectdev(csdev, false);
> +			if (ret)
>   				return ret;
> -			}
>   		}
>   		csdev->enable = true;
>   	}
> @@ -499,7 +461,6 @@ bool coresight_disable_source(struct coresight_device *csdev, void *data)
>   	if (atomic_dec_return(&csdev->refcnt) == 0) {
>   		if (source_ops(csdev)->disable)
>   			source_ops(csdev)->disable(csdev, data);
> -		coresight_control_assoc_ectdev(csdev, false);
>   		coresight_disable_helpers(csdev);
>   		csdev->enable = false;
>   	}
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 277c890a1f1f..db7a2212ec18 100644
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
> +	    list_empty(&ect_net))
>   		goto cti_add_done;
>   
>   	/* if we didn't find the csdev previously we used the fwnode name */
> @@ -571,8 +574,7 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
>   			 * if we found a matching csdev then update the ECT
>   			 * association pointer for the device with this CTI.
>   			 */
> -			coresight_set_assoc_ectdev_mutex(csdev,
> -							 ect_item->csdev);
> +			coresight_add_helper_mutex(csdev, ect_item->csdev);
>   			break;
>   		}
>   	}
> @@ -582,26 +584,30 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
>   
>   /*
>    * Removing the associated devices is easier.
> - * A CTI will not have a value for csdev->ect_dev.
>    */
>   static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
>   {
>   	struct cti_drvdata *ctidrv;
>   	struct cti_trig_con *tc;
> +	union coresight_dev_subtype cti_subtype = {
> +		.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI
> +	};
> +	struct coresight_device *cti_csdev = coresight_find_output_type(
> +		csdev->pdata, CORESIGHT_DEV_TYPE_HELPER, cti_subtype);

minor nit: Please could we split the initialisation ? Or at least move
this after the next variable declaration below ?


Rest looks fine to me.

Suzuki

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
> @@ -630,8 +636,8 @@ static void cti_update_conn_xrefs(struct cti_drvdata *drvdata)
>   			/* if we can set the sysfs link */
>   			if (cti_add_sysfs_link(drvdata, tc))
>   				/* set the CTI/csdev association */
> -				coresight_set_assoc_ectdev_mutex(tc->con_dev,
> -							 drvdata->csdev);
> +				coresight_add_helper_mutex(tc->con_dev,
> +							   drvdata->csdev);
>   			else
>   				/* otherwise remove reference from CTI */
>   				tc->con_dev = NULL;
> @@ -646,8 +652,6 @@ static void cti_remove_conn_xrefs(struct cti_drvdata *drvdata)
>   
>   	list_for_each_entry(tc, &ctidev->trig_cons, node) {
>   		if (tc->con_dev) {
> -			coresight_set_assoc_ectdev_mutex(tc->con_dev,
> -							 NULL);
>   			cti_remove_sysfs_link(drvdata, tc);
>   			tc->con_dev = NULL;
>   		}
> @@ -795,27 +799,27 @@ static void cti_pm_release(struct cti_drvdata *drvdata)
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
> @@ -922,8 +926,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
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
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index a843f9d5c737..fff565d1cb42 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -211,8 +211,8 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>   				     struct coresight_platform_data *pdata);
>   struct coresight_device *
>   coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode);
> -void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
> -				      struct coresight_device *ect_csdev);
> +void coresight_add_helper_mutex(struct coresight_device *csdev,
> +				struct coresight_device *helper);
>   
>   void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
>   struct coresight_device *coresight_get_percpu_sink(int cpu);
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index 464ba5e1343b..dd78e9fcfc4d 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -148,6 +148,10 @@ int coresight_make_links(struct coresight_device *orig,
>   	char *outs = NULL, *ins = NULL;
>   	struct coresight_sysfs_link *link = NULL;
>   
> +	/* Helper devices aren't shown in sysfs */
> +	if (conn->dest_port == -1 && conn->src_port == -1)
> +		return 0;
> +
>   	do {
>   		outs = devm_kasprintf(&orig->dev, GFP_KERNEL,
>   				      "out:%d", conn->src_port);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d2739a0286f1..ed37552761e4 100644
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
> @@ -237,8 +228,6 @@ struct coresight_sysfs_link {
>    *		from source to that sink.
>    * @ea:		Device attribute for sink representation under PMU directory.
>    * @def_sink:	cached reference to default sink found for this device.
> - * @ect_dev:	Associated cross trigger device. Not part of the trace data
> - *		path or connections.
>    * @nr_links:   number of sysfs links created to other components from this
>    *		device. These will appear in the "connections" group.
>    * @has_conns_grp: Have added a "connections" group for sysfs links.
> @@ -261,12 +250,9 @@ struct coresight_device {
>   	bool activated;	/* true only if a sink is part of a path */
>   	struct dev_ext_attribute *ea;
>   	struct coresight_device *def_sink;
> -	/* cross trigger handling */
> -	struct coresight_device *ect_dev;
>   	/* sysfs links between components */
>   	int nr_links;
>   	bool has_conns_grp;
> -	bool ect_enabled; /* true only if associated ect device is enabled */
>   	/* system configuration and feature lists */
>   	struct list_head feature_csdev_list;
>   	struct list_head config_csdev_list;
> @@ -378,23 +364,11 @@ struct coresight_ops_helper {
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

