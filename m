Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F95B55BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiILIL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiILILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:11:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3022495C;
        Mon, 12 Sep 2022 01:11:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u22so7822682plq.12;
        Mon, 12 Sep 2022 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=X1ZYJ4LtGOATY9lmBRxo1aMAOVbGxGFQuO3VUUnbYvs=;
        b=MXaU2ahqcKrEpxmSosz7/Ef6K9Goz4pQ9XgtYbNdAw0TJ81egNrqOz6NfyUR/Fyv4v
         ezov4RPhF3A84GCjl++Wod8/tIFd71RpFjNTc/g1jJvtGJXE11sus1RhAsrcrj8Tfzx6
         SzxPc1D0qCU8GopbV/jDsqrAA1d7VstVBk47OjPqg/0SjbrjVSI45PjA2O/p1aKsGF3o
         lbrtW/AZyo5fOPuQAlMBQDLvnJwqrTyPdJcK1OyWy7pEnnbU6LnimhNoreclgvce8FqE
         QpoWS2nrLeec6mZwQPeSUvnz/tSmVxGmZmk/CBoyiEdRg7wrDKkXdMSsth3HbSbFyPUQ
         4kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=X1ZYJ4LtGOATY9lmBRxo1aMAOVbGxGFQuO3VUUnbYvs=;
        b=dFoWmQpZfadr5MjQWxczH9OqcxbC993c8QEtOuF+ufBen6rCmbZC5EX/jE1pgCoB3u
         ex3/FcSJFnlnIFnD9rJ1Yz0l2skDk8x09eAZ9zBusBiEtmSgCknrJr34+bPfKbdhs1Xf
         fCoCM7pb/2erEUJyD/E7552V/zKyrOTZLmfqN7yyAUJuWd9e56QySw1aZYcbGYv3xtKM
         i27S+WwhPO1MM3cHA5Vc5ntWqkKg4Qv0UdSjoi9ZN7hAK7ywS0JLK3BSoBYGDtZFBYm9
         rAKDwUiUnfOVQd3nto0cvTqNQ+HN1VFSLZyC+oqCRzpOoQYibYOqMQaR+dfxyKA3txRF
         nVPQ==
X-Gm-Message-State: ACgBeo0nz9D0B76Vm3i6NOIyv9m0lUk6C/1OgfJPxECBB15PoFMSxubE
        1qTag6lvb/an3h+OBgzidJU=
X-Google-Smtp-Source: AA6agR6HkvMPd/NVnfksZ5EoQ4RRYpdcAKQ5z/lW5584ERENChvV9rgqwEemIHkN9+dWflnnnMu+xQ==
X-Received: by 2002:a17:90b:4a48:b0:202:9bcb:b89c with SMTP id lb8-20020a17090b4a4800b002029bcbb89cmr13582834pjb.161.1662970281114;
        Mon, 12 Sep 2022 01:11:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a6a4800b001fd7e56da4csm4526239pjm.39.2022.09.12.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:11:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     axboe@kernel.dk, bsingharora@gmail.com, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Subject: [PATCH RESEND] block: count submission time as thrashing delay for delayacct
Date:   Mon, 12 Sep 2022 08:10:54 +0000
Message-Id: <20220912081053.17691-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang (CGEL ZTE) <yang.yang29@zte.com.cn>

PSI tracks the time system waiting for refaulting pages(or called
thrashing) spent on submitting the IO[1]. Delayacct also tracks
thrashing, but we failed to update it accordingly.

And we then have the ability to detect re-entrance of thrashing
accounting for delayacct[2], so we complete the accounting now.
This will make the thrashing accounting more accurate specifically
when device is congested or the submitting cgroup IO-throttled.

[1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
[2] commit 317bdccd67b2 ("delayacct: support re-entrance detection of thrashing accounting")

Signed-off-by: Yang Yang (CGEL ZTE) <yang.yang29@zte.com.cn>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Ran Xiaokai (CGEL ZTE) <ran.xiaokai@zte.com.cn>
Cc: wangyong (CGEL ZTE) <wang.yong12@zte.com.cn>
---
 block/blk-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0d1104c5590..d722ead0557f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -41,6 +41,7 @@
 #include <linux/part_stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
+#include <linux/delayacct.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -831,16 +832,19 @@ void submit_bio(struct bio *bio)
 
 	/*
 	 * If we're reading data that is part of the userspace workingset, count
-	 * submission time as memory stall.  When the device is congested, or
-	 * the submitting cgroup IO-throttled, submission can be a significant
+	 * submission time as memory stall and delay.  When the device is congested,
+	 * or the submitting cgroup IO-throttled, submission can be a significant
 	 * part of overall IO time.
 	 */
 	if (unlikely(bio_op(bio) == REQ_OP_READ &&
 	    bio_flagged(bio, BIO_WORKINGSET))) {
 		unsigned long pflags;
+		bool in_thrashing;
 
+		delayacct_thrashing_start(&in_thrashing);
 		psi_memstall_enter(&pflags);
 		submit_bio_noacct(bio);
+		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
 		return;
 	}
-- 
2.25.1

