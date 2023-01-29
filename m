Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37C6801EE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjA2Vvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjA2Vvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:51:53 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506721E9C7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:51:45 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so4074387oto.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71n2f6LaAOs/UKUBQCaEZwgVWiBSUJITufR8To5woBY=;
        b=L6eIVZMrTKuAQPRfW6Wv5Pg1cdc1lruPW2FttnN5r8aS3QOAsiR//a7Z+7V0acX12Q
         XkWbaLi0pmU2oJN3fBnlwYy7GIZiVJgSb4xiKhUZC1+8uoGS0Bn5dS58DeULoIkswLtR
         9b1rQNAG0EAKyhLgO2YssBRJn2/OHAAcOCI8onyQDhB0ZnKOEYMtMmw1fmz/SsuBblvW
         lNd1lrkkw76aA1LLaYLf4E4JYg+rx0v7O0Oj9G5Gy68tamnvxvgCTzS+JQqpRk7NJfYh
         bc7S5XqhQJ9a3sSzBVUck7XQzqMVLmwGSBOvrArqsT7yVqWzzQyswq03R4L7QHnC2qKr
         qtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71n2f6LaAOs/UKUBQCaEZwgVWiBSUJITufR8To5woBY=;
        b=Z0vOfHdFzzFkM0L36niZXz1ji5Xw0Lh3irb4UNhkCtHgJDNBwnd5dOVILbE9gRWcsQ
         I23inDK1lMQr4DmIcDMfosfxDRmUwTdgnbkWOB82wI0j5EpaUIgbEgZcwJ3Teq7dvjtM
         Nbwjlgx9nyTKfWUFJz1bNr94SHn5sYzVW9ybRFR7EX3+wxKL4wmjb2xlD5aaqv/vV8u6
         KBqk/yeg0bYiYFNGxG2Z+Qlp9thEqOvPohm1PAsETAMljG8wfoo7zxH7mE3bn9N80NNI
         YR40LtDBje5gv4VdzXso4yqdenzE2pU3lmLeOehHCtkYdPs+X9yVHKo7cwg3VuhXapWB
         h0TA==
X-Gm-Message-State: AO0yUKVgBECrQ/8GH/xvg/KNOKV7Ohu/Qak6Usnkq3jQ2FRG3eTOaZJv
        Ba3Hk3RwYp3HleGfmHFjGCXcdg==
X-Google-Smtp-Source: AK7set9ONITmwN9cCRMw9QPW/eprPZ69frn6FqrAMTORzChGi41vU0fQn9/SWkAWbKZkJe1MiXB/Gg==
X-Received: by 2002:a9d:825:0:b0:68b:ba93:6c11 with SMTP id 34-20020a9d0825000000b0068bba936c11mr3854567oty.23.1675029104568;
        Sun, 29 Jan 2023 13:51:44 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id s33-20020a0568302aa100b0068bd3001922sm335340otu.45.2023.01.29.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 13:51:43 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: net: Add WCN6855 Bluetooth bindings
Date:   Sun, 29 Jan 2023 15:51:27 -0600
Message-Id: <20230129215136.5557-2-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230129215136.5557-1-steev@kali.org>
References: <20230129215136.5557-1-steev@kali.org>
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

Add bindings for the QTI WCN6855 chipset, based on the WCN6750.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index a6a6b0e4df7a..64e278561ba8 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,wcn3998-bt
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
+      - qcom,wcn6855-bt
 
   enable-gpios:
     maxItems: 1
@@ -121,6 +122,7 @@ allOf:
           contains:
             enum:
               - qcom,wcn6750-bt
+              - qcom,wcn6855-bt
     then:
       required:
         - enable-gpios
-- 
2.39.0

