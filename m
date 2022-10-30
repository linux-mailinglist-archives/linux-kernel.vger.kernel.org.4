Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8E612D04
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJ3Vbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJ3Vbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59241A45D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcZdgMzXcUClzXwFwvMe9vX/XbvITV8H0Y6t4On5idY=;
        b=BvcrJES4j0nILKfC76UaCHTgFjMycDrDv6w+C8IYnKZ4GiscdDrMn5DoIPp4LnPjV269aJ
        TNtaj4tsazvYdg4yX38rIlXNAIFg5xuOfXWzbFpuZs0RM2StwfpUiueU6YnzgGp1V+umc9
        JAUSwPK7CFfnsHuhqM2Ou+fVRTtIwmo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-U_Hwj77VOKiPjB-qBt7nWQ-1; Sun, 30 Oct 2022 17:29:41 -0400
X-MC-Unique: U_Hwj77VOKiPjB-qBt7nWQ-1
Received: by mail-qk1-f198.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso7978019qkp.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcZdgMzXcUClzXwFwvMe9vX/XbvITV8H0Y6t4On5idY=;
        b=wNE2bsds37kZFN/8ELmdkj1XCw4gVEtqSw5PynUFxEKuMRKOBQOzN5jxVAKpg9Ohmt
         +GGFs0YosZJyzhPIKYFGHbVLLFxLKSGsDODqgji78UCF0H9zw2eIIbELIClPDcXKj+J7
         jHGmXa+Be1d7oQLhGjo0tUBVGLRkQVAr/EVB28cVimr+kH7aM6k/n3lyD+Nl5cPilYjg
         qqz38z/NGzhJ3TsRj4x8ZopsN4nUyCt3jib66k8q5jldQG5bLquY8htA/nL9w7qv9Eow
         LO0+a2ye4OKvu8XreLf8DzMkN9dbxB/YGzxPh8hXm0U9VlChPaqBl58FlABh0vkBJEuk
         e7Vw==
X-Gm-Message-State: ACrzQf1TQTQAAvE0dOzp2A2eOgb2dM4EyoHZbaAm+QECb/Pc6CavpqqS
        7EI/KIk4JdZHqVAZwdLADjUCpS6ZZpq6wtV2IKu+7nkOenLT3wo+ga4eTBbRVt32k2RP/2HlA+k
        appNSnWYmfti+io/mNR93+xR2SvhgRxDSWZSSKKLYYTOxbAJVmiFT32M26sE00iXZQDmeci2o9w
        ==
X-Received: by 2002:ad4:5c4e:0:b0:4bb:9fea:f52e with SMTP id a14-20020ad45c4e000000b004bb9feaf52emr8476681qva.51.1667165380631;
        Sun, 30 Oct 2022 14:29:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ZnJZXvFuDX4rJ/LrVQdDYcAIkIRly/xQ0vtJY1Rg+h8deNRU6tueG0RHxG/wRYLRwm8iB2w==
X-Received: by 2002:ad4:5c4e:0:b0:4bb:9fea:f52e with SMTP id a14-20020ad45c4e000000b004bb9feaf52emr8476659qva.51.1667165380375;
        Sun, 30 Oct 2022 14:29:40 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:39 -0700 (PDT)
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
Subject: [PATCH RFC 05/10] mm/hugetlb: Make walk_hugetlb_range() RCU-safe
Date:   Sun, 30 Oct 2022 17:29:24 -0400
Message-Id: <20221030212929.335473-6-peterx@redhat.com>
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
 mm/pagewalk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 7f1c9b274906..bbc71c750576 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -302,6 +302,9 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	/* For huge_pte_offset() */
+	rcu_read_lock();
+
 	do {
 		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
@@ -315,6 +318,8 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 			break;
 	} while (addr = next, addr != end);
 
+	rcu_read_unlock();
+
 	return err;
 }
 
-- 
2.37.3

