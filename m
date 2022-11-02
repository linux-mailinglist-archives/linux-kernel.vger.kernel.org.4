Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F036162DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKBMk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiKBMkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:40:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25EE2A247;
        Wed,  2 Nov 2022 05:40:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r18so16101667pgr.12;
        Wed, 02 Nov 2022 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe5a5Ru1/XT66dpFkqWwNZmEbEp5/a1fNwas3qwNPCU=;
        b=fvAtYKUe/Ychvwzd3I6de24IsN9RvsNMpvWnbYipWTg9V/fFoanLqa14uuE+ntvDWK
         h8mU0mz+E4mGizz4oj/RxVnY2IbPW6+/YCesr865G//rNRjEdiMaa8+U23s3W6TG7RgL
         e17kyY0mdJ2CwVGAmxuqHp4AGc+Br+VwqwQLQnad4QqHzcvDbvjvCVG31SV++RcVkDuW
         aZP6F9oShASUvqHGDGj8TVH0tqbIIyhmGrRozBtvBnR4NsiGWdXzWnPCEO5KIisMI97n
         BRw3mfUf/zrLRnjW6/nK7HrOn1yw4qLtZrjqwh40+R+0KMEapx5P0Y5HwHrPw2cbSipH
         XPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe5a5Ru1/XT66dpFkqWwNZmEbEp5/a1fNwas3qwNPCU=;
        b=cvu8wp5Z8kvKo9IFFdtVnxmqmck+1kjyRmjJbxtV0vthww7eGzeJbiBLSOl83KF9MI
         xYrg+6Zdl/XpRxD9lE5Lb5I+mTiZ2qTtd7ZH6w8xxKfmfGk+tKddzBTfSxa/mF5QseV0
         tyYMkRbBE1sd8Kn9il2C/urmPuoXo2fPj4bqR8QBZ8FzGmyeBe1KfixZ5kAhsG8k5zce
         cljs+4l09K44C/7fP8O/dXaUgq/9VQM4DXKCS6yjuqEORfrws1QOQFJHfEhLKQ0ruG1p
         pdV/+7eNknzlywlhyl8qfHdc7TaB6+425HxLWcLYaUaC7EnEs5bn16zhuCMuSWeBNdS3
         ukrg==
X-Gm-Message-State: ACrzQf0EhLfM+wZPaOsDsftk4rShRqVNB3rrwm1FX8WIb5lI7Ck4hlBA
        cMf9q7u7nKri7ff7ZeJV3fQ=
X-Google-Smtp-Source: AMsMyM5MCQt8YBiAHYQm8dtgMBBm25GSFqCMceamsEH0a5pp0vWc93EyVnrzHmyWsvpdMYABjKxCYg==
X-Received: by 2002:a63:24d:0:b0:452:87c1:9781 with SMTP id 74-20020a63024d000000b0045287c19781mr21723627pgc.512.1667392826161;
        Wed, 02 Nov 2022 05:40:26 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm8339360pfk.196.2022.11.02.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:40:25 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [PATCH 5/5] block, bfq: print bfqq addr for each bfq_log_bfqq log
Date:   Wed,  2 Nov 2022 20:39:56 +0800
Message-Id: <20221102123956.230-6-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
References: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
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

Print bfqq addr for each bfq_log_bfqq log, which can improve readability
of bfq log.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c | 15 +++++++--------
 block/bfq-iosched.h |  4 +++-
 block/bfq-wf2q.c    |  3 +--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9c626fba41c8..432c5337d7c2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5253,7 +5253,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 	struct hlist_node *n;
 	struct bfq_group *bfqg = bfqq_group(bfqq);
 
-	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref);
+	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: ref %d", bfqq->ref);
 
 	bfqq->ref--;
 	if (bfqq->ref)
@@ -5356,7 +5356,7 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		bfq_schedule_dispatch(bfqd);
 	}
 
-	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, bfqq->ref);
+	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: ref %d", bfqq->ref);
 
 	bfq_put_cooperator(bfqq);
 
@@ -5772,8 +5772,8 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 			      * guarantee that this queue is not freed
 			      * until its group goes away.
 			      */
-		bfq_log_bfqq(bfqd, bfqq, "get_queue, bfqq not in async: %p, %d",
-			     bfqq, bfqq->ref);
+		bfq_log_bfqq(bfqd, bfqq, "get_queue, bfqq not in async: ref %d",
+			     bfqq->ref);
 		*async_bfqq = bfqq;
 	}
 
@@ -6803,8 +6803,8 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	bfqq_request_allocated(bfqq);
 	bfqq->ref++;
 	bic->requests++;
-	bfq_log_bfqq(bfqd, bfqq, "get_request %p: bfqq %p, %d",
-		     rq, bfqq, bfqq->ref);
+	bfq_log_bfqq(bfqd, bfqq, "get_request %p: bfqq ref %d",
+		     rq, bfqq->ref);
 
 	rq->elv.priv[0] = bic;
 	rq->elv.priv[1] = bfqq;
@@ -6936,8 +6936,7 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
 	if (bfqq) {
 		bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
 
-		bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",
-			     bfqq, bfqq->ref);
+		bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: ref %d", bfqq->ref);
 		bfq_put_queue(bfqq);
 		*bfqq_ptr = NULL;
 	}
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 71f721670ab6..8851ffcb7a0d 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -24,7 +24,7 @@
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-#define MAX_BFQQ_NAME_LENGTH 16
+#define MAX_BFQQ_NAME_LENGTH 32
 
 /*
  * Soft real-time applications are extremely more latency sensitive
@@ -1090,6 +1090,8 @@ static inline void bfq_bfqq_name(struct bfq_queue *bfqq, char *str, int len)
 		snprintf(str, len, "bfq%d%c", bfqq->pid, type);
 	else
 		snprintf(str, len, "bfqSHARED-%c", type);
+
+	snprintf(str, len, "%s %p", str, bfqq);
 }
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index f57ed0b037f3..7ab4094af35a 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -513,8 +513,7 @@ static void bfq_get_entity(struct bfq_entity *entity)
 
 	if (bfqq) {
 		bfqq->ref++;
-		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
-			     bfqq, bfqq->ref);
+		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: ref %d", bfqq->ref);
 	}
 }
 
-- 
2.34.1

