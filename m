Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD46E17EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDMXMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDMXMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3456849CE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681427485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sy2ZMNXqMN2EgcAsVUaOWzVqOHhPBbCxJILj4M5ud0k=;
        b=YYNKPc9WORqOAu1hab8rlTQEQsUOeILIkIjilmAPno5Mc1fBMBXu4rCfDR2L2VNSEsHOUL
        1BEwOfrc52s1gJGSMxZof3tYCXBEw8jFLHh2SXRKj1LyS7Sc5YpENXPggJq3bODzPdGWk3
        hMNmlHq+pc0y/7qqqH0deImazXRP/Xs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505--50IN8n6OUiRHViocjYnyg-1; Thu, 13 Apr 2023 19:11:24 -0400
X-MC-Unique: -50IN8n6OUiRHViocjYnyg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e947d81d7dso3391281cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427483; x=1684019483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sy2ZMNXqMN2EgcAsVUaOWzVqOHhPBbCxJILj4M5ud0k=;
        b=IhR57ynZr48BsYmve/A3ETMNHeiqo4Wa3Y/9r3C5DLcMVUBxCjAdVSfs3zp1oj0heY
         avT5paJm1qibnJDRcVy7a2Gb0cg1aVllLG/sIY20O9JQVYD4IJAkw9Nk6iDtUToQQJb2
         +oUdCext6WLUXoQlDn06mrHVE4r293+YtGiRbRqXkj5qLTgSuGq51aP/l7nxls3jFEM0
         +Uz8VnK90e0XUFi9Vkcm/cpP4d6NM1EBcvI7CHxZLx3tlEfE7rUwq4IU7wVFGaEReHz0
         gB1dc5Ytl2pV+SBfqMyBLYsSThfrW9wz88oX/NDvqbo5sf1O6nmosqDGZGlCM0MZ2vEm
         1Z9g==
X-Gm-Message-State: AAQBX9ePl7mRrR6q7dtH/Z9c/PZlM4X3GF5SIbUG9X5JC1H+Fsa7T9iL
        HQD55C3/d5rJc8vpAOxwA9HYvnefKYHY4NOs5CkFwD6jRIWGRl8T711uH7hsxOy/FVK9DEaII0T
        jDbOf7kxEM7SMnhpJ2wKEaThT9zOH2aWZCR/g8NPNDXuP2vETM16JEE222YXseeNj1BQRCxb9cC
        KTCoksJw==
X-Received: by 2002:ac8:4e43:0:b0:3bf:cf77:a861 with SMTP id e3-20020ac84e43000000b003bfcf77a861mr1053272qtw.4.1681427482732;
        Thu, 13 Apr 2023 16:11:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350azXW2VkXEejL7kciZXzwV2PnzHHS8mVYaL63ffO4fmArHm00rq3T8DL3wm/yhANxmPuDYiEQ==
X-Received: by 2002:ac8:4e43:0:b0:3bf:cf77:a861 with SMTP id e3-20020ac84e43000000b003bfcf77a861mr1053215qtw.4.1681427482308;
        Thu, 13 Apr 2023 16:11:22 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g3-20020ac81243000000b003ea1b97acfasm612446qtj.49.2023.04.13.16.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:11:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 0/6] mm/hugetlb: More fixes around uffd-wp vs fork() / RO pins
Date:   Thu, 13 Apr 2023 19:11:14 -0400
Message-Id: <20230413231120.544685-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up of previous discussion here:

https://lore.kernel.org/r/20230324222707.GA3046@monkey

There, Mike correctly pointed out that uffd-wp bit can get lost too when
Copy-On-Read triggers.  Last time we didn't have a reproducer, I finally
wrote a reproducer and attached as the last patch.

When at it, I decided to also add some more uffd-wp tests against fork(),
and I found more bugs.  None of them were reported by anyone probably
because none of us cares, but since they're still bugs and can be
reproduced by the unit test I fixed them too in another patch.

The initial patch 1-2 are fixes to bugs, copied stable.

The rest patches 3-6 introduces unit tests to verify (based on the recent
rework on uffd unit test).  Note that not all the bugfixes in patch 1 is
verified (e.g. on changes to hugetlb hwpoison / migration entries), but I
assume they can be reviewed with careful eyes.

Thanks,

Peter Xu (6):
  mm/hugetlb: Fix uffd-wp during fork()
  mm/hugetlb: Fix uffd-wp bit lost when unsharing happens
  selftests/mm: Add a few options for uffd-unit-test
  selftests/mm: Extend and rename uffd pagemap test
  selftests/mm: Rename COW_EXTRA_LIBS to IOURING_EXTRA_LIBS
  selftests/mm: Add tests for RO pinning vs fork()

 mm/hugetlb.c                                 |  33 +-
 tools/testing/selftests/mm/Makefile          |   8 +-
 tools/testing/selftests/mm/check_config.sh   |   4 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 318 +++++++++++++++++--
 4 files changed, 315 insertions(+), 48 deletions(-)

-- 
2.39.1

