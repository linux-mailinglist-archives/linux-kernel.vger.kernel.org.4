Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ABD609958
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJXElt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJXElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:41:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD8796B7;
        Sun, 23 Oct 2022 21:41:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so5879155wmb.2;
        Sun, 23 Oct 2022 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDghWiI+VfS+QbKsUYVkwYkySZv+irXHu5fI56T3Y+4=;
        b=jlyQHSJVM1ckmfkQqatiCEvt56zwVDqmhlesOcj2hUCDfSNEATcIMva4XyKHKmRVCM
         E8+8vvmQzrlbtezGSedgSuPUNA1sp9CXCCYkZU4IX+y+TJyYmW2pYEp2PEL6Ym1QaaVT
         Bo0DRy7zzqCxbRUqyC/7zkRkQNM8fLk/6EptXnoc1Drw8kDCwHbqHaIbA8Jz5I9MZkzF
         lsUgJ/3ru2Op4WJ1/GneBMKx122g7kX0HvoKNd2X6PYXfT2QB20QY4CA2JpgjvZGlpe7
         nFHcw9QV50nm1N4L7R6mbGrwSYNo8YfFcvDVAI8iQHv2qViayLAQQoeYraSKv+N3HkTP
         K5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDghWiI+VfS+QbKsUYVkwYkySZv+irXHu5fI56T3Y+4=;
        b=Ww4gx8V5UJBii1D7NA9Gx19/4dsEVDtAMZuGQOny/LvUEPFbzfmAbzgdaxRItsBzHD
         zX7HPZuR/zJweSIWXQOo+J4wW2bNJohhZkuhEsyWba80OKFuKZH1g8/jWAkIigGoGdB0
         qjrLSKhnxMy0tuQl3ztM1ib976T0p53HETTEcJz/FPG5j+AXd5mwlLCwF2LCzz3edtvV
         DIiIV2eRQKcboQJ1/hh7IAhHF4AyB5/ukdnyFeQRWeSesJTfgw98xy8aO2Oisxi81etS
         tfGMn5PyMR4BFlUN286le9l4Z46dZ814joQeAwElJnbXeQGP5UeRphhU/j/2nxd+Fchq
         mm9Q==
X-Gm-Message-State: ACrzQf0XI4f38hErPBHk2O7arhTCUpHLbWOPAg6oLvP43qJ7NSu1CBX1
        im32z0BXOqAULMZp2Lg2qUWxSfw/dV1Y7w==
X-Google-Smtp-Source: AMsMyM7/GqaYaC1AJQ2QYC3SMzZalu0BZTNZmtwLmb1125xUtGbYwsx/QriCaCetJVEQsVIKnrrnew==
X-Received: by 2002:a05:600c:1549:b0:3ce:794f:d801 with SMTP id f9-20020a05600c154900b003ce794fd801mr2623380wmg.63.1666586495423;
        Sun, 23 Oct 2022 21:41:35 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-197-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.197])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b003c6deb5c1edsm9856925wms.45.2022.10.23.21.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 21:41:35 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: ingenic: Add support for the JZ4755 CGU
Date:   Mon, 24 Oct 2022 07:40:54 +0300
Message-Id: <20221024044057.4151633-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221024044057.4151633-1-lis8215@gmail.com>
References: <20221024044057.4151633-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the clock generation unit (CGU)
of the JZ4755 SoC.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index aa1df03ef..df256ebcd 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -22,6 +22,7 @@ select:
         enum:
           - ingenic,jz4740-cgu
           - ingenic,jz4725b-cgu
+          - ingenic,jz4755-cgu
           - ingenic,jz4760-cgu
           - ingenic,jz4760b-cgu
           - ingenic,jz4770-cgu
@@ -51,6 +52,7 @@ properties:
       - enum:
           - ingenic,jz4740-cgu
           - ingenic,jz4725b-cgu
+          - ingenic,jz4755-cgu
           - ingenic,jz4760-cgu
           - ingenic,jz4760b-cgu
           - ingenic,jz4770-cgu
-- 
2.36.1

