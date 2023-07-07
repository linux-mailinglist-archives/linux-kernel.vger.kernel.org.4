Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF174A9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGGEcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGGEcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:32:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571D1BCA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:32:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso17411957b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688704337; x=1691296337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOqq0WN+jYVzOAHPCJmC3T8ZmV+ri02/8UcPUSwENZU=;
        b=eODw2VAG4LYwUudSofmYsJnD5sDvgnvXm7FQ6WhI9uyNSxsp0njiK6thMN6LRU5jTF
         gYmW5dl0SjECbLtK8iZkOH2xEUNg27Y4ApUuh7waJQakQ9qHP1nx+nYn3YKoVQ98VxWz
         OY4YiR+GiMKjF2MsRbpXNOQvq0vJJsB3vwvYf8qNkr7WvRvnC7O9FwEtRfKLje9Z1BZP
         9cOyuGcTKL1Y+u5/k71eAVQKBKvf+ar9q4SEqw+qNvkFIduc73n4qBi271JwmDnSiSe9
         HnhcI0RwPWBtG3pS/6ZbVosWthJ25wdjphq0ZVDNfyhX/7kCWTDbFnICRKBZ285B6A6q
         2nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704337; x=1691296337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOqq0WN+jYVzOAHPCJmC3T8ZmV+ri02/8UcPUSwENZU=;
        b=CRbVG/Px1KF5NusTdaSDcvV6SwL8u+EbEtGAfvFrbubh331qv1SOwjcS2mZ8bUPqTZ
         9oL04G6Rz+CFRaBcpCy3dWgkcq7/gIngxtGdKkqsITUVbaXQ8VqlNw8518pfyxPXGFpe
         l/VpRgiS7OEV3eRJS1WNdrSBvbjdlcO3QRpAuMdMTGU1h6112OcBKiRxrwz1VUQYo6u/
         zoeQqNk1HwBsK3cFpDiBX9ADrNjm/C87WZOyGnC+EQGqyMYFl0PeuLNKuCHTmjybVxDY
         XppsQ/m/g+X7GKOuSmJjv/IUOroa0LsHuRn1OxD/auKFmJPCCmJvOxZT//Nhk8NTvJNI
         lj5g==
X-Gm-Message-State: ABy/qLYPwE07zp8VGodonJ5XNVMFCeMHphfJw2AwCUK70yCbpRztXcQh
        b89vQ7fLXBJPMXgj2+Rv8deZh7Lxu9I=
X-Google-Smtp-Source: APBJJlHJJzo6xKqRfCwu3K4BMa/DSUqUwTqtDXrv/pQ5MfhlCzg1HW7hTPTkOQo0rodXtQODdOcQ37BKfgc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:fd8f:e174:8bb4:814])
 (user=surenb job=sendgmr) by 2002:a81:af1b:0:b0:573:6b9c:6fa1 with SMTP id
 n27-20020a81af1b000000b005736b9c6fa1mr27409ywh.1.1688704337053; Thu, 06 Jul
 2023 21:32:17 -0700 (PDT)
Date:   Thu,  6 Jul 2023 21:32:11 -0700
In-Reply-To: <20230707043211.3682710-1-surenb@google.com>
Mime-Version: 1.0
References: <20230707043211.3682710-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230707043211.3682710-2-surenb@google.com>
Subject: [PATCH 2/2] mm: lock newly mapped VMA which can be modified after it
 becomes visible
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, ldufour@linux.ibm.com, hughd@google.com,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        rientjes@google.com, axelrasmussen@google.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap_region adds a newly created VMA into VMA tree and might modify it
afterwards before dropping the mmap_lock. This poses a problem for page
faults handled under per-VMA locks because they don't take the mmap_lock
and can stumble on this VMA while it's still being modified. Currently
this does not pose a problem since post-addition modifications are done
only for file-backed VMAs, which are not handled under per-VMA lock.
However, once support for handling file-backed page faults with per-VMA
locks is added, this will become a race.
Fix this by write-locking the VMA before inserting it into the VMA tree.
Other places where a new VMA is added into VMA tree do not modify it
after the insertion, so do not need the same locking.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index c66e4622a557..84c71431a527 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2812,6 +2812,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
 
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
-- 
2.41.0.255.g8b1d071c50-goog

