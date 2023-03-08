Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADB6B0172
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCHIbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCHIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:30:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053A85349
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:30:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso1239342pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678264206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xRs8NrvU992AK9fSZQDXLZYUjNLgriMwcrq6rCPe550=;
        b=SgIhFTp9jiAK2ZOLhTKNb3wtLcjUgrsFtB2VL1Cw5/YfmP1lUZBa85gclZhgDl3TIK
         IFjo1vsm9XLXNtkoaj+TJ6pJDCTE4BdZqDNcVquwNM3UrsfEMPVvPXiJJOgnvTvwY59B
         zspzqpn0KzowleOqY6OJKcLOpmERyzbjgTVYRvEMBcyjUtkEP6DZgB/NqnSDUjrKMNKw
         fLusbU8vywpkE676x9eJLrfPoxlUL8VR8dj7ORcncDVzTi53E/PRzT33qWN2xyCnvYgi
         WEOOAjwWrIAK0Sh03opHeeseQdifJJiM0zNEQM55YwPBc9lROQyqqKrgsIEGkJGrwvUd
         VsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRs8NrvU992AK9fSZQDXLZYUjNLgriMwcrq6rCPe550=;
        b=H4sT0ulXFyXhasGypcbPSzW1PX90ffe0K9UfemaCqvMUzaWCv+b26D1vzVTKqrUhhB
         4bCa3ZdwgywK+CXCh/hPdqr+VSw1H6kTqTwkFqPs/npWRfP+9CScjZ4sPIK+iizvp5Dc
         2VAWIx/ilT5qYWAamLO+Ux5K+PulAcxB1PytzHMQiW9gruiijAbwePZD3Tx3KKgclVK9
         SJKMi7Q5pJfyODuPn8tBuGNftpC3nzq+VRZFB5RaVknnXvIjhg4/Au4sSm1TD/hSWG60
         SeP9oMJRAgOCSEOd+QTCZBk+y/b2d1w7b9KuBV0tu7ZvpOR9bWiLMxskUq2ba06XQZRV
         6BwQ==
X-Gm-Message-State: AO0yUKUJ++1gC9npOR9gMr97EeeCFNQVrOFSWg4O2VM2oRO3oEc5YSd1
        M+7n7KBIA4Yzx6A0i2KMJHpl
X-Google-Smtp-Source: AK7set/SbItrWxTTR270hev6tj8HFfvXTl5gAvjs/qGm8QD+v48XAGlUGI5Q5ySpBLBey7JY5y737Q==
X-Received: by 2002:a17:902:efce:b0:192:4f85:b91d with SMTP id ja14-20020a170902efce00b001924f85b91dmr15416279plb.46.1678264206141;
        Wed, 08 Mar 2023 00:30:06 -0800 (PST)
Received: from thinkpad ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id lf13-20020a170902fb4d00b0019edc1b9eb2sm2639897plb.238.2023.03.08.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:30:05 -0800 (PST)
Date:   Wed, 8 Mar 2023 13:59:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 14/19] PCI: qcom-ep: Rename "mmio" region to "mhi"
Message-ID: <20230308082959.GC134293@thinkpad>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-15-manivannan.sadhasivam@linaro.org>
 <e1332d26-d686-be5a-952a-75af20c5cacb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1332d26-d686-be5a-952a-75af20c5cacb@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:19:29AM +0100, Krzysztof Kozlowski wrote:
> On 06/03/2023 16:32, Manivannan Sadhasivam wrote:
> > As per Qualcomm's internal documentation, the name of the region is "mhi"
> > and not "mmio". So let's rename it to follow the convention.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> 
> 
> >  
> > @@ -477,16 +477,16 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
> >  	if (IS_ERR(pcie_ep->elbi))
> >  		return PTR_ERR(pcie_ep->elbi);
> >  
> > -	pcie_ep->mmio_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > -							 "mmio");
> > -	if (!pcie_ep->mmio_res) {
> > -		dev_err(dev, "Failed to get mmio resource\n");
> > +	pcie_ep->mhi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +							 "mhi");
> 
> That's an ABI break. Patchset is also non-bisectable.
> 

As agreed, I will drop this patch in next revision.

Thanks,
Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
