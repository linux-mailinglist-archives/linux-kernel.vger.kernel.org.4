Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E526A483E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjB0RiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjB0Rhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F406D23C6D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaeceeaso152728337b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWwKpXjDg6WAvmp/os9+Adpl/ccsxZtoSX3Q5XOWyQ0=;
        b=QlvGB3sbxoYWlBS31TzcGu38FuNf7Lhjhtq2VlYCxWOSVfHgnAjaRBrb1w97aEacbe
         K6advecLicCSUfFEo9GDjw6ni0z0vYUO24YPFOrOT6PGrUxiFDeAMZRvmYa7tXn8nDcV
         jQQpuW50daFJ8WQmqyVE7pXe4jO0h72Ly1mymbXPSaJk3hcoxxEHUhmsYcU7Utdafwgh
         EoU7EkscyBq5l+R+tPrIdVU+apzyZHKYcAM5J8frjMBd1EpUZg/bzw2FKzGiNCJc/yPF
         OX60CUqczCC42EwMz0GH4Ohwd96NL51ADp4JavDsEQkoG6zGf4C60SM+ihxfLXuX3u7Q
         RNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWwKpXjDg6WAvmp/os9+Adpl/ccsxZtoSX3Q5XOWyQ0=;
        b=4o+E/0g2Oyp+ew3ttUiBvTYM9VT3pMVc7AvXhTHizVAuG8jPhGFEkfv79wKMHZ21ht
         py0Gz9UGlGOYz5jUGOjIQ8EiC3+jXJJHqlv0Ji1pjXJDx3/KjJp+48MzE/CBUaeHMYOK
         mKD700F9WsldZWoiQJFhnlfTsXcByigqheZleyxN3+sTyiEA98eSo6O2KSKVPifX2J6q
         JPB1/RNzYMjwDsUkCp48HtntUtvWQUfZYrVKNyLsZVNT46456fzROzlzBJlRuioBCIJb
         9sqzp9TwUh+4c39YnAck8mhB8mfh5lDKg8c4T4IMbUUHz11+G6vOaB1Ka/ZEOIdv9Jux
         TSEQ==
X-Gm-Message-State: AO0yUKXgx4Mjdmdnk24O4IRhWE1ATbSHy0fBU0o70HW2w5tAshtjFiCM
        7o1Mg7BrrSFpQz7bWCFfEcv9UOdj2ls=
X-Google-Smtp-Source: AK7set/Ab7tdetucxhQI7Y0d4CepnVZrRoikg6zNi8DSW4Q8ICogb5HvJ+8Ost/w6wLIBwUIyCkVrkJznGc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:6902:10c:b0:a9f:3ee4:51a0 with SMTP id
 o12-20020a056902010c00b00a9f3ee451a0mr10ybh.505.1677519437283; Mon, 27 Feb
 2023 09:37:17 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:16 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-18-surenb@google.com>
Subject: [PATCH v4 17/33] mm/mremap: write-lock VMA while remapping it to a
 new address range
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write-lock VMA as locked before copying it and when copy_vma produces
a new VMA.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 mm/mmap.c   | 1 +
 mm/mremap.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index e73fbb84ce12..1f42b9a52b9b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3189,6 +3189,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
+		vma_start_write(new_vma);
 		if (vma_link(mm, new_vma))
 			goto out_vma_link;
 		*need_rmap_locks = false;
diff --git a/mm/mremap.c b/mm/mremap.c
index 1ddf7beb62e9..327c38eb132e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -623,6 +623,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			return -ENOMEM;
 	}
 
+	vma_start_write(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
 			   &need_rmap_locks);
-- 
2.39.2.722.g9855ee24e9-goog

