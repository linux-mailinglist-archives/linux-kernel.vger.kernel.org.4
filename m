Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CD5F0DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiI3OnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiI3OnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:43:10 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750310AB0A;
        Fri, 30 Sep 2022 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1664548985; bh=+6qTIFFJKA3rP5CBKrEGP9nTyy0TCuPtEQRDHlQDQBg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=miPn2lcznclcMGrbjklHkagM1M++XmC4PMekCkrtWMhqTgzqizH11cubsnsI4fjhO
         MaHAsKUMXHYaLaDsa4v9A1bh1kJfVA3mnR7AL4pTH/lYdc0RepeXoGMXunBnigPnb6
         /bNdXEVnqsnVSrkLOUjv2bnnm4v6SSl8KZC+ABNY=
Received: from [192.168.9.172] (unknown [101.228.138.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 6C470600F8;
        Fri, 30 Sep 2022 22:43:05 +0800 (CST)
Message-ID: <bc62d053-1e26-d7b7-3611-f0c9237d86f3@xen0n.name>
Date:   Fri, 30 Sep 2022 22:43:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0a1
Subject: Re: [PATCH v1 1/2] clocksource: loongson2_hpet: add hpet driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20220930093510.10781-1-zhuyinbo@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220930093510.10781-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/30/22 17:35, Yinbo Zhu wrote:
> HPET (High Precision Event Timer) defines a new set of timers, which
> are used by the operating system to schedule threads, interrupt the
> kernel and interrupt the multimedia timer server. The operating
> system can assign different timers to different applications. By
> configuration, each timer can generate interrupt independently.
>
> The loongson2 HPET module includes a main count and three comparators
> , all of which are 32 bits wide. Among the three comparators, only
> one comparator supports periodic interrupt, all three comparators
> support non periodic interrupts.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>   MAINTAINERS                          |   6 +
>   arch/loongarch/kernel/time.c         |   3 +
>   drivers/clocksource/Kconfig          |   9 +
>   drivers/clocksource/Makefile         |   1 +
>   drivers/clocksource/loongson2_hpet.c | 332 +++++++++++++++++++++++++++
>   5 files changed, 351 insertions(+)
>   create mode 100644 drivers/clocksource/loongson2_hpet.c

Thanks for the contribution, but as HPET is a fairly common peripheral 
that have well standardized behavior, why not simply add DT support to 
the drivers/char/hpet.c and be done with it?

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

