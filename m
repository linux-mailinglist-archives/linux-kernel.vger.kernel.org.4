Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691765D06D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjADKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjADKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:11:13 -0500
X-Greylist: delayed 213 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 02:11:11 PST
Received: from a27-190.smtp-out.us-west-2.amazonses.com (a27-190.smtp-out.us-west-2.amazonses.com [54.240.27.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77585FE2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ude52klaz7ukvnrchdbsicqdl2lnui6h; d=aaront.org; t=1672826857;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=FTCjnpVJ1Qh/9O+K6EEOvEZWCHvxPMB2xlJghH+d0qo=;
        b=A5tveU8Nh7T8MYsTOAKCEKAiwN8Z4OAP5OT+m+IZ9XUwMrg/W9uvtRti/e0EPc20
        dqA1WfxN+NuUkachusnp5Aac/sA0CdD3OrqyzNyE+EERNf+cHhwMcHRdZYrqmDvR3si
        EGJwU4FQOpq3vZ7l0zFfuHujZ4c44S/TBg1nhD2g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1672826857;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=FTCjnpVJ1Qh/9O+K6EEOvEZWCHvxPMB2xlJghH+d0qo=;
        b=bbOFEW2rqqDUllqiiJxo2qz3wbAEhYVwwvsV9atClOR/9pXcRGNSZe8EZtr0y2EN
        DkpOJFhLAhG5FCfGBIdgaqCb3J5d2X0xi+t596gntzFZOYsW+yRGqdjhWNjebGYnCyg
        2zUl1zh7CXwRIM4Xk3MsJcp3PkT82vpsfUEhf8JE=
From:   Aaron Thompson <dev@aaront.org>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Aaron Thompson <dev@aaront.org>
Subject: [PATCH] memblock tests: Fix compilation error.
Date:   Wed, 4 Jan 2023 10:07:37 +0000
Message-ID: <010101857c402765-96e2dbc6-b82b-47e2-a437-4834dbe0b96b-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.us-west-2.OwdjDcIoZWY+bZWuVZYzryiuW455iyNkDEZFeL97Dng=:AmazonSES
X-SES-Outgoing: 2023.01.04-54.240.27.190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cf4694be2b2cf ("tools: Add atomic_test_and_set_bit()") changed
tools/arch/x86/include/asm/atomic.h to include <asm/asm.h>, which causes
'make -C tools/testing/memblock' to fail with:

In file included from ../../include/asm/atomic.h:6,
                 from ../../include/linux/atomic.h:5,
                 from ./linux/mmzone.h:5,
                 from ../../include/linux/mm.h:5,
                 from ../../include/linux/pfn.h:5,
                 from ./linux/memory_hotplug.h:6,
                 from ./linux/init.h:7,
                 from ./linux/memblock.h:11,
                 from tests/common.h:8,
                 from tests/basic_api.h:5,
                 from main.c:2:
../../include/asm/../../arch/x86/include/asm/atomic.h:11:10: fatal error: asm/asm.h: No such file or directory
   11 | #include <asm/asm.h>
      |          ^~~~~~~~~~~

Create a symlink to asm/asm.h in the same manner as the existing one to
asm/cmpxchg.h.

Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 tools/testing/memblock/.gitignore | 1 +
 tools/testing/memblock/Makefile   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/memblock/.gitignore b/tools/testing/memblock/.gitignore
index 654338e0be52..4cc7cd5aac2b 100644
--- a/tools/testing/memblock/.gitignore
+++ b/tools/testing/memblock/.gitignore
@@ -1,4 +1,5 @@
 main
 memblock.c
 linux/memblock.h
+asm/asm.h
 asm/cmpxchg.h
diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 2310ac4d080e..7a1ca694a982 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -29,13 +29,14 @@ include: ../../../include/linux/memblock.h ../../include/linux/*.h \
 
 	@mkdir -p linux
 	test -L linux/memblock.h || ln -s ../../../../include/linux/memblock.h linux/memblock.h
+	test -L asm/asm.h || ln -s ../../../arch/x86/include/asm/asm.h asm/asm.h
 	test -L asm/cmpxchg.h || ln -s ../../../arch/x86/include/asm/cmpxchg.h asm/cmpxchg.h
 
 memblock.c: $(EXTR_SRC)
 	test -L memblock.c || ln -s $(EXTR_SRC) memblock.c
 
 clean:
-	$(RM) $(TARGETS) $(OFILES) linux/memblock.h memblock.c asm/cmpxchg.h
+	$(RM) $(TARGETS) $(OFILES) linux/memblock.h memblock.c asm/asm.h asm/cmpxchg.h
 
 help:
 	@echo  'Memblock simulator'
-- 
2.30.2

