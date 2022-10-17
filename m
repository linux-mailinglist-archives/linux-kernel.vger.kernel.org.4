Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83956011EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiJQO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiJQOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3EA67CBE;
        Mon, 17 Oct 2022 07:54:03 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sQTqR7JNo9YwgGdZV+8islDgWyBO5eZt3gU7Jv+2Vc=;
        b=AoOrGoKIAQyu2WPlnxnDckQaegpZPvgiC0+b/AV2PoOsyzp7MIClho+PfSnbJ4Hcz4sqPg
        gdVQW1H2HOuybAKWr82sOF90y2zX11QDby5DaHRb+BjAceOEDyiDZrY2JT/bpUL63fF8IO
        66gvDoBznHn1vxnnJT8pq+YgFKr6nVXyilL391OMuTZtPrIAQ+BWB6kWSAB7Ahk8F6V0Fx
        m2bIT34z92gFsbiKxxwHoQcclX1+uutdaYTC4bfqf4c6GgiTooPc1z1uQg1NvXErT+SWjG
        vyX62lQAdGN5uZ66zga9P4tvb2rjF60LmOmnzDh8WQjrZvAH7KQ3S5RNUdM3sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sQTqR7JNo9YwgGdZV+8islDgWyBO5eZt3gU7Jv+2Vc=;
        b=FRU4pCCmMC8S8mxqlSEMRtwzcVoSDOjlG8kTuaLSOA+DkEvAD4EjjVgn69HCHiGrrnXAYp
        r4cIq3WM9AIdBJDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add .call_sites section
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.016511961@infradead.org>
References: <20220915111146.016511961@infradead.org>
MIME-Version: 1.0
Message-ID: <166601844011.401.15723883118148497291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     00abd38408127a57861698a8bffba65849de6bbd
Gitweb:        https://git.kernel.org/tip/00abd38408127a57861698a8bffba65849de6bbd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:07 +02:00

objtool: Add .call_sites section

In preparation for call depth tracking provide a section which collects all
direct calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.016511961@infradead.org
---
 arch/x86/kernel/vmlinux.lds.S           |  7 +++-
 tools/objtool/check.c                   | 51 ++++++++++++++++++++++++-
 tools/objtool/include/objtool/objtool.h |  1 +-
 tools/objtool/objtool.c                 |  1 +-
 4 files changed, 60 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0e9fc08..b69df9e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -291,6 +291,13 @@ SECTIONS
 		*(.return_sites)
 		__return_sites_end = .;
 	}
+
+	. = ALIGN(8);
+	.call_sites : AT(ADDR(.call_sites) - LOAD_OFFSET) {
+		__call_sites = .;
+		*(.call_sites)
+		__call_sites_end = .;
+	}
 #endif
 
 #ifdef CONFIG_X86_KERNEL_IBT
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bb7c819..f578e03 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -902,6 +902,49 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	return 0;
 }
 
+static int create_direct_call_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	unsigned int *loc;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".call_sites");
+	if (sec) {
+		INIT_LIST_HEAD(&file->call_list);
+		WARN("file already has .call_sites section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->call_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->call_list, call_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, ".call_sites", 0, sizeof(unsigned int), idx);
+	if (!sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->call_list, call_node) {
+
+		loc = (unsigned int *)sec->data->d_buf + idx;
+		memset(loc, 0, sizeof(unsigned int));
+
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(unsigned int),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset))
+			return -1;
+
+		idx++;
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1279,6 +1322,9 @@ static void annotate_call_site(struct objtool_file *file,
 		return;
 	}
 
+	if (insn->type == INSN_CALL && !insn->sec->init)
+		list_add_tail(&insn->call_node, &file->call_list);
+
 	if (!sibling && dead_end_function(file, sym))
 		insn->dead_end = true;
 }
@@ -4305,6 +4351,11 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+
+		ret = create_direct_call_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.mcount) {
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 7f2d1b0..6b40977 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -28,6 +28,7 @@ struct objtool_file {
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	struct list_head endbr_list;
+	struct list_head call_list;
 	bool ignore_unreachables, hints, rodata;
 
 	unsigned int nr_endbr;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index a7ecc32..6affd80 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -106,6 +106,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	INIT_LIST_HEAD(&file.endbr_list);
+	INIT_LIST_HEAD(&file.call_list);
 	file.ignore_unreachables = opts.no_unreachable;
 	file.hints = false;
 
