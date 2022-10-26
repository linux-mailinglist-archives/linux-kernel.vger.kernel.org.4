Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3360E35E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiJZOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiJZOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:32:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B010F898
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:32:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h2so8855881pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntZLp7OVSmLd/Z9tfPE0dtDYBArbeZCUDytlptrIcAY=;
        b=ukHhbkDC6DOXtfdPDryQPu2tSw0ZRs83cKVWZ1T5QXY6hOWZuIKG4tFEDhnrEGIqr6
         b8brR1LtEL7CGvOv9VhxOKoEhJTNtJyPa+xHn2D7YouuG6DMAqhZ4pkm64MhuXtRuUgX
         e8vttbocs3MMmD/la2C5Wopob4hq4+kHWAfPImoyEIUM59ikC3qv7b1ZktG2xI+k8IfN
         8hw8AKxpHRsrMic7J92rzkeWFjlHeY3pBgZh1eM1+WikcwbbQyEZXez5YJqSpX2GnXzN
         j7Naa5ijVBqHfsib2FatH1Lj9MBrnQKY86pV6xaDtF7G7wWBwGbhTswoWIezU3TmLtr9
         101w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntZLp7OVSmLd/Z9tfPE0dtDYBArbeZCUDytlptrIcAY=;
        b=S4nBsfm9x5PzarVC6RBlZn6z2l+XWoZeG0DzteevY0ThjTgCP7QXTF3mpHypZXJaVG
         HmQuRFADH3EriUFQO4m7v11Ap24eWD8ylnSkh/LAkNniMMNuqOezeunHECXQKF3jboP1
         rMFVK5/FGoFzH4QC0onaVdlxJOcsSz0OVXZxsWLen6w8GXtZfsnpaZ4pmmqAGW2rJzGK
         kv5SXGfzXYHxTnpYUCSNlv/EZunNtyfQs3WnNzCfd4wGU/DMffqA6Ga31Imnk7LOy+t8
         tWTZvzDyIHiPx8y8rWIq/YypIVJHuS0LQicxmMAXzvgVwIwpDc9+vVR+aUwqVeoXQF2M
         bOAw==
X-Gm-Message-State: ACrzQf2w71RgLA+nwOwZTuLs1M5r6E1cLgs7aPkfQW8gxHfrPmiAvlsh
        b/vB1eoABVkQCSGy/46t83sk
X-Google-Smtp-Source: AMsMyM6SeK6JRTsCgrvuTLYxTBm7A+1WSmXUpZygONc4JZRDonnJRjpbmV0zfxWnha7urSXsWyrXFQ==
X-Received: by 2002:a63:5410:0:b0:46f:2a22:13ea with SMTP id i16-20020a635410000000b0046f2a2213eamr8947593pgb.487.1666794719788;
        Wed, 26 Oct 2022 07:31:59 -0700 (PDT)
Received: from thinkpad ([117.193.208.123])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b0017f9147983asm2982657plb.175.2022.10.26.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:31:58 -0700 (PDT)
Date:   Wed, 26 Oct 2022 20:01:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     vkoul@kernel.org, andersson@kernel.org, kishon@ti.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-pcie: Fix the SM8450 PCS registers
Message-ID: <20221026143152.GA93939@thinkpad>
References: <20220910063857.17372-1-manivannan.sadhasivam@linaro.org>
 <f6ab7125-4f1a-61fc-cfeb-8988921c35b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6ab7125-4f1a-61fc-cfeb-8988921c35b4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:06:10PM +0300, Dmitry Baryshkov wrote:
> On 10/09/2022 09:38, Manivannan Sadhasivam wrote:
> > In the PCS region, registers QPHY_V5_PCS_EQ_CONFIG4 and
> > QPHY_V5_PCS_EQ_CONFIG5 should be used instead of QPHY_V5_PCS_EQ_CONFIG2
> > and QPHY_V5_PCS_EQ_CONFIG3.
> > 
> > This causes high latency when ASPM is enabled, so fix it!
> 
> I have checked against vendor's tree [1]. The registers in question have
> offsets 0x01c0f3e0 / 0x01c0f3e4. The sm8450.dtsi uses 0x1c0f200 as the PCS
> region base for the PCIe PHY1. Thus the correct offsets for the table are
> 0x1e0/0x1e4.
> 
> There might be a mistake in the name of the register, but the address
> corresponds to the address in the vendor's tree.
> 

Right. Only the register name is wrong and I've got the offset wrong here.
But the actual latency issue is fixed by clearing the
QPHY_V4_PCS_PCIE_PRESET_P10_POST register in pcs_misc register space.

I will check with Qcom on this behaviour and post v2 with register name fix.

Thanks,
Mani

> [1] https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio-pcie.dtsi#L520
> 
> > 
> > Fixes: 2c91bf6bf290 ("phy: qcom-qmp: Add SM8450 PCIe1 PHY support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c   | 4 ++--
> >   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h | 4 ++--
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 4648467d5cac..b508903d77d0 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1332,8 +1332,8 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rx_tbl[] = {
> >   };
> >   static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
> > -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG2, 0x16),
> > -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG3, 0x22),
> > +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG4, 0x16),
> > +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x22),
> >   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_G3S2_PRE_GAIN, 0x2e),
> >   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x99),
> >   };
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> > index 61a44519f969..cca6455ec98c 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> > @@ -11,7 +11,7 @@
> >   #define QPHY_V5_PCS_G3S2_PRE_GAIN			0x170
> >   #define QPHY_V5_PCS_RX_SIGDET_LVL			0x188
> >   #define QPHY_V5_PCS_RATE_SLEW_CNTRL1			0x198
> > -#define QPHY_V5_PCS_EQ_CONFIG2				0x1e0
> > -#define QPHY_V5_PCS_EQ_CONFIG3				0x1e4
> > +#define QPHY_V5_PCS_EQ_CONFIG4				0x2e0
> > +#define QPHY_V5_PCS_EQ_CONFIG5				0x2e4
> >   #endif
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
