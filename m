Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E545E64F418
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLPW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:27:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358805FB87
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:27:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E52AFB81E2C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56420C433EF;
        Fri, 16 Dec 2022 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671229654;
        bh=hzy1hiFBPCnzXpEnk22ZSBgCkM7Z7HkItAy2prfBEyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cSUY2ZdGsqNUcmdlXkHRvtAK8zlaayBPKqovHUcABVrkqfFKSGVDAH/6PCRZxhVL6
         9Ph5D1d3kkon0n8hdplZSt4D258K+cGvlwwpnRBJTslTh83gABU+bmYFM6zN2DcKm1
         Vx2fab42NE8lGkDgBFyJzZxb4Cw38ay/kl6eZYds=
Date:   Fri, 16 Dec 2022 14:27:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        willy@infradead.org, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Message-Id: <20221216142733.e2a716a4cd7ea55240d98391@linux-foundation.org>
In-Reply-To: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 13:20:53 -0800 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> folio_set_compound_order() is moved to an mm-internal location so external
> folio users cannot misuse this function. Change the name of the function
> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
> handle the case if a non-large folio is passed and add clarifying comments
> to the function.
> 

This differs from the version I previously merged:

--- a/mm/internal.h~mm-move-folio_set_compound_order-to-mm-internalh-update
+++ a/mm/internal.h
@@ -384,8 +384,10 @@ int split_free_page(struct page *free_pa
  */
 static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
-	if (WARN_ON_ONCE(!folio_test_large(folio)))
+	if (!folio_test_large(folio)) {
+		WARN_ON_ONCE(order);
 		return;
+	}
 
 	folio->_folio_order = order;
 #ifdef CONFIG_64BIT

Makes sense.  But wouldn't

	if (WARN_ON_ONCE(order && !folio_test_large(folio)))

be clearer?
