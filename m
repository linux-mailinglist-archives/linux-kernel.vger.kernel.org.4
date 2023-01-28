Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4907D67F5A4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjA1HfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjA1HfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:35:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47688F03
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:34:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso10083925pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LfU4NdFCY9mc96XzAftKL5sqMzYNYpuz0VuvSMcGko=;
        b=aOMpWODzMbhFL3U0nhkxf3JtSAEDLPoYqjDVsAiPDjmpzGOhoHNHzmJATT2eXZbmFT
         QhaNHRZiE0UXHnzwCAuJgyJHBBZB4sJRLsdKHLlCiTOTYwTx4S3CA3s+YiYTpTCbFHy/
         Hp7Vhw4OpgMmE2PKnWTnxvPG5mLSurQjgiUWvv9PxtPSVqMTEh+zWMbpZiADnhmP4Wie
         CdeUNIUGGwzwf6D4pxWwzgYYB7EeHgRugrq/8Kcdxtl1Ifn4VjvnFsRT9d/x6DrHN52V
         LjsGBYLIlOOdfEc4rHTKV78v1buVq2Zs6KS92a4vsDyenvGrfrokDe7zk5qyS79UXHN7
         CEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LfU4NdFCY9mc96XzAftKL5sqMzYNYpuz0VuvSMcGko=;
        b=Kn555pKsHJGiYcOowwZu7VafmpLfQ57Df3ahKJj3Zul1/NvxUcnFFjXPtV6Rpps5LO
         6qRmzgiJkXdrxkACxZKQgJYsWwUi1b8iH00ZIIZwZ89rVENDm94xLpxKLAAApNg4Yck/
         fFaia0TLCA98d8NdymFIJ7Sq1xL8TqHP2bNfq9MYh4shTH0CgDw18GY5t2QBYfaEFWXC
         R3bNLJrM9SJSkN8qtMP7L7weH/Rk7Ng9FlSKPP71uqMCI/57UXPkm1FngMlUFG2yNetX
         HX3XaRBrGXo0AArXMhJ0d3xZacs3Z4npytdjk/RT6kTGcnpYOyx8RcsSfSnqIKJ+z/t6
         qz2A==
X-Gm-Message-State: AFqh2kofmTJJ39g00l8AiPXt5nNVN5AKEZBxLCHCfqXvpig8Jf5FOxVQ
        hxaE3O3Tk0tXmJn9VRV4g7Mk86Hu4vGJFLXqg3Sd4A==
X-Google-Smtp-Source: AMrXdXtm2ZrkaA0rw5RqDWYgPn1YG+GpZT4pmxbZ4JYnhM7L8m57SoxRptL9ssm4sTwpAl2zFa006VRnLiy4NJFPcco=
X-Received: by 2002:a17:90a:7e8d:b0:225:d307:95ce with SMTP id
 j13-20020a17090a7e8d00b00225d30795cemr5435468pjl.136.1674891287679; Fri, 27
 Jan 2023 23:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-6-saravanak@google.com>
 <Y9OZh0ZqtnqmKcvT@smile.fi.intel.com>
In-Reply-To: <Y9OZh0ZqtnqmKcvT@smile.fi.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 23:34:11 -0800
Message-ID: <CAGETcx9WX-Nf7oD=sLEsG70hDczrQkDRdQTBmgE2y89hDLbYDg@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] driver core: fw_devlink: Add DL_FLAG_CYCLE
 support to device links
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 1:30 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 26, 2023 at 04:11:32PM -0800, Saravana Kannan wrote:
> > fw_devlink uses DL_FLAG_SYNC_STATE_ONLY device link flag for two
> > purposes:
> >
> > 1. To allow a parent device to proxy its child device's dependency on a
> >    supplier so that the supplier doesn't get its sync_state() callback
> >    before the child device/consumer can be added and probed. In this
> >    usage scenario, we need to ignore cycles for ensure correctness of
> >    sync_state() callbacks.
> >
> > 2. When there are dependency cycles in firmware, we don't know which of
> >    those dependencies are valid. So, we have to ignore them all wrt
> >    probe ordering while still making sure the sync_state() callbacks
> >    come correctly.
> >
> > However, when detecting dependency cycles, there can be multiple
> > dependency cycles between two devices that we need to detect. For
> > example:
> >
> > A -> B -> A and A -> C -> B -> A.
> >
> > To detect multiple cycles correct, we need to be able to differentiate
> > DL_FLAG_SYNC_STATE_ONLY device links used for (1) vs (2) above.
> >
> > To allow this differentiation, add a DL_FLAG_CYCLE that can be use to
> > mark use case (2). We can then use the DL_FLAG_CYCLE to decide which
> > DL_FLAG_SYNC_STATE_ONLY device links to follow when looking for
> > dependency cycles.
>
> ...
>
> > +static inline bool device_link_flag_is_sync_state_only(u32 flags)
> > +{
> > +     return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE))
> > +             == (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);
>
> Weird indentation, why not
>
>         return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE)) ==
>                (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);
>
> ?

Ack. Will fix in v3.

>
> > +}
>
> ...
>
> >                              DL_FLAG_AUTOREMOVE_SUPPLIER | \
> >                              DL_FLAG_AUTOPROBE_CONSUMER  | \
> >                              DL_FLAG_SYNC_STATE_ONLY | \
> > -                            DL_FLAG_INFERRED)
> > +                            DL_FLAG_INFERRED | \
> > +                            DL_FLAG_CYCLE)
>
> You can make less churn by squeezing the new one above the last one.

I feel like this part is getting bike shedded. I'm going to leave it
as is. It's done in the order it's defined in the header and keeping
it that way makes it way more easier to read than worry about a single
line churn.


-Saravana

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
