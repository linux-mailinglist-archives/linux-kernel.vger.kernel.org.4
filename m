Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37C2698BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBPFUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBPFTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422645F60
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n20-20020a25da14000000b008fa1d22bd55so840462ybf.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTmH+3zLa4DS1pm6XKzoFa9XiN/n/492GQmNm0F2u98=;
        b=lxQtFymGNoCMn73Q032qmSTTcj+ve7GubiXjG/S2/wZlI5A+wvms4mpLfeb6oKn81f
         gVVSU10rEKBXvaTQ4DI3+isYBuVvKtNDNUM4jT8VbxX9prWBulP37D7mcvfTTB0yv5Vd
         xLNBfAphNgvAxOXoC4bxmXgktQA4hGiUCCaPhABiIUzurEkqvA5yibf0xhi6vP6KsH63
         2fMMNvtfnEstPxLz+UPzwP+9hfF+/M/equZBkR4oGxxGpJkcmKAi9IzofVMskpdF8tY7
         tvoaCpVKwaaM8HBNFnnIuJry7ZsbTgV8SMkds4HojfN0Cbg+ccWTepT6dYOQ/gKplcjn
         qubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTmH+3zLa4DS1pm6XKzoFa9XiN/n/492GQmNm0F2u98=;
        b=dWwGXiD833Vh5DcAbp2IOBMXewpJtdezcUeVBwztsoS5bGpNgW8LQSFGxjRlHkclcS
         ft1uBp84hnEh+mI3muVkuhDeCE4x3idmD9e5wqEl8Apf+W5ZkgcrZ5/Q/COwsWj8VDMI
         a8yiC3tK8gbuFKQhiKJm9JlJUEv3KZERVAqb93L5bMpnmgAc7tgsqzpRxSS/HNpQaqKB
         7P289jaSAZJEUn4bjH7UgU3sI8wYEeYOwvclh1TGiLsbaKNJJAhIpNpIcz+7684GGTSV
         qIk2KQLff3gNiHP/f3Sv1g7pZ4hSujmlZqoln9gqHBYx6S3jjrOhYe8CjmVkhB5Ys4i5
         N0sw==
X-Gm-Message-State: AO0yUKXMg/yloDfeGiMUlWXpn2eGKs5NdCujJ+4SELHMABO3sSyU22bZ
        awTvAqi4892mlH8EelqlV/IO7kglQcc=
X-Google-Smtp-Source: AK7set/Pm4WgUpt5iRaimc/pvYKHTFOy9juHCFu4sSQHLZZAabCINcoiFbttYYVnL3GbT+1smZzLxo4F4W0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:441c:0:b0:52e:c79a:cda with SMTP id
 r28-20020a81441c000000b0052ec79a0cdamr12ywa.10.1676524730090; Wed, 15 Feb
 2023 21:18:50 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:38 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-24-surenb@google.com>
Subject: [PATCH v3 23/35] mm/mmap: prevent pagefault handler from racing with
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
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
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
index 00f8c5798936..801608726be8 100644
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

