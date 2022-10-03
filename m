Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13D5F32F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJCP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJCP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE84C2CCBA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664812594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c+kdz5cc3NrJArhDY2JgimgASSW1d1LMZTKXqfIaym0=;
        b=HEt5J27PULF+xYKbuqsfzXr5JFagp9DzFuumogbkWsa5bHesqoRU8s5wlCp4uPxIXVVbAQ
        dAAd+8jCnybGrbwyFlkjYdM9B3mO3Qg+sZNdbcyKMwQOCVpbmfq/LUn1+oMHceqsn2KICE
        EX7LONde08hgYPeyUpwB6ZeeLRxgk+Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-HjfK0IK8PJeH1zrfLbaJkA-1; Mon, 03 Oct 2022 11:56:33 -0400
X-MC-Unique: HjfK0IK8PJeH1zrfLbaJkA-1
Received: by mail-qk1-f199.google.com with SMTP id az15-20020a05620a170f00b006cece4cd0beso9494402qkb.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=c+kdz5cc3NrJArhDY2JgimgASSW1d1LMZTKXqfIaym0=;
        b=YDjFWympkI15o/n5EjoT06FiZx53EiBmRTFhfhkRBikACH5K32wM4zDwzcN4ya/Am6
         XLgNI3sR+AG/3z3Ee+9OXdqsIL+efHq+9gvIqMhHt5Kciru+ZpC/sbXDUXkvW3vBEDka
         r/62h4NeBP9qs7SSilqLCiCOkJ7wpFvbCc807NW5HUGB2FHS4EkLrPn/6f+0HOeVpBGm
         RDyCgPm34U+rG3ynNVs3li0Xj6H0+dpU2o6NoGNhHhfXPYsSfhxbOv2tIDEkklul38x+
         DifrgNAMJi40qtJKDGnGCFBfVWvOay4oTz89qQlT720UWUNzaJoygAxS1kEs2nouF6r9
         5mmw==
X-Gm-Message-State: ACrzQf39MqSs9FqnpfqZzVQLOAKuTBL+1kx0f6YXiwkQQpgVVhGF8Iup
        RUS0H/fKG+GOv9RRzuvRQA7HD43xyLMS8ESacQYClG4A2XQZV1oHokXHUyziWCjzdNKkI+zwhHW
        lhQglFVS8i4NeklUr0c5IKtP4IGLJvmFuooUCkabwoYKfYQXpjxIdU1KmfxvBBjVQIlYpB4OYwg
        ==
X-Received: by 2002:a05:620a:1a8f:b0:6ce:7d4e:6bf8 with SMTP id bl15-20020a05620a1a8f00b006ce7d4e6bf8mr13686644qkb.349.1664812592986;
        Mon, 03 Oct 2022 08:56:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM772dQHPW6o9PwTFwZTSvMd0ETbKDy6p1qmmy6Hv9ZpUfc2C7s+ziRT/FDrpRICFT2iN9vS6g==
X-Received: by 2002:a05:620a:1a8f:b0:6ce:7d4e:6bf8 with SMTP id bl15-20020a05620a1a8f00b006ce7d4e6bf8mr13686625qkb.349.1664812592729;
        Mon, 03 Oct 2022 08:56:32 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006cf38fd659asm10956732qkb.103.2022.10.03.08.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:56:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 0/3] mm/hugetlb: Fix selftest failures with write check
Date:   Mon,  3 Oct 2022 11:56:27 -0400
Message-Id: <20221003155630.469263-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 mm/hugetlb.c                             | 62 ++++++++++++++++++++----
 tools/testing/selftests/vm/userfaultfd.c | 22 ++++++++-
 2 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.37.3

