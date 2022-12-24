Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C616B655915
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiLXIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLXIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:12:20 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01DDF3A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 00:12:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l63-20020a639142000000b0047942953738so3502691pge.15
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 00:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItQBUrV0EvZiYOjtPn9RtcHJwdM5uCOC63vNEO/Cgn4=;
        b=IQNrJhCRWbch37b0zxiQ63klwB/GGCz0T3Ti+BnTbJFnWDAuKxZuxygKiPLeM+O0AR
         w/T2lFf+mrPfJE/QEm2dA04gLVnrUB0sjvh4mOGQ0L26Qki+z+qwi+gk41DAtyORCPyd
         xTjFieSO7GBH4ut5SB0J3jEXfQ7FMh3pxSwPoz/OHCGFw8TSmZKZxwP/JCiLOnektegW
         Vmxhwp1NU8QaK6s+ZiVaZ0vSUG4se+Ch/6vOTg54/jZg8pz+Dwnszf0rzMCW3udUjA4S
         5zQdWNFo64+OlvLPScP5CEMif/f89OuQZi8ioPTgb23fkNwP4zciNWW7SJXWpZ/mQDF8
         0MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItQBUrV0EvZiYOjtPn9RtcHJwdM5uCOC63vNEO/Cgn4=;
        b=0frACKyDLZbTch2WHlZd/0uK1WDAuN663mnBn+ndXRCF71PWUnUL6Vvp6mDlUW2uJW
         daQSnKTqdxghihEh9BjYF8Wnazkawb73zSLhu7X8YQvcdu+g/Jf8azDDS8Tsdajhd20r
         5hMm7+cvODiKL2VW/SQL6issuf+lMN/4tM7RJL6IA6lY9dThJ9Ap/X7TIOrdKZkIII1q
         CWWCDVGldMnxkw7f53KNsG+hvEbe5qd1c5d7rZBYRL8qnFmI0WBTVur1pmrDhbSFomAd
         WixAK78+JKfONFFOwIozxWNpRRsDlnDP4fQWOhjsoOkBssEwRnEOt33FHdFGoAk4SRhe
         ce2w==
X-Gm-Message-State: AFqh2koboXz82cS+mKNaN6kdoXZq1BUpmtq70x8tvOPA7ns+cDjGZPA4
        kWhxlR3YDQRACIZdDrftDuAyiZc/U1+4
X-Google-Smtp-Source: AMrXdXsO97Tf6V+s4D4bpX/S6mjRj56+jxyaaHemqoaz8G5Nwc8Bqz8Sa7QxAErbsdzR57ehavEIxWJ9q3OD
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:c10a:b0:189:cf7a:b564 with SMTP id
 10-20020a170902c10a00b00189cf7ab564mr893175pli.8.1671869538392; Sat, 24 Dec
 2022 00:12:18 -0800 (PST)
Date:   Sat, 24 Dec 2022 00:12:03 -0800
In-Reply-To: <20221224081203.3193960-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20221224081203.3193960-1-zokeefe@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221224081203.3193960-2-zokeefe@google.com>
Subject: [PATCH v2 2/2] mm/shmem: restore SHMEM_HUGE_DENY precedence over MADV_COLLAPSE
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        "Zach O'Keefe" <zokeefe@google.com>
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

SHMEM_HUGE_DENY is for emergency use by the admin, to disable allocation
of shmem huge pages if, for example, a dangerous bug is found in their
usage: see "deny" in Documentation/mm/transhuge.rst.  An app using
madvise(,,MADV_COLLAPSE) should not be allowed to override it: restore
its precedence over shmem_huge_force.

Restore SHMEM_HUGE_DENY precedence over MADV_COLLAPSE.

Fixes: 7c6c6cc4d3a2 ("mm/shmem: add flag to enforce shmem THP in hugepage_vma_check()")
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Cc: Yang Shi <shy828301@gmail.com>
---
v1->v2: Update changelog, and add note explaining rationale for
	backporting  (Andrew Morton).

Request to backport this to 6.1.X stable.  We'd like SHMEM_HUGE_DENY to
take precedence over MADV_COLLAPSE.  If we make this change later, it
will be a userspace API change.  As such, 6.1 cannot be allowed to
continue as-is, and we should fix up the code there.
---
 mm/shmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb..0005ab2c29af 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -478,12 +478,10 @@ bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
 	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
 		return false;
-	if (shmem_huge_force)
-		return true;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
-		return true;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
+	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
+		return true;
 
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
-- 
2.39.0.314.g84b9a713c41-goog

