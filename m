Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F2616C95
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiKBShx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKBShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EDC2FFCC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncRDq/BlJOAFd1lZE2ZJuHKc4OomK+HPZ50zPzXYcKQ=;
        b=LYPHEOGWA8HxC8883iDwz4ozq0B5uiuGw68ctqDiO3btgVKaQXc+9jVOF1AFviigdM1J3N
        ewiXuxxipD6qYOmhI5K0IvmSOplQa9R+4HWj4xWPVABQ6pNfCclIKPjKcA3CPrGnINyFsc
        XW4OBbcmhPUdq02zpOYJ6ZBg44igeI0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-iOHf_agQPhaIgGv2aVn0rg-1; Wed, 02 Nov 2022 14:34:36 -0400
X-MC-Unique: iOHf_agQPhaIgGv2aVn0rg-1
Received: by mail-qv1-f71.google.com with SMTP id on28-20020a056214449c00b004bbf12d7976so5751657qvb.18
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncRDq/BlJOAFd1lZE2ZJuHKc4OomK+HPZ50zPzXYcKQ=;
        b=7CCTIYh+zCFOS57/Fxa02OLNRAzBlXpysnJ1j7Z76ichj4qZ/ZGlCCc+0W5TgkuCbD
         h2soPoPjUSwU+E+w1PRNEPfLZzFJYoJV+VjFo47Pi3cqWFAIjZSY4YGjQvddnF+FaOGq
         hNyO6Ps95Rk7cWjuBQLsDWZGKcxB/+X8cY/L0yrZbaUjiJW4jaUkNDr6piv2/1OE7nqq
         7XmMtMG3kJgG8wXUZMvkzUUPhKuIqECcNZH6WjLr4xCZUB45ihaEVQlUetRAX14LsgGO
         7WvyJtwfn7KCfq+zGEVoxm93NFysp6QyaW/g0mvDqtCIBCu8f7Ef5UZ4QV6+kv5KVhav
         E3xQ==
X-Gm-Message-State: ACrzQf20qOQUMBsu9NYtduLfnRhLbJSDEMRMpLx1Jo2OIL4I9ukrLmsQ
        rDI5QDRIrqdYkw7aFlAf3O4mVhfpFV0HGlqCoDKukpHpeM5fT9UFphfjOWkK2rnLnIAWQugc5GX
        LfHsLU5EVsAQLkhfljHaD/7zi
X-Received: by 2002:a05:622a:248c:b0:3a5:15f9:57a5 with SMTP id cn12-20020a05622a248c00b003a515f957a5mr18914903qtb.48.1667414075613;
        Wed, 02 Nov 2022 11:34:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4FNihlWG52eEaddlVJ4IcxN5GuBU/ct7sDYakGhS8G9lm88SJZYPQReqCWBc6NZ/CtMAHrgg==
X-Received: by 2002:a05:622a:248c:b0:3a5:15f9:57a5 with SMTP id cn12-20020a05622a248c00b003a515f957a5mr18914895qtb.48.1667414075423;
        Wed, 02 Nov 2022 11:34:35 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:34 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH v2 7/8] smp: reword smp call IPI comment
Date:   Wed,  2 Nov 2022 18:33:35 +0000
Message-Id: <20221102183336.3120536-6-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing the call_single_queue hasn't involved a spinlock since 2014:

  6897fc22ea01 ("kernel: use lockless list for smp_call_function_single")

The llist operations (namely cmpxchg() and xchg()) provide similar ordering
guarantees, update the comment to lessen confusion.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/smp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 44fa4b9b1f46b..b96579fe08f09 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -503,9 +503,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 #endif
 
 	/*
-	 * The list addition should be visible before sending the IPI
-	 * handler locks the list to pull the entry off it because of
-	 * normal cache coherency rules implied by spinlocks.
+	 * The list addition should be visible to the target CPU when it pops
+	 * the head of the list to pull the entry off it in the IPI handler
+	 * because of normal cache coherency rules implied by the underlying
+	 * llist ops.
 	 *
 	 * If IPIs can go out of order to the cache coherency protocol
 	 * in an architecture, sufficient synchronisation should be added
-- 
2.31.1

