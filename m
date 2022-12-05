Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5D642A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiLEOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiLEOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:46:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F51B788;
        Mon,  5 Dec 2022 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670251584; x=1701787584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xa3lQ5br274pHlzqKFXObTMHjy86GvzTLCwrJSJFAKA=;
  b=mshFdZZvsdpyH+TXzhniEQuHZl2sUUW1EBmLfZxio/WcDoVpwNqAUGpl
   Pl+KNrO+7DWQ2m98pEbs+V4H+NJCaXLbOFQWqfbbHUH5c1qh5BmdduxAs
   F/Z8BSpanbtH/w/rU1qAzjVrOXJ4ssvT2Hf0UwfVYS9e6Mhl87gX3gQ8s
   Zx7t8xLQrtH+PcIeclo+6yzQPi/CCPTnU1ED0n5lRBsDa4MVU1Sd18IDW
   9GK3n+scoFQh3Ohv1GR8YggehZx+5COOxf1jrUnjt+WI0S8FZDrNVykev
   PiqiCXL14IGa95xQdYtgXyrCYLpLOb4IEaAYPl3065nac/CC7/9PgtsuQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="202640941"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 07:46:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 07:46:19 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Dec 2022 07:46:17 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <corbet@lwn.net>, <guoren@kernel.org>,
        <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 3/3] Documentation: riscv: add a section about ISA string ordering in /proc/cpuinfo
Date:   Mon, 5 Dec 2022 14:45:26 +0000
Message-ID: <20221205144525.2148448-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205144525.2148448-1-conor.dooley@microchip.com>
References: <20221205144525.2148448-1-conor.dooley@microchip.com>
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

The RISC-V specs are permissive in what they allow as the ISA string,
but how we output this to userspace in /proc/cpuinfo is quasi uABI.

Formalise this as part of the uABI, by documenting the list of rules
we use at this point in time.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/riscv/uabi.rst | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
index 21a82cfb6c4d..2ebec4c52230 100644
--- a/Documentation/riscv/uabi.rst
+++ b/Documentation/riscv/uabi.rst
@@ -3,4 +3,46 @@
 RISC-V Linux User ABI
 =====================
 
+ISA string ordering in /proc/cpuinfo
+------------------------------------
+
+The canonical order of ISA extension names in the ISA string is defined in
+chapter 27 of the unprivileged specification.
+The specification uses vague wording, such as should, when it comes to ordering,
+so for our purposes the following rules apply:
+
+#. Single-letter extensions come first, in canonical order.
+   The canonical order is "IMAFDQLCBKJTPVH".
+
+#. All multi-letter extensions will be separated from other extensions by an
+   underscore.
+
+#. Additional standard extensions (starting with 'Z') will be sorted after
+   single-letter extensions and before any higher-privileged extensions.
+
+#. For additional standard extensions, the first letter following the 'Z'
+  conventionally indicates the most closely related alphabetical
+  extension category. If multiple 'Z' extensions are named, they will be ordered
+  first by category, in canonical order, as listed above, then alphabetically
+  within a category.
+
+#. Standard supervisor-level extensions (starting with 'S') will be listed
+   after standard unprivileged extensions.  If multiple supervisor-level
+   extensions are listed, they will be ordered alphabetically.
+
+#. Standard machine-level extensions (starting with 'Zxm') will be listed
+   after any lower-privileged, standard extensions. If multiple machine-level
+   extensions are listed, they will be ordered alphabetically.
+
+#. Non-standard extensions (starting with 'X') will be listed after all standard
+   extensions. If multiple non-standard extensions are listed, they will be
+   ordered alphabetically.
+
+An example string following the order is::
+
+   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
+
+Misaligned accesses
+-------------------
+
 Misaligned accesses are supported in userspace, but they may perform poorly.
-- 
2.38.1

