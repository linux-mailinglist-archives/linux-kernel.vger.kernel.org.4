Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D9B6A483C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjB0Ric (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjB0Rh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:37:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46E2331B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536af109f9aso154258357b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7njm8z68LI6RSv1P8+cvUE7J2LNjoWsKIE5FW5UVRU=;
        b=kE2fXrc4CKxmWF4clr80N741Ci0xoX5G8lQJgmu9s0G2B1Dy6UfiGdmy87bkmQVz06
         s0jNeoaCkSHSjTyAuaLFgp289qeTagMwone0ldYih81KbxqFw8/SoaDnJa0SNDiiUGH5
         C2cHTDPFHiMhA/p+opto/zgvEpmwF0hSnXtUorxCz5wzOWx7pG82xGb9d1FeLnZgcBn6
         7W1alMlgUF/qdYBONkVV4Ipuqjxo8jbsNMGdOFgbr+6bIzoXMj9Q7PsKDQfKRgxbc6VN
         kYkd8hTRqF7X5fVDHYhOgBPe6TXfun1LU5P2SsjoAl6axSlRSprAw6j/yFhpk0MslB1+
         5m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7njm8z68LI6RSv1P8+cvUE7J2LNjoWsKIE5FW5UVRU=;
        b=G59bBEDebkd9554QaE01Hs2JOi4gsCX7JEbd3ABsttwVD/EjXjN0AISw1L2MLHXpDG
         Bm7Ot22UymI2aa59d8tLN5CYv8C3/6CGFLs5ypEMvyu/usJT5Ef3cm7CoH2ilR+RFhd8
         k0jcVAGQJ2EGd2PN6Y57afsC40kPAlmsN9ra3uCjkyVW8x23AfwAUWUIddszzOjt9Vqv
         3oLImS9xPzu07EXqg5UhvrFg98PvCqPFy7vM88pqDEkttPcI4LUyP/nXJI9FI5RjMWnN
         oLqyoBSFH4ptwyEi7nQ+bULbqo5+NF6TQRHR8BIkWmvv3FAAw56Md+TiaICz/hepOeXj
         WRQA==
X-Gm-Message-State: AO0yUKWbU3EnOUmzPUEn0gvJHB3dUeaN4yzCiAHEA8BpouShDsUDbvUf
        nreeccOTLX4MZkA+3DrwdeqycTRt4mM=
X-Google-Smtp-Source: AK7set8BLaXPA95+t3odvktVZcgw7j4RuC8orgkmVPEnGvQUgHaO3AYXobp8iNv8pTyoR4t4ofqJKVALLsQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a05:6902:4d4:b0:91d:d6ed:6bd2 with SMTP id
 v20-20020a05690204d400b0091dd6ed6bd2mr10048648ybs.1.1677519444556; Mon, 27
 Feb 2023 09:37:24 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:19 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-21-surenb@google.com>
Subject: [PATCH v4 20/33] kernel/fork: assert no VMA readers during its destruction
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
index e1dd79c7738c..bdb55f25895d 100644
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
2.39.2.722.g9855ee24e9-goog

