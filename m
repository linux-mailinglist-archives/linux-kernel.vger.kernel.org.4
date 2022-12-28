Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17D5658673
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiL1Tm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL1Tm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:42:56 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42B1165
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 11:42:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-434eb7c6fa5so184197287b3.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h66ZlJIW0sPnpY7cABzav3ob2j9zOJpX5LkgC0xA0/8=;
        b=ZmaFVF7jonGinSfOfqJLrvexRkxJcgPqsnKMM2BWGIh/BVHh7PqXo08JdBFt3JvzDT
         MtFcfUdyqDiaFCLySq0/hKOSrDV1GcyYBXtmNsEtbbs0AD5T4KILU972sTh9LBVzvylG
         tQ34yld8u16qX7XcANjKxhlHCij158UtIOUP/9gRAC7H35s/1sJXhDZT3sMLn3/tZhV7
         aWcN73j9+nlL33mr6ie5dvAYJUjVKshl6AviGRMeNglXhoCBBVDSmhZzyQClFEryL6aG
         E8UwArx1nYdxTy3CYrwtb/ObqUZ8XeDEoelJ/4aWBtjKXZWtTcThztS84KOf7idyfQVd
         fSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h66ZlJIW0sPnpY7cABzav3ob2j9zOJpX5LkgC0xA0/8=;
        b=xtKEwWUPNOyz6qLjjpyBrSjcA3HO/XRIIxg4LpG7cPwhjIOhS/Ms2Rn+7k96fNOc59
         IF2KbbR/KQt6Kv+VqcM8AaJC0CT2kaVIpiYFRF0iuVegZkM8WYS8ldXCt8tV1Ldj7TZC
         u8G7FCDezZ1IfNh4J8nGCpUCxsMd5jcV5pBovea3WKMLcZAta7QNh64kdcK650+UbBL/
         E3AC1Nymor7/vbkJmYvyzL/+MQfQxUoL431vQl3Umm//873ttMm5TTdSjAwveBtyjl+X
         Hj6UM4SILeRA5/JaPLnk32COUl7S/bq6xRUJsrpS/3uEWcWboHXyNbMRd2wQjLZRD5Z3
         G6mA==
X-Gm-Message-State: AFqh2kr/VIjlOYycfaLeFiMslH9p7b8cbitRM62l3tpmAcPie7HN9nwI
        QfAxUM3J9rM2P4H+JXvFsmSibsiwd1A=
X-Google-Smtp-Source: AMrXdXvVoybg1IWCnNxBiUrrq4mqKVmvhjCYdrsqR+1uBXDBxNLu6NltWyq75pQsNEPLUw321kk56Lsqvsg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:77b8:ecbc:954d:4461])
 (user=surenb job=sendgmr) by 2002:a25:d496:0:b0:70c:4fa3:2cce with SMTP id
 m144-20020a25d496000000b0070c4fa32ccemr3787363ybf.539.1672256574382; Wed, 28
 Dec 2022 11:42:54 -0800 (PST)
Date:   Wed, 28 Dec 2022 11:42:49 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221228194249.170354-1-surenb@google.com>
Subject: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous shmem VMAs
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     hughd@google.com, hannes@cmpxchg.org, david@redhat.com,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@Oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        surenb@google.com,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
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

free_anon_vma_name() is missing a check for anonymous shmem VMA which
leads to a memory leak due to refcount not being dropped. Fix this by
adding the missing check.

Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_inline.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e8ed225d8f7c..d650ca2c5d29 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	 * Not using anon_vma_name because it generates a warning if mmap_lock
 	 * is not held, which might be the case here.
 	 */
-	if (!vma->vm_file)
+	if (!vma->vm_file || vma_is_anon_shmem(vma))
 		anon_vma_name_put(vma->anon_name);
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

