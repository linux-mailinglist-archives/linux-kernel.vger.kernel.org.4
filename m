Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EE622831
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKIKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiKIKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:16:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3211D320
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:16:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so45313555ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMdsq5H+6Eg0hvqJw3g6zxey1x9uU7yagkyLzIBH/F8=;
        b=Mf4BNQPHb+LkQAXlb/zm2rbrYtltLFna6nc2Es5lq8bJEJ7rDh5wWXb5VkkK3/kUYf
         JqZ44+Pi2/+t1XBglDDFxNwhZ0Fn2xsUhxjfWUXoRRSR2+zBg/bJ8kap//H+CajrVAni
         cbDNGfypzUF2W//Pc9OJEatkwT5vAGlVsIwXU34LesicaLUQRSeBms0HTcF3jVXeQgem
         d/g6eG09j0VdiIfCTn2N5473qcM76Av/rrpDT/SEt2hrd0qh41SGOIvqZQLILodXGr0Y
         /dFVhZLeGMPLJCE4WE/w0xlAufUt0Ltc1l4DVdWqp+ZIOV74v/ptSpG/vkSTfBiHxcGE
         OLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMdsq5H+6Eg0hvqJw3g6zxey1x9uU7yagkyLzIBH/F8=;
        b=1kvL+0+MtHEwviQCLcyS7eNwgXg4xZurF4fBLSQKCBER+rmvxlbmv1oFK/SDs4WDRe
         wcjugdiMwSYUP70feVa8uoOqXF7Bu1aJpwl04SMVmXDhw5gqe+VXf/LBOtQJV/Gfh2gm
         GESINXvzk3TgYjYiZ2ENAaMsEoqCDVpIESnoA8JSiPDygplEKQ1+y+kIYfwytVxzW4Wo
         2hS11MQo6SU1wIpSE9mjCMXQQmb+NJga4H3leFuvF1s0ReXWuXNJA2WVHjuAnPVPxgDn
         l0d+gPcRHS1xeBxZBEBoE3U7VpP0iBMjp7tKjGaS1YQB3RDo7cmyudSozY6GTgplCtnu
         hR+g==
X-Gm-Message-State: ANoB5pkeTtJPWPjsggVrF2Hp31DIky3HxY+jZlS92zk6dK1u5UgeU4cu
        YmpKU01nywU+vEpuNPC6Ybr4jHfF8HYr53tIOUECEA==
X-Google-Smtp-Source: AA0mqf5TF33fQF20BTjL+3ietwm8wjDul9XW+jKaFBmLAPAOQ0xs+i8deVVZ1I0zgS5VF8Q1mxfrofhVMn/oYL/Vdak=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr14661004ejs.190.1667988962150; Wed, 09
 Nov 2022 02:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20221104024835.3570-1-zhuyinbo@loongson.cn> <57c9f565-e75b-0c8f-fdce-9dc8c334d50f@loongson.cn>
In-Reply-To: <57c9f565-e75b-0c8f-fdce-9dc8c334d50f@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 11:15:50 +0100
Message-ID: <CACRpkda=-_a+gWQVk1vi4QJ30j-hzeraX-wr86RcQ9xne4-d6Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] soc: loongson: add GUTS driver for loongson-2 platforms
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 11:03 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:

> Hi maintainer,
>
> This patch I had verified that base on mainline 6.1-rc3 tree, it is
> okay, if no other issue, please you help me merge it to upstream.

Aren't these loongarch maintainers listed in MAINTAINERS able to
merge this? Certainly Huacai can merge stuff to drivers/soc as
need be. drivers/soc is a bit shared between different archs.

LOONGARCH
M:      Huacai Chen <chenhuacai@kernel.org>
R:      WANG Xuerui <kernel@xen0n.name>
L:      loongarch@lists.linux.dev
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
F:      arch/loongarch/
F:      drivers/*/*loongarch*
F:      Documentation/loongarch/
F:      Documentation/translations/zh_CN/loongarch/

Yours,
Linus Walleij
