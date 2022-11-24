Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A794636FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiKXBUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKXBUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:20:10 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D3B54EE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:20:09 -0800 (PST)
Date:   Wed, 23 Nov 2022 17:20:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669252808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kSoIk47rAwpiN9pabAp+IZRqQiebKCqHWLdT35A0A3E=;
        b=rW0ro0KVSJkzBJO/DFQ3lHOaWqdsvbxFKZ7ndm41ogrFFbp3F0jmavv+qF1GPQ60geBRqE
        0h7+J6e++wyQrY1+rfc16vzgYOCQWFwptmgOWsNISroA8jrbnmYRUf6xxD8VBksYpUoIP8
        k9Ructq1YdIVopdOMLFVM/g9NxzqI4E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] mm, slab: ignore SLAB_RECLAIM_ACCOUNT with
 CONFIG_SLUB_TINY
Message-ID: <Y37GxICuaRbwK+tj@P9FQF9L96D.corp.robot.car>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-8-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-8-vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:57PM +0100, Vlastimil Babka wrote:
> SLAB_RECLAIM_ACCOUNT caches allocate their slab pages with
> __GFP_RECLAIMABLE and can help against fragmentation by grouping pages
> by mobility, but on tiny systems mobility grouping is likely disabled
> anyway and ignoring SLAB_RECLAIM_ACCOUNT might instead lead to merging
> of caches that are made incompatible just by the flag.
> 
> Thus with CONFIG_SLUB_TINY, make SLAB_RECLAIM_ACCOUNT ineffective.

Hm, do you see disabling all kernel memory accounting functionality
with COFNIG_SLUB_TINY? I'd say yes. But in this case need to be consistent
and disable it alltogether.

Thanks!
