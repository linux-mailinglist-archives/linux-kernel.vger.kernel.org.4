Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F325EEE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiI2HMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiI2HMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ECB1323EA;
        Thu, 29 Sep 2022 00:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDAF162059;
        Thu, 29 Sep 2022 07:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51399C433C1;
        Thu, 29 Sep 2022 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664435517;
        bh=1bSwRpi6PmdpAopy29uDI4mnvtAn/D1FCSeWqhELdBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfWU5BFgB2zJvaNObw2joLGrnaFo4LE8Di6r5uciswvHSQ/hoc6FFRug9joR4b3V3
         gMC+MHv6RK5L6GgyFNmLAdNpugqjfnn4ZtyDiy0aonw3gm2CA/TaV6AhR8/d93eE9K
         b6fPnXbuUF7R54c5YAhUN+7JgHwNZnqiGm4gey+c+JNQSLWS5jEZ+qWiob4+eKTJbl
         4yrvDfgzPX8G1rePUtiL6tPSLZAvgxKXE+/wzp5DeOX46OgE7gABZtyp4Wr0juu4pg
         fWzxYj0ja+9WJkmReY1ZfILDheQe//xtCk83zNXZ+PBTICtzr7iZvcDfbFSdMp10FB
         wcktzp4l69erw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odniE-0006Tc-TO; Thu, 29 Sep 2022 09:12:03 +0200
Date:   Thu, 29 Sep 2022 09:12:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] phy: qcom-qmp-pcie: drop bogus register update
Message-ID: <YzVFQikkJmTDlg4U@hovoldconsulting.com>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-7-johan+linaro@kernel.org>
 <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
 <f9d0fb60-3e62-8f55-015e-88ca2e209323@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d0fb60-3e62-8f55-015e-88ca2e209323@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:48:40PM +0300, Dmitry Baryshkov wrote:
> On 28/09/2022 22:10, Dmitry Baryshkov wrote:
> > On 28/09/2022 18:28, Johan Hovold wrote:
> >> Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
> >> PHY is powered on before configuring the registers and only the MSM8996
> >> PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
> >> initialisation table, may possibly require a second update afterwards.
> >>
> >> To make things worse, the POWER_DOWN_CONTROL register lies at a
> >> different offset on more recent SoCs so that the second update, which
> >> still used a hard-coded offset, would write to an unrelated register
> >> (e.g. a revision-id register on SC8280XP).
> >>
> >> As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
> >> the bogus register update.
> >>
> >> Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for 
> >> sm8150 USB") added support
> > 
> > I'm not sure about the particular fixes tag. Backporting from the split 
> > driver into old qmp driver would be a complete pain.
> > 
> >> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> After digging some more, I stumbled upon the commit 0d58280cf1e6 ("phy: 
> Update PHY power control sequence"), which puts explicit register write 
> here, telling that 'PCIe PHYs need an extra power control before 
> deasserts reset state'.

That's the commit I'm referring to above.

> I can confirm this with the register tables from downstream dtsi. E.g. 
> consider sdm845-pcie.dts, pcie0 table. The PCS_POWER_DOWN_CONTROL is the 
> register 0x804.
> 
> The programmings starts with <0x804 0x1 0x0>, writing 1 to 
> PCS_POWER_DOWN_CONTROL (which if I'm not mistaken we do not do at this 
> moment). Then after writing all the serdes/tx/rx/pcs/pcs_misc tables 
> comes the write <0x804 0x3 0x0> (which you are trying to remove here).

The PHY would already have been powered on with the mainline driver, that
write has already happened.

Whether or not PCIe support for SDM845 has been broken since it was
first mainlined almost three years ago is a separate issue. I assume
Bjorn tested it before sending it upstream. 

	421c9a0e9731 ("phy: qcom: qmp: Add SDM845 PCIe QMP PHY support")

> Same sequence applies to the PCIe PHY on msm8998.
> 
> Most newer PHYs have the expected sequence (of writing 0x3 to 
> PCS_POWER_DOWN_CONTROL) before writing all registers.
> 
> As a short summary: unless we get any additional information that 8998 
> and sdm845 tables are incorrect, I'd suggest adding a conditional here 
> (ugh) and using it here and in qmp_pcie_init() call.

I see little point in doing that unless you dig out an SDM845, confirm
that it has never worked with upstream, and update the init sequence
first.

> Vinod, Bjorn, do you have any additional info?

An explanation of the split POWER_DOWN_CONTROL updates on MSM8996 would
be good to have either way.

Johan
