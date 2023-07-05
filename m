Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3C747D30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGEGhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjGEGhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:37:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D61700
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:37:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059f90cc5so69039907b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688539040; x=1691131040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhr6pJDsNrLzcgsJWM8+NlUbxGJ2RjB7mS40bDz+nag=;
        b=wGZz06tiAGOYOW1oR9igBCSCESoMLrvNQ4Is6Pq7jt8gRNGlk1OlqZ3GkhB+7tB7P9
         9lnfKV1ZOPx85SiPB01L2VOYkfUHMYQugjqIBBmzYRd9nmOCGL2TtTmutyFGYvZrS9jQ
         +W0EPlKnQP+wOFnIQ4R6jDrukMoAYrbfHMtMDFmynXYRiAD9rYASdisWn+t9ZO9ysXzw
         pu71VB50nQ9GaYyt1jma1y3S/PyVvAUT4Fg+kD4KEc6TcpNqzMQ1FQUr40YrhLdj2XyJ
         l2odp0IjyHycFROKoN2GV3n72IrNyOtaK4/hhb8CV/GjubqvLQRS7I2/YogapwLtjdfi
         kP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539040; x=1691131040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhr6pJDsNrLzcgsJWM8+NlUbxGJ2RjB7mS40bDz+nag=;
        b=D5HMDO5RiXmlJZOWLt0Pz5mNdTpCr5JQG0Hx5kXbZmyfGIe3Ql/MtRgx6e8AoQU/7Y
         mSaW+5C8I+BEe5bo7iu6JJQoOM7TjshLC6rwWsdVI3+2NNTL63NJN29TVpj+fWniV41l
         G1WeffSj7Beze37JeQ9hGaz2MXRV6tIXzfufITMsz9yKdSqPl8aUd6dCL82CG7QbZr/8
         khhAnLOK/XB/uMiB11I53VPRQG1JApxe3/Rh49a4riVH+yiZc7s02HogC4XSi3wENMWp
         Wvkte04+hiozVITPIzfD51oSSxbkLJslCsN6cOerOigGC1XoIlj6zN3robv2yMq/28CB
         VcfQ==
X-Gm-Message-State: ABy/qLZZCWRyLBbQNHnZO4IF7p1d8KzUTr/dt22aYWE1j50M0O3ygUGc
        ncqwz76CaFri+ydoslkEl4s4/SCeIDE=
X-Google-Smtp-Source: APBJJlGRXrDm2+UHaaQ2lMndANUDPYXN3L5xPOFiKmeuHtoExxhUVsaVOnCv/ExXrwiSlS2rc6+mCts1FPc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:9164:ef9f:8918:e2b6])
 (user=surenb job=sendgmr) by 2002:a81:ca44:0:b0:573:3897:c925 with SMTP id
 y4-20020a81ca44000000b005733897c925mr109816ywk.6.1688539040473; Tue, 04 Jul
 2023 23:37:20 -0700 (PDT)
Date:   Tue,  4 Jul 2023 23:37:11 -0700
In-Reply-To: <20230705063711.2670599-1-surenb@google.com>
Mime-Version: 1.0
References: <20230705063711.2670599-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705063711.2670599-3-surenb@google.com>
Subject: [PATCH v2 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
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

