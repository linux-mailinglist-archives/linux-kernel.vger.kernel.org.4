Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE9663217
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjAIU7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjAIU6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:58:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6038E9B1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w15-20020a05690204ef00b007b966ba4410so7177556ybs.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqE4Jv/Ie7jJyt+ylXoJ6xWWNYJ7mAmWvaygaHhGgmA=;
        b=C0RC5qgBD/V26736LQT1/agfFQE3oawoBsVodaZr+HfHKR+SKXSkxzHnqRRZUQyjCF
         /VKZZZ+vJ6kaEdIfo26R2t3ZnpRNnactrnv5DhopT9zYmpMMrFjwmeMN0NuvQGOG9Ma5
         xgohCqYaIMlqK/c6f2BeWoXmU7iZ4/9gccjpi+n1Vpya+2P9xxgUSOybhe5uijKT6IMh
         I/M50QEDZcxaCjlrD2td9ExwPf2mPPj9P3UPSnAgQR/cCy9DPbczOjnWTPsq0XpCcdbi
         g/lQrqmdlC6kTELYjuH3lVXIdNQlERXCKK1DKiV3+4JsEhkwrKU78EAKu+F90rDI8Z8t
         c6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqE4Jv/Ie7jJyt+ylXoJ6xWWNYJ7mAmWvaygaHhGgmA=;
        b=VNDtRtCZbfC8ppgUEHdrHnhVH9LBuc60UsVKibbl5LyVamjIdxoQXBhskek1+t9Syk
         0/BK/DkI7Sj+HMpc/nZgAsOMwlf/6oPcFiuBge//L+mU+osFfIoMkjhym3Wv+YuqsOvl
         vKJhZlVjV0Crhf1cqPt3SQrGUa4rG0/nxF5gaO1glPSmDaDA+TjPu054I83VGFWppeun
         qmvc1s8KTlhoQJQ/rPDX7VZjP7L9a/ZHuQPctwi2U9LF/JHZfc/DsKpejjqh3QfbPWQd
         OGQgeRgebcxD53gWJZ4rvuDa6Zi8h5TBC0bYP3Nib62par0DcL0ufP3yfZPCf0/zek4w
         SNnw==
X-Gm-Message-State: AFqh2kqu+qPip9iZBXyqX9SjYj/tRtPSj87p2+JHpiDc6f1QbKCtIH3C
        Bt5xk+dHFUQAo9Fm2gmIgk5pJs55WQo=
X-Google-Smtp-Source: AMrXdXsVSd5Wz07hI5hxUAzF2wzs/BFzwaLObvOXI24uMhgcUHGkQCCTKMo/jOVrGruw6pJEAc/B3Pke/WM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a0d:dbce:0:b0:4ad:7104:1f63 with SMTP id
 d197-20020a0ddbce000000b004ad71041f63mr3427748ywe.49.1673297713421; Mon, 09
 Jan 2023 12:55:13 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:32 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-38-surenb@google.com>
Subject: [PATCH 37/41] mm: introduce mod_vm_flags_nolock
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
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

In cases when VMA flags are modified after VMA was isolated and mmap_lock
was downgraded, flags modifications do not require per-VMA locking and
an attempt to lock the VMA would result in an assertion because mmap
write lock is not held.
Introduce mod_vm_flags_nolock to be used in such situation.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2e3be1d45371..7d436a5027cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -743,6 +743,14 @@ void clear_vm_flags(struct vm_area_struct *vma, unsigned long flags)
 	vma->vm_flags &= ~flags;
 }
 
+static inline
+void mod_vm_flags_nolock(struct vm_area_struct *vma,
+		  unsigned long set, unsigned long clear)
+{
+	vma->vm_flags |= set;
+	vma->vm_flags &= ~clear;
+}
+
 static inline
 void mod_vm_flags(struct vm_area_struct *vma,
 		  unsigned long set, unsigned long clear)
-- 
2.39.0

