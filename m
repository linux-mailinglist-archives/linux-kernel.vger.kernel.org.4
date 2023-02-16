Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B1698BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBPFUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBPFT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFAA474D1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q127-20020a25d985000000b009362f0368aeso883604ybg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+2R9wHJik/ujG7pbEIR7UB7BFuMmi7T4GQjwfs+Slo=;
        b=GJ5BxW0Q1u88snEvipBftLmc3+Jf1QItAPirJyrJgB8Mp9ylRIIALZlXmJQ4wNiSwP
         o865zgbeTpwGE0/miDmLSBWepWhJN06egqwo+YGBO2p834t1tPcrBoNtCdfrXD1jQzaN
         e7lrVFe77phFTZAotKwLYsW/LOb59LyIPFjYvDx4mPrMSRvD2iWSSQr/TeKwF3SManJP
         7zOmcrgCnGJ5t0wPXfGvFFU5Wepw7LHd2B3wtwv+KMRgdeCQNTeRgpwm3UNl2CvWi/nE
         3FOidEUJKnpNbe60Or5Um47yum4t5Cm2ARYxCb7pet6vv6oqpLv+fwdHpYVdfug+gwv9
         oixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+2R9wHJik/ujG7pbEIR7UB7BFuMmi7T4GQjwfs+Slo=;
        b=Qi3tRaGOFoNfAfZOXYc5BFe0C7UUqBaV5lquw1ZJ5toVViOcgpfIVIkTr+7eGAzQKM
         MiP476TRD9/Gi/YCUSfYwC5297Yn0h5OJDxPp9Uu6Sa2gAyo595Fkw6l4ZY2v9WpYUtw
         BzfrK1e+xzxgFiCKBufoFG82ZcyF2zKF9SS4h6ocgzSmE1I9TdB7AzqJGyKuwTus04/7
         sh00bqtKsu/xqYKnQhvg2M7+LxogCzjf7wPFcyblIK0UGh1rDKwZC0ApTfxehir00NJn
         5hefN49CeTJLtsRz0zpSedzMfHjoXkFxJMlJW9NAnAaieKokpa0HtDRzd0zjTgq2M3AS
         +rXg==
X-Gm-Message-State: AO0yUKUfxcUdXcQOCiH92eidQJURQsAkgLjGfjpIVT/UmZ63e+T8j9J8
        xkTTs7ZOjRQSnz5SvGXFY5aAjXV5YG8=
X-Google-Smtp-Source: AK7set/8zrN2bEgVNx1m2BtSP2crHaoN6LxODGu2trr1UY0Ec3uUEJoRM+mde4AC+sE3ZWg+Wi9w81iJ8kk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a5b:144:0:b0:8ec:cc9b:7333 with SMTP id
 c4-20020a5b0144000000b008eccc9b7333mr463396ybp.205.1676524739514; Wed, 15 Feb
 2023 21:18:59 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:42 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-28-surenb@google.com>
Subject: [PATCH v3 27/35] mm: add FAULT_FLAG_VMA_LOCK flag
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

Add a new flag to distinguish page faults handled under protection of
per-vma lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 36172bb38e6b..3c9167529417 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -478,7 +478,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 939f4f5a1115..212e7f923a69 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1056,6 +1056,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_VMA_LOCK =		1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.39.1

