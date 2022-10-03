Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1625F3617
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJCTGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJCTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:06:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098813FD43;
        Mon,  3 Oct 2022 12:06:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc7so24257942ejb.0;
        Mon, 03 Oct 2022 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Xwi3N9ufURz0LduITDGK/fYkJbQHXdCmTWzD6dC6eX0=;
        b=lZt4kWPTns37s1+otZvwgXHWnAt6/kr5Aqu20qAdRWBEQVDUC8HTLd8opLhfZAdAy2
         cYeeCNaz62Lb8jtHlf6oPtRVBqUf4ZEr8kkBrz4CPlCGWymRz5q4SclO6ylr6812Dn5n
         ZbjdA1kSpAu/7npKj5KEp7fQybtYSW1S9i8C8f8uIWlb5SxYAFOuxXLWMU5NLigifhbS
         I0QZ5nRjgsTWhh9hHTyiX/RUgAEFfBgR27d/2vr8eI5MqOmvoP2JRU3vB+/FyOLPK7I6
         bJ//vUjRo7oHVGEqxZxVKkC4Ka/D4HgcqlCxQFelxSu2wzzAfCTaady4KE+eEOEsSY0r
         kE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Xwi3N9ufURz0LduITDGK/fYkJbQHXdCmTWzD6dC6eX0=;
        b=J0UFDCyvfzVBFrqSKYTknSaJlGixDj10mL0Qbaw0vJgOHjeCLa84PGFROHylb7pJUs
         P94bVtEEhQV1GqcrbCxeZqdE9jsG7RKqZ+ZN9DdmBZYVQlaogewxFHYGjoYf4qRVROJM
         JeoDK2cqHNVyudhp1jhuCIqC/g4jz1u3Av/IKspc16+/87C9hTe48st5ac5QSSnXKQZk
         ctWRGkSlXjFZerdJY1Fy497yVbniVcJ2HPsawGTu9zz7Udf2R0lapLY7oGwL/Kx6tezn
         QqYMAhtsbeMTQLvUGmS+dtuzeUIb44R5EbYn/Vg/bav9MHBoosdE2eXYsk/R/dqS0EQY
         qkVQ==
X-Gm-Message-State: ACrzQf0/hKEOxh1NL9NM6mu+NC81G+MiRS/c/Jo7KysBFI6mn1GYDu6a
        6bOjjFD5LwfStV9TRsq0egyfJ11djSY=
X-Google-Smtp-Source: AMsMyM4zHtx5kFvWJGstOQno6SwvaOC6j0Q6TGi6EG9FcMvM6BWpyZhMR58610Rg4ozDqtAo+UMr1w==
X-Received: by 2002:a17:907:7fa0:b0:782:9713:1e with SMTP id qk32-20020a1709077fa000b007829713001emr16609987ejc.394.1664823964282;
        Mon, 03 Oct 2022 12:06:04 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id lc23-20020a170906dff700b00787f91a6b16sm5883975ejc.26.2022.10.03.12.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:06:03 -0700 (PDT)
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
Subject: [PATCH v4 2/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Mon,  3 Oct 2022 22:05:56 +0300
Message-Id: <20221003190556.931678-3-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221003190556.931678-1-dsankouski@gmail.com>
References: <20221003190556.931678-1-dsankouski@gmail.com>
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
Changes for v4:
- remove unused 'sagit' compatible line

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

