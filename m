Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48163F20F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiLANwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiLANv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:51:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A58050D69;
        Thu,  1 Dec 2022 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669902715; x=1701438715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bav08OV3LsnmXxf0ohUY0Zv4EUZl+WnAgOolhM8CEvc=;
  b=E9pR5cOHEpOrvWNkeKO6TCO5iw21e8hMnaSMHD1pE1TIZRWWFvh0+4uS
   xwzyF76N7bQJ/pCf7WI8oDnBVA8U1FrpamL7PvE6SiNZ/k3OwiZRxfuK0
   jFjJv591u3V7siZMdZW/A8u6YxFWcjL3cpm/P0uEexp/vY3yMyyzHkUhG
   KibRg/+DNto97OccAMA200zRmNvn+DuqBCMdtYJZmTUz0zy4dQYUT+t3g
   BEMxboqe6v/ANcSAOsSf61RhOMNRelb8KpnqwppcJMbhqmeyVHamjKkdh
   AHnroB46KlNAklJUNQFE4adHj4tTGMKW7QjK+K2y3guTlQCRUcfDVKmtR
   g==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="186069167"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 06:51:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 06:51:52 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 06:51:50 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: riscv: note that counter access is part of the uABI
Date:   Thu, 1 Dec 2022 13:51:10 +0000
Message-ID: <20221201135110.3855965-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y4XvnHIPw8ZuBZEk@wendy>
References: <Y4XvnHIPw8ZuBZEk@wendy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5a5294fbe020 ("RISC-V: Re-enable counter access from userspace")
fixed userspace access to CYCLE, TIME & INSTRET counters and left a nice
comment in-place about why they must not be restricted. Since we now
have a uABI doc in RISC-V land, add a section documenting it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Based on an, as yet, unsent v2 of my other uABI changes. I don't expect
it to be applicable, just getting a patch into patchwork while I don't
forget about this.
---
 Documentation/riscv/uabi.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
index 8d2651e42fda..638ddce56700 100644
--- a/Documentation/riscv/uabi.rst
+++ b/Documentation/riscv/uabi.rst
@@ -3,6 +3,13 @@
 RISC-V Linux User ABI
 =====================
 
+Counter access
+--------------
+
+Access to the CYCLE, TIME and INSTRET counters, now controlled by the SBI PMU
+extension, were part of the ISA when the uABI was frozen & so remain accessible
+from userspace.
+
 ISA string ordering in /proc/cpuinfo
 ------------------------------------
 

base-commit: 13ee7ef407cfcf63f4f047460ac5bb6ba5a3447d
prerequisite-patch-id: d17a9ffb6fcf99eb683728da98cd50e18cd28fe8
prerequisite-patch-id: 0df4127e3f4a0c02a235fea00bcb69cd94fabb38
prerequisite-patch-id: 171724b870ba212b714ebbded480269accd83733
-- 
2.38.1

