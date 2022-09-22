Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E71F5E5B71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIVGfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIVGfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:35:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3D93532
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:35:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a3so13011109lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UG9ohaYNGjC0P5to2hQtJ2st/GFJ8zFpPwv7fQeTI1k=;
        b=n3xOBDivLy1P/8Qh+2k2b/mOB3/VRhF473LRc4JGPdzNBlSF1OkbJ39YpcAVU46+4O
         e4mZDBFykkFRfu7cchV5yKHAbpd4X7WoYgGZQfL/s7JC3M6pP5SJMUsXkppM5rOE4qdB
         aPsPaVBhsXXDQ4NzCKjQquB4uR20DOepMSCgX5CNGwcn6S1zQp8b8smzPKnvzt7VkrlY
         HClXXM9LgJVEffrwYuUepFu5hRDt+orUHOgE4D/F6R1kspEYuEcTRENkRa5ngZm8zo3R
         BqJPAebADqZ0IZ6HJ5ME+ChcZPMayp9mROGN8r1zZ7/xITDNkmVxFM8oObuleYv+JYbN
         wc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UG9ohaYNGjC0P5to2hQtJ2st/GFJ8zFpPwv7fQeTI1k=;
        b=oB6tGKKnggXNWJ4PDTdOcUAN//A1vFXsEIoq2tiOTlRu/PhNNCJBwWUHVaqEI8NQpD
         QIPq5ihae/CmnXZ5amG8Ji3yhohBatnjsde12BSOkiqZswd7rBOOBoXR/q0waRA7d2eS
         nWFz0lIDcYAABFauH8qqQ78zJjc3HsmZQ9LBaSMHnb1H4fKei3vxjpD+xNkPklmqba8c
         EE7z0H/p1Vd0k7L3ORSDlrw5Cov29vprpIl3++wpsDDUgObYuE+MZYfAJhdyJadatW5u
         v2EpD31Oshv+iMtK2q9+JBEV+4bQkyoO8ftYOIALmbHwodiKi7zOaZMAxTqIm1FnO5il
         PuDg==
X-Gm-Message-State: ACrzQf35JtEXjCDO0vrewuemD7/FdvkI0WrA+MMHKUqjgLa1i2yvO/Ut
        6rD5wT4TYB6NlMqhZHyvOm501Q==
X-Google-Smtp-Source: AMsMyM59bw9pdu973etIE/LLkjusQ6+VNSmZkxPOGlt5AQZzoXXZEBZhwZRYoa3QPGWJREsy0jV1IA==
X-Received: by 2002:a19:e050:0:b0:49f:5464:71d3 with SMTP id g16-20020a19e050000000b0049f546471d3mr719382lfj.558.1663828517506;
        Wed, 21 Sep 2022 23:35:17 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p22-20020a2eb7d6000000b0025dfd2f66d6sm745682ljo.95.2022.09.21.23.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 23:35:16 -0700 (PDT)
Date:   Thu, 22 Sep 2022 08:35:14 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: aspeed: document AMD DaytonaX
Message-ID: <20220922063514.f6euqlw35jrkpee4@krzk-bin>
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
 <20220921210950.10568-2-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921210950.10568-2-aladyshev22@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 00:09:46 +0300, Konstantin Aladyshev wrote:
> Document AMD DaytonaX board compatible.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1680833


/: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dtb
