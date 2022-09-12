Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA135B57C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiILKEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiILKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A726562;
        Mon, 12 Sep 2022 03:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59BE761179;
        Mon, 12 Sep 2022 10:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A05C433D6;
        Mon, 12 Sep 2022 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662977044;
        bh=jeIqU9gxdUHpQpXNVjN4H1Box+OSo71A8j60K31ECjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8p1LztYG52KxD2UUiKnMSxtWarxKdyLqJco1iFjgc+AOkJ9EOBNtAa+pfIhZauzD
         3FdQrs4LVLVHw4psc3lhqakIwKfoUZynfnH8CLLEon0VcK057yl1oYDcwVY2nb+U5G
         fys+8zsXitNtdKJIZlMbw7SCMCYZeaJaiwGlWFlsQLyZqcNwkscnw37eYKUr8sxOF6
         lTQPB0aQU63QkOKCJIpq5ctjtlRLYqj3rh1JfRofXlyjYVxFfGzG8Haeowkt41yUbM
         mm0MkAAQYz3RM2/Cj0ff2cGapHyqPc2IAOLmDhWb1HWHFSXtcfD70i6jSrCY5Rqpqk
         y9TDFXseizR7Q==
Date:   Mon, 12 Sep 2022 18:03:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V9 0/6] imx: support i.MX93 SRC and mediamix blk ctrl
Message-ID: <20220912100358.GY1728671@dragon>
References: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:28:11AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V9:
>  Per Shawn's comments in patch 3:
>   License still keep GPL per ./Documentation/process/license-rules.rst
>   Sort header in patch 3
>   Update of_device_id variable to be driver specific
> 
>  Per Shawn's comments in patch 4:
>    Drop: Reported-by: kernel test robot
>    imx93-blk-ctrl.o in a separate line in Makefile
>    Move reg_access_table from imx93_blk_ctrl_domain_data to imx93_blk_ctrl_data
>    Drop 'const struct imx93_blk_ctrl_domain_data *bus', and add related fields in imx93_blk_ctrl_data 
>    Use genpd_xlate_onecell
>    Drop extra uneccesary domain allocation in probe
>    Align indent
>    License still keep GPL per ./Documentation/process/license-rules.rst
> 
>  Shawn:
>   patch 5, 6 may conflict with [1], because both patchsets are based on linux-next/master.
>   If this patchset goes fast, I could rebase [1].
>   If [1] goes fast, I could rebase patch 5, 6 in this patchset. But if the binding or driver is
>   good, I hope you could pick binding/driver first, I rebase patch 5,6 in a separate patch later.
> 
>   [1] https://lore.kernel.org/all/20220905055915.3878000-1-peng.fan@oss.nxp.com/
> 
> V8:
>  Fix error reported by kernel test robot
> 
> V7:
>  Added R-b for dt-bindings
>  Addressed Shawn's comments for patch 3, 4
>  Included NoC default settings in patch in patch 4
>  Use regmap access table to restrict the access to blk-ctrl register in patch 4
>  Update node name in patch 5, 6
> 
> V6:
>  Per Rob's comments to patch 1:
>   Drop the ref to power-domain.yaml
>   Describe each item of reg
>  Per Randy's comment, drop duplicated support in Kconfig
>  Per kernel test robot, use `void __iomem *` instead `void * __iomem`
>  not default select PM_GENERIC_DOMAINS for SOC_IMX9
> 
> V5:
>  Update bindings for SRC, remove the slices node
>    Although there are several mix-slices, mem-slices, but actually
>    they should work together, so I use one node to group a mix/mem with
>    dual reg entries.
>  Add SRC driver to include a driver to populate subnodes of SRC node
>  Restructure SRC-PD driver, because slices node dropped.
>  Drop the patch to export of_clk_bulk_get_all, which is not needed.
> 
>  https://lore.kernel.org/all/20220711062452.3575032-1-peng.fan@oss.nxp.com/
> 
> V4:
>  Correct including fsl,imx93-power.h, not imx93-power.h in driver
> 
> V3:
>   Move src yaml to power directory.
>   Update slice name to slices
> 
> V2:
>   yaml fix
> 
> This patchset is to support i.MX93 SRC and mediamix blk ctrl.
> SRC functions as power domain provider as i.MX8M GPC.
> mediamix blk ctrl is similar with i.MX8M blk ctrl, but much simplier from
> software view.
> 
> Add bindings and dts node
> 
> Peng Fan (6):
>   dt-bindings: soc: add i.MX93 SRC
>   dt-bindings: soc: add i.MX93 mediamix blk ctrl
>   soc: imx: add i.MX93 SRC power domain driver
>   soc: imx: add i.MX93 media blk ctrl driver
>   arm64: dts: imx93: add src node
>   arm64: dts: imx93: add mediamix blk ctrl node

Applied all, thanks!
