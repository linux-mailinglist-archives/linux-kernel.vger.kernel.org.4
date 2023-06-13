Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF072EE51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjFMVyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFMVyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2175F1BC9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HWwG9L2Hn01HieDsdKTsM+fW6Heseo+AVtJqKk3pma0=;
        b=AuW7i9/FKvjK0+Q6MdN+b1hmBVq5m9/4ONGwmdpZv/iMuep8qL88HI8Q9xO0kSbPM03hZ9
        s8G1X/Q/PjsyGnYtp6nO8quE/OUNoJcYLKhW1JGKxXWecRhoBZ77QtDdCg7Tu5R4zoiGZq
        5rHV3d15V6Jo2AZ6LGQFQX9onXAYw8U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-R-4W7kD9MOKGYfpONxlBMQ-1; Tue, 13 Jun 2023 17:53:51 -0400
X-MC-Unique: R-4W7kD9MOKGYfpONxlBMQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f8283a3a7aso13777141cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693230; x=1689285230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWwG9L2Hn01HieDsdKTsM+fW6Heseo+AVtJqKk3pma0=;
        b=cYb2RZa8qNbw3p6gJW8tX0qCo0oBp/Dx/V3f/9CHUK67xIJtTiWwqoz3eIPv48YmJd
         CGtQP4d6ZAYIx+R6Ogus+sucfm+Bp2yG4LT+kEMpgbz9Ey3Lp5Tkvtb8CFxQ3oDSP2R3
         fYb6HVFzZN/U/a2lUYSMlrTthskkMTbODsBbTt3bn8bw5trTrLOtN/vB1lRw88+v0pwW
         oQvkwxEoenpneNd7yZ7z2TV0LqsYhswQGSpvOBdTDf7katLrKX7n6/lakPBLcm+a/a2X
         xhZFu8NzDXSN0tGxynUkw5hH4iXJrO3eDIhRRph8rX/fbH86s8PPgiq9CdPjtY9PrhOb
         OJJg==
X-Gm-Message-State: AC+VfDy1nG6KRvA0pldY+kcTSkqRVnlsT6KycJ1FKFFIRkicjj0wp4+h
        c3rUIwPMGHaKnWAMquUxRVgZcL/+Fb4WR8+qGHHSHecpHO6CVv2jWlmykOr7B+j2TAGjnNG+azS
        1YlJQ8VNFwClmJZGjOiA1sG2QojP6hSmZZxDSydmq2nYaKltAebGeQ3d6tWbBojnrF2rLKyYuOp
        +s0aFSEw==
X-Received: by 2002:a05:622a:19a3:b0:3f9:cb97:f15a with SMTP id u35-20020a05622a19a300b003f9cb97f15amr17412711qtc.0.1686693229761;
        Tue, 13 Jun 2023 14:53:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LpuZZ8y6o+05nkbQUABsrbOlbnN9Rz4uLpZW4sN1JV6I6TVEVvx/zi1pYcdjTFS2ruush5A==
X-Received: by 2002:a05:622a:19a3:b0:3f9:cb97:f15a with SMTP id u35-20020a05622a19a300b003f9cb97f15amr17412692qtc.0.1686693229394;
        Tue, 13 Jun 2023 14:53:49 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:53:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 0/7] mm/gup: Unify hugetlb, speed up thp
Date:   Tue, 13 Jun 2023 17:53:39 -0400
Message-Id: <20230613215346.1022773-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb has a special path for slow gup that follow_page_mask() is actually
skipped completely along with faultin_page().  It's not only confusing, but
also duplicating a lot of logics that generic gup already has, making
hugetlb slightly special.

This patchset tries to dedup the logic, by first touching up the slow gup
code to be able to handle hugetlb pages correctly with the current follow
page and faultin routines (where we're mostly there.. due to 10 years ago
we did try to optimize thp, but half way done; more below), then at the
last patch drop the special path, then the hugetlb gup will always go the
generic routine too via faultin_page().

Note that hugetlb is still special for gup, mostly due to the pgtable
walking (hugetlb_walk()) that we rely on which is currently per-arch.  But
this is still one small step forward, and the diffstat might be a proof
too that this might be worthwhile.

Then for the "speed up thp" side: as a side effect, when I'm looking at the
chunk of code, I found that thp support is actually partially done.  It
doesn't mean that thp won't work for gup, but as long as **pages pointer
passed over, the optimization will be skipped too.  Patch 6 should address
that, so for thp we now get full speed gup.

For a quick number, "chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10" gives
me 13992.50us -> 378.50us.  Gup_test is an extreme case, but just to show
how it affects thp gups.

James: I hope this won't affect too much of your HGM series as this might
conflict with yours.  Logically it should even make your series smaller,
since you can drop the patch to support HGM for follow_hugetlb_page() now
after this one, but you only need to worry that if this one is proven
useful and merged first.

Patch 1-6 prepares for the switch, while patch 7 does the switch over.

I hope I didn't miss anything, and will be very happy to know.  Please have
a look, thanks.

Peter Xu (7):
  mm/hugetlb: Handle FOLL_DUMP well in follow_page_mask()
  mm/hugetlb: Fix hugetlb_follow_page_mask() on permission checks
  mm/hugetlb: Add page_mask for hugetlb_follow_page_mask()
  mm/hugetlb: Prepare hugetlb_follow_page_mask() for FOLL_PIN
  mm/gup: Cleanup next_page handling
  mm/gup: Accelerate thp gup even for "pages != NULL"
  mm/gup: Retire follow_hugetlb_page()

 include/linux/hugetlb.h |  20 +---
 mm/gup.c                |  68 +++++------
 mm/hugetlb.c            | 259 ++++------------------------------------
 3 files changed, 63 insertions(+), 284 deletions(-)

-- 
2.40.1

