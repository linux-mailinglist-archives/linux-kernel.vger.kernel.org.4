Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460060F04C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiJ0Gbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiJ0GbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:31:12 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6171D16252D;
        Wed, 26 Oct 2022 23:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666852262; x=1698388262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nKoamIA8wUbcHKiEZbUCm28Kcvfx9jQu3oj0e+ov70w=;
  b=OPDu8juHpHnDd/pt7n8p0UAlLfv9Cg6HLfbfl71duI+LHKCrZNe0Ncae
   qepcC6u1IMPvbugmFrKio7jxPce4ub2thNJ9sWzU1qftTbHQgYlmJbJkk
   TnJwBpsP8ZAcqO+LTsoGDm3gUMSN8RD/680j4uA+v7etWFWOX3SYyEQ2r
   Odi8HsMCb5vuKcGJD94ZfYw9loyQlZf/YhMQ58viFeoOcQ2Tt9z1OflqX
   Uka7yboQUhYjvRjL18AiEvPuw4IvINudidvbQqZi3UzYZMybzXAURtlhP
   I14GOwV5jiLbkF39T2WC4CppXmRWfrH+EEMJA9PiWmy7UYk493g/CUkSf
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661810400"; 
   d="scan'208";a="27000477"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Oct 2022 08:30:59 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Oct 2022 08:30:59 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Oct 2022 08:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666852259; x=1698388259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nKoamIA8wUbcHKiEZbUCm28Kcvfx9jQu3oj0e+ov70w=;
  b=dpIIzne24/4fXnib6g1gT+ey5C/OoEqngXd1aR2YkOU0IHVlxqpp7OXs
   yT2zeGmojx28bg8zPPvsGlXiq9VzPGzni4TBMwOfah6GcncGF/TScU1b8
   BMNzjTGaO9OvmhV4kGpyWQaUErtrpVTD4x07E+ZrvOvXajEc23aawZxCj
   siefY6PUEkTk+r9gmP2UVe73LglBU94T1EIntbLNNmo7dFw65bxEEvjZg
   cG/K7QmAw0Jb1Obosr/rcV68YWMSaafIAoUWHTojve+E5bj9zN1fFBoDj
   5w5mIYQmxc4zxMIF198p1jof5HGRd/0d3CQmujumurqwAe85qmN868sVl
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661810400"; 
   d="scan'208";a="27000476"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Oct 2022 08:30:59 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5B39E280056;
        Thu, 27 Oct 2022 08:30:59 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     shengjiu.wang@gmail.com
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/2] clk: imx8mp: Add audio shared gate
Date:   Thu, 27 Oct 2022 08:30:55 +0200
Message-ID: <12087191.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1666834442-5609-2-git-send-email-shengjiu.wang@nxp.com>
References: <1666834442-5609-1-git-send-email-shengjiu.wang@nxp.com> <1666834442-5609-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 27. Oktober 2022, 03:34:02 CEST schrieb Shengjiu Wang:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> According to the RM, the CCGR101 is shared for the following root clocks:
> - AUDIO_AHB_CLK_ROOT
> - AUDIO_AXI_CLK_ROOT
> - SAI1_CLK_ROOT
> - SAI2_CLK_ROOT
> - SAI3_CLK_ROOT
> - SAI5_CLK_ROOT
> - SAI6_CLK_ROOT
> - SAI7_CLK_ROOT
> - PDM_CLK_ROOT
> 
> And correct clock MX8MP_CLK_AUDIO_ROOT to be IMX8MP_CLK_AUDIO_AHB_ROOT.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - split dt-binding to separate patch
> 
>  drivers/clk/imx/clk-imx8mp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 652ae58c2735..0ae3bc7bf8a1 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -17,6 +17,7 @@
> 
>  static u32 share_count_nand;
>  static u32 share_count_media;
> +static u32 share_count_audio;
> 
>  static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy",
> "dummy", }; static const char * const audio_pll1_bypass_sels[] =
> {"audio_pll1", "audio_pll1_ref_sel", }; @@ -699,7 +700,15 @@ static int
> imx8mp_clocks_probe(struct platform_device *pdev) hws[IMX8MP_CLK_HDMI_ROOT]
> = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
> hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk",
> "ipg_root", ccm_base + 0x4620, 0); hws[IMX8MP_CLK_VPU_ROOT] =
> imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
> -	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk",
> "audio_ahb", ccm_base + 0x4650, 0); +	hws[IMX8MP_CLK_AUDIO_AHB_ROOT] =
> imx_clk_hw_gate2_shared2("audio_ahb_root", "audio_ahb", ccm_base + 0x4650,
> 0, &share_count_audio); +	hws[IMX8MP_CLK_AUDIO_AXI_ROOT] =
> imx_clk_hw_gate2_shared2("audio_axi_root", "audio_axi", ccm_base + 0x4650,
> 0, &share_count_audio); +	hws[IMX8MP_CLK_SAI1_ROOT] =
> imx_clk_hw_gate2_shared2("sai1_root", "sai1", ccm_base + 0x4650, 0,
> &share_count_audio); +	hws[IMX8MP_CLK_SAI2_ROOT] =
> imx_clk_hw_gate2_shared2("sai2_root", "sai2", ccm_base + 0x4650, 0,
> &share_count_audio); +	hws[IMX8MP_CLK_SAI3_ROOT] =
> imx_clk_hw_gate2_shared2("sai3_root", "sai3", ccm_base + 0x4650, 0,
> &share_count_audio); +	hws[IMX8MP_CLK_SAI5_ROOT] =
> imx_clk_hw_gate2_shared2("sai5_root", "sai5", ccm_base + 0x4650, 0,
> &share_count_audio); +	hws[IMX8MP_CLK_SAI6_ROOT] =
> imx_clk_hw_gate2_shared2("sai6_root", "sai6", ccm_base + 0x4650, 0,
> &share_count_audio); +	hws[IMX8MP_CLK_SAI7_ROOT] =
> imx_clk_hw_gate2_shared2("sai7_root", "sai7", ccm_base + 0x4650, 0,
> &share_count_audio); +	hws[IMX8MP_CLK_PDM_ROOT] =
> imx_clk_hw_gate2_shared2("pdm_root", "pdm", ccm_base + 0x4650, 0,
> &share_count_audio);
> 
>  	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
>  					     
hws[IMX8MP_CLK_A53_CORE]->clk,

Now IMX8MP_CLK_AUDIO_ROOT is unused. Should it be removed? Or should the 
rename be done in a separate commit before this one?

Best regards,
Alexander



