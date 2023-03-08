Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9426B0541
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCHLCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCHLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:01:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6EDB4201;
        Wed,  8 Mar 2023 03:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDE861760;
        Wed,  8 Mar 2023 11:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311E2C433D2;
        Wed,  8 Mar 2023 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678273313;
        bh=tS9tmSwCiCb5Gj7uPqDRGFFYeZ7A5dLeyFKgap0zzuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMfX0sW3iJt8hkidpnTtasIdXfvgQhFiwmwRvHf+AEvlcP53j0zEeGcQVYUDbbJDc
         tH94Qov0LYPeIrgbvpO87XFD4j+JOppbuvHymSaFYdUzMqEW89yS0Cj2amM5ZVfErV
         P7k60e0NKUq+DjoWBau93zKM/bPTL8Qw69BTuqp/MWDZDbJqlc/sHS25ze1FvWuE9H
         ylhqpg2oX6F02fcIMF7AzoQwG8TZcEeRp8E8T0PIUB5nZKmWjXgKMDfW1zlPyjWqOw
         Z/GwZallNZxsL3JpkGzPwwXF1Dfs1yf11qQVH9Ns33ZrkYBk1TeL/DLG2ELezbcnjT
         ySnFnjBbCvAkg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZrZ9-0005wP-1P; Wed, 08 Mar 2023 12:02:39 +0100
Date:   Wed, 8 Mar 2023 12:02:39 +0100
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
Message-ID: <ZAhrT1ICTQjfdeGq@hovoldconsulting.com>
References: <20230306170817.3806-1-they@mint.lgbt>
 <20230306170817.3806-4-they@mint.lgbt>
 <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:09:48AM +0100, Konrad Dybcio wrote:
> 
> 
> On 6.03.2023 18:08, Lux Aliaga wrote:
> > The SM6125 UFS PHY is compatible with the one from SM6115. Add a
> > compatible for it and modify the config from SM6115 to make them
> > compatible with the SC8280XP binding
> > 
> > Signed-off-by: Lux Aliaga <they@mint.lgbt>
> > Reviewed-by: Martin Botka <martin.botka@somainline.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > index 318eea35b972..44c29fdfc551 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > @@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] = {
> >  	"vdda-phy", "vdda-pll",
> >  };
> >  
> > +static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 = {
> > +	.serdes		= 0,
> > +	.pcs		= 0xc00,
> > +	.tx		= 0x400,
> > +	.rx		= 0x600,
> > +};
> > +
> >  static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
> >  	.serdes		= 0,
> >  	.pcs		= 0xc00,
> > @@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> >  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
> >  	.lanes			= 1,
> >  
> > +	.offsets		= &qmp_ufs_offsets_v3_660,
> Will this not trigger OOB r/w for the users of qcom,sm6115-smp-ufs-phy
> which specify the regions separately (old binding style)?

No, that should work fine.

But looks like this series needs to be rebased on 6.3-rc1 as these
offsets are now already set in mainline.

Johan
