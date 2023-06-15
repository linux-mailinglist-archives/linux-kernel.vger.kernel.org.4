Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4F7322E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbjFOWzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjFOWy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49559270E;
        Thu, 15 Jun 2023 15:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8EFE61F12;
        Thu, 15 Jun 2023 22:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26B3C433CA;
        Thu, 15 Jun 2023 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686869695;
        bh=uOdg4scVwQQzL8UZnROnPCCRu7Nfdm5eCRa5kHL1u3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7dnoqhMqsNpKE8pAOzKNBWZs2o3jqvpczL4+qj/AnHRAbA+aMbrugl5xHi0SGH8p
         3QYW/NRiH3p1pwIvE0NvC5eh8etZ52ICkyfNOYgbr8KrpW772LN1+zxnN+Eo9bA0Ga
         Q9upHj2X2cnQhgXHBZpU5AB5u8MiwoxTXmTB7zsNL2O+hEWZW07vQdpsnWDulbEme3
         EqlDOvJGX3X1Cf7tTaSBdH+Jet1qUPYP86nbYEMLxP1KrMutgAL3sKbgmfn4hA+sGv
         e4yiroGQHTlUV2ClVw69H4osMbp5083FmA45b+9n2lfWrh1IobvSzbBEs3fK0+rSLs
         Y21RKq4cMVWrA==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
Date:   Thu, 15 Jun 2023 23:50:15 +0100
Message-Id: <20230615-viper-stoic-1ff8efd7d51d@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615-creamer-emu-ade0fa0bdb68@spud>
References: <20230615-creamer-emu-ade0fa0bdb68@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=u/qrBFnL9e9PAex6e6NvnAWTZV+52ZOaw3F8Q/zOFMA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCndUxdfseKvjwla7JCU5jYp+vURlY9nUq7/K9Hpfz5/1 v5sm8Z7HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI8ysMf4WPBhXM3/362eI7 DlOZuQsNDnz3a7r51NT3r8yktv6Xhy4x/E84uNkwqIsh666IkITAudpLDw9Ov2TN+aiVfedRdq6 MDnYA
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

To permit validation of cpu nodes, swap "additionalProperties: true"
out for "unevaluatedProperties: false".

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e89a10d9c06b..144da86718c1 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -143,7 +143,7 @@ required:
   - riscv,isa
   - interrupt-controller
 
-additionalProperties: true
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.2

