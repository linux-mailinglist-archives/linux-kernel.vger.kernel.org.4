Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F048B7489EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGERM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGERMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:12:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F41985
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:12:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c3d29d2fdffso6020663276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577141; x=1691169141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhr6pJDsNrLzcgsJWM8+NlUbxGJ2RjB7mS40bDz+nag=;
        b=OwuwGFefbKC9U1hFfGKq7XVLlSbfvn3Wc1U1DPpWfsB5S/+9zaJkfbxaaSgx2SY8+6
         M9FNfOjC5a4sfR2baxeMeSlwAC3ytN/Gkc7JLJsgx4C5IeFx8LmIhVrkLPRt/S5ZJyNA
         28uBx/1a3m2BtIykVlVstHy3CewRyQH0tBQzJAsD0iBzvDhansX6fe8lVtV71Wkq1hhF
         d7ss16D85/5kqrIrY6VkEZavYwQ2wMGnqwZirQPO+RWDDcC6a41CuVjzqBZ4QT4LZJnh
         ZL1TiC0/TmKgXTKOLlA7HYRxqjCZysCGhr47PMpLNnmBb4Y/CCZ5wC9I/3zONjhbmCvK
         N4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577141; x=1691169141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhr6pJDsNrLzcgsJWM8+NlUbxGJ2RjB7mS40bDz+nag=;
        b=DPoBBYUYdlZclUeJYwwot/dxJTFdJxeUdtnT2YU6ocpFnZcJfxOOlKQROeR7xIV4Ol
         7elGnOfShoG1kcSCdZ/ORowafre1lyBegMR2qd4oYIfwkaZrb2FF1tO/hYx5dS4JR/M5
         y7Ctd0NfTlvWG2b/Pg6P+mzD2uTSNEJsV1WcPxwHXxB6WrF1WtUGE/GPpEbbVzhRCVNn
         8+5wg9WG7G6t5NPO1gQoLhW/5jj9GBDNofCuzWrWvgXw1M3Egc9wtoIKQnEokBTS1Aw7
         ERWvlSlRHOiIO1ge3Pn/VCUGRrE7f0sOIt3J/+xLE/crvkPZviDsKcc/PriDPEOP2g1/
         OGMw==
X-Gm-Message-State: ABy/qLb0tY723fxi+pBQlA4S9e3F5aRVaw40PwtGvio5vJIQpZ9oJ8wB
        REvg4bKDAE425yaS86TmISPl3WO9NFI=
X-Google-Smtp-Source: APBJJlGpmVB1m9CXIOzFLtUmhP6OfOK5P1LeMgXKt+RTRDlo/ehfVzIeZ4w0sSLiOprYfZqdFetD2HIkiuA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:946c:be30:90d9:9093])
 (user=surenb job=sendgmr) by 2002:a05:6902:11:b0:c4c:b107:65f9 with SMTP id
 l17-20020a056902001100b00c4cb10765f9mr62580ybh.10.1688577141397; Wed, 05 Jul
 2023 10:12:21 -0700 (PDT)
Date:   Wed,  5 Jul 2023 10:12:12 -0700
In-Reply-To: <20230705171213.2843068-1-surenb@google.com>
Mime-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705171213.2843068-3-surenb@google.com>
Subject: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
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
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory corruption was reported in [1] with bisection pointing to the
patch [2] enabling per-VMA locks for x86.
Disable per-VMA locks config to prevent this issue while the problem is
being investigated. This is expected to be a temporary measure.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
[2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com

Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
Reported-by: Jacob Young <jacobly.alt@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
Cc: stable@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..0abc6c71dd89 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1224,8 +1224,9 @@ config ARCH_SUPPORTS_PER_VMA_LOCK
        def_bool n
 
 config PER_VMA_LOCK
-	def_bool y
+	bool "Enable per-vma locking during page fault handling."
 	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
+	depends on BROKEN
 	help
 	  Allow per-vma locking during page fault handling.
 
-- 
2.41.0.255.g8b1d071c50-goog

