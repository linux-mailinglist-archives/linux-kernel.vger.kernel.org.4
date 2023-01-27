Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8B67EEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjA0TpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjA0Tns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:48 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254D2FCC4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:05 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z10-20020a170902ccca00b001898329db72so3335005ple.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy3b4YdYe1JheypyM1qEqlntx+LNPOiVtlvqoTpRTGk=;
        b=oI0LJkxWJWb4FwrADuA4kk3Z1VuG/PqmB+wfudzVRf1FutZSssy7j1ZDpJRsJeC2x6
         AK+2fBcgvA6Z1yebvss3n+ODruOq7UlamXlS7DfsbRapPdytBdlVYqH5VQCwBS0bW5Cs
         14NyRgqd5c0dS96F3WtaSc6UYIsY2Q866sZsgDc9kakHc8RR5OiJX50DOvF/naV3sW35
         K5NQwDrUGeBVt7kutcZKVO5xLo4MSKoGaFWDyWGZ3caTDR6ZBpyZR8N/O+LnlyPsEjZa
         UEkxm7VSV5agQqzuF3YgYMg0fZBeMdeXvS4WgRk9vqB/9OKyGK8SEZXO7u7cVN0V9JOR
         wUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy3b4YdYe1JheypyM1qEqlntx+LNPOiVtlvqoTpRTGk=;
        b=nH0a9Tz1hFZgirjd/YDxR0lQAY6YbZoxaOIZcQiFuxjz9z6rP/0B6fLXepvpCVKxFS
         lMualyArBM3DCZ/JaMTB+CYUHEDYNxjCPyQXsp4O1ZvJddq9nb9AhjdNsyk4ZvB0OaY0
         KikJn5wc9cV+nqkK5wZ37Gv5mOXeZJA3amaqLoIJFlczkIE3kg/5D36YXMG6zzAr7MYw
         OIISF59YAnZUX01QKZMdvfnp2HJGuwQbooaC/L/MI6fJYdcmhOdVUgeMEYeKOBTLyPhw
         6Ked58SwVaMC+thfsr+k2kXN059RdymwtjfJbVRbDMGUsam1IxI/G9Fe+omduRw6veTh
         x0NA==
X-Gm-Message-State: AO0yUKUu6SI5c84gN2C4n7bggG9LLXw6mskn9v40zGwF3RRmIqTQ6UDz
        yghLAPPUryuIOKvnNjmGsQDJveHOjI0=
X-Google-Smtp-Source: AK7set/yd1hcYRvbMqSOfXS0bVRoPLBLaG1qWLcI1OwZ+QZcbDYXkFqGvC1aaqenThgkEbN36zZqWHoF630=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a63:ba1a:0:b0:4dc:3b99:6f67 with SMTP id
 k26-20020a63ba1a000000b004dc3b996f67mr1091417pgf.47.1674848524282; Fri, 27
 Jan 2023 11:42:04 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:58 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-22-surenb@google.com>
Subject: [PATCH v2 21/33] kernel/fork: assert no VMA readers during its destruction
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

