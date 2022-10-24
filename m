Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202160BC26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiJXV2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiJXV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B91132248
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666640023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZ8v+EwY2bNX8aSl1hAi5ZLb9PPb9KwOp7fvuUkZC2g=;
        b=XfRf4UmJmSNh4Xrfh1qQrn7WP5b7ZAiIjSyiDWpIP2u4k83eyi5cE/Bk3sA6jErLTcZljz
        VvwCFPUhts6OplzTubrMUA+jy0GjkOZ/Ho1emUv4HAX1gQ5U8KsF7d0h3ply8/RW9/ytzi
        uScTBpz7DJpxW+YuQ2PMsK8pVu8v6Vg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-348-B-dJxrEsNzKYDqn1yCJL5A-1; Mon, 24 Oct 2022 15:33:41 -0400
X-MC-Unique: B-dJxrEsNzKYDqn1yCJL5A-1
Received: by mail-qt1-f199.google.com with SMTP id f19-20020ac84713000000b00397692bdaecso7723500qtp.22
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZ8v+EwY2bNX8aSl1hAi5ZLb9PPb9KwOp7fvuUkZC2g=;
        b=6KpigDMYt6s9qpd7QcM4tMAkjbCo9EhsO+8/MoiRRZ+jtF0L207QKKUQUWpxe4fAcw
         C102M86DSVaVSEftD1eiNzdE94eV5jBwsAuPBhtV9Zx9UsGpM3bN9rqNTIgdf/RTRFYB
         e1T0uRh4j8u5yaA7tr8dRKzkF1m4Nqt2uWzG3YN7QgovrS9ihn3eaTlzion+j2pQiWUr
         FR2JJ8Zr2FFOgU8hA8lcf1WKDqVfA+RCtIDUDS9gXEVbnHwPkONmaXJaoLaKmUYdVf8x
         KQpKnh0cE2qvRQWWN0wlkXsJ9YPtlH3YYmYxU8Ilset/W09hg55MSfkxTA5n+3mErKsY
         JUHA==
X-Gm-Message-State: ACrzQf2V/+OCm1AooDTRnUd77KJmk1eE7o+y5+UIYnwXQZu4DLmkskit
        euedzl8CQEOijkkkA0dF1QhjlBtf9FG6WmtRltuvICdjUCEZlVG7gDxIuuRB5gnsOMxqWZ2KbYU
        WgWznj8ac4G6QTmerOCGPaxeN
X-Received: by 2002:ac8:5dd3:0:b0:39d:1847:872a with SMTP id e19-20020ac85dd3000000b0039d1847872amr18544501qtx.645.1666640020369;
        Mon, 24 Oct 2022 12:33:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6yZixs/k9ipGQk+YxOWJ1akEpX25bTl/zf3AiVYxllzKHCwgi54KXtb6GwKtr88nUataLr5Q==
X-Received: by 2002:ac8:5dd3:0:b0:39d:1847:872a with SMTP id e19-20020ac85dd3000000b0039d1847872amr18544482qtx.645.1666640020135;
        Mon, 24 Oct 2022 12:33:40 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a450f00b006cddf59a600sm545164qkp.34.2022.10.24.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:33:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 1/2] mm/uffd: Fix vma check on userfault for wp
Date:   Mon, 24 Oct 2022 15:33:35 -0400
Message-Id: <20221024193336.1233616-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024193336.1233616-1-peterx@redhat.com>
References: <20221024193336.1233616-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have a report that pte-marker code can be reached even when
uffd-wp is not compiled in for file memories, here:

https://lore.kernel.org/all/YzeR+R6b4bwBlBHh@x1n/T/#u

I just got time to revisit this and found that the root cause is we simply
messed up with the vma check, so that for !PTE_MARKER_UFFD_WP system, we
will allow UFFDIO_REGISTER of MINOR & WP upon shmem as the check was wrong:

    if (vm_flags & VM_UFFD_MINOR)
        return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);

Where we'll allow anything to pass on shmem as long as minor mode is
requested.

Axel did it right when introducing minor mode but I messed it up in
b1f9e876862d when moving code around.  Fix it.

Cc: Axel Rasmussen <axelrasmussen@google.com>
Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index f07e6998bb68..9df0b9a762cc 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -146,9 +146,9 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 static inline bool vma_can_userfault(struct vm_area_struct *vma,
 				     unsigned long vm_flags)
 {
-	if (vm_flags & VM_UFFD_MINOR)
-		return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);
-
+	if ((vm_flags & VM_UFFD_MINOR) &&
+	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
+		return false;
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
-- 
2.37.3

