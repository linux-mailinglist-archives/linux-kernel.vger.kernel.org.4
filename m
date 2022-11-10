Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AC624BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiKJUcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKJUcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E52C101
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668112298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ff4uIKDwEIX1/MsTGENOmYM+Xv3Uc0BmHEC53Fnq3vY=;
        b=JLggzwm0ouJzT4gFMOEdeonTCpxls6CBRmM5WibRXZ+EE3uNOhleb47D9AN882oDPAjA44
        yON9f9jjSBebUlINNUtkGasruJBsFFKFJRLyybkcjr5SQHn77bTEpUCjbxq1xWjh8GnXsy
        Rg7gnen+vFl1KRwIG+EUDa0SUBY0Ob8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-OFgK-zluPViWqEPnxECd5w-1; Thu, 10 Nov 2022 15:31:37 -0500
X-MC-Unique: OFgK-zluPViWqEPnxECd5w-1
Received: by mail-qt1-f200.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so2275162qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ff4uIKDwEIX1/MsTGENOmYM+Xv3Uc0BmHEC53Fnq3vY=;
        b=ivSa2/XzbtZ6u5s8nUrYDeVl3aBSwqMzqN8NIYjMibUzDXHgNwyzQkPLgzpKbQQXNm
         P1X0f8gIhKMyLiuHL8KwGSSIRoJzjU6oC8fYMEu2JJVACe8d2D45eMG7StXEi3M1rn5b
         IMWBcaiOD4RirWxGLRKGuG4ULCgAfkZgVxOPva1OOKuI577DTyIuaBquL50W4tss5mAx
         Af8j2olQZfeLQKoHyM96aAeUHCe/N2kkEfkKcBbCYt2vg046UV0Nx7pnlAW9XnRZd9zy
         Gbq9C0Ahkyyv2HrMqhFRi41MB4XK3j1McCr/ULO+PUv/XmapZTQrGzeTDBB1GUT9vpuL
         ItGA==
X-Gm-Message-State: ACrzQf24WGGYtllVU1pHgCd7C6cHp67lJaQG3jk/5+fcyGL5h6vrf5H1
        Peeu8wxxI61BsHjn3+ByxLgpbRmFJ+d4B0kmcL52UE9GYvG7EjgaKAtRTGvFYxPKShtmsqbv8pF
        Kwde5LqjVJ/4OksUrU128qWUT3CFIgMQ8FRAe0emYIaWpDF11MlCnY04ATpRO4gTIkGtL7gVsyg
        ==
X-Received: by 2002:a05:620a:2455:b0:6fa:3fbf:6b51 with SMTP id h21-20020a05620a245500b006fa3fbf6b51mr1747398qkn.519.1668112296278;
        Thu, 10 Nov 2022 12:31:36 -0800 (PST)
X-Google-Smtp-Source: AMsMyM48Dbsd61+EMKMLnYyrMapQFxdZHIJkOTIgyuDxqxIk8mfk0DBVx1tPHeFMdbbAkCTVyomt5g==
X-Received: by 2002:a05:620a:2455:b0:6fa:3fbf:6b51 with SMTP id h21-20020a05620a245500b006fa3fbf6b51mr1747373qkn.519.1668112295954;
        Thu, 10 Nov 2022 12:31:35 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i1-20020ac860c1000000b00399edda03dfsm123588qtm.67.2022.11.10.12.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:31:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/migrate: Fix read-only page got writable when recover pte
Date:   Thu, 10 Nov 2022 15:31:31 -0500
Message-Id: <20221110203132.1498183-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110203132.1498183-1-peterx@redhat.com>
References: <20221110203132.1498183-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ives van Hoorne from codesandbox.io reported an issue regarding possible
data loss of uffd-wp when applied to memfds on heavily loaded systems.  The
sympton is some read page got data mismatch from the snapshot child VMs.

Here I can also reproduce with a Rust reproducer that was provided by Ives
that keeps taking snapshot of a 256MB VM, on a 32G system when I initiate
80 instances I can trigger the issues in ten minutes.

It turns out that we got some pages write-through even if uffd-wp is
applied to the pte.

The problem is, when removing migration entries, we didn't really worry
about write bit as long as we know it's not a write migration entry.  That
may not be true, for some memory types (e.g. writable shmem) mk_pte can
return a pte with write bit set, then to recover the migration entry to its
original state we need to explicit wr-protect the pte or it'll has the
write bit set if it's a read migration entry.

For uffd it can cause write-through.  I didn't verify, but I think it'll be
the same for mprotect()ed pages and after migration we can miss the sigbus
instead.

The relevant code on uffd was introduced in the anon support, which is
commit f45ec5ff16a7 ("userfaultfd: wp: support swap and page migration",
2020-04-07).  However anon shouldn't suffer from this problem because anon
should already have the write bit cleared always, so that may not be a
proper Fixes target.  To satisfy the need on the backport, I'm attaching
the Fixes tag to the uffd-wp shmem support.  Since no one had issue with
mprotect, so I assume that's also the kernel version we should start to
backport for stable, and we shouldn't need to worry before that.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: stable@vger.kernel.org
Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
Reported-by: Ives van Hoorne <ives@codesandbox.io>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/migrate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index dff333593a8a..8b6351c08c78 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -213,8 +213,14 @@ static bool remove_migration_pte(struct folio *folio,
 			pte = pte_mkdirty(pte);
 		if (is_writable_migration_entry(entry))
 			pte = maybe_mkwrite(pte, vma);
-		else if (pte_swp_uffd_wp(*pvmw.pte))
+		else
+			/* NOTE: mk_pte can have write bit set */
+			pte = pte_wrprotect(pte);
+
+		if (pte_swp_uffd_wp(*pvmw.pte)) {
+			WARN_ON_ONCE(pte_write(pte));
 			pte = pte_mkuffd_wp(pte);
+		}
 
 		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
-- 
2.37.3

