Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E876094B2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJWQZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJWQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:25:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CE58052
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:25:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q1so6772861pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jcQPE22A48a95d0Ogt+bAyJJhmrH6Y8yK7TFRPuffA=;
        b=KnSZxGmLWc/7oLtUvXu2L7AuOqPgZ8Dmv0wdB5e3Jt4pUOCSMjGwFQ77x+tMF4GUO4
         2CgS6mtfqdBJSKi1J0SppHTDP7oZARauEjG4Z+NXdnMTrlv9uS2p8NhWe7zsbdm3KFd2
         2lnfp1zk9YNQwXFZSBVg+emUfNubt7gdKe3a6yQEMioHBfiYk9NobaOKIhsVEDafDXrA
         D0kp4oWYHPkEKIGmhY672F0wVt6GtArCZlMg2C29GHviUTfChGgyZbJPIzZDXKcv4LEX
         v0j0NVBqc+tQgldsSUmQAXRJFsRD5OydkM2pGHJ1qIHLq3u/eMncvqwUIJw1W/vH52Sk
         1KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jcQPE22A48a95d0Ogt+bAyJJhmrH6Y8yK7TFRPuffA=;
        b=qSDNPXGQ1t3jGA9qE8Vecsg0K5QoCmwMRodPyyOFFArQbXm6XAk58B81Xt+Q9QbW+N
         wMo68mq69+9sDjhiYxXu5iJNVHqrcCs9KreAnpJRE4XwjDnj/oOYH5pbzAxrAJpED8gW
         adW9R7s7PB7Py6TNnU8OewgSWkkgFRz+1OLoMtFXA2Zl9AFQ3b322ozevRVuC2jM8hXa
         fpOBR1kNID6WmnSW+icpVdb5va2G0paNv5KgXLe7BIqpEsvG/j1NsvHPyxJVt76Zdqoh
         gD99rctpB7AksdJic1iXRG3qB7n6QwwqGaKVb+tQ30M0hFCRIuL3bmQWQPAkq2Mp1XCH
         G/GA==
X-Gm-Message-State: ACrzQf3/El5UkYQYj7hMNvZN/j4LkEz0DHJWUfDk16yrrxB/JJOde3S0
        Ysup3LMGaaM80+KIe2IuUA0=
X-Google-Smtp-Source: AMsMyM7NWsfmhTNzlYUbFoEXLmLkWMTX9T8RDOi/P8KojKBVLs3iONMPEjEDjjUcKnRmgJR32vKy3g==
X-Received: by 2002:a65:4bc3:0:b0:439:103b:fc35 with SMTP id p3-20020a654bc3000000b00439103bfc35mr24587501pgr.248.1666542338259;
        Sun, 23 Oct 2022 09:25:38 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([1.203.117.185])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b0018685aaf41dsm3727420plg.18.2022.10.23.09.25.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Oct 2022 09:25:37 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH] swap: add a limit for readahead page-cluster value
Date:   Mon, 24 Oct 2022 00:25:33 +0800
Message-Id: <20221023162533.81561-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Currenty there is no upper limit for /proc/sys/vm/page-cluster, and it's
a bit shift value, so it could result in overflow of the 32-bit integer.
Add a reasonable upper limit for it, read-in at most 2**31 pages, which
is a large enough value for readahead.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h | 1 +
 kernel/sysctl.c    | 1 +
 mm/swap.c          | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d42536ce1dab4..5512f3b188fab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -74,6 +74,7 @@ static inline void totalram_pages_add(long count)
 
 extern void * high_memory;
 extern int page_cluster;
+extern const int page_cluster_max;
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 188c305aeb8b7..71a4350ac601b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2125,6 +2125,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&page_cluster_max,
 	},
 	{
 		.procname	= "dirtytime_expire_seconds",
diff --git a/mm/swap.c b/mm/swap.c
index 955930f41d20c..2ab33c82cb062 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -43,8 +43,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/pagemap.h>
 
-/* How many pages do we try to swap or page in/out together? */
+/* How many pages do we try to swap or page in/out together? As a power of 2 */
 int page_cluster;
+const int page_cluster_max = 31;
 
 /* Protecting only lru_rotate.fbatch which requires disabling interrupts */
 struct lru_rotate {
-- 
2.35.2

