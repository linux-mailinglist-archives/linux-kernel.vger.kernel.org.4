Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9C6DD954
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDKLZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDKLZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:25:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E623A87
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:25:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so10476460pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681212324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjC854OYX3syRhNdBidxi/X2OMU2mQKVfgEhy4167R4=;
        b=plEk6vtDVxP6VXQl+/eZbhLIS6cdTT4ZKAW/D3LkYpTKApwyzFyVjn8+6Vdx6TyEX6
         NcPBONdclGJrGMsqWCSnwlsoEsKtwHTrNJoP/BN51DVCdnmqL7nZeU19z70qvlY8f9OE
         yYnJkU8cEuymT8USncoN4mU63wubhaNk4g0CI5Qs9auxuFrFpMKuQipxGXTSgnfBqi2p
         6MPORQkO4VV7vupx22XsVTS6rma6RiP7ylRxyopFhGVUJSveSOjFzbrEBa4dmHGQZtZF
         KgzlgOE+qQI1hIWFVmEZh8FrCinDCGBHevGjj37Vo5o1J7DPqeqcVUVZgJ7bOb9r4MI/
         /Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681212324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjC854OYX3syRhNdBidxi/X2OMU2mQKVfgEhy4167R4=;
        b=OZlN4pqVZYjMj2jazPJweKXHYt2DiWn8J6Nqvuoiu/grjjacxKu3USgBrfvE3oTWr3
         sThI32QYvtwlKNnLOQPAxSvOAXFASEgbU01uZzpfaQbg+Gx7S3e3EnTYSKVYTVu7dCh8
         LYrWd545CvCQ46pt15n/dDZuBM/fswhXBEX/P1LFa9gpsGgIo1nkYcodQ+vSWJpMXB/L
         rLiDTPDfjPQnVOjogsfO2GwdsUWDGvFWWcfDL/UJe6H9PhX/5wN3iNjHQw04VUg+fzJx
         cFHLC7WtUqFrqzM/3dpAbw8/YSGEaRO2+UFNcZyLc4bc1ku7+ymrGi+nePpZmVlntaU1
         88eA==
X-Gm-Message-State: AAQBX9eOXCP2/heWXZhnoE7q+1gFnPaAGEoyYBhYUCrMLl8navRjhK/O
        dQLYH91x4osawn/n+T/s1B+P
X-Google-Smtp-Source: AKy350bzzRRS+zMe7eZ7G7p/8IFbqdXoO3nFC6fP785tSpCTHhiL7A9bTyFIJc8Mt/ghP59Lc7UfRA==
X-Received: by 2002:a17:90b:1c03:b0:240:d8a:8d24 with SMTP id oc3-20020a17090b1c0300b002400d8a8d24mr17735549pjb.4.1681212324486;
        Tue, 11 Apr 2023 04:25:24 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b001933b4b1a49sm9455775plb.183.2023.04.11.04.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:25:24 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:55:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 10/10] MAINTAINERS: Add myself as the DW eDMA
 driver reviewer
Message-ID: <20230411112514.GL5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-11-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:28AM +0300, Serge Semin wrote:
> The driver maintainer has been inactive for almost two years now. It
> doesn't positively affect the new patches tests and reviews process. Since
> the DW eDMA engine has been embedded into the PCIe controllers in several
> our SoCs we will be interested in helping with the updates review.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Same comment as 9/10. I'll defer the decision to Vinod.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51adcafa0f0c..fb7bada6cdd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5862,6 +5862,7 @@ F:	drivers/mtd/nand/raw/denali*
>  
>  DESIGNWARE EDMA CORE IP DRIVER
>  M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +R:	Serge Semin <fancer.lancer@gmail.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	drivers/dma/dw-edma/
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
