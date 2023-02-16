Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDF9698BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBPFTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBPFTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:11 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D08039B98
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4cddba76f55so8301457b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpf0g6jEgEDruwUAtDYeX37TOF9sV0bBdZYAp5OaPFw=;
        b=QqHoT4KBvKUoUdLlMqp51fx+DvEGbEeCQBAnfd6VVaWQ1iGMSVWdcYYT+IcmdoGW6k
         3cvpI3DbxmqWzlsZbZtdKxchg+b34bnVwYQM28D7iM4wfdyptvE97biBiYefhiTugMIi
         6QLuIfwXdU8feO6tOQjuROgghWTm3q6OIMngPhTxYx3FIBx/Q/vwNR9bBonlFJnVLRif
         jIgBrdCbBh8/u0HLrcAEynfXgVsHAUyrN5D1sUvBi7o9DTj4LnFYvOofA3wqcNiCIoKK
         +suiPaGBCd0kL8KKwbFLDtmEf/YUc3gt6F4GpOlLFqmXcdgxQWnJd0Ox4qoA9H1pNQ9Z
         aRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpf0g6jEgEDruwUAtDYeX37TOF9sV0bBdZYAp5OaPFw=;
        b=B74ZFrO6R44wFBlyz2MCssrIgopSojVQC8qyy0NXl+Nq87HlQIzydb3FEqU74fQHww
         qWrR0nwICIbOAtz36fVIX1U1peg5+3wmahF/VHlRswJNW7uZ3bNv2tmURvCmdCLol3Tu
         e9VAHheIaeoJCijRq/4QatWCPIe25Op9TNhFlIStz5AlyvfHqwcSyY+tPYXRrUtMcirf
         4V08cDa+NrFTutD8ehZcRfg5/+JcIrBSh6B/NJdTrHtIgjZVBKTEpZPQ08wnnC/2joA8
         smD6UYEL8mpGyzPttkUTRggPq318tOVP5saQPu1AP0EtuGipD1eOZ9GKxkhKYrLcZUwP
         unIQ==
X-Gm-Message-State: AO0yUKX3jE0Qh/2Ss6g7THPB3cVWFfBB3LegEHj/csjMqGeQc10LwBT3
        E3nAeAClMMnTUR4zd+THMTH3vAfQt1Y=
X-Google-Smtp-Source: AK7set9lI2rlt8srxq1B77BNUY6DsMc7qDNM9tTWpZOotyLmczPTVi4pDHBbcvVuKtvP6t7k4zPbNPC6UU8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:5a03:0:b0:527:83f5:3f08 with SMTP id
 o3-20020a815a03000000b0052783f53f08mr494142ywb.425.1676524707124; Wed, 15 Feb
 2023 21:18:27 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:28 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-14-surenb@google.com>
Subject: [PATCH v3 13/35] mm: mark VMA as being written when changing vm_flags
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

Updates to vm_flags have to be done with VMA marked as being written for
preventing concurrent page faults or other modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a056ee170e34..f4f702224ec5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -726,28 +726,28 @@ static inline void vm_flags_init(struct vm_area_struct *vma,
 static inline void vm_flags_reset(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	vm_flags_init(vma, flags);
 }
 
 static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
 }
 
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
 }
 
 static inline void vm_flags_clear(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
 }
 
@@ -768,7 +768,7 @@ static inline void __vm_flags_mod(struct vm_area_struct *vma,
 static inline void vm_flags_mod(struct vm_area_struct *vma,
 				vm_flags_t set, vm_flags_t clear)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	__vm_flags_mod(vma, set, clear);
 }
 
-- 
2.39.1

