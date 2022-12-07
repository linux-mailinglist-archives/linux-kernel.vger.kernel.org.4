Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543246463E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLGWNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLGWNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:13:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084B5B5B8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:13:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y4so18379397plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nEgt4bnIsVkJIQUqcwPD9I1432q4Z5qtw3xEnhVXCI=;
        b=igu3cBWidQrTd/ku7BwQIwug8ETi/ySbCW/XBpvclOku5WJ9nlvRQHhZpbKVNR78tc
         ABD1+ytIxj0GdXe2sz5a3291QwNHZcKn7RhtaCI6ryEpvhk3L2ujBd2+TMYLEeLAtK0n
         DHY8IJXMCnkKk08+P6gKHbXrZ9/8temljGIYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nEgt4bnIsVkJIQUqcwPD9I1432q4Z5qtw3xEnhVXCI=;
        b=j6TXrgGpuBoihsTUzoTcm5uM8qSMAFDjQkwksU3KgoeA2RsGQyL6LYyWZyACCwt+bI
         ZyAYf1VL1zgET7YEU4vqEj/Q0og8c5LsrY0pZujl3JXVW91GVZ1q7Lw6Z9xFZhH75VT4
         uYeudJtcSh/Va+fXhhcw027+ugMB90tdeYwNZibeELfBZyzuLzkV/sDhuOIHV6FajUnD
         4Z3veWXY8w+MtP4jegV6pk9VO24oofILZgcmiWXdVCTTlTRrag74yrR2avVavdQBhdFO
         PXxYkG/py1PGNXzLmrrpD1yQIq6v4O69JvLFrlEY2GxiNTDTgkRNP/o6ONG1gmRFtvGr
         hJbQ==
X-Gm-Message-State: ANoB5pky57u23y4bIgZmXbYGvwIyOkungYj6SVseeo8BWYPIBos+A8ei
        0Y9WGKcUp+fHmdtcU6tPijK4yA==
X-Google-Smtp-Source: AA0mqf5juEY2JmqwIYJahljnggFGeoctHKQSscU3qjPfwxoQcSUcWbssc4pkrH1VlFkhKS7ZE5Qhmg==
X-Received: by 2002:a17:90a:8402:b0:218:7744:5e9 with SMTP id j2-20020a17090a840200b00218774405e9mr103365755pjn.44.1670451231433;
        Wed, 07 Dec 2022 14:13:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nr4-20020a17090b240400b002191e769546sm1641462pjb.4.2022.12.07.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:13:50 -0800 (PST)
Date:   Wed, 7 Dec 2022 14:13:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: Invalid pstore_blk use?
Message-ID: <202212071412.1B1BF97@keescook>
References: <e97bc607-a913-dbbd-1965-b60d55d956b8@gmail.com>
 <c5edaa34-6f85-c6a8-84f5-75413dc864ea@gmail.com>
 <202208091600.D19DFF9C7D@keescook>
 <CAC=U0a3F6172JH+xvA0pSb0bewu_0PX9XFKmL32ge+KyTOdaZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=U0a3F6172JH+xvA0pSb0bewu_0PX9XFKmL32ge+KyTOdaZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 03:41:44PM -0500, Kamal Dasu wrote:
> Kees,
> 
> I am in the process of implementing  mmcpstore  backend for mmc  based
> on the mtdpstore driver
> 
> This is what is registered with register_pstore_device(&cxt->dev);
> cxt->dev.flags = PSTORE_FLAGS_DMESG;
> cxt->dev.zone.read = mmcpstore_read;
> cxt->dev.zone.write = mmcpstore_write;
> cxt->dev.zone.erase = mmcpstore_erase;
> cxt->dev.zone.panic_write = mmcpstore_panic_write;
> 
> # dmesg | grep pstor
> [    0.000000] Kernel command line: pstore_blk.blkdev=/dev/mmcblk1p8
> crash_kexec_post_notifiers printk.always_kmsg_dump
> [    1.993986] pstore_zone: registered pstore_blk as backend for
> kmsg(Oops,panic_write) pmsg
> [    2.002582] pstore: Using crash dump compression: deflate
> [    2.008133] pstore: Registered pstore_blk as persistent store backend
> [    2.020907] mmcpstore: /dev/mmcblk1p8 size 131072 start sector
> 34468 registered as psblk backend
> [   17.868753] psz_kmsg_recover_meta: pstore_zone: no valid data in
> kmsg dump zone 0
> [   18.298933] psz_recover_zone: pstore_zone: no valid data in zone pmsg
> [   18.305398] psz_recovery: pstore_zone: recover end!
> 
> The driver is successfully registered and the read path works when
> /sys/fs/pstor is mounted , however mmc_pstore_panic_write is not
> called.
> Need help in understanding what could be missing. I am using the
> latest upstream kernel for testing.

Hi!

Can you send an RFC patch? I'd expect this to work as you've currently
described it, but without code I'd just be guessing. :)

-Kees

-- 
Kees Cook
