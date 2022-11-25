Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F546386EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKYKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKYKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A868B11C2E;
        Fri, 25 Nov 2022 02:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30CB8622E7;
        Fri, 25 Nov 2022 10:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AB3C433C1;
        Fri, 25 Nov 2022 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669370490;
        bh=1BTs+/wgO83xZVv9nOmE5ndF0fwtJT85UEdx9USU+hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HD5EzQPSOXQnpT0nFCX/1rwJh0PiS6JvvRRNbnBbv8M+kLQfrvSrMufPeeYN92n4Q
         AQOpTdvwlWRmjL3f0gdSsEBqKbgsOD+99zKW3xomHIqQfVFsrZ0eIasEMOx6GDJ600
         UHZjNBhA95DTzQpno99Pnhk+eEcgBOJkhF+Ar81qqu8noz6MGy+gIBn9q24/Q/1UTQ
         cX/vVcgTuqA933uAez39gRdPmzFsoyPKXhgvk2tADnues7RbLecoNm1yPCL5pxWwlv
         sm2SosDy+BvcDcUIKMU/frwpbMUGBb6BmSYABuaTloK9heIK8cUKgW6zefW3l599OW
         nqrxRKbHGPzZg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyVW5-0002IL-6C; Fri, 25 Nov 2022 11:01:05 +0100
Date:   Fri, 25 Nov 2022 11:01:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] phy: qcom-qmp-combo: Add config for SM6350
Message-ID: <Y4CSYZE+3fZCV4Z3@hovoldconsulting.com>
References: <20221125092749.46073-1-luca.weiss@fairphone.com>
 <20221125092749.46073-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125092749.46073-2-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:27:48AM +0100, Luca Weiss wrote:
> Add the tables and config for the combo phy found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> @Johan Hovold, here I've added dp_txa & dp_txb, I believe otherwise
> qmp->dp_tx would be wrong. Is this different on sc8280xp or was this a
> mistake on your side? I think this should probably be split out to
> another patch to not mix things up too much.

Yeah, that's a difference in sc8280xp which does not have dedicated TX
registers for DP.

This is probably best handled explicitly when parsing the DT by using
dp_txa/b if they are set and otherwise fallback to txa/txb (e.g.
instead of hiding it in the v5 table by using the same offset in two
places).

It can be done as part of this patch as long as you mention it in the
commit message.

> I think other than that this patch is good.

Indeed, looks good! Nice to see this working out as intended also for
the older platforms.

>  static const struct qmp_phy_init_tbl sm8150_usb3_serdes_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
>  	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
> @@ -809,6 +873,8 @@ struct qmp_combo_offsets {
>  	u16 usb3_pcs;
>  	u16 usb3_pcs_usb;
>  	u16 dp_serdes;
> +	u16 dp_txa;
> +	u16 dp_txb;
>  	u16 dp_dp_phy;
>  };
>  
> @@ -975,6 +1041,21 @@ static const char * const sc7180_usb3phy_reset_l[] = {
>  	"phy",
>  };
>  
> +static const struct qmp_combo_offsets qmp_combo_offsets_v3 = {
> +	.com		= 0x0000,
> +	.txa		= 0x1200,
> +	.rxa		= 0x1400,
> +	.txb		= 0x1600,
> +	.rxb		= 0x1800,
> +	.usb3_serdes	= 0x1000,
> +	.usb3_pcs_misc	= 0x1a00,
> +	.usb3_pcs	= 0x1c00,
> +	.dp_serdes	= 0x2000,
> +	.dp_txa		= 0x2200,
> +	.dp_txb		= 0x2600,
> +	.dp_dp_phy	= 0x2c00,
> +};
> +
>  static const struct qmp_combo_offsets qmp_combo_offsets_v5 = {
>  	.com		= 0x0000,
>  	.txa		= 0x0400,

> @@ -2641,8 +2767,8 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
>  	qmp->pcs_usb = base + offs->usb3_pcs_usb;
>  
>  	qmp->dp_serdes = base + offs->dp_serdes;
> -	qmp->dp_tx = base + offs->txa;
> -	qmp->dp_tx2 = base + offs->txb;
> +	qmp->dp_tx = base + offs->dp_txa;
> +	qmp->dp_tx2 = base + offs->dp_txb;
>  	qmp->dp_dp_phy = base + offs->dp_dp_phy;
>  
>  	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");

Johan
