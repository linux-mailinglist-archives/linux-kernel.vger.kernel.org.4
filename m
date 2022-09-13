Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D285B6BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiIMKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIMKaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:30:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074412127A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:30:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oY3B0-0004De-Db; Tue, 13 Sep 2022 12:29:58 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oY3Az-0001xh-BK; Tue, 13 Sep 2022 12:29:57 +0200
Date:   Tue, 13 Sep 2022 12:29:57 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 0/2] clk: imx: introduce fsl,always-on-clocks
Message-ID: <20220913102957.sir37bsdr5sayxal@pengutronix.de>
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
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

Hi Peng,

On 22-09-13, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V3:
>  Rename to fsl,always-on-clocks 
> 
> V2:
>  Use protected-clocks
>  https://lore.kernel.org/all/20220816130327.2987710-1-peng.fan@oss.nxp.com/
> 
> V1:
>  Use fsl,protected-clocks
>  https://lore.kernel.org/all/20220815033632.1687854-1-peng.fan@oss.nxp.com/
> 
> There are two cases that I wanna this property could serve:
> Virtualization: root cell linux run in parallel with inmate cell
> AMP: M7/4 runs in parallel with A53
> 
> The major case is:
> Jailhouse hypervisor only support partition, so devices are partitioned.
> But there is only CCM module that provides clock, the CCM is handled by
> root cell linux, need make sure the root cell linux not shutdown the
> clocks using by inmate cell.
> 
> I was thinking whether need to provide a rate entry to ask root cell
> configure the clk rate for inmate cell. But NXP downstream not have it,
> see https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/clk/imx/clk-imx8mp.c?h=lf-5.15.y#n690
> So just leave the property as uint32-array.

Can you please check my recent proposal? I recently stumbled over such
an issue on the mx8mm-evk as well but with the 32k clock provided by the
pmic. Unfortunately I forgot to add you to the to list, I will change
that. If that proposal will fix your problem, I would like to go the
generic way.

https://patchwork.kernel.org/project/linux-clk/list/?series=676522

Regards,
  Marco


> 
> This patchset could also benifit AMP case, check the two commits
> commit 19565ea12d61 ("clk: imx: add mcore_booted module paratemter")
> commit d097cc045b64 ("clk: imx8mp: remove SYS PLL 1/2 clock gates")
> Although I not plan to drop the upper two patches, this patchset
> exposes opportunity for better power consumption.
> 
> Peng Fan (2):
>   dt-bindings: clock: imx8m/imx93: introduce fsl,always-on-clocks
>     property
>   clk: imx: support fsl,always-on-clocks
> 
>  .../bindings/clock/imx8m-clock.yaml           |  4 ++++
>  .../bindings/clock/imx93-clock.yaml           |  4 ++++
>  drivers/clk/imx/clk-imx8mm.c                  |  2 ++
>  drivers/clk/imx/clk-imx8mn.c                  |  2 ++
>  drivers/clk/imx/clk-imx8mp.c                  |  2 ++
>  drivers/clk/imx/clk-imx8mq.c                  |  2 ++
>  drivers/clk/imx/clk.c                         | 21 +++++++++++++++++++
>  drivers/clk/imx/clk.h                         |  2 ++
>  8 files changed, 39 insertions(+)
> 
> -- 
> 2.37.1
> 
> 
> 
