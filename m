Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2CC608CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJVLsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJVLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B6D24F785
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RY5OJVKm7PHKfP6ch20ecx7TX/MGByzkwaP5zQXVje4=; b=OJUNT+dm8Xm8G4HKPUJTT88+5b
        tS7rS4Xte2tScbrsFmj1YbzEc81Fk6njpuY3V7B/fQSSRiowYqw06hkfp4K7lil+cYoEilAlK626c
        skvA6gh56x7NxdcMn/+qHQbgcePeOyPqteTa64FhrQD2XdvJRo7DyDyAcFyvMhNpo/ScLaXybnWgd
        N35tVDujd87+4UpkzlXOj/vEoKlK+9YprxpUkKPWJwSBL6UY46tD9qx15+E/rcO3cvGY6EFN4XohB
        8Ot3mLfMet0JZV34mz6DbGldZ+616MqADT10saDPFs+Rw1ii0z/QnTUVeBnufCvLBhWNZ13DQWN5F
        7HXKoxeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzM-005XdU-WF; Sat, 22 Oct 2022 11:48:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6086303109;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 518E428B8E518; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114425.298833095@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 13/13] mm: Remove pointless barrier() after pmdp_get_lockless()
References: <20221022111403.531902164@infradead.org>
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

pmdp_get_lockless() should itself imply any ordering required.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/hmm.c    |    1 -
 mm/vmscan.c |    3 ---
 2 files changed, 4 deletions(-)

--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -362,7 +362,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		barrier();
 		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
 			goto again;
 
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4041,9 +4041,6 @@ static void walk_pmd_range(pud_t *pud, u
 	for (i = pmd_index(start), addr = start; addr != end; i++, addr = next) {
 		pmd_t val = pmdp_get_lockless(pmd + i);
 
-		/* for pmdp_get_lockless() */
-		barrier();
-
 		next = pmd_addr_end(addr, end);
 
 		if (!pmd_present(val) || is_huge_zero_pmd(val)) {


