Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9250274BEE3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGHTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGHTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:12:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A5C9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:12:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5707177ff8aso34878767b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688843539; x=1691435539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4rAZiN8CFc+wkQPvmF3sDwgaLYdtc/sQi/Gu45S9YQ=;
        b=rDyzKJgvSb4iVFr4MU6yl+skVCEaDOmrNnUTQxW2AR6lwndLcFZirFs7K8NVbOet/l
         Hz1ezj81fpfDhby24QFHC8W4yNrvRhOZmkRPzGk0HoDpmSzVRvUFh46uDhRrvrsHj0T+
         bWfsgAAuSrJUkxovFXIvpjT+3mNLViAPukrwkqTZEVh67uYSSdkV3/RB6xiSA1ML8ef8
         x4SI1Wv4IyWtXrra9hN2OOMwSs1hHi6cndf596Frps7d08xkQhXDxEudvyECcS4PhaDT
         YUU3z/ec3eCdOsvrUHORdE6FKycuZJ6n6CZZT2tr9aAc7ZTwuikUkUWUt+zO7jA28nYB
         wf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688843539; x=1691435539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4rAZiN8CFc+wkQPvmF3sDwgaLYdtc/sQi/Gu45S9YQ=;
        b=QXX4LDsyMF9TxM3mH3bQ0GBm5LJ7lo0/MS2N6tNL6Szl9X3sZ53ndEyyviKYTylEgn
         A4UjvuErYObgYfT+d8MkzQIHN8FGmEE2ErpI0UfMJlcpBq80oQZypxA+cPIij0nlZZv9
         K10OETkml4hc9YPeyRyPgjZt5ZMf1umIXboeIK3mQPHw6sEpULv0KjLy13bgDm3bAn7e
         bQLPMpY9R9ZiP5YxXjkRJptg1JG1t7bsTrn+e51Fy93+EXMMoVo38vWv0hqdtdbiOJ9D
         jhTsFaxaaU1pOd3yPvPM5QtY5wQHYb3G+tplpfBsm/7zEJDyXLP3AsTkWtw7B4U8Dkf1
         KuLQ==
X-Gm-Message-State: ABy/qLa2hTj7SYy6yYorGfwq3z/Q20M4Imm0eAygVj/rltBhSoNbiduS
        XHhBdKAyYZdwLupN0V5ANUDKYtDsS9Y=
X-Google-Smtp-Source: APBJJlHlFE3mHfSxux3qV7DD1eHyTN3Bj7OluqfqRLk3Ndt0avHOdBy2KrtMLyVg6El02lkP8km17cLgxIM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6f0:5193:79db:25b3])
 (user=surenb job=sendgmr) by 2002:a25:b05:0:b0:c24:7d1c:6145 with SMTP id
 5-20020a250b05000000b00c247d1c6145mr69068ybl.2.1688843538817; Sat, 08 Jul
 2023 12:12:18 -0700 (PDT)
Date:   Sat,  8 Jul 2023 12:12:11 -0700
In-Reply-To: <20230708191212.4147700-1-surenb@google.com>
Mime-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230708191212.4147700-2-surenb@google.com>
Subject: [PATCH v2 2/3] mm: lock newly mapped VMA which can be modified after
 it becomes visible
From:   Suren Baghdasaryan <surenb@google.com>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev,
        Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap_region adds a newly created VMA into VMA tree and might modify it
afterwards before dropping the mmap_lock. This poses a problem for page
faults handled under per-VMA locks because they don't take the mmap_lock
and can stumble on this VMA while it's still being modified. Currently
this does not pose a problem since post-addition modifications are done
only for file-backed VMAs, which are not handled under per-VMA lock.
However, once support for handling file-backed page faults with per-VMA
locks is added, this will become a race.
Fix this by write-locking the VMA before inserting it into the VMA tree.
Other places where a new VMA is added into VMA tree do not modify it
after the insertion, so do not need the same locking.

Cc: stable@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index c66e4622a557..84c71431a527 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2812,6 +2812,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
 
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
-- 
2.41.0.390.g38632f3daf-goog

