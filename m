Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278AE670F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjARAxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjARAxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:53:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03137367C7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:41:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r9so9598882wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfUH6vxkGTJcxdxitYWr1pxKffe1+NgMp91YrVEBau4=;
        b=Phk9fd0xgzPORCCqHCoGdckMrohDDK6ehcyxD5DqGXK90HWpvDg8J8h93atSQnc8RW
         +n3oKEjuPGhVi4GV8Sz8MbedhW9ap6Vs+/8/VYzKh9GBSNZebpmAGa8gm+hO53vIoUjG
         6nKXDseRf510hU+2TKJmJEPcE0SaOU67wgJ6koZ0L1d8qTOsHy31OZq87ujjauc8x+BE
         C0UrwqGbKN+wOKmKNhRpKMn5IiZiiG3pU6h0p995l3frCvC8t6LgOC20n7z5lDaKCkN9
         hhYRsBcJSVxPmbqPmCKH4//ev4lmO9/nxz7GxMSZHmeL+8xWXxbnW4Paqt123XmtAngE
         DpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfUH6vxkGTJcxdxitYWr1pxKffe1+NgMp91YrVEBau4=;
        b=tMDU2OGKRBghgO8AgahAlGWv6lHeJ5QTmMwTgANcCcD7AOOeQzLRP3bWTJ3wCmJU8G
         KLAKvOrD7dKfLE8EnTfd3j6TZVpLAdiiDOCoPR+HlsSkgZmnq7guL8j5gwhhP7hZn45a
         ZjynzwXmAy6gSUsMxcuUjywhlFyjTc2eVWNl89p/aX3IvHRDIPpV1ZQFMokIcAoOZ81b
         1fv9NULWoqBwEEmF9UEJKp4FKK1WuNre2cBigegVjC+QIl7B5QsvC5HvxrP7g9xQ24SV
         pNyJuB6INa2R1dWnw/UB0jak3ctcTH5OwsLbiOA8xHIHSDm4dbTw9+8VjJzc/SVBSkUa
         bwMg==
X-Gm-Message-State: AFqh2koP+wVUGvaGv6fgTF+clnwyQtlHmRs8zV6P12oEz7DgD+90XiaN
        v5wY8uJ9Mt3xDc/d44KQhwW2Ep78exh8/CZC
X-Google-Smtp-Source: AMrXdXtCLhSYacWmXztH3AnKfK4xq0jJH3N0aeFi245GN4xo2GPRzjI1itK7T93YdsbUeFM0cQ1Etg==
X-Received: by 2002:adf:f54d:0:b0:273:7d1b:7337 with SMTP id j13-20020adff54d000000b002737d1b7337mr13046851wrp.7.1674002516557;
        Tue, 17 Jan 2023 16:41:56 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020adff68e000000b002365730eae8sm30124380wrp.55.2023.01.17.16.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:41:56 -0800 (PST)
Date:   Wed, 18 Jan 2023 02:41:54 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 0/7] phy: qualcomm: Add PCIe support for SM8550
Message-ID: <Y8dAUqRglBphxjQb@linaro.org>
References: <20230118003834.2330028-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118003834.2330028-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-18 02:38:27, Abel Vesa wrote:
> This patchset relies on the following patchset:
> https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> 
> The v1 of this patchset is:
> https://lore.kernel.org/all/20221116120157.2706810-1-abel.vesa@linaro.org/
> 

Please ignore this version. I missed the bindings update patch.

> Changes since v1:
>  * dropped all PCIe unrelated patches and also register offsets
>  * split all the offsets into separate patches, like Vinod suggested
>  * dropped the legacy dt parse changes since we intend to support
>    only the new dt parse mechanism from now on
> 
> Abel Vesa (7):
>   phy: qcom-qmp: pcs: Add v6 register offsets
>   phy: qcom-qmp: pcs: Add v6.20 register offsets
>   phy: qcom-qmp: pcs-pcie: Add v6 register offsets
>   phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
>   phy: qcom-qmp: qserdes-txrx: Add v6.20 register offsets
>   phy: qcom-qmp: qserdes-lane-shared: Add v6 register offsets
>   phy: qcom-qmp-pcie: Add support for SM8550 g3x2 and g4x2 PCIEs
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 371 ++++++++++++++++++
>  .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h   |  15 +
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    |  23 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h    |  16 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h |  18 +
>  .../phy-qcom-qmp-qserdes-ln-shrd-v6.h         |  32 ++
>  .../phy-qcom-qmp-qserdes-txrx-v6_20.h         |  45 +++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |   6 +
>  8 files changed, 526 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> 
> -- 
> 2.34.1
> 
