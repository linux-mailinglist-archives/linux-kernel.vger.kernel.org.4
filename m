Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA37363BE01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiK2Kcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiK2Kcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:32:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115062FF;
        Tue, 29 Nov 2022 02:32:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y4so12980001plb.2;
        Tue, 29 Nov 2022 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QeTQq6wzF697oGF5V/c7AcE3tcQdYXM/Tpo1+r5kqU=;
        b=aGy2uFGGpvGA5zC4sX5JxR+ucQECH5mvVl5Afol1RUhkbXOCv83wc+z+CycE7yYEjf
         6TBNA52rhxBZUtQ1o5Sr4po8rwiBI1u118tarIqDA0r5IOU4GnQOumwZGlM7miIe/okt
         ukXrlDLd38tpkzDZwsFowlbTcw4hMhnqCJqpQAxFhc0t0C/iqoHLHoSKc6dyE9mCHQuP
         U6rdjeNoCqcFrHmUI+wAImKWNNwYA/b+5zt7SY+fQpBJtqbW0Z3dO+TbJ+0ar3QoF64Y
         KrTkQrpoPKYez0G3jfCYf0K5HoIvPNdRuWSPhENQOfqYC7ZCo+esexZTI+9I95uyJhkB
         9u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QeTQq6wzF697oGF5V/c7AcE3tcQdYXM/Tpo1+r5kqU=;
        b=JbzX0N3A85gkYywzk524LqY+a2KNv1FGYK1jfKbQWJW+ZLtO0oQZm/BuM5kfCfDAeM
         VVa1JtqkzYpsoft90hQ7XCvIizCLJnc5u+5seAS/ZqlLABmCM2anOEROENIkkeKNzd+h
         pYy1vxfyyPghcYuWK2mGWvCH1Edsj73YgOhxtI+1i8RJOIpN3KJapnEoUeRvLWeYAx0G
         lVcHAoW1fXUCM/qC4xH18kgKxkX8gef0+llhcbULTxY5JVI1fIjmAIQrR11wJjBrZWxj
         oyfp14Q31ckX5o7ZEDGu37I15XqJEZqQ7pDRyyNcpSc4lxt4+NnXiMvVFxpMHCNGQBle
         aCwQ==
X-Gm-Message-State: ANoB5pks1OVtPJe1DVEZLkdHtdYlFHp+Xm9q20hv4PcKt5EeSTpSzPse
        cMHonkocPa3CtRjQi7fwQXKgNRhyStM=
X-Google-Smtp-Source: AA0mqf6kmMIRV9OUMA1FJnSq0eXaLrI1mmp5BS42ToHHOTbEt6Te0E49+v2hbDa/1ZA2tl2tKHcDHw==
X-Received: by 2002:a17:903:40c9:b0:189:760d:c5e7 with SMTP id t9-20020a17090340c900b00189760dc5e7mr4421270pld.39.1669717956557;
        Tue, 29 Nov 2022 02:32:36 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-5c2c-fa0a-e67b-3955.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:5c2c:fa0a:e67b:3955])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090ad59800b0020b7de675a4sm1025234pju.41.2022.11.29.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:32:35 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@google.com>,
        Matthias Kaehlcke <mka@google.com>, Harvey <hunge@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Tue, 29 Nov 2022 18:32:27 +0800
Message-Id: <20221129183213.v6.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry in the device tree binding for sc7280-zombie.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..7ec6240311db 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -655,6 +655,16 @@ properties:
           - const: google,villager-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie (newest rev)
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE (newest rev)
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

