Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA217705F54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjEQF2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjEQF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:28:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322D40D1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:28:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965cc5170bdso42796466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684301316; x=1686893316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YkFQxkeIaAtOX7X82FOSvnxuF0SwQxBBghGcIiDTlnk=;
        b=ZQrJET4wGtV4MerB8eSC218ct7JHnhfBFoJK2SGZqLCki1ERYV307QidV8BUQriLbH
         mwNSLyB0vhLpI3PJzXOGVdpHllapQV3gw77Rnz6lnHmZturl2v1HN8P41t7CHneLIdOc
         c27K6LjY5UGPhpWVhxBhv2FOZP4kpNxGt/B4Od+cebUxfK1ziSA41aNNJqV9n8fUZtD9
         XzrQcxeom8gqXAEUTljQd0xeGgwkpGi2pRdJLjEYurYA2TMZcW45aOfkDRG1DSOP2TYB
         IoRp2rj5wvYI/+l9Sv6x5BAR0SftmdnqIXdLSXuWjDRKw4xDdWoI4jg4T7ZPK5/OhTtL
         /nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301316; x=1686893316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkFQxkeIaAtOX7X82FOSvnxuF0SwQxBBghGcIiDTlnk=;
        b=gDYlUd2QWYiq8M5mfJi5ZFIkCuENBVxp+U2JUUOCbEPGtz9FpzC4CTtMrnbFhl14zS
         gz1T19b4+MFmuyVfWgRROW7uXMsjupPV6lscvhX/keA6RZNSOdZ+JK+EBQ2NMb+MBhmX
         5ZtF74mzRNHeZPKl9AKYY8GJCm8U4gKkq9mCV1hRJJ8epBY5J34GC/TPEgBZ7GG1Vdtz
         KirsZoxjCcizX4pDDRQZKF4+2fBj20EUpQu3OhYotuEkgLhTYyhrZMpU9ylzSYlLS5X9
         TqS2J8OGrN7K2XiT34ei1sv4k6mSpqN0eB0OOUIi+S0tDmc/ypExYrhe5AiPfvrOkAvk
         4mmQ==
X-Gm-Message-State: AC+VfDzKX7ZYJA3UH2HCjvGv7d+GTohRGz/BOltVmc80+flmVLs3wqAh
        R9V7haiFub9ulvr1tYYyHXex
X-Google-Smtp-Source: ACHHUZ6eFyJuc6IKEV1IprQS+sWE7KoY2veQl2FDbtkOb75qjzr4+bgSMjiGNeS3BPGSpvpFJ9hwbg==
X-Received: by 2002:a17:906:fd88:b0:965:a72a:b2ae with SMTP id xa8-20020a170906fd8800b00965a72ab2aemr32922148ejb.60.1684301316027;
        Tue, 16 May 2023 22:28:36 -0700 (PDT)
Received: from thinkpad ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906914a00b009663cf5dc3bsm11622333ejw.53.2023.05.16.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 22:28:35 -0700 (PDT)
Date:   Wed, 17 May 2023 10:58:24 +0530
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
Subject: Re: [PATCH RESEND v5 13/14] MAINTAINERS: Add Manivannan to DW eDMA
 driver maintainers list
Message-ID: <20230517052824.GA4868@thinkpad>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511190902.28896-14-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:09:01PM +0300, Serge Semin wrote:
> Manivannan has been very active in reviewing the bits coming to the DW
> eDMA driver. Let's add him to the driver maintainers list.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b49a3f0e6dde..9f66461ede29 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5885,6 +5885,7 @@ S:	Orphan
>  F:	drivers/mtd/nand/raw/denali*
>  
>  DESIGNWARE EDMA CORE IP DRIVER
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Maintained
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
