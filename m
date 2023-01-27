Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC867EEAC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjA0Tp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjA0ToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:02 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDB1E1FF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4b34cf67fb6so65252337b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PvsAEkfbXSvdKN+lTJ9M9+vqfLQVBlihpxSKUw/t/s=;
        b=kp92vFUO2N4rCYUenom2PgB/dU7qqaylHAcH6HVVMYT5QMpL/oqQ/DdOm4bVNlYLNw
         9rNSkse+dfgOJKwj09yKdpzV2qc7upA8mjHmEpxt3RKsaa3pDRks1QGh3Nb2hG4bp/jU
         3eSArvNsdqtxNb6zpVi6gl2vf0iZr8y+PtaslVXMeV9Pu9xS/EmrXvCiajKJa9iCZe4S
         LpK/JO6vbmew4JxbSzbZQyffZL4sOt9sBlPWbT9WmPY7+pp+Ff0i+9BT7l4WdUaIrrgA
         btwhF2XkX8IUP7VpoyJ9OAYm06ddrZftAFhV0gBzofVRmYYEJ8dT0O9gMwk7XMh0b2Ct
         qw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PvsAEkfbXSvdKN+lTJ9M9+vqfLQVBlihpxSKUw/t/s=;
        b=XqblgBp0ZkG/sgPug/J34bMEfsbtHxL6yOVv+f7o/BSbKodPd6q7cCfA8u461LY5Pv
         dlK2okGts7uCHAyqMC96o+jPafmSkVuCMIsP65hwWTj08ZfNYWALbmOqYiy1bBRMkQFk
         W1WRaPTar3im9hcu5qFc4bRz9/S+068dUnpH18sk5TuaRQdc9aWhZwADGBSbGcbUj5ii
         UV4NGTciJVwmi9KsnDHDS8AxetTQ1AsJhntQfOcQpG12y1r+3am15vYq9gaPJzVouu9O
         ijiY8n7styqBu+E/wXo8t9aD6owrLAttN8XZ6sQ3xeSZD/vWfnOr0ogsBJ2nkhve/QG+
         D2Uw==
X-Gm-Message-State: AO0yUKWye3Is3CNTLv9r7Ip5yfYI4YB4Ybd6JRFHC6sCBuZVWc10Su/T
        JS1vnUejk8RzDriL5IK+Q+EjBwebZN4=
X-Google-Smtp-Source: AK7set8zsvT5wkP/7moSYA7dIHSCpHQad2RzXlV5c0Wh0zEZrq5yaOQZsQ7iykW9DnqHdXZz8PLHMfkZLc8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a81:6d2:0:b0:50e:e91d:f47 with SMTP id
 201-20020a8106d2000000b0050ee91d0f47mr27189ywg.61.1674848529047; Fri, 27 Jan
 2023 11:42:09 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:41:00 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-24-surenb@google.com>
Subject: [PATCH v2 23/33] mm: introduce lock_vma_under_rcu to be used from
 arch-specific code
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

Introduce lock_vma_under_rcu function to lookup and lock a VMA during
page fault handling. When VMA is not found, can't be locked or changes
after being locked, the function returns NULL. The lookup is performed
under RCU protection to prevent the found VMA from being destroyed before
the VMA lock is acquired. VMA lock statistics are updated according to
the results.
For now only anonymous VMAs can be searched this way. In other cases the
function returns NULL.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h |  3 +++
 mm/memory.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 66dca140695e..fa2b9d6e665e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -687,6 +687,9 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
 }
 
+struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
+					  unsigned long address);
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
diff --git a/mm/memory.c b/mm/memory.c
index d48c76e9fa57..5568fcb0a46b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5222,6 +5222,57 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
 
+#ifdef CONFIG_PER_VMA_LOCK
+/*
+ * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
+ * stable and not isolated. If the VMA is not found or is being modified the
+ * function returns NULL.
+ */
+struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
+					  unsigned long address)
+{
+	MA_STATE(mas, &mm->mm_mt, address, address);
+	struct vm_area_struct *vma, *validate;
+
+	rcu_read_lock();
+	vma = mas_walk(&mas);
+retry:
+	if (!vma)
+		goto inval;
+
+	/* Only anonymous vmas are supported for now */
+	if (!vma_is_anonymous(vma))
+		goto inval;
+
+	if (!vma_start_read(vma))
+		goto inval;
+
+	/* Check since vm_start/vm_end might change before we lock the VMA */
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+		vma_end_read(vma);
+		goto inval;
+	}
+
+	/* Check if the VMA got isolated after we found it */
+	mas.index = address;
+	validate = mas_walk(&mas);
+	if (validate != vma) {
+		vma_end_read(vma);
+		count_vm_vma_lock_event(VMA_LOCK_MISS);
+		/* The area was replaced with another one. */
+		vma = validate;
+		goto retry;
+	}
+
+	rcu_read_unlock();
+	return vma;
+inval:
+	rcu_read_unlock();
+	count_vm_vma_lock_event(VMA_LOCK_ABORT);
+	return NULL;
+}
+#endif /* CONFIG_PER_VMA_LOCK */
+
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
  * Allocate p4d page table.
-- 
2.39.1

