Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93C961394F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiJaOuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiJaOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:50:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5096410FE8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:50:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g62so10863813pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G61ZtZyzLbGn60Ny6OY1xq5S4nX4pwImvQvsYH0GFno=;
        b=h+AZN1emo1F/GPSOBe9v3NFLYdpHmSzshIlpJlH3Geua8ehCIy/9qpUX9+VfZBg7bB
         z+8OPNVh++U7733AaV+t/Hhr5fWdvoFZkEDIt2fyCBEOHQkm5W0zdn3FV3cVPvm8ZRX3
         peodf6oZ3P+4diGYd3fJsV1qWnIUBuWZysiJ/foPRE6I4YAoAq32x2T/Mt5OAK89kX4e
         j0G7nDVWjst4XqbwiN1vh9oqoHm5ZJP2fMw5OJ8/TagUc6WRfoDjNlFJZ+FqZt4UwsMx
         5jhImqqJN2vpTbV2aFbpn83kSdt/GejJDBBD8qAPSaWv51bV/Dc4bRbUV/8aBr3D2NQI
         L8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G61ZtZyzLbGn60Ny6OY1xq5S4nX4pwImvQvsYH0GFno=;
        b=ZTdfiVS1egJl9A03Z26Qv0cgNH3zUIz6RZHVShErgFh7++28q2DJ+en5i9escbk6LD
         uw5TkFRG1GsbNDqwmKqVnWRdk3/rNvZ4F+y2KafALZB5AYKWRtDsnGEW230Xkht25oL/
         5Yzxqe0qRNSwqsOrqKCHGDpPSkm4kTQLWiz8GfaanBejMltFhhL49neWvOurrucqlmeJ
         RfGPREPuIi5YhB2pmGPQ223Tekj0pl4OTR4OSSbWsC7JJssgI/fMKreLZcxh7162kNZa
         Wa2YAQClYJWSYaSDc5lmlPg0WFnAYJ6LQ6kpSbUNv/6MIUs913Sn1yvzER7K+EKHEm9Q
         boqA==
X-Gm-Message-State: ACrzQf1Vr0Jo4sA6idx0GiPkU9CpIIzMu5dIF0rilnImYiKp4fRxpJfQ
        A3H/h4b3qMB29h6XAR4LBFwc
X-Google-Smtp-Source: AMsMyM5RRehaTeLhtzAe1dhNO1cSAE/tCbXXuTRW2JUlaOB4/VnEV1BmaFq8CdTJHAW9nrBd/e6oGg==
X-Received: by 2002:a65:6bc4:0:b0:439:8ff8:e2e1 with SMTP id e4-20020a656bc4000000b004398ff8e2e1mr13003767pgw.91.1667227815594;
        Mon, 31 Oct 2022 07:50:15 -0700 (PDT)
Received: from thinkpad ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id z184-20020a6233c1000000b0056c47a5c34dsm4685401pfz.122.2022.10.31.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:50:14 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:20:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 10/15] scsi: ufs: ufs-qcom: Use bitfields where
 appropriate
Message-ID: <20221031145005.GA10515@thinkpad>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-11-manivannan.sadhasivam@linaro.org>
 <01a01fb3-2520-58ce-6432-b278bb8118f5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01a01fb3-2520-58ce-6432-b278bb8118f5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 12:58:57AM +0300, Dmitry Baryshkov wrote:
> On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> > Use bitfield macros where appropriate to simplify the driver.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/ufs/host/ufs-qcom.h | 58 ++++++++++++++++---------------------
> >   1 file changed, 25 insertions(+), 33 deletions(-)
> > 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> > diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> > index 44466a395bb5..6cb0776456b3 100644
> > --- a/drivers/ufs/host/ufs-qcom.h
> > +++ b/drivers/ufs/host/ufs-qcom.h
> > @@ -17,12 +17,9 @@
> >   #define DEFAULT_CLK_RATE_HZ     1000000
> >   #define BUS_VECTOR_NAME_LEN     32
> > -#define UFS_HW_VER_MAJOR_SHFT	(28)
> > -#define UFS_HW_VER_MAJOR_MASK	(0x000F << UFS_HW_VER_MAJOR_SHFT)
> > -#define UFS_HW_VER_MINOR_SHFT	(16)
> > -#define UFS_HW_VER_MINOR_MASK	(0x0FFF << UFS_HW_VER_MINOR_SHFT)
> > -#define UFS_HW_VER_STEP_SHFT	(0)
> > -#define UFS_HW_VER_STEP_MASK	(0xFFFF << UFS_HW_VER_STEP_SHFT)
> > +#define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
> > +#define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
> > +#define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
> >   /* vendor specific pre-defined parameters */
> >   #define SLOW 1
> > @@ -76,24 +73,24 @@ enum {
> >   #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
> >   /* bit definitions for REG_UFS_CFG1 register */
> > -#define QUNIPRO_SEL		0x1
> > -#define UTP_DBG_RAMS_EN		0x20000
> > +#define QUNIPRO_SEL		BIT(0)
> > +#define UTP_DBG_RAMS_EN		BIT(17)
> >   #define TEST_BUS_EN		BIT(18)
> >   #define TEST_BUS_SEL		GENMASK(22, 19)
> >   #define UFS_REG_TEST_BUS_EN	BIT(30)
> >   /* bit definitions for REG_UFS_CFG2 register */
> > -#define UAWM_HW_CGC_EN		(1 << 0)
> > -#define UARM_HW_CGC_EN		(1 << 1)
> > -#define TXUC_HW_CGC_EN		(1 << 2)
> > -#define RXUC_HW_CGC_EN		(1 << 3)
> > -#define DFC_HW_CGC_EN		(1 << 4)
> > -#define TRLUT_HW_CGC_EN		(1 << 5)
> > -#define TMRLUT_HW_CGC_EN	(1 << 6)
> > -#define OCSC_HW_CGC_EN		(1 << 7)
> > +#define UAWM_HW_CGC_EN		BIT(0)
> > +#define UARM_HW_CGC_EN		BIT(1)
> > +#define TXUC_HW_CGC_EN		BIT(2)
> > +#define RXUC_HW_CGC_EN		BIT(3)
> > +#define DFC_HW_CGC_EN		BIT(4)
> > +#define TRLUT_HW_CGC_EN		BIT(5)
> > +#define TMRLUT_HW_CGC_EN	BIT(6)
> > +#define OCSC_HW_CGC_EN		BIT(7)
> >   /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
> > -#define TEST_BUS_SUB_SEL_MASK	0x1F  /* All XXX_SEL fields are 5 bits wide */
> > +#define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
> >   #define REG_UFS_CFG2_CGC_EN_ALL (UAWM_HW_CGC_EN | UARM_HW_CGC_EN |\
> >   				 TXUC_HW_CGC_EN | RXUC_HW_CGC_EN |\
> > @@ -101,17 +98,12 @@ enum {
> >   				 TMRLUT_HW_CGC_EN | OCSC_HW_CGC_EN)
> >   /* bit offset */
> > -enum {
> > -	OFFSET_UFS_PHY_SOFT_RESET           = 1,
> > -	OFFSET_CLK_NS_REG                   = 10,
> > -};
> > +#define OFFSET_CLK_NS_REG		0xa
> >   /* bit masks */
> > -enum {
> > -	MASK_UFS_PHY_SOFT_RESET             = 0x2,
> > -	MASK_TX_SYMBOL_CLK_1US_REG          = 0x3FF,
> > -	MASK_CLK_NS_REG                     = 0xFFFC00,
> > -};
> > +#define MASK_UFS_PHY_SOFT_RESET		BIT(1)
> > +#define MASK_TX_SYMBOL_CLK_1US_REG	GENMASK(9, 0)
> > +#define MASK_CLK_NS_REG			GENMASK(23, 10)
> >   /* QCOM UFS debug print bit mask */
> >   #define UFS_QCOM_DBG_PRINT_REGS_EN	BIT(0)
> > @@ -135,15 +127,15 @@ ufs_qcom_get_controller_revision(struct ufs_hba *hba,
> >   {
> >   	u32 ver = ufshcd_readl(hba, REG_UFS_HW_VERSION);
> > -	*major = (ver & UFS_HW_VER_MAJOR_MASK) >> UFS_HW_VER_MAJOR_SHFT;
> > -	*minor = (ver & UFS_HW_VER_MINOR_MASK) >> UFS_HW_VER_MINOR_SHFT;
> > -	*step = (ver & UFS_HW_VER_STEP_MASK) >> UFS_HW_VER_STEP_SHFT;
> > +	*major = FIELD_GET(UFS_HW_VER_MAJOR_MASK, ver);
> > +	*minor = FIELD_GET(UFS_HW_VER_MINOR_MASK, ver);
> > +	*step = FIELD_GET(UFS_HW_VER_STEP_MASK, ver);
> >   };
> >   static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
> >   {
> > -	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
> > -			1 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
> > +	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET, FIELD_PREP(MASK_UFS_PHY_SOFT_RESET, 1),
> 
> Nit: I'd just define the value too and use the defined name here.
> 
> > +		    REG_UFS_CFG1);
> >   	/*
> >   	 * Make sure assertion of ufs phy reset is written to
> > @@ -154,8 +146,8 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
> >   static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
> >   {
> > -	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
> > -			0 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
> > +	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET, FIELD_PREP(MASK_UFS_PHY_SOFT_RESET, 0),
> 
> Nit: FIELD_PREP is always 0.
> 

I know but this make the code in sync with reset assert.

Thanks,
Mani

> > +		    REG_UFS_CFG1);
> >   	/*
> >   	 * Make sure de-assertion of ufs phy reset is written to
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
