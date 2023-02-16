Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B687698BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBPFUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBPFTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931636FC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n20-20020a25da14000000b008fa1d22bd55so840318ybf.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zeEKIs6RouZ3NeHI7ZJ8m5Jmv1yLdTyFBRJo2pt5tCE=;
        b=Hd3NZlonbpCzy5K7Z5feVeMneevLupNr2wIBk8xrF2F0FeVHuTW7v0p8Iwz465OudO
         Kz/cwziHnFST/NwsyYv9H1NpjXxfHSGLxO5ukc+3xsoPYXaSl8+RA3RdmvmM4fbLpXN9
         gimJ3OxJZ4Ep64JmtioAuz7PGMRMavPtJuthlMhEIfRvRDzYwwXEt+kIY/UhQ/1ohnXV
         Mp7Yg73p6F/OdwNe1qmUkwSe8yYAoyBy/8c1r/0Zsdj45B+B6DEhDKlW7MvfqHG54uOt
         TWogzsTy9UemTUaeFAzTdpALJEgq+fwHHnoe+QVimQT+Dp4bg9S2kMJXbPj9+Gb2VnGT
         o48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeEKIs6RouZ3NeHI7ZJ8m5Jmv1yLdTyFBRJo2pt5tCE=;
        b=FV5sNiMFzNHCNtvK23N/vPhSa88H749KUN2uP8iGhzQx7K+wYFs1fqloQJUvbcXwwg
         R6OKWNFPaTzj3aQ2TYOncfxBOFMPMgNgy26wQgmT1raRUN6gkZDZsu+ISTS/H0Z67FfD
         y//3p7Ht8NcQcJOsE0R5EKGDQBbSVAmN5Jp5V/fIvBJFu7WIKaMjqfJeR/XbsZ3ugZ9O
         Gf7cNJgPhJhHE/ssF9UCDaxtENN77oeH8NbNvBolB80oYXxW+QFw3sgRU+bDxqDmkptv
         Y19RdCjRxtkZZRhGP3oFjspef3lPMMBzFiMjQ+Cl8BTrRAWDnCYOqQo8/9RKAG8c+PBs
         lGKA==
X-Gm-Message-State: AO0yUKXXbwg/WF7QEdet7cIP1MfWQvGumGsRur2t0XDBnuXUE5A3xB82
        /BFlWIVTGqFtpiO7QVMvyvvaD8FvLws=
X-Google-Smtp-Source: AK7set9EG6pwKD6Qe8/WGqDgk7Um8RE2RvPxkguhsK1CKP8nzrHSAEE/Znnb7/ves5IDs/PTEla86+djibg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a5b:604:0:b0:859:2acc:deb6 with SMTP id
 d4-20020a5b0604000000b008592accdeb6mr561571ybq.79.1676524725671; Wed, 15 Feb
 2023 21:18:45 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:36 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-22-surenb@google.com>
Subject: [PATCH v3 21/35] mm/mmap: write-lock adjacent VMAs if they can grow
 into unmapped area
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
        Suren Baghdasaryan <surenb@google.com>
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

While unmapping VMAs, adjacent VMAs might be able to grow into the area
being unmapped. In such cases write-lock adjacent VMAs to prevent this
growth.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 118b2246bba9..00f8c5798936 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2399,11 +2399,13 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (next && (next->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN)) {
+			vma_start_write(next);
 			downgrade = false;
-		else if (prev && (prev->vm_flags & VM_GROWSUP))
+		} else if (prev && (prev->vm_flags & VM_GROWSUP)) {
+			vma_start_write(prev);
 			downgrade = false;
-		else
+		} else
 			mmap_write_downgrade(mm);
 	}
 
-- 
2.39.1

