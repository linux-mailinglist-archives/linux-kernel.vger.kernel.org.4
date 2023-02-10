Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE6692148
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjBJO7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBJO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:59:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291551E9D3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676041109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0GuaSLkqsctnE/R9PtYsrkRTyTfi3C3gicyzl5WAfdo=;
        b=RLDLedI0+TRxXzuvdall4Hr5Lod16chOv/FXiuD4SiO5DWBJPY8YWjg0KwqSuZDAQrDvDR
        3bmPmSbymYzQKz79LmF3/EdB0cxEsJfGMPDtqZpNI1dG5Z6z/0sYuIxZ5BUG//zZ6IKjdE
        sWqbb6GCFDqXWmWJwZ8p08v3eLZp9tQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-BNTeKE40P6WzFltaOLQDqg-1; Fri, 10 Feb 2023 09:58:26 -0500
X-MC-Unique: BNTeKE40P6WzFltaOLQDqg-1
Received: by mail-ej1-f69.google.com with SMTP id l18-20020a1709067d5200b008af415fdd80so3117422ejp.21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GuaSLkqsctnE/R9PtYsrkRTyTfi3C3gicyzl5WAfdo=;
        b=zVqgwByA5nigbpAakJfTVl79PyNOjy/gf0qTETjT9hWjc8N0XkqgYwjYR3rAewVL/k
         +IBVr7DLfBrG08AEKpgwOO0smFUL1DzPvww4QJN8ZQ+tSStEeK+/jLAz3VpsDqLx8cmQ
         4HbPrZFhP9tmqASnsKkIe3auLHz+zJ+gWFSAb7e95q0A20Z01mG1N8LSkOZuKmGzSR8f
         sQ2wJsak/7d7pXzJu0pZoMf6PJXbzrU0ABsU7RJgJDQ/UB1EnJ9583ifyqZofy1oAYgb
         IS7ts8Q6sEvgurwnIaG3uK5ACuKSD+QVEkJuCPfm5YLmPRI4t5Z5qYBeLnZNs9dY1L1y
         N5xQ==
X-Gm-Message-State: AO0yUKUpJLo8/4ia+5w23/NMzrWpY3C+V6fmAmw/YRNfN3qaCaA82csm
        NhtPO0IBM/TFQrlLNIohopJPt4k5NtZcvNDNHz3CKQt0TFpQ65ACv07vfKzvLLaKKKtvWhqPQhZ
        jDV2Q9SYv25MclW+VzKIPLVhO
X-Received: by 2002:a17:906:830c:b0:878:5d46:9ed2 with SMTP id j12-20020a170906830c00b008785d469ed2mr15520858ejx.39.1676041105001;
        Fri, 10 Feb 2023 06:58:25 -0800 (PST)
X-Google-Smtp-Source: AK7set/KjOFaibc3QsEtqV/UTTJ1bP7jy1oQlsDgl+T1vfPoK6IQJs9Fi4kyrR2gjuPttCI2bZZVOw==
X-Received: by 2002:a17:906:830c:b0:878:5d46:9ed2 with SMTP id j12-20020a170906830c00b008785d469ed2mr15520849ejx.39.1676041104825;
        Fri, 10 Feb 2023 06:58:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id mj13-20020a170906af8d00b0089b6fd89429sm2509620ejb.10.2023.02.10.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:58:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: fix proc_dobool() usability
Date:   Fri, 10 Feb 2023 15:58:23 +0100
Message-Id: <20230210145823.756906-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently proc_dobool expects a (bool *) in table->data, but sizeof(int)
in table->maxsize, because it uses do_proc_dointvec() directly.

This is unsafe for at least two reasons:
1. A sysctl table definition may use { .data = &variable, .maxsize =
   sizeof(variable) }, not realizing that this makes the sysctl unusable
   (see the Fixes: tag) and that they need to use the completely
   counterintuitive sizeof(int) instead.
2. proc_dobool() will currently try to parse an array of values if given
   .maxsize >= 2*sizeof(int), but will try to write values of type bool
   by offsets of sizeof(int), so it will not work correctly with neither
   an (int *) nor a (bool *). There is no .maxsize validation to prevent
   this.

Fix this by:
1. Constraining proc_dobool() to allow only one value and .maxsize ==
   sizeof(bool).
2. Wrapping the original struct ctl_table in a temporary one with .data
   pointing to a local int variable and .maxsize set to sizeof(int) and
   passing this one to proc_dointvec(), converting the value to/from
   bool as needed (using proc_dou8vec_minmax() as an example).
3. Extending sysctl_check_table() to enforce proc_dobool() expectations.
4. Fixing the proc_dobool() docstring (it was just copy-pasted from
   proc_douintvec, apparently...).
5. Converting all existing proc_dobool() users to set .maxsize to
   sizeof(bool) instead of sizeof(int).

Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
Fixes: a2071573d634 ("sysctl: introduce new proc handler proc_dobool")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/lockd/svc.c        |  2 +-
 fs/proc/proc_sysctl.c |  6 ++++++
 kernel/sysctl.c       | 43 ++++++++++++++++++++++++-------------------
 mm/hugetlb_vmemmap.c  |  2 +-
 4 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 59ef8a1f843f3..914ea1c3537d1 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -496,7 +496,7 @@ static struct ctl_table nlm_sysctls[] = {
 	{
 		.procname	= "nsm_use_hostnames",
 		.data		= &nsm_use_hostnames,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(bool),
 		.mode		= 0644,
 		.proc_handler	= proc_dobool,
 	},
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 48f2d60bd78a2..436025e0f77a6 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1124,6 +1124,11 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 			err |= sysctl_err(path, table, "array not allowed");
 	}
 
+	if (table->proc_handler == proc_dobool) {
+		if (table->maxlen != sizeof(bool))
+			err |= sysctl_err(path, table, "array not allowed");
+	}
+
 	return err;
 }
 
@@ -1136,6 +1141,7 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 			err |= sysctl_err(path, entry, "Not a file");
 
 		if ((entry->proc_handler == proc_dostring) ||
+		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
 		    (entry->proc_handler == proc_douintvec) ||
 		    (entry->proc_handler == proc_douintvec_minmax) ||
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 137d4abe3eda1..1c240d2c99bcb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -425,21 +425,6 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
-static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
-				int *valp,
-				int write, void *data)
-{
-	if (write) {
-		*(bool *)valp = *lvalp;
-	} else {
-		int val = *(bool *)valp;
-
-		*lvalp = (unsigned long)val;
-		*negp = false;
-	}
-	return 0;
-}
-
 static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
 				 int *valp,
 				 int write, void *data)
@@ -710,16 +695,36 @@ int do_proc_douintvec(struct ctl_table *table, int write,
  * @lenp: the size of the user buffer
  * @ppos: file position
  *
- * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string.
+ * Reads/writes one integer value from/to the user buffer,
+ * treated as an ASCII string.
+ *
+ * table->data must point to a bool variable and table->maxlen must
+ * be sizeof(bool).
  *
  * Returns 0 on success.
  */
 int proc_dobool(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos,
-				do_proc_dobool_conv, NULL);
+	struct ctl_table tmp;
+	bool *data = table->data;
+	int res, val;
+
+	/* Do not support arrays yet. */
+	if (table->maxlen != sizeof(bool))
+		return -EINVAL;
+
+	tmp = *table;
+	tmp.maxlen = sizeof(val);
+	tmp.data = &val;
+
+	val = READ_ONCE(*data);
+	res = proc_dointvec(&tmp, write, buffer, lenp, ppos);
+	if (res)
+		return res;
+	if (write)
+		WRITE_ONCE(*data, val);
+	return 0;
 }
 
 /**
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 45e93a545dd7e..a559037cce00c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -581,7 +581,7 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
 		.data		= &vmemmap_optimize_enabled,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(vmemmap_optimize_enabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dobool,
 	},
-- 
2.39.1

