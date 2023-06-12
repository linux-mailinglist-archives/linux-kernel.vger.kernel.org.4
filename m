Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62972D121
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjFLUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbjFLUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A81BDB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C0F462F29
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765A9C43335;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=Evs3XQM2ptmnQVe5RZ3I1FeVEzlmruXYwu3iSmSz9lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ixa3VUIP4/MWYPGOP9kEqnHyLPqFhnHm/9+xZofBjXuUTnfR1pB+oJ0gyij4vtoZg
         eMKZ9pmrD9GXtfwY8aUWURwdBrqwnM5axbQBV7jeGZdUtotgbCnSazSnwWQFIac0Zf
         ol7hDyD+eX6jpJphumP6D25tgCWMtJ9wXDs6y9DCjjCZ7IvvQE5HeIz1xpc0CxFa3O
         GZaiS2lmOrfxBFVpEW/GZV/3ADTlFYBh22LfQcZB9l42fjGxdLldprrDtHnxPHEzM6
         uuCRleCOpFB4sCZagzDNcey7pxCnODSmcKkqjPDDLEJFPSXpaQaZ6quL1BdDAhD93Q
         ppNY/zSDYRzeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2B562CE09E7; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 52/53] selftests/nolibc: also count skipped and failed tests in output
Date:   Mon, 12 Jun 2023 13:45:13 -0700
Message-Id: <20230612204514.292087-52-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
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

From: Willy Tarreau <w@1wt.eu>

Right now skipped and failed test counts are not reported, and a few
times already we missed skipped ones that ought not to. Let's now
count each category and continue to invite the user to check the
report file when skipped+fail > 0. E.g:

  $ make run-user
    (...)
    CC      nolibc-test
  136 test(s) passed, 2 skipped, 0 failed. See all results in .../run.out

Note that it's important to be careful about the trailing \r on the qemu
output (thanks Zhangjin for noticing).

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 44088535682e..4a3a105e1fdf 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -130,7 +130,10 @@ libc-test: nolibc-test.c
 # qemu user-land test
 run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
-	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+	$(Q)awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
+	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
+	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
+	         $(CURDIR)/run.out
 
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
@@ -146,12 +149,18 @@ kernel: initramfs
 # run the tests after building the kernel
 run: kernel
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+	$(Q)awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
+	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
+	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
+	         $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)grep -w FAIL "$(CURDIR)/run.out" && echo "See all results in $(CURDIR)/run.out" || echo "$$(grep -c ^[0-9].*OK $(CURDIR)/run.out) test(s) passed."
+	$(Q)awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
+	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
+	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
+	         $(CURDIR)/run.out
 
 clean:
 	$(call QUIET_CLEAN, sysroot)
-- 
2.40.1

