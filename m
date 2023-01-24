Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E9679E45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjAXQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjAXQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:10:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38636470B3;
        Tue, 24 Jan 2023 08:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674576640; x=1706112640;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bfth0fiqPqzxJDQBMqI4J/DC8fqnBgrv/9/6b50yfWA=;
  b=AbrpljICSXQ9jIw81R05Cqm48dt74FGbD/3NVuw3f9Ul9OO7dPUy34aA
   i63tpV7W1gd926JoUceAyLTcY6lDT74ZbK+/XZaOgU9vWtSj+e3340odF
   5ok88I333xY05nUeGEIvjeeWIjh4HiHxJjhxjElBg2ZjYKt+p4k2lXF9Z
   /ibV7dJyROu4J8XYNMFQgiKd9/PrgQvtL6zANlAEoE9KRLRSyhZ16U5lX
   nDQfr1oKsX7awC4sr2LPcyR5SrswSKihk1zFeCNPdDL2gcTEDIxPrpkv6
   r7L+V7YX2wwbDHXjADM75oVk8KauEYY8mIv+3hGSdax2sbf+ABZMpSWcX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="353607792"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="353607792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:10:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="730734021"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="730734021"
Received: from kabbas-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.252.131.133])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:10:26 -0800
Message-ID: <1b9aa29a3c217eed97e2a732ba94bfc03f95f320.camel@linux.intel.com>
Subject: Re: [PATCH v3] thermal: int340x_thermal: Add production mode
 attribute
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Date:   Tue, 24 Jan 2023 08:10:26 -0800
In-Reply-To: <CAJZ5v0iK-ob4Mhh-Upq01gq6SPsYuAD22E-o0zwcoL1hLiP3JQ@mail.gmail.com>
References: <20230123163046.358879-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0iK-ob4Mhh-Upq01gq6SPsYuAD22E-o0zwcoL1hLiP3JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-24 at 15:22 +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 23, 2023 at 5:31 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > It is possible that the system manufacturer locks down thermal
> > tuning
> > beyond what is usually done on the given platform. In that case
> > user
> > space calibration tools should not try to adjust the thermal
> > configuration of the system.
> > 
> > To allow user space to check if that is the case, add a new sysfs
> > attribute "production_mode" that will be present when the ACPI DCFG
> > method is present under the INT3400 device object in the ACPI
> > Namespace.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > v3:
> > Build warning reported by for missing static
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > v2
> > Addressed comments from Rafael:
> > - Updated commit excatly same as Rafael wrote
> > - Removed production_mode_support bool
> > - Use sysfs_emit
> > - Update documentation
> > 
> >  .../driver-api/thermal/intel_dptf.rst         |  3 ++
> >  .../intel/int340x_thermal/int3400_thermal.c   | 48
> > +++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/thermal/intel_dptf.rst
> > b/Documentation/driver-api/thermal/intel_dptf.rst
> > index 372bdb4d04c6..f5c193cccbda 100644
> > --- a/Documentation/driver-api/thermal/intel_dptf.rst
> > +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> > @@ -84,6 +84,9 @@ DPTF ACPI Drivers interface
> >         https:/github.com/intel/thermal_daemon for decoding
> >         thermal table.
> > 
> > +``production_mode`` (RO)
> > +       When different from zero, manufacturer locked thermal
> > configuration
> > +       from further changes.
> > 
> >  ACPI Thermal Relationship table interface
> >  ------------------------------------------
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index db8a6f63657d..23ea21238bbd 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -60,6 +60,7 @@ struct int3400_thermal_priv {
> >         int odvp_count;
> >         int *odvp;
> >         u32 os_uuid_mask;
> > +       int production_mode;
> >         struct odvp_attr *odvp_attrs;
> >  };
> > 
> > @@ -315,6 +316,44 @@ static int int3400_thermal_get_uuids(struct
> > int3400_thermal_priv *priv)
> >         return result;
> >  }
> > 
> > +static ssize_t production_mode_show(struct device *dev, struct
> > device_attribute *attr,
> > +                                    char *buf)
> > +{
> > +       struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
> > +
> > +       return sysfs_emit(buf, "%d\n", priv->production_mode);
> > +}
> > +
> > +static DEVICE_ATTR_RO(production_mode);
> > +
> > +static int production_mode_init(struct int3400_thermal_priv *priv)
> > +{
> > +       unsigned long long mode;
> > +       acpi_status status;
> > +       int ret;
> > +
> > +       priv->production_mode = -1;
> > +
> > +       status = acpi_evaluate_integer(priv->adev->handle, "DCFG",
> > NULL, &mode);
> > +       /* If the method is not present, this is not an error */
> > +       if (ACPI_FAILURE(status))
> > +               return 0;
> > +
> > +       ret = sysfs_create_file(&priv->pdev->dev.kobj,
> > &dev_attr_production_mode.attr);
> > +       if (ret)
> > +               return ret;
> > +
> > +       priv->production_mode = mode;
> > +
> > +       return 0;
> > +}
> > +
> > +static void production_mode_exit(struct int3400_thermal_priv
> > *priv)
> > +{
> > +       if (priv->production_mode >= 0)
> > +               sysfs_remove_file(&priv->pdev->dev.kobj,
> > &dev_attr_production_mode.attr);
> 
> Isn't it OK to call sysfs_remove_file() if the given attribute is not
> there?
> 
I think it will be OK. But remove call will traverse 6 levels of
function taking semaphores and finally call into kernfs_find_ns(),
where it will search a hash table and fail. So much more processing
than checking one if() condition.

> If so, the above check is unnecessary and the assignment to -1 above
> too (as this is the only place where the value is tested).
If you want, I can remove and resubmit.

Thanks,
Srinivas

> 
> > +}
> > +
> >  static ssize_t odvp_show(struct device *dev, struct
> > device_attribute *attr,
> >                          char *buf)
> >  {
> > @@ -610,8 +649,15 @@ static int int3400_thermal_probe(struct
> > platform_device *pdev)
> >         if (result)
> >                 goto free_sysfs;
> > 
> > +       result = production_mode_init(priv);
> > +       if (result)
> > +               goto free_notify;
> > +
> >         return 0;
> > 
> > +free_notify:
> > +       acpi_remove_notify_handler(priv->adev->handle,
> > ACPI_DEVICE_NOTIFY,
> > +                                  int3400_notify);
> >  free_sysfs:
> >         cleanup_odvp(priv);
> >         if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> > @@ -638,6 +684,8 @@ static int int3400_thermal_remove(struct
> > platform_device *pdev)
> >  {
> >         struct int3400_thermal_priv *priv =
> > platform_get_drvdata(pdev);
> > 
> > +       production_mode_exit(priv);
> > +
> >         acpi_remove_notify_handler(
> >                         priv->adev->handle, ACPI_DEVICE_NOTIFY,
> >                         int3400_notify);
> > --

