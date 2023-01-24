Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B96795F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjAXLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjAXLCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:02:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B021E394;
        Tue, 24 Jan 2023 03:02:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFAD0219D4;
        Tue, 24 Jan 2023 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674558119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qIPJ4BajorMcKBe9rM/oMiSejSUgyU9LsAd5Im2601Y=;
        b=FGGJ6r+LfUZwKs12imYsOsTvCtHr1dK5SRTnB90Urs0AhVwA0sCMIVSo6Ua6Z2KRtpEnmz
        TnBb0ets/fOq2VLPfvHvNm9yBRezNpeJPnxrvaCqqCpIEneHW9R8MrW1aSajIHZOEi+n7u
        D/YAlp1ixlViSjRwyIfqf0XOPN6OJ9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674558119;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qIPJ4BajorMcKBe9rM/oMiSejSUgyU9LsAd5Im2601Y=;
        b=go7yQVD8PcQWxFnVVPJZmZehh/PwKtzb2vxbSKcVcnFVbz40SebNeyBFyj+xmdV+M/mB3e
        F36+7lj5eNbu3uBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D4EF13487;
        Tue, 24 Jan 2023 11:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6I9mHae6z2MVCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 Jan 2023 11:01:59 +0000
Message-ID: <bea284c3-fe7c-f55a-449d-07f47a364c1c@suse.cz>
Date:   Tue, 24 Jan 2023 12:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/1] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
References: <20230115184212.996298-1-rppt@kernel.org>
 <20230115184212.996298-2-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230115184212.996298-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/23 19:42, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Add structure, introduction and Nodes section to Physical Memory
> chapter.
> 
> As the new documentation references core-api/dma-api and mm/page_reclaim,
> add page labels to those documents.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

A small bug to fix below?

<snip>

> +
> +Along with the node structures, kernel maintains an array of ``nodemask_t``
> +bitmasks called ``node_states``. Each bitmask in this array represents a set of
> +nodes with particular properties as defined by ``enum node_states``:
> +
> +``N_POSSIBLE``
> +  The node could become online at some point.
> +``N_ONLINE``
> +  The node is online.
> +``N_NORMAL_MEMORY``
> +  The node has regular memory.
> +``N_HIGH_MEMORY``
> +  The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
> +  aliased to ``N_NORMAL_MEMORY``.

Noted.

> +``N_MEMORY``
> +  The node has memory(regular, high, movable)
> +``N_CPU``
> +  The node has one or more CPUs
> +
> +For each node that has a property described above, the bit corresponding to the
> +node ID in the ``node_states[<property>]`` bitmask is set.
> +
> +For example, for node 2 with normal memory and CPUs, bit 2 will be set in ::
> +
> +  node_states[N_POSSIBLE]
> +  node_states[N_ONLINE]
> +  node_states[N_NORMAL_MEMORY]
> +  node_states[N_MEMORY]
> +  node_states[N_CPU]

Should it be set also in node_states[N_HIGH_MEMORY]?


