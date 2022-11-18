Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9BE62EDEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbiKRGws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbiKRGwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:52:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D0F1F9EB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w14so7809917wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY6KhYAUR5ucFJNuLPM9f1H+df/2M9xIYSbpdtp87Ek=;
        b=u19VxxE41bJu7vss7eTcPTQobv6F7nMKdzL47mu2Xo8FQHZSrCJoaWzspf8e6QUjZf
         02+eJSSrMdRXUI8/x+KRAKfnPUMPWfeJDPOblB1e0SGRLwPJDboqEdbltlETvsbdv1ax
         FGA5uOcfuwwdZlJbGLMxkCECW7V98bsVf4Xb3tB6aJUUwd6jgP/ftEIdyGgqt0LecO9r
         riCZerC/sgwjJBleTzqtwEQsfVnPhlnVLgk1CwPAb5IRtrUMa3PektXb3nwSL+3KwI98
         Bv2qDAWGkKaIK/PNUElcYDAoVz5r5QtubkXd233Kt5rNc3Fc6y3EXmc4MlGwDdPQS9Dl
         fCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY6KhYAUR5ucFJNuLPM9f1H+df/2M9xIYSbpdtp87Ek=;
        b=eRs1BmogCrQNL03btwldHu0Syvmejb/6T1AYBM0sGVlDqF2JA3ALXSZ34sZeQoyM5V
         ZxKrhItc2XR4vML6W35nf2VXdzpxENY5W2V97IlD83VY6Ex9jUjTUa8iFwRFI+RMtOpb
         JxmWPSM1mfmUhHp3A7NHZJlQsUDWeLV0a2s6hPlvJlUmOxc4S1Q7ndM3sY41Jl4dMuQG
         7UY606bZwdmoIEy2w47xjikNZVamLhFXAtpmY0IX7NIXG1H1glrIt1egZcYV8uOz1/Gu
         16eFGPKR9SG5HGyubZ5b6rbSPR/BbDSueRYa5q1n/URZ1zUSPShKFXg/LKMzk1W5VaGm
         tHLg==
X-Gm-Message-State: ANoB5plS2s6tN5xw6dQIScuE0GWVkFu8JW5flXx8iJmtT+MCnyOqNhtT
        hqEhPYZ1x/ml+AYGi8RssAg4QqBJZWvaXA==
X-Google-Smtp-Source: AA0mqf7XskUTyolLVpF9es7OHwU1yYs5u+AkZ1hYqh0p8EPqTVe6aDY7tEDtcouxkuu2drHAgej/Yg==
X-Received: by 2002:a5d:408b:0:b0:236:53d2:1668 with SMTP id o11-20020a5d408b000000b0023653d21668mr3409646wrp.694.1668754360904;
        Thu, 17 Nov 2022 22:52:40 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003c5571c27a1sm4400165wmo.32.2022.11.17.22.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] slimbus: stream: correct presence rate frequencies
Date:   Fri, 18 Nov 2022 06:52:28 +0000
Message-Id: <20221118065228.6773-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065228.6773-1-srinivas.kandagatla@linaro.org>
References: <20221118065228.6773-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Correct few frequencies in presence rate table - multiplied by 10
(110250 instead of 11025 Hz).

Fixes: abb9c9b8b51b ("slimbus: stream: add stream support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 75f87b3d8b95..73a2aa362957 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -67,10 +67,10 @@ static const int slim_presence_rate_table[] = {
 	384000,
 	768000,
 	0, /* Reserved */
-	110250,
-	220500,
-	441000,
-	882000,
+	11025,
+	22050,
+	44100,
+	88200,
 	176400,
 	352800,
 	705600,
-- 
2.25.1

