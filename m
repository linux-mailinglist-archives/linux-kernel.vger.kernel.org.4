Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B5966B665
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjAPDqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjAPDqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:46:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96453CC0C
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:44:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p18-20020a25bd52000000b007c8919c86efso12131079ybm.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRXb5Tx9eB0QD8MPQ3bDTUMYKB42PbWbukVcWDbrGBE=;
        b=DbXiQgb16cXc0c+1Ms81Hey0/LYqSzODb9phkheLoa2O8f3Ig92mTiQHSCrotArslU
         FEhihvxAu74eZD4ZQe4lTANr5P5IpZ55hmjNXVmwzm9h7sRX2FMGYLVTwiaWm1ZkUjKH
         pFtLaSOiV+aW76Yi83BTtq0/BrDt/QaUwk97NMS5Sq4Cb3L2/vr4KLaNpNLQ8XBHU+a6
         hahZrekdCCHtViDqFgpx0LlxuyMZ/IYBQSlN37323erCpSDPaVessn4Ls1Em2E92Sw44
         oXeBPF4ZzWX50UHybSL9f4sTMOwB3Nl2zVKANoYCGcvJkLRVQx3peuXbl7WTm23Qno3H
         V55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRXb5Tx9eB0QD8MPQ3bDTUMYKB42PbWbukVcWDbrGBE=;
        b=3GpK8izaNc/c/arWqSFCzL3fLWwh4uodd2RbvSPrOw+g9BSKK7HeSVULv33ED0pO4a
         iGGNLvU6332IdhBMg7kmruRzkankgfY+rD7TXoDgt+myxPM6u7IX+aoLcsfBkzp09JU4
         Zg3tqKkwQg3G3p4JjyNMvvCnpZUl8XG6qZYi0xFng6miO7A/Q9bgpXEkEoko1U9HgcjV
         IodA0E7PES5xxjrZuKlHwbT4BPTpcQ+YmRg/XshA/hd++5pBcUNhW2EBWJwKVMzdDF5c
         FkABIJ4WzrZNIYKxPhlnm4piT4HvCJedzmpR3NATNaxVi+ynKC5qlDSac/paZ0Y05hXs
         pakg==
X-Gm-Message-State: AFqh2koAq/820Z04mgEp8TTrDlg0Ejg+PH8TVaiVqSVI0Szq4Ve5Dmq3
        VHwVao+cCP2xbUUGb7g4YcraZTGKAvw=
X-Google-Smtp-Source: AMrXdXvLWad4bD9NfwO8dLR/2EI357BTUrAnmpF0KOigylM+0w18WGKH/mk2AkTunNN50QaDroPabDG7MY8=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:9283:334a:bf40:242b])
 (user=yuzhao job=sendgmr) by 2002:a25:f903:0:b0:7b9:daf2:4117 with SMTP id
 q3-20020a25f903000000b007b9daf24117mr4108825ybe.408.1673840647568; Sun, 15
 Jan 2023 19:44:07 -0800 (PST)
Date:   Sun, 15 Jan 2023 20:44:05 -0700
Message-Id: <20230116034405.2960276-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v1] mm: multi-gen LRU: fix crash during cgroup migration
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, Yu Zhao <yuzhao@google.com>,
        msizanoen <msizanoen@qtmlabs.xyz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lru_gen_migrate_mm() assumes lru_gen_add_mm() runs prior to itself.
This isn't true for the following scenario:

    CPU 1                         CPU 2

  clone()
    cgroup_can_fork()
                                cgroup_procs_write()
    cgroup_post_fork()
                                  task_lock()
                                  lru_gen_migrate_mm()
                                  task_unlock()
    task_lock()
    lru_gen_add_mm()
    task_unlock()

And when the above happens, kernel crashes because of linked list
corruption (mm_struct->lru_gen.list).

Link: https://lore.kernel.org/r/20230115134651.30028-1-msizanoen@qtmlabs.xyz/
Reported-by: msizanoen <msizanoen@qtmlabs.xyz>
Tested-by: msizanoen <msizanoen@qtmlabs.xyz>
Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cdf96aec39dc..394ff4962cbc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3335,13 +3335,16 @@ void lru_gen_migrate_mm(struct mm_struct *mm)
 	if (mem_cgroup_disabled())
 		return;
 
+	/* migration can happen before addition */
+	if (!mm->lru_gen.memcg)
+		return;
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(task);
 	rcu_read_unlock();
 	if (memcg == mm->lru_gen.memcg)
 		return;
 
-	VM_WARN_ON_ONCE(!mm->lru_gen.memcg);
 	VM_WARN_ON_ONCE(list_empty(&mm->lru_gen.list));
 
 	lru_gen_del_mm(mm);
-- 
2.39.0.314.g84b9a713c41-goog

