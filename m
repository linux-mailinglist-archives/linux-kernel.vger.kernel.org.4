Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DCB698BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBPFU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBPFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:58 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063E47432
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4bdeb1bbeafso8706637b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+haucx/0aUjNKP4B5JYWnKqFhX48IZcct98M2E1/jbw=;
        b=aDErRd7kkY+Kp4AaU6gjM3F503YHpBTPjjocmaNoc4zXVCAuMI2RAQKjzcRAbLtJge
         uySjaOCoHcGS53W7o3RYdOQoeaAfeHvH08PuG1fh1bxXWOGZDVGDBlzIfGuJz8kR8m0P
         4LCu9IW21ZFA5+XCq7hXP9c4LIZtK/mDOJpY3r8EhzjVEo7Ti1XlFspuAz3gf99Vo08U
         GQhyt4xy4/c9ROtLln2G8n+ixCeeiCqz1U0tO8VqF1k+R16fVXyhOw17lx8zHct64i1Z
         f89mO/K5qgtX3vlh4Aty7U18axNicxnQBp8nhqlTIla4iaOnphrb06qKzWIf+oeLlfcz
         N8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+haucx/0aUjNKP4B5JYWnKqFhX48IZcct98M2E1/jbw=;
        b=vXvJ/jmmr8cilTQtDwSdBP8CsN/q9SuLvltAFG8UvI2R0R5hMj+Kq6MUK6SkLZ53Rt
         XcyyIW9gpU+L5xxQsTfhd77ZxzcOJ4JCdSiHVivWPLbF4A/R8zx9QlWWQlXf/d5VoF8a
         FgvXXwo66wc2uvZMqNgZO+Fxpqa1D6WmNPYbSqW9EoxmUWr/Jx+F050nEj4kIbB5eTMs
         LvxnN7MXQO1maObCExB10pge0LyvHy5kMnEqiJThAvyYqngbH83isJTwbCRMEnx4fk86
         ya2dLL8+euGIVAtNNEy49vl+fp3ZPK2NEOkrp6XiegjNLcvJAnw3kAFjeNGwH4+e4lrw
         4URA==
X-Gm-Message-State: AO0yUKVGFbz20h6ipSOryVd1Dya+CyG7oDRmF5XfadjTFb1sSyrg8vvY
        n5ibRy+z0ce2YWQNEBbuQZIutRIB6BQ=
X-Google-Smtp-Source: AK7set9hR8JRk82RlKZHeYCMxCYi1ok7+igo70HcdJvHzw/Nn50rv4GE5Ev7Sgo0D41w7o23DTD5b6roJhQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a5b:c41:0:b0:91d:ddda:665f with SMTP id
 d1-20020a5b0c41000000b0091dddda665fmr396601ybr.589.1676524741694; Wed, 15 Feb
 2023 21:19:01 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:43 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-29-surenb@google.com>
Subject: [PATCH v3 28/35] mm: prevent do_swap_page from handling page faults
 under VMA lock
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
        Suren Baghdasaryan <surenb@google.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>
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
index 13369ff15ec1..555612d153ad 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3688,6 +3688,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
2.39.1

