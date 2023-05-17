Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4270718C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEQTKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEQTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FE083C5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684350564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0vLIGQ76sSG5EGgMh6kBM7wgWyPxuvXNfJPYChH6HQ=;
        b=Gtrr0Hq0NXrkjSbKP/wTRsx6tfagXDJJbOT3+j/N+0SnV+jXf3ZfSCW4HIVILMDvU7fj5i
        aMZEq8nYLbygoH4LZAy22bm0vehxisHAN1sNPlAdgQxx4pJa83A25cnvrLr4Emlkr2O9UJ
        i5FdH7Ft/PYGD5N1ogqgQc/A/aCfK5M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-hrZzoHSVOR-v2Cbqz3SdWA-1; Wed, 17 May 2023 15:09:23 -0400
X-MC-Unique: hrZzoHSVOR-v2Cbqz3SdWA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f39195e7e5so2360161cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350562; x=1686942562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0vLIGQ76sSG5EGgMh6kBM7wgWyPxuvXNfJPYChH6HQ=;
        b=LV9waJnguUZoLSNzcwjaC+VVd3bjuIJkm7S4qW6OWgqbjbB+uIQ3AKbdSaPbky913y
         6pqBYPBxzNIfboUlbyFc8VS7aKOBi2bSMulFAcj1w6zG7IRyUhRIasLgDwWbazOiwj2m
         RTw+EP3Ry/FGxmkxjjXtKk4PupCHQTBh0cVmeDSzJ+WMAhQorbIbAtQtyk2fNVXzMQOV
         vkf9+xK431nucZP8sH7QpBhRBVIOMX4XOinqWU0ra9pvej/r6DCD1uFSy6QvKlpf2wJ2
         C1TrOvXFjBiTemiU1qtKaPCWRmiDqlCRYnsElZH+TH6acHSPuUhOl0aGPWrG1DFqZi3L
         WMSQ==
X-Gm-Message-State: AC+VfDzf/WPlQRBwrWdF4D97fjuEdENEPbCdwxUunKI7MBc0r+b4x1ue
        P8r4NfxLaBFPycoq9Mf1y4HzzCtGyVycGhyaHbMwvhMyiCSazjgbq95Pkt95bop9W7Flt4uyA3G
        adfUCxy42Va4+4efXdrDVnmI6ICJ6U7wNvUFKNTd654QdhZk4ibkVN0xXDR1LPb5cLbFix7L4FQ
        hDgpFqGg==
X-Received: by 2002:a05:622a:2cd:b0:3ef:4614:d0de with SMTP id a13-20020a05622a02cd00b003ef4614d0demr6995421qtx.4.1684350561922;
        Wed, 17 May 2023 12:09:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7J2wzPLNuWb2xStmEdoJDaUJKipyb+2I0xjiFg3N5ksFe4XH0shtqnXZrCduoJFkiMn/Bkjw==
X-Received: by 2002:a05:622a:2cd:b0:3ef:4614:d0de with SMTP id a13-20020a05622a02cd00b003ef4614d0demr6995376qtx.4.1684350561541;
        Wed, 17 May 2023 12:09:21 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a143500b0075954005b46sm833464qkj.48.2023.05.17.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:09:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] mm/uffd: Fix vma operation where start addr cuts part of vma
Date:   Wed, 17 May 2023 15:09:15 -0400
Message-Id: <20230517190916.3429499-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517190916.3429499-1-peterx@redhat.com>
References: <20230517190916.3429499-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems vma merging with uffd paths is broken with either
register/unregister, where right now we can feed wrong parameters to
vma_merge() and it's found by recent patch which moved asserts upwards in
vma_merge() by Lorenzo Stoakes:

https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/

It's possible that "start" is contained within vma but not clamped to its
start.  We need to convert this into either "cannot merge" case or "can
merge" case 4 which permits subdivision of prev by assigning vma to
prev. As we loop, each subsequent VMA will be clamped to the start.

This patch will eliminate the report and make sure vma_merge() calls will
become legal again.

One thing to mention is that the "Fixes: 29417d292bd0" below is there only
to help explain where the warning can start to trigger, the real commit to
fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
issue, but unfortunately we may want to keep it in Fixes too just to ease
kernel backporters for easier tracking.

Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0fd96d6e39ce..17c8c345dac4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1459,6 +1459,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
@@ -1625,6 +1627,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 	vma_iter_set(&vmi, start);
 	prev = vma_prev(&vmi);
+	if (vma->vm_start < start)
+		prev = vma;
+
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
-- 
2.39.1

