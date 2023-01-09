Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2783F663212
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbjAIU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjAIU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:57:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833FC8D5CC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:05 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso7051030plx.23
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzUeswsih4PBYsAGoTi9IuotyhbGAzkWIDmV0FovK6Q=;
        b=i8mCfCut8WK6+zjWPXPrBAn0OVK3TZZqUir2pgpkQNWhenu43X3/akUsts/8WrGL5U
         Ag1lqNnPrK3Lht8c6bYeEHv2p/KYkV84L0N5RKup3Lqh7FNgEiwz2qb9iAaK8aobnie5
         SWRp3Ej3gvy6Gx0qa+UPT0Wm9SDIcbH9qbkEiBwV9a/y0P6JGxAF3x2bjosqkuWs4x2Q
         7wdZhW31F8FFO8VMgBTx/6RIzfF9caT2DmPvdENgd9fKarg0jWwQoD/+83rrhQbpzEQp
         l4T3tmRoZNr6BoK1+IwDWlh9AP60sfKufgosjp9Mre5rIBM3jgdbCDpmS0FgJglfxzEq
         wvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzUeswsih4PBYsAGoTi9IuotyhbGAzkWIDmV0FovK6Q=;
        b=xeHozbe4eDOwQcykrFHBIlzjjaasUmnkeVVA5CmWRjBzI5CvFjbBq8vl3ealIxj39x
         UViMqmoLpQFzALrtUb5PMq3Puj+2U9yLRaw8niaLpSfgiB82QM7rGofa4ZrfWa4/LfQU
         PXA4dvHro8WDeo68M9wovQDfd94Ma9muB8if/LRmDVWoH2mINgO8PsGhpt94A4mEmCtH
         2odlKw4sxz0ZCYhhhVGJeGFPct9ZWptmqwOCNHoP5fssb9AvQiKhG76j4mNzHANt4ltD
         AosLTQTLoLbYW9kA/zRrcwfahhJ98VcYZrpajh82QXY0QTHH/90z00C3llsZ8RrsHpMu
         1dIA==
X-Gm-Message-State: AFqh2kpLzf8vzCOqujvPOXF0bW9lzmKHlgse3olZn4NWH/ImjY+g7fOJ
        bnnP1rpIUYZuMflAIQ13kypyVfzyzYo=
X-Google-Smtp-Source: AMrXdXtXcDh9ACK+yDPMFgwqnCidD6d48HBoOS8XbTQx42HB6Mm5GZSyonzBvXPdXaN+wlg8/pxMUTj5geU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a17:902:7d8a:b0:189:754b:9d9c with SMTP id
 a10-20020a1709027d8a00b00189754b9d9cmr4530740plm.120.1673297699405; Mon, 09
 Jan 2023 12:54:59 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:26 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-32-surenb@google.com>
Subject: [PATCH 31/41] mm: prevent do_swap_page from handling page faults
 under VMA lock
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

Due to the possibility of do_swap_page dropping mmap_lock, abort fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 2560524ad7f4..20806bc8b4eb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3707,6 +3707,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
+
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
-- 
2.39.0

