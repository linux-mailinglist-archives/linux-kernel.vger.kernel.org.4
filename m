Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595486D6B29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjDDSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjDDSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9FD5251;
        Tue,  4 Apr 2023 11:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81CD36382B;
        Tue,  4 Apr 2023 18:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCD6C4339B;
        Tue,  4 Apr 2023 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680631438;
        bh=NEdwIWZOJschJ8QF5b2zp8sC703r6EvbHbPixlx4z38=;
        h=From:To:Cc:Subject:Date:From;
        b=O6l53MPt/ujh70GigbHt1SNot+coAvvC28j4hWiJfd2z4pG2T6zpnG5gXx9a6dDoB
         VbLOFovn3848wzUP++tWeiDndLgR5GtYFdcOB6wDFcPphhzOUnyZPSbz5CKHFMzjCF
         W6xdY/fBbpvE4gr1c3f53r/d1d8hKAoJ2xp+6Rkx41y+/2yqOrRydZtUD67yAJpOpz
         gBqTSxIWDorSb01oefoB4Pxoa859nxnTfSu4tK2CFn3ylFjaqEVFpoGslM1kPRINJV
         lWr7AW+LrGpPV1xCZnQcj34d2lm+fqbdHBxwZHwTF4NcbcWh12ux3duj8hrVmjAArL
         PHmwQyqQjbGOw==
From:   Conor Dooley <conor@kernel.org>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: perf: riscv,pmu: fix property dependencies
Date:   Tue,  4 Apr 2023 19:03:22 +0100
Message-Id: <20230404-tractor-confusing-8852e552539a@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=2hS1x6j8jxB5WORv7alUwm+GQaMbRtWF7Ns9mZYqnSE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCk6aanvotZJXJBkODU58cYl5fsH1bI/a0W/kD24xkvrk vmmSXuYOkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRf5MZ/se6VF4Jvs6T6/xq ueoGk8RFzs/Do3JevPm4fZZZpaH2nAmMDHcdDs6Mm2RsYm394pqo+861Dzf6chc/+/P6yLPtz76 qBLACAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Seemingly I mis-implemented the dependencies here. The OpenSBI docs only
point out that the "riscv,event-to-mhpmcounters property is mandatory if
riscv,event-to-mhpmevent is present". It never claims that
riscv,event-to-mhpmcounters requires riscv,event-to-mhpmevent.

Drop the dependency of riscv,event-to-mhpmcounters on
riscv,event-to-mhpmevent.

Fixes: 7e38085d9c59 ("dt-bindings: riscv: add SBI PMU event mappings")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Atish, I'm not 100% on this one but I noticed it while doing dt-validate
on a dump of the qemu virt machine which doesn't use the
event-to-mhpmevent property.

CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Atish Patra <atishp@rivosinc.com>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: devicetree@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/perf/riscv,pmu.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
index a55a4d047d3f..c8448de2f2a0 100644
--- a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
+++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
@@ -91,7 +91,6 @@ properties:
 
 dependencies:
   "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
-  "riscv,event-to-mhpmcounters": [ "riscv,event-to-mhpmevent" ]
 
 required:
   - compatible
-- 
2.39.2

