Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD366C246
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjAPOem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjAPOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:34:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4815B25E29
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:14:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v6so40824877edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxWXmWcLQ+ZIknAtpo/VTrs5PfqFx9sefku166Jyecw=;
        b=lG2jWb+J5HLvrWszvvybXPjb7IPaErSAiwIUBVWb5qlcA3I8+l6J0mmbat/04JWP0E
         UrRKrpCVDgDq2VCdHtDOnzuRSLtthlJ6JtAyZNA+LqpF/gUMH1BV9WqMwFdVVGgOhxCv
         wgMNLiti//slLJWlUiF1wZmOvosdEde6WHcR5zoXYppXGMj9sMcchC6Y8KPcsUCYLTbx
         iKPwej56sTot2iQVIEeFaCskeJV2VJACzJGr/qpnhjMJ9+9ZTSsjk09NdoV1et3xIvDx
         nCTVfBlkGt9cMWCifaek42Mi8aSdMb+q2HQu9CXB3dcL6+mXz9DIURyP3xCdfOYrXncG
         tQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxWXmWcLQ+ZIknAtpo/VTrs5PfqFx9sefku166Jyecw=;
        b=qsNaKPFVGjt1wGtXWjCxS4eM66cvn7pnWe9zCHBVbFjHN7DS7w8VtHRTT8Bjn6Zdov
         rB37nkGY/NlMM4WaBauRLpEfTSTDV+VSopeHSlXwiM8yAYsCMyjEjsgHvdFY+KlfX6oZ
         KyaBUB3v12xepqmACpvFID+Bj+nIsYYjenEXsuRHblu1hkjdYQmvBv7D2JP4lYAaWgyg
         gQwD8jCj4mWxVekPvOyufgcgIH4k24m3zG5qkQTLnpv5aQXvBf3cDptO8qbmT3a/n5T8
         RGmWb0Qp1mRCCWiFcSJNo0nAZjZY7OXoFqnrADvL3jUrdzbiUvAwfKOvlHLkgYoC7tPO
         wo7w==
X-Gm-Message-State: AFqh2koqL0FA/e2m7O8Ab9Ipk4QWXKf+As5MCHfZE7S/laJ/ALUK1zFW
        5Qeyv40/ObcUGyJ1zKot1DMoUA==
X-Google-Smtp-Source: AMrXdXtKQkmYiR8b4sgoBLLQVNlMUBW4jlnwYSbaHNAIN+T0Fhw2pI/kQSEyKvuC2H5sGY6b5pBcRA==
X-Received: by 2002:a50:cc4c:0:b0:463:e2cd:a8b5 with SMTP id n12-20020a50cc4c000000b00463e2cda8b5mr81548431edi.11.1673878496707;
        Mon, 16 Jan 2023 06:14:56 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7d3c7000000b0045bd14e241csm11586818edr.76.2023.01.16.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 06:14:56 -0800 (PST)
Date:   Mon, 16 Jan 2023 16:14:54 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     mani@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] phy: qcom-qmp-ufs: Add SM8550 support
Message-ID: <Y8Vb3jBR2AtAJlWQ@linaro.org>
References: <20230112130542.1399921-1-abel.vesa@linaro.org>
 <20230112130542.1399921-7-abel.vesa@linaro.org>
 <Y8GkZKwvOc5nPSjI@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GkZKwvOc5nPSjI@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-14 00:05:16, Vinod Koul wrote:
> On 12-01-23, 15:05, Abel Vesa wrote:
> > Add SM8550 specific register layout and table configs.
> 
> Not related, but was this tested with the UFS Gear 4 support from Mani?
> It would be great to have that added (here or separately)

I mentioned both Mani's and Dmitry's patchsets in the cover letter.
This patchset is based on both those patchsets.

> 
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 100 ++++++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > index 5936a3a05002..a9b666f32f59 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > @@ -95,6 +95,13 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
> >  	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
> >  };
> >  
> > +static const unsigned int sm8550_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
> > +	[QPHY_START_CTRL]		= QPHY_V6_PCS_UFS_PHY_START,
> > +	[QPHY_PCS_READY_STATUS]		= QPHY_V6_PCS_UFS_READY_STATUS,
> > +	[QPHY_SW_RESET]			= QPHY_V6_PCS_UFS_SW_RESET,
> > +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL,
> > +};
> > +
> >  static const struct qmp_phy_init_tbl msm8996_ufsphy_serdes[] = {
> >  	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
> >  	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
> > @@ -599,6 +606,61 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_g4_pcs[] = {
> >  	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
> >  };
> >  
> > +static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0xd9),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
> > +};
> > +
> > +static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x05),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
> > +};
> > +
> > +static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0f),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
> > +
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3, 0x1a),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6, 0x60),
> > +
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B3, 0x9e),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B6, 0x60),
> > +
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B3, 0x9e),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B4, 0x0e),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B5, 0x36),
> > +	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
> > +};
> > +
> > +static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
> > +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
> > +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
> > +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> > +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
> > +	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> > +};
> > +
> >  struct qmp_ufs_offsets {
> >  	u16 serdes;
> >  	u16 pcs;
> > @@ -703,6 +765,10 @@ static const char * const sm8450_ufs_phy_clk_l[] = {
> >  	"qref", "ref", "ref_aux",
> >  };
> >  
> > +static const char * const sm8550_ufs_phy_clk_l[] = {
> > +	"qref", "ref",
> > +};
> > +
> >  static const char * const sdm845_ufs_phy_clk_l[] = {
> >  	"ref", "ref_aux",
> >  };
> > @@ -721,6 +787,15 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
> >  	.rx2		= 0xa00,
> >  };
> >  
> > +static const struct qmp_ufs_offsets qmp_ufs_offsets_v6 = {
> > +	.serdes		= 0,
> > +	.pcs		= 0x400,
> > +	.tx		= 0x1000,
> > +	.rx		= 0x1200,
> > +	.tx2		= 0x1800,
> > +	.rx2		= 0x1a00,
> > +};
> > +
> >  static const struct qmp_phy_cfg msm8996_ufsphy_cfg = {
> >  	.lanes			= 1,
> >  
> > @@ -958,6 +1033,28 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
> >  	.regs			= sm8150_ufsphy_regs_layout,
> >  };
> >  
> > +static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
> > +	.lanes			= 2,
> > +
> > +	.offsets		= &qmp_ufs_offsets_v6,
> > +
> > +	.tbls = {
> > +		.serdes		= sm8550_ufsphy_serdes,
> > +		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_serdes),
> > +		.tx		= sm8550_ufsphy_tx,
> > +		.tx_num		= ARRAY_SIZE(sm8550_ufsphy_tx),
> > +		.rx		= sm8550_ufsphy_rx,
> > +		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_rx),
> > +		.pcs		= sm8550_ufsphy_pcs,
> > +		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_pcs),
> > +	},
> > +	.clk_list		= sm8550_ufs_phy_clk_l,
> > +	.num_clks		= ARRAY_SIZE(sm8550_ufs_phy_clk_l),
> > +	.vreg_list		= qmp_phy_vreg_l,
> > +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> > +	.regs			= sm8550_ufsphy_regs_layout,
> > +};
> > +
> >  static void qmp_ufs_configure_lane(void __iomem *base,
> >  					const struct qmp_phy_init_tbl tbl[],
> >  					int num,
> > @@ -1467,6 +1564,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
> >  	}, {
> >  		.compatible = "qcom,sm8450-qmp-ufs-phy",
> >  		.data = &sm8450_ufsphy_cfg,
> > +	}, {
> > +		.compatible = "qcom,sm8550-qmp-ufs-phy",
> > +		.data = &sm8550_ufsphy_cfg,
> >  	},
> >  	{ },
> >  };
> > -- 
> > 2.34.1
> 
> -- 
> ~Vinod
