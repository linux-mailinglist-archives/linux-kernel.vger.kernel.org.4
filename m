Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6D6C52F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCVRsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCVRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:48:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4535ECD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:48:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so76131343edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679507285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr6TeKOzsge+FFicPSnu2Sq+O0zv/SoC08/DpMmMHaE=;
        b=Q4T2XCaOfbJbsZAlVZtoSvsLC8ZbgLbU3no4b8QA+ypbFvYTOXeDddpLcrdQYRumsa
         M1WYQ5GZxmCd0EXCKV4QJRW9NsTApwhrVLMQd2qYRw8qD4I6WlCkBxS9zEWoQKN6qV5G
         P0DxyD8O+c/QFHAPnShd1uy6dCt3Tn7WhXw/xjDm/GDwcc5l0E1015keX8KYbdLQ7c59
         ImKJbPkfkb/4H/1Q8j92Z8mK5v8EtuZ5LwL6jELS7oEbHcn8El8YO+D7RpcvGZv3CD8n
         czUGy48AScGmIiz0GeF5KwSC/o8AC7e3FubVBnxmzFXAxcKJX2p3gUuOOms0tDrHmTxC
         gEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679507285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr6TeKOzsge+FFicPSnu2Sq+O0zv/SoC08/DpMmMHaE=;
        b=g8VBiuAJidehh5Cdl8dirb8nR/xb3meScZjRqQd8HzgwZu8sWRCj544+0f57uIy5XI
         1QIAbaRsCj8VWKSWBSE6vXBYBe1YzLSDBJ3uWX0sYR7gEf6gfNy89COBg9gD5L8NmV1V
         sysMbRJsGLGuI4xwyZdugWpoNvS1Qxk8r2UKj39mmFsUVwUMbk/DT8/ULTMUgwl0raPU
         CNYQht3oUplA4Kc0/ojU91XEyzUwFLMm2AQ0T8mzT9uNppQnPO/GvgomfW4AGHjZlHxw
         JNWJBWss+Rg/AOYHTzKXGytk5h9a4eGCiouxgBnMQLUQ8rfoNDIXaobI3aa5wb9MtRhk
         yAfw==
X-Gm-Message-State: AO0yUKVhrT2RlS8Lwr0z4AOI/BFYc9vPBK/WvQrhckzIt03nhFRYPjn5
        NmRQTn/kY+nwlFnvWM69soJHOw==
X-Google-Smtp-Source: AK7set9kbuZpghXxHJT6c08wz2KY1zmFVsr1oRZl6hQ+iQKsD8J3Q/YQAeWyADmeJizgjuY5CWSc2w==
X-Received: by 2002:a17:906:e0c1:b0:920:388c:5c60 with SMTP id gl1-20020a170906e0c100b00920388c5c60mr7757836ejb.41.1679507285210;
        Wed, 22 Mar 2023 10:48:05 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709064f0700b008cda6560404sm7495732eju.193.2023.03.22.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:48:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: EXYNOS: Use of_address_to_resource()
Date:   Wed, 22 Mar 2023 18:48:02 +0100
Message-Id: <167950727877.811583.5299126381937296479.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230319163145.225323-1-robh@kernel.org>
References: <20230319163145.225323-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 11:31:44 -0500, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() with single call
> to of_address_to_resource(). With this, use ioremap() instead of
> of_iomap() which would parse "reg" a second time.
> 
> 

Applied, thanks!

[1/1] ARM: EXYNOS: Use of_address_to_resource()
      https://git.kernel.org/krzk/linux/c/cb56f508e541036ad41cb9a5afb46339b2f83b9f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
