Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998DB7484D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjGENV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGENV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:21:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817C1712;
        Wed,  5 Jul 2023 06:21:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666ed230c81so5391506b3a.0;
        Wed, 05 Jul 2023 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688563315; x=1691155315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWZ2BR25Cbtl3kBv+8LWgxKufJ8qRo9llA2CSXzR8TE=;
        b=bsudlm5PkQKnpUn1ukxjRu0GLhKbw80SpKgMn3C313bSS20dJntXXYLb6ofi4N0AIl
         g78CIsTJ0cDrAEqrZ7mb6hb8i4rAcnX2Ncaxa8VzmMXYCA2FkMrF94PkNbwkzZo7huuA
         hI0otLbl8jtsdm7Y6XdkO7su4m+tfDKfi/muIVt8zwk1cKEptzJkT9d4GnGyWxfwYS13
         rN90sJ2yIOlZJm9XG5Hzn5RtvZDkb1/s4AEI9C7sOBlCAexS4OzqeO8hlp+rBBq8bbrx
         jatVWyY8czVie8ZmwqhdQFfa9LpC8VvqzkWGA/7+sYFm3xBq77JeEV1rPgd+VjpUkDpl
         SbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688563315; x=1691155315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWZ2BR25Cbtl3kBv+8LWgxKufJ8qRo9llA2CSXzR8TE=;
        b=GRUl6SSwmfukmTua9af+uyWXmavE6/MKb09+3lkMgFoTY0bwijt6MoheGsgZu+wmCe
         7asgjea9kbU+ZRSxUs1Wi/QywoCjPSC6KRPjZr0IXYV7DCdIy0CWJEafBJdjHPpqZCBI
         x4/cpK6Rn2hW5/EI9rnOypWmo4f6lYqtkvoB2eWI141A+3730I5UEeUGeYXPGewAO4kt
         ByJor5FKw0JP7nQjrqpA+MT8Ka2+ldXlpJpCjyvymjrzQQzcrGmdmoZXfrbNf+qH49bM
         vpbfj15j/YI5MNKpdJ+4eB5EvMtISfeRw76efKAN7yjgJdGo+mhlWRNr3rGJSXwPYTyM
         c9Jw==
X-Gm-Message-State: ABy/qLZypW1epj79NwOxz5C94uFu95yui6JHhiaVip27UjMzAWk+NOR7
        +tjW2+7l7EtuFU0yetpelpo=
X-Google-Smtp-Source: APBJJlH2cSDdFwAzfcLUmmPQ0Md5HsQL4eBonj4K6fIf9YVgLBZ71RPiQiddkScj1fu7wU+do1ESfA==
X-Received: by 2002:a05:6a00:2282:b0:668:7325:e184 with SMTP id f2-20020a056a00228200b006687325e184mr21489399pfe.16.1688563314761;
        Wed, 05 Jul 2023 06:21:54 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id j25-20020a62e919000000b00682a0184742sm3645292pfh.148.2023.07.05.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:21:54 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        hffilwlqm@gmail.com, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Introduce bpf generic log
Date:   Wed,  5 Jul 2023 21:20:58 +0800
Message-ID: <20230705132058.46194-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, excluding verifier, users are unable to obtain detailed error
information when issues occur in BPF syscall.

To overcome this limitation, bpf generic log is introduced to provide
error details similar to the verifier. This enhancement will enable the
reporting of error details along with the corresponding errno in BPF
syscall.

Essentially, bpf generic log functions as a mechanism similar to netlink,
enabling the transmission of error messages to user space. This
mechanism greatly enhances the usability of BPF syscall by allowing
users to access comprehensive error messages instead of relying solely
on errno.

This patch specifically addresses the error reporting in dev_xdp_attach()
. With this patch, the error messages will be transferred to user space
like the netlink approach. Hence, users will be able to check the error
message along with the errno.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/linux/bpf.h            | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  6 ++++++
 kernel/bpf/log.c               | 33 +++++++++++++++++++++++++++++++++
 net/core/dev.c                 | 11 ++++++++++-
 tools/include/uapi/linux/bpf.h |  6 ++++++
 5 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830..fd63f4a76 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3077,4 +3077,34 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
+#define BPF_GENERIC_TMP_LOG_SIZE	256
+
+struct bpf_generic_log {
+	char		kbuf[BPF_GENERIC_TMP_LOG_SIZE];
+	char __user	*ubuf;
+	u32		len_used;
+	u32		len_total;
+};
+
+__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
+			const char *fmt, ...);
+static inline void bpf_generic_log_init(struct bpf_generic_log *log,
+			const struct bpf_generic_user_log *ulog)
+{
+	log->ubuf = (char __user *) (unsigned long) ulog->log_buf;
+	log->len_total = ulog->log_size;
+	log->len_used = 0;
+}
+
+#define BPF_GENERIC_LOG_WRITE(log, ulog, fmt, ...)	do {	\
+	const char *____fmt = (fmt);				\
+	bpf_generic_log_init(log, ulog);			\
+	bpf_generic_log_write(log, ____fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#define BPF_GENERIC_ULOG_WRITE(ulog, fmt, ...)	do {			\
+	struct bpf_generic_log ____log;					\
+	BPF_GENERIC_LOG_WRITE(&____log, ulog, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59be..34fa33493 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_generic_user_log {
+	__aligned_u64	log_buf;    /* user supplied buffer */
+	__u32		log_size;   /* size of user buffer */
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 union bpf_attr {
@@ -1544,6 +1549,7 @@ union bpf_attr {
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
+		struct bpf_generic_user_log log; /* user log */
 		union {
 			__u32		target_btf_id;	/* btf_id of target to attach to */
 			struct {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 850494423..be56b153b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -325,3 +325,36 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 	va_end(args);
 }
 EXPORT_SYMBOL_GPL(bpf_log);
+
+static inline void __bpf_generic_log_write(struct bpf_generic_log *log, const char *fmt,
+				      va_list args)
+{
+	unsigned int n;
+
+	n = vscnprintf(log->kbuf, BPF_GENERIC_TMP_LOG_SIZE, fmt, args);
+
+	WARN_ONCE(n >= BPF_GENERIC_TMP_LOG_SIZE - 1,
+		  "bpf generic log truncated - local buffer too short\n");
+
+	n = min(log->len_total - log->len_used - 1, n);
+	log->kbuf[n] = '\0';
+
+	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
+		log->len_used += n;
+	else
+		log->ubuf = NULL;
+}
+
+__printf(2, 3) void bpf_generic_log_write(struct bpf_generic_log *log,
+				     const char *fmt, ...)
+{
+	va_list args;
+
+	if (!log->ubuf || !log->len_total)
+		return;
+
+	va_start(args, fmt);
+	__bpf_generic_log_write(log, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(bpf_generic_log_write);
diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e5446..e933809c0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9409,12 +9409,20 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 	.update_prog = bpf_xdp_link_update,
 };
 
+static inline void bpf_xdp_link_log(const union bpf_attr *attr, struct netlink_ext_ack *extack)
+{
+	const struct bpf_generic_user_log *ulog = &attr->link_create.log;
+
+	BPF_GENERIC_ULOG_WRITE(ulog, extack->_msg);
+}
+
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
+	struct netlink_ext_ack extack;
 	int err, fd;
 
 	rtnl_lock();
@@ -9440,12 +9448,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	err = dev_xdp_attach_link(dev, NULL, link);
+	err = dev_xdp_attach_link(dev, &extack, link);
 	rtnl_unlock();
 
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
+		bpf_xdp_link_log(attr, &extack);
 		goto out_put_dev;
 	}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59be..34fa33493 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1318,6 +1318,11 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_generic_user_log {
+	__aligned_u64	log_buf;    /* user supplied buffer */
+	__u32		log_size;   /* size of user buffer */
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 union bpf_attr {
@@ -1544,6 +1549,7 @@ union bpf_attr {
 		};
 		__u32		attach_type;	/* attach type */
 		__u32		flags;		/* extra flags */
+		struct bpf_generic_user_log log; /* user log */
 		union {
 			__u32		target_btf_id;	/* btf_id of target to attach to */
 			struct {
-- 
2.41.0

