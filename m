Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32772ADB8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjFJRZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjFJRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A993589;
        Sat, 10 Jun 2023 10:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705E261567;
        Sat, 10 Jun 2023 17:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED653C4339E;
        Sat, 10 Jun 2023 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417920;
        bh=hm8DFtI0+spkXUeJgFAB5WoC+koaV/CfCqr4C9q9gnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFjqa4SyfhT6CpI0rgZuv7zUWeXAq40+W98EwPO70oi7ZQc+vq7zs6NtCYQbRhUO0
         RVPxmZM7MUiOLJ3xgULwcdDPAGtprU2eggSwt0d61GgHaCJc34Jr5F+Y79iPFNN7eQ
         ozZVS6rsMywFaXbvux5cXvJxrsjiww6Kz7c49pXaURJWFPHVtg07KglrRX2c4PTy2W
         KUPdxIixl9LTNsUtmeJCykDF+oxZKmA79LHPGREA8frTZX0XYkx9zpEHtEYNkd7gdz
         jnH5KfFks8DiP1WzD1Z2+KB/4+kNy584yFK1FKjYSH4SiHsCVgHI/nlqV167kI6pu6
         tVf8eLQdB2UUQ==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] dt-bindings: riscv: cpus: document cpu-supply
Date:   Sat, 10 Jun 2023 18:24:52 +0100
Message-Id: <20230610-quaintly-eastcoast-c006ff4ce942@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610-snaking-version-81ae5abb7573@spud>
References: <20230610-snaking-version-81ae5abb7573@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=f3zWC+rsKH2/myZR3Jx3qGAL8gTZdvoMweP7fwlgFq4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCktGx8u3/X1x4NSbceCwBLds7qTVCYkvr+r+mprrELeT dvuM5OzOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRjc8YGS4/ds35MPtkR/2L g8F9lh4ub7Um/zWOMIyusfTaqd2f/4KR4YaSrKbsw58LTt9NNbeaW/WIKT3obUSkH9fkvFVf5zx 9zQgA
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

To facilitate switching to "unevaluatedProperties: false", document the
cpu-supply property that is already in use in several Allwinner
devicetrees.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 00d1e273f1a9..5e2db35411f1 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -62,6 +62,10 @@ properties:
   clocks:
     maxItems: 1
 
+  cpu-supply:
+    description:
+      Regulator supplying the CPU's power rail.
+
   mmu-type:
     description:
       Identifies the MMU address translation mode used on this
-- 
2.39.2

