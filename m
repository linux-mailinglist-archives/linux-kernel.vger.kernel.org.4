Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9741E67EEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjA0To5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjA0Tng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:36 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DECC2DE4B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c8e781bc0aso66308987b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMW5WtXlwQRVw5jLv0uMPkgP2YoyRT4XQf8L1G2g0sM=;
        b=mdQhCODmER/WcuXnOwjGOPGsluXP611R3K8yAAqGfZO+eojPR0iLkDWsNYoGq20Pxc
         pLGndC0gNc0k/+qBk7J/uFwYPbCjsW7XmlHDcZCSFndQyDIXmYjY6yxKamOAoeP6UD5R
         10GuF5qfONyUFHlhJRc27yht8CtL7+xZMg96kBN6doFn/8DSebIrGsIvYM1XfrVRdrIT
         Vzd4VicNtC2Hx0ebeUSEC751adwD7ZH4dP9Tg/rHSx32WXBUDV2TcmMYgTc4y3CEq8j+
         2IuM945ICEGJ6/3bquYB/9nBx6UvS9o2Tl6iob7NJEFRIs2YxCbcwKtUsh6O7/MdtiEH
         lFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMW5WtXlwQRVw5jLv0uMPkgP2YoyRT4XQf8L1G2g0sM=;
        b=YIac+PxJGZptkH5hsFdPViXAs5WSWvfp2/AQyEb+fMGNv9+3L3/+6EgX+YxG1xIF/H
         0zm5S457OYuR9+PXprRr0Gf75fVyCu/0QQRdXkWI0StOn7TEB8Qou/ncjlyt8JTwVERB
         uDfE7Xzv2HpeCfUyxQ90K5UDTGZpLXEueCNtrpgr8kcwnBFOdcdmunv9smmna4EbfaqL
         1zPpCGX6pGnJzRSYkFbIbHIHqFtSobDA9dxhZM4byM1nGOAJlMXxymLKEnGFf+U+5zi0
         MGidSYdSrIhMRE/WIHKrnc/Us1tgO+iGGI0Id7h96AHkTnFrrDliOUHVNW5JufhiI8PI
         N8Fw==
X-Gm-Message-State: AFqh2kpOoiFZo+llAgVkjhK3CHgBN1G5zbNvyIFbn37Xyog9Z4akpYvn
        St41weWyf/OgjepfEUBWZUNw9W+CmH0=
X-Google-Smtp-Source: AMrXdXvm/6CR5hD1SSLODW5O6UqAFkTGTyEvJF4A+5Su+1PwVS4k4WIa/asYlNCGXFd3Q9zHSTloGdPuiKg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a25:1fd4:0:b0:7d4:712e:2852 with SMTP id
 f203-20020a251fd4000000b007d4712e2852mr4289060ybf.628.1674848526673; Fri, 27
 Jan 2023 11:42:06 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:59 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-23-surenb@google.com>
Subject: [PATCH v2 22/33] mm/mmap: prevent pagefault handler from racing with
 mmu_notifier registration
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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

Page fault handlers might need to fire MMU notifications while a new
notifier is being registered. Modify mm_take_all_locks to write-lock all
VMAs and prevent this race with page fault handlers that would hold VMA
locks. VMAs are locked before i_mmap_rwsem and anon_vma to keep the same
locking order as in page fault handlers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3baf218836bb..3d0cfbc92745 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3501,6 +3501,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
  * of mm/rmap.c:
  *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
  *     hugetlb mapping);
+ *   - all vmas marked locked
  *   - all i_mmap_rwsem locks;
  *   - all anon_vma->rwseml
  *
@@ -3523,6 +3524,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 
 	mutex_lock(&mm_all_locks_mutex);
 
+	mas_for_each(&mas, vma, ULONG_MAX) {
+		if (signal_pending(current))
+			goto out_unlock;
+		vma_start_write(vma);
+	}
+
+	mas_set(&mas, 0);
 	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
@@ -3612,6 +3620,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
 		if (vma->vm_file && vma->vm_file->f_mapping)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
+	vma_end_write_all(mm);
 
 	mutex_unlock(&mm_all_locks_mutex);
 }
-- 
2.39.1

