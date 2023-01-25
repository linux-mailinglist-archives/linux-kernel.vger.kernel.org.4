Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5A67C0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjAYXgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjAYXgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:36:04 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5C5E51A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-482d3bf0266so1661047b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijhDThbayE4MrjmcyJpQB4++KqDnXZSVkoWdTA6boxg=;
        b=qAP7Xe1jWQ2v1pDyzimk/ucUXt6pJgnQPRMzULtUiXJ7miq94fdzWh3UQtS4ELXLXG
         xnRyMqJvJr9Qyw4fk8i3KNqyrHI6q9BE51NGUhcMbBkXiFN4EkWsXQg+sNncoZfFgpAd
         pmakogcOD7fawIoyB40GTMQKoodOtmE61jQOjn9IiPN2QveUdh02XHqNgo44qZ1Swkka
         UsHWmYnCHoE7T0et5kXrXIFTIL10ukIq3X3ayvz36CK5hAZd9JEO8xbOLC65b5H6U0Ms
         J3NS+Lumkoi4FpH2j3VjTovOoJdkWi+DW6xdc6JIqkzB0eqSo4KKNBbmC2JFmfQN4m9j
         cFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijhDThbayE4MrjmcyJpQB4++KqDnXZSVkoWdTA6boxg=;
        b=oisXrJ9nNjN19+rP7oWVX1HxLUSgs5w23497396reNy0mR0rupYD+/G9iB6I2hWCPE
         9c9D7qIRQHdigLxlkGxLxrLZryMs2V2T2D1Fuu0eQn0BLbxzLZF3iamIm/LQWvYY9xt8
         R4b89bmgCG8dt4+mLXkdLNQ/d6tu6HRIxVo0X9uI8NKh77KJBopiwx8XG75j99pTzKxS
         sN4MBB9425KotZb+OhthkZzqitcUYMLfhYGeff3QbMM6P/25gjAO8SXtsSNHltzIZIg7
         FOOirLqXR7DcBGMN888LNqpLTBWbCyjcIKTt+WsF/CcIKfYraork4nsOcuEeoxLCg4Rg
         YsUw==
X-Gm-Message-State: AFqh2kp3HZUpUW3v5ErZ0OvrGVPSUi65JDRXYzoxIhnpqxSNRPYYGe5J
        aEMn61JzUfgLWyvbf8a5g1EZK2LOmdg=
X-Google-Smtp-Source: AMrXdXuKSNG6CNUWpJ2GxlW/S4CYhyc7M4Q5HmRRIO5iXM40geoKvk7b/ruVHPa4Ev+GXlDquQW3EuW1OFs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a0d:ff42:0:b0:4e0:8133:2a5a with SMTP id
 p63-20020a0dff42000000b004e081332a5amr3780554ywf.187.1674689762692; Wed, 25
 Jan 2023 15:36:02 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:35:49 -0800
In-Reply-To: <20230125233554.153109-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125233554.153109-3-surenb@google.com>
Subject: [PATCH v3 2/7] mm: introduce vma->vm_flags wrapper functions
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

vm_flags are among VMA attributes which affect decisions like VMA merging
and splitting. Therefore all vm_flags modifications are performed after
taking exclusive mmap_lock to prevent vm_flags updates racing with such
operations. Introduce modifier functions for vm_flags to be used whenever
flags are updated. This way we can better check and control correct
locking behavior during these updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 10 +++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c2f62bdce134..bf16ddd544a5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -627,6 +627,43 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 }
 
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline void init_vm_flags(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	ACCESS_PRIVATE(vma, __vm_flags) = flags;
+}
+
+/* Use when VMA is part of the VMA tree and modifications need coordination */
+static inline void reset_vm_flags(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	init_vm_flags(vma, flags);
+}
+
+static inline void set_vm_flags(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
+}
+
+static inline void clear_vm_flags(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
+}
+
+static inline void mod_vm_flags(struct vm_area_struct *vma,
+				vm_flags_t set, vm_flags_t clear)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	ACCESS_PRIVATE(vma, __vm_flags) |= set;
+	ACCESS_PRIVATE(vma, __vm_flags) &= ~clear;
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2d6d790d9bed..bccbd5896850 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -491,7 +491,15 @@ struct vm_area_struct {
 	 * See vmf_insert_mixed_prot() for discussion.
 	 */
 	pgprot_t vm_page_prot;
-	unsigned long vm_flags;		/* Flags, see mm.h. */
+
+	/*
+	 * Flags, see mm.h.
+	 * To modify use {init|reset|set|clear|mod}_vm_flags() functions.
+	 */
+	union {
+		const vm_flags_t vm_flags;
+		vm_flags_t __private __vm_flags;
+	};
 
 	/*
 	 * For areas with an address space and backing store,
-- 
2.39.1

