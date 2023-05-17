Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124F270718F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEQTKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjEQTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B1993CA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684350566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iN+jv8msY1qYvEsq3XmStz9lSIVf2EzEiCXgZiX6HJw=;
        b=KgLxnzeZY+W5HaBEm/0wzPd2ALK2artPQSTq6KYZxa/2koPZi8vJEdNyrJsM7R+X4vCdoo
        vp9UqFtGYYRwPkW2Pto3cdFbYEaQG2oRv6Kg8VsPxBf74/TW6eu542lpxvZi+hGt+QiLn6
        KfzBb3Mom66d749nwDBeaQUL71sEHMI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-46-WjkqdNkC8wi2jzFmZ7Q-1; Wed, 17 May 2023 15:09:25 -0400
X-MC-Unique: 46-WjkqdNkC8wi2jzFmZ7Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62387ccd3bdso1582316d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350564; x=1686942564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN+jv8msY1qYvEsq3XmStz9lSIVf2EzEiCXgZiX6HJw=;
        b=ePb2itYHjhdiSJgSbBNFWFaunHoN88DMXznxPVxoOs9eZnQger4qa3RkJBKBi17nLo
         ThWjA67Tk4YkY9d+IQSD+CMbX6VFUZKBXbdBGNEEJUgs/IIImx2UmSLsjDmzgl/IQT5W
         ++PyAelYam6lTAsgFTiYw7l/rL13OOqcZKgZsfpUiDa5E7/t5K80b2396q0tKSCPWbjc
         +4Y3a8icvSU7mAL9wlRgJEjrFjE1J6er8NPI7WUgvdj1dP6/50rU7HDAdcLv/1PjETPy
         eOGFXdnWOgGn1vKycjYnHxuOSFaafGu2Y8XTLIZSTfnazx0kRenQJ/wSWU3STuBRaVWL
         2z6w==
X-Gm-Message-State: AC+VfDzSKC6w/IQ+GMY2umnInQtIq+cudOQZePWmFCH/TANYGtD1ko7P
        9+hGMu5FlrS/qf7a9YtnNx7LKU2G2mXw4+wkBF5YWlXNJjt3au0JKhMr+GGXaPwhCwyBfxMjS38
        2l0ZkWOphRyadWNddmT3GOkm99+q0oYJBZ5giT/5TqrOB4JMsf6DpVQ/A3Ni7N/CNgpPoOYPBJ+
        nyA1NNfw==
X-Received: by 2002:a05:6214:c2d:b0:61b:7115:55a9 with SMTP id a13-20020a0562140c2d00b0061b711555a9mr7053406qvd.0.1684350564449;
        Wed, 17 May 2023 12:09:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5P+JGEIsxWMcDTyGW5MOqVSCkIOibsvYLwKde5Ar0gJAeQXW0Wox1vONWp1UZpJXyF/cU+Xg==
X-Received: by 2002:a05:6214:c2d:b0:61b:7115:55a9 with SMTP id a13-20020a0562140c2d00b0061b711555a9mr7053354qvd.0.1684350564106;
        Wed, 17 May 2023 12:09:24 -0700 (PDT)
Received: from x1n.. (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a143500b0075954005b46sm833464qkj.48.2023.05.17.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:09:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] mm/uffd: Allow vma to merge as much as possible
Date:   Wed, 17 May 2023 15:09:16 -0400
Message-Id: <20230517190916.3429499-3-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517190916.3429499-1-peterx@redhat.com>
References: <20230517190916.3429499-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to not pass in the pgoff correctly when register/unregister uffd
regions, it caused incorrect behavior on vma merging and can cause
mergeable vmas being separate after ioctls return.

For example, when we have:

  vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)

Then someone unregisters uffd on range (5-9), it should logically become:

  vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)

But with current code we'll have:

  vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)

This patch allows such merge to happen correctly before ioctl returns.

This behavior seems to have existed since the 1st day of uffd.  Since pgoff
for vma_merge() is only used to identify the possibility of vma merging,
meanwhile here what we did was always passing in a pgoff smaller than what
we should, so there should have no other side effect besides not merging
it.  Let's still tentatively copy stable for this, even though I don't see
anything will go wrong besides vma being split (which is mostly not user
visible).

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: linux-stable <stable@vger.kernel.org>
Reported-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 17c8c345dac4..4e800bb7d2ab 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
 	struct vma_iterator vmi;
+	pgoff_t pgoff;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1484,8 +1485,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
+		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
+				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
@@ -1565,6 +1567,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
 	struct vma_iterator vmi;
+	pgoff_t pgoff;
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1667,8 +1670,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
+		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
-				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
+				 vma->anon_vma, vma->vm_file, pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
 		if (prev) {
-- 
2.39.1

