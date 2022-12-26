Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC3656251
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiLZL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 06:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiLZL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 06:58:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2C16179;
        Mon, 26 Dec 2022 03:58:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AA24B80C75;
        Mon, 26 Dec 2022 11:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895F8C433EF;
        Mon, 26 Dec 2022 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672055882;
        bh=BCmdieMBicJXuI4/ZzBxG2C09Q8TUmVSKdBVNnqsWpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=te4U/bKJZYL4EQq81SVivnn5sAAcIlPZSoc8sgbMclBd6VwxkgzF/U449dFkQGQy+
         c6fLeqQ1NzSM2BW0L3AD0BhSaV+h7beqCBfjXtXDjzGCVfYh9IW/nXXSDdy4sax1yy
         QXyXhpZXX+KeyY93fGKGpgtWJveehZdNgZ+BNKJY3Ki/CUQLyw9UuddKrLtXZtoBrx
         N56P9F1qyQuPWFyvmRhTXjmakqk4bB5mpKoEe3SlQTofARTV4vzWfSElvPWRPBnLld
         KKCHDiVjimTxpRFN7nVBYDzwoaa4GcNpHAP4vKns7souAh0XrUWjJEiJixhyIAMUMq
         +EyBEB9UvCr5Q==
Received: by pali.im (Postfix)
        id A794D77D; Mon, 26 Dec 2022 12:57:59 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: reset: syscon-reboot: Add priority property
Date:   Mon, 26 Dec 2022 12:45:11 +0100
Message-Id: <20221226114513.4569-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220820102925.29476-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new optional priority property allows to specify custom priority level
of reset device. Prior this change priority level was hardcoded to 192 and
not possible to specify or change. Specifying other value is needed for
some boards. Default level when not specified stays at 192 as before.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v4:
* Use restart-handler.yaml

Changes in v3:
* Add explanation into commit message

Changes in v2:
* Change sint32 to int32
* Add default
---
 .../devicetree/bindings/power/reset/syscon-reboot.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index da2509724812..f721bdf63a98 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -19,6 +19,9 @@ description: |+
   sub-node of a "syscon", "simple-mfd" node. Though the regmap property
   pointing to the system controller node is also supported.
 
+allOf:
+  - $ref: restart-handler.yaml#
+
 properties:
   compatible:
     const: syscon-reboot
@@ -42,6 +45,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The reset value written to the reboot register (32 bit access).
 
+  priority:
+    default: 192
+
 required:
   - compatible
   - offset
-- 
2.20.1

