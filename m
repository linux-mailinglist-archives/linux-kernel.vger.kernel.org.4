Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC07322E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjFOWy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjFOWyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA2272A;
        Thu, 15 Jun 2023 15:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCE061BE6;
        Thu, 15 Jun 2023 22:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A2DC433C9;
        Thu, 15 Jun 2023 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686869692;
        bh=Df043vgm6CnnvUWCZd+vj+oFrnFuv7Ap9nxevuDGXJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlHWY7F7AYPflO0rB6nuP/YL0uYkct0iT0RW4smQHkv38NoiU3x5EZpgJDHsw712j
         Vp38wT2BA44kvTWC/0jULlBRzX7oyJ0gqRvCwFmbRzF5+/Zn7D5gHIFdK7d8WePt7a
         q9c1djYEMs0r7zJj8s7xwGz0mv6MB8TYG89M7gUn8t4G8yg8Jnjb3x58NwsKpozVPm
         3AaNRwGhHTGoBdtEBYI6wwLFK6egoozkefyYjD4OEu6DKSPMdZwVlAdas2A45Waq78
         mY0ZCkVPBjhsKLbhiVAtMdc4vlY2tkNveEUAuQ8t2oMb7I/x4U9n6VaQtAffjJhkLp
         d/7f1X5bty+Pw==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: riscv: cpus: add a ref the common cpu schema
Date:   Thu, 15 Jun 2023 23:50:14 +0100
Message-Id: <20230615-dubiously-parasail-79d34cefedce@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615-creamer-emu-ade0fa0bdb68@spud>
References: <20230615-creamer-emu-ade0fa0bdb68@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=xnf8UGz7+fdKaOoNLsbw78HDVnw230rwRyuBbYLfg8w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCndUxebKtwsSK6TCBAy6ShyYUjtPmOi/sPXT+gG59cVH ceOzzzfUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlM9GT47xnJvjnj5KeFukfl DqfV74nYoee2pvqvxfIPrfsOlGcwTmVkmPxO+7B23oY3m97O6v5sfVKvI5D5qdWH0hm7Kkvl9bq K+QA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

To permit validation of RISC-V cpu nodes, "additionalProperties: true"
needs to be swapped for "unevaluatedProperties: false". To facilitate
this in a way that passes dt_binding_check, a reference to the cpu
schema is required.

Disallow the generic cache-op-block-size property that that drags in,
since the RISC-V CBO extensions do not require a common size, and have
individual properties.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 3d2934b15e80..e89a10d9c06b 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -23,6 +23,9 @@ description: |
   two cores, each of which has two hyperthreads, could be described as
   having four harts.
 
+allOf:
+  - $ref: /schemas/cpu.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -98,6 +101,9 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/string"
     pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
 
+  # RISC-V has multiple properties for cache op block sizes as the sizes
+  # differ between individual CBO extensions
+  cache-op-block-size: false
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
 
-- 
2.39.2

