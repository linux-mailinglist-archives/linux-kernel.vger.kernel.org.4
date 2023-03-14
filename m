Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806AC6B9101
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCNLFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCNLF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:05:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A43644E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:04:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so19925940pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678791880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HrDFtl79sc+ajUKajTjTeATx1JcjSGMMUnWf7PJyUO0=;
        b=yV6/BTqocpnceFVorOrd5zj0tUxczCcgUobq91Kh/TkCPfsbK7cHC8KPzChb16znPq
         cP75poFrb74w1b/Fgq6AzbXDWUOMX100ppolj9qoJ99PXpocrQujafwxsZAx2+6I26pK
         99iUQw3yeNObpp9Mak7XiKRVhFW8yNQsIXe/67bStzMgw0viT0AZLaDmBwnPdnkbUbHF
         75rCet2P3bJgouiLgH4JRlImeBYylRIVtscD1Y0ug1bd/3n1w66BIxsMTeYuBBWcV36H
         2I+u3UpbSwWqifL9XN6LyQxhCx+F5ZmA4/tHQbd6onYLu7YJbUvrsrE8pQ98hCxxipvc
         r6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678791880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrDFtl79sc+ajUKajTjTeATx1JcjSGMMUnWf7PJyUO0=;
        b=yYhjafhH3b1mHtnta5+tV8wt9T20pLZ/Y3WeBde95XQfhELKtWvEZYYg4OIMBbqHND
         yDqSt8TfOUCazr1kd2xLRtbIoJQMw6ugMPM9OdrnFr0OsJ9gskdcXMS3kMee1cwMZF7K
         SGMyw5Q6SanwuS0CZagFyu9hV6QkJzLDj20N22pFGT8ATN2Gef7CZJm7oPyCImwuFfj8
         E2I1bPmNiRD3tb3FtVVXSbOgRFd8SMbcK7MT4CEyHIgT4qmAO0XAHvJ9iZoT+o3G8RQA
         +XPkNfgrIvOHRFxVoS7+9zuQ6wE9FORLSAl186ySKVc+6jKpwr+tHiLv5XaddBDvAO8j
         0pCg==
X-Gm-Message-State: AO0yUKVb3GawziY2VcfpM6PyMGWI8b5EGD3yNMCtViovA3jTHhGDqo7k
        jWOeUD2kfVgy/bBFocP2K5Y6
X-Google-Smtp-Source: AK7set9WQx7XvYGapBRqozDdlUR3HMi3qnSOpHxAgrYVyHhM337Di4Jp/csQM2i06d9CCjq4jGEd1Q==
X-Received: by 2002:a17:902:e547:b0:1a0:5524:eb70 with SMTP id n7-20020a170902e54700b001a05524eb70mr4565516plf.39.1678791880088;
        Tue, 14 Mar 2023 04:04:40 -0700 (PDT)
Received: from thinkpad ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902740300b0019a8530c063sm1488023pll.102.2023.03.14.04.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:04:39 -0700 (PDT)
Date:   Tue, 14 Mar 2023 16:34:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/19] PCI: qcom: Expose link transition counts via
 debugfs for v2.4.0
Message-ID: <20230314110431.GA137001@thinkpad>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
 <20230310040816.22094-20-manivannan.sadhasivam@linaro.org>
 <e02980a9-34ca-9b9a-389a-01c599612140@quicinc.com>
 <a55f652c-aa78-1df5-1587-a12920d7a2f1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a55f652c-aa78-1df5-1587-a12920d7a2f1@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:25:29PM +0530, Sricharan Ramabadhran wrote:
> 
> 
> On 3/14/2023 4:06 PM, Sricharan Ramabadhran wrote:
> > 
> > 
> > On 3/10/2023 9:38 AM, Manivannan Sadhasivam wrote:
> > > Qualcomm PCIe controllers of version v2.4.0 have debug registers in the
> > > PARF region that count PCIe link transitions. Expose them over debugfs to
> > > userspace to help debug the low power issues.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 33 ++++++++++++++++++++++++++
> > >   1 file changed, 33 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > > b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index f99b7e7f3f73..0b41f007fa90 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -37,6 +37,7 @@
> > >   /* PARF registers */
> > >   #define PARF_SYS_CTRL                0x00
> > >   #define PARF_PM_CTRL                0x20
> > > +#define PARF_PM_STTS                0x24
> > >   #define PARF_PCS_DEEMPH                0x34
> > >   #define PARF_PCS_SWING                0x38
> > >   #define PARF_PHY_CTRL                0x40
> > > @@ -84,6 +85,12 @@
> > >   /* PARF_PM_CTRL register fields */
> > >   #define REQ_NOT_ENTR_L1                BIT(5)
> > > +/* PARF_PM_STTS register fields */
> > > +#define PM_LINKST_IN_L1SUB            BIT(8)
> > > +#define PM_LINKST_IN_L0S            BIT(7)
> > > +#define PM_LINKST_IN_L2                BIT(5)
> > > +#define PM_LINKST_IN_L1                BIT(4)
> > > +
> > >   /* PARF_PCS_DEEMPH register fields */
> > >   #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)        FIELD_PREP(GENMASK(21,
> > > 16), x)
> > >   #define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)   
> > > FIELD_PREP(GENMASK(13, 8), x)
> > > @@ -737,6 +744,31 @@ static int qcom_pcie_post_init_2_4_0(struct
> > > qcom_pcie *pcie)
> > >       return 0;
> > >   }
> > > +static int qcom_pcie_debugfs_func_2_4_0(struct seq_file *s, void *data)
> > > +{
> > > +    struct qcom_pcie *pcie = (struct qcom_pcie *)
> > > dev_get_drvdata(s->private);
> > > +
> > > +    seq_printf(s, "L0s transition count: %u\n",
> > > +           readl_relaxed(pcie->parf + PM_LINKST_IN_L0S));
> > > +
> > > +    seq_printf(s, "L1 transition count: %u\n",
> > > +           readl_relaxed(pcie->parf + PM_LINKST_IN_L1));
> > > +
> > > +    seq_printf(s, "L1.1 transition count: %u\n",
> > > +           readl_relaxed(pcie->parf + PM_LINKST_IN_L1SUB));
> > > +
> > > +    seq_printf(s, "L2 transition count: %u\n",
> > > +           readl_relaxed(pcie->parf + PM_LINKST_IN_L2));
> > > +
> > 
> >   Using bitmask as register offset ? instead use PM_STTS and bitmask it ?
> 
>  Also, since its 1 bit, all are status and not count.
>  Not sure, if you want it to limit this debug based on 'mhi' property
>  being populated ?
> 

Err... Look like I blindly copied the debugfs function from 2.7.0 :/ Sry, since
these are all just 1 bit, we cannot use it for getting the count. So I'll drop
this patch in next revision.

Thanks,
Mani

> Regards,
>  Sricharan

-- 
மணிவண்ணன் சதாசிவம்
