Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304F75F14C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiI3V0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiI3V0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6892F15AB58;
        Fri, 30 Sep 2022 14:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE9E9B829E1;
        Fri, 30 Sep 2022 21:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E16C433C1;
        Fri, 30 Sep 2022 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664573195;
        bh=360V7rDj3wxMoS6JnM/+CnB3ZGWiP5LXFSIlVEXWBbw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sl0sdVmKdQjzAt7mFCJu4oBoGLQcRsZos17XmIJDxBZdvaSq6T5XW4CSJxQq4G1q+
         P0mreebqNxJzllpXR9leKNNvi5MAjxArtNPIIOszp/8c97M66IyyirAAh/Pvu4QTWG
         nwl4K2eVaT0x+3US5ivSVY9tf5b79YRR0rn9rfx9tnKflfYut84/bucr/NXfEG/XgZ
         D3D3/LWoUle+DEAtrX/W37RNQKDjdaHbUHKR4+TN3le9aC7jO41HX2q63P948eI+2i
         NBjCtWBSOae37H38oa10seiH4NzVR93IUrVKEPvDXrYXgg1BL8P9TRs2iQ94L4f3ta
         WVNmVMdHV9IEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220929225402.9696-5-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru> <20220929225402.9696-5-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH RESEND v12 4/8] clk: baikal-t1: Add SATA internal ref clock buffer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Fri, 30 Sep 2022 14:26:32 -0700
User-Agent: alot/0.10
Message-Id: <20220930212635.A4E16C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Semin (2022-09-29 15:53:58)
> It turns out the internal SATA reference clock signal will stay
> unavailable for the SATA interface consumer until the buffer on it's way
> is ungated. So aside with having the actual clock divider enabled we need
> to ungate a buffer placed on the signal way to the SATA controller (most
> likely some rudiment from the initial SoC release). Seeing the switch flag
> is placed in the same register as the SATA-ref clock divider at a
> non-standard ffset, let's implement it as a separate clock controller with
> the set-rate propagation to the parental clock divider wrapper. As such
> we'll be able to disable/enable and still change the original clock source
> rate.
>=20
> Fixes: 353afa3a8d2e ("clk: Add Baikal-T1 CCU Dividers driver")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> ---

Applied to clk-next
