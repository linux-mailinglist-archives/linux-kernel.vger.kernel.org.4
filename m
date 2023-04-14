Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F876E2518
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDNODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjDNODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBD7A5E6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z38so2823488ljq.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480973; x=1684072973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76axTl8cbJUBy7OLAwyWyTtD7GTYfsTJiThiXMDIx3s=;
        b=SB1cVRyWZbrKZUFHSptgTkU1gCg6LU7UXA+761173EAj6Vq0hW3AwJe9c1WFRia95a
         y0/8K8hQMEDHSv7dvOdub+XGJE4Og/J8gc3u+1c4ZCYsBgtuq6vbexJ53O3gINqltJev
         CA5R5tLb85MQ+wtym2dYzB10QlkOI++8ifVF6o5z0LOG70v8JVdgoLFO+SVSGLZkONoi
         GMFrh22TWgY0MJFeT5YRpgnePigt/z8Lxd+XVKVpwXSHUDDJICe9h2ZWnh5aqTiLRB26
         LzfR+GRmY+4c9Vh3opEtGsC5KlBNPtKojYkByTTCIgb+mc3gn/NtI9g5zL/s0D8yZ8hy
         E+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480973; x=1684072973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76axTl8cbJUBy7OLAwyWyTtD7GTYfsTJiThiXMDIx3s=;
        b=HBi6j9hs6aTbwkabNtTGIgkH8fcv25w46ASsM8KNzT4bGy/GCIzLLtIPCWpjGX7J8U
         w/bw4pBcq+pxJBhrVS/pbJNYvpvmLPZh+szc0At5U0kcKPHM8WNhFfDo+WaaxDI/4Tft
         NZWeO+SKdK7TgLvV5GohNScqZHMtIqvxC0a8K/EPGv+yjHSSpBa8xYNxv6aJL87Ay92X
         NpQttNOIWyARDSRHW2aHVLcOOAo3r0zxTtAs7D1fXZcgAILkm/3pWI5vDH42KRAbmS2K
         vtGChZq0aXgx9jg5Jxh1Aes6HB7kLuR8Y1g4UGvSiGXh2BNqucYDgrlJKP90PmeybQ0t
         TTng==
X-Gm-Message-State: AAQBX9d4/v0Pgitp2eBSNJJ993MzY1Kwlwq+7XkIiqYtFb23shEOLHwR
        BXlaJW9kLt9wmqmUKFUtXKmWGA==
X-Google-Smtp-Source: AKy350ZzWs16uKXN2YB3yLTeEJy4YSzcbJzgsMuyu+FmMB5GC0CIO/mMbAp72GN1rsJ9oQhuSxCppg==
X-Received: by 2002:a2e:9b49:0:b0:2a8:ae90:83d6 with SMTP id o9-20020a2e9b49000000b002a8ae9083d6mr584641ljj.48.1681480972484;
        Fri, 14 Apr 2023 07:02:52 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:52 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 8/9] dt-bindings: ASoC: Add mute-gpio to ssm2602
Date:   Fri, 14 Apr 2023 16:02:02 +0200
Message-ID: <20230414140203.707729-9-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mute-gpio to ssm2602

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 Documentation/devicetree/bindings/sound/adi,ssm2602.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
index 3b3302fe399b..132aa9668e7e 100644
--- a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
+++ b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
@@ -11,6 +11,10 @@ Required properties:
   - reg : the I2C address of the device for I2C, the chip select
           number for SPI.
 
+Optional properties:
+
+- mute-gpios: GPIO specifier for the mute pin
+
  Example:
 
 	ssm2602: ssm2602@1a {
-- 
2.40.0.634.g4ca3ef3211-goog

