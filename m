Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB21693714
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBLLub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:50:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242B10241;
        Sun, 12 Feb 2023 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F/oUvUqcxxSsH3QTIuSHpDyRj938YvYs4yZVYvuW6Rc=; b=rmaO8vWmZ2RMO07OUH3V7ba7S8
        P1CwTAdZQunhfRFsb2o20pzOAlNCcBth+jahyoTS0xevTa+vwncTRpg9rVHO8blya2jZbbjmlQnca
        lk4pIV887StNb+63EpDyZaZG47FSqzQSTAUXG0raiMj0p3IsrvvzWr17tOl/dA6qRWIRBE0Wh/VaO
        qhKEh+fo9F6kaeaEHEOl/t6zBISbcYe+taXuuCiReEgJayAy2ZBtIKkZGQWbOKVRqp7EegNcEd+VW
        ZhvPfav/OSx8HIul7vfUkYWKNG9XWiv48YJ8hLaaT/jDNhPB0srzyLOCwG+Ekys+nqbjbEJw+4beY
        qhPJc5Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRArw-004pM7-BH; Sun, 12 Feb 2023 11:50:08 +0000
Date:   Sun, 12 Feb 2023 11:50:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] docs/mm: Physical Memory: add example of interleaving
 nodes
Message-ID: <Y+jScFT/qyXSPESp@casper.infradead.org>
References: <20230212095445.1311627-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212095445.1311627-1-rppt@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 11:54:45AM +0200, Mike Rapoport wrote:
> +Note, that memory banks may belong to interleaving nodes. In the example
> +below an x86 machine has 16Gbytes or RAM in 4 memory banks, even banks
> +belong to node 0 and odd banks belong to node 1::

s/or RAM/of RAM/

The "Note," is superfluous, you can just write:

Memory banks may belong to interleaved nodes.

And I think we prefer the newer form "GiB" for new documentation.

> +
> +  0              4G              8G             12G            16G
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +
> +  0   16M      4G
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +  | DMA | DMA32 | |    NORMAL   | |    NORMAL   | |    NORMAL   |
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +
> +In such case node 0 will span from 0 to 12 Gbytes and node 1 will span from
> +4 to 16 Gbytes.

s/such/this/ (and I'd use GiB again)
