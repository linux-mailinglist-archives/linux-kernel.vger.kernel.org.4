Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B86E18C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjDNAMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjDNAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:12:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C392359A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f93850a86so69169547b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681431125; x=1684023125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+vIzhvgnDTeM5yLC6D6DMUdvSTbR9axXaSgRhroXf8=;
        b=mW9eVt20/JcXUsgxb+xjqD4VG4js+2q/p5hJJDDZIcnukRm0syQv/TXqiec2heBNck
         /LJ2OaI6hIksRPbp9XAhh99LqDjoZM2pQCkJ+bmJzc8yZHZYkwMAwFEhAsHbl30CzShC
         AnjRJgdI7su71kGpp2x6zyUwFmi0ZsMW7HG1IhDvuRpLPR8dBsIbCcLfLX3bb41Nf7ID
         fPGnb4gcd1xumZwEpzLDR6LXrZNMCwms/UiqwFrs/MG66By8fMMhSBTwwbfU9CItCsXE
         IVTc6CfCREM1gKWUMxH19y2K58Mf0+JvqHllDRZBSVXeFCA0+XBcsiL9bPxv2h5LcfvI
         JjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431125; x=1684023125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+vIzhvgnDTeM5yLC6D6DMUdvSTbR9axXaSgRhroXf8=;
        b=WNiLUrxMLdQ2UynPEam5utsvB3/viPoSAUnWIEPu1oDFixRonVEv6Pud8mrQZqYmM8
         bWz3MHtZBh+i+hqpBx33+Z3zJYTT0tIoPboqUcD2ym4TUcLhZEvO3F/j7FSUBYlw/edS
         BKAaA0ZdoJWH0IkIP1MLkiIkGEFO4V+Uu0YaX1dMS8VOlSesmEmU2MN+5yXZJ4EC7G4e
         6/48C1JcWNrmXk9osNLBb1AQQDjUpvNMO/XciC3g3YS2ofx3AWo99+HvyWWN+qXrRb1I
         LBsFkdhZO9Yg8qgaeuRyuZp9wzuJoaEWXEZf2/oa2KO+3dWCMSPmdCCDhScldYy1rC8k
         SaCA==
X-Gm-Message-State: AAQBX9cikgGHM8FMkgk1s9PVEAA+esOnev2bAw2YIdG7BnBiIMoLU4WG
        CNaW24JXIx+hwCPVUwogo2YwRwH+N8XPJ9Txsw==
X-Google-Smtp-Source: AKy350b34CBn9n2raOJ+zF+ClQSsfsH/2Lr8AcQiejmlqBPjPibu2aqY4QIJU2kHR7dXtCx3CNEm4OqoAAxVmXTquQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a81:4328:0:b0:545:4133:fc40 with SMTP
 id q40-20020a814328000000b005454133fc40mr2444452ywa.9.1681431125361; Thu, 13
 Apr 2023 17:12:05 -0700 (PDT)
Date:   Fri, 14 Apr 2023 00:11:53 +0000
In-Reply-To: <cover.1681430907.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1681430907.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <17bb8e925c08f27c627cd1f2bbb2714daf590c1d.1681430907.git.ackerleytng@google.com>
Subject: [RFC PATCH 4/6] mm: mempolicy: Add and expose mpol_create
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        muchun.song@linux.dev, feng.tang@intel.com, brgerst@gmail.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        mailhol.vincent@wanadoo.fr, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpol_create builds a mempolicy based on mode, nmask and maxnode.

mpol_create is exposed for use in memfd_restricted_bind() in a later
patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mempolicy.h |  2 ++
 mm/mempolicy.c            | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 9a2a2dd95432..15facd9de087 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -125,6 +125,8 @@ struct shared_policy {
 };
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst);
+struct mempolicy *mpol_create(
+	unsigned long mode, const unsigned long __user *nmask, unsigned long maxnode)
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol);
 int __mpol_set_shared_policy(struct shared_policy *info, struct mempolicy *mpol,
 			     unsigned long pgoff_start, unsigned long npages);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f3fa5494e4a8..f4fe241c17ff 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3181,3 +3181,42 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
 			       nodemask_pr_args(&nodes));
 }
+
+/**
+ * mpol_create - build mempolicy based on mode, nmask and maxnode
+ * @mode:  policy mode, as in MPOL_MODE_FLAGS
+ * @nmask:  node mask from userspace
+ * @maxnode:  number of valid bits in nmask
+ *
+ * Will allocate a new struct mempolicy that has to be released with
+ * mpol_put. Will also take and release the write lock mmap_lock in current->mm.
+ */
+struct mempolicy *mpol_create(
+	unsigned long mode, const unsigned long __user *nmask, unsigned long maxnode)
+{
+	int err;
+	unsigned short mode_flags;
+	nodemask_t nodes;
+	int lmode = mode;
+	struct mempolicy *mpol;
+
+	err = sanitize_mpol_flags(&lmode, &mode_flags);
+	if (err)
+		return ERR_PTR(err);
+
+	err = get_nodes(&nodes, nmask, maxnode);
+	if (err)
+		return ERR_PTR(err);
+
+	mpol = mpol_new(mode, mode_flags, &nodes);
+	if (IS_ERR(mpol))
+		return mpol;
+
+	err = mpol_init_from_nodemask(mpol, &nodes, true);
+	if (err) {
+		mpol_put(mpol);
+		return ERR_PTR(err);
+	}
+
+	return mpol;
+}
-- 
2.40.0.634.g4ca3ef3211-goog

