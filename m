Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479BD62EF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbiKRI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbiKRI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:28:24 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAD3293CF7;
        Fri, 18 Nov 2022 00:28:22 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_NgkQndjZ48IAA--.24119S3;
        Fri, 18 Nov 2022 16:28:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxb+IhQndjbGsWAA--.58945S2;
        Fri, 18 Nov 2022 16:28:17 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Use "grep -E" instead of "egrep"
Date:   Fri, 18 Nov 2022 16:28:11 +0800
Message-Id: <1668760091-20150-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxb+IhQndjbGsWAA--.58945S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWUCFy3Kw1DtFyrWry7GFg_yoW8Ww1xpa
        1Fk3WDtws7XryUGFWrCFW3Xw15tFs5J3yj9FWUtw15tas5X3W3Ar1fAFZ8XF17GrWkAay8
        Was3uFy3Jr4kAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOF4_UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the related file to use "grep -E" instead.

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/Makefile      | 2 +-
 arch/mips/vdso/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index b296e33..490dea0 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -318,7 +318,7 @@ KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
-	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
+	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
 
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index f72658b..1f7d5c6 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -71,7 +71,7 @@ KCOV_INSTRUMENT := n
 
 # Check that we don't have PIC 'jalr t9' calls left
 quiet_cmd_vdso_mips_check = VDSOCHK $@
-      cmd_vdso_mips_check = if $(OBJDUMP) --disassemble $@ | egrep -h "jalr.*t9" > /dev/null; \
+      cmd_vdso_mips_check = if $(OBJDUMP) --disassemble $@ | grep -E -h "jalr.*t9" > /dev/null; \
 		       then (echo >&2 "$@: PIC 'jalr t9' calls are not supported"; \
 			     rm -f $@; /bin/false); fi
 
-- 
2.1.0

