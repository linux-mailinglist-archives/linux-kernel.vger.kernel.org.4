Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467C067C881
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbjAZKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjAZKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:25:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB197A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so808397wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaR5jhwi5YrHF00X8Cya5skIPkeh6XZxRWs06m04ENk=;
        b=nt2PilhVrW7itt7C51DeNXeJCTft96sdxsJP836usV9YupnMWLadI8hAO05M3qGBB3
         iB70BvifIT0o1q4kUwnERNQfjbyHAGQzzSKbObcrA9uZEAmuCP+Fr4l6QLSy/kLKjBJs
         e1DkkEsGJZuxnmugzMghOmBnly82iYkuzqKIwrV3XTwesH6KxL3Vw0KFFXBj1z1ESwby
         dkz+CI/jJTfiieICIwYjouZwrpeDjwKEfO3jdXCARhDeM6x0myx29340x7yF7dQO9pkV
         HRyx67flvr2QzbYV/kr6oH47S3s0iiXSY6LN6M+4yv8LcbCjqqao7q/4qyu0/xR79b3D
         t76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaR5jhwi5YrHF00X8Cya5skIPkeh6XZxRWs06m04ENk=;
        b=77tSGTa7Bsv0gtZePigKtFxcLKcl1OuQPirRgVgMoQXVvrynTuJPnHLWDrnQnZkUmk
         sQyhRv+xElf0LKCxj5SQwW3F2z2cby9r1A8wAc/FNTBSYKbzoy8F9E0Fj12dtBhBL1+m
         txHueaNwrStPeD/HO5YIYqlBtFE9mZSFvQGXvyL5nWLO/RggQrU/q/3m47Big8cVZmGr
         /sHdA5IZ8lwoOtABY4iABdnOvFy5Ofxx+6zyt/bq1Ka6/nFfHGX/u4CWc3hLmVFp+JIv
         tW0rmdDudvKNOW2sRWJL2FDuxkk4hmMoHsMZqKYxFZLAMOET4WS2ilxPnFVSJq0Jx8UC
         JYmg==
X-Gm-Message-State: AFqh2kpNW11/OexvnFzXng5ZSy8pZzgIZ318tn5jjBIuS/Exqbdp5QZV
        /EdYp5Z/ftwu9CjLjGOl+QmpzjYAGVWffGek
X-Google-Smtp-Source: AMrXdXtWigPAnLXe8lSFWu0W2aJrN030YjgS8S2EIjXr4oeDrz8kaA7Gf9cMUJ4tMmqNU4vLxZ/gew==
X-Received: by 2002:a05:600c:ccf:b0:3db:f34:e9e0 with SMTP id fk15-20020a05600c0ccf00b003db0f34e9e0mr32294033wmb.35.1674728742090;
        Thu, 26 Jan 2023 02:25:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm886514wru.116.2023.01.26.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:25:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: apm: drop deprecated serial device_type
Date:   Thu, 26 Jan 2023 11:25:27 +0100
Message-Id: <167472873009.13092.17233187905582464583.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151549.369818-1-krzysztof.kozlowski@linaro.org>
References: <20230123151549.369818-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:15:49 +0100, Krzysztof Kozlowski wrote:
> The device_type property is deprecated by Devicetree specification and
> bindings do not allow it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: apm: drop deprecated serial device_type
      https://git.kernel.org/krzk/linux-dt/c/5fc3037ae3def493360cc1b7844a9971ba2bd08e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
