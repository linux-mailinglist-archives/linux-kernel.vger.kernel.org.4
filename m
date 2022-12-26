Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC465636C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiLZOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiLZOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:32:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E9BF5D;
        Mon, 26 Dec 2022 06:32:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso1067644wms.5;
        Mon, 26 Dec 2022 06:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7Uxgqg5mAtgEreFJVlyY9FG6dh29sWzofDPJcOPslk=;
        b=m9yLIp37lG4ssHCA3fqE179rPKKkHexH8euixga72Zfo0s2wvxCE9klxLP7kwPsEgU
         ZhzBgkmCsyWVUMK/djzAgCkiFU80YRlRjV7df3GYCAgm+BlikVqvFhXyC5OR9locaWug
         N4m/7ZyhyZHdELBPrrVVW4YCaCwVmBlnlFF5QItskhP/4oelT3Pl7nvHohrK0elJcuGq
         gVDDMHDrmOyCgSurZKLfppxnsE2BblPqk6x6A7cHQTnTVciiF/9LHH5ht2zb4pUmRzUf
         wafj+Cvy4+Gz04emapaed4Sfri7WYVD9HbO5DdQyMevRHDM9VnpjMMpuuOZ2mIhUwmnH
         IHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7Uxgqg5mAtgEreFJVlyY9FG6dh29sWzofDPJcOPslk=;
        b=K6ROG1u2/cQOH9yWFRQvcKVTUHTwh5LE0fPybe/NxSDF32RI/6EHqsumv1QN/FFrs9
         cSHJrYuva8Hwfar9eEF3/zB/NSpFUNjkIMxz1sD8QRLHrxm6GEz7bMK2jmNQcDrtgKdZ
         H3lLlj2IC94VvtQc9mJSVNc1B+AEETAG8xH+kQxGjYgd6ZKVmL949/BGRTufcL/WoqDP
         1lcMVxb0iAT1SwFGcACck9dTBZwxe8szFhCC0HJCkDBxCjJ0wfYXa3XYYK3kibb4TGSp
         QwrN/TGuCAW8NnOXY5qb22W07+4D14CaoWBUH9kO6bKNsr+oMwM3AnJpuCc8uhpDlL3o
         Fmzw==
X-Gm-Message-State: AFqh2kp+Gfgm0zogjSyKX+t3uOohjtYuneO1h0NpibWdRFFrbSpTShVO
        uIhfjN/5vq1g4gnuqdtneAKAnk2ibAM=
X-Google-Smtp-Source: AMrXdXtN/OwhX3uMo5jpwxoLuerHvjoeJKOys/6qW9AMtCQ07sRkRubq7pA1rDQ0X3L1VY9eXIagOA==
X-Received: by 2002:a05:600c:601e:b0:3c6:e61e:ae71 with SMTP id az30-20020a05600c601e00b003c6e61eae71mr15947590wmb.1.1672065154359;
        Mon, 26 Dec 2022 06:32:34 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf75213bb9sm21511754wmq.8.2022.12.26.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 06:32:34 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
Date:   Mon, 26 Dec 2022 15:29:23 +0100
Message-Id: <ec7500c211cd545391c0e55da4f8753e2c38dedc.1672062380.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bosch,bmp580 to compatible string for the new family of sensors.
This family includes the BMP580 and BMP581 sensors. The register map
in this family presents significant departures from previous generations.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 72cd2c2d3f17..f52c4794e21b 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -17,6 +17,7 @@ description: |
     https://www.bosch-sensortec.com/bst/products/all_products/bmp280
     https://www.bosch-sensortec.com/bst/products/all_products/bme280
     https://www.bosch-sensortec.com/bst/products/all_products/bmp380
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp580
 
 properties:
   compatible:
@@ -26,6 +27,7 @@ properties:
       - bosch,bmp280
       - bosch,bme280
       - bosch,bmp380
+      - bosch,bmp580
 
   reg:
     maxItems: 1
-- 
2.39.0

