Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0711622D13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKIOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiKIOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:00:37 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D901658C;
        Wed,  9 Nov 2022 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1668002431;
        bh=Ews65r4y2x+UHZvJJk7wXKfdlpp6YZLRGLLHPu4DZpc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ha4gxdm9cLM96VCWy6RWfDZcLShBR/G6OaDedILXBox2ZNKSkyb80M8GOB6NreAu3
         qUlREHCsR3QCxqJpB12pz42N/MUaf1ycUm73nGHFeV+kSfKlHxPI9xodCmqHmp7tmH
         5zX85FGHc05xFuPwbSlnh0D+JTTcQE5rHOIfYIpA=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B1BEE66883;
        Wed,  9 Nov 2022 09:00:27 -0500 (EST)
Message-ID: <80accd6a82d35902c08acbafcd10426b81d15bec.camel@xry111.site>
Subject: Re: [PATCH v6 1/2] soc: loongson: add GUTS driver for loongson-2
 platforms
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Date:   Wed, 09 Nov 2022 22:00:26 +0800
In-Reply-To: <CAAhV-H4mpNp6wEGY0xOJgf5Kjm1EKXBUZdSKoGeacN5_CVuxtA@mail.gmail.com>
References: <20221104024835.3570-1-zhuyinbo@loongson.cn>
         <CAAhV-H4mpNp6wEGY0xOJgf5Kjm1EKXBUZdSKoGeacN5_CVuxtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-09 at 21:57 +0800, Huacai Chen wrote:
> Hi, Yinbo,
>=20
> On Fri, Nov 4, 2022 at 10:48 AM Yinbo Zhu <zhuyinbo@loongson.cn>
> wrote:
> >=20
> > The global utilities block controls PCIE device enabling, alternate
> > function selection for multiplexed signals, consistency of HDA, USB
> > and PCIE, configuration of memory controller, rtc controller, lio
> > controller, and clock control.
> >=20
> > This patch adds a driver to manage and access global utilities block
> > for loongarch architecture Loongson-2 SoCs. Initially only reading
> > SVR
> Replace loongarch with LoongArch.
>=20
> > and registering soc device are supported. Other guts accesses, such
> > as reading PMON configuration by default, should eventually be added
> > into this driver as well.
> Replace PMON with BIOS is better.

Or just "firmware"?  I remember Xuerui (or another guy?) has said
"nobody should use the term BIOS for non-x86 platforms in 2022".

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
