Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5D612D01
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJ3Va4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJ3Van (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC3A44D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agXgQWAuByPHwxJXo49Hx7hkR/BEQEXX5BlO+c7HbVA=;
        b=eULKnbz0iRds+nPlupkJyRMKYcVP+cp5maTyzQDLF5wNoXctbhkLXZD9j0LTMMVj5TsfXd
        fR9mu1TxV1yDf1GtxdfgdkUv/AjHxoeNsHTdUcUehxHI9fAUO7TqMKB0YsbM6imdWHXonw
        7qzTxx/IGWrnJcdxMEvS3aOEzhRmQCM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-42NyM1FaOu-uVp8XgLv4dg-1; Sun, 30 Oct 2022 17:29:39 -0400
X-MC-Unique: 42NyM1FaOu-uVp8XgLv4dg-1
Received: by mail-qk1-f198.google.com with SMTP id de21-20020a05620a371500b006eed31abb72so7984366qkb.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agXgQWAuByPHwxJXo49Hx7hkR/BEQEXX5BlO+c7HbVA=;
        b=Gows9Re9yfGoUNgITLJKKq60Ec3WWjKhyE3fESjCRJ1M4s+i/aAQWIsKberUYj02m+
         DOGeok46iH1gHOKw4v8adKiAu6DQfE0qsGNqg4r8CP6/5P+gBsHf7wYzFzpTUguXsvPD
         va6FSMEeILn2XkBa9+xcCR9D+vqqKt4qp6IRM/KG+ZUSr4J4aXmHqh8aw/799nf2oAnW
         h8pZYRPYObKXdjIgBnq41qnxfNq3Z1FfoMecFZUeMlMdsqLOiWqyeR9L9T96qlvEa/TQ
         /leSjIbXlIWSQ+/04O/YPu4pSNDDV9VN52ZtP5vLl9PksXy3YoT5P0U75xDn/UhZKqDQ
         wN1Q==
X-Gm-Message-State: ACrzQf2zJgP/O9MmPQG4x7Yy6Lafr9zaGGFzL0DuWdcPPWQYp4RDjG8A
        q3lKNajO/mAu7alBdYdmQ4iZ1XGrQFfnB9SzST84JjRawaA+5Xz+0qD7m1IuZdEKc3l55dcCHUK
        RIavErLnjYVUesKn+fVQF2JvJRegX0+FNsPGCUNzvmaEbkGLskhCW/0mddEY+YNMN/9H54p94sw
        ==
X-Received: by 2002:a0c:f0d4:0:b0:4bb:6583:66e6 with SMTP id d20-20020a0cf0d4000000b004bb658366e6mr8560482qvl.123.1667165379140;
        Sun, 30 Oct 2022 14:29:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7sce2XU7RtWq2xdMTQLA/Y2bdKWFb6WfMYU+Rxg+ddv0M5GF24IJZTzMXfQ4BlQlC1JXATQQ==
X-Received: by 2002:a0c:f0d4:0:b0:4bb:6583:66e6 with SMTP id d20-20020a0cf0d4000000b004bb658366e6mr8560462qvl.123.1667165378831;
        Sun, 30 Oct 2022 14:29:38 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH RFC 04/10] mm/hugetlb: Make userfaultfd_huge_must_wait() RCU-safe
Date:   Sun, 30 Oct 2022 17:29:23 -0400
Message-Id: <20221030212929.335473-5-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
References: <20221030212929.335473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU makes sure the pte_t* won't go away from under us.  Please refer to the
comment above huge_pte_offset() for more information.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07c81ab3fd4d..4e813e68e4f8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -243,6 +243,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 
 	mmap_assert_locked(mm);
 
+	/* For huge_pte_offset() */
+	rcu_read_lock();
+
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
 	if (!ptep)
@@ -261,6 +264,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
 out:
+	rcu_read_unlock();
 	return ret;
 }
 #else
-- 
2.37.3

