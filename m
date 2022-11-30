Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5E63E5AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiK3XmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK3XmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:42:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01F4B9B9;
        Wed, 30 Nov 2022 15:42:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93F061E5F;
        Wed, 30 Nov 2022 23:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89BFC4347C;
        Wed, 30 Nov 2022 23:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669851725;
        bh=Z7aEnVV+jWqoN52K1e+YmgnpAmHL+qz1PmK3NhAzRxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnIw4/IrxANCSz/9VMiRA2KIF6h3JhMAHa/K90/tVJu+PWuZwyGcVwk6Y/zm+B+jL
         SlBUCNPTLbcVhrHzZob+j5KwC/UXl07hBKXLBafS0wmQjHhK9Fw9J/vp4+JR7Y94uS
         TBP2keeu8Tg48fv4xCCzWzvNHS7gGuGlALoUG+FhDzeU/snOwUnk+ZLnOvmNTK/YGA
         lnuxunckxgcjRYxr0IB9pBW+hzIHmoPtb27IEAy2PWT44dlttLMlsVwte40Y/vhbPA
         sVQJHXRlDzCKMWkh3ALONUhRQT9ISq2l2EOKGhVynuXRuW2SWJGFVPd6riRsdahpDe
         SiRZLV22KB8Hw==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, conor@kernel.org, corbet@lwn.net,
        guoren@kernel.org, heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 3/3] Documentation: riscv: add a section about ISA string ordering in /proc/cpuinfo
Date:   Wed, 30 Nov 2022 23:41:26 +0000
Message-Id: <20221130234125.2722364-4-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130234125.2722364-1-conor@kernel.org>
References: <20221130234125.2722364-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The RISC-V specs are permissive in what they allow as the ISA string,
but how we output this to userspace in /proc/cpuinfo is quasi uAPI.

Formalise this as part of the uAPI, by documenting the list of rules
we use at this point in time.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I've not "tested" these docs. The NIPA-esque pwbot should go and
test it AFAICT. If it doesn't, I'll go add that.
---
 Documentation/riscv/uabi.rst | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
index 21a82cfb6c4d..bc3c8ced644b 100644
--- a/Documentation/riscv/uabi.rst
+++ b/Documentation/riscv/uabi.rst
@@ -3,4 +3,46 @@
 RISC-V Linux User ABI
 =====================
 
+Misaligned accesses
+-------------------
+
 Misaligned accesses are supported in userspace, but they may perform poorly.
+
+ISA string ordering in /proc/cpuinfo
+------------------------------------
+
+The canonical order of ISA extension names in the ISA string is defined in
+chapter 27 of the unprivileged specification.
+The specification uses vague wording, such as should, when it comes to
+ordering, so for our purposes the following rules apply:
+
+#. Single-letter extensions come first, in "canonical order", so
+   "IMAFDQLCBKJTPVH".
+
+#. All multi-letter extensions will be separated from other multi-letter
+   extensions by an underscore.
+
+#. Additional standard extensions (starting with 'Z') will be sorted after
+   single-letter extensions and before any higher-privileged extensions.
+
+#. The first letter following the 'Z' conventionally indicates the most
+   closely related alphabetical extension category, IMAFDQLCBKJTPVH.
+   If multiple 'Z' extensions are named, they should be ordered first by
+   category, then alphabetically within a category.
+
+#. Standard supervisor-level extensions (starting with 'S') will be listed
+   after standard unprivileged extensions.  If multiple
+   supervisor-level extensions are listed, they will be ordered
+   alphabetically.
+
+#. Standard machine-level extensions (starting with 'Zxm') will be listed
+   after any lower-privileged, standard extensions.  If multiple
+   machine-level extensions are listed, they will be ordered
+   alphabetically.
+
+#. Non-standard extensions (starts with 'X') will be listed after all
+   standard extensions.
+
+An example string following the order is:
+   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
+
-- 
2.38.1

