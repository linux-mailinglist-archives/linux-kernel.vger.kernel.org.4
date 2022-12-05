Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD21642255
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiLEEm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiLEEmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:42:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28DADF5D;
        Sun,  4 Dec 2022 20:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 905BFB80D3F;
        Mon,  5 Dec 2022 04:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AECC433B5;
        Mon,  5 Dec 2022 04:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670215339;
        bh=hGVfY/YiMIoPWoZm2ky/fCC+ogF0sZ0/EbnMzxfrhSA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aTIdErjWIAFHlkmIudnnK/lHMT9WGunKhrK1mkARmQwYEJVPkTGqVbNp/5QT/fE6B
         DNTMACecptBlryHCBHuILZJsqgK6ZS9jUbI+awsghix0J6sP+CK1aAImyuqsKRssfB
         8PjvY3A2xddM52aUBjbYiXcfkgkEaELQh7NqY+qIG9Vst97Yzq2iACVKLgNQaTmw48
         D1QiWBPmOCYgK6/2/CupV3N3AIwwegG2BpM8EdA1wDJkw/s0VjmEo6XYFq9xyLuPPz
         lDi/PeraYIw60t58ID3TYdOYKzbg3MsMIh2IaDjvWWkYtcxWr/ucSWJo1OVME4m4Nr
         Bx/tuNdjTGajw==
Received: by mail-ed1-f50.google.com with SMTP id i15so5946992edf.2;
        Sun, 04 Dec 2022 20:42:19 -0800 (PST)
X-Gm-Message-State: ANoB5plztQhPmgVdEgnF6kNlFfi1+xmOkhZGooPMaydXA5ninFQR0QBB
        BTajT96f8tLSfH/ZNzJp91/aKBRgmJS+HRAbVFI=
X-Google-Smtp-Source: AA0mqf5MDssRik4wMIBESdT1+8eu1S+9rF6HtZjXOMCf/xAYijoD9F8YmPYb7ZZeCKctDg5I5sULvpNRuuo8Lt60A98=
X-Received: by 2002:a05:6402:2b91:b0:457:23cb:20ab with SMTP id
 fj17-20020a0564022b9100b0045723cb20abmr7253315edb.254.1670215337551; Sun, 04
 Dec 2022 20:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20221114113824.1880-1-liupeibao@loongson.cn> <20221114113824.1880-2-liupeibao@loongson.cn>
 <CAAhV-H4euj53v=5k7iw5Ts7i41fpnRfWCUaAKuOTPpjRDushFg@mail.gmail.com> <ea43e46f0ee749e4c00acb91fe670632@kernel.org>
In-Reply-To: <ea43e46f0ee749e4c00acb91fe670632@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 5 Dec 2022 12:42:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5agisBN7G4eJRXLe4rKYY2T1bxtQHfLQ-MtAt_gOJVjw@mail.gmail.com>
Message-ID: <CAAhV-H5agisBN7G4eJRXLe4rKYY2T1bxtQHfLQ-MtAt_gOJVjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqchip: loongarch-cpu: add DT support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Liu Peibao <liupeibao@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 4:45 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-12-02 02:07, Huacai Chen wrote:
> > Hi, Peibao and Marc,
> >
> > I found this patch has merged but lkp report a problem, this can
> > simply fixed by add "static" before loongarch_cpu_irq_of_init
> > definition. Since Marc's next branch hasn't been tagged yet, can
> > Peibao send a new version and Marc rebase it?
>
> Please send in a fix on top of the existing series.
OK, I'll send a fix later.

Huacai
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
