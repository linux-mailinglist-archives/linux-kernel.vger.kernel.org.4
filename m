Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0128A6EF94F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbjDZRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbjDZRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:24:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151D7ED3;
        Wed, 26 Apr 2023 10:24:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 797F5D8B;
        Wed, 26 Apr 2023 19:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682529828;
        bh=WUk0APxVNyvXba+udS2MEf5FyWxxyD2hm4F9XspRCRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZ0V/TRv2bsp/xF8y8yNukpM2mYC8PLuvpAeisY0GocPR320nFuxYwkZGuq25s6nl
         nWICcxqPVRRcoEOtOFw5gbUCftx8pq8JrZQ/jnjaPRomdtL+tpaN2hHegCldgRouM9
         /Ue363ZW/wFYZJRXfCYbJJ/k81c/zIUs3+Vep5CE=
Date:   Wed, 26 Apr 2023 20:24:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
Message-ID: <20230426172410.GC2326@pendragon.ideasonboard.com>
References: <ZElaVmxDsOkZj2DK@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZElaVmxDsOkZj2DK@debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On Wed, Apr 26, 2023 at 06:07:34PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build xtensa, mips, arm allmodconfig
> with the error:
> 
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_inbuf':
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:33:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    33 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_outbuf':
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:51:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    51 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:66:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    66 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> git bisect pointed to cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> 
> I will be happy to test any patch or provide any extra log if needed.

This issue has been fixed already, the fixes are available in the master
branch of git://linuxtv.org/media_stage.git:

e49b1e1958b4 media: nxp: ignore unused suspend operations
9829ed20b019 media: nxp: imx8-isi: fix buiding on 32-bit

Mauro, can you please include those two fixes in your next pull request
for v6.4 ?

-- 
Regards,

Laurent Pinchart
