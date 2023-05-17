Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C36706C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjEQPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjEQPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF7A5D3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684335856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5R80nbUZwWFiHdR78rMDNlvBGteEPIxCifWqkv+jAN8=;
        b=AVvl6WpRLnQ3H8wtsI401rmZ1NvYbvOboWkKsRRSx/wZy6WUDjiuGM6nNx1IqK0oDoCVql
        EfkIYHivwHkkc3Qe5ZwJgmhLxzDGt/tQOEJat4IsHwwWB0+opCwFVJQI/QxEurdLc+lOWq
        HOCMrCEA2WkoOBFR1mff3ZhX35C1TeE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-xI2Sxs1qPwu4pWcRJCDoVg-1; Wed, 17 May 2023 11:04:14 -0400
X-MC-Unique: xI2Sxs1qPwu4pWcRJCDoVg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74faf5008bbso3251585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335853; x=1686927853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R80nbUZwWFiHdR78rMDNlvBGteEPIxCifWqkv+jAN8=;
        b=JkfFNt00JO34QH8j0nTKbzmg+o9W9nhve2QkghLXaV2MRyTk3x+992q5bYjXeiQibx
         cpEMLoE8/o26DYs758qLFu2Rwyf2+hlV4Lx4SCIkpPwq24+7sER5n0ZW5iNWJhYINTAn
         MxrhTu8Q04yE8m6gDVuco3nLQyJM6hGfPl7q7nT/5AoYbRQAuorTnMYIV2dIPwMbb9s4
         GmTosN2WaW4B44buK1XUQWie5EXlbj0RMzilII5R6qXDX3BDp2IRnhwM/CmGTdeLpgg2
         Z9ZQfmBbt8guRCihUshtqkQ+HSZLDGS4f3tITfUkmVfjovHFTGyLOpQQzFZmt8wghQso
         sRXw==
X-Gm-Message-State: AC+VfDzyBQDvlQR27xxC60OrDlNgfpEHAc/Iu6Bo11f6hde9hIy8dODl
        bQ/uLCe54/OeJ3S2IoCczVyh5zWr6FsUnc5ioRd/1Mb5hH6nOGMECG361Qvzcj9+nImWSyb2ZVL
        mw6gmDaZH8YDiKw4O6+X5AE0BbFgIQy+QIu1x/xhPuT+WEyB4KBNQif+cHT/H5Q2GhNilIyoruK
        XZKjEbQw==
X-Received: by 2002:a05:6214:cc8:b0:623:5678:1285 with SMTP id 8-20020a0562140cc800b0062356781285mr5664678qvx.2.1684335852882;
        Wed, 17 May 2023 08:04:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4A7kugtT7Bx+EHF80tM99neHimNnRwy8AYQ2bdr/AsAi1MAhOSAI8qAPppaefRrYgb8kIRbA==
X-Received: by 2002:a05:6214:cc8:b0:623:5678:1285 with SMTP id 8-20020a0562140cc800b0062356781285mr5664630qvx.2.1684335852517;
        Wed, 17 May 2023 08:04:12 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a120a00b0074d4cf8f9fcsm661141qkj.107.2023.05.17.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:04:11 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of vma
Date:   Wed, 17 May 2023 11:04:07 -0400
Message-Id: <20230517150408.3411044-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517150408.3411044-1-peterx@redhat.com>
References: <20230517150408.3411044-1-peterx@redhat.com>
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

The problem is in the current code base we didn't fixup "prev" for the case
where "start" address can be within the "prev" vma section.  In that case
we should have "prev" points to the current vma rather than the previous
one when feeding to vma_merge().

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

