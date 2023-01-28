Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF267F6FF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjA1KSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjA1KSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:18:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C972AE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:17:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk16so7029067wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTB+Sh1FmmfNr1tLKZxbjWqu3WghwOXMQrkxfLn/7dg=;
        b=B2HjVLlfE6q/UwVa4QoSQdgvcxG7BhxVUtn+a+XPpz2z+nW2gFctU05wzY9lk1n17F
         q6y1dx+X8pXSQ7m6hKMx0yZAsXNvTi+2WFBvKtd8D7KLCiREuDtNy4bOmfHhKJYGysCA
         hOxks/xrS7rz+pbRUPP6yoFhkszAxEUhUf7eJ0IsHdOl3w6DAe5R8S02J2vPlNDKcS/s
         WgOD1MlAgPpZNaRrD8m3gppn/NEUqbl7TpTxNjlNKKIr9pdKS3bAAaf+zzkoasY/p9RQ
         SadEvz1g0ncVgR11Sxkx3pTBIKmZdlPdwQdC3DDPaFuuv2+x57MNNUcm2oSQkvQgdYMH
         QnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTB+Sh1FmmfNr1tLKZxbjWqu3WghwOXMQrkxfLn/7dg=;
        b=IgCudIvCHpWP/5qTXE4hqO6z2eLnivGG2Mkx786IuY0v9pQ6bmgckyOEaaDXEKG3ia
         ugMJbomH4m1W+xTMS0i39rbCrTcUYl+wAnelVE9qFg+8eJ78Qn7qian4otEAvpJGFur5
         +xRyHhF0zv0sALTeN12Utvk7E9AbVn0VQn2M6JDc+E2/v5C4p6BVG3SfKBvD9p7Kkdkl
         CCWxyk4jULrzutIM/0lQbJZEmL30sUMVaSPC/7XdMlR83cp4+oViaHIopPafIc7M8nva
         3fTX1DYjb6+QnQr6im0tC175Pl86/ysSDLk6DNDh1XHBBAaMYIUZY4l2VN+fgGuYJ4jV
         bIMw==
X-Gm-Message-State: AO0yUKW11DRV2ygRiRCfRYt/y8g+8WgQJ3dkQLQCA7Rj3iUujpCJCjZ6
        yH68pr223ZjTWx1R5q5YmxLCtw==
X-Google-Smtp-Source: AK7set+hyMtoczj8aQu2cYE7X5al7kO2Jrw/SHZmkuP3xybrYdKuqG5Eq4Vlc+8nOCysRYd0cdOLoQ==
X-Received: by 2002:a05:6000:603:b0:2bf:c319:d1d8 with SMTP id bn3-20020a056000060300b002bfc319d1d8mr9344998wrb.42.1674901077441;
        Sat, 28 Jan 2023 02:17:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z4-20020adfd0c4000000b002bdc3f5945dsm6112812wrh.89.2023.01.28.02.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 02:17:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: amd: use "okay" for status
Date:   Sat, 28 Jan 2023 11:17:52 +0100
Message-Id: <167490104051.6514.1833459588266397303.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127101829.93761-1-krzysztof.kozlowski@linaro.org>
References: <20230127101829.93761-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 11:18:29 +0100, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred for status property.
> 
> 

Applied, thanks!

Let me know if anyone preferred to take it via sub-arch/SoC maintainer tree.
I'll drop it then.

[1/1] arm64: dts: amd: use "okay" for status
      https://git.kernel.org/krzk/linux-dt/c/9f2c9170934eace462499ba0bfe042cc72900173

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
