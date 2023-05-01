Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0CC6F3A68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjEAWZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEAWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:25:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE82123
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:25:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a8075bd7cso5423749276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682979954; x=1685571954;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BxhGqqIjMamiGADI4rmVFfxoo9kAM2Y8zr5TqlELr0=;
        b=U3MTB4tzWaoAeuLf7zTSo4Amq9ScioPloA+jQir4eqboGDJVyEgqL6DdVasMfZHsZg
         vBrehczzN1QTDBrGeQtOjR2w5eHKvycMGoOQXD/HWtb/lBc4NbvnS5An/1CbpglUq5qW
         SeAvFePY6ORF0a+vI3w3jbAKcvG5ZU5Zr2VElZ27XoWwdAvOUCBMnebjx9wV12CbMCCE
         ZE2aNA6Yye5kE6xtjIZ/PAWB3laZQjF1We1N2y0aGiJyGWJDDFeV9w3eRY8Z9/5nsH1u
         fJ+xc92EqXKQ9t/nvrZ6KoEflzOlDUJE2xukjZk/QYj71b51EMACkelg/5rJaWRwVJth
         0q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682979954; x=1685571954;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BxhGqqIjMamiGADI4rmVFfxoo9kAM2Y8zr5TqlELr0=;
        b=GQS4B5nO+tel6/hlz3GwV7GWfTEFFLMCUzTdItxUUvU5bubWPgCPg+Snl9NDAI71Gc
         uRqmaQIZ9KumyojOPvtHYP5QOiNPkDYa2GYt2gl+0XurEPa8/fBhsnyoTp8fyFYfLLXv
         pJxZGnSzpbFFBKFwu7U0aG4IupvKcEaGHGORK7FgR0vL3tzket+kvYLCkPUT7Va9LA3n
         RP10Qhh9127dcK2Bw25Vgg2XVL+azKLG6G/v9VwUiIV/ShYXdrZvC8eA8jeWTiae+t/h
         MCX1KIe8XDBtCspjUE6NVf4UBaQj3DNO6uF0YpaXknpbZlBSsp/mJcdycaPqThBbbz94
         qPpQ==
X-Gm-Message-State: AC+VfDxST5oHDY/LSkL2ZxYeNzuW3zZ9JQn8VnxYRkPmPiMVqrfN9aAE
        T/XEGknwdJ2qb2NGBAMe0wfIKhUR4Veh
X-Google-Smtp-Source: ACHHUZ53guwu8TPGl5Urv7haX8BeewTLGvNppYh1wGDiEF7DNctu6QYxPwQXGekB2IEN6HmXnsYcxrmR94WS
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a05:6902:100e:b0:b8b:f584:6b73 with SMTP
 id w14-20020a056902100e00b00b8bf5846b73mr5947503ybt.10.1682979953813; Mon, 01
 May 2023 15:25:53 -0700 (PDT)
Date:   Mon,  1 May 2023 22:25:51 +0000
Mime-Version: 1.0
Message-ID: <20230501222551.1254686-1-maskray@google.com>
Subject: [PATCH v2] arm64: lds: move .got section out of .text
From:   Fangrui Song <maskray@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the .got section is placed within the output section .text.
However, when .got is non-empty, the SHF_WRITE flag is set for .text
when linked by lld. GNU ld recognizes .text as a special section and
ignores the SHF_WRITE flag. By renaming .text, we can also get the
SHF_WRITE flag.

The kernel has performed R_AARCH64_RELATIVE resolving very early, and can
then assume that .got is read-only. Let's move .got to the vmlinux_rodata
pseudo-segment. The change avoids a section with both executable and
writable permissions.

Signed-off-by: Fangrui Song <maskray@google.com>

--
Changes from v1 (https://lore.kernel.org/lkml/20230428050442.180913-1-maskray@google.com/)
* move .got to the vmlinux_rodata pseudo-segment as suggested by Ard Biesheuvel
---
 arch/arm64/kernel/vmlinux.lds.S | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b9202c2ee18e..3cd7e76cc562 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -181,10 +181,17 @@ SECTIONS
 			KPROBES_TEXT
 			HYPERVISOR_TEXT
 			*(.gnu.warning)
-		. = ALIGN(16);
-		*(.got)			/* Global offset table		*/
 	}
 
+	. = ALIGN(SEGMENT_ALIGN);
+	_etext = .;			/* End of text section */
+
+	/* everything from this point to __init_begin will be marked RO NX */
+	RO_DATA(PAGE_SIZE)
+
+	HYPERVISOR_DATA_SECTIONS
+
+	.got : { *(.got) }
 	/*
 	 * Make sure that the .got.plt is either completely empty or it
 	 * contains only the lazy dispatch entries.
@@ -193,14 +200,6 @@ SECTIONS
 	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
 	       "Unexpected GOT/PLT entries detected!")
 
-	. = ALIGN(SEGMENT_ALIGN);
-	_etext = .;			/* End of text section */
-
-	/* everything from this point to __init_begin will be marked RO NX */
-	RO_DATA(PAGE_SIZE)
-
-	HYPERVISOR_DATA_SECTIONS
-
 	/* code sections that are never executed via the kernel mapping */
 	.rodata.text : {
 		TRAMP_TEXT
-- 
2.40.1.495.gc816e09b53d-goog

