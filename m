Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68A95DDD34
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIUSNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiIUSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:13:42 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63967EFE4;
        Wed, 21 Sep 2022 11:13:41 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id h28so4607783qka.0;
        Wed, 21 Sep 2022 11:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mInsceIHKGpEA4Fy20VkkW8wh0vIm2v2E7BS4tpCcY0=;
        b=Km82qcvQWGOD45vqFeIn6v0yx/OuO3secDt6hD5s+UWZKrnP1kNhNMYpR1rxTJddeG
         9xvbSH2EY1SF43gsvpYoM2c9DePvK9NMSAPuU/Cl8+6gbjb/Mh7sl0gjL7S1i3joI5AG
         1ynEvKwh528kzHmEyL9m2WyYdSyZC41EYBa6sC42K97lwciqFRDa7rsNo8M0hF/Wn5Ry
         x9FtBBVLeN1orilKAlfKKyqQfgZRKRKcg/MZNAVaqMPtkNop4o2hd7KusjwFMATzJnDN
         WUhKDej9JJrPw1IcYSEM3Dml+LgIzndUuBOwBgkW//Q+i/ZwPoPaN5SpkFEtOb1GeE5v
         g4rQ==
X-Gm-Message-State: ACrzQf3mgehJ8CeO4B0kaACV6/8rZCEIh+bF23g7dCyzpu2SiBjQE8ud
        hZL+NScl5N46DzotydqBSROfrkgAAHKqWdWZyJA=
X-Google-Smtp-Source: AMsMyM50ZihtgJl2kvb/GbiZ4Hptr3ZKNo+2Ha+UPaVH8kR9KCSkJeSdze5aVzpABgPv7+HBBQ/HPmsbKcs+tj2DALU=
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id
 h8-20020a05620a400800b006ce87250cb7mr21224231qko.480.1663784020888; Wed, 21
 Sep 2022 11:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <1663294501-6377-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1663294501-6377-1-git-send-email-u0084500@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Sep 2022 20:13:29 +0200
Message-ID: <CAJZ5v0gL_U=FwY8W-A2pGSif6wbvyFUL7WQ2jcqHFgT2ucqY6Q@mail.gmail.com>
Subject: Re: [RFC] PM: core: Add pm_wakeup_pending check in device suspend_noirq
To:     cy_huang <u0084500@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, cy_huang@richtek.com,
        gene_chen@richtek.com, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 4:15 AM cy_huang <u0084500@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> In 'dpm_suspend_noirq', it will do the sychronized_irq to guarantee all
> irqs are all done, and then do any wakeup flag set.
>
> For some peripherial deivces like as I2C/SPI, to speed up the irq handling,
> it may use 'pm_stay_awake' and really handle in another thread context like
> as workqueue.
>
> But in mem suspend flow, after 'dpm_suspend_noirq" stage, the next
> 'pm_wakeup_pending' check will be at 'syscore_suspend'.
>
> The checkpoint seems too late and cause I2C/SPI fail during 'noirq' to
> 'syscore_suspend'

What exactly do you mean by "fail" here?

>. But some adapter was already be marked as 'suspended'
> at 'noirq' callback, any I2C/SPI xfer will return the error flag '-ESHUTDOWN'.
>
> After the code trace, it seems all device callback will do 'pm_wakeup_pending'
> check, except 'noirq'.
>
> This patch is to add 'pm_wakeup_pending' check in 'noirq' sage to prevent this
> kind of usage.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Hi,
>
> Is there any rule to define when I2C/SPI host controller need to mark adapter as
> 'suspended'?
>
> I trace 'drivers/i2c/buses'.It seems there's no common rule, Some are 'suspend',
> others may did it at 'suspend_noirq'.
>
> ---
>  drivers/base/power/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c501392..7cd7dc5 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1210,6 +1210,11 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>         if (async_error)
>                 goto Complete;
>
> +       if (pm_wakeup_pending()) {
> +               async_error = -EBUSY;
> +               goto Complete;
> +       }
> +
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
> --
> 2.7.4
>
