Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411D7322E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbjFOWuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjFOWu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F426A9;
        Thu, 15 Jun 2023 15:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42268611A7;
        Thu, 15 Jun 2023 22:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8338CC433C8;
        Thu, 15 Jun 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686869424;
        bh=fzU2Asm/5j3/wDRwdzkINVCgJqFep0/BSzQFxsdoEYE=;
        h=From:To:Cc:Subject:Date:From;
        b=IM5ZAoHSBGTDNGZj+jgy0CX+hcBWh5WRApPaPWqYHQlM7bkYzEOMgJfW17H5VkyfS
         bhe9LuouJ3DcyajyGRXmRPIunsGPmqFBGZiXcqfomnV2Uxt2STUElrBkpyHkC3M2Mo
         2zJjtknAmYeMWRZ2QetT4ymvR/LUwkcSK1IUE7O06fxPV8SSxIBljhODgf6aqIRu8A
         aeNXtVqDi2zQgStW9XJOAM7UCrTHfVa98TGhu6u8XVEujN0CLR0teCPmfOXtOqWm5Q
         OjtbWcOYEqBvJEMk56K9B+4ZFP/TXHC+k194v91wSOTRcDQJ+ytIdhv5weuY+6dBuY
         jO5j1j5/22p2Q==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
Date:   Thu, 15 Jun 2023 23:50:13 +0100
Message-Id: <20230615-creamer-emu-ade0fa0bdb68@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=U0b7pnBllJDo0Zb3jnuhIw49ctLfLxSxrdnlxX7wcF0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCndUxfNX6ajFd8/I0Lz7dXFcw/ZB+u9k2MUrCs+w7ZZ0 exJ4/s9HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIoRzD/5rXOeZbFu3Ucpg8 pVI4z/Jo1369lWum/5wn7HeofcIjHSGGfwbbDptxTxW5WzX9ddC39/utw5hKpDYc442/7Ry/7qn +TBYA
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

Changes in v2:
- drop patches 2 -> 5, they're now standard in dt-schema

CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  dt-bindings: riscv: cpus: add a ref the common cpu schema
  dt-bindings: riscv: cpus: switch to unevaluatedProperties: false

 Documentation/devicetree/bindings/riscv/cpus.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.39.2

