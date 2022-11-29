Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6ED63C32A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiK2OvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiK2OvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:51:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D083BAD;
        Tue, 29 Nov 2022 06:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669733477; x=1701269477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CX12l/BYcHckW0nxt5dW6uGaSf9bcCVSRsIUm2MrbaY=;
  b=DA7JrLVpepXpqVe7J3e2kwZ+2bgGr0OHLrpTZxiKLMLF79BDOa4stEqY
   I8B2ZS8uBISd6Z0UqtscpECyUSiJcZAItm+PRAGz7A3DTBy3tf6r4+5ZQ
   SIxG3jkIfvUBkTTMwlcmtSbM8qqeO66s1Ua5DS2ANj6uuX0TndFDDM49f
   N8YbB11V68H0m7QlHoOxap31wAWajstPyc+lCepwE7XgJ3/7G2LnRVpyn
   FSe3tfWz6kaBrc3YHQgGq8SmmK2IqTfFZlHfh1zqnHtxm7S/9qqg9d95W
   Oacz2NlwhR1DWxiJhHbM5Sqwyeg9D+Hq3ANE0czNXepfLAGNZT053nBqU
   A==;
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="190983230"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2022 07:51:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 29 Nov 2022 07:51:15 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 29 Nov 2022 07:51:13 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <guoren@kernel.org>, <heiko@sntech.de>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>
Subject: [RFC 1/2] RISC-V: clarify ISA string ordering rules in cpu.c
Date:   Tue, 29 Nov 2022 14:47:42 +0000
Message-ID: <20221129144742.2935581-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y4XvnHIPw8ZuBZEk@wendy>
References: <Y4XvnHIPw8ZuBZEk@wendy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the list of rules may have been accurate when created, it now
lacks some clarity in the face of isa-manual updates. Specifically:

- there is no mention here of a distinction between regular 'Z'
  extensions which are "Additional Standard Extensions" and "Zxm"
  extensions which are "Standard Machine-Level Extensions"

- there is also no explicit mention of where either should be sorted in
  the list

- underscores are only required between two *multi-letter* extensions but
  the list of rules implies that this is required between a multi-letter
  extension and any other extension. IOW "rv64imafdzicsr_zifencei" is a
  valid string

Attempt to clean up the list of rules, by adding information on the
above & sprinkling in some white space for readability.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 852ecccd8920..5e42c92a8456 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -120,20 +120,32 @@ device_initcall(riscv_cpuinfo_init);
 		.uprop = #UPROP,				\
 		.isa_ext_id = EXTID,				\
 	}
+
 /*
  * Here are the ordering rules of extension naming defined by RISC-V
  * specification :
- * 1. All extensions should be separated from other multi-letter extensions
- *    by an underscore.
+ *
+ * 1. All multi-letter extensions should be separated from other multi-letter
+ *    extensions by an underscore.
+ *
  * 2. The first letter following the 'Z' conventionally indicates the most
  *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
- *    If multiple 'Z' extensions are named, they should be ordered first
- *    by category, then alphabetically within a category.
+ *    'Z' extensions should be sorted after single-letter extensions and before
+ *    any higher-privileged extensions.
+ *    If multiple 'Z' extensions are named, they should be ordered first by
+ *    category, then alphabetically within a category.
+ *
  * 3. Standard supervisor-level extensions (starts with 'S') should be
  *    listed after standard unprivileged extensions.  If multiple
  *    supervisor-level extensions are listed, they should be ordered
  *    alphabetically.
- * 4. Non-standard extensions (starts with 'X') must be listed after all
+ *
+ * 4  Standard machine-level extensions (starts with 'Zxm') should be
+ *    listed after any lower-privileged, standard extensions.  If multiple
+ *    machine-level extensions are listed, they should be ordered
+ *    alphabetically.
+ *
+ * 5. Non-standard extensions (starts with 'X') must be listed after all
  *    standard extensions. They must be separated from other multi-letter
  *    extensions by an underscore.
  */
-- 
2.38.1

