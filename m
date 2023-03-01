Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D06A6575
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCAC11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCAC1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:27:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A5136DE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:27:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaeceeaso251642447b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677637644;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/02ba9pKPs+xaeDNoqwdk3OeXtfhs3eb+vbTt5q+ds=;
        b=jwkVCM8M/VdQLhfCkuQxzR9SFY68aOcPkmEc06SJ6jbXq0SL8vhpoeNFFcc2FIMX4Z
         qOAOI7yp7551oLwvyh9mgMAkw383CXCX5b/h08MQxyDTWLFQM302VK4PCxZW4njJU5wA
         w8EcBp5F7o/S81X59PWPM2wdZuE0ddMRfvLTZfdeoGxlABs9nXf5/tfjdeYbhTyrLwWT
         e+FKJlhxrRgP+4+FF7t+gW+oCtxdSoeGJUiUlZqGApiO7FNDs2PJNRAhZDwX5gfdv5E5
         1eq6ilJ6KGu4P83kvjayRhSH9oLzyJQNHlvbOeaMFbtv/Mp7aqikHM/ZQ07xCIiTbr5t
         l13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677637644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/02ba9pKPs+xaeDNoqwdk3OeXtfhs3eb+vbTt5q+ds=;
        b=mgDo75/zF6I62CW6ecIa9lGI1UZ45ifgAPCcBYYTBnB/efq0h1Qc8XVxVprFgnmqTO
         yVRmhTNqmknne7yRSWvi+pWb/gd8Jdy/mFLIS7YYgUjI3BQ69eex0wk8FnAJXciTwwg1
         ShEz7EOhokRBDkErCmjh8LBqRne/SiznvYirBZ5XCQiTYFmg8Z/hkzystZP0z1Sbh6I1
         2/d8kNQX/RtJmhJm6pXIl9jGWD8aAB8Y2hGHplHPNgyUrFxARgDnIdiUaCbPC7jTWfCA
         E9wcPmDXrn73c2JirAYwulkG8a9IuUNNNdR1a7HnU+Z+alAzOFEcYvW5qkxnLrZIdNUj
         xx7Q==
X-Gm-Message-State: AO0yUKUH7SkxdD6hwUpU4dJy5DUsSP0laHZPJs4ODd78xXS4an5Wwlvx
        2tCM4Ffws8MV9bj6pVO0qisu/OMfbCA=
X-Google-Smtp-Source: AK7set+61/MW3yRA90mpctcsE10D/EizwukiJmPOyOpLJRZveGe/foy6L1qBI9eSafdW1SJNmwf3gt5vepg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:612b:820a:2225:ad82])
 (user=surenb job=sendgmr) by 2002:a05:6902:50e:b0:967:f8b2:7a42 with SMTP id
 x14-20020a056902050e00b00967f8b27a42mr2156872ybs.7.1677637644274; Tue, 28 Feb
 2023 18:27:24 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:27:19 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230301022720.1380780-1-surenb@google.com>
Subject: [PATCH 1/2] mm/mmap: remove unnecessary vp->vma check in vma_prepare
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, error27@gmail.com, willy@infradead.org,
        david@redhat.com, Liam.Howlett@oracle.com, jgg@ziepe.ca,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, surenb@google.com,
        kernel test robot <lkp@intel.com>
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

vp->vma in vma_prepare() is always non-NULL, therefore checking it is
not necessary. Remove the extra check.

Fixes: e8f071350ea5 ("mm/mmap: write-lock VMAs in vma_prepare before modifying them")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302281802.J93Nma7q-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Fix cleanly apply over mm-unstable, SHA in "Fixes" is from that tree.

 mm/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0cd3714c2182..0759d53b470c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -505,8 +505,7 @@ static inline void init_vma_prep(struct vma_prepare *vp,
  */
 static inline void vma_prepare(struct vma_prepare *vp)
 {
-	if (vp->vma)
-		vma_start_write(vp->vma);
+	vma_start_write(vp->vma);
 	if (vp->adj_next)
 		vma_start_write(vp->adj_next);
 	/* vp->insert is always a newly created VMA, no need for locking */
-- 
2.39.2.722.g9855ee24e9-goog

