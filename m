Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267156A08A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjBWMfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjBWMes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:34:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77745532AC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0TS8nXz+u1sbnPtO4cPWraWjlrBkSRepEXgG/CH9vjk=; b=mN5vdRVpmTtTwyuN2DIFDauxqj
        1o3qoMLZfcsM6maEP16gO+DSlQfS5ptl7EPmIPsPda4yq4sG369icdDjiUuaUYF+QIocsyOzMyZ96
        6dklfwYDxpDR8zBjS9UOctta8RTPWdySmOX3yEYMR95FsXskw1nMviCP+PMybek5DF/0X+IpyocRP
        EyJH3qRjjaqcU8T1POIFwSGm8JuQrGsS7bSkVdiEvvyFtlhgXi/QeKMLOwtL1fLj1sJkSj49eoVk7
        Rq1JOT1cSqa/rkEd/K5MZ6L/4ug8N9I7xuy1skmNaJ7C5XLPffjET0T2Qhy5F0derdG4e41Uwu9TM
        wghnXc8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pVAo0-00CuV7-0x;
        Thu, 23 Feb 2023 12:34:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D174E30067B;
        Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B84AE2C86FE03; Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Message-ID: <20230223123319.428168721@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Feb 2023 13:26:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Subject: [PATCH 2/6] locking/rwsem: Enforce queueing when HANDOFF
References: <20230223122642.491637862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that HANDOFF disables all spinning and stealing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -468,7 +468,12 @@ static void rwsem_mark_wake(struct rw_se
 					adjustment -= RWSEM_FLAG_HANDOFF;
 					lockevent_inc(rwsem_rlock_handoff);
 				}
+				/*
+				 * With HANDOFF set for reader, we must
+				 * terminate all spinning.
+				 */
 				waiter->handoff_set = true;
+				rwsem_set_nonspinnable(sem);
 			}
 
 			atomic_long_add(-adjustment, &sem->count);
@@ -755,6 +760,10 @@ rwsem_spin_on_owner(struct rw_semaphore
 
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
+
+	if (owner == current)
+		return OWNER_NONSPINNABLE;	/* Handoff granted */
+
 	if (state != OWNER_WRITER)
 		return state;
 


