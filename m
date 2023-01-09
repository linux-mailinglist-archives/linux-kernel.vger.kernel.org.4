Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCB6631F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbjAIUzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbjAIUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:17 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318B077D0E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 31-20020a17090a0fa200b00226e43409c2so3542156pjz.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ThjMRKbwnKxVGB3eylsidymuk6Qi/iLA6nYtJEm4MU=;
        b=RKn/zVLZEJYWNukTXjRCu4nz81zaytlRkR7rakIR2uB/aIfeElp0yCIRzuM8+pvZ3x
         BQOElK8tbS+rhMmhhEhBtfHOWGZOyvH/HCUdLENpEngLYbZsqjJ9OUXahFZPUHh+XaxU
         YMwkVhfHQ73TasfAveK5V4w8pX7O6IKpRzfg+l1/+SN9l2l60gXMRIOKbNPAPi3/90FE
         v/HorT/klJnq8Lcd3XX+VkW89j017v/vCfpCQTBG4XFodaDoUu6obKl8t1y+jpshNDo0
         91Vfmkl3EHo0Elu4jQ9efLprq8Gy+cE160O08y2PdqRoSx1lsEPlDSvoNxeAyXeTk2x0
         qpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ThjMRKbwnKxVGB3eylsidymuk6Qi/iLA6nYtJEm4MU=;
        b=l4mmbpAKy2O1PAk8y/kacszyy540lIu8NNdeipP2LJKtrQyYzk9nV6Fu1tx9MiKM5j
         uUeLzhlLkEUwfiEKdZOjwrLNCMRI568fRbN/X6m3+/hS6R3bBhN75o2Uw2ZPDPW7yxV+
         HDcayym1tf0eLVREY8FZkNDu9Zv/fvRxaoz4M2VyhAkRUR/nNopM77caUZXVGa5bh2kd
         tN3ytoJNxrfcRDTi/CG8CisttQiFvEB19gstYBwZdmYtaTmJAnkjtVvG+cy11NA2LWlc
         /4N10RT07r3FKa0q95OknOBvxkUj0MsML4LkYkwHfYrJnnG74hMroXy3CM/bgbtHj0iD
         kNNA==
X-Gm-Message-State: AFqh2kp2usmtUDJcRzsbUz5rsJL1fo9OhRCe0zylOGXAesmm6V48xPNh
        HjJFWQItY15pjQk4JqLYhgrmmLh67Fw=
X-Google-Smtp-Source: AMrXdXvxnut8BEB8WYWMFHzY9PnfOwu60Xd9fTsfu57bMChvZCCQkV4pslftmJOaEGGsy1IoVxboiXkLZWU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a17:90a:5c86:b0:219:c1fb:5da8 with SMTP id
 r6-20020a17090a5c8600b00219c1fb5da8mr5399379pji.221.1673297653600; Mon, 09
 Jan 2023 12:54:13 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:08 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-14-surenb@google.com>
Subject: [PATCH 13/41] mm: introduce vma->vm_flags modifier functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
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

To keep vma locking correctness when vm_flags are modified, add modifier
functions to be used whenever flags are updated.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  8 +++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ec2c4c227d51..35cf0a6cbcc2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -702,6 +702,44 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma_init_lock(vma);
 }
 
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline
+void init_vm_flags(struct vm_area_struct *vma, unsigned long flags)
+{
+	WRITE_ONCE(vma->vm_flags, flags);
+}
+
+/* Use when VMA is part of the VMA tree and needs appropriate locking */
+static inline
+void reset_vm_flags(struct vm_area_struct *vma, unsigned long flags)
+{
+	vma_write_lock(vma);
+	init_vm_flags(vma, flags);
+}
+
+static inline
+void set_vm_flags(struct vm_area_struct *vma, unsigned long flags)
+{
+	vma_write_lock(vma);
+	vma->vm_flags |= flags;
+}
+
+static inline
+void clear_vm_flags(struct vm_area_struct *vma, unsigned long flags)
+{
+	vma_write_lock(vma);
+	vma->vm_flags &= ~flags;
+}
+
+static inline
+void mod_vm_flags(struct vm_area_struct *vma,
+		  unsigned long set, unsigned long clear)
+{
+	vma_write_lock(vma);
+	vma->vm_flags |= set;
+	vma->vm_flags &= ~clear;
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5f7c5ca89931..0d27edd3e63a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -553,7 +553,13 @@ struct vm_area_struct {
 	 * See vmf_insert_mixed_prot() for discussion.
 	 */
 	pgprot_t vm_page_prot;
-	unsigned long vm_flags;		/* Flags, see mm.h. */
+
+	/*
+	 * Flags, see mm.h.
+	 * WARNING! Do not modify directly to keep correct VMA locking.
+	 * Use {init|reset|set|clear|mod}_vm_flags() functions instead.
+	 */
+	unsigned long vm_flags;
 
 #ifdef CONFIG_PER_VMA_LOCK
 	int vm_lock_seq;
-- 
2.39.0

