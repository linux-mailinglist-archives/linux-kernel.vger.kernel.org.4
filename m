Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C85E613976
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiJaO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiJaO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:56:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA861114C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:56:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g62so10880099pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qfRWCQkOBm2MxnVgDK5v0Vn9xRjDYCGceLE5mq8RAWI=;
        b=stVuBKmZrU7+ei+AFFBE+eKP4PINriYNYY5RsQGv1tc+A6WJ/s7pAKdcc7QZYF4+XO
         QWS2lLzveBESkZroA6tZEavUJE03g62quWyzPY0QbB9S9Fn4ePHiMyvv7qiHILct2ilD
         +dmu15gA+VXLxciUsRlhZw65iOYkZ6Lk8j36WixjIHf+1eqf+RajjtP3DfofZztb2SQc
         0tBimU3mNeMZKv1ZT0LOkiQcQA9AY5OIQscOmqH2B3+LT8oxNq75BZKMlT3L6gep76Uv
         NQGPc+iBjB+3bAG7L9vnZBqtR9QbTby81m4+c1vAT3Ir6uWvpVrzAMV800H5ZUQjoymv
         KBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfRWCQkOBm2MxnVgDK5v0Vn9xRjDYCGceLE5mq8RAWI=;
        b=CPQ+cyvNlH6LZDJQHRMe3QxLRJIG7LEOqbd5SKlu3IHHzg/u4VpsvpK1YjL1abfy3T
         bEXTRuk7jn8Ybr6UuKhykc+yVaOcka9hv03bwHKNegY5cH09K+ArirknCsNsXdN+jWDJ
         UiDuTBAc6mPPQo5MD2npuU6MyzbZGMoSBT2tWLDQiO+ZKMsVOVHPupWNvvAiOaZ10IlH
         neOEds4Hqkfu/kyNEYktw71vxIyaEH7TIr2uTkrczWYDCEiKas9cn1CshFnySondlfUK
         Oglv9kBQ75BJStHcHwQ5mTsCibRHdjJ2774VAKh1kcPp0vzpbxyQ4m+LQ6tb2SIFcZK4
         gHIA==
X-Gm-Message-State: ACrzQf36Db558t+MMvEGXBUtRgyNZZI1Zwp0QATAGThKupCMRLQgEc7V
        RtY8f9TKdFWnWQpIwBBcAX7Q
X-Google-Smtp-Source: AMsMyM7SHU/9duW/QueVKxebwPeGGo51l3TZSSc9aXZpBWMnn19DzLxyNQfHIvbOJuiSkwcMuVYOrw==
X-Received: by 2002:a05:6a00:230f:b0:53e:2c2c:5c03 with SMTP id h15-20020a056a00230f00b0053e2c2c5c03mr14699448pfh.11.1667228216041;
        Mon, 31 Oct 2022 07:56:56 -0700 (PDT)
Received: from thinkpad ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a414c00b002135fdfa995sm4235595pjg.25.2022.10.31.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:56:54 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:26:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 14/15] scsi: ufs: ufs-qcom: Add support for finding HS
 gear on new UFS versions
Message-ID: <20221031145647.GC10515@thinkpad>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-15-manivannan.sadhasivam@linaro.org>
 <cf8dcf53-f131-68f4-c6aa-d41e02ac6d5c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf8dcf53-f131-68f4-c6aa-d41e02ac6d5c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 12:48:21AM +0300, Dmitry Baryshkov wrote:
> On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> > Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
> > controller/PHY can be configured to run in two gear speeds). But that
> > requires an agreement between the UFS controller and the UFS device.
> > This commit finds the max gear supported by both controller and device
> > then decides which one to use.
> > 
> > UFS controller's max gear can be read from the REG_UFS_PARAM0 register and
> > UFS device's max gear can be read from the "max-gear" devicetree property.
> > 
> > The UFS PHY also needs to be configured with the decided gear using the
> > phy_set_mode_ext() API.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++++++---
> >   drivers/ufs/host/ufs-qcom.h |  4 ++++
> >   2 files changed, 36 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index f952cc76919f..268463e92d67 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -281,6 +281,9 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
> >   static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
> >   {
> >   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > +	struct device *dev = hba->dev;
> > +	u32 max_gear, hcd_max_gear, reg;
> > +	int ret;
> >   	if (host->hw_ver.major == 0x1) {
> >   		/*
> > @@ -292,8 +295,33 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
> >   		 */
> >   		if (hs_gear > UFS_HS_G2)
> >   			return UFS_HS_G2;
> > +	} else if (host->hw_ver.major > 0x3) {
> > +		/*
> > +		 * Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
> > +		 * controller/PHY can be configured to run in two gear speeds). But that
> > +		 * requires an agreement between the UFS controller and the device. Below
> > +		 * code tries to find the max gear of both and decides which gear to use.
> > +		 *
> > +		 * First get the max gear supported by the UFS device if available.
> > +		 * If the property is not defined in devicetree, then use the default gear.
> > +		 */
> > +		ret = of_property_read_u32(dev->of_node, "max-gear", &max_gear);
> > +		if (ret)
> > +			goto err_out;
> 
> Can we detect the UFS device's max gear somehow? If not, the 'max-gear'
> property name doesn't sound good. Maybe calling it 'device-gear' would be
> better.
> 

UFS device probing depends on PHY init sequence. So technically we cannot know
the max gear of the device without using an init sequence, but this information
is static and should be known to a board manufacturer. That's why I decided to
use this property. Another option is to use a fixed init sequence for probing
the device and do a re-init after knowing it's max gear but that is not
recommended.

We need "max" keyword because this property specifies the maximum gear at which
the device could operate and not necessarily the gear at which it operates.
Maybe, "max-device-gear" would make it clear.

Thanks,
Mani

> > +
> > +		/* Next get the max gear supported by the UFS controller */
> > +		reg = ufshcd_readl(hba, REG_UFS_PARAM0);
> > +		hcd_max_gear = UFS_QCOM_MAX_GEAR(reg);
> > +
> > +		/*
> > +		 * Now compare both the gears. If the max gear supported by the UFS device
> > +		 * is compatible with UFS controller, then use the UFS device's max gear
> > +		 * speed. Otherwise, use the UFS controller supported max gear speed.
> > +		 */
> > +		return (max_gear <= hcd_max_gear) ? max_gear : hcd_max_gear;
> 
> return max(max_gear, hcd_max_gear); ?
> 
> >   	}
> > +err_out:
> >   	/* Default is HS-G3 */
> >   	return UFS_HS_G3;
> >   }
> > @@ -303,7 +331,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> >   	struct phy *phy = host->generic_phy;
> >   	int ret;
> > -	bool is_rate_B = UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B;
> > +	u32 hs_gear;
> >   	/* Reset UFS Host Controller and PHY */
> >   	ret = ufs_qcom_host_reset(hba);
> > @@ -311,8 +339,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >   		dev_warn(hba->dev, "%s: host reset returned %d\n",
> >   				  __func__, ret);
> > -	if (is_rate_B)
> > -		phy_set_mode(phy, PHY_MODE_UFS_HS_B);
> > +	/* UFS_HS_G2 is used here since that's the least gear supported by legacy Qcom platforms */
> > +	hs_gear = ufs_qcom_get_hs_gear(hba, UFS_HS_G2);
> > +	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, hs_gear);
> >   	/* phy initialization - calibrate the phy */
> >   	ret = phy_init(phy);
> > diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> > index 214ea50acab9..c93bc52ea848 100644
> > --- a/drivers/ufs/host/ufs-qcom.h
> > +++ b/drivers/ufs/host/ufs-qcom.h
> > @@ -89,6 +89,10 @@ enum {
> >   #define TMRLUT_HW_CGC_EN	BIT(6)
> >   #define OCSC_HW_CGC_EN		BIT(7)
> > +/* bit definitions for REG_UFS_PARAM0 */
> > +#define MAX_HS_GEAR_MASK	GENMASK(6, 4)
> > +#define UFS_QCOM_MAX_GEAR(x)	FIELD_GET(MAX_HS_GEAR_MASK, (x))
> > +
> >   /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
> >   #define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
