Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BEE69DACD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjBUGww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjBUGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:52:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751825299;
        Mon, 20 Feb 2023 22:52:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6EF60EFD;
        Tue, 21 Feb 2023 06:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78312C433D2;
        Tue, 21 Feb 2023 06:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676962359;
        bh=NxMBFmaYBDitbmp1sO4gaUOd+V6XgSphzGaJlOKkQig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHHLlnmf59g/vXjw7M/rQj5zhZe/8s4jGc/vNh/o1BGK5L/nk/7KvWGJA39yK2m06
         2ZmE1Q4dVqbaI++nAOWwLmbOtIqpPCUqCZFaFvGCUIYKFjiGgLXi0wNiLLM6zrcUUm
         1KC0LJYWTyxAzUyoIR3Kxo6/XqVWEKOqJ2wJtmmMoIHXKsC65JCBnfUkEcnW9UfNVe
         o/tm1pPNw4OhgRTjhiWw2lbLZsqAyJGROQ/FCZa8JXJ3ZCtI3WeEEuNEv/MWsQwl9A
         H9QKNSB2VFEJyecJVOXZQVQM1CGSqUXMsPkZMcCw9m43nbjlz6TOsqezoqEsI00qt6
         CTkH2EjRogxLg==
Date:   Tue, 21 Feb 2023 08:52:25 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] docs/mm: Physical Memory: add example of interleaving
 nodes
Message-ID: <Y/RqKbBeXLswC1AR@kernel.org>
References: <20230213154447.1631847-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213154447.1631847-1-rppt@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Mon, Feb 13, 2023 at 05:44:47PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Add an example of memory layout with interleaving nodes where even memory
> banks belong to node 0 and odd memory banks belong to node 1
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
> 
> v3:
> * Fix typos and wording (Matthew) 
> 
> v2: https://lore.kernel.org/all/20230212095445.1311627-1-rppt@kernel.org
> * Wording update (Bagas)
> * Add forgotten Suggested-by
> 
> v1: https://lore.kernel.org/all/20230211102207.1267058-1-rppt@kernel.org
>  Documentation/mm/physical_memory.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 3f3c02aa6e6e..863ddcd0b291 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -114,6 +114,25 @@ RAM equally split between two nodes, there will be ``ZONE_DMA32``,
>    |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
>    +---------+----------+-----------+ +------------+-------------+
>  
> +
> +Memory banks may belong to interleaving nodes. In the example below an x86
> +machine has 16 Gbytes of RAM in 4 memory banks, even banks belong to node 0
> +and odd banks belong to node 1::
> +
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
> +In this case node 0 will span from 0 to 12 Gbytes and node 1 will span from
> +4 to 16 Gbytes.
> +
>  .. _nodes:
>  
>  Nodes
> 
> base-commit: e076f253283c3e55a128fa9665c0e6cd8146948d
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
