Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2176A4843
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjB0Rit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0RiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467024484
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:35 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u8-20020a17090ae00800b00237e4f46c8bso1450065pjy.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrP8wdv0q5g6TZoHkkTnkJI1bRVcCya3euyXWiQCR7k=;
        b=ehrse2VdjDnpUSRaJ3cu0jOOkJfFGFsUNPVo557shDqmppFkfxAsvzUOYaJjQ0PijB
         EblMOtm5g5NRXaAPcMrHVwQAv8s/x+GnRlxruVHPkK5jtQN3yNt/EBweE+tKCGKaism7
         U3HUjXQbto1B7qoo3unz00bS4zA1LfeWfOlzZkorv9RHy9hKyHRYaEA4i2TEzaJJuMBg
         IRIyIDCAlrqJadscsfwaMyXl67M96LYiFdG5WP3t9rIaF13TbFMOYIsSXYvDmmcAe7mT
         R89y28xjRtFN9b/E58zHscfzaCRWqNFydygKz6NtUn93MmZ0Jv953fv4FHoISujugl1t
         udmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrP8wdv0q5g6TZoHkkTnkJI1bRVcCya3euyXWiQCR7k=;
        b=2n65QL9JohQ4zA3XLQptrQHsJjPGzTfHjpj4mPmDfO9YCTeOdett0vAXQxaVlkETy0
         OaXbA4O9Y5FSM8kV94gdhrFiQe3vODtcdNUCxSd+gSfF9GgSHEq78ihPVklCE2xWzFub
         Jq8gejXZ8abYVjolInCNVG79yFpw5BU/+tsRG6C327LgU6VxAqzb8KRu2ZkXMOFbIYA5
         Uc+u1U5297GDrcm+tXbKAZEiYemUVekyG9aBcvZ4K2FHwJryTmpe6gx+vwsi31nM790+
         fUQ/945dNIu2Jrtj+6HVpGoO4iNz+nu/aN8s30jH5Z/H3RvqON2RkGhi3R2ubbTgRUYR
         mWfg==
X-Gm-Message-State: AO0yUKW2JOjmAVLI+V/XrxLgKDCt+MawoR2p/jdM9UGjruU/O+mWM3w1
        qDIjrgBgDZX5iSFWQRmd8h5MQkuPx58=
X-Google-Smtp-Source: AK7set/aNutcI5JPOH6nKZSnuzXLxYVujD/4TtRCmI167JUO0duhDMkhOBXuPDJivfwxfw4Ct9inq/o370Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a17:902:ab58:b0:19b:e4c:2039 with SMTP id
 ij24-20020a170902ab5800b0019b0e4c2039mr6578302plb.4.1677519453804; Mon, 27
 Feb 2023 09:37:33 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:23 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-25-surenb@google.com>
Subject: [PATCH v4 24/33] mm: fall back to mmap_lock if vma->anon_vma is not
 yet set
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

When vma->anon_vma is not set, page fault handler will set it by either
reusing anon_vma of an adjacent VMA if VMAs are compatible or by
allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
a compatible adjacent VMA and that requires not only the faulting VMA
to be stable but also the tree structure and other VMAs inside that tree.
Therefore locking just the faulting VMA is not enough for this search.
Fall back to taking mmap_lock when vma->anon_vma is not set. This
situation happens only on the first page fault and should not affect
overall performance.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index bda4c1a991f0..8855846a361b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5243,6 +5243,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_is_anonymous(vma))
 		goto inval;
 
+	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
+	if (!vma->anon_vma)
+		goto inval;
+
 	if (!vma_start_read(vma))
 		goto inval;
 
-- 
2.39.2.722.g9855ee24e9-goog

