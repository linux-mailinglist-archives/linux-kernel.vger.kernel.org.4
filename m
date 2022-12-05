Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071E6642F64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiLERri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiLERrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:47:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B94233AB;
        Mon,  5 Dec 2022 09:45:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1330E61280;
        Mon,  5 Dec 2022 17:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972B2C43470;
        Mon,  5 Dec 2022 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670262347;
        bh=FmsPC9vkAuOSeyIidXhZGduvRa/XcRXnLCs2H58uKvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvoenScK84bXEcVw22KBdxXQ0dTV86dyI/T/dik2Uj0QKklr1vDO9BpdvI6AtqdF2
         vzEB8kgauiVefFjhIUsA4+isEo6xVUHh5L0ilFJXOrzMDxSxBQqYXj9jznQnlKb+di
         FuD0Fz8YK4GiLcCsAK4P4rBlb1whgliGRP0dLBLPeIIA4Jtk4QyYcIw+0wjyVdJEdh
         oNhFSdIwLZbJI9XnjjvcVIBxZf625OlwJr26PHBO7i1sT3dqE21uPfJLlGE+GRwgn1
         5GoWg1fabLz1FLSE3y9BbLq0eJpEdL8YLhejMymzSXCExMQxbRnkG/F6gNXWYL4nEy
         shwi9zBkE1z1w==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 2/2] dt-bindings: riscv: fix single letter canonical order
Date:   Mon,  5 Dec 2022 17:45:00 +0000
Message-Id: <20221205174459.60195-3-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205174459.60195-1-conor@kernel.org>
References: <20221205174459.60195-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

I used the wikipedia table for ordering extensions when updating the
pattern here in commit 299824e68bd0 ("dt-bindings: riscv: add new
riscv,isa strings for emulators").

Unfortunately that table did not match canonical order, as defined by
the RISC-V ISA Manual, which defines extension ordering in (what is
currently) Table 41, "Standard ISA extension names". Fix things up by
re-sorting v (vector) and adding p (packed-simd) & j (dynamic
languages). The e (reduced integer) and g (general) extensions are still
intentionally left out.

Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 97659bb71811..d4148418350c 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -80,7 +80,7 @@ properties:
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
     $ref: "/schemas/types.yaml#/definitions/string"
-    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
+    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.38.1

