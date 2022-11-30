Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23E863E1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiK3US3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiK3UR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:17:57 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9895093A43
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:13:39 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id q13so8622120ild.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5D9QgKvXJDSs69W719kOBsxIgJ1yqINQsNXR6y+ypg=;
        b=PPaNJJ4BLUfwX1mQEBI+QDJAYRQmqRb4iG7M33xvC3iB/PTrpApOpWJuDXe/Zx+AFY
         HKm7ba+4GF3xyclbIX7mpmX4wrP+yq6EMSjV35dIhSiQ2sFiWA+STIggI5WTt8Nm41n3
         VYhlWv+veee5m6oQcf4sLDVY7osh0e4eePoV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5D9QgKvXJDSs69W719kOBsxIgJ1yqINQsNXR6y+ypg=;
        b=GLxizZ/shRYOwWtlMmevhkIKk7bE4jqEFk+5lt22rBde7LF5WYXyNZ3V57nZQtfewj
         tDO0M0ZIyk91iRnJQwyLy+EWGnmrI2dJeVJHupPFv6aB+6FeHx8Jt3N/e2Pwk3fbAPAe
         TFOyMutPaiFalQeKNZUHQflO56h3J4KUuqdbLwCrURNMrhnINPvI5Lu68czZxxjumYRd
         PNB58JVq1GXzB77E0DGaTblaKVJubTuKM87hF2XDgxjqOiZCdjP11+ou+9B5jZ2hTZM4
         g+Fd8E9VnQ9nqtAcTHWG18QL2iciDPlwTiU69UoQTRPgwMPHaKf63d3KdNMu1u+kDbfs
         tEnQ==
X-Gm-Message-State: ANoB5pkpT/rPeh0rnG7SNT0cI/TUXL6E1yEvqx2tXZrdw5FaWjO7SZWX
        aioovR5/PKaGlXR3eDtflUS7hshcK3M4EQ==
X-Google-Smtp-Source: AA0mqf6b492EKnEpYiEcgyaTQ8cIRPquT7Nfs9N61Dnynobe1sPfOduEfXXY45N6Q4TWv88NBbMNiw==
X-Received: by 2002:a92:d607:0:b0:2fb:6601:80f2 with SMTP id w7-20020a92d607000000b002fb660180f2mr24147849ilm.208.1669839218517;
        Wed, 30 Nov 2022 12:13:38 -0800 (PST)
Received: from markhas1.lan (184-96-172-159.hlrn.qwest.net. [184.96.172.159])
        by smtp.gmail.com with ESMTPSA id r2-20020a02b102000000b00363e61908bfsm902158jah.10.2022.11.30.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:13:38 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v8 2/3] dt-bindings: mfd: Add compatible string for UART support
Date:   Wed, 30 Nov 2022 13:12:55 -0700
Message-Id: <20221130131245.v8.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
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

Add a compatible string to support the UART implementation of the cros
ec interface.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v8:
- Update commit message

Changes in v7:
- No change

Changes in v6:
- No change

Changes in v5:
- No change

Changes in v4:
- Changes in commit message.

Changes in v3:
- Rebased changes on google,cros-ec.yaml

Changes in v2:
- No change

---
 .../devicetree/bindings/mfd/google,cros-ec.yaml       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 04962bb29576e..26787e4574b8d 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -28,6 +28,9 @@ properties:
       - description:
           For implementations of the EC is connected through RPMSG.
         const: google,cros-ec-rpmsg
+      - description:
+          For implementations of the EC is connected through UART.
+        const: google,cros-ec-uart
 
   controller-data:
     description:
@@ -222,4 +225,12 @@ examples:
             compatible = "google,cros-ec-rpmsg";
         };
     };
+
+  # Example for UART
+  - |
+    uart0 {
+        cros-ec {
+            compatible = "google,cros-ec-uart";
+        };
+    };
 ...
-- 
2.38.1.584.g0f3c55d4c2-goog

