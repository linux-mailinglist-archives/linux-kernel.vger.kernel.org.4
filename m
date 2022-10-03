Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558805F3692
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJCTnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJCTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:43:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E548CB0;
        Mon,  3 Oct 2022 12:43:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r6so18226635wru.8;
        Mon, 03 Oct 2022 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3RLX1VxjXOs3ZcDQ2RhxhL9p3wd3mTVn1GXIHd4zMVE=;
        b=FqB08cxtviPNqjGDYUnRQ1GKeRD2FPwtsz7gA1tuQ6pDMzN9WIo8vWohuMVuey3s8A
         iri+aBxfRbIYUOmCLP1J/UvP/mt8kQL3SXq3lJGY/h0ZEJJixiYBmqEKZj4w6kJRTCmo
         grn9yhhEe+Lut8LLphj9/xEuUcl8/AiSIW+q4pWEV+2G+6k2PQdIhwaldT5UeyURNR4y
         +pQr24syzWGOHTkTpvTozK0AFTDMWRPXCTkwD7yFYP+Jt3nNpWuqq++jogYN+MvKm/A2
         A6w7qebfrUKkuyu2N29G/SW5rxylkRwOmIH22SI/cWe4iIfAvtKDW4YwyeHAcFkGpxCI
         dsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3RLX1VxjXOs3ZcDQ2RhxhL9p3wd3mTVn1GXIHd4zMVE=;
        b=W4fS24Qwf2nLOO8/sO4ddwVzfMbbN9gPNBx+5Nrt2rw+ks5nj5XERhuQozwbo/JnEx
         DYperSicKjsiWXMQER3zV7gaYgkmzDaiUOUENzRryHyO6VElpC8IQNhhYacYsMyV65wC
         cndl8RrhZK1217dPrW6YXkTO6VtGN3i9WKzCvT4Ey3F0qbLYKQ9iTY8yiR7A2s06Lo33
         YXlU3xsSURqu3I3Ubxg05rJ1Bp50JUQDJgMYrR7+RKgG1ThmjoM8O3DXy6JgBJVxzbIt
         e5jkgGhjw3BpBml7/KqBBidSx/GhS4LBLozX/eOwmJHdpcWcFdl4EncRUpHE8mFZ8npP
         4B3A==
X-Gm-Message-State: ACrzQf3S7B1yn1v2Sp3Auxo3rYidn8LK29OWJXgFTUmqhTw5T3K+JlQJ
        8Dhs/XglzVqktDKgccv4R0dXYNgA6yo=
X-Google-Smtp-Source: AMsMyM4pKfGdBvaeAGrqDGa4Q+3gGp1bHraBkcQjvKY4HPheZk6WeUzmJrD+smUyNX4cltbOhGNL/w==
X-Received: by 2002:a05:6000:1882:b0:22a:f7a2:736a with SMTP id a2-20020a056000188200b0022af7a2736amr13930335wri.691.1664826205733;
        Mon, 03 Oct 2022 12:43:25 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id q5-20020a05600c2e4500b003b50428cf66sm12041663wmf.33.2022.10.03.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:43:25 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v5 2/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Mon,  3 Oct 2022 22:43:15 +0300
Message-Id: <20221003194315.943903-3-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221003194315.943903-1-dsankouski@gmail.com>
References: <20221003194315.943903-1-dsankouski@gmail.com>
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


add xiaomi,sagit board (Xiaomi Mi 6) binding

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v5: none

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..294075bafb97 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -239,6 +239,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

