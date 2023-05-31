Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C191717E25
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjEaLfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjEaLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:35:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D17E10B;
        Wed, 31 May 2023 04:35:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so6381611e87.1;
        Wed, 31 May 2023 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685532934; x=1688124934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtaeayrxwnpVa64jGqwH3nylPnKgLH9664Qace/gSBA=;
        b=aMaqn41hzNWiWfn+hx37ZzesODgofhDklubUC+rUH4M6gg6wyKrv92npnIYfoC61vR
         3Ihs6LKRRZJdJwayqXPndJrJR8qpHwHyomoNocsKwxaxQ5Bl78XqIV5kJEi+klUfLg+W
         NzlvX1s7P02BY1VD2YyHdn/dJSjCh75pHOpm49UzWR4v7ojAyrBVAc27ZIu5KwAZzgHa
         WGX+c8wxbz/WIFpiu2bVMnaY7VBnxunWk2xGRr1X5xYdP0UhC+NaAzoLgQ+kQXpV62Gu
         WZqL28ooj1Qtj9mVi5chfNG5lY8s43HoxjNNIxAp+Ak+kQPgHbd8OuS2MjaW2vv83h1z
         z5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685532934; x=1688124934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtaeayrxwnpVa64jGqwH3nylPnKgLH9664Qace/gSBA=;
        b=iY5uo/FKhWBq+14XJaIrdDAo+2dYBdBOIznVw3r+oxaTGK+0s8Hb30Rx5doLFVVxCK
         HHtrO4WuTZaEv1lGue7jttwul+HRNUobbdT34kYQo2WBWW2KYhI611pgeUCNjXVspDNC
         QRp39MGBV+rAMTZHwB3NTXJuIxYnVjGxDaurfx1lz4teJWIDAFdPDGgkliSyYwlGxtNy
         gAO9ptpLkHwEcAaOEXew8zwzdkRGc/VK0c7oVh7lB0kRoESS2LpBuzEGRNhPTk4/eSdj
         iT9W0RwL3XrtMXnmFxh26IWLKe4HUfqYs34QEEdQcUthcSR1of3jwgJ8YAXldpV+vmH3
         VBJA==
X-Gm-Message-State: AC+VfDzHFLFBQsbPhfPTElA14NGH8lM6kVFZb1x2F3cgQfwYXU4IhOfu
        7gj6HpRrTT8chnnQ18DAnyE=
X-Google-Smtp-Source: ACHHUZ4fnjb/mV3OvhnIK8X+bfU3M2FICrmkQDNJ91GcVsSM8BddGMIpS9+xFyVk2jpKrqeR3DnntQ==
X-Received: by 2002:ac2:4859:0:b0:4f3:9930:5b8c with SMTP id 25-20020ac24859000000b004f399305b8cmr2382226lfy.25.1685532933569;
        Wed, 31 May 2023 04:35:33 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id c15-20020a19760f000000b004f24e797c58sm675740lff.217.2023.05.31.04.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:35:33 -0700 (PDT)
Date:   Wed, 31 May 2023 14:35:31 +0300
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
Subject: Re: [PATCH v2 0/6] Add RK3588 SATA support
Message-ID: <20230531113531.rxmupa2mbx4tn2re@mobilestation>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522173423.64691-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian

On Mon, May 22, 2023 at 07:34:17PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> This enables SATA support for RK3588.

Thanks for the updated series. I'll have a look at the DW AHCI SATA
part of it on this week.

-Serge(y)

> 
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20230413182345.92557-1-sebastian.reichel@collabora.com/
>  * Rebase to v6.4-rc1
>  * Collect Acked-by for syscon DT binding update
>  * Use ASIC clock description suggested by Serge Semin
>  * Also add RBC clock (not used by RK3588)
>  * Add extra patch narrowing down the allowed clocks for RK356x and RK3588
> 
> -- Sebastian
> 
> Sebastian Reichel (6):
>   dt-bindings: soc: rockchip: add rk3588 pipe-phy syscon
>   dt-bindings: ata: ahci: add RK3588 AHCI controller
>   dt-bindings: ata: ahci: dwc: enforce rockchip clocks
>   dt-bindings: phy: rockchip: rk3588 has two reset lines
>   arm64: dts: rockchip: rk3588: add combo PHYs
>   arm64: dts: rockchip: rk3588: add SATA support
> 
>  .../bindings/ata/snps,dwc-ahci-common.yaml    |  8 +-
>  .../bindings/ata/snps,dwc-ahci.yaml           | 40 +++++++--
>  .../phy/phy-rockchip-naneng-combphy.yaml      |  8 +-
>  .../devicetree/bindings/soc/rockchip/grf.yaml |  1 +
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 44 +++++++++
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 90 +++++++++++++++++++
>  6 files changed, 183 insertions(+), 8 deletions(-)
> 
> -- 
> 2.39.2
> 
