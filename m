Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C376B05E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCHLXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCHLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:23:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5852F53;
        Wed,  8 Mar 2023 03:23:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E98361772;
        Wed,  8 Mar 2023 11:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933C5C433EF;
        Wed,  8 Mar 2023 11:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678274591;
        bh=lMPpkylPih+gy/b/v4XZysVk95zUNxYI8bo+VtztrZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkgjf1EQvUt5FjrEuNuomhNhpSaCCooerbZEZml6QuiXSvFMR3sAVmYgMWyX6kNdU
         Vdjr7m1XlPW19xw6J5fJVNG8b3TF3O0Z/OLtBa2vxkgTwMHQhgeh4IcOHahENpHl32
         I80t5ym8NriBoVN3AZXsB6r0mKpQGk2lqAA8Y8xb48z0iidqtOx1kIEp2x+leqTdnN
         6/ixzX8Y01jf9+1D2uWG2+lfUVmPC5jG1MYKDK29nCUteOdyaH1tZrOyjXPCHjecl0
         DExeRfqSzlRmMN8l0gSR7zrsrF/1nu5g8496nbuPX6ocgtSrwPcjJfCfZneZ5WptQl
         G5Hz/UELPaqfw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZrtl-000645-HA; Wed, 08 Mar 2023 12:23:57 +0100
Date:   Wed, 8 Mar 2023 12:23:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
Subject: Re: [PATCH v7 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
Message-ID: <ZAhwTcMZoCQVULQe@hovoldconsulting.com>
References: <20230306170817.3806-1-they@mint.lgbt>
 <20230306170817.3806-4-they@mint.lgbt>
 <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org>
 <ZAhrT1ICTQjfdeGq@hovoldconsulting.com>
 <64ab4061-6a8b-662e-1c7a-99b0da26751c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ab4061-6a8b-662e-1c7a-99b0da26751c@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:15:39PM +0100, Konrad Dybcio wrote:
> 
> 
> On 8.03.2023 12:02, Johan Hovold wrote:
> > On Wed, Mar 08, 2023 at 11:09:48AM +0100, Konrad Dybcio wrote:
> >>
> >>
> >> On 6.03.2023 18:08, Lux Aliaga wrote:
> >>> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
> >>> compatible for it and modify the config from SM6115 to make them
> >>> compatible with the SC8280XP binding
> >>>
> >>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> >>> Reviewed-by: Martin Botka <martin.botka@somainline.org>
> >>> ---
> >>>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 12 ++++++++++++
> >>>  1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>> index 318eea35b972..44c29fdfc551 100644
> >>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> >>> @@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] = {
> >>>  	"vdda-phy", "vdda-pll",
> >>>  };
> >>>  
> >>> +static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 = {
> >>> +	.serdes		= 0,
> >>> +	.pcs		= 0xc00,
> >>> +	.tx		= 0x400,
> >>> +	.rx		= 0x600,
> >>> +};
> >>> +
> >>>  static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
> >>>  	.serdes		= 0,
> >>>  	.pcs		= 0xc00,
> >>> @@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> >>>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
> >>>  	.lanes			= 1,
> >>>  
> >>> +	.offsets		= &qmp_ufs_offsets_v3_660,
> >> Will this not trigger OOB r/w for the users of qcom,sm6115-smp-ufs-phy
> >> which specify the regions separately (old binding style)?
> > 
> > No, that should work fine.
> So do you think the SM6115 binding could be updated too? Or should
> we keep it as-is for ABI purposes?..

They could be and the possibility has been raised. I think it may be
more important to convert the old combo-phy binding (it's on my list,
but I keep getting preempted), but at some point we can get rid of the
legacy UFS binding as well.

> > But looks like this series needs to be rebased on 6.3-rc1 as these
> > offsets are now already set in mainline.
> ..Or did you do that already and I can't find it?

It seems a previous version of this patch was merged almost two months
ago.

	9b9e29af984c ("phy: qcom-qmp: Add SM6125 UFS PHY support")

Not sure what failed here.

Johan
