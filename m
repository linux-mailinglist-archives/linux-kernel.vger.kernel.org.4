Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F56A49E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjB0Sgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0Sgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:36:31 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DB59D5;
        Mon, 27 Feb 2023 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oQVtxUWoJZl5nryf+nzdarBkbw9Vk2BNb3zqSC+Ure4=; b=pKi8Eqg5g5LTjQP97WuOMpYlAp
        BU68dqbTorIcqBm91Y6wPURRk9CqQBMiX6P7qADqMmR/e/Z06E7gIDZh0grS8dKP7ij0jtJhZpsdH
        g2z6lAueIFbChdiBi/zf2JjOma6p0P5+8v7aIOp5LybFzsOlv7DJBWLjOKhJIGXSgOYuGSTBffylh
        jG9Qk5+pg5PpPAGMO7BqZQ2klKQsE7Wfz2J6hyn1hCeJ/l1GnhcVaKPScr7MJOZv5jrxMAhR/kAEJ
        fErXkKZKCz8Ef+UbhijzAmMoTJo/HHdtl2rQi5gphUhtGwkxi7uQiWBSWKf8CBLAQYwB+3xJ1RCfI
        uwZAwzKg==;
Received: from [152.254.196.162] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pWiMD-00Gztq-Do; Mon, 27 Feb 2023 19:36:17 +0100
Message-ID: <421678cb-6ec0-903c-a84b-c833f013815d@igalia.com>
Date:   Mon, 27 Feb 2023 15:36:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: bcm: brcmstb: Remove bare-metal ARM suspend/resume
 code
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@vger.kernel.org
Cc:     drv@mailo.com, ssengar@microsoft.com,
        kumarpraveen@linux.microsoft.com, christophe.jaillet@wanadoo.fr,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Miaoqian Lin <linmq006@gmail.com>, Liang He <windhl@126.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230224215249.239405-1-f.fainelli@gmail.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230224215249.239405-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 18:52, Florian Fainelli wrote:
> Since 2018 these platforms have supported entry via the ARM Trusted
> Firmware using the standard PSCI SYSTEM_SUSPEND function calls. Remove
> this legacy code.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> [...]
> -/*
> - * The AON is a small domain in the SoC that can retain its state across
> - * various system wide sleep states and specific reset conditions; the
> - * AON DATA RAM is a small RAM of a few words (< 1KB) which can store
> - * persistent information across such events.
> - *
> - * The purpose of the below panic notifier is to help with notifying
> - * the bootloader that a panic occurred and so that it should try its
> - * best to preserve the DRAM contents holding that buffer for recovery
> - * by the kernel as opposed to wiping out DRAM clean again.
> - *
> - * Reference: comment from Florian Fainelli, at
> - * https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com
> - */
> -static int brcmstb_pm_panic_notify(struct notifier_block *nb,
> -		unsigned long action, void *data)
> -{
> -	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
> -
> -	return NOTIFY_DONE;
> [...]

Hi Florian, thanks for the clean-up!

I'm curious with the above panic notifier - is it not necessary when
PSCI is used?

Cheers,


Guilherme
