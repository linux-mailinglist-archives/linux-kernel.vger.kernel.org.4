Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9660937D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiJWNOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJWNOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:14:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C17786E3;
        Sun, 23 Oct 2022 06:14:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l32so5039940wms.2;
        Sun, 23 Oct 2022 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxfKzDWxx2hZvtseS2X/4UtMYIVk+yBwmQtbqcDgw1I=;
        b=b/9vy87mCP+VCGX/9//iTbvK2+OgMaWJQKD3yBpi+iIcqBeDANb406/K9CMiOzcf/L
         bHyCGNKRdaMafzPysr89PttGH5j4yxBeJwlBHqJ0SYq24klUxtA8WXevm7dU9XEgBMcg
         qWOGTY9yMkgFk0k9gYkIF8ucZFkX5HzHdsXBwmnGFBgx44YOmWRVilnwKGW+kM2V6y19
         SoAUXAmhbK2pgWcDLkBMYdDKkvY/uKiHMo0D8a/z86rRr+kruSkFOCcAwP0H8Xx74ZZJ
         8g4cdTdrhsXUIo0B/9cT7NDEys3HUfuQq/TtPB+jDJCzRBKZTBunj8T9r+Q2yVNcjrFA
         mjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxfKzDWxx2hZvtseS2X/4UtMYIVk+yBwmQtbqcDgw1I=;
        b=Id0MrulfyI6xgxwDA3izbftMuBKD8rvdT7sbBEjFvE7yqRnsAmvwX5dIQ+p5ewMjbW
         t60WU5Ii5dPR2kYL3a6uVd4NGjAY9zcGgI6a96ZlFt0yp/YgSHU3Se4xeX8cmK8R6hwe
         /0PrbohD9JiknrSD+kdX9yT5od7NPBmmWCs+Vi0FUW/AjQCTXNKXi5piX5yyVUupKAD7
         sFHmV3xBGLIt4mEea9/pgty99a319SapBryOmAHHH0SXa/qtRFS8/kblb32bFq9getla
         mHnVEG2jBH9fJDRJfqx0U65ZNqLdJWcbSMvM3/JN4mNnhjoRsAVNtlktbJfgZkO/2DnK
         ZGuQ==
X-Gm-Message-State: ACrzQf1Yb7yLaWh83sUaeqR+BsTEtuQJ8wS+IV9ar1yoVJiZKQHxhJjj
        xcZw3uKLpXoUKninQFKV/Vk=
X-Google-Smtp-Source: AMsMyM5u9rClkxZnCPZLD2soBSHt5iYVXzvMah2ityjOQ+63AI+FHjLP1UW+FnsI0tICtXyiEHXYiA==
X-Received: by 2002:a1c:f002:0:b0:3b4:dda4:b58f with SMTP id a2-20020a1cf002000000b003b4dda4b58fmr39092992wmb.184.1666530837648;
        Sun, 23 Oct 2022 06:13:57 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-19-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.19.133])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003b50428cf66sm8302475wme.33.2022.10.23.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:13:57 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: ingenic: Add support for the JZ4755 CGU
Date:   Sun, 23 Oct 2022 16:13:29 +0300
Message-Id: <20221023131331.4107782-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221023131331.4107782-1-lis8215@gmail.com>
References: <20221023131331.4107782-1-lis8215@gmail.com>
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

Update documentation prior to adding driver changes.

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

