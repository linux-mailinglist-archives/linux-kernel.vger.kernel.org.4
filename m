Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27B6E2ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDNTqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CB422A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A70064448
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 19:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C61C433EF;
        Fri, 14 Apr 2023 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681501578;
        bh=zewFkR9CTXAmbKrqBvDqFQw5lqpR+BJt79rpHFOXU2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0I8xZsrNKj7OBFHOzz7WfdL8mYbG3v9DBNn4AR1hoDn7CwaMQhreC19smS7QI8DGX
         b95jA27HyHKo7FU/9JP5kJmWwosf1pTZUxHGfoCmZUi1DB3DvTormSAF3O/JdZYato
         AbRNNLDi9gHkDJEU4ziPRG3ho3m7M2o/2DVp2J58=
Date:   Fri, 14 Apr 2023 12:46:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Skip regions with hugetlbfs pages when
 allocating 1G pages
Message-Id: <20230414124617.c53cf4ce606cdcba54f65aa2@linux-foundation.org>
In-Reply-To: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
References: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 15:14:29 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> A bug was reported by Yuanxi Liu where allocating 1G pages at runtime is
> taking an excessive amount of time for large amounts of memory.
>
> ...
>
>                    6.3.0-rc6   6.3.0-rc6   6.3.0-rc6
>                      vanilla   revert-v1   hugeallocfix-v2
> Duration User           0.28        0.27        0.30
> Duration System       808.66       17.77       35.99
> Duration Elapsed      830.87       18.08       36.33
> 

I'll put a cc:stable on this.
