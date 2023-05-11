Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0183E6FF79B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjEKQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbjEKQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:39:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F021996;
        Thu, 11 May 2023 09:39:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso16694755a12.3;
        Thu, 11 May 2023 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683823196; x=1686415196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpg8XDB92ynuRzY1i3UBYEufHNkhwJLAak/2Lx31N6M=;
        b=ibTgPIrHlC7KM/tGyqwtf1UyJoDnPrrLqtP2Zqej1oTbR/ruuQMX9ZXvgnS39ULJvo
         DERGtBVBE4r78wvrzmORpxZDKusSm7SnefyLARh9hy9m3JL7n5Yu7HlfQmQ34BXafg7r
         1/GM07+C5kHldeoOv7dn4eYcXFOHvIFUJfDuGzTvPdmfmLIMUh916Sa1Ffbe8Glz5uTC
         veeqqFL58PtyBrn682RVe0XbnqYAtyRHlIAJyhX/Lwp3/ynI/wiZolwdiO+KfG5L/QIl
         24BSF3UgtwsHic13L1N4Qvk31GZG9r9hpBup0hFkQFGdYLqJuhnrTbkXNvTIGn9i5+ga
         eFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683823196; x=1686415196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpg8XDB92ynuRzY1i3UBYEufHNkhwJLAak/2Lx31N6M=;
        b=M7EmcvS8cWpM7dDxCT0/1wQA8o9qwQv678X6m4k0PAOupz9sT2LQ30DT3psDXOvcP+
         zGmp7UJrLwXt+u5Gice7vVFRPWU3KxZhhafzNTl4vq2IZpTI0Gc+97T49RVdOejORPKu
         cYiBSRif5oTPQlBTp6x+kh6p6aklvgK+zajYLxWATyaoKFsy7NvUOtkvPdy62Z7Z3iK7
         dBNb51WsuWFXAA77qZm9Id1V69zBtJey33pRDohPN3bMPHptP9Io9F+mSwS6J8w3brfK
         xOidT412N39qS6zgiYUEEeEaf8ce5jZCZV/58A3QceK5i6shBlpbaAuvaLjcjdufFKID
         xvMw==
X-Gm-Message-State: AC+VfDxbE0hgKEXCjxwqhq1qPnyZP+A7JkqGGQi13gYiPbGKtMGgZoEV
        4u4b4z3cjSKodVqKki+DWTs=
X-Google-Smtp-Source: ACHHUZ5M06vBgci6zS42m3wRUWv6RwPtzqUTomGRUWOkHFF5nSTmaSbApuSRzoOCjc6tHcHBsCYfeQ==
X-Received: by 2002:a17:907:843:b0:94f:5847:8ac with SMTP id ww3-20020a170907084300b0094f584708acmr19514441ejb.51.1683823196255;
        Thu, 11 May 2023 09:39:56 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id r12-20020a1709062ccc00b0094e954fd015sm4260699ejr.175.2023.05.11.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:39:55 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/5] dt-bindings: spi: sun6i: add DT bindings for Allwinner
 R329/D1/R528/T113s SPI
Date:   Thu, 11 May 2023 18:39:54 +0200
Message-ID: <3558185.R56niFO833@jernej-laptop>
In-Reply-To: <20230510081121.3463710-2-bigunclemax@gmail.com>
References: <20230510081121.3463710-1-bigunclemax@gmail.com>
 <20230510081121.3463710-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 10:11:08 CEST je Maksim Kiselev napisal(a):
> Listed above Allwinner SoCs has two SPI controllers. First is the regular
> SPI controller and the second one has additional functionality for
> MIPI-DBI Type C.
> 
> Add compatible strings for these controllers
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


