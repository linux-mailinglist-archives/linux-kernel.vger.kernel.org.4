Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1B167EEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjA0Tow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjA0Tng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC901241F3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so6377360ybr.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VGgj1TmnjNrGwceq1Y9mwtgHdomU/ZJ3zMBBp7twvM=;
        b=kcxorgjDvieL4H0gsZ4o6ev4StdVYsVDA7GZVrIORQdjZKoFiGI1KoZQdzzvMshMrE
         snI0AzaYSvDLC9zEn2IBQumHO6CKLkrL/i3wJ9ueET6bm8oRn7QEPBX+BM7UODPO3hzZ
         U4MGRqXmViJMsS4HDNU6vnAmwplZNvnqe2D+qu3fGFBMwOJOM+QBc0aicDuQnfczJKX+
         vPW/+j1Kiez+csRZc1jn4fVsV2fgBwTNZpRX4guJZVX8gsy3dFik2ggDGPcziixMOIIZ
         ZlSkjqSVG2I0FEWcD7z9JqxBzo/zAlN1m8/Qkt+nlr6qzU3SYltCmGn1Rp59psmpvaAD
         Fzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VGgj1TmnjNrGwceq1Y9mwtgHdomU/ZJ3zMBBp7twvM=;
        b=3iK6K7ENcx0k/Repn0MSoWvvLTAkiaupoqzbJ2J0EsnnXLCAuzJqYfQQrRP6M7tcWS
         1+duRey7zR0EK6d4M6MIZf4HwWIlZNJUmHOrefqK4n3Zz+AsNDIoUJKbehzVNPUnic+f
         3GOCMoKT4NWQdH+wrdW5qF5ibSVguw3mP6gbZRUAr5loUpU2Tzq7B0zMguGvtOiEePq8
         OtpZKFfu2GGuy0MJloCPFF123Xb80fcWttjRiXSEJPQSPFYoDO7TJj2NwsjhbZdlm5je
         OPmP9dPsnFRqpYPaVKenngglK5pMLJ+RalIVjr89XF0ICpTBB2d0tw2mjemdF3QrtSYH
         LITw==
X-Gm-Message-State: AO0yUKXLeTr7jBoLd3GntH8blmAjJh47+3B5S/nKd1LE/QKrg0aZutaT
        NggF7seh9q3XZlgAWmAGbWxu5pS+uiY=
X-Google-Smtp-Source: AK7set/jPsOwzlm+kUPz+CABbySieLCP3cL/8jypOFocWiEQOE8fcbH4Z91B+4ltIKP12TkxYenF+FhrAT0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:cb8b:0:b0:50b:1b97:f19a with SMTP id
 n133-20020a0dcb8b000000b0050b1b97f19amr434148ywd.164.1674848522027; Fri, 27
 Jan 2023 11:42:02 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:57 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-21-surenb@google.com>
Subject: [PATCH v2 20/33] mm/mmap: write-lock adjacent VMAs if they can grow
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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
index 57cb3a2ac9b1..3baf218836bb 100644
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

