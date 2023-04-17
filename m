Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F06E4A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDQNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDQNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:37:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86AF72BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:37:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5144043d9d1so1402150a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681738624; x=1684330624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tczK9BSA5eKG8kegU+yzG8NkABdwtaL/O9m5+9NpZ38=;
        b=hULUtRK95HmBQBXeP3p+yglqMVwaofiDWMNnPB2RcX+knYQFO335XdD6dnjxSJBHKU
         FHrKNex8UBckYEd4Wrudc+PgBhVsI9cOV8Kt26rSbQWEJDR0sRoS2WN5+5vh+KHX90m/
         3kHRdA82MYC39ClhPTKBIPro9DRnBNBTCEdaKjzJjszF+7mbuhbJj53Mh/LyNPQy5Oj8
         RX3CMjZIyWCtNhZH7qHjm6gRkCxgilnENRdMsdgITQQOh393u9+LcWEJejuiJ84wltcW
         BbBGatJKFDyNZI/9A9PJeMDIDdsNVyI+SONcxM3pQsAa90BTkZKpmrDojhnXRMLR/80e
         o5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738624; x=1684330624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tczK9BSA5eKG8kegU+yzG8NkABdwtaL/O9m5+9NpZ38=;
        b=H1+4qOiMNtgHyp90+SuVQhG6VY+0tGD5TwNOz77QwDt4JzymgvHsImoh92ELbbGSzt
         AuMVAVRQ84bmjzuUxfsb3FP7iPRWMltePR1YNsVehWfaUzi7ay2Oteo1X6MzK3MdzfuC
         DtQcEh9WffyPvDwt6fl9b07mXuX91UpauQC8eP7X5Ae3P3D/paKhr/UZHNgzXBDx+iux
         x05CsBTnYV6FwHXnrY5W288pEIlV6vmNw4wvruXhdTJqj3rBGavRgih0zweZj+cyFUmB
         p9KUXmPRx2K+/xwU3c7K3Ei3KNX1CJeux7yo4tke8bN2Vjllne3L72c7QB1SNPMEKv0a
         oQBA==
X-Gm-Message-State: AAQBX9ewVClT6fxy5yuq5Zemk2Ct59NxSdUNBAeQvhBg4fbJZ91MRn/0
        654NEtDUrgek/Plow7+jXJwNb9k+zr+kQRzJVO2WwQ==
X-Google-Smtp-Source: AKy350YZs2jnPT+6L+jiSVx8A3WRQF59Wbw6xpj3KpbERnWRpoiH/2ptMr106kW7RAen0KIQZx+sajyEDvY2AObvEUg=
X-Received: by 2002:a05:6a00:218d:b0:63b:7ab1:6c44 with SMTP id
 h13-20020a056a00218d00b0063b7ab16c44mr3999061pfi.3.1681738623952; Mon, 17 Apr
 2023 06:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230404155121.1824126-1-james.clark@arm.com> <20230404155121.1824126-14-james.clark@arm.com>
In-Reply-To: <20230404155121.1824126-14-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 17 Apr 2023 14:36:52 +0100
Message-ID: <CAJ9a7VhXhYkv-uJwE9MRaXNzmbbUgySeBAJ1Zk752cqMh9jV3Q@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] coresight: Fix CTI module refcount leak by
 making it a helper device
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Tue, 4 Apr 2023 at 16:52, James Clark <james.clark@arm.com> wrote:
>
> The CTI module has some hard coded refcounting code that has a leak.
> For example running perf and then trying to unload it fails:
>
>   perf record -e cs_etm// -a -- ls
>   rmmod coresight_cti
>
>   rmmod: ERROR: Module coresight_cti is in use
>
> The coresight core already handles references of devices in use, so by
> making CTI a normal helper device, we get working refcounting for free.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c  | 104 ++++++------------
>  .../hwtracing/coresight/coresight-cti-core.c  |  52 +++++----
>  .../hwtracing/coresight/coresight-cti-sysfs.c |   4 +-
>  drivers/hwtracing/coresight/coresight-cti.h   |   4 +-
>  drivers/hwtracing/coresight/coresight-priv.h  |   4 +-
>  drivers/hwtracing/coresight/coresight-sysfs.c |   4 +
>  include/linux/coresight.h                     |  30 +----
>  7 files changed, 75 insertions(+), 127 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 16689fe4ba98..2af416bba983 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -236,60 +236,44 @@ void coresight_disclaim_device(struct coresight_device *csdev)
>  }
>  EXPORT_SYMBOL_GPL(coresight_disclaim_device);
>
> -/* enable or disable an associated CTI device of the supplied CS device */
> -static int
> -coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
> +/*
> + * Add a helper as an output device. This function takes the @coresight_mutex
> + * because it's assumed that it's called from the helper device, outside of the
> + * core code where the mutex would already be held. Don't add new calls to this
> + * from inside the core code, instead try to add the new helper to the DT and
> + * ACPI where it will be picked up and linked automatically.
> + */
> +void coresight_add_helper(struct coresight_device *csdev,
> +                         struct coresight_device *helper)
>  {
> -       int ect_ret = 0;
> -       struct coresight_device *ect_csdev = csdev->ect_dev;
> -       struct module *mod;
> +       int i;
> +       struct coresight_connection conn = {};
> +       struct coresight_connection *new_conn;
>
> -       if (!ect_csdev)
> -               return 0;
> -       if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
> -               return 0;
> +       mutex_lock(&coresight_mutex);
> +       conn.dest_fwnode = fwnode_handle_get(dev_fwnode(&helper->dev));
> +       conn.dest_dev = helper;
> +       conn.dest_port = conn.src_port = -1;
> +       conn.src_dev = csdev;
>
> -       mod = ect_csdev->dev.parent->driver->owner;
> -       if (enable) {
> -               if (try_module_get(mod)) {
> -                       ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
> -                       if (ect_ret) {
> -                               module_put(mod);
> -                       } else {
> -                               get_device(ect_csdev->dev.parent);
> -                               csdev->ect_enabled = true;
> -                       }
> -               } else
> -                       ect_ret = -ENODEV;
> -       } else {
> -               if (csdev->ect_enabled) {
> -                       ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
> -                       put_device(ect_csdev->dev.parent);
> -                       module_put(mod);
> -                       csdev->ect_enabled = false;
> -               }
> -       }
> +       /*
> +        * Check for duplicates because this is called every time a helper
> +        * device is re-loaded. Existing connections will get re-linked
> +        * automatically.
> +        */
> +       for (i = 0; i < csdev->pdata->nr_outconns; ++i)
> +               if (csdev->pdata->out_conns[i]->dest_fwnode == conn.dest_fwnode)
> +                       goto unlock;
>
> -       /* output warning if ECT enable is preventing trace operation */
> -       if (ect_ret)
> -               dev_info(&csdev->dev, "Associated ECT device (%s) %s failed\n",
> -                        dev_name(&ect_csdev->dev),
> -                        enable ? "enable" : "disable");
> -       return ect_ret;
> -}
> +       new_conn =
> +               coresight_add_out_conn(csdev->dev.parent, csdev->pdata, &conn);
> +       if (!IS_ERR(new_conn))
> +               coresight_add_in_conn(new_conn);
>
> -/*
> - * Set the associated ect / cti device while holding the coresight_mutex
> - * to avoid a race with coresight_enable that may try to use this value.
> - */
> -void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
> -                                     struct coresight_device *ect_csdev)
> -{
> -       mutex_lock(&coresight_mutex);
> -       csdev->ect_dev = ect_csdev;
> +unlock:
>         mutex_unlock(&coresight_mutex);
>  }
> -EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
> +EXPORT_SYMBOL_GPL(coresight_add_helper);
>
>  static int coresight_enable_sink(struct coresight_device *csdev,
>                                  enum cs_mode mode, void *data)
> @@ -303,12 +287,8 @@ static int coresight_enable_sink(struct coresight_device *csdev,
>         if (!sink_ops(csdev)->enable)
>                 return -EINVAL;
>
> -       ret = coresight_control_assoc_ectdev(csdev, true);
> -       if (ret)
> -               return ret;
>         ret = sink_ops(csdev)->enable(csdev, mode, data);
>         if (ret) {
> -               coresight_control_assoc_ectdev(csdev, false);
>                 return ret;
>         }

minor nit: should drop {} here

>         csdev->enable = true;
> @@ -326,7 +306,6 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>         ret = sink_ops(csdev)->disable(csdev);
>         if (ret)
>                 return;
> -       coresight_control_assoc_ectdev(csdev, false);
>         csdev->enable = false;
>  }
>
> @@ -351,17 +330,11 @@ static int coresight_enable_link(struct coresight_device *csdev,
>                 return PTR_ERR(outconn);
>
>         if (link_ops(csdev)->enable) {
> -               ret = coresight_control_assoc_ectdev(csdev, true);
> -               if (!ret) {
> -                       ret = link_ops(csdev)->enable(csdev, inconn, outconn);
> -                       if (ret)
> -                               coresight_control_assoc_ectdev(csdev, false);
> -               }
> +               ret = link_ops(csdev)->enable(csdev, inconn, outconn);
> +               if (!ret)
> +                       csdev->enable = true;
>         }
>
> -       if (!ret)
> -               csdev->enable = true;
> -
>         return ret;
>  }
>
> @@ -382,7 +355,6 @@ static void coresight_disable_link(struct coresight_device *csdev,
>
>         if (link_ops(csdev)->disable) {
>                 link_ops(csdev)->disable(csdev, inconn, outconn);
> -               coresight_control_assoc_ectdev(csdev, false);
>         }
>
>         if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
> @@ -410,14 +382,9 @@ int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
>
>         if (!csdev->enable) {
>                 if (source_ops(csdev)->enable) {
> -                       ret = coresight_control_assoc_ectdev(csdev, true);
> -                       if (ret)
> -                               return ret;
>                         ret = source_ops(csdev)->enable(csdev, data, mode);
> -                       if (ret) {
> -                               coresight_control_assoc_ectdev(csdev, false);
> +                       if (ret)
>                                 return ret;
> -                       }
>                 }
>                 csdev->enable = true;
>         }
> @@ -488,7 +455,6 @@ bool coresight_disable_source(struct coresight_device *csdev, void *data)
>         if (atomic_dec_return(&csdev->refcnt) == 0) {
>                 if (source_ops(csdev)->disable)
>                         source_ops(csdev)->disable(csdev, data);
> -               coresight_control_assoc_ectdev(csdev, false);
>                 coresight_disable_helpers(csdev);
>                 csdev->enable = false;
>         }
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 277c890a1f1f..7023ff70cc28 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -555,7 +555,10 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
>         mutex_lock(&ect_mutex);
>
>         /* exit if current is an ECT device.*/
> -       if ((csdev->type == CORESIGHT_DEV_TYPE_ECT) || list_empty(&ect_net))
> +       if ((csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
> +            csdev->subtype.helper_subtype ==
> +                    CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI) ||
> +           list_empty(&ect_net))
>                 goto cti_add_done;
>
>         /* if we didn't find the csdev previously we used the fwnode name */
> @@ -571,8 +574,7 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
>                          * if we found a matching csdev then update the ECT
>                          * association pointer for the device with this CTI.
>                          */
> -                       coresight_set_assoc_ectdev_mutex(csdev,
> -                                                        ect_item->csdev);
> +                       coresight_add_helper(csdev, ect_item->csdev);
>                         break;
>                 }
>         }
> @@ -582,26 +584,30 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
>
>  /*
>   * Removing the associated devices is easier.
> - * A CTI will not have a value for csdev->ect_dev.
>   */
>  static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
>  {
>         struct cti_drvdata *ctidrv;
>         struct cti_trig_con *tc;
>         struct cti_device *ctidev;
> +       union coresight_dev_subtype cti_subtype = {
> +               .helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI
> +       };
> +       struct coresight_device *cti_csdev = coresight_find_output_type(
> +               csdev->pdata, CORESIGHT_DEV_TYPE_HELPER, cti_subtype);
> +
> +       if (!cti_csdev)
> +               return;
>
>         mutex_lock(&ect_mutex);
> -       if (csdev->ect_dev) {
> -               ctidrv = csdev_to_cti_drvdata(csdev->ect_dev);
> -               ctidev = &ctidrv->ctidev;
> -               list_for_each_entry(tc, &ctidev->trig_cons, node) {
> -                       if (tc->con_dev == csdev) {
> -                               cti_remove_sysfs_link(ctidrv, tc);
> -                               tc->con_dev = NULL;
> -                               break;
> -                       }
> +       ctidrv = csdev_to_cti_drvdata(cti_csdev);
> +       ctidev = &ctidrv->ctidev;
> +       list_for_each_entry(tc, &ctidev->trig_cons, node) {
> +               if (tc->con_dev == csdev) {
> +                       cti_remove_sysfs_link(ctidrv, tc);
> +                       tc->con_dev = NULL;
> +                       break;
>                 }
> -               csdev->ect_dev = NULL;
>         }
>         mutex_unlock(&ect_mutex);
>  }
> @@ -630,8 +636,8 @@ static void cti_update_conn_xrefs(struct cti_drvdata *drvdata)
>                         /* if we can set the sysfs link */
>                         if (cti_add_sysfs_link(drvdata, tc))
>                                 /* set the CTI/csdev association */
> -                               coresight_set_assoc_ectdev_mutex(tc->con_dev,
> -                                                        drvdata->csdev);
> +                               coresight_add_helper(tc->con_dev,
> +                                                    drvdata->csdev);
>                         else
>                                 /* otherwise remove reference from CTI */
>                                 tc->con_dev = NULL;
> @@ -646,8 +652,6 @@ static void cti_remove_conn_xrefs(struct cti_drvdata *drvdata)
>
>         list_for_each_entry(tc, &ctidev->trig_cons, node) {
>                 if (tc->con_dev) {
> -                       coresight_set_assoc_ectdev_mutex(tc->con_dev,
> -                                                        NULL);
>                         cti_remove_sysfs_link(drvdata, tc);
>                         tc->con_dev = NULL;
>                 }
> @@ -795,27 +799,27 @@ static void cti_pm_release(struct cti_drvdata *drvdata)
>  }
>
>  /** cti ect operations **/
> -int cti_enable(struct coresight_device *csdev)
> +int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
>  {
>         struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
>
>         return cti_enable_hw(drvdata);
>  }
>
> -int cti_disable(struct coresight_device *csdev)
> +int cti_disable(struct coresight_device *csdev, void *data)
>  {
>         struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
>
>         return cti_disable_hw(drvdata);
>  }
>
> -static const struct coresight_ops_ect cti_ops_ect = {
> +static const struct coresight_ops_helper cti_ops_ect = {
>         .enable = cti_enable,
>         .disable = cti_disable,
>  };
>
>  static const struct coresight_ops cti_ops = {
> -       .ect_ops = &cti_ops_ect,
> +       .helper_ops = &cti_ops_ect,
>  };
>
>  /*
> @@ -922,8 +926,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>
>         /* set up coresight component description */
>         cti_desc.pdata = pdata;
> -       cti_desc.type = CORESIGHT_DEV_TYPE_ECT;
> -       cti_desc.subtype.ect_subtype = CORESIGHT_DEV_SUBTYPE_ECT_CTI;
> +       cti_desc.type = CORESIGHT_DEV_TYPE_HELPER;
> +       cti_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI;
>         cti_desc.ops = &cti_ops;
>         cti_desc.groups = drvdata->ctidev.con_groups;
>         cti_desc.dev = dev;
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index e528cff9d4e2..d25dd2737b49 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -112,11 +112,11 @@ static ssize_t enable_store(struct device *dev,
>                 ret = pm_runtime_resume_and_get(dev->parent);
>                 if (ret)
>                         return ret;
> -               ret = cti_enable(drvdata->csdev);
> +               ret = cti_enable(drvdata->csdev, CS_MODE_SYSFS, NULL);
>                 if (ret)
>                         pm_runtime_put(dev->parent);
>         } else {
> -               ret = cti_disable(drvdata->csdev);
> +               ret = cti_disable(drvdata->csdev, NULL);
>                 if (!ret)
>                         pm_runtime_put(dev->parent);
>         }
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index 8b106b13a244..cb9ee616d01f 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -215,8 +215,8 @@ int cti_add_connection_entry(struct device *dev, struct cti_drvdata *drvdata,
>                              const char *assoc_dev_name);
>  struct cti_trig_con *cti_allocate_trig_con(struct device *dev, int in_sigs,
>                                            int out_sigs);
> -int cti_enable(struct coresight_device *csdev);
> -int cti_disable(struct coresight_device *csdev);
> +int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data);
> +int cti_disable(struct coresight_device *csdev, void *data);
>  void cti_write_all_hw_regs(struct cti_drvdata *drvdata);
>  void cti_write_intack(struct device *dev, u32 ackval);
>  void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value);
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 5575014f73e0..1801ff4e467b 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -211,8 +211,8 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>                                      struct coresight_platform_data *pdata);
>  struct coresight_device *
>  coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode);
> -void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
> -                                     struct coresight_device *ect_csdev);
> +void coresight_add_helper(struct coresight_device *csdev,
> +                         struct coresight_device *helper);
>
>  void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
>  struct coresight_device *coresight_get_percpu_sink(int cpu);
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index 464ba5e1343b..dd78e9fcfc4d 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -148,6 +148,10 @@ int coresight_make_links(struct coresight_device *orig,
>         char *outs = NULL, *ins = NULL;
>         struct coresight_sysfs_link *link = NULL;
>
> +       /* Helper devices aren't shown in sysfs */
> +       if (conn->dest_port == -1 && conn->src_port == -1)
> +               return 0;
> +
>         do {
>                 outs = devm_kasprintf(&orig->dev, GFP_KERNEL,
>                                       "out:%d", conn->src_port);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 61dfbab5fa98..225a5fa71baf 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -40,8 +40,7 @@ enum coresight_dev_type {
>         CORESIGHT_DEV_TYPE_LINK,
>         CORESIGHT_DEV_TYPE_LINKSINK,
>         CORESIGHT_DEV_TYPE_SOURCE,
> -       CORESIGHT_DEV_TYPE_HELPER,
> -       CORESIGHT_DEV_TYPE_ECT,
> +       CORESIGHT_DEV_TYPE_HELPER
>  };
>
>  enum coresight_dev_subtype_sink {
> @@ -66,12 +65,7 @@ enum coresight_dev_subtype_source {
>
>  enum coresight_dev_subtype_helper {
>         CORESIGHT_DEV_SUBTYPE_HELPER_CATU,
> -};
> -
> -/* Embedded Cross Trigger (ECT) sub-types */
> -enum coresight_dev_subtype_ect {
> -       CORESIGHT_DEV_SUBTYPE_ECT_NONE,
> -       CORESIGHT_DEV_SUBTYPE_ECT_CTI,
> +       CORESIGHT_DEV_SUBTYPE_HELPER_ECT_CTI
>  };
>
>  /**
> @@ -84,8 +78,6 @@ enum coresight_dev_subtype_ect {
>   *                     by @coresight_dev_subtype_source.
>   * @helper_subtype:    type of helper this component is, as defined
>   *                     by @coresight_dev_subtype_helper.
> - * @ect_subtype:        type of cross trigger this component is, as
> - *                     defined by @coresight_dev_subtype_ect
>   */
>  union coresight_dev_subtype {
>         /* We have some devices which acts as LINK and SINK */
> @@ -95,7 +87,6 @@ union coresight_dev_subtype {
>         };
>         enum coresight_dev_subtype_source source_subtype;
>         enum coresight_dev_subtype_helper helper_subtype;
> -       enum coresight_dev_subtype_ect ect_subtype;
>  };
>
>  /**
> @@ -239,8 +230,6 @@ struct coresight_sysfs_link {
>   *             from source to that sink.
>   * @ea:                Device attribute for sink representation under PMU directory.
>   * @def_sink:  cached reference to default sink found for this device.
> - * @ect_dev:   Associated cross trigger device. Not part of the trace data
> - *             path or connections.
>   * @nr_links:   number of sysfs links created to other components from this
>   *             device. These will appear in the "connections" group.
>   * @has_conns_grp: Have added a "connections" group for sysfs links.
> @@ -263,12 +252,9 @@ struct coresight_device {
>         bool activated; /* true only if a sink is part of a path */
>         struct dev_ext_attribute *ea;
>         struct coresight_device *def_sink;
> -       /* cross trigger handling */
> -       struct coresight_device *ect_dev;
>         /* sysfs links between components */
>         int nr_links;
>         bool has_conns_grp;
> -       bool ect_enabled; /* true only if associated ect device is enabled */
>         /* system configuration and feature lists */
>         struct list_head feature_csdev_list;
>         struct list_head config_csdev_list;
> @@ -380,23 +366,11 @@ struct coresight_ops_helper {
>         int (*disable)(struct coresight_device *csdev, void *data);
>  };
>
> -/**
> - * struct coresight_ops_ect - Ops for an embedded cross trigger device
> - *
> - * @enable     : Enable the device
> - * @disable    : Disable the device
> - */
> -struct coresight_ops_ect {
> -       int (*enable)(struct coresight_device *csdev);
> -       int (*disable)(struct coresight_device *csdev);
> -};
> -
>  struct coresight_ops {
>         const struct coresight_ops_sink *sink_ops;
>         const struct coresight_ops_link *link_ops;
>         const struct coresight_ops_source *source_ops;
>         const struct coresight_ops_helper *helper_ops;
> -       const struct coresight_ops_ect *ect_ops;
>  };
>
>  #if IS_ENABLED(CONFIG_CORESIGHT)
> --
> 2.34.1
>

Reviewed-by: Mike Leach  <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
