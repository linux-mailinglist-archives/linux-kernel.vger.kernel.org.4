Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1CE705F67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjEQFbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjEQFbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:31:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAEE40CC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:31:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso3153745e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684301459; x=1686893459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nMTTmWYUrmzwZaosHfjCqIrl1kyDtjH4MIUq5qujY/A=;
        b=UnrPfKZJD6CEVn5/7yvhUPi3PkUqmrarSf0RaoCRjNKU+8LLI0JNEzyi8UmHchGhJq
         10QnEO07Vur1pSrNUx7jwM6EXPdlsFIFmPHCOqnn4nkAlN94FxVBfDbZ0995pvWV5ol7
         03GSXZIh+ZpDHGl3iZ2r9gHaxG0cgn4TDy5R3B+ediF//UO/nk27NB9ZT/OCqU2Xfp0d
         4Gkw4mWNthgR/Z5/Db9OREy4+q25vLnNrnSsppNpNNYyezIIfImTa7/xb/iXAhAjYSix
         Lkl/W8SJCTsXIOfmZ61yiCLC2HOm7PGmnWJkYhB5bGA3H9SCP0P8vnGTBZWnzaQeQXB9
         MwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301459; x=1686893459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMTTmWYUrmzwZaosHfjCqIrl1kyDtjH4MIUq5qujY/A=;
        b=TmMkny0PZKDpjBQ8xOtBsElD7YcIsHK+vaJbQKMdQCGEEW63r/OD8TR4PuZW2vWDUn
         CyAamQDiZeZJy9cyHk1sZn6mpjlnxo34jDodKG3Ypy9WsimCzTkkgvgrC+aDdLsPZWKS
         Chj1nlJOzNVRbHMSHh6C/8tnsAB2EtwXv4PLKe3bN9v3kqf00uOjVGlMax3l0cuyIYop
         WrlXAba+MgykkCxnK+DAYfY1HcQZnAdagt+6MyaiRgz9THHeRz+3JE0d5iNxLwvZpYLg
         xT/689KGfpEoD76IzrWVcf06upB3Z738RPzm8G4OeWPrOTlZVGKMm2FpyNfk+TqGwjaK
         Oosw==
X-Gm-Message-State: AC+VfDxZjpvwmFPabdsoJuXQSy4vO73WOPuTeN9QV0JtAfOZHZu4piPC
        so6BER/2vaa8lqizGah/oQzB
X-Google-Smtp-Source: ACHHUZ5ZVVeIxKagdAlznvBM/aTBPA6j03/fd6cGZgNsUDgn4IzTHH7xgo0zULvnLYCgp8rw3O0scA==
X-Received: by 2002:a7b:c38f:0:b0:3f4:ef34:fbc2 with SMTP id s15-20020a7bc38f000000b003f4ef34fbc2mr14133926wmj.24.1684301459577;
        Tue, 16 May 2023 22:30:59 -0700 (PDT)
Received: from thinkpad ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f4f8cc4285sm934656wmf.17.2023.05.16.22.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 22:30:59 -0700 (PDT)
Date:   Wed, 17 May 2023 11:00:47 +0530
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
Subject: Re: [PATCH RESEND v5 09/14] MAINTAINERS: Demote Gustavo Pimentel to
 DW PCIe core reviewer
Message-ID: <20230517053047.GC4868@thinkpad>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511190902.28896-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:08:57PM +0300, Serge Semin wrote:
> No maintaining actions from Gustavo have been noticed for over two years.
> Demote him to being the DW PCIe RP/EP driver reviewer for now.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 817cd8f40e65..0d93e1e4e776 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16166,7 +16166,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
> -M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
