Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC69698BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBPFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBPFT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CC1457D5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r17-20020a258291000000b008ee1c76c25dso857450ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy3b4YdYe1JheypyM1qEqlntx+LNPOiVtlvqoTpRTGk=;
        b=ee09VaaNfMCXdTYs7ho4FL1rz+7Jau0hVrpqtPJwR0LOjVJOOKMHcMbwd/rGxak63H
         BRVuTQ9tdXJzSR+6NhiK4KAEy3orTDG5A6ugcB1Mu/JZ3TtJ8rFlU/MHE4DwjmulfLqA
         4lbez5vLr44VvmK0HXNKetjG61FmR5dtu/ffCFjZaMQfVdd6yPZ6Vqs7cSoCFmCWN2ej
         U7UJuLArjVJJvFA58VBbTFzUGAlbxAZVBV5EE2zVq6EhbmHffJxz6yeGBWtLnffH9zfX
         I0SKmeE3zn9vqZPVYyRXu1tk/VZ/LisV9OyoAUd6iOjxLewnK1RWOS7bKO/6E67varMh
         DYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy3b4YdYe1JheypyM1qEqlntx+LNPOiVtlvqoTpRTGk=;
        b=S9oRNMN53hXvJ2u1o7n8WUTsVPHgF6cCHA3DtHB81BbxgFZtLfiESNINvU+MrQlQTl
         2OQI5aBIlbXTepj2OvGFJy/NxbAg/D2XM9ATKRNyocDpu83/sPUO+aMTUXiMHYwMYhsu
         s7viF2fnSNjy2HCFJ7RkGPHKAp8Ss1MuTFjQK+KL9rw1EBJpjtFnw/64M0BfxmMu9RRq
         xzzVmaVRZG63cXb7Kvfjc8EqozIab4Hqa7EdAxGbaAG9/oyXLbYGAnd82croe6EQ396q
         f3rScoWmoAKeTcCZb0cVCntKD8dMZ2lAwHZXSUOx1q8G0mCya+Dc4SxPLUpeXChTQUAw
         CafA==
X-Gm-Message-State: AO0yUKUz8GvR4fi84hr3SHgZZVjuQxXZI6fJuvveD+V0xnJx0/jIwh/4
        Soh49U9H69yCtRj4ZMAt220Ni4XVSXc=
X-Google-Smtp-Source: AK7set98gd/BBmD2MrHMvmTSXIUmiTX+HY9u8tg6jgvhUw+D34Dv05igzcuyCWu8/RYb3F6ryIOQeEDmrWY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a0d:c347:0:b0:52f:1923:4f9d with SMTP id
 f68-20020a0dc347000000b0052f19234f9dmr562132ywd.366.1676524727987; Wed, 15
 Feb 2023 21:18:47 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:37 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-23-surenb@google.com>
Subject: [PATCH v3 22/35] kernel/fork: assert no VMA readers during its destruction
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

Assert there are no holders of VMA lock for reading when it is about to be
destroyed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/fork.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9141427a98b2..a08cc0e2bfde 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -491,6 +491,9 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 {
 	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
 						  vm_rcu);
+
+	/* The vma should not be locked while being destroyed. */
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock), vma);
 	__vm_area_free(vma);
 }
 #endif
-- 
2.39.1

