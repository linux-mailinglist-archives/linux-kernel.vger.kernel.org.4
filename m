Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4C6F46C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjEBPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjEBPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:06:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5430F1;
        Tue,  2 May 2023 08:06:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso2858288b3a.2;
        Tue, 02 May 2023 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683039977; x=1685631977;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfBsAGpRXFX3Iqed0oeLIM1q8SnmBVNgKImTrWph7ys=;
        b=L+LxLoS7h/tl6nAWBs0gTbJ1H4N0ce4HbF3BC1NXmG8821bTevRIf2S5vMWct1CrAH
         D7wJnuy9OeFP80iArWd4fQsmQwxC6kJX53RzRgWUNRFn+R/kElQ3Nwxf3B+Y8Uz6F+r9
         3Tu0LRZlY7vaXyA6+BGFgOiaaZxgz6fsc2s1up3U8xSUIQSmr1YBQhLHGzvLAtTPOLnb
         HK/hI3oKA1TaZ7MfPfjmDS7KgZzTjAr04RL7c+sfOk7DeJau13z91lWyFNfAEUNHNRvN
         ntZnRgqFPchzp81KoLSlde9XkPd94bkF/JWHbc2KTPyUBFIxsmn5SSVxg3XVLOnFclxD
         9ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683039977; x=1685631977;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfBsAGpRXFX3Iqed0oeLIM1q8SnmBVNgKImTrWph7ys=;
        b=l3GuZ758ueVg0oMMdXw9cfc6xqLxP1vuJUet53Z7N0S7sYNH+wPv/+ZF1GXIA5OTHF
         BkSqCJayoqy/WTq+Ezk9WeA2ddvdpaGCP9atxtzqyXvCTWxhaqplqmR/kmjr8f/i5o22
         KnIet80pJPEaCQx2Ap6gDgLtn5TPOU6j1Ljpy2f5UKtVjk4Iutx2CP3B5GqsWX5oq4fY
         TpgAbCNaTS6z20kzAEEzQ8opcfOprJk5iIIAZnc+Y53ohHxhjJrKnTTgsTi96WPOjqEM
         0hAuof45gtoCNzRgWjw4gJYaltoDYVOaU848xP4IhFQRs30g5f4C82FC4u2gxAXSovgm
         pOxg==
X-Gm-Message-State: AC+VfDwNZZ42c1x8VHw1S9ZOj3qRCPM7KHT46W90L+Xf0HVhUaafQpeZ
        gMOGklEsCPd11OtBtKKHT2Q=
X-Google-Smtp-Source: ACHHUZ7islxlN/yKDPiKhGdceK+u8FJFTxYQ9Vxxh0/Z6Z830DQzWdjVccEHSpP8IBYIBpiaHqTOlg==
X-Received: by 2002:a05:6a21:3a91:b0:f0:6517:2fd with SMTP id zv17-20020a056a213a9100b000f0651702fdmr18369559pzb.2.1683039976916;
        Tue, 02 May 2023 08:06:16 -0700 (PDT)
Received: from localhost.localdomain ([154.220.3.115])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b0063799398eb9sm21983103pfe.58.2023.05.02.08.06.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2023 08:06:16 -0700 (PDT)
From:   zhouzhouyi@gmail.com
To:     paulmck@kernel.org, rcu@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lance@osuosl.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH RFC] rcu: torture: shorten the time between forward-progress tests
Date:   Tue,  2 May 2023 23:06:02 +0800
Message-Id: <1683039962-15751-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

Currently, default time between rcu torture forward-progress tests is 60HZ,
Under this configuration, false positive caused by __stack_chk_fail [1] is
difficult to reproduce (needs average 5*420 seconds for SRCU-P),
which means one has to invoke [2] 5 times in average to make [1] appear.

With time between rcu torture forward-progress tests be 1 HZ, above
phenomenon will be reproduced within 3 minutes, which means we can
reproduce [1] everytime we invoke [2].

Although [1] is a false positive, this change will make possible future
true bugs easier to be discovered.            
                   
[1] Link: https://lore.kernel.org/lkml/CAABZP2yS5=ZUwEZQ7iHkV0wDm_HgO8K-TeAhyJrZhavzKDa44Q@mail.gmail.com/T/
[2] tools/testing/selftests/rcutorture/bin/torture.sh

Tested in PPC VM of Opensource Lab of Oregon State Univerisity.
        
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>        
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot  | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot  | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot  | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
index ce0694fd9b92..982582bff041 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot
@@ -1,2 +1,3 @@
 rcutorture.torture_type=srcu
 rcutorture.fwd_progress=3
+rcutorture.fwd_progress_holdoff=1
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
index 2db39f298d18..18f5d7361d8a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
@@ -1,4 +1,5 @@
 rcutorture.torture_type=srcud
 rcupdate.rcu_self_test=1
 rcutorture.fwd_progress=3
+rcutorture.fwd_progress_holdoff=1
 srcutree.big_cpu_lim=5
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
index c70b5db6c2ae..b86bc7df7603 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
@@ -1,2 +1,3 @@
 rcutorture.torture_type=tasks-tracing
 rcutorture.fwd_progress=2
+rcutorture.fwd_progress_holdoff=1
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
index dd914fa8f690..933302f885df 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
@@ -1 +1,2 @@
 rcutorture.fwd_progress=2
+rcutorture.fwd_progress_holdoff=1
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
index dd914fa8f690..933302f885df 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
@@ -1 +1,2 @@
 rcutorture.fwd_progress=2
+rcutorture.fwd_progress_holdoff=1
-- 
2.34.1

