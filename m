Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8059263DC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiK3SFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiK3SFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:05:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E874CC4;
        Wed, 30 Nov 2022 10:04:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 272A8B81C89;
        Wed, 30 Nov 2022 18:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477AFC43144;
        Wed, 30 Nov 2022 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669831496;
        bh=aWS431RxPAePRVMhSm2JmuPDwCYve4mSOvoqk39aooc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxddzEriFuoQxLFHlPju0wVpIb4GQkBlxo4ms79oP3DGmib0Ysdvi3AIp0VSeUNoL
         2GThFQsz/g+XmgRUiUUxSl/4aQQKGsPUMx7IUi0sHWL6dQWPSxAl5N0LUIWA5t5WKV
         KPJM68MTJz9WkRBomxdV2WqLduCBYSGRgjxqxQ7gOo/eiSjgXlqQCTeHFsRIwxN8DN
         YTHnISl0XJ9d9CVR84ishl2FIuDuAoQMBD/0DIVMeDJlZcu1LwYUF/IzCjs6hIT3Wf
         Tj7yvEbaYtM9BgQiCdWM7XgfrNYQFrwhI2K7o6leuS2hSo71z4TbEuNSrkVf4Hi2Vg
         5GDQ8Dz0YgNcQ==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: riscv: fix underscore requirement for addtional standard extensions
Date:   Wed, 30 Nov 2022 18:04:22 +0000
Message-Id: <20221130180422.1642652-2-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130180422.1642652-1-conor@kernel.org>
References: <20221130180422.1642652-1-conor@kernel.org>
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

The RISC-V ISA Manual allows for the first Additional Standard
Extension having no leading underscore. Only if there are multiple
Additional Standard Extensions is it needed to have an underscore.

The dt-binding does not validate that a multi-letter extension is
canonically ordered, as that'd need an even worse regex than is here,
but it should not fail validation for valid ISA strings.

Allow the first Z multi-letter extension to appear immediately prior
after the single-letter extensions.

Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 90a7cabf58fe..e80c967a4fa4 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -80,7 +80,7 @@ properties:
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
     $ref: "/schemas/types.yaml#/definitions/string"
-    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
+    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.38.1

