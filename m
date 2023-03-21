Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7056C3E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCUXX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCUXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DD8574ED;
        Tue, 21 Mar 2023 16:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC11C61ECD;
        Tue, 21 Mar 2023 23:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25840C433EF;
        Tue, 21 Mar 2023 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679441034;
        bh=+EfnOxT75Ld+29rEVmKi6TN3JgIS8p2r7e10xPEAPGo=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Vzd5oM68Pw5X+tVrVXkMn/ejgMsiJ0J5brorQOCg3FqUYlN4j4PrLRDWspJ39cEna
         sQ6p/chTwubRym64K3xbcpvM9QxuVmvSPVxhoyXDEH2FnK8X8KuVw4YzAFGJpNoROo
         /6min28s0g6QwMl3/z6/velSIRSwPgljM8P7SbjnPF4z0mAEMklOBqq121zTRh8CIJ
         vNXlRj1ufVLX2olhzT8aSmnMWOMKcewQ5TFyZVX6hmMXS3FpT70QU5PJ11i9enYOhg
         WrJbAay6sZ7xZRzcYIFlbolZV5bwJ5jnctE9g24Urlak/2X9yurE8eXNCIZ6Hafi6O
         7C+vNBFAbUEJA==
Message-ID: <896d16997cf3d308eff0cb8ce8596fc3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <302bb0c4-a31e-7025-26d6-21c8d473f370@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com> <20230321201022.1052743-1-noltari@gmail.com> <20230321201022.1052743-5-noltari@gmail.com> <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org> <0071fdc1-fa53-e096-19c7-ecd1a9d56e86@gmail.com> <d06781c905adb23089a85a8d54b94461.sboyd@kernel.org> <302bb0c4-a31e-7025-26d6-21c8d473f370@gmail.com>
Subject: Re: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset driver
From:   Stephen Boyd <sboyd@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, jonas.gorski@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        william.zhang@broadcom.com,
        =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez?= Rojas <noltari@gmail.com>
Date:   Tue, 21 Mar 2023 16:23:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Florian Fainelli (2023-03-21 16:09:54)
> On 3/21/23 16:06, Stephen Boyd wrote:
> > Quoting Florian Fainelli (2023-03-21 16:00:29)
> >>
> >> These SoCs are big-endian, require native endian register access and
> >> have no posted writes within their bus logic (UBUS) and require no
> >> barriers, hence the use of __raw_readl() and __raw_writel() is adequat=
e.
> >>
> >=20
> > Use ioread32be() then?
>=20
> BCM63xx drivers tend to use __raw_{read,write}l for consistency and to=20
> make it clear that no barriers, no endian swapping is necessary, I would =

> prefer to remain consistent with that convention.

Ok.

Is the clk device big-endian? Or the CPU is big-endian? SoC being
big-endian sounds like the devices in the SoC are big-endian. I hope we
never plop this device down with a CPU that's litle-endian.
