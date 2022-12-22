Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37480654792
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiLVU4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiLVU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC41C916
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671742518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qcDRS9Sce9ANj40wLqgQKKpvrIhr1uJpBf+ytEcZupg=;
        b=IuO8X1SHUxOcs/LckNhMnnTV9RhMYdaHxaxVA3ui2TE4CEPWg22QOexdCaWiaj3EUlC4dc
        zj7UBNryobFoaxKYCeSU938/ly0TjyyDwqJj11yqip1EpyHsIZKJD1rTG9xEv2ZsX+pfdc
        VRbFd8kgYN2UVPhDZT2wZES00k/Lir0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-zkxOB09qPE2IQI9M8lcv7Q-1; Thu, 22 Dec 2022 15:55:15 -0500
X-MC-Unique: zkxOB09qPE2IQI9M8lcv7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08AAD87A383;
        Thu, 22 Dec 2022 20:55:15 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D45D340C2064;
        Thu, 22 Dec 2022 20:55:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v1 0/2] mm/hugetlb: uffd-wp fixes for hugetlb_change_protection()
Date:   Thu, 22 Dec 2022 21:55:09 +0100
Message-Id: <20221222205511.675832-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Playing with virtio-mem and background snapshots (using uffd-wp) on
hugetlb in QEMU, I managed to trigger a VM_BUG_ON(). Looking into the
details, hugetlb_change_protection() seems to not handle uffd-wp correctly
in all cases.

Patch #1 fixes my test case. I don't have reproducers for patch #2, as
it requires running into migration entries.

I did not yet check in detail yet if !hugetlb code requires similar care.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Miaohe Lin <linmiaohe@huawei.com>

David Hildenbrand (2):
  mm/hugetlb: fix PTE marker handling in hugetlb_change_protection()
  mm/hugetlb: fix uffd-wp handling for migration entries in
    hugetlb_change_protection()

 mm/hugetlb.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

-- 
2.38.1

