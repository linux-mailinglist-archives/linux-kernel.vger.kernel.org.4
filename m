Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0445EB40B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiIZWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIZWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D28E172C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x15-20020a17090a294f00b00205d6bb3815so197465pjf.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VO9kIGBomtZbV0n2IUM5HAAlzgHy/MoeouO8NuU3pAo=;
        b=af8cjselPcStmvVCg3qezRR3fcj7wTDAlkgJDJbhbjS8Z8mk2Ao94i0ddHnRnskC+B
         xB5JVyLS/BmL1dQpV3IVsajZ0x2/jQi1l+fhJH6u2diGXhGk/YNo5d7z9MYJa462LHqh
         llkbVCduAxFjdJY+pryKoGYmBxtancZV11/4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VO9kIGBomtZbV0n2IUM5HAAlzgHy/MoeouO8NuU3pAo=;
        b=WidGBuztVkh9g/Wnn6aIV/aZpDiPZdzQBwBPXKw3BFgoUcWDIFhcMTHGQ4gVFtBdju
         tJiOZAPJ1fdvwtK+FgXcaMflnCcEuC8j42Xi42sJM86RqlyVMoELDhOiqRfYHJM5F2H/
         Z8vv6nKW3xyRT5Tq9Au3OJr4cZpQQJxnGWxPT3rfDpRoqEHXCHmhMhD9WkUf6oEEAkRB
         BWETiApP17kiOQqolXDtdb11KsswDUHOAd53y4yet0pfJUQSYb1XVOYRxBHz/O7cin80
         VBz0y4+3ed4l4Sc+B8C2B2FI6Jxg32TlvQHfIPPwEuNz6at8cizbCsXZ+M57Vz/x5DTP
         hSvg==
X-Gm-Message-State: ACrzQf1gXgVYGGe20qe8c4CKG37jW5gVNkUtb+MgpiEC+X9XJhZTvoFL
        l3UPlpr5cM+0pIBaxQvZx38pW1bokLE5vQ==
X-Google-Smtp-Source: AMsMyM5jeRhiNhxziE/RNOl6eSYiZsMpBKRgKYZrdndpy22w+OXeNUR0qi9rdOz/7QuMjiP0NP3nNg==
X-Received: by 2002:a17:902:680d:b0:176:9f46:bebb with SMTP id h13-20020a170902680d00b001769f46bebbmr23731973plk.122.1664229700208;
        Mon, 26 Sep 2022 15:01:40 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:386c:e0ff:829b:40eb])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b00178b77b7e71sm11671303plb.188.2022.09.26.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:39 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] block: allow specifying default iosched in config
Date:   Mon, 26 Sep 2022 15:01:34 -0700
Message-Id: <20220926220134.2633692-1-khazhy@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting IO scheduler at device init time in kernel is useful, and moving
this option into kernel config makes it possible to build different
kernels with different default schedulers from the same tree.

Order deadline->none->rest to retain current behavior of using "none" by
default if mq-deadline is not enabled.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
checkpatch suggested more verbose help descriptions, but I felt it'd be
too much repeated from the main config options, so opted to leave them
out.

 block/Kconfig.iosched | 28 ++++++++++++++++++++++++++++
 block/elevator.c      |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 615516146086..38a83282802a 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -43,4 +43,32 @@ config BFQ_CGROUP_DEBUG
 	Enable some debugging help. Currently it exports additional stat
 	files in a cgroup which can be useful for debugging.
 
+choice
+	prompt "Default I/O scheduler"
+	default DEFAULT_MQ_DEADLINE
+	help
+	  Select the I/O scheduler which will be used by default for block devices
+	  with a single hardware queue.
+
+config DEFAULT_MQ_DEADLINE
+	bool "MQ Deadline" if MQ_IOSCHED_DEADLINE=y
+
+config DEFAULT_NONE
+	bool "none"
+
+config DEFAULT_MQ_KYBER
+	bool "Kyber" if MQ_IOSCHED_KYBER=y
+
+config DEFAULT_BFQ
+	bool "BFQ" if IOSCHED_BFQ=y
+
+endchoice
+
+config MQ_DEFAULT_IOSCHED
+	string
+	default "mq-deadline" if DEFAULT_MQ_DEADLINE
+	default "none" if DEFAULT_NONE
+	default "kyber" if DEFAULT_MQ_KYBER
+	default "bfq" if DEFAULT_BFQ
+
 endmenu
diff --git a/block/elevator.c b/block/elevator.c
index c319765892bb..4137933dfd16 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -642,7 +642,7 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 	    !blk_mq_is_shared_tags(q->tag_set->flags))
 		return NULL;
 
-	return elevator_get(q, "mq-deadline", false);
+	return elevator_get(q, CONFIG_MQ_DEFAULT_IOSCHED, false);
 }
 
 /*
-- 
2.37.3.998.g577e59143f-goog

