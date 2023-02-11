Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D4F693103
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBKMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBKMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:40:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589142E832;
        Sat, 11 Feb 2023 04:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07339B80959;
        Sat, 11 Feb 2023 12:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9BDC433D2;
        Sat, 11 Feb 2023 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676119204;
        bh=aWDu0wdaNGNHbr/t7iwUocZHZ6ZgfnT9uKvdgixjfdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGwSk8wL2riXMuWuBnlUl7O+iT+PFvFShfCysKnXOCyk6Ycfm91eqtfzDdk4wvXiI
         GVuywTxIzOI0LekcAiyaReMbhcMBdxqB2cuDsp0d8dpTMjg++wL9NBbmcMLR9lT8sG
         BIyOO9Mwky5wKwqH4NXQXDDSkn0abE8BM5DxziDpRdAPVP4EGkRxaRjyN2cWepqKRd
         qtPqEqQnwfovGDdzgaOAQITRO6sHtFku06kuh/WUPaUcfAmDrJ41ltdBnbKQ6ykVQX
         /DUUjj28KB4iLxu6Qhp0A99a2IByB7kmYjUUUHBXKp3HIQ5skpnHB024gOo9C23zkv
         FsvVXRcLAJ8Rw==
Date:   Sat, 11 Feb 2023 14:39:49 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: add example of interleaving
 nodes
Message-ID: <Y+eMlVmn7uXslV7O@kernel.org>
References: <20230211102207.1267058-1-rppt@kernel.org>
 <330367aa-6d34-2341-9d24-5f2e09aecfdf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330367aa-6d34-2341-9d24-5f2e09aecfdf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 07:31:18PM +0700, Bagas Sanjaya wrote:
> On 2/11/23 17:22, Mike Rapoport wrote:
> > +Note, that memory banks may belong to interleaving nodes. In the example
> > +below an x86 machine has 16Gbytes or RAM in 4 memory banks, even banks
> > +belong to node 0 and odd banks belong to node 1::
> > +
> > +
> > +  0              4G              8G             12G            16G
> > +  +-------------+ +-------------+ +-------------+ +-------------+
> > +  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
> > +  +-------------+ +-------------+ +-------------+ +-------------+
> > +
> > +  0   16M      4G
> > +  +-----+-------+ +-------------+ +-------------+ +-------------+
> > +  | DMA | DMA32 | |    NORMAL   | |    NORMAL   | |    NORMAL   |
> > +  +-----+-------+ +-------------+ +-------------+ +-------------+
> > +
> > +In such case node 0 will span from 0 to 12 Gbytes and node 1 will span from
> > +4 Gbytes to 16 Gbytes.
> > +
> 
> What about "... and node 1 will span from 4 to 16 Gbytes"?
 
Sure.

> -- 
> An old man doll... just what I always wanted! - Clara
> 

-- 
Sincerely yours,
Mike.
