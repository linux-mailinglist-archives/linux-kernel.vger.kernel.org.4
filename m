Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AEB72ADAD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjFJRZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFJRZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7973592;
        Sat, 10 Jun 2023 10:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01D16097A;
        Sat, 10 Jun 2023 17:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754CCC433D2;
        Sat, 10 Jun 2023 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417909;
        bh=+CGO6+qAMKLfPjunyiWqLb8FIpRIF17JdrAj2A38lbQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Guf3S4EcErxRdPDv1P4FruQrkdW3AAtM9QrK9OPiiciRmjTpUlIGA0ohCxpbwLqpV
         gBPdZwXUy57hV28Ht4RHj4Tyc8H/IOZBvtJ960dCBXMdeoQ1Ak5vNAJiMLSbFDgUvl
         SjwkfOcMODgKVUdsNn+DMGkptR1AMYB3L9CBPVEC0YmdsKrzHXHP0LORnfRtveBr7M
         NXG3gEBjpO/AhwLIcISEdjB/pYqISUJwpJE2iLejQL1pnhssJ0TpLWoYlIjvTUIIP/
         gjeMEuEnamAKxle46Vxo5iLT0OwydGFqiOZEAlDgk9vLMB4yaxtVyb/0xGDjnws52s
         q2P6saDY/0Ctw==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
Date:   Sat, 10 Jun 2023 18:24:47 +0100
Message-Id: <20230610-snaking-version-81ae5abb7573@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=/IRjjbSMe5wvcyT1lUiwzTIegPvYC2KIb2FTQX8vuGA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCktGx/IHfklX+DUwN6ZMHef0mKr4rVxgUaiVR6n3S9F2 f9zeeLTUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIkcbmD4Z5gq1rNnv5voLV/n hv9Nygu/ftxWcc2wUIRHWfih+J9HaxgZlt94UDal7M+Ld7caDx2/dVJRyTrMqjPJ8Luv6iXJ9J4 OdgA=
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

Do the various bits needed to drop the additionalProperties: true that
we currently have in riscv/cpu.yaml, to permit actually enforcing what
people put in cpus nodes.

CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (6):
  dt-bindings: riscv: cpus: add a ref the common cpu schema
  dt-bindings: riscv: cpus: allow clocks property
  dt-bindings: riscv: cpus: add a ref to thermal-cooling-cells
  dt-bindings: riscv: cpus: permit operating-points-v2
  dt-bindings: riscv: cpus: document cpu-supply
  dt-bindings: riscv: cpus: switch to unevaluatedProperties: false

 .../devicetree/bindings/riscv/cpus.yaml         | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.39.2

