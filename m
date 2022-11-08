Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAA620738
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKHDE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKHDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:41 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B456303C6;
        Mon,  7 Nov 2022 19:04:28 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id w10so9480549qvr.3;
        Mon, 07 Nov 2022 19:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQdXfHXD2jNc0ULYmRYiq2ER1KgTrvIMpk00EXTgBbk=;
        b=fSd9gd4ITO8giAB01DCxPo6CQY4cqBdUzCqMZxzeWDo8oz2WA5KgveboE/XaGKB+3S
         nt5dmUFhh6o3KGKBZ2orp/ecKnyrLiax5vT2cF3NoCWbBu9ZI3wmhu5ZaO2w5oACtGbs
         /Qr4XpEr4GECJuamHtuRn08H8opIqw1T/Sw1UH4+ywe8LY08syhtFSDJbKbWPXuxCbgb
         1TabZraKGMeJ3avcyXmTB5oR0cqxTanyr9ZySg73yesw0p4NJBRoz7RFQPP0ijAX9i6A
         cBrzPCVqERVVVj+Sngap5sJBU2cqzmaAb6SUVFpOzfEhOzEiL4e0pItQBWhHZLCrKvuc
         aOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQdXfHXD2jNc0ULYmRYiq2ER1KgTrvIMpk00EXTgBbk=;
        b=Gi51D23Gsc7rCrnS9cec15YkYu6g9ebA5hh4JFC/Ic8kRX5u2qjaSOAGIPbsDkxL1B
         ioRCAjwWHlxK1Bb3ySd6CVeim4j2jB0dMRlDzx4G4KvEhgd/CpMb2r27JJoSNypnRgSf
         S+Xxdd0jFpTL9m9jG0yq9bnh8IlXWTLJznfSoLh//gWRAxtc0hBtFZjX4HB1l0zynlOg
         AFrvDBBfKs0+6oUPSS1o4l4mLxORxUEdQvGiWsSCpSUlxnMrmV1D0IAtEsBg1sIYmVtG
         l9fg8CzJ1cV+1I2W/x/3F5UT6ZaY4M505orJqMVXS4HytRcA/JVX4SdNEW4DIqLXAlkP
         aflQ==
X-Gm-Message-State: ACrzQf1Iv6TYnH6aPHwVY3IlyLvq8MP9fEKpFiguJPft93E3rhjmeLlK
        3uvQiA67GluBvsrjwon206o=
X-Google-Smtp-Source: AMsMyM4qVwqB40prsVkiYBEHGsEWDu0nGqaB9FhOYnGtIfeMjbNRlvsqxa92nxsvlVpV/PFjRG60HA==
X-Received: by 2002:a05:6214:1d02:b0:4b7:6a28:3e85 with SMTP id e2-20020a0562141d0200b004b76a283e85mr47104175qvd.88.1667876667800;
        Mon, 07 Nov 2022 19:04:27 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id bm26-20020a05620a199a00b006ed138e89f2sm8127325qkb.123.2022.11.07.19.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:04:27 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 2/4] dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
Date:   Mon,  7 Nov 2022 22:04:09 -0500
Message-Id: <20221108030411.59409-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108030411.59409-1-mailingradian@gmail.com>
References: <20221108030411.59409-1-mailingradian@gmail.com>
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

The Snapdragon 670 and Pixel 3a initial device trees are about to be
added. Add the compatible strings for the board.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..f9eddc22d4a4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -51,6 +51,7 @@ description: |
         sdm632
         sdm636
         sdm660
+        sdm670
         sdm845
         sdx55
         sdx65
@@ -654,6 +655,11 @@ properties:
               - xiaomi,lavender
           - const: qcom,sdm660
 
+      - items:
+          - enum:
+              - google,sargo
+          - const: qcom,sdm670
+
       - items:
           - enum:
               - qcom,sdx55-mtp
-- 
2.38.1

