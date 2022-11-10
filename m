Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F41E6242AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKJM64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiKJM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:58:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5236F70199
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0TJ9GM3QmpQqqobwlFgaZAhiMEzovhIsHgiWH55IfFY=; b=XVvw5AjHBW7Sr896LTSC7q1lTz
        TmNKXxDIJ+ya8FM34oNVTeso6esOE++ayL2r+MfpByrxlZ1WpZ0ItL/7Tcbui7nrjSENwsg9VzgOL
        acJlrVu58mBRM4xnRZdYOZtjr5BoW0i8yAtlHxzgl/inBU8mzdgfPo2rxKakdabucPTGh9u8YXUhj
        jMqLjW4pEp2MCEzv8glvWlQK8GaPPvqO0hbeK56/q049j5MrO6D7lAoMadiIbPtjBsZhL3q5mU9k4
        6qrbtAafR93T7d+qoGY05eYmUBf6bgjl6PM3dDntz3tEBIw6prMQdhWdDWFWJQMaKLVBhtJ41SFjs
        o58/HQZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot78X-00AHCi-A2; Thu, 10 Nov 2022 12:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF382300C26;
        Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AEFD02B31AD65; Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Message-ID: <20221110125544.661001508@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 13:52:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, oliver.sang@intel.com
Subject: [PATCH 4/4] x86/mm: Rename __change_page_attr_set_clr(.checkalias)
References: <20221110125253.240704966@infradead.org>
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

Now that the checkalias functionality is taken by CPA_NO_CHECK_ALIAS
rename the argument to better match is remaining purpose: primary,
matching __change_page_attr().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1635,7 +1635,7 @@ static int __change_page_attr(struct cpa
 	return err;
 }
 
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias);
+static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary);
 
 /*
  * Check the directmap and "high kernel map" 'aliases'.
@@ -1712,7 +1712,7 @@ static int cpa_process_alias(struct cpa_
 	return 0;
 }
 
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
+static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 {
 	unsigned long numpages = cpa->numpages;
 	unsigned long rempages = numpages;
@@ -1736,13 +1736,13 @@ static int __change_page_attr_set_clr(st
 
 		if (!debug_pagealloc_enabled())
 			spin_lock(&cpa_lock);
-		ret = __change_page_attr(cpa, checkalias);
+		ret = __change_page_attr(cpa, primary);
 		if (!debug_pagealloc_enabled())
 			spin_unlock(&cpa_lock);
 		if (ret)
 			goto out;
 
-		if (checkalias && !(cpa->flags & CPA_NO_CHECK_ALIAS)) {
+		if (primary && !(cpa->flags & CPA_NO_CHECK_ALIAS)) {
 			ret = cpa_process_alias(cpa);
 			if (ret)
 				goto out;


