Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E082A72ADB3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFJRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjFJRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399113598;
        Sat, 10 Jun 2023 10:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB1CB611A5;
        Sat, 10 Jun 2023 17:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6377EC4339E;
        Sat, 10 Jun 2023 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417916;
        bh=v1UrSNfLWrNGAmPVc1KJdoO4pG/6O2Mh0GZGIPz0/A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ORGAxlFHkQ3ZHHANOC+UtsEuLI10MLZoN3T99DVNonN7otkMYIeJ44lVXOemdQsyL
         6ZoeJemcCEjkZptDvm5nsAQorTHdZ0ysKFPuSo0Y/u83RC3mE7EZyUOW1/IDfPswyt
         ZqcZOru4TLVacbE3pYEpCzNJuqvRYVRLUgI0rqLR0C8U15VzEGA+XrgLL6Z8/YGuPp
         Em72uhsR9xWc0iVxtDb5evaBcDfhkSUr4AMWU+3Y3+7tUYb5F0sTqUcz6kkOChD3PE
         exJeMReWwrUmAD319dGgOXtqQy6J3TPRtd6PCBoYCJfKyjkmmf9i1RPhaIuZC7sN+G
         kmkh71DajuYig==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] dt-bindings: riscv: cpus: add a ref to thermal-cooling-cells
Date:   Sat, 10 Jun 2023 18:24:50 +0100
Message-Id: <20230610-antiques-provoking-f58da8e39262@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610-snaking-version-81ae5abb7573@spud>
References: <20230610-snaking-version-81ae5abb7573@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=X44cJQynNyxLh/lbSBWZ7y3BLAT7CFQ+L40vuT60PNk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCktGx8qCVzRUiqUtpi0QbWzUzFQYdEurTsR2o0zLj2Kf 9TIz2XeUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIm4b2Vk2C6ztf3XTmPzUo0f oQ8/N867LCZ+qKmRPyZBtvT92ZXqFowM+zkFpp++bHgsqDOSqS9dz7Slfsq5pV1c2+oSutfq3r7 EDgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

With "additionalProperties: true" removed from cpus.yaml,
dtbs_check complains that #cooling-cells is a disallowed property.
Add a ref to the binding in which it is defined to satisfy the checks.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 3808a6703b2d..9bf2b72a9460 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -25,6 +25,7 @@ description: |
 
 allOf:
   - $ref: /schemas/cpu.yaml#
+  - $ref: /schemas/thermal/thermal-cooling-devices.yaml#
 
 properties:
   compatible:
-- 
2.39.2

