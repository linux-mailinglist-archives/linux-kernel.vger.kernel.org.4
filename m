Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0431642F63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiLERrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiLERrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:47:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841023BCD;
        Mon,  5 Dec 2022 09:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ACAEB811BE;
        Mon,  5 Dec 2022 17:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5B7C433D6;
        Mon,  5 Dec 2022 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670262344;
        bh=FJ2eLc+/uvQtLvi0RqLWMq8XBxp4zHfWRfsPOxpEs+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dytuqIlUealQUxdTAhY+8ZYE3V8rGSp7iu1KElSnR/Y24IhoesCGKp/+Rt3hrFTBn
         7fYb4N87KzfwacJim7ecefII2dS9AMKznszp+2sSVfarUSjESNVzoOP+Y4aWqiCOHh
         ak8NCsL1daSs+lQvLQssAlTpe7cOb6y94b3nFozwvdXS/VKPJxkIltqyne+/KQKmju
         TMiLeDxbWtidxR7d08bziajaZq+BxfhXkxYrUcKkviuBrleUngoHGy6ThieD3vx8c1
         ZxVYpnnoucHPxS0Vd+hnJBc7tXxOepQYLfmhMl2cRIBahpcpCHA8ULXIZM7uLzVrd/
         3gHBTekRuCkog==
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: riscv: fix underscore requirement for multi-letter extensions
Date:   Mon,  5 Dec 2022 17:44:59 +0000
Message-Id: <20221205174459.60195-2-conor@kernel.org>
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

The RISC-V ISA Manual allows the first multi-letter extension to avoid
a leading underscore. Underscores are only required between multi-letter
extensions.

The dt-binding does not validate that a multi-letter extension is
canonically ordered, as that'd need an even worse regex than is here,
but it should not fail validation for valid ISA strings.

Allow the first multi-letter extension to appear immediately after
the single-letter extensions.

Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 90a7cabf58fe..97659bb71811 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -80,7 +80,7 @@ properties:
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
     $ref: "/schemas/types.yaml#/definitions/string"
-    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
+    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.38.1

