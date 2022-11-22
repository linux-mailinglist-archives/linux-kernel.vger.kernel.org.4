Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA47633C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiKVMhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiKVMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:37:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F35B5B4;
        Tue, 22 Nov 2022 04:37:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d20so13477115plr.10;
        Tue, 22 Nov 2022 04:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8qg/emDfEgOySeeVTva6i4SFez57cE7nt0Z+zXTENo=;
        b=ZfN9ijY8CiymIyiytlLYgQc6qmX2hPUTX94btYZsDj9Yo2H/d2zLJHQYl6lavFfOFU
         Ptd9OCP1dC6+WH4dqskZdPkayXLtoxZ9UX9CjeDhLQt8eXUdJ7iLWdM27kgozSUTgIfL
         2RihHRemghE8F/ND+bBl0csBa3wyymosHAWeyoYGRE9Y1p03Eu0yXuEFSdwvdfd9a1S/
         13uIFA/47iDFrwoHF1BMVyLh04dXbA8xb5m6jCkdtnI6TcP4zePyCJsmtCGbmyGeiTxx
         VnwaGzwB5b+4bwrUBa1bKffoRH7O8AwJPt0aYGd6QfYmwCn3+qHTfDFKraOvP/W8KrXe
         /LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8qg/emDfEgOySeeVTva6i4SFez57cE7nt0Z+zXTENo=;
        b=33ciT0hABqnINE2fD/sOvYjQzwDNNINMmLUCeBAyqcFejYt4LJYfxJuknSApqdvxQk
         6+0OEnFfeDUisPrOWCHQj+dAkyUUFHMgzc+5+iboxKQExLYDnEWKVBgihQ/wkxlldgHh
         kP5snnzfko9rtf2jl9JyxJpFUZ/FYhZ47ZqcLnbEVT4h5RTL2Ww1Dpzhmi9s0XwO17mo
         Xfkgtd+NtaTCrZn6OfrvVCBXi6AyiOOOB7WBNmUAdL2CnOAfg6paM1uzW2c7lvsAybGW
         jQy2wSBvqjx38SIAWqa9QMyNRFUFF+URMRD1Zygi6yfTu+4wKgEYsNTwAIYye8TUq0OD
         u1nw==
X-Gm-Message-State: ANoB5plPm/yxSopCEY66/K6iyfkecxGfbjRPiQjQp5ZLETXSTsK6//dV
        YHXoW0CKuD6Tupwpei4UUZQqOPkj+9U=
X-Google-Smtp-Source: AA0mqf7TuRyNfnwuxO7EBS5PIZWae1nc3iBoOe9sQiqc1jqgcx5FN8UQmccdTcfWyyILJ6hdm4gJxQ==
X-Received: by 2002:a17:902:f7cc:b0:188:d4ea:2568 with SMTP id h12-20020a170902f7cc00b00188d4ea2568mr3958840plw.14.1669120634299;
        Tue, 22 Nov 2022 04:37:14 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d2-0afd-2169-5d09-2570-7e89.emome-ip6.hinet.net. [2001:b400:e2d2:afd:2169:5d09:2570:7e89])
        by smtp.gmail.com with ESMTPSA id z68-20020a623347000000b00573eb4a9a66sm1699948pfz.2.2022.11.22.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:37:13 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Harvey <hunge@google.com>, Stephen Boyd <swboyd@chromium.org>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Adding DT binding for zombie
Date:   Tue, 22 Nov 2022 20:37:02 +0800
Message-Id: <20221122203635.v2.1.Ie05fd439d0b271b927acb25c2a6e41af7a927e90@changeid>
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

Documentation/devicetree/bindings/arm/qcom.yaml

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v2:
- Move binding item to Google series bottom.
- Modify DT file for zombie.

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c15a729a6852..f617923f7485 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -538,6 +538,16 @@ properties:
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
               - xiaomi,lavender
-- 
2.17.1

