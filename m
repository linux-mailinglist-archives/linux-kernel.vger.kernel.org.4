Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57295B6C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiIMLtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiIMLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:49:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1580EA45F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:49:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oY4Pw-0006hk-LP; Tue, 13 Sep 2022 13:49:28 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oY4Pv-00060G-Pj; Tue, 13 Sep 2022 13:49:27 +0200
Date:   Tue, 13 Sep 2022 13:49:27 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 0/2] clk: imx: introduce fsl,always-on-clocks
Message-ID: <20220913114927.an5n5cv5tzd3lypc@pengutronix.de>
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
 <20220913102957.sir37bsdr5sayxal@pengutronix.de>
 <c6d4fb3e-9907-cda2-90d8-cfa21e8ebd41@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d4fb3e-9907-cda2-90d8-cfa21e8ebd41@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-13, Krzysztof Kozlowski wrote:
> On 13/09/2022 12:29, Marco Felsch wrote:
> > Hi Peng,
> > 
> > On 22-09-13, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> V3:
> >>  Rename to fsl,always-on-clocks 
> >>
> >> V2:
> >>  Use protected-clocks
> >>  https://lore.kernel.org/all/20220816130327.2987710-1-peng.fan@oss.nxp.com/
> >>
> >> V1:
> >>  Use fsl,protected-clocks
> >>  https://lore.kernel.org/all/20220815033632.1687854-1-peng.fan@oss.nxp.com/
> >>
> >> There are two cases that I wanna this property could serve:
> >> Virtualization: root cell linux run in parallel with inmate cell
> >> AMP: M7/4 runs in parallel with A53
> >>
> >> The major case is:
> >> Jailhouse hypervisor only support partition, so devices are partitioned.
> >> But there is only CCM module that provides clock, the CCM is handled by
> >> root cell linux, need make sure the root cell linux not shutdown the
> >> clocks using by inmate cell.
> >>
> >> I was thinking whether need to provide a rate entry to ask root cell
> >> configure the clk rate for inmate cell. But NXP downstream not have it,
> >> see https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/clk/imx/clk-imx8mp.c?h=lf-5.15.y#n690
> >> So just leave the property as uint32-array.
> > 
> > Can you please check my recent proposal? I recently stumbled over such
> > an issue on the mx8mm-evk as well but with the 32k clock provided by the
> > pmic. Unfortunately I forgot to add you to the to list, I will change
> > that. If that proposal will fix your problem, I would like to go the
> > generic way.
> > 
> > https://patchwork.kernel.org/project/linux-clk/list/?series=676522
> 
> Your proposal does not change bindings. You cannot introduce new
> properties without documenting them in the bindings.

As said, it is a proposal. Bindings will be added if it would be
accepted.

Regards,
  Marco
