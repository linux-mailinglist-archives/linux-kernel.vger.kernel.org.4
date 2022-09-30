Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9B5F120A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiI3TAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiI3S74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497AE49B44;
        Fri, 30 Sep 2022 11:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB0A3623D3;
        Fri, 30 Sep 2022 18:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41810C433C1;
        Fri, 30 Sep 2022 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664564393;
        bh=3QNA3zbxcf7C4eGHXviUTx4Mw2lLcI48VnpwYP8Y8s4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aZSaxoh2EQHcxbPxcxRfp25X3CBDogGpi/oGVPkj8agbdJ9P96s1jidhYhAqXmWEy
         TcykmDM6A+4IG1bMzW2DyIZ5eeBpaw1Aab0BLIodRJUWZMzrQWXIRrYvekX0P4wU16
         6FMiMv2Xhv+f+4mwQEDvLyPrpMi74Cdce3dsWVdJSQHi2loO9vNcd15Y3ywbuQRxeq
         ambIAp0HAGBnCAzsAzPra/gRV8VYhsfeLiOPZWNb/evVLAOg9WqZw9xksARRYH1Va9
         MBPcgUspxQh8oPEtdvbE9+Tv5gOPgK+rETIKKMifAPVIqWqiXiXWYz1+Q6gcR4P/hJ
         2FHcjYw24WZYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <17c5cc9c-50ea-aeac-04e0-20b6c093c7ec@collabora.com>
References: <20220929121031.17523-1-rex-bc.chen@mediatek.com> <17c5cc9c-50ea-aeac-04e0-20b6c093c7ec@collabora.com>
Subject: Re: [PATCH v3] reset: mediatek: Move mediatek system clock reset to reset folder
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, nfraprado@collabora.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de
Date:   Fri, 30 Sep 2022 11:59:51 -0700
User-Agent: alot/0.10
Message-Id: <20220930185953.41810C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-09-29 05:50:38)
> I've just analyzed this idea a bit more, and there's the outcome.
>=20
> This driver would be fine, if some MediaTek SoCs weren't shipped with
> a bootloader that supports only very small kernels... because then, if
> the reset controller is not available at boot time, it's unlikely that
> you can probe the eMMC or the uSD, so it won't be possible to actually
> compile this driver as a module and load it afterwards.
>=20
> Please don't misunderstand me: I like the idea of having the MediaTek
> SoC sysclk reset controller as a ... reset controller driver but, to
> make that work, one fundamental issue must be solved...
>=20
> If the kernel is configured for, let's say, MT2701 and MT2712, we're
> always building in reset controller support for MT7622, 7629, 8135, 8173,
> 8183, 8186, 8192, 8195 - and this list will grow with MT8188, and others.
>=20
> Obviously, it's useless to have support for, say, MT7622, if the MT7622
> system clock controllers aren't built-in, nor modules.
>=20
> So, to make this idea to work, we have to find a way to:
> 1. Build in support only for the required SoC(s)

Use Kconfig

> 2. Put the reset index mapping arrays in SoC-specific files, or this
>     single file driver will see an exponential growth.

Split the reset driver into different files compiled for different SoCs
based on the SoC Kconfig made in step 1.

>=20
> Wrapping it up - as the driver is right now - we're losing flexibility:
> we need to maintain the current flexibility while keeping the improvements
> that are made with this proposal.
>=20
> Ideas?
>=20

It should work and your concerns are alleviated?
