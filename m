Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3B074F337
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGKPU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGKPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:20:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516FE54;
        Tue, 11 Jul 2023 08:20:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9891c73e0fbso1169813666b.1;
        Tue, 11 Jul 2023 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689088821; x=1691680821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7huTybfTEF13yXu4HtntZri2hfP7iL8FYJnFCnMvJWg=;
        b=NgGnNEcVV2Q6rHyzM8AmQVBmml0EPmsrO6qPrzsnaTQ63Q9nVducdVK4I9vqP89hUV
         oXiolIJy4cCI3VkOWbdL76pGziMmeEFOrMEwscT0Nl498XDWFfyUV7wXdkcAp3IViyjK
         3b474JDSl06l0U1EgYSHNj3Zh5eI2Cx8x+BYlurXavFGYQewIl4FNvDsIIFt0QXLFB/t
         IT28+sCpOYCqr6elRcpxhge/HVJrOGDWN2U4SaKbWtxJpYkLlM6bHkN2Wcwl4KS5A13N
         J0r28Js2s+mVqXVZwRezxfeq7ejpawYLleXexxS8mrDtUoO/PjKr0ueSxvrSr7obcUNv
         gpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088821; x=1691680821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7huTybfTEF13yXu4HtntZri2hfP7iL8FYJnFCnMvJWg=;
        b=j7sLOdFRn67YACr8NsSpYVSkfKbFn3pOL5RO7I+OPj9FxmoPOFSnKUPNlLoUgjbyo3
         i9wmucUDw9YTPhk8f4u6wWUAAe6uDI6G3Jxw4ma6wPqA5xjIfPnGXK1GFyrKeDu8bCxg
         wZxpSPvUgRtKnSFQX1z6TryXVPJcTNf4Hm/9fDFsWnnwXkjS47F8kslp1QPDfwC3ZtGn
         TMeG+55R9VcKSbjPSPsCgvyHmJHzrxbfC0JcNh5zbxT1WD9JxjpZ435PaMk5ushfPbzT
         JsBpJijq1gkND3rHRAqQ1/nA2Cqc4dqOzuhPCDZnTrVFRjq1O/bQqW9awd6jyfNoSXPh
         fMNg==
X-Gm-Message-State: ABy/qLbAawm/Vqr5ZkF8OZaT5dHX5bfJ90wsePY4cpa8LoUWvO4cji+M
        /XP7p7l24PSCO0zfM16yXgE=
X-Google-Smtp-Source: APBJJlFkNgtBqYCWMzFhchQbiSeyIpF0xPpdZHyNdl5F+xss992Kvdoo7qyiMOt9r/HuzKbX9HD5iQ==
X-Received: by 2002:a17:906:d54b:b0:98e:48cc:4cbf with SMTP id cr11-20020a170906d54b00b0098e48cc4cbfmr24143570ejc.26.1689088820617;
        Tue, 11 Jul 2023 08:20:20 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id h14-20020aa7de0e000000b0051e0cb4692esm1384031edv.17.2023.07.11.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:20:20 -0700 (PDT)
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bristot@kernel.org, vmalik@redhat.com,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Subject: [PATCH] scripts/link-vmlinux.sh: Add alias to duplicate symbols for kallsyms
Date:   Tue, 11 Jul 2023 15:19:25 +0000
Message-Id: <20230711151925.1092080-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not uncommon for drivers or modules related to similar peripherals
to have symbols with the exact same name.
While this is not a problem for the kernel's binary itself, it becomes an
issue when attempting to trace or probe specific functions using
infrastructure like ftrace or kprobe.

The tracing subsystem relies on the `nm -n vmlinux` output, which provides
symbol information from the kernel's ELF binary. However, when multiple
symbols share the same name, the standard nm output does not differentiate
between them. This can lead to confusion and difficulty when trying to
probe the intended symbol.

~ # cat /proc/kallsyms | grep " name_show"
ffffffff8c4f76d0 t name_show
ffffffff8c9cccb0 t name_show
ffffffff8cb0ac20 t name_show
ffffffff8cc728c0 t name_show
ffffffff8ce0efd0 t name_show
ffffffff8ce126c0 t name_show
ffffffff8ce1dd20 t name_show
ffffffff8ce24e70 t name_show
ffffffff8d1104c0 t name_show
ffffffff8d1fe480 t name_show

**kas_alias** addresses this challenge by extending the symbol names with
unique suffixes during the kernel build process.
The newly created aliases for these duplicated symbols are unique names
that can be fed to the tracefs interface. By doing so, it enables
previously unreachable symbols to be probed.

~ # cat /proc/kallsyms | grep " name_show"
ffffffff974f76d0 t name_show
ffffffff974f76d0 t name_show__alias__6340
ffffffff979cccb0 t name_show
ffffffff979cccb0 t name_show__alias__6341
ffffffff97b0ac20 t name_show
ffffffff97b0ac20 t name_show__alias__6342
ffffffff97c728c0 t name_show
ffffffff97c728c0 t name_show__alias__6343
ffffffff97e0efd0 t name_show
ffffffff97e0efd0 t name_show__alias__6344
ffffffff97e126c0 t name_show
ffffffff97e126c0 t name_show__alias__6345
ffffffff97e1dd20 t name_show
ffffffff97e1dd20 t name_show__alias__6346
ffffffff97e24e70 t name_show
ffffffff97e24e70 t name_show__alias__6347
ffffffff981104c0 t name_show
ffffffff981104c0 t name_show__alias__6348
ffffffff981fe480 t name_show
ffffffff981fe480 t name_show__alias__6349
~ # echo "p:kprobes/evnt1 name_show__alias__6349" \
> >/sys/kernel/tracing/kprobe_events
~ # cat /sys/kernel/tracing/kprobe_events
p:kprobes/evnt1 name_show__alias__6349

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 init/Kconfig                        |  17 ++
 scripts/Makefile                    |   4 +
 scripts/kas_alias/Makefile          |   4 +
 scripts/kas_alias/duplicates_list.c |  70 +++++++++
 scripts/kas_alias/duplicates_list.h |  15 ++
 scripts/kas_alias/item_list.c       | 230 ++++++++++++++++++++++++++++
 scripts/kas_alias/item_list.h       |  26 ++++
 scripts/kas_alias/kas_alias.c       | 112 ++++++++++++++
 scripts/link-vmlinux.sh             |   6 +-
 9 files changed, 483 insertions(+), 1 deletion(-)
 create mode 100644 scripts/kas_alias/Makefile
 create mode 100644 scripts/kas_alias/duplicates_list.c
 create mode 100644 scripts/kas_alias/duplicates_list.h
 create mode 100644 scripts/kas_alias/item_list.c
 create mode 100644 scripts/kas_alias/item_list.h
 create mode 100644 scripts/kas_alias/kas_alias.c

diff --git a/init/Kconfig b/init/Kconfig
index f7f65af4ee12..a67b7b1c604b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1737,6 +1737,23 @@ config KALLSYMS_BASE_RELATIVE
 	  time constants, and no relocation pass is required at runtime to fix
 	  up the entries based on the runtime load address of the kernel.
 
+config KALLSYMS_ALIAS
+	bool "Produces alias for duplicated symbols" if EXPERT
+	depends on KALLSYMS
+	help
+	  It is not uncommon for drivers or modules related to similar
+	  peripherals to have symbols with the exact same name.
+	  While this is not a problem for the kernel's binary itself, it
+	  becomes an issue when attempting to trace or probe specific
+	  functions using infrastructure like ftrace or kprobe.
+
+	  This option addresses this challenge by extending the symbol names
+	  with unique suffixes during the kernel build process.
+	  The newly created aliases for these duplicated symbols are unique
+	  names that can be fed to the ftrace sysfs interface. By doing so, it
+	  enables previously unreachable symbols to be probed.
+
+
 # end of the "standard kernel features (expert users)" menu
 
 # syscall, maps, verifier
diff --git a/scripts/Makefile b/scripts/Makefile
index 32b6ba722728..65fafe17cfe5 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -49,3 +49,7 @@ subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 
 # Let clean descend into subdirs
 subdir-	+= basic dtc gdb kconfig mod
+
+# KALLSyms alias
+subdir-$(CONFIG_KALLSYMS_ALIAS) += kas_alias
+
diff --git a/scripts/kas_alias/Makefile b/scripts/kas_alias/Makefile
new file mode 100644
index 000000000000..523fa3441013
--- /dev/null
+++ b/scripts/kas_alias/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+hostprogs-always-$(CONFIG_KALLSYMS_ALIAS)    += kas_alias
+
+kas_alias-objs        := duplicates_list.o item_list.o kas_alias.o
diff --git a/scripts/kas_alias/duplicates_list.c b/scripts/kas_alias/duplicates_list.c
new file mode 100644
index 000000000000..e7a3d2917937
--- /dev/null
+++ b/scripts/kas_alias/duplicates_list.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "item_list.h"
+#include "duplicates_list.h"
+
+struct duplicate_item *find_duplicates(struct item *list)
+{
+	struct duplicate_item *current_duplicate = NULL;
+	struct duplicate_item *duplicates = NULL;
+	struct duplicate_item *new_duplicate;
+	struct item *current_item = list;
+	bool prev_was_duplicate = false;
+	struct item *prev_item = NULL;
+
+	while (current_item) {
+		if ((prev_item && (strcmp(current_item->symb_name, prev_item->symb_name) == 0)) ||
+		    prev_was_duplicate) {
+			if (!duplicates) {
+				duplicates = malloc(sizeof(struct duplicate_item));
+				if (!duplicates)
+					return NULL;
+
+				duplicates->original_item = prev_item;
+				duplicates->next = NULL;
+				current_duplicate = duplicates;
+			} else {
+				new_duplicate = malloc(sizeof(struct duplicate_item));
+				if (!new_duplicate) {
+					free_duplicates(&duplicates);
+					return NULL;
+				}
+
+				new_duplicate->original_item = prev_item;
+				new_duplicate->next = NULL;
+				current_duplicate->next = new_duplicate;
+				current_duplicate = new_duplicate;
+
+				if ((strcmp(current_item->symb_name, prev_item->symb_name) != 0) &&
+				    (prev_was_duplicate))
+					prev_was_duplicate = false;
+				else
+					prev_was_duplicate = true;
+			}
+		}
+
+		prev_item = current_item;
+		current_item = current_item->next;
+	}
+
+	return duplicates;
+}
+
+void free_duplicates(struct duplicate_item **duplicates)
+{
+	struct duplicate_item *duplicates_iterator = *duplicates;
+	struct duplicate_item *app;
+
+	while (duplicates_iterator) {
+		app = duplicates_iterator;
+		duplicates_iterator = duplicates_iterator->next;
+		free(app);
+	}
+
+	*duplicates = NULL;
+}
diff --git a/scripts/kas_alias/duplicates_list.h b/scripts/kas_alias/duplicates_list.h
new file mode 100644
index 000000000000..76aa73e584bc
--- /dev/null
+++ b/scripts/kas_alias/duplicates_list.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef DUPLICATES_LIST_H
+#define DUPLICATES_LIST_H
+
+#include "item_list.h"
+
+struct duplicate_item {
+	struct item *original_item;
+	struct duplicate_item *next;
+};
+
+struct duplicate_item *find_duplicates(struct item *list);
+void free_duplicates(struct duplicate_item **duplicates);
+
+#endif
diff --git a/scripts/kas_alias/item_list.c b/scripts/kas_alias/item_list.c
new file mode 100644
index 000000000000..7c9d5aecca9a
--- /dev/null
+++ b/scripts/kas_alias/item_list.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdbool.h>
+#include <assert.h>
+#include "item_list.h"
+
+#define CHECK_ORDER_BY_ADDRESS(sort_by, current, temp, op) \
+	((sort_by) == BY_ADDRESS && (current)->addr op (temp)->addr)
+#define CHECK_ORDER_BY_NAME(sort_by, current, temp, op) \
+	((sort_by) == BY_NAME && strcmp((current)->symb_name, (temp)->symb_name) op 0)
+
+struct item *list_index[96] = {0};
+
+void build_index(struct item *list)
+{
+	char current_first_letter = ' ';
+	struct item *current = list;
+
+	while (current) {
+		if (current->symb_name[0] != current_first_letter) {
+			current_first_letter = current->symb_name[0];
+			list_index[current_first_letter - 32] = current;
+		}
+		current = current->next;
+	}
+}
+
+struct item *add_item(struct item **list, const char *name, char stype, uint64_t addr)
+{
+	struct item *new_item;
+	struct item *current;
+
+	new_item = malloc(sizeof(struct item));
+	if (!new_item)
+		return NULL;
+
+	strncpy(new_item->symb_name, name, MAX_NAME_SIZE);
+	new_item->symb_name[MAX_NAME_SIZE - 1] = '\0';
+	new_item->addr = addr;
+	new_item->stype = stype;
+	new_item->next = NULL;
+
+	if (!(*list)) {
+		*list = new_item;
+	} else {
+		current = *list;
+		while (current->next)
+			current = current->next;
+
+		current->next = new_item;
+	}
+	return new_item;
+}
+
+void sort_list(struct item **list, int sort_by)
+{
+	struct item *current = *list;
+	struct item *sorted = NULL;
+	struct item *next_item;
+	struct item *temp;
+
+	if (!(*list) || !((*list)->next))
+		return;
+
+	while (current) {
+		next_item = current->next;
+		if (!sorted ||
+		   (CHECK_ORDER_BY_ADDRESS(sort_by, current, sorted, <) ||
+		    CHECK_ORDER_BY_NAME(sort_by, current, sorted, >=))) {
+			current->next = sorted;
+			sorted = current;
+		} else {
+			temp = sorted;
+			while (temp->next &&
+			      (CHECK_ORDER_BY_ADDRESS(sort_by, current, temp->next, >=) ||
+			       CHECK_ORDER_BY_NAME(sort_by, current, temp->next, >=)))
+				temp = temp->next;
+
+			current->next = temp->next;
+			temp->next = current;
+		}
+		current = next_item;
+	}
+
+	*list = sorted;
+}
+
+struct item *merge(struct item *left, struct item *right, int sort_by)
+{
+	struct item *current = NULL;
+	struct item *result = NULL;
+
+	if (!left)
+		return right;
+	if (!right)
+		return left;
+
+	if (sort_by == BY_NAME) {
+		if (strcmp(left->symb_name, right->symb_name) <= 0) {
+			result = left;
+			left = left->next;
+		} else {
+			result = right;
+			right = right->next;
+		}
+	} else {
+		if (sort_by == BY_ADDRESS) {
+			if (left->addr <= right->addr) {
+				result = left;
+				left = left->next;
+			} else {
+				result = right;
+				right = right->next;
+			}
+		}
+	}
+
+	current = result;
+
+	while (left && right) {
+		if (sort_by == BY_NAME) {
+			if (strcmp(left->symb_name, right->symb_name) <= 0) {
+				current->next = left;
+				left = left->next;
+			} else {
+				current->next = right;
+				right = right->next;
+			}
+		} else {
+			if (sort_by == BY_ADDRESS) {
+				if (left->addr <= right->addr) {
+					current->next = left;
+					left = left->next;
+				} else {
+					current->next = right;
+					right = right->next;
+				}
+			}
+		}
+
+		current = current->next;
+	}
+
+	if (left) {
+		current->next = left;
+	} else {
+		if (right)
+			current->next = right;
+	}
+
+	return result;
+}
+
+struct item *merge_sort(struct item *head, int sort_by)
+{
+	struct item *right;
+	struct item *slow;
+	struct item *fast;
+	struct item *left;
+
+	if (!head || !head->next)
+		return head;
+
+	slow = head;
+	fast = head->next;
+
+	while (fast && fast->next) {
+		slow = slow->next;
+		fast = fast->next->next;
+	}
+
+	left = head;
+	right = slow->next;
+	slow->next = NULL;
+
+	left = merge_sort(left, sort_by);
+	right = merge_sort(right, sort_by);
+
+	return merge(left, right, sort_by);
+}
+
+void sort_list_m(struct item **head, int sort_by)
+{
+	if (!(*head) || !((*head)->next))
+		return;
+
+	*head = merge_sort(*head, sort_by);
+}
+
+int insert_after(struct item *list, const uint64_t search_addr,
+		 const char *name, uint64_t addr, char stype)
+{
+	struct item *new_item;
+	struct item *current;
+	int ret = 0;
+
+	current = (list_index[name[0] - 32]) ? list_index[name[0] - 32] : list;
+	while (current) {
+		if (current->addr == search_addr) {
+			new_item = malloc(sizeof(struct item));
+			if (!new_item)
+				return ret;
+			strncpy(new_item->symb_name, name, MAX_NAME_SIZE);
+			new_item->symb_name[MAX_NAME_SIZE - 1] = '\0';
+			new_item->addr = addr;
+			new_item->stype = stype;
+			new_item->next = current->next;
+			current->next = new_item;
+			ret = 1;
+			break;
+		}
+		current = current->next;
+	}
+	return ret;
+}
+
+void free_items(struct item **head)
+{
+	struct item *app, *item_iterator = *head;
+
+	while (item_iterator) {
+		app = item_iterator;
+		item_iterator = item_iterator->next;
+		free(app);
+	}
+	*head = NULL;
+}
diff --git a/scripts/kas_alias/item_list.h b/scripts/kas_alias/item_list.h
new file mode 100644
index 000000000000..b4891cb088ee
--- /dev/null
+++ b/scripts/kas_alias/item_list.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef ITEM_LIST_H
+#define ITEM_LIST_H
+#include <stdint.h>
+
+#define MAX_NAME_SIZE 256
+#define BY_ADDRESS 1
+#define BY_NAME 2
+
+struct item {
+	char		symb_name[MAX_NAME_SIZE];
+	uint64_t	addr;
+	char		stype;
+	struct item	*next;
+};
+
+void build_index(struct item *list);
+struct item *add_item(struct item **list, const char *name, char stype, uint64_t addr);
+void sort_list(struct item **list, int sort_by);
+struct item *merge(struct item *left, struct item *right, int sort_by);
+struct item *merge_sort(struct item *head, int sort_by);
+void sort_list_m(struct item **head, int sort_by);
+int insert_after(struct item *list, const uint64_t search_addr,
+		 const char *name, uint64_t addr, char stype);
+void free_items(struct item **head);
+#endif
diff --git a/scripts/kas_alias/kas_alias.c b/scripts/kas_alias/kas_alias.c
new file mode 100644
index 000000000000..d47cfec9f1f3
--- /dev/null
+++ b/scripts/kas_alias/kas_alias.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdarg.h>
+
+#include "item_list.h"
+#include "duplicates_list.h"
+
+int suffix_serial;
+
+static inline void verbose_msg(bool verbose, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	if (verbose)
+		printf(fmt, args);
+
+	va_end(args);
+}
+
+static void create_suffix(const char *name, char *output_suffix)
+{
+	sprintf(output_suffix, "%s__alias__%d", name, suffix_serial++);
+}
+
+int main(int argc, char *argv[])
+{
+	char t, sym_name[MAX_NAME_SIZE], new_name[MAX_NAME_SIZE + 15];
+	struct duplicate_item  *duplicate_iterator;
+	struct duplicate_item *duplicate;
+	struct item *head = {NULL};
+	bool need_2_process = true;
+	struct item *last = {NULL};
+	struct item  *current;
+	int verbose_mode = 0;
+	uint64_t address;
+	FILE *fp;
+
+	if (argc < 2 || argc > 3) {
+		printf("Usage: %s <nmfile> [-verbose]\n", argv[0]);
+		return 1;
+	}
+
+	if (argc == 3 && strcmp(argv[2], "-verbose") == 0)
+		verbose_mode = 1;
+
+	verbose_msg(verbose_mode, "Scanning nm data(%s)\n", argv[1]);
+
+	fp = fopen(argv[1], "r");
+	if (!fp) {
+		printf("Can't open input file.\n");
+		return 1;
+	}
+
+	while (fscanf(fp, "%lx %c %99s\n", &address, &t, sym_name) == 3) {
+		if (strstr(sym_name, "__alias__1") != NULL) {
+			if (verbose_mode && need_2_process)
+				printf("Already processed\n");
+			need_2_process = false;
+			}
+		last = add_item(&last, sym_name, t, address);
+		if (!last) {
+			printf("Error in allocate memory\n");
+			free_items(&head);
+			return 1;
+		}
+
+		if (!head)
+			head = last;
+	}
+
+	fclose(fp);
+
+	if (need_2_process) {
+		verbose_msg(verbose_mode, "Sorting nm data\n");
+		sort_list_m(&head, BY_NAME);
+		verbose_msg(verbose_mode, "Scanning nm data for duplicates\n");
+		duplicate = find_duplicates(head);
+		if (!duplicate) {
+			printf("Error in duplicates list\n");
+			return 1;
+		}
+
+		verbose_msg(verbose_mode, "Applying suffixes\n");
+		build_index(head);
+		duplicate_iterator = duplicate;
+		while (duplicate_iterator) {
+			create_suffix(duplicate_iterator->original_item->symb_name, new_name);
+			if (!insert_after(head, duplicate_iterator->original_item->addr, new_name,
+					  duplicate_iterator->original_item->addr,
+					  duplicate_iterator->original_item->stype))
+				return 1;
+			duplicate_iterator = duplicate_iterator->next;
+		}
+
+		sort_list_m(&head, BY_ADDRESS);
+	}
+	current = head;
+	while (current) {
+		printf("%08lx %c %s\n", current->addr, current->stype, current->symb_name);
+		current = current->next;
+	}
+
+	free_items(&head);
+	free_duplicates(&duplicate);
+
+	return 0;
+}
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a432b171be82..4e3dea3ac2df 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -161,7 +161,11 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	scripts/kallsyms ${kallsymopt} ${1} > ${2}
+	if is_enabled CONFIG_KALLSYMS_ALIAS; then
+		ALIAS=".alias"
+		scripts/kas_alias/kas_alias ${1} >${1}${ALIAS}
+		fi
+	scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
-- 
2.34.1

