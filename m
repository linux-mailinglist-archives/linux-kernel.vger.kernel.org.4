Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8B653A54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 02:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiLVBdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 20:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLVBdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 20:33:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54520180
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:33:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3d2994e2d7dso6879887b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMbd6YPE3mDcFXMpMkb2Cl5GlR82hgSLYy3B2RTrJ24=;
        b=iPqNqREydN6RH8EAKMfQ3krja3jcNSNIVXyMeSPbiv3qxfT4FujakOttz4xz/kwCTL
         1mVtEICZPiGeTUVk4POhXMUHZH37mmgonWwjNnjArrl+/DCz3SeY7SsMEwdWCK74sD9P
         lE7cPlcCJWrSpou2akxgz9Jk5oMCXH5z81cfXbrSqTisN8UthkUFeU4p0b9yhsCK19DA
         njnNd2X85mAmuMLy7LWgQHO+pkek2nnztGnoUkwb5Dw7kFqbcxq2uYnELnLq93CtVPIn
         ZKsellIp7I1uoHlT0RmELO6g+DhxSh56y/IeI/GglvztpBr3GeenQq7bFALVdUMKcLz2
         pIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMbd6YPE3mDcFXMpMkb2Cl5GlR82hgSLYy3B2RTrJ24=;
        b=PcfnK5u/10LGq68rqaSzErSnfHzMDDq0PtUbm7VzlS0GJmyWgbKXNrgYfsp/abPKjq
         PdTsNc400RQdZMWfbG1ZWJr0r0Pcw1ye1uXrPyR64UJFm+cYN2o1Nun/+HaetQU4bZ9S
         ra52mRvhTxOkZTSb1ucQBC06TDXXGvrlSErDzWJUGR/mg/FqFb1WpVhlcR8W7ZQjHRxJ
         f4etEzs0cf01fmvYm91Svh1XN2wQjNsxGFuN5AXQ36yC7IBTD7GhRIM6kPPj5Xg4o3yk
         iDXWTmzOBpT9qcmQMJ1hswrLuXFzzK001cilnKGgvbhUF9VJO016aI/xHOaTCcIKV2tM
         Mi+Q==
X-Gm-Message-State: AFqh2krqvlGUPeriEhJ2aFZ+NiNIBaO3rlmq1ki7kgQmyOfXNOKFRV23
        0titXr5Zg82CpSlXlfHCC4XiBPQQT18=
X-Google-Smtp-Source: AMrXdXvcJ5fLrALYrL4yvBVM/w1aVt0b+iVWdDkoO/EdJInehaqxYmryeUca4jH3vE1y2v9HTKl0f/ViE9by
X-Received: from jackyli.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3b51])
 (user=jackyli job=sendgmr) by 2002:a25:8487:0:b0:71d:a4ec:6069 with SMTP id
 v7-20020a258487000000b0071da4ec6069mr435416ybk.613.1671672817363; Wed, 21 Dec
 2022 17:33:37 -0800 (PST)
Date:   Thu, 22 Dec 2022 01:33:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222013330.831474-1-jackyli@google.com>
Subject: [PATCH] x86/mm/cpa: get rid of the cpa lock
From:   Jacky Li <jackyli@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC is to solicit feedback on how to remove/disable the CPA lock
for modern x86 CPUs. We suspect it can be removed for older x86 CPUs
as well per the third bullet in our full reasoning below. However,
offlist discussion at LPC suggested that doing so could be too risky
because it is hard to test these changes on very old CPUs.

The cpa_lock was introduced in commit ad5ca55f6bdb ("x86, cpa: srlz
cpa(), global flush tlb after splitting big page and before doing cpa")
to solve a race condition where one cpu is splitting a large
page entry along with changing the attribute, while another cpu with
stale large tlb entries is also changing the page attributes.

There are 3 reasons to remove/modify this cpa_lock today.

First, this cpa_lock is inefficient because it=E2=80=99s a global spin lock=
.
It only protects the race condition when multiple threads are
modifying the same large page entry while preventing all
parallelization when threads are updating different 4K page entries,
which is much more common.

Second, as stated in arch/x86/include/asm/set_memory.h,
	"the API does not provide exclusion between various callers -
	including callers that operation on other mappings of the same
	physical page."
the caller should handle the race condition where two threads are
modifying the same page entry. The API should only handle it when this
race condition can crash the kernel, which might have been true back
in 2008 because the commit cover letter mentioned
	"If the two translations differ with respect to page frame or
	attributes (e.g., permissions), processor behavior is
	undefined and may be implementation specific. The processor
	may use a page frame or attributes that correspond to neither
	translation;"
However it=E2=80=99s no longer true today per Intel's spec [1]:
	"the TLBs may subsequently contain multiple translations for
	the address range (one for each page size). A reference to a
	linear address in the address range may use any of these
	translations."

Third, even though it=E2=80=99s possible in old hardware that this race
condition can crash the kernel, this specific race condition that
cpa_lock was trying to protect when introduced in 2008 has already
been protected by pgd_lock today, thanks to the commit c0a759abf5a6
("x86/mm/cpa: Move flush_tlb_all()") in 2018 that moves the
flush_tlb_all() from outside pgd_lock to inside. Therefore today when
one cpu is splitting the large page and changing attributes, the other
cpu will need to wait until the global tlb flush is done and pgd_lock
gets released, and after that there won=E2=80=99t be stale large tlb entrie=
s
to change within this cpu. (I did a talk in LPC [2] that has a pseudo
code explaining why the race condition is protected by pgd_lock today)

It=E2=80=99s true that with such old code, the cpa_lock might protect more
race conditions than those that it was introduced to protect in 2008,
or some old hardware may depend on the cpa_lock for undocumented
behavior. So removing the lock directly might not be a good idea, but
it probably should not mean that we need to keep the inefficient code
forever. I would appreciate any suggestion to navigate this lock
removal from the folks on the to and cc list.

[1] Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=80=99s Man=
ual,
Volume 3A: System Programming Guide, Part 1, Section 4.10.2.
[2] https://youtu.be/LFJQ1PGGF7Q?t=3D330

Signed-off-by: Jacky Li <jackyli@google.com>
---
 arch/x86/mm/pat/set_memory.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 356758b7d4b4..84ad8198830f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -62,14 +62,6 @@ enum cpa_warn {
=20
 static const int cpa_warn_level =3D CPA_PROTECT;
=20
-/*
- * Serialize cpa() (for !DEBUG_PAGEALLOC which uses large identity mapping=
s)
- * using cpa_lock. So that we don't allow any other cpu, with stale large =
tlb
- * entries change the page attribute in parallel to some other cpu
- * splitting a large page entry along with changing the attribute.
- */
-static DEFINE_SPINLOCK(cpa_lock);
-
 #define CPA_FLUSHTLB 1
 #define CPA_ARRAY 2
 #define CPA_PAGES_ARRAY 4
@@ -1127,7 +1119,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte,=
 unsigned long address,
 	 *  (e.g., permissions), processor behavior is undefined and may
 	 *  be implementation-specific."
 	 *
-	 * We do this global tlb flush inside the cpa_lock, so that we
+	 * We do this global tlb flush inside the pgd_lock, so that we
 	 * don't allow any other cpu, with stale tlb entries change the
 	 * page attribute in parallel, that also falls into the
 	 * just split large page entry.
@@ -1143,11 +1135,7 @@ static int split_large_page(struct cpa_data *cpa, pt=
e_t *kpte,
 {
 	struct page *base;
=20
-	if (!debug_pagealloc_enabled())
-		spin_unlock(&cpa_lock);
 	base =3D alloc_pages(GFP_KERNEL, 0);
-	if (!debug_pagealloc_enabled())
-		spin_lock(&cpa_lock);
 	if (!base)
 		return -ENOMEM;
=20
@@ -1759,11 +1747,7 @@ static int __change_page_attr_set_clr(struct cpa_dat=
a *cpa, int primary)
 		if (cpa->flags & (CPA_ARRAY | CPA_PAGES_ARRAY))
 			cpa->numpages =3D 1;
=20
-		if (!debug_pagealloc_enabled())
-			spin_lock(&cpa_lock);
 		ret =3D __change_page_attr(cpa, primary);
-		if (!debug_pagealloc_enabled())
-			spin_unlock(&cpa_lock);
 		if (ret)
 			goto out;
=20
--=20
2.39.0.314.g84b9a713c41-goog

