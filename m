Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C394572ADAF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjFJRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFJRZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67B3596;
        Sat, 10 Jun 2023 10:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4017361564;
        Sat, 10 Jun 2023 17:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24D4C4339E;
        Sat, 10 Jun 2023 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417911;
        bh=Df043vgm6CnnvUWCZd+vj+oFrnFuv7Ap9nxevuDGXJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlVvMTAl5OuWwgFYGYz8gC/52wk2NdF46iA7rXrSw9J6FGDTUOoqWDUulA06KN4ie
         DBVNYIUhuHfMiw1RUMEDKvlAao6ffwpWJF9c90djU5RfdgtdIXW8LXtmWR5vkZkraJ
         vkT36+XRx/LTsFGHhSk55UTwY77QW0DPQAJrQwbn8EAib7lBp+2wdy7YCFKvYcEN3U
         KHyUtZxpPzitSXKWK7zA9DnJnIfbdpYiez+Mn+wFOgZSDWS2VzElB4A8WD2aWYcBAR
         hiYyZ06d0eFZMjHT8TvhHHSJILZsX5S32cnM+/xCywxyAgXzLNG/PLKFeEntYnKL2S
         6TC8smY0KwwCA==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] dt-bindings: riscv: cpus: add a ref the common cpu schema
Date:   Sat, 10 Jun 2023 18:24:48 +0100
Message-Id: <20230610-pug-spending-d08d12d82e77@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610-snaking-version-81ae5abb7573@spud>
References: <20230610-snaking-version-81ae5abb7573@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=xnf8UGz7+fdKaOoNLsbw78HDVnw230rwRyuBbYLfg8w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCktGx9UJssHfHvwY+PljWGJP0PXTU2uu+Pq+UymX9y7q 3kGC6tmRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACYyI4ORYRVHoZ/YtQtGPx2u JXFHR1RITHu2MOQcx6JIlwe1n22nqTP84Y9vfS6g+bQtM2Bp7tsFOec36DPtP9bd8PHzhZVv2m6 8ZwQA
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

