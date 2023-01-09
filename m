Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D1A6631EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjAIUys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjAIUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:54:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52437458B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a256651000000b007907852ca4dso10290949ybm.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKcEnbcUm4yNPmJ0/UBWAk4YOoOktsWvie1GPNgM1C8=;
        b=GGWOlVFNZmpsv4EqX6fJ0IzU46mRQdwbpB1woCBvprw4wrB1Px0W3aw0R3eA4F/+xV
         kXuBRDFymMvypEzFr/D4iD7og2WAH2DpqMoKxtl2yVGo8HrvBlCIzI0TYQCav4I1owI5
         QhJAem5dniKSevuuTKEF0EwC81wZP9AQ1hwH/aOaMvCSNfv3FcYZaW7nXgrr4EsyFNJE
         AJznojM8o2oQLC4YAgQdb7K64EDnrtRV2QjiyePckmOOYm4vpeviEyBwwk5GM5l0mBi5
         NKaa6vy3INpTQuuxZ0BRwKOg99o3TKTitzAEr6jS2DiN0O+IImG4Tiab8jZ8nkO0QP6Q
         MsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKcEnbcUm4yNPmJ0/UBWAk4YOoOktsWvie1GPNgM1C8=;
        b=0TH/FtS1iHalAEAfuWZgWXlDiDaDR/S5MlzQ7iXcWTsYLCCTo3WwJnmOZ7BiXuMws/
         oWR+kdJXDaNYK2auC80eQda0bndzIGYRjCC0976Ol3U59dvFlBBSRJkBJcgTxWso3lXl
         tdVgmip6KCppxXIWpRxzv3sZcGb6jWOMjujsuBfMFVnL/iQuFYdLYGU0IH0a4h4NZyCE
         w1mTM8SBX82tdJ0vzZe+PBALM+qtd2oNrVaMhSu1x0HjTo7dnFq4/n93LAwSY08bz8jM
         tHqmGkiLEPRTo70JQnB9tqfWqvlV9td3/rhxzilRq57eTCrfZWUenO9Yd1QVkjbn7lV/
         rKOg==
X-Gm-Message-State: AFqh2kqLNuWRenyFaLEmjlF4e4UIvFgQX6enhQVnuyj1pHd4jO6jYwJ9
        w0v6TQI0v4LD9LPy9/hhETGPkGD2hdQ=
X-Google-Smtp-Source: AMrXdXuuklmw1U5OSS04yToFIKYXQnoMsaTWu76HfgvyMhLNzfJxTKm5wgWz/6XkfwWL03n+CBAO8y2WRQ4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:9393:6f7a:d410:55ca])
 (user=surenb job=sendgmr) by 2002:a0d:d48a:0:b0:46a:f5ee:a2fe with SMTP id
 w132-20020a0dd48a000000b0046af5eea2femr1229443ywd.207.1673297647974; Mon, 09
 Jan 2023 12:54:07 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:53:06 -0800
In-Reply-To: <20230109205336.3665937-1-surenb@google.com>
Mime-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109205336.3665937-12-surenb@google.com>
Subject: [PATCH 11/41] mm: export dump_mm()
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

mmap_assert_write_locked() will be used in the next patch to ensure
vma write lock is taken only under mmap_lock exclusive lock. Because
mmap_assert_write_locked() uses dump_mm() and there are cases when
vma write lock is taken from inside a module, it's necessary to export
dump_mm() function.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/debug.c b/mm/debug.c
index 7f8e5f744e42..b6e9e53469d1 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -215,6 +215,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->def_flags, &mm->def_flags
 	);
 }
+EXPORT_SYMBOL(dump_mm);
 
 static bool page_init_poisoning __read_mostly = true;
 
-- 
2.39.0

