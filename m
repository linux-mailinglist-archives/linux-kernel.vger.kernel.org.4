Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0E6510B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLSQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:49:39 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947710540
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:49:38 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d10so4992034ilc.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O53/BMj/UJQrRui9mxtxJP8eMQ6bqXClr1qQJJurLSM=;
        b=Qe31U6yIonvkfkl/5QCFTfJ2g7i0mTSPpjR3/Ugw0vMPfMdpuEI61AUG9W8EODRwDV
         cF9R41MZgNqaiPJocr5rdzc78Fksv9S/MOPWfztf3ty5S3G2OkQau/rh3ld7ACLWVOaG
         ptwLYSmON5sAS/qRqEPXU919vEV/4jyq69MRzTZvwhd2ivmxfCJgb7dPET+GlXv+Pwbt
         5x3HJuCVD6fGKDVtgnvv8mn0+QAH8DWto/tGdR5Wef0hWuYJMgRvvRJ9VYUNmcaE551w
         RiAv2qglWtQ29j3Q4iNO9iJ5za8dIzoC+tPohr+QrQk5MemGb5KIvaaZe4mUbwij7Pf5
         PTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O53/BMj/UJQrRui9mxtxJP8eMQ6bqXClr1qQJJurLSM=;
        b=SaSAfXZwXFE4JFQSTTmoPUIHTdC+CXfEgFQoyqJ24+xMltvzRFqWenwIm0ivTjCzKL
         or8VeUWqNF9LTcj6vAw1IrLW8BPeBZ0T8qZyvCsAwQqpg92FM1a6uRcaeBexu+TXXQEc
         K82fkpg5LztWxOylk8KVHI+fj+jpUl5Xjc1n6WOw99lrMd4JgQfHyS0mOjL0PV/9iOCa
         dl/d5zVpFwTC3xqTGK+p0brY2JFcIYc0TIld+uLqu+JbmI66lANtxguD5YbQMaEzCwej
         PpU0dbAHknoCMbpPSL0a4beYcC4LxhGPzVoGDZJk/TbN0HBuxZfGWZGI1D9baaNtmSme
         Zq9Q==
X-Gm-Message-State: AFqh2komfXq2gO+DiE++j5fYD1tGRKbZGIBFFyv17OJkamOtRnN4BhAf
        rEBphkbVb4kPRGNviXs4BSu7JrYMID27FceNiek=
X-Google-Smtp-Source: AMrXdXs7/nOwEBiskqNbc4mpuAb2eT65ywrTMDNqNwDJk16tTbcyAcBNEi8l/UOEBn1N4OaBDA01gw==
X-Received: by 2002:a92:d746:0:b0:303:3163:cb0a with SMTP id e6-20020a92d746000000b003033163cb0amr5215141ilq.17.1671468577809;
        Mon, 19 Dec 2022 08:49:37 -0800 (PST)
Received: from ip-172-31-23-7.us-east-2.compute.internal (ec2-18-117-238-67.us-east-2.compute.amazonaws.com. [18.117.238.67])
        by smtp.googlemail.com with ESMTPSA id q37-20020a056638346500b00383c144fbd7sm3515170jav.32.2022.12.19.08.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 08:49:37 -0800 (PST)
From:   Jianlin Lv <iecedge@gmail.com>
To:     akpm@linux-foundation.org, yejiajian2018@email.szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn, seanga2@gmail.com,
        zhangyinan2019@email.szu.edu.cn, zhaochongxi2019@email.szu.edu.cn
Cc:     iecedge@gmail.com, jianlv@ebay.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/vm/page_owner_sort: free memory before exit
Date:   Mon, 19 Dec 2022 16:49:17 +0000
Message-Id: <20221219164917.14132-1-iecedge@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Although when a process terminates, the kernel will removes memory
associated with that process, It's neither good style nor proper design
to leave it to kernel.
This patch free allocated memory before process exit.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 tools/vm/page_owner_sort.c | 65 ++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index ce860ab94162..7c2ac124cdc8 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -246,15 +246,16 @@ static int search_pattern(regex_t *pattern, char *pattern_str, char *buf)
 	return 0;
 }
 
-static void check_regcomp(regex_t *pattern, const char *regex)
+static bool check_regcomp(regex_t *pattern, const char *regex)
 {
 	int err;
 
 	err = regcomp(pattern, regex, REG_EXTENDED | REG_NEWLINE);
 	if (err != 0 || pattern->re_nsub != 1) {
 		fprintf(stderr, "Invalid pattern %s code %d\n", regex, err);
-		exit(1);
+		return false;
 	}
+	return true;
 }
 
 static char **explode(char sep, const char *str, int *size)
@@ -494,28 +495,28 @@ static bool is_need(char *buf)
 	return true;
 }
 
-static void add_list(char *buf, int len, char *ext_buf)
+static bool add_list(char *buf, int len, char *ext_buf)
 {
 	if (list_size != 0 &&
 		len == list[list_size-1].len &&
 		memcmp(buf, list[list_size-1].txt, len) == 0) {
 		list[list_size-1].num++;
 		list[list_size-1].page_num += get_page_num(buf);
-		return;
+		return true;
 	}
 	if (list_size == max_size) {
 		fprintf(stderr, "max_size too small??\n");
-		exit(1);
+		return false;
 	}
 	if (!is_need(buf))
-		return;
+		return true;
 	list[list_size].pid = get_pid(buf);
 	list[list_size].tgid = get_tgid(buf);
 	list[list_size].comm = get_comm(buf);
 	list[list_size].txt = malloc(len+1);
 	if (!list[list_size].txt) {
 		fprintf(stderr, "Out of memory\n");
-		exit(1);
+		return false;
 	}
 	memcpy(list[list_size].txt, buf, len);
 	list[list_size].txt[len] = 0;
@@ -534,6 +535,7 @@ static void add_list(char *buf, int len, char *ext_buf)
 		printf("loaded %d\r", list_size);
 		fflush(stdout);
 	}
+	return true;
 }
 
 static bool parse_cull_args(const char *arg_str)
@@ -790,12 +792,19 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	check_regcomp(&order_pattern, "order\\s*([0-9]*),");
-	check_regcomp(&pid_pattern, "pid\\s*([0-9]*),");
-	check_regcomp(&tgid_pattern, "tgid\\s*([0-9]*) ");
-	check_regcomp(&comm_pattern, "tgid\\s*[0-9]*\\s*\\((.*)\\),\\s*ts");
-	check_regcomp(&ts_nsec_pattern, "ts\\s*([0-9]*)\\s*ns,");
-	check_regcomp(&free_ts_nsec_pattern, "free_ts\\s*([0-9]*)\\s*ns");
+	if (!check_regcomp(&order_pattern, "order\\s*([0-9]*),"))
+		goto out_order;
+	if (!check_regcomp(&pid_pattern, "pid\\s*([0-9]*),"))
+		goto out_pid;
+	if (!check_regcomp(&tgid_pattern, "tgid\\s*([0-9]*) "))
+		goto out_tgid;
+	if (!check_regcomp(&comm_pattern, "tgid\\s*[0-9]*\\s*\\((.*)\\),\\s*ts"))
+		goto out_comm;
+	if (!check_regcomp(&ts_nsec_pattern, "ts\\s*([0-9]*)\\s*ns,"))
+		goto out_ts;
+	if (!check_regcomp(&free_ts_nsec_pattern, "free_ts\\s*([0-9]*)\\s*ns"))
+		goto out_free_ts;
+
 	fstat(fileno(fin), &st);
 	max_size = st.st_size / 100; /* hack ... */
 
@@ -804,7 +813,7 @@ int main(int argc, char **argv)
 	ext_buf = malloc(BUF_SIZE);
 	if (!list || !buf || !ext_buf) {
 		fprintf(stderr, "Out of memory\n");
-		exit(1);
+		goto out_free;
 	}
 
 	for ( ; ; ) {
@@ -812,7 +821,8 @@ int main(int argc, char **argv)
 
 		if (buf_len < 0)
 			break;
-		add_list(buf, buf_len, ext_buf);
+		if (!add_list(buf, buf_len, ext_buf))
+			goto out_free;
 	}
 
 	printf("loaded %d\n", list_size);
@@ -862,11 +872,26 @@ int main(int argc, char **argv)
 			fprintf(fout, "\n");
 		}
 	}
-	regfree(&order_pattern);
-	regfree(&pid_pattern);
-	regfree(&tgid_pattern);
-	regfree(&comm_pattern);
-	regfree(&ts_nsec_pattern);
+
+out_free:
+	if (ext_buf)
+		free(ext_buf);
+	if (buf)
+		free(buf);
+	if (list)
+		free(list);
+out_free_ts:
 	regfree(&free_ts_nsec_pattern);
+out_ts:
+	regfree(&ts_nsec_pattern);
+out_comm:
+	regfree(&comm_pattern);
+out_tgid:
+	regfree(&tgid_pattern);
+out_pid:
+	regfree(&pid_pattern);
+out_order:
+	regfree(&order_pattern);
+
 	return 0;
 }
-- 
2.25.1

