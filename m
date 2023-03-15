Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB06BBAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjCORRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCORRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3797685B28
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678900607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zvezbU1ptkdFZAvuDb0blk+QkhG0CCjoFIruzUfPyhk=;
        b=OJ2Z0bs9vHAAZ77ikwrTUxrjhZqbnIt7PmT5+XrPo4PiX7vUA1hLM9gGYi06w9Ry05zXpQ
        2rgCWS7DqiZ9mVUFqvMRSFx36p0dqk6dkdU7CHI46AjzXLMp6Nud1p+/QMxoPzXFmf7ppr
        6qqLN6Qw9s50p69J5SSFZdnWunXS+W8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ONWlgepKPtSPe9P08OrRGQ-1; Wed, 15 Mar 2023 13:16:46 -0400
X-MC-Unique: ONWlgepKPtSPe9P08OrRGQ-1
Received: by mail-qv1-f71.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso5784368qvw.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvezbU1ptkdFZAvuDb0blk+QkhG0CCjoFIruzUfPyhk=;
        b=X7NNeED58uE5QS5mws90mMsUAD5obU5k7Ucg4K48Rx/CpmCHFyORlhTrHxkQhPUbaj
         O1iwavDzAK+qhEI2sGByemxNB0UpF4kSbWW0XVTPUi+x+WeEncQIo5w1JiRFuQhpIecK
         5HgxGMwUsO3ILNNYa5qniGCDBd05k2B+js2JnkzlbRrUYVbdjsk9NYYKh8kdHZYjd96a
         GSQobsWgSHYsF0M/feVUQeB6O7zXvZQrS74xzWzjysACtAkCHH62cJz9lf0D1ymULWhm
         E5ZyszecQ8/KPF1jwcb0Iq/Z2a1rBQmaWFk6T0YbDA1g11dtQm09o27fTKHcL0lXJMP0
         lGyQ==
X-Gm-Message-State: AO0yUKUMNMwCtqG7W6RUu+dYWkTx2Of11wp4bAY+uJEgMsZ8xmebcNhQ
        ZJXX/MKmaROf+z9BLjfqQfmFtpcEx2Hemn8aH8YO59okVAss9OLY4h1zUJj8crJpv8IZfzplRa6
        P8PsOGQ8PNqLcb/G0wO88A0j45hxw9RSrIyrcSANSjeenXO/g9u3KiiwF7iuszaQNUwYgWRd2XN
        CAKZ9X0A==
X-Received: by 2002:a05:6214:1c84:b0:56c:d9e:c9a0 with SMTP id ib4-20020a0562141c8400b0056c0d9ec9a0mr34426352qvb.1.1678900605200;
        Wed, 15 Mar 2023 10:16:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YRHSBI5uUIkKGKAACcKTfkMve3FmPCkb+zky8sTaHDcPuoOWo3g2xqNgdKMa02gE2SPiFmg==
X-Received: by 2002:a05:6214:1c84:b0:56c:d9e:c9a0 with SMTP id ib4-20020a0562141c8400b0056c0d9ec9a0mr34426317qvb.1.1678900604835;
        Wed, 15 Mar 2023 10:16:44 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 198-20020a370acf000000b007424376ca4bsm4065432qkk.18.2023.03.15.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:16:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH] mm/thp: Rename TRANSPARENT_HUGEPAGE_NEVER_DAX to _UNSUPPORTED
Date:   Wed, 15 Mar 2023 13:16:42 -0400
Message-Id: <20230315171642.1244625-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
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

TRANSPARENT_HUGEPAGE_NEVER_DAX has nothing to do with DAX.  It's set when
has_transparent_hugepage() returns false, checked in hugepage_vma_check()
and will disable THP completely if false.  Rename it to reflect its real
purpose.

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Yang Shi <shy828301@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 2 +-
 mm/huge_memory.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 70bd867eba94..9a3a3af2dd80 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -79,7 +79,7 @@ static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
 }
 
 enum transparent_hugepage_flag {
-	TRANSPARENT_HUGEPAGE_NEVER_DAX,
+	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
 	TRANSPARENT_HUGEPAGE_FLAG,
 	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b0ab247939e0..913e7dc32869 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -88,7 +88,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	/*
 	 * If the hardware/firmware marked hugepage support disabled.
 	 */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
 		return false;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
@@ -464,7 +464,7 @@ static int __init hugepage_init(void)
 		 * Hardware doesn't support hugepages, hence disable
 		 * DAX PMD support.
 		 */
-		transparent_hugepage_flags = 1 << TRANSPARENT_HUGEPAGE_NEVER_DAX;
+		transparent_hugepage_flags = 1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED;
 		return -EINVAL;
 	}
 
-- 
2.39.1

