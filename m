Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B9743EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjF3PZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjF3PYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:24:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0F10C3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:24:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f766777605so3230436e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688138681; x=1690730681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txeggcAXbRmMDpa24OQ4hQFnGXTegi/WFNEbs/267Mk=;
        b=zyhfMPGXkAD6EhJlJiOnavDdNQLlyKsqaPyQuT3tqsKmqxrDbWPaXnqU4ribLdFtlF
         LVMhBIuXwzCleZdHtXIxAGe3Hvy6F2ddGLuibXvlssx9omtgDWdztKaCkbNO9o3hyUc4
         z32ZQBMD5wBT1Jz560HCRJPN12axNLjelwqkuIJrjS/rFZ1NXN9PqN/SuSfCl1zfCOB1
         x3ivmtNzm1/0l1OKmRjVAr7nFae9llyXKw9jnsDTXCXf8Ovfphkanl2c85GawDBMfmOQ
         0avV+5c3Kar3gbQqvcoaXL48AC68AvPohUSBHRiN7p5pNjouRChcrE090aPkv7Q/yYLi
         F+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138681; x=1690730681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txeggcAXbRmMDpa24OQ4hQFnGXTegi/WFNEbs/267Mk=;
        b=O5RhXgPyaFov7GrHjW0Zj1RDO60sYzw9hyl69hwstVxziHqC3+XmBfk+uKKOh+6DqZ
         SWzwfV97PoJtypgUUZcfNyshEaIUBFllO1KibuuS+tJxo9fXSAbojQOo00AjfChoCvHR
         CDMDVT95uAXsyD/VtBrHiRueP/fiy3IGvvmU+W9j81yw5roiPG4sVcTfAhifuwzQYQbt
         UybkxBECnSScTU3hZmyFktEyJG8Txo6PxvvnRR6q4+YXywb3XL99k7VRLLWk/mIqRAHp
         6VM66G9aiVlS31bR1xKU40w3EBGvcTxsFYwOeMLND3R1ZTRkNwDkfZoOP0NP4rdjDNqi
         2BOA==
X-Gm-Message-State: ABy/qLZ5U9uB0r8Jrv5xbK+cH7PzM3eMwA43xoyzY0h/Q7ytZyDmYimZ
        fc1wbOZywXY57O79XdKegvgKig==
X-Google-Smtp-Source: APBJJlFJPfsgrb4tFvXFPv9Ql8tUEzNhxmocRvXDbrIXKHjxgGW/kXmSw/ls3sv5mndZZvUUnNTV0A==
X-Received: by 2002:a05:6512:2815:b0:4fb:893e:8ffc with SMTP id cf21-20020a056512281500b004fb893e8ffcmr2950126lfb.17.1688138681214;
        Fri, 30 Jun 2023 08:24:41 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bcb8d000000b003fba97b1252sm9313936wmi.1.2023.06.30.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:24:40 -0700 (PDT)
Date:   Fri, 30 Jun 2023 16:24:39 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: include header in signal handling code
Message-ID: <20230630152439.GA2900969@aspen.lan>
References: <20230517125423.930967-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517125423.930967-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:54:09PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> kdb_send_sig() is defined in the signal code and called from kdb,
> but the declaration is part of the kdb internal code.
> Include this from signal.c as well to avoid the warning:
>
> kernel/signal.c:4789:6: error: no previous prototype for 'kdb_send_sig' [-Werror=missing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry to be so late with this feedback! I got as far as queuing this up
for merge before the penny dropped...

> ---
>  kernel/signal.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..d38df14f71ac 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4780,6 +4780,8 @@ void __init signals_init(void)
>
>  #ifdef CONFIG_KGDB_KDB
>  #include <linux/kdb.h>
> +#include "debug/kdb/kdb_private.h"
> +

Isn't is better to move the prototype for kdb_send_sig() into
linux/kdb.h instead?

That's what other kdb helpers spread across the kernel do
(kdb_walk_kallsyms() for example).


Daniel.
