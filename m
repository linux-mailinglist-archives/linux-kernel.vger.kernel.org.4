Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3A6D82D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjDEQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjDEQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A255583
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cYaKGp+t2zLM3SXwrmYC1WhmJ28+tinYlXREE/5gPFI=;
        b=EuG0CgBMvpYtOwSYhH2z4dDGrAblj2E3rkXfEHhE3zMU8KFQ8AbTQFY6Uzre+sQrDu8JfJ
        aw/vRjFZsG6b3P/E9ku+b/neduAGKXWO017d0xTcvNLMNLIgYFdBm9NYG1k+iIHdyKN0jA
        n1xzRexZKhYUH0yoPfPZYJEKRgF9TmQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-67cLjWAMPhe2Q8XOKifa8A-1; Wed, 05 Apr 2023 12:02:40 -0400
X-MC-Unique: 67cLjWAMPhe2Q8XOKifa8A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4530280A321;
        Wed,  5 Apr 2023 16:02:38 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53276492C14;
        Wed,  5 Apr 2023 16:02:37 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2 0/2] mm/userfaultfd: fix and cleanup for migration entries with uffd-wp
Date:   Wed,  5 Apr 2023 18:02:34 +0200
Message-Id: <20230405160236.587705-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One fix and one cleanup.

uffd-wp migration entry handling for PTE/PMDs should now be fairly similar
code-wise.

v1 -> v2:
- Add RB's
- "mm/userfaultfd: fix uffd-wp handling for THP migration entries"
 -> pmd_swp_uffd_wp(*pvmw->pmd) -> pmd_uffd_wp(pmdval)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>

David Hildenbrand (2):
  mm/userfaultfd: fix uffd-wp handling for THP migration entries
  mm/userfaultfd: don't consider uffd-wp bit of writable migration
    entries

 mm/huge_memory.c | 16 ++++++++++++----
 mm/mprotect.c    |  2 --
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.39.2

