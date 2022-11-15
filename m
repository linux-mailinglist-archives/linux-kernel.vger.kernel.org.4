Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E346293DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiKOJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiKOJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:07:13 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA421824
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:07:12 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v28so13535382pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTYdVIALUl9YpoP++eVlpJmeUKMRDCw8t5UXvIltjl4=;
        b=Zemr7C/GHx/NegieoNzHXBrXKSnkhmJEj85qj90eZoGg1EssVm3kU0vKtctNXmWkqB
         mKEQVjkdNTTJM+g/b6pIhoDQq1xy9HwDrzjGkKR8QLfNY3c1Q+ZYt48oYdQcclJKy3Wq
         uNE9mfi6sI10qu+bdYAZvbKKgMnOH8GL1duU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTYdVIALUl9YpoP++eVlpJmeUKMRDCw8t5UXvIltjl4=;
        b=K/3oqwKHYqWiAipWhtaPOz5bRgLOl/4XJ618zIHat3FvT2tzSwxladmuqB+t6VVoNT
         K42illnoVWqRVd5FCmxvR8n93dID3J6IDR4B+hNFYdSDnvY+XfjsNGmbL7DmUOxGMa3i
         YHiPftGR5hEqdk7ZDGpYOnWXukmKb8ipdaDn+gniFAGva7b/kwbMosjOV0N4VyPSzZJ1
         gfpB7RyIuChADT/pFDjFj5lhQ+YGhwExsipOp5rifhTIpyEznO2P2MzCP4n05AiTg1mt
         +ZkiXt2RhEA5jr6A81llpB95oc3J2nItozzWPahb3LGMja2/mwsGGOxvBzb29hSzP9K2
         B+bQ==
X-Gm-Message-State: ANoB5pnpv1/b8zhzqPxWaXy/EgcADFlJ2xMhPImQqPBbw6K0hSfrodtb
        ZcZbYW+ShDynxsMTcCXwy2V5OA==
X-Google-Smtp-Source: AA0mqf4maw/zOnFAm6mK7X2FkowQqKj5X0F+diwR9KPfh1t3egiDv/bNjxyvC1awklk5juosr0kv7g==
X-Received: by 2002:a62:648a:0:b0:561:ada0:69d7 with SMTP id y132-20020a62648a000000b00561ada069d7mr17616150pfb.9.1668503231802;
        Tue, 15 Nov 2022 01:07:11 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4d49:6d15:b250:5977])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b00182a9c27acfsm3378830plh.227.2022.11.15.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:07:11 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: dt-bindings: allwinner: h6-vpu-g2: Add IOMMU reference property
Date:   Tue, 15 Nov 2022 17:06:43 +0800
Message-Id: <20221115090644.3602573-2-wenst@chromium.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221115090644.3602573-1-wenst@chromium.org>
References: <20221115090644.3602573-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hantro G2 video decoder block sits behind an IOMMU. The device tree
binding needs a property to reference it. Without a reference for the
implementation to properly configure the IOMMU, it will fault and cause
the video decoder to fail.

Add an "iommus" property for referring to the IOMMU port. The master ID
in the example is taken from the IOMMU fault error message on Linux,
and the number seems to match the order in the user manual's IOMMU
diagram.

Fixes: fd6be12716c4 ("media: dt-bindings: allwinner: document H6 Hantro G2 binding")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
index 24d7bf21499e..9d44236f2deb 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
@@ -36,6 +36,9 @@ properties:
   resets:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -43,6 +46,7 @@ required:
   - clocks
   - clock-names
   - resets
+  - iommus
 
 additionalProperties: false
 
@@ -59,6 +63,7 @@ examples:
         clocks = <&ccu CLK_BUS_VP9>, <&ccu CLK_VP9>;
         clock-names = "bus", "mod";
         resets = <&ccu RST_BUS_VP9>;
+        iommus = <&iommu 5>;
     };
 
 ...
-- 
2.38.1.493.g58b659f92b-goog

