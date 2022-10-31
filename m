Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF361395B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiJaOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiJaOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:51:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA410FFC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:51:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so16153634pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgaSg3YilW0bY3wb0PfV4C2o6RkFEiky2r/QW3cr95Q=;
        b=NDX+/pbFibStxDbfcIKfe9Cw1g+cwYVRJeqt5kJcdCi5TKhYHmo+n1CuKGLOqdKfP2
         GdYXCuDUGPno200z7QLnM/0kZI3H5VtIGCuXDrXLNUNoi1M2H7/GPm2ZTE8W0aH7TMj0
         2tg8a9Z5lQ+FMlKEPqjqhyENTtWE85NpEIDSIQSy0kdA8zvhUXrZq7P230w0EUmx4r2C
         N8omqUJH8CmYmXeGofaell5BDTX/4R/PRuQmsHkJ3lr7MCScv4rPvYORfr15pG6v+YTy
         G9+RyL2zZJIZSW+V63spiZ9cxugZvL2X5UkIVxh7I1Ql+dc9vayvpM86NFJYW/rt46uU
         J+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgaSg3YilW0bY3wb0PfV4C2o6RkFEiky2r/QW3cr95Q=;
        b=spFunkQmTNC+ZmK7cEfACu3iz+1nBhMF6y6IROSAJBzmUeKnfLuVXhLj+LQhRNHGIe
         b3xfyxN4ppH8M7YHojJ0WD3WfXorFFNKXREewbean1EHElfwEMc/d3yyGBVph3hKWA51
         E/HSg4jULdegzOKwRCdgf+nM6t/HoZRWF5lGbxnCVLA5EwfWmikMlymbF4A9bt5ty5f6
         tTMjXtq4i/skCV9gOkwJKSQJRIZ2wA1dcqWRCmqKFIqEAzLI4Kl5vTYvvpOrYrGPgpY8
         aqZGqalg3RKaHyS2fj5q4M/ALhUk1sgkyfTvV3SFWSc51GcR2bcxXCysNY8Ddq2oZdCK
         sQqA==
X-Gm-Message-State: ACrzQf1X5Uc8ZHq6D6skPU8OQ2obh89qfvtSV5MKigGGvoM9EoaeV/fD
        QFLLBO6zQeOOOP83WstxbGSY
X-Google-Smtp-Source: AMsMyM6Ca2btqqaMDtFBtgxJEd4UJ/gTOBby0iJg7mkBNzulg11Wh9oaaSrw15z7NN+qZrNYh7rIuQ==
X-Received: by 2002:a17:90a:e606:b0:212:f100:22e3 with SMTP id j6-20020a17090ae60600b00212f10022e3mr32735016pjy.83.1667227863165;
        Mon, 31 Oct 2022 07:51:03 -0700 (PDT)
Received: from thinkpad ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id l6-20020a622506000000b0056c08c87196sm4705475pfl.48.2022.10.31.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:51:01 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:20:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 12/15] scsi: ufs: ufs-qcom: Fix the Qcom register name
 for offset 0xD0
Message-ID: <20221031145051.GB10515@thinkpad>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-13-manivannan.sadhasivam@linaro.org>
 <9c1ca51d-2202-8279-cecb-12792385b18d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c1ca51d-2202-8279-cecb-12792385b18d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 01:06:20AM +0300, Dmitry Baryshkov wrote:
> On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> > Fix the register name used for offset 0xD0. The correct name is
> > REG_UFS_PARAM0.
> 
> The vendor kernels starting from 3.10 define this register as
> RETRY_TIMER_REG (but it is unused). I'd suggest adding a comment about the
> older register name.
> 

Makes sense to me.

Thanks,
Mani

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/ufs/host/ufs-qcom.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> > index 6cb0776456b3..214ea50acab9 100644
> > --- a/drivers/ufs/host/ufs-qcom.h
> > +++ b/drivers/ufs/host/ufs-qcom.h
> > @@ -33,7 +33,7 @@ enum {
> >   	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
> >   	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
> >   	REG_UFS_PA_ERR_CODE                 = 0xCC,
> > -	REG_UFS_RETRY_TIMER_REG             = 0xD0,
> > +	REG_UFS_PARAM0                      = 0xD0,
> >   	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
> >   	REG_UFS_CFG1                        = 0xDC,
> >   	REG_UFS_CFG2                        = 0xE0,
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
