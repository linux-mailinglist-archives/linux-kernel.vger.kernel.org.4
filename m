Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E185D72ADB9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjFJRZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjFJRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2655E3588;
        Sat, 10 Jun 2023 10:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B068B61564;
        Sat, 10 Jun 2023 17:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46019C4339C;
        Sat, 10 Jun 2023 17:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417923;
        bh=tuqTKew1pmcWljWXjwIE2elKVYInmZpla1AX7Tht4Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXBwE1ORTw48+VW7+mlJJrrhcA7HLqhUB+nf5HY9Xlztjidq61XVGXytcYEQ27ptM
         oPpZIvwcgdui/Bsiuj8ikSTclKZmSBL0Fpw8tEMETxt9E4ldi1j6ZR5+z1dle3spBL
         wcjZDQsaZ0pTRoJHgtkRSyjxxVFsNFVzxLFcAHHtoA7qmFzNxAQH0zSEjXpcave89b
         HhrC0EUXy6Q9al2iAxrIrirv5TcOfu18jvi1jYhVb1c3ven+s2sJbBZ2fgkM0Tjg8P
         0WlQ4UueYqc89YpUZ0NtyDYHSsZn5kOaAvC3ElstCieo4nOwZ3wBXAXqK9hm3FEWsa
         c6qqVxvh9NPsg==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
Date:   Sat, 10 Jun 2023 18:24:53 +0100
Message-Id: <20230610-koala-bronze-3592637a5d1f@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610-snaking-version-81ae5abb7573@spud>
References: <20230610-snaking-version-81ae5abb7573@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=vzC5e7CTr+OJcy6GMX4g4oH7k/Hrsknp/1aNi4L7f2Y=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCktGx+emDH74qOflh+v/bC2/ByocltEcKedr2dId+3rg y9OGvwV6ShlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEslkZGRa+n5rY6vD+zadV fzef3sXSf+O60tuuSwaS0Y+3dfZrOUQy/BVsc8h4+GVB96vqpUc45tqt/jN/+kOpuoft/5cVu56 uCOUEAA==
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
index 5e2db35411f1..d82d5c872a0e 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -152,7 +152,7 @@ required:
   - riscv,isa
   - interrupt-controller
 
-additionalProperties: true
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.2

