Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90D574A9EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjGGEcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGEcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:32:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B717119BD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:32:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704af0e64so16481407b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688704335; x=1691296335;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZ6z8dQsy+feCMa6mHLv7bXXJoh0AFryfACo+v22y/I=;
        b=Gwtq/b9i6ROYeVk/l2zLnMZzShNECphjVgRqvWJv5OGn+qPgDf0aYOccyWRYQYFvoe
         a7kkq7Xd+cJ5Yl1sqH5mEwr1FQQ5mDvqjjOvtUPlT/znd2rFs7Pck6McGti6M/rVA24s
         llLvscQ9xrZVeoRLucl11LU6f6n6b0Xa29TjReH/+Gm/F3SrGIpra5wV33NUcvECjY3b
         edvx0fZJHvb/lQFLmDlwXRw3XoweSUsN7MydjcGTLSgxwpx2SVLkOc4pe3ecCewVkym6
         3owTws6qa98ajMMWF0iXsyo8KL9j5OzHAPnkMl9JjHL2TyBxof/pLt96lGmatkHdhHzc
         zIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704335; x=1691296335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZ6z8dQsy+feCMa6mHLv7bXXJoh0AFryfACo+v22y/I=;
        b=mErcT84tWlJw4WGle7CidaQeUpnUw0j0+8T+45vLpFQZimkGM1MzivemaoXHvSZ7Ss
         DXOJhavzEI+A5Y7PqseyipUren8PrYhuXZuBS2tvOoJZnqlSvTno3Gw1r/YvJoQdj6ZW
         ZLGTxpvNUuLsoIYlBml9dyFM0Q6SC1et5ICknXa9xRZyHiRp4hYvpKE3zo7zYSQGf6ES
         ARm8N4wB2MwqCva49r8OFY2hbmbuzo7B2R3BCffWDfhOHkPBNLjF4H+lHaV0Oz0gkmJn
         Jlp5GLVjYpRLQ8lsw1TJvyHXz7SwMzjvPmf7N1Ax42YdScQj9esCs2fKkO/tDGjiBOov
         WGYA==
X-Gm-Message-State: ABy/qLa4LFOAkivFiEnaj6NDWhFmWkt6a2hQJ5laBUVXGbC/ez1zoj4O
        0QUCIBhGMrrJ9DIxF3SRQckbGW8Nzw0=
X-Google-Smtp-Source: APBJJlFkYEJCxhTy7hdsK2AY5aTIGyzLomxQxPwMN23ZBPHY8N4SuK35j+IjBDaJ4zJACbfSU1q2dNs4+C8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:fd8f:e174:8bb4:814])
 (user=surenb job=sendgmr) by 2002:a05:6902:508:b0:c4b:6ed6:6147 with SMTP id
 x8-20020a056902050800b00c4b6ed66147mr43761ybs.9.1688704334865; Thu, 06 Jul
 2023 21:32:14 -0700 (PDT)
Date:   Thu,  6 Jul 2023 21:32:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230707043211.3682710-1-surenb@google.com>
Subject: [PATCH 1/2] mm: lock a vma before stack expansion
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, ldufour@linux.ibm.com, hughd@google.com,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        rientjes@google.com, axelrasmussen@google.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recent changes necessitating mmap_lock to be held for write while
expanding a stack, per-VMA locks should follow the same rules and be
write-locked to prevent page faults into the VMA being expanded. Add
the necessary locking.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 204ddcd52625..c66e4622a557 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1977,6 +1977,8 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		return -ENOMEM;
 	}
 
+	/* Lock the VMA before expanding to prevent concurrent page faults */
+	vma_start_write(vma);
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
 	 * is required to hold the mmap_lock in read mode.  We need the
@@ -2064,6 +2066,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		return -ENOMEM;
 	}
 
+	/* Lock the VMA before expanding to prevent concurrent page faults */
+	vma_start_write(vma);
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
 	 * is required to hold the mmap_lock in read mode.  We need the
-- 
2.41.0.255.g8b1d071c50-goog

