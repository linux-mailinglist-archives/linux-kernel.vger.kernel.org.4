Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC569C020
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBSMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:05:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37E10ABA;
        Sun, 19 Feb 2023 04:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gBSgmlok4yCxRuK+9Ez4kHo78avKwS+vMROQc68Os1E=; b=gu+lkdTl6i3jBnp2T+WS1qBpBP
        tiU0lKXykEcp1b/56CNTJl9x3GBg3QZP8uuvsqvl9yYHdD3Mk57T//M1M2gdqbCSyJ+cZADrjFjif
        YAJKnD0uD2j8Ol8bDa7vKM1RI6gt950wjZwtvsQkd8lkDnoT1jSLDqi27IVokAd+vllUJgeTvYVpK
        6V9rqF1sdxdr0ymWbCkAWSgg32MTv8vpmkZG26WoXM86WSEZBq/0wfJQvmXOLGU6Tho9LVYbprzJZ
        EkRoNXCDlmrEGytQvf7hI8Xa31RxQYkBiXZqf2pe8/6+VhnArV8RfKtZJuAEE/yHaYqHm61lSEpRa
        u7Fn9Gow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTiRp-00AuBi-65; Sun, 19 Feb 2023 12:05:41 +0000
Date:   Sun, 19 Feb 2023 12:05:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 1/3] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <Y/IQlWdD1NvcUROv@casper.infradead.org>
References: <20230219073318.366189-1-nphamcs@gmail.com>
 <20230219073318.366189-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219073318.366189-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 11:33:16PM -0800, Nhat Pham wrote:
> +++ b/mm/workingset.c
> @@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
>  	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
>  }
> 
> +/*
> + * Test if the folio is recently evicted.
> + *
> + * As a side effect, also populates the references with
> + * values unpacked from the shadow of the evicted folio.
> + */

I find this comment hard to understand.  First it talks about "the
folio", but it doesn't pass a folio.  Then it talks about "the
references", but I don't have any idea what those are either.

I think what you mean is,

 * Test if the shadow entry is for a folio which was recently evicted.
 * Fills in @memcgid, @pgdat, @token and @workingset with values
 * extracted from the shadow entry.

> +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> +		struct pglist_data **pgdat, unsigned long *token, bool *workingset)
> +{
> +	struct mem_cgroup *eviction_memcg;
> +	struct lruvec *lruvec;
> +	struct lru_gen_struct *lrugen;
> +	unsigned long min_seq;
> +
> +	unpack_shadow(shadow, memcgid, pgdat, token, workingset);
> +	eviction_memcg = mem_cgroup_from_id(*memcgid);
> +
> +	lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
> +	lrugen = &lruvec->lrugen;
> +
> +	min_seq = READ_ONCE(lrugen->min_seq[file]);
> +	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
> +}

[...]

> +/*
> + * Test if the folio is recently evicted by checking if
> + * refault distance of shadow exceeds workingset size.
>   *
> - * Calculates and evaluates the refault distance of the previously
> - * evicted folio in the context of the node and the memcg whose memory
> - * pressure caused the eviction.
> + * As a side effect, populate workingset with the value
> + * unpacked from shadow.
>   */

1. Shouldn't this be kernel-doc?
2. Again, don't use the term "side effect" here.  It's just one of
the things that the function _does_.

