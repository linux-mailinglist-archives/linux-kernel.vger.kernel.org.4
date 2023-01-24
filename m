Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E371679E70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjAXQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:20:36 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1547404;
        Tue, 24 Jan 2023 08:20:35 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id w14so18858657edi.5;
        Tue, 24 Jan 2023 08:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qR2/SrVOyPCZRBp77YSOfx4FTQmgO7BrpPQfzKkXVk8=;
        b=oTy9PusXkGyTmGqQO5wZA7wdbwL6W7PLO3e+qmoDLi2Sv+mBrpKJ/XpY6S1jrf4T06
         DCjuIs5EgHF1X33M37dA2VdZFEKc+UsXp8R9W4g4EMCIceVvKYmJpxyWMHTdaKhvnjNK
         n1pZ5tJGMrPt5txPja6QUcA0E3/Zve1Pzq27PQfnoC8WbMS5eXrBZSUNC5KXG9nPqZy0
         1L3KreglKt+CVuW/Z23y4TH/5uHMqa+v2IQHKLKG+YFfPjoTLpIPSWkfYMEF+1Tkhh/2
         S193WFuZXRBc1RIgKDhJTKvAhH5qh+fR4ijmtvJuwCc6r1/PVUiC18Ojx0h7GAe3OjlM
         nBmA==
X-Gm-Message-State: AO0yUKXmfCkHJ74sT6ISe/uAwfTy4weNBvZ1Ksl5Sbu6HQwdfwMOAb0a
        Khrg2IErolr4tUvgMl2uvlOpHwCDmSKa4AFOYaY=
X-Google-Smtp-Source: AK7set+1t39h7zTSL3t9u5Mhq8duVC3yPbdKYfdy5tmfsgEqS+8WU1zOpk4r3Gp+9O1sshOt6pZUUq07SVUOHlQzkxc=
X-Received: by 2002:a05:6402:5299:b0:49f:43af:1160 with SMTP id
 en25-20020a056402529900b0049f43af1160mr655736edb.161.1674577233975; Tue, 24
 Jan 2023 08:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20230123163046.358879-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0iK-ob4Mhh-Upq01gq6SPsYuAD22E-o0zwcoL1hLiP3JQ@mail.gmail.com> <1b9aa29a3c217eed97e2a732ba94bfc03f95f320.camel@linux.intel.com>
In-Reply-To: <1b9aa29a3c217eed97e2a732ba94bfc03f95f320.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 17:20:22 +0100
Message-ID: <CAJZ5v0hGPYfJ_H-+PWTaSPc3DjNDt4O5AWsGJUxjtU3jgDtktw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: int340x_thermal: Add production mode attribute
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 5:10 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-01-24 at 15:22 +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 23, 2023 at 5:31 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > It is possible that the system manufacturer locks down thermal
> > > tuning
> > > beyond what is usually done on the given platform. In that case
> > > user
> > > space calibration tools should not try to adjust the thermal
> > > configuration of the system.
> > >
> > > To allow user space to check if that is the case, add a new sysfs
> > > attribute "production_mode" that will be present when the ACPI DCFG
> > > method is present under the INT3400 device object in the ACPI
> > > Namespace.
> > >
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > ---
> > > v3:
> > > Build warning reported by for missing static
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > v2
> > > Addressed comments from Rafael:
> > > - Updated commit excatly same as Rafael wrote
> > > - Removed production_mode_support bool
> > > - Use sysfs_emit
> > > - Update documentation
> > >
> > >  .../driver-api/thermal/intel_dptf.rst         |  3 ++
> > >  .../intel/int340x_thermal/int3400_thermal.c   | 48
> > > +++++++++++++++++++
> > >  2 files changed, 51 insertions(+)
> > >
> > > diff --git a/Documentation/driver-api/thermal/intel_dptf.rst
> > > b/Documentation/driver-api/thermal/intel_dptf.rst
> > > index 372bdb4d04c6..f5c193cccbda 100644
> > > --- a/Documentation/driver-api/thermal/intel_dptf.rst
> > > +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> > > @@ -84,6 +84,9 @@ DPTF ACPI Drivers interface
> > >         https:/github.com/intel/thermal_daemon for decoding
> > >         thermal table.
> > >
> > > +``production_mode`` (RO)
> > > +       When different from zero, manufacturer locked thermal
> > > configuration
> > > +       from further changes.
> > >
> > >  ACPI Thermal Relationship table interface
> > >  ------------------------------------------
> > > diff --git
> > > a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > index db8a6f63657d..23ea21238bbd 100644
> > > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > @@ -60,6 +60,7 @@ struct int3400_thermal_priv {
> > >         int odvp_count;
> > >         int *odvp;
> > >         u32 os_uuid_mask;
> > > +       int production_mode;
> > >         struct odvp_attr *odvp_attrs;
> > >  };
> > >
> > > @@ -315,6 +316,44 @@ static int int3400_thermal_get_uuids(struct
> > > int3400_thermal_priv *priv)
> > >         return result;
> > >  }
> > >
> > > +static ssize_t production_mode_show(struct device *dev, struct
> > > device_attribute *attr,
> > > +                                    char *buf)
> > > +{
> > > +       struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
> > > +
> > > +       return sysfs_emit(buf, "%d\n", priv->production_mode);
> > > +}
> > > +
> > > +static DEVICE_ATTR_RO(production_mode);
> > > +
> > > +static int production_mode_init(struct int3400_thermal_priv *priv)
> > > +{
> > > +       unsigned long long mode;
> > > +       acpi_status status;
> > > +       int ret;
> > > +
> > > +       priv->production_mode = -1;
> > > +
> > > +       status = acpi_evaluate_integer(priv->adev->handle, "DCFG",
> > > NULL, &mode);
> > > +       /* If the method is not present, this is not an error */
> > > +       if (ACPI_FAILURE(status))
> > > +               return 0;
> > > +
> > > +       ret = sysfs_create_file(&priv->pdev->dev.kobj,
> > > &dev_attr_production_mode.attr);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       priv->production_mode = mode;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void production_mode_exit(struct int3400_thermal_priv
> > > *priv)
> > > +{
> > > +       if (priv->production_mode >= 0)
> > > +               sysfs_remove_file(&priv->pdev->dev.kobj,
> > > &dev_attr_production_mode.attr);
> >
> > Isn't it OK to call sysfs_remove_file() if the given attribute is not
> > there?
> >
> I think it will be OK. But remove call will traverse 6 levels of
> function taking semaphores and finally call into kernfs_find_ns(),
> where it will search a hash table and fail. So much more processing
> than checking one if() condition.

Fair enough.
