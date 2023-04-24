Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361806DD94D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDKLY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:24:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E935A6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:24:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6321d67eed0so786401b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681212265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qJRC2fmKYy3q5cvXM6tPwtBqOIrqlg10FuCvexioZB4=;
        b=DzROGqTtBLAYNxgvMbhQVQlTSSOVeA5xvc8Zvg2yLMcU5+BLnlHPkS3wNNsMj4KY/q
         fNnyVtMwzIjISmoD72T+YGghCwea+tqlgTh0Hu9H1TTctx2CUYhEySNVIXu3F7fCMaSi
         91a3S/0AL9UBoMCYEECzcQf3VUpUjSMGY2s1/IETTJCq93DBmsxlkuG+vIJqp1zz4w90
         iX1iEHcnknQVdvRpJ2sNtE3GNvoKlbwrzcZhw24UNmME/Q/RJypiqZKEiWyCU1z2SAXk
         V2j5iJiKPlIujn7rm2/MOqSNeQgMVDb2wVsKkFESSsrlmQ3We7RGZo7a7Yp9Yzyi1qL9
         2cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681212265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJRC2fmKYy3q5cvXM6tPwtBqOIrqlg10FuCvexioZB4=;
        b=nJpnVrq+vmvt9J3+6JzHiP+7liiSdG0vKj75lN1WQe6qhwyhDezrQAhGlhMoeG/iPx
         D/RNiYNhw2HQrD9WsHQ+xfJ7p4GxrHcL1CnfMJtsF7VOBFYUoiexbyeh1sw6x194rfwW
         0Kz59MW4j0QFdk3+58D+0DhySUYt4gfBHWxatctLjHB/kvFhaigMDkDgwm47UQAp/yNp
         W0XC9laZJXVre6/321dsPWvKoOjHHY5TD4e7YZInM8S+ETle5RqU6ICcILiDw/QKUvQO
         PUrLhTdYIB0MU0HNrnSk3qTE2TjBXaqm+x4vC7pyOIsjPH+yyn/dXiWwd3aqz5eJIly0
         TyCA==
X-Gm-Message-State: AAQBX9fOlbnCz1bj88E8WB1/5UndMv74tOW7AAeTjGhMdP9qsYgtSwmt
        yMre2yTivdbsOso4ubpjyKpD
X-Google-Smtp-Source: AKy350Yd7ft8YsZDgS3sHNGhUX5XeKcYlCDmwld+oYfaymvFOGA2nRgZxrh7GTEgPLk/gL1cqQIrhA==
X-Received: by 2002:a62:844c:0:b0:634:c780:5bb8 with SMTP id k73-20020a62844c000000b00634c7805bb8mr12304326pfd.17.1681212265281;
        Tue, 11 Apr 2023 04:24:25 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id s13-20020a056a0008cd00b0062e48fe0ccfsm9578399pfu.45.2023.04.11.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:24:24 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:54:16 +0530
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
Subject: Re: [PATCH RESEND v3 09/10] MAINTAINERS: Add myself as the DW PCIe
 core reviewer
Message-ID: <20230411112416.GK5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:27AM +0300, Serge Semin wrote:
> No actions have been spotted from the driver maintainers for almost two
> years now. It significantly delays the review process of the relatively
> often incoming updates. Since that IP-core has been used in several our
> SoCs adding myself to the list of reviewers will help in the evolving the
> driver faster and in catching any potential problem as early as possible.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

If the Maintainers were not responding for these long years, then it implies
that they are not maintaining at all. So I'm inclined to remove their entries
too but I'll defer that decision to Lorenzo.

For this patch,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 489fd4b4c7ae..51adcafa0f0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16061,6 +16061,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
>  M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +R:	Serge Semin <fancer.lancer@gmail.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
