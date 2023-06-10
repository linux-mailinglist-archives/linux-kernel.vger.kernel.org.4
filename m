Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98972ADB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFJRZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjFJRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5D73590;
        Sat, 10 Jun 2023 10:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD34611A5;
        Sat, 10 Jun 2023 17:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A38C433EF;
        Sat, 10 Jun 2023 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417918;
        bh=/RSEb/8qn2JLiYhnJeSUa2LgkGU8ITV00j06razkRQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKz//IfoXGIJk1GU06Ba9/I9/7ZmNONwLt8CzK8x+IPV1H2itwjKDt/WpAXMZ/Amc
         AqN5ATQtQql23Uq/mZ6VIOLcHi1v4bAfwmLIDT9Z1TgnrhgYZ/zF1qEnl7pk4f7xGx
         iCU/r7kifl4RxHD9wz6lp431152q8xA2CN27MgZe9++mn1A2Tatx7W/5L9vLw5F64I
         3FUcPpMi13EQiAFRr05KldhNeCp21j/bA/c2XJ0CYklvOzNpbh+xWdq19ZvEFl6Jp6
         qP0eQbxQ+6lC5KDwZ1MIPk5i0VK6BskVlgbGkYroaqAbpCJenkD4wLo72Udl7cHzfN
         FekWYHTiBr7Aw==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] dt-bindings: riscv: cpus: permit operating-points-v2
Date:   Sat, 10 Jun 2023 18:24:51 +0100
Message-Id: <20230610-jacket-king-486b50a4e01d@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610-snaking-version-81ae5abb7573@spud>
References: <20230610-snaking-version-81ae5abb7573@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ZN0D8JIh0ZTCyrgQ1QBX5wAql6+LOTcbl870BurJKZA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCktGx/mXXoWcv3avliRBZZNMf9TLI7OKN/09sEutSJJ7 Q153Jted5SyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAivssY/ie6r/idKv/Wdo+z 08cdf0xZKwLWv9qWEJJ0/aDLc0u3/yGMDOfu8/z7eebuqzD7pZlX1Tezb5mWH/+Z8dTfhz0v5ty oe8kFAA==
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

To allow setting "unevaluatedProperties: false" for cpus.yaml, permit
the operating points property for RISC-V cpu nodes.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 9bf2b72a9460..00d1e273f1a9 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -108,6 +108,7 @@ properties:
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false
+  operating-points-v2: true
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
 
-- 
2.39.2

