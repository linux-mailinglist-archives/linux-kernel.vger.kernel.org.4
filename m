Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA46B50F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCJTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCJTdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:33:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A125B5F7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:33:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j125-20020a25d283000000b008f257b16d71so6728557ybg.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678476814;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=80aTzTXNxqQ00vS1sVT9ibDfp321VL5ZJhrr00uLlW0=;
        b=N6xBegLEZPOSg1C2qdTuIfVEO+wPD/Ap1kvkcsB90ItjDOV2G0dZ8lQhUFZcDeywCS
         J2s9GTek7pwX09o+qEw05YoiIbeM+qmn20dKMG/Jqqw0na3Huf6TKz2wnK/2jsDWwDPb
         DAkbgr+6iagXAZO21tXmno+3ZSxjJirx0xllzeHUg18soicJclL3MOwK6Zu7d2Bdzyxq
         krFUWawBzVSUYQxw9ONLssQirnNEVM+0VIhqHqqYy14zWkOZrjozm4ZZ+yZ4nU/014LM
         T2yEugy0x281ZY7hQ/+X9F7yEleIOt3327GfFntguqGYNM2m47uGwzBSYXEzU58Wn3CD
         +42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678476814;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80aTzTXNxqQ00vS1sVT9ibDfp321VL5ZJhrr00uLlW0=;
        b=iwCZoQEzHiRa4up0baufmSxokh1lQhyERxVgteZ8DFiS0kvlej0fQ4jzUbBhZ7J1GI
         d61NTEvVwWV4j+k5HLUvUTn+notPCNqclFp39HQbMPxoYqQavQQPZ8iOAqarzaJJaqL0
         uuA5cw1vmC/t4EetO3635ZClZO/cgeK88nDbt+HivG6OB/NUAcAKw51AlPvu1xzRa8mP
         sIQfKfawtPMGG+P36lIia+lt/bxum3dsDolrTiab4MMsTQWREX4Tjz/mZU3cpPNe8DxT
         Gc0PRUqrfAViB387r9zwUgD8LqscHwa1Keh6KBuugYWHgMzZdoVfxciAVu4Ps+iQTmXn
         KvrQ==
X-Gm-Message-State: AO0yUKU4Oj8bu6/W5CW3G9+MOUGfb10nEo/o++ejkLS7vsxcFpjXeWus
        aHCb58Ic6FjxmNqalae7DRvvc+Jkyw==
X-Google-Smtp-Source: AK7set9v2grUZTAnu6fTO6bylxZxYVU0C+usTdIONobZWRo8uikE+RQewK643w4HbtOrKdC4m8CFOG9FGQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a81:4422:0:b0:534:eef8:caa9 with SMTP id
 r34-20020a814422000000b00534eef8caa9mr16520387ywa.8.1678476814674; Fri, 10
 Mar 2023 11:33:34 -0800 (PST)
Date:   Fri, 10 Mar 2023 11:33:25 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310193325.620493-1-nhuck@google.com>
Subject: [PATCH v2] fsverity: Remove WQ_UNBOUND from fsverity read workqueue
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, fsverity@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WQ_UNBOUND causes significant scheduler latency on ARM64/Android.  This
is problematic for latency sensitive workloads, like I/O
post-processing.

Removing WQ_UNBOUND gives a 96% reduction in fsverity workqueue related
scheduler latency and improves app cold startup times by ~30ms.
WQ_UNBOUND was also removed from the dm-verity workqueue for the same
reason [1].

This code was tested by running Android app startup benchmarks and
measuring how long the fsverity workqueue spent in the runnable state.

Before
Total workqueue scheduler latency: 553800us
After
Total workqueue scheduler latency: 18962us

[1]: https://lore.kernel.org/all/20230202012348.885402-1-nhuck@google.com/

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
Changelog:
v1 -> v2:
- Added comment about WQ_UNBOUND
- Added info about related dm-verity patches in commit message

 fs/verity/verify.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index f50e3b5b52c9..782b8b4a24c1 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -387,15 +387,15 @@ EXPORT_SYMBOL_GPL(fsverity_enqueue_verify_work);
 int __init fsverity_init_workqueue(void)
 {
 	/*
-	 * Use an unbound workqueue to allow bios to be verified in parallel
-	 * even when they happen to complete on the same CPU.  This sacrifices
-	 * locality, but it's worthwhile since hashing is CPU-intensive.
-	 *
 	 * Also use a high-priority workqueue to prioritize verification work,
 	 * which blocks reads from completing, over regular application tasks.
+	 *
+	 * This workqueue is not marked as unbound for performance reasons.
+	 * Using an unbound workqueue for crypto operations causes excessive
+	 * scheduler latency on ARM64.
 	 */
 	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
-						  WQ_UNBOUND | WQ_HIGHPRI,
+						  WQ_HIGHPRI,
 						  num_online_cpus());
 	if (!fsverity_read_workqueue)
 		return -ENOMEM;
-- 
2.40.0.rc1.284.g88254d51c5-goog

