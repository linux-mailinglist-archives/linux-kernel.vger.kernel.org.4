Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA385BE4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiITLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiITLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:42:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DCF74363
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b23so2459507pfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f1jyoMzYrt7oW3ZWE+v01VrggZfcgZodlLjAeFXHMeI=;
        b=fs7gdTeOnh6ajT0yIBSWXYT4L2N3b4oPI9fdr6NeMuRnaU2VkFM0XPnXpJIdeR8O+e
         kZu6hYqU/o9vRacABqPnwhkoUpbz0jMgf1ALcVRubrxJj2jsydG8IWxizoMCO+EtXdC2
         trvFye6XTiVanq/1aBOn/53bG1OHC8bjNkhYsHOc5sQzNTyuoKsCbUz0fFXct3R8e+45
         0GUjjXp0x4kTuOrIsmBslPQxt3KgCEIPDUUpgEnd4HQ8TP+rPOKplxljq+cdJY2BhhnR
         umjKU0ViLgSz5GKHAqv+/4HjHg66/OpU9SpwDoeCdTauhrpVXfCh8PNj9X04jBBfiEAV
         V+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f1jyoMzYrt7oW3ZWE+v01VrggZfcgZodlLjAeFXHMeI=;
        b=A1EbFV7yeMmoTbIoPSA0JXJTFKY057BXkDZsi5His8Ae7ItT0ezeG1NPGfthWptPk7
         jJbmyVxKjrKeL0ZYcX4Ng4OYwpbMv1Ac5hWYxHD/PcVWlgOi+n03rDoMTIWKt1siys57
         k53BFH77yO78xntXM1goNmNoTlGHDA4JtA5z7tSxk862hlZ+hVN5u5rlbCTyjVuaXv8R
         3kVT3FR8CS8H78rivmtdH02oPjhM6qhFkHZyyd7lqckicX/wWrauQ0zLn1fBsaa2j26k
         Jars8rAN0SHDLmrpbQngsvvkCn9Kxab1B0mobuW/6kDFNIrjVA4LmVR3+XIbQVQTmeIE
         7Hpw==
X-Gm-Message-State: ACrzQf2opMjWS30odfLhm249V+7raGjvPDhaX93f0r5n/EwmteOSdKbC
        SYMwaYtTgc2rb2/2nZAwaoiHAQ==
X-Google-Smtp-Source: AMsMyM5ZD2aJk5iuQA6y0NmBUSdwRh7Wc1Io0QWIX9d73pd6IVTCE1fZfBRd+zTbW5U4KgT11NenvA==
X-Received: by 2002:a63:4c50:0:b0:429:983d:22f1 with SMTP id m16-20020a634c50000000b00429983d22f1mr20123611pgl.213.1663674110301;
        Tue, 20 Sep 2022 04:41:50 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p30-20020a63741e000000b00434e57bfc6csm1348793pgc.56.2022.09.20.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:41:49 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, davem@davemloft.net
Subject: [PATCH v7 9/9] MAINTAINERS: Add myself as a co-maintainer for Qualcomm Crypto Drivers
Date:   Tue, 20 Sep 2022 17:10:51 +0530
Message-Id: <20220920114051.1116441-10-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
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

Add myself as a co-maintainer of Qualcomm Crypto drivers.
As I will be working on enabling crypto block on newer
Qualcomm SoCs, I will also help review and co-maintain
the same.

Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0556cd21f86..df5724cf608c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16945,6 +16945,7 @@ F:	drivers/cpufreq/qcom-cpufreq-nvmem.c
 
 QUALCOMM CRYPTO DRIVERS
 M:	Thara Gopinath <thara.gopinath@gmail.com>
+M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
 L:	linux-crypto@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.37.1

