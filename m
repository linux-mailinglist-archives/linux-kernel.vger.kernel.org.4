Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5D707EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjERLAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjERLAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:00:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4192B10D0;
        Thu, 18 May 2023 04:00:14 -0700 (PDT)
Date:   Thu, 18 May 2023 11:00:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684407612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ogUiYIYbimMvgiKnqi6QFT2oPGAWrxvLomDLcWubdU=;
        b=sdPzQtnXpiAPwysyNSCfwONb1SHJz6MEVNOUwtG/ubmZjJWUwJcqGD+hEWJkjVWE0gpJRl
        m9hTGiM1L+snsmokxr4/f1nspeA4AZODA4D1nyyGzCdjPcyMx/4LPL5EzjhDNyWksd8FsJ
        ms0GAXU9hAxtkUsLf1KYuYdD5u/POEovqaQs7FCcCPVxv7Xuky2setq1vWkip95WrAB9go
        bZp66n52LSOyQPyYXzs2Be8/lL7/zfbb7+65lw2wOs431miC3YqqPIVM25TJKDM+yCEVxv
        yEXvwlyD2juLWMo3Abep3m1WpLEGS2Fy2qkaUkBCCPBLcYoN3jgmlWHPQyGWCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684407612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ogUiYIYbimMvgiKnqi6QFT2oPGAWrxvLomDLcWubdU=;
        b=4CsFd6jBLU1biabuVQXHa9kR52hRmEA4vnvN50nvZysRcPu0ysZjDasdbMN9EcLScDYDif
        UFx1laWk+elTyXDg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] vmlinux.lds.h: Discard .note.gnu.property section
Cc:     Daniel Xu <dxu@dxuuu.xyz>, joanbrugueram@gmail.com,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
MIME-Version: 1.0
Message-ID: <168440761195.404.13281941608603924593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     f7ba52f302fdc392e0047f38e50841483d997144
Gitweb:        https://git.kernel.org/tip/f7ba52f302fdc392e0047f38e50841483d9=
97144
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:49:25 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:30:50 -07:00

vmlinux.lds.h: Discard .note.gnu.property section

When tooling reads ELF notes, it assumes each note entry is aligned to
the value listed in the .note section header's sh_addralign field.

The kernel-created ELF notes in the .note.Linux and .note.Xen sections
are aligned to 4 bytes.  This causes the toolchain to set those
sections' sh_addralign values to 4.

On the other hand, the GCC-created .note.gnu.property section has an
sh_addralign value of 8 for some reason, despite being based on struct
Elf32_Nhdr which only needs 4-byte alignment.

When the mismatched input sections get linked together into the vmlinux
.notes output section, the higher alignment "wins", resulting in an
sh_addralign of 8, which confuses tooling.  For example:

  $ readelf -n .tmp_vmlinux.btf
  ...
  readelf: .tmp_vmlinux.btf: Warning: note with invalid namesz and/or descsz =
found at offset 0x170
  readelf: .tmp_vmlinux.btf: Warning:  type: 0x4, namesize: 0x006e6558, descs=
ize: 0x00008801, alignment: 8

In this case readelf thinks there's alignment padding where there is
none, so it starts reading an ELF note in the middle.

With newer toolchains (e.g., latest Fedora Rawhide), a similar mismatch
triggers a build failure when combined with CONFIG_X86_KERNEL_IBT:

  btf_encoder__encode: btf__dedup failed!
  Failed to encode BTF
  libbpf: failed to find '.BTF' ELF section in vmlinux
  FAILED: load BTF from vmlinux: No data available
  make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255

This latter error was caused by pahole crashing when it encountered the
corrupt .notes section.  This crash has been fixed in dwarves version
1.25.  As Tianyi Liu describes:

  "Pahole reads .notes to look for LINUX_ELFNOTE_BUILD_LTO. When LTO is
   enabled, pahole needs to call cus__merge_and_process_cu to merge
   compile units, at which point there should only be one unspecified
   type (used to represent some compilation information) in the global
   context.

   However, when the kernel is compiled without LTO, if pahole calls
   cus__merge_and_process_cu due to alignment issues with notes,
   multiple unspecified types may appear after merging the cus, and
   older versions of pahole only support up to one. This is why pahole
   1.24 crashes, while newer versions support multiple. However, the
   latest version of pahole still does not solve the problem of
   incorrect LTO recognition, so compiling the kernel may be slower
   than normal."

Even with the newer pahole, the note section misaligment issue still
exists and pahole is misinterpreting the LTO note.  Fix it by discarding
the .note.gnu.property section.  While GNU properties are important for
user space (and VDSO), they don't seem to have any use for vmlinux.

(In fact, they're already getting (inadvertently) stripped from vmlinux
when CONFIG_DEBUG_INFO_BTF is enabled.  The BTF data is extracted from
vmlinux.o with "objcopy --only-section=3D.BTF" into .btf.vmlinux.bin.o.
That file doesn't have .note.gnu.property, so when it gets modified and
linked back into the main object, the linker automatically strips it
(see "How GNU properties are merged" in the ld man page).)

Reported-by: Daniel Xu <dxu@dxuuu.xyz>
Link: https://lkml.kernel.org/bpf/57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fa=
stmail.com
Debugged-by: Tianyi Liu <i.pear@outlook.com>
Suggested-by: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
Link: https://lore.kernel.org/r/20230418214925.ay3jpf2zhw75kgmd@treble
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/asm-generic/vmlinux.lds.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.=
lds.h
index d1f57e4..cebdf1c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -891,9 +891,16 @@
 /*
  * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
  * Otherwise, the type of .notes section would become PROGBITS instead of NO=
TES.
+ *
+ * Also, discard .note.gnu.property, otherwise it forces the notes section to
+ * be 8-byte aligned which causes alignment mismatches with the kernel's cus=
tom
+ * 4-byte aligned notes.
  */
 #define NOTES								\
-	/DISCARD/ : { *(.note.GNU-stack) }				\
+	/DISCARD/ : {							\
+		*(.note.GNU-stack)					\
+		*(.note.gnu.property)					\
+	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		BOUNDED_SECTION_BY(.note.*, _notes)			\
 	} NOTES_HEADERS							\
