Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9B35F49C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJDTeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A4696D2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664912044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F5xmAN9t6CeE2TFrsq+QgzxqKIzmy0qcB2aGqOypPbg=;
        b=BUfjo1pKaAhWfrazQwSj/dowlERF8DaJVE4wULp3QxVVHtnKwqdhr2VonmFEBBU0jx5WB2
        1BFfVuea/wqmX4iCVNcHbQ6jk0mNoz1RzxZoxik7AtZ66YP0MMOXHqvqANV6KTxe9TgbOW
        XIfvYNUCs8ppWXkvSt5Ng6xldDuB/pY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-d4l1OzjiOgmNC4V5gKJ7Iw-1; Tue, 04 Oct 2022 15:34:03 -0400
X-MC-Unique: d4l1OzjiOgmNC4V5gKJ7Iw-1
Received: by mail-qk1-f199.google.com with SMTP id j13-20020a05620a288d00b006be7b2a758fso12370092qkp.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=F5xmAN9t6CeE2TFrsq+QgzxqKIzmy0qcB2aGqOypPbg=;
        b=7WFrS537whkSBSqpnlu8zxFHk86O2+HXSzIxT7BrzhNdN4Gb+gm0wS3DDsFdigfwCo
         kcQm5U2cv3G/c3cO4AadyuasMJmOHBm5RByAglNLvv73ov8/8CUo6LuXrJX0pGGAb9m9
         NOlxJ6NUq7iOBfVLF8vlKrh/63glkxz2IADj4HHZP9a0Yx0306nwln0an9qsZuE77XtT
         GPUQbSSThk+dy02v6bTfDHk94fbQ2xjFdNXmM1uJ2Jhinus7dcCJoyTFNlU6MNVw19HU
         tsPcEQDTGI1q+M1I6HQQZF/3441JBBhOyqoRHIYMPgzO0PFfXMC/79Lb8adJNx+M/Ltr
         cKiA==
X-Gm-Message-State: ACrzQf2AIzoBCXBOGsYOo2nUrzhlQslcGml8sRujUdhJ9VgguLBqLVnR
        rhSaMU5VYpAu+PpFrRjnSg5DyKXrlyi7u2eESQ/gpHCI/dVRiKfFmKju0m4SakcGuezLXK+6UnY
        orgN/UhHPBCrW5QGoQhXbvE8B
X-Received: by 2002:a05:622a:341:b0:35d:44fc:3908 with SMTP id r1-20020a05622a034100b0035d44fc3908mr21104944qtw.507.1664912042645;
        Tue, 04 Oct 2022 12:34:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5jAF/2MHQhLJAx9+6UCeRp8zUWOpJ+7sJqhIuTupkh+lahPG8XXzChn6HoW8Wyr49jN/OPRQ==
X-Received: by 2002:a05:622a:341:b0:35d:44fc:3908 with SMTP id r1-20020a05622a034100b0035d44fc3908mr21104926qtw.507.1664912042438;
        Tue, 04 Oct 2022 12:34:02 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id z5-20020a05622a028500b00342fb07944fsm13299811qtw.82.2022.10.04.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:34:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 0/3] mm/hugetlb: Fix selftest failures with write check
Date:   Tue,  4 Oct 2022 15:33:57 -0400
Message-Id: <20221004193400.110155-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Rebase to akpm mm-unstable
v2:
- Fix the commit message of patch 1, replacing CoW with wr-unprotect
  example

Currently akpm mm-unstable fails with uffd hugetlb private mapping test
randomly on a write check.

The initial bisection of that points to the recent pmd unshare series, but
it turns out there's no direction relationship with the series but only
some timing change caused the race to start trigger.

The race should be fixed in patch 1.  Patch 2 is a trivial cleanup on the
similar race with hugetlb migrations, patch 3 comment on the write check
so when anyone read it again it'll be clear why it's there.

Thanks,

Peter Xu (3):
  mm/hugetlb: Fix race condition of uffd missing/minor handling
  mm/hugetlb: Use hugetlb_pte_stable in migration race check
  mm/selftest: uffd: Explain the write missing fault check

 mm/hugetlb.c                             | 66 ++++++++++++++++++++----
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++-
 2 files changed, 76 insertions(+), 12 deletions(-)

-- 
2.37.3

