Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104AE6187EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKCSsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKCSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:48:31 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4AE17048;
        Thu,  3 Nov 2022 11:48:30 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id mi9so1752686qvb.8;
        Thu, 03 Nov 2022 11:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFFj0YnqgTVbsW45BjHNbWg4SjPrNwZE8AOD83zKJ74=;
        b=Ue83nvM49wxmIJpeW0OdsHD3NSvihD3GyzcevI5S7uiJNIjY+Ud+7eAp3rb+X+S0PR
         KcAdJrR6FtS+MFBh7QuRpQ4ouO1vEKlg3cLtlQNk8cGUntKbT9y7LMuJClvOeUWGOCQg
         gVVwUKpUnES7wma6SAPNy3srUgd4nrtt3K/PiMttvc8+4HPNgqfVWwA0hkj4dhni+LQl
         +83k2EoB0FHv6u7xFh6V886k5VYAZWS/SflmxWB44v3TGzi79KVetJrkTKSz4cRKlFZh
         A900vMp3zMbR7BDjgRwiNDjbUsNBr+M47xlxrKfDpTtaHhcg60K21MXJjLimqFTNSjXx
         6l1g==
X-Gm-Message-State: ACrzQf2SAkYYZsOgrtVdRcAk5Dv+cpiFrsUlgo5ih+YVfDFl9WKJcrLp
        Oirq8ExSKPB2JPAYMNadb1PLF2JrvRMB2va2Qhnfrcky
X-Google-Smtp-Source: AMsMyM5ByWBOLNaWU6upUbPGJQZXvuckz/Axld8j4XIsJqWWxPKRr6T3ZjvryDDlHqoJOyOQI58Wmx/N/Sqtel0PzrE=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr19725144qvj.3.1667501309876; Thu, 03 Nov
 2022 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <57396f1eacfacdb589127499f8ff64225a39e110.1667336095.git.christophe.jaillet@wanadoo.fr>
 <Y2JVhffdmXkkrIRN@smile.fi.intel.com>
In-Reply-To: <Y2JVhffdmXkkrIRN@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:48:19 +0100
Message-ID: <CAJZ5v0hdzYuiKECEdXFB0vmz=6Z697DRp0Xx5jwyqHH4SGrLCA@mail.gmail.com>
Subject: Re: [PATCH 09/30] ACPI: sysfs: Use kstrtobool() instead of strtobool()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 12:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 01, 2022 at 10:13:57PM +0100, Christophe JAILLET wrote:
> > strtobool() is the same as kstrtobool().
> > However, the latter is more used within the kernel.
> >
> > In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> > the other function name.
> >
> > While at it, include the corresponding header file (<linux/kstrtox.h>)
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > This patch is part of a serie that axes all usages of strtobool().
> > Each patch can be applied independently from the other ones.
> >
> > The last patch of the serie removes the definition of strtobool().
> >
> > You may not be in copy of the cover letter. So, if needed, it is available
> > at [1].
> >
> > [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> > ---
> >  drivers/acpi/sysfs.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > index cc2fe0618178..2d81c742e4d2 100644
> > --- a/drivers/acpi/sysfs.c
> > +++ b/drivers/acpi/sysfs.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/bitmap.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kstrtox.h>
> >  #include <linux/moduleparam.h>
> >
> >  #include "internal.h"
> > @@ -992,7 +993,7 @@ static ssize_t force_remove_store(struct kobject *kobj,
> >       bool val;
> >       int ret;
> >
> > -     ret = strtobool(buf, &val);
> > +     ret = kstrtobool(buf, &val);
> >       if (ret < 0)
> >               return ret;
> >
> > --

Applied as 6.2 material, thanks!
