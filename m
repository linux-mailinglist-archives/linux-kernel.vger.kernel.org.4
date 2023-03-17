Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8AA6BF696
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCQXkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQXkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAEE126E6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD3460E08
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 23:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E03C433D2;
        Fri, 17 Mar 2023 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679096377;
        bh=g9RvAI6uRrnZhaoxjUI04YdZRMrZ80xSpJJR25dnKgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gQo+D8FKH6tXI3+ox34wHy8t/QPnafy7eFKiPdN54CFWadsZCuuDbANMx8GdTqvUU
         2XLBLWTPdI2YrYHD1cwmJb+4MHHAn2OBq3xpcNt3lu30i1lauXgLD6ox6cBOq7jZgb
         7iEvYSxeR4KiIXLuw2sqk5y2l7hyYBAIZGoKQpuo=
Date:   Fri, 17 Mar 2023 16:39:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/2] Refactor do_fault_around()
Message-Id: <20230317163936.06d9c7d032a5c2296075caa1@linux-foundation.org>
In-Reply-To: <cover.1679089214.git.lstoakes@gmail.com>
References: <cover.1679089214.git.lstoakes@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 21:58:24 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> Refactor do_fault_around() to avoid bitwise tricks and arather difficult to
> follow logic.  Additionally, prefer fault_around_pages to
> fault_around_bytes as the operations are performed at a base page
> granularity.
> 
> I have run this code against a small program I wrote which generates
> significant input data and compares output with the original function to
> ensure that it behaves the same as the old code across varying vmf, vma and
> fault_around_pages inputs.

Well, what changes were you looking for in that testing? 
do_fault_around() could become a no-op and most tests wouldn't notice. 
What we'd be looking for to test these changes is performance
differences.

Perhaps one could add a tracepoint to do_fault_around()'s call to
->map_pages, check that the before-and-after traces are identical.


Or, if you're old school and lazy,

	if (!strcmp(current->comm, "name-of-my-test-program"))
		printk("name-of-my-test-program: %lu %lu\n",
			start_pgoff, end_pgoff)

then grep-n-diff the dmesg output.
