Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94477602942
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJRKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJRKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7845DB03E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666088604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lGc1brklA5v9OUHTBe6S3k3fA4Qi2pTlNeYEp6W+HVI=;
        b=B4bEGTuLgH1kfKIBewdUEmn4vLFnF0uh64PerpxP32PSbedbiikarO7gDJTHfhhLKkozu4
        mYWUT1bchSpil66H8PcHnR4RKUrse6iCmbiiBBIhP0v7gh5/dofP771eWVCdCBJuNlKH50
        C5QVYVGBFsDRpwF3gvqFe9nZ+cjYbZU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-0eyRkvcuN-et8k6neXvCwQ-1; Tue, 18 Oct 2022 06:23:23 -0400
X-MC-Unique: 0eyRkvcuN-et8k6neXvCwQ-1
Received: by mail-pg1-f199.google.com with SMTP id 83-20020a630156000000b0046b208f6ae3so6717756pgb.16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGc1brklA5v9OUHTBe6S3k3fA4Qi2pTlNeYEp6W+HVI=;
        b=WYiD02NiYQ3BXZ1s5pRXrnmbkkcSX2w0KWXnUPeHhirl/DUmXav13E8wwooxce+Moo
         VispXZ9kEV+RlaP79WPAxv5NKPuaJpKQ38fZPCs+TRAyCNPF93HGknIZX2+3geW10yvW
         bI8jUKaTXHK6Zd009RfZkEnadgtC34dL77phcepov3xtHZ/p0c9amDvxcycO7qrQL/nq
         gkddj2mskWC8oDapj6lWQ191tIPxHc+asGO0lyfVJHnpV5NhYiCsM82oz34Rkvio0Qem
         8usELJrl3Cgkit8R4/lvOomssqljC5Gh4n3YWE2X+lsS3rGiDEmfXMyn93KKg8ZkahuB
         SYRw==
X-Gm-Message-State: ACrzQf1fLIg3SVgr+Bal3oqoxiKQpKCJPopsdWr40FhyruRZzVmqqiU+
        qX1V9qUhKcmaPIOWtmOn7TLeqotHwYGsXG7AOdrnHt2/5zu8H1Vv96/T7STSCwm0KpNmqnfQTrw
        /PqL/QrLkg/9Gh9m6jyt1YHyz
X-Received: by 2002:a17:90b:4a8a:b0:20d:8a4d:c2ae with SMTP id lp10-20020a17090b4a8a00b0020d8a4dc2aemr36943055pjb.179.1666088602212;
        Tue, 18 Oct 2022 03:23:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4yZEZ3zz/NaaPvomcA0q2fWZLeE26WLTAC0kzNafK9BiNR2Y6DRwutygGdqw7K1vCRk2VOgw==
X-Received: by 2002:a17:90b:4a8a:b0:20d:8a4d:c2ae with SMTP id lp10-20020a17090b4a8a00b0020d8a4dc2aemr36943033pjb.179.1666088601967;
        Tue, 18 Oct 2022 03:23:21 -0700 (PDT)
Received: from zeus.flets-east.jp ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090a4d4500b00205d85cfb30sm11173373pjh.20.2022.10.18.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:23:21 -0700 (PDT)
From:   Ryosuke Yasuoka <ryasuoka@redhat.com>
To:     elver@google.com, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     Ryosuke Yasuoka <ryasuoka@redhat.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] kcsan: Fix trivial typo in Kconfig help comments
Date:   Tue, 18 Oct 2022 19:22:54 +0900
Message-Id: <20221018102254.2424506-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivial typo in Kconfig help comments in KCSAN_SKIP_WATCH and
KCSAN_SKIP_WATCH_RANDOMIZE

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 lib/Kconfig.kcsan | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 47a693c45864..375575a5a0e3 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -125,7 +125,7 @@ config KCSAN_SKIP_WATCH
 	default 4000
 	help
 	  The number of per-CPU memory operations to skip, before another
-	  watchpoint is set up, i.e. one in KCSAN_WATCH_SKIP per-CPU
+	  watchpoint is set up, i.e. one in KCSAN_SKIP_WATCH per-CPU
 	  memory operations are used to set up a watchpoint. A smaller value
 	  results in more aggressive race detection, whereas a larger value
 	  improves system performance at the cost of missing some races.
@@ -135,8 +135,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	default y
 	help
 	  If instruction skip count should be randomized, where the maximum is
-	  KCSAN_WATCH_SKIP. If false, the chosen value is always
-	  KCSAN_WATCH_SKIP.
+	  KCSAN_SKIP_WATCH. If false, the chosen value is always
+	  KCSAN_SKIP_WATCH.
 
 config KCSAN_INTERRUPT_WATCHER
 	bool "Interruptible watchers" if !KCSAN_STRICT
-- 
2.37.3

