Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0580694BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjBMP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBMP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:57:36 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC525257;
        Mon, 13 Feb 2023 07:57:32 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id lf10so1162411ejc.5;
        Mon, 13 Feb 2023 07:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIJSf+XurZOqyGE9DpYNL1/ZnZBKhqx/Senz95QUCN0=;
        b=iGLMZMyxUBXGNVlVyKcRemypb5ZZu+OLWCuj7vGdqqkkVyVwPZ7DApBGwHY4Pmgtkr
         fJegBEXfOvtu4GxryqtwNjzrT1LT7SA08s+nmWjZlhTcRKpeK5VkBQ4YvJglIghQy7e1
         cmxmyfXogkNXdXaWanzh/WvbBrwjW9V0SyEQahqe92hEVUVOW3rHCdNa0JfiwgZak8ie
         iWJEoKpYGqcydBlm+vNyGL4a74L18ycvOsW2TBCic6yevn0HgghnO6/+4g0lk6WQCsqR
         J7FuVmN1VPJ2NXnS/INRwNH9ZAzuDabmA65jOlgTrCb4KrURe7wX943GFmOvRd4PJ/46
         w9fw==
X-Gm-Message-State: AO0yUKWJypBb5SExelvlJcdAjNVAZzf4gyleOe+xMOJ7JdfPAStbJs7C
        bqetlyf0A9/vwrClRrCTocg1SrIBEU7l4WYTwHPYrcJf
X-Google-Smtp-Source: AK7set/2IathRSVeenCIyaFzAMkA1ZRmj0wTGBJA1DncV9DfybKYoybegkxtrfmtSsBwu4yJOs8WqH9DjjEK9dclBSw=
X-Received: by 2002:a17:906:c1ca:b0:877:747d:1108 with SMTP id
 bw10-20020a170906c1ca00b00877747d1108mr4833400ejb.5.1676303851052; Mon, 13
 Feb 2023 07:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20230213132048.2612961-1-rf@opensource.cirrus.com>
 <CAJZ5v0hE7u_rTEn1KRFhE55Y3MHS_Le4rAbFPmR+0r+Eg=3K9Q@mail.gmail.com> <1294e968-d03e-ee4a-e1c1-d9293b813c63@opensource.cirrus.com>
In-Reply-To: <1294e968-d03e-ee4a-e1c1-d9293b813c63@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 16:57:19 +0100
Message-ID: <CAJZ5v0jMbRNPuPOmDNYCvpj+R9DS+x1FPUegi8NESgi1xT_hig@mail.gmail.com>
Subject: Re: [PATCH] PM: Add EXPORT macros for exporting PM functions
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, pavel@ucw.cz,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 4:50 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 13/02/2023 15:43, Rafael J. Wysocki wrote:
> > On Mon, Feb 13, 2023 at 2:20 PM Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> Add a set of macros for exporting functions only if CONFIG_PM
> >> is enabled.
> >>
> >> The naming follows the style of the standard EXPORT_SYMBOL_*()
> >> macros that they replace.
> >>
> >> Sometimes a module wants to export PM functions directly to other
> >> drivers, not a complete struct dev_pm_ops. A typical example is
> >> where a core library exports the generic (shared) implementation
> >> and calling code wraps one or more of these in custom code.
> >>
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> ---
> >>   include/linux/pm.h | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/include/linux/pm.h b/include/linux/pm.h
> >> index 93cd34f00822..21618f7087f8 100644
> >> --- a/include/linux/pm.h
> >> +++ b/include/linux/pm.h
> >> @@ -379,9 +379,17 @@ const struct dev_pm_ops name = { \
> >>          const struct dev_pm_ops name;                                   \
> >>          __EXPORT_SYMBOL(name, sec, ns);                                 \
> >>          const struct dev_pm_ops name
> >> +#define EXPORT_PM_FN(name)             EXPORT_SYMBOL(name)
> >> +#define EXPORT_PM_FN_GPL(name)         EXPORT_SYMBOL_GPL(name)
> >> +#define EXPORT_PM_FN_NS(name, ns)      EXPORT_SYMBOL_NS(name, ns)
> >> +#define EXPORT_PM_FN_NS_GPL(name, ns)  EXPORT_SYMBOL_NS_GPL(name, ns)
> >
> > Why are the non-GPL variants needed?
> >
>
> I did all four because there are all four variants of EXPORT_DEV_PM_OPS.
> Why are the non-GPL variants of EXPORT_DEV_PM_OPS needed?

They aren't or at least they should not be needed in the mainline.

> I can remove the non-GPL variants of my macros.

Yes, please!

> >>   #else
> >>   #define _EXPORT_DEV_PM_OPS(name, sec, ns)                              \
> >>          static __maybe_unused const struct dev_pm_ops __static_##name
> >> +#define EXPORT_PM_FN(name)
> >> +#define EXPORT_PM_FN_GPL(name)
> >> +#define EXPORT_PM_FN_NS(name, ns)
> >> +#define EXPORT_PM_FN_NS_GPL(name, ns)
> >>   #endif
> >>
> >>   #define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
> >> --
> >> 2.30.2
> >>
