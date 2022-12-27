Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF16568A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiL0JAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiL0I75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:59:57 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB70765F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:56 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x11so13148821ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewBi19F5rXDvPAl4arROpl57FFDvAATlcWCR8UrBTc4=;
        b=ZL0RTjYtiTVU2WOwh2NUdPlltWQJooucmSNNh2/gaRWGMmPUo1/f+lDB2GgWA02fge
         g/GDJ+CdYP/pc57Ngp1gR+7cA44ACBid8rGDJl1+RCRavUm99L/6LG3+5hVCrby8smVF
         OKFAWVpwWds71Yd1I05TX8dmf5fGlkVN8i07ZjSXpxkqxMKQkNP4M/PNtNHVHCXkKdhh
         G7BQ4+tXI1pJWUC7Ce4JHfX0QIc13XTT9ZCbq/lCBl8GjyImwmXdKPrLotSo6ycn5Rp/
         vckkWBeRHrEYPzlJHe5nrAPMD9uJRlJwgyyVffVTlOC4sCtux9OgFAXXI8ejoMHiFwCf
         4iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewBi19F5rXDvPAl4arROpl57FFDvAATlcWCR8UrBTc4=;
        b=08BeflWHFxcbLDCT0egqAAKKgmZPireqFezUb5RKGlhGIgfWN8obPsuzOTmipLygMY
         SgPLb4Je0c8+nJB4gh2SRHuE7cn8ZVZ1YYw2q1l1YLBO+pD1kdmnbgaFZ3FKJGcsI0b0
         0l0edz7lch3PcyAmA2Nj06GNfaGeislu5FO0xicXHUcpk88vc6CiDanuRM2Kwe9x+X1p
         0j2xd20wQ5KZB1/Vmleb1fihbK4mzvZJinJHkcON6UzJR4x2HT3igf3KtmtHLqWlf+kL
         TeXv1wTHIlcJ5lVQmFLPtIj3P7LEWYMSfJY+9OQvCP5ujW3BA/cBu3VKN5gi2oUl7p24
         3c2A==
X-Gm-Message-State: AFqh2kotHCiaRXGYSDSJOQh28rSk3fNDqT5jKnIcg5xEDv7iX1bScYLC
        1NQxi9bOy714W0D8Z3KDcao7Ow==
X-Google-Smtp-Source: AMrXdXtEJ0IXXXeHfxAVzoEs7V6Xjo/5d+ieHP1plHxTO/EMvQMZ9tNJCAZCafaSRq3v9Tx0n6kA0w==
X-Received: by 2002:a2e:95d9:0:b0:27f:bf70:e55c with SMTP id y25-20020a2e95d9000000b0027fbf70e55cmr1674857ljh.28.1672131595121;
        Tue, 27 Dec 2022 00:59:55 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0026bf0d71b1esm1534837ljp.93.2022.12.27.00.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 00:59:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     ye.xingchen@zte.com.cn, ssantosh@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] memory: ti-emif-pm: Use device_get_match_data() to simplify the code
Date:   Tue, 27 Dec 2022 09:59:46 +0100
Message-Id: <167213158108.15520.8320653916524293610.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202211171939327684154@zte.com.cn>
References: <202211171939327684154@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 19:39:32 +0800 (CST), ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Directly get the match data with device_get_match_data().
> 
> 

Applied, thanks!

[1/1] memory: ti-emif-pm: Use device_get_match_data() to simplify the code
      https://git.kernel.org/krzk/linux-mem-ctrl/c/271c9a97dec87341bdaea685f3502a0ed0e4a1af

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
