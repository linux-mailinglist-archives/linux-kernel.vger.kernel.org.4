Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96535EBBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiI0Hg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiI0HgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:36:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19056BB6;
        Tue, 27 Sep 2022 00:36:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t14so13596855wrx.8;
        Tue, 27 Sep 2022 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sKmAJ34A8WrJ1xqDlpDO/oGZEw5aFDM7BTPRJDupDv4=;
        b=drIvcpwx2WFkpTuxWzA8EBs6k5UJc7GPvMiTQghl4kmiz453uJATgLRQe7qC0kdJZi
         3Ls0dcWehPE9QD3e7x84wd/GNpd7MbCm5DOIfY7umj0A9kL3mzX/Bvca0UPUgxK2txrZ
         5emCH1jng6L4mOEp7zyGltQ9VnwhfQ1zu8jII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sKmAJ34A8WrJ1xqDlpDO/oGZEw5aFDM7BTPRJDupDv4=;
        b=yneWpBQFoJWrj1id2SzRvuYXE/WwnJiRV8R+7ArD4hYP09vGBlCZCQtUTrucU9wut3
         zstYIev1tlBymErfHR0i9XwSpLigoCbTUXz8mG1m3x2tt7CfaUbg1GHsQVX0zLX6OGXM
         9+BbWMtLAYnM5wdm6Lu1Dj1fUgZL8JGpRkcc7dAp7snWRsrR3Ah3ja3Tt51UIWTn69Bt
         6PWVwkh5e1phoaBXq8HtUOuTrasEwBb4Qbnzpw4xwrkExyp/u78anpUBNtAcCHZwFPTW
         7ot0JhvQwMuRR7VrcyaPtIdRkuIAGIJQ6FyaPOf6VZK1KZYnLgqJvJiKkGpezNLsZZb1
         e1rg==
X-Gm-Message-State: ACrzQf2+FeMXFonXjw0eQS5ntvcCXFmBxh+EeD6ebCNwYyapSg3tytAl
        KRuciTF7yDvgenOr7Thn57U89dpXHpdBCvumhQ8=
X-Google-Smtp-Source: AMsMyM4/JM+SnNVu6LYuec5gzT2SfX+XzA9grPlTz91or2/hfHTpXCihTm0uJTpB47xzG9i1TEHpi9UxpQkUmk5BPjQ=
X-Received: by 2002:a5d:4688:0:b0:22a:f718:7f36 with SMTP id
 u8-20020a5d4688000000b0022af7187f36mr15515102wrq.315.1664264160648; Tue, 27
 Sep 2022 00:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220809200701.218059-1-eajames@linux.ibm.com>
 <20220809200701.218059-4-eajames@linux.ibm.com> <20220925180632.GA1766526@roeck-us.net>
In-Reply-To: <20220925180632.GA1766526@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 27 Sep 2022 07:35:49 +0000
Message-ID: <CACPK8XdkH4BZH9UCd085n=bX0EU5=2BemRfOU-zGsK2W4_SNHQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hwmon: (occ) Check for device property for setting
 OCC active during probe
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eddie James <eajames@linux.ibm.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sept 2022 at 18:06, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Aug 09, 2022 at 03:07:01PM -0500, Eddie James wrote:
> > A previous commit changed the existing behavior of the driver to skip
> > attempting to communicate with the OCC during probe. Return to the
> > previous default behavior of automatically communicating with the OCC
> > and make it optional with a new device-tree property.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> Assuming this patch is applied as part of the series outside
> the hwmon subsystem.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter. I have applied it to the FSI tree.


>
> Guenter
>
> > ---
> >  drivers/hwmon/occ/common.c | 11 ++++++++++-
> >  drivers/hwmon/occ/p9_sbe.c |  9 +++++++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> > index 45407b12db4b..dd690f700d49 100644
> > --- a/drivers/hwmon/occ/common.c
> > +++ b/drivers/hwmon/occ/common.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/math64.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/property.h>
> >  #include <linux/sysfs.h>
> >  #include <asm/unaligned.h>
> >
> > @@ -1216,8 +1217,16 @@ int occ_setup(struct occ *occ)
> >       occ->groups[0] = &occ->group;
> >
> >       rc = occ_setup_sysfs(occ);
> > -     if (rc)
> > +     if (rc) {
> >               dev_err(occ->bus_dev, "failed to setup sysfs: %d\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     if (!device_property_read_bool(occ->bus_dev, "ibm,no-poll-on-init")) {
> > +             rc = occ_active(occ, true);
> > +             if (rc)
> > +                     occ_shutdown_sysfs(occ);
> > +     }
> >
> >       return rc;
> >  }
> > diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> > index 4a1fe4ee8e2c..3adcf8d0b4a6 100644
> > --- a/drivers/hwmon/occ/p9_sbe.c
> > +++ b/drivers/hwmon/occ/p9_sbe.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/fsi-occ.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/string.h>
> > @@ -179,9 +180,17 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +static const struct of_device_id p9_sbe_occ_of_match[] = {
> > +     { .compatible = "ibm,p9-occ-hwmon" },
> > +     { .compatible = "ibm,p10-occ-hwmon" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, p9_sbe_occ_of_match);
> > +
> >  static struct platform_driver p9_sbe_occ_driver = {
> >       .driver = {
> >               .name = "occ-hwmon",
> > +             .of_match_table = p9_sbe_occ_of_match,
> >       },
> >       .probe  = p9_sbe_occ_probe,
> >       .remove = p9_sbe_occ_remove,
