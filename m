Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D146631FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjAIU4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbjAIUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:36 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8487F17
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c1456d608cso104273017b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sz3d8Q6zHAextbGhc5zNdx6/hdXqibZ5+zjxQEPtcY=;
        b=dyW75mchIm8T3L3V0Aa5O5essWjp4aFupYS1LFKIISIPYObh/dim0X80nsutKOS2m/
         7vd6AcHVv3F7nL+fFOG4vgOpiulnyZtSLux8AIxMn/Q09ghgqU9hpb0yvL9ry+wKM1Wm
         UvSXVlZK7VJVWgc1kVtRM87LVA0ol6j3197yqrcZsN3y1TKaMHMTXNPpOvk38N+aLEKf
         U9xTtNcWgL4MRS7DZ4GXXUuetaMZa2ezppHTDMHc58pzPdKSGBN9qWFGFMwk1DYAuR6m
         mxxVO9djRkO0qH7ZMi64I+oMQN0AQu1sYjF82YaLSmfJI9fTdyDigl7Wn8SgruW4bLXZ
         WU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sz3d8Q6zHAextbGhc5zNdx6/hdXqibZ5+zjxQEPtcY=;
        b=2ek9xVPg5kTOse9s7DJeUBms3KlFaULCDJFWo3rGk1EOtLUtJ13x5aoAp6Py8+7tLk
         XEiGY4i3N46zeLJe0M35P5Ny+7xSGXQ4KBAn5OfDinW4elurR8QpTJPtPdiRCYFysLSE
         EGVz+A+/lcUVTtThybM/uQmTytdmEcuu6GWBy/dbmvV1S60GKfN3bYGxDaU9O400Yr2l
         e72l8WFD37cOoEb0rxkJT0gf9IyyWIrtgsaxDAA0rA2KRpCr5YNUgpKGWhZin0V+Lf4B
         x8GFt8NjBuiEjnM+WoeHVL2SYEj0DaHZYniFrJB4IIp7GRBEh36XO1b9D08Be0D9Ihtm
         1PSw==
X-Gm-Message-State: AFqh2koEsPZXj1SVJJ+ptcFwACtnk8wQrjxZaU3mkJk95vm44CIr+BMl
        7l7PMjKMTMptk5S1A2Jh8v9Nkf0Y+fg=
X-Google-Smtp-Source: AMrXdXvYJ0MKAPgXdwWnp9E6tLdKAmG2zH31TOsESiFv0D3eqJovHEz4lb9T2t60zhYoFlt31PHaEzcWVdQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a25:830b:0:b0:731:a583:5571 with SMTP id
 s11-20020a25830b000000b00731a5835571mr8144189ybk.320.1673297674437; Mon, 09
 Jan 2023 12:54:34 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:16 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-22-surenb@google.com>
Subject: [PATCH 21/41] mm/mmap: write-lock VMAs affected by VMA expansion
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

vma_expand changes VMA boundaries and might result in freeing an adjacent
VMA. Write-lock affected VMAs to prevent concurrent page faults.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e2154137631..ff02cb51e7e7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -544,6 +544,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		goto nomem;
 
+	vma_write_lock(vma);
 	vma_adjust_trans_huge(vma, start, end, 0);
 
 	if (file) {
@@ -590,6 +591,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	}
 
 	if (remove_next) {
+		vma_write_lock(next);
 		if (file) {
 			uprobe_munmap(next, next->vm_start, next->vm_end);
 			fput(file);
-- 
2.39.0

