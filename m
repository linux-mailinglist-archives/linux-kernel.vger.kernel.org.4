Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549D172B3E4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjFKUH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 16:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKUH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:07:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D643299;
        Sun, 11 Jun 2023 13:07:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f660e57123so2064848e87.3;
        Sun, 11 Jun 2023 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686514043; x=1689106043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPAXUJMl2olgLfel3fMTObIngqSlcX9cwamWvtgEryU=;
        b=U90IpPzzDT1hYVjCAzUYQ8SH+qZ9LJ9b/4gKcgd+QWBGGt4cwKs1AO/LJKvWQOxGdf
         lFFhRDU67j/CuN+5SSBeK8eIyTTICTlp1/3oGlSk2HT0eaheaM8BHDVoxjMsIk1eHdOu
         dxAZhMmOu2UrspCZ0gp2W8G4zac+HtXkoTUJjQfHR8TBAMjPpKWbjM56LVCoWftyshRI
         eE2N7r9tK1tDu9BmGFvIbR/BbkLIaj3al69jy+m/iARqsrLiWBTRA5i5gwHM/HV7YG/E
         CGxrK3sqptY+OvelKMemwVbaehCExCG5iMGDE0kejZGQAWcP/Dsiqpq4AsxCv3FV98R5
         RjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686514043; x=1689106043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPAXUJMl2olgLfel3fMTObIngqSlcX9cwamWvtgEryU=;
        b=L64HfMOvjq0yxCofbMB812Eu9BhuqyP5kTy05dsNwLCt8oACiXLHj14Zy6Tlk5H7Gp
         L4a5PS6uR6LCV5OqqUe0KN6kf2n4yr3ZJTVd/8TopGtmD4tR8PMEyCTzAeKE3ElXW4fe
         Y0wGCkPw/+J8T2wwpPAzoiXfV9utx0YsOewhtv8APkLVgQ1f8WRDDMdtWd84VDAwBsiJ
         761xh9zTinVjUcAPbtqASkV8bvjZXGaiCb/aJ8Hh9YHsu9+ef99RFKQzJCNJre1zraEt
         5ON4xFAXPIO5Y8YFMpoi9akNSLhX41tC2HJ5TrtR9DSKXHnlDLpWV4uPgDz9/fCvfALJ
         Fh3Q==
X-Gm-Message-State: AC+VfDxWrmarRCADSyWo371XRGHtp/QDyD+dJBWQcokSU+/+QXZVbuab
        7rXoLHp8VP0rEBpmYtZ3zPY=
X-Google-Smtp-Source: ACHHUZ7TUfI6VgL+wCYiJszZCQaUW35B1SFLTNT2ijeS+m8ypXT3rz4F5aZE/26qGRRhbAtmY3gF9Q==
X-Received: by 2002:a05:6512:1d1:b0:4f3:94b5:3274 with SMTP id f17-20020a05651201d100b004f394b53274mr2903819lfp.63.1686514042768;
        Sun, 11 Jun 2023 13:07:22 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id s6-20020a19ad46000000b004efff420b11sm1235506lfd.181.2023.06.11.13.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 13:07:21 -0700 (PDT)
Date:   Sun, 11 Jun 2023 23:07:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/5] dt-bindings: ata: dwc-ahci: add PHY clocks
Message-ID: <20230611200719.exct7r7z5izqzz4t@mobilestation>
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608162238.50078-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 06:22:34PM +0200, Sebastian Reichel wrote:
> Add PHY transmit and receive clocks as described by the
> DW SATA AHCI HW manual.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Looks good. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> index c1457910520b..34c5bf65b02d 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> @@ -31,11 +31,11 @@ properties:
>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
>        clock, etc.
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
>      items:
>        oneOf:
>          - description: Application APB/AHB/AXI BIU clock
> @@ -48,6 +48,10 @@ properties:
>            const: pmalive
>          - description: RxOOB detection clock
>            const: rxoob
> +        - description: PHY Transmit Clock
> +          const: asic
> +        - description: PHY Receive Clock
> +          const: rbc
>          - description: SATA Ports reference clock
>            const: ref
>  
> -- 
> 2.39.2
> 
