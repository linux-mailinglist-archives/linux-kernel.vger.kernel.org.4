Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE57012DF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbjELX7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbjELX6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:58:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69DB40F2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:58:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so13026032276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935897; x=1686527897;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwMV83qzB00xUe1xka9Kex2X8Ec2jkmSilor+2INk6I=;
        b=xk2Ibde3e8u/s1FXz5MjnaikjmFzTVuGbTz673xLExz96TfA9SY9JBEhrH4pDcD4kc
         lJcaoTYG0RcJgWFZFSCaY33HyZj2N01rZHV90M6ATudVtPlhyiI8LL94cSLE8hlDZsK1
         ohmUhbm4cTQwXS7bDVKRWaW81vYw/Zs2XgvQtpjyOpS39KbdeTP0PlNP0LVOEJX0BiKd
         Gp/2PGuqyiqk4rIboKMupJ2lV3A59cCft+4hG9Pnr7dP/E1pUxUHHsAIktr3S1az7xY9
         Y7C7SJ3J766Sa8Y3zSYkAveN2OM091uDtEnFY90+chuUo5dWOIKtYgSwr2SEMxwfaVJk
         l+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935897; x=1686527897;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XwMV83qzB00xUe1xka9Kex2X8Ec2jkmSilor+2INk6I=;
        b=VSNaepKceXMIdZTLUTCkL6YsH4hLOKPwp9+Mks7qrlANAMWOJTogFdPKkB677t5mX7
         dm+kGAk2E47sN2vt1VZDgKMVYWB9XUXaJ/WOugoJO1Ur5ie0zNMGJMMq54uvFH/wy3pS
         x5FrvZXF2ja5yx9L+ZITfn3wDwjPL/RjxPC6OFi0L9cTUakr/znkZugKa3bWk3zJMTw6
         hqqWjZU4gRiK3SVDe/G/lxeeu2RIG1G/8ADrbsSCjskBRTzaaDjbY1maSHNnqvDdzLc3
         iXZgQjCiID4F2VAbKBcgldhceFOsbs1+eyL+Sgn7QyRAi4/vXfTIakatbMAlS2VdbE6w
         PHpQ==
X-Gm-Message-State: AC+VfDyx3sVa55KpTf76ADUOqF504xwKKndEPy3hYFMoHi+56+nXD94n
        7vB6vsNwjOcEklW3XNu9+NWO+Hc=
X-Google-Smtp-Source: ACHHUZ5fNzBCdsm//w4GJKGotggr/NOqYy/clxbht/ilkykWu8XfrBS2AXyT1QiZkNq0D7bzCiaesqo=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:ff6:108b:739d:6a1c])
 (user=pcc job=sendgmr) by 2002:a25:d18a:0:b0:ba7:29a9:a471 with SMTP id
 i132-20020a25d18a000000b00ba729a9a471mr1565248ybg.0.1683935897117; Fri, 12
 May 2023 16:58:17 -0700 (PDT)
Date:   Fri, 12 May 2023 16:57:51 -0700
In-Reply-To: <20230512235755.1589034-1-pcc@google.com>
Message-Id: <20230512235755.1589034-3-pcc@google.com>
Mime-Version: 1.0
References: <20230512235755.1589034-1-pcc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH 2/3] mm: Call arch_swap_restore() from arch_do_swap_page() and
 deprecate the latter
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "=?UTF-8?q?Qun-wei=20Lin=20=28=E6=9E=97=E7=BE=A4=E5=B4=B4=29?=" 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "=?UTF-8?q?Chinwen=20Chang=20=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?=" 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "=?UTF-8?q?Kuan-Ying=20Lee=20=28=E6=9D=8E=E5=86=A0=E7=A9=8E=29?=" 
        <Kuan-Ying.Lee@mediatek.com>,
        "=?UTF-8?q?Casper=20Li=20=28=E6=9D=8E=E4=B8=AD=E6=A6=AE=29?=" 
        <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch made it possible for MTE to restore tags before they
are freed by hooking arch_do_swap_page().

However, the arch_do_swap_page() hook API is incompatible with swap
restoration in circumstances where we do not have an mm or a vma,
such as swapoff with swapped out shmem, and I expect that ADI will
currently fail to restore tags in these circumstances. This implies that
arch-specific metadata stores ought to be indexed by swap index, as MTE
does, rather than by mm and vma, as ADI does, and we should discourage
hooking arch_do_swap_page(), preferring to hook arch_swap_restore()
instead, as MTE already does.

Therefore, instead of directly hooking arch_do_swap_page() for
MTE, deprecate that hook, change its default implementation to call
arch_swap_restore() and rely on the existing implementation of the latter
for MTE.

Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
Link: https://linux-review.googlesource.com/id/Id2f1ad76eaf606ae210e1d2dd0b=
7fe287e5f7d87
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reported-by: Qun-wei Lin (=E6=9E=97=E7=BE=A4=E5=B4=B4) <Qun-wei.Lin@mediate=
k.com>
Link: https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.=
camel@mediatek.com/
Cc: <stable@vger.kernel.org> # 6.1
---
 include/linux/pgtable.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c63cd44777ec..fc0259cf60fb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -740,6 +740,12 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 	set_pgd(pgdp, pgd); \
 })
=20
+#ifndef __HAVE_ARCH_SWAP_RESTORE
+static inline void arch_swap_restore(swp_entry_t entry, struct folio *foli=
o)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
 /*
  * Some architectures support metadata associated with a page. When a
@@ -748,14 +754,14 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
  * processors support an ADI (Application Data Integrity) tag for the
  * page as metadata for the page. arch_do_swap_page() can restore this
  * metadata when a page is swapped back in.
+ *
+ * This hook is deprecated. Architectures should hook arch_swap_restore()
+ * instead, because this hook is not called on all code paths that can
+ * swap in a page, particularly those where mm and vma are not available
+ * (e.g. swapoff for shmem pages).
  */
-static inline void arch_do_swap_page(struct mm_struct *mm,
-				     struct vm_area_struct *vma,
-				     unsigned long addr,
-				     pte_t pte, pte_t oldpte)
-{
-
-}
+#define arch_do_swap_page(mm, vma, addr, pte, oldpte) \
+	arch_swap_restore(pte_to_swp_entry(oldpte), page_folio(pte_page(pte)))
 #endif
=20
 #ifndef __HAVE_ARCH_UNMAP_ONE
@@ -798,12 +804,6 @@ static inline void arch_swap_invalidate_area(int type)
 }
 #endif
=20
-#ifndef __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *foli=
o)
-{
-}
-#endif
-
 #ifndef __HAVE_ARCH_PGD_OFFSET_GATE
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
--=20
2.40.1.606.ga4b1b128d6-goog

