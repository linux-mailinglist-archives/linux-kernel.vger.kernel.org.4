Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA667A4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjAXVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjAXVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:20:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577CA8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:20:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso15331363pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBxYXf9XQKgQ+wbszOVA6b3m7kHIkaxtHTOSxwRTgZI=;
        b=WTNrPifpA1xZC9rsK9aKpgWZhNP9vDDNuhSBHRGYbNZGqym2iqnnzc/etpIYKjSied
         3IWGHZGxPvNGBP0IOl/e9vy5pH6s7+wX0y0ZAFEFozZb2s4TZckzqxUgY44qfiFddtS4
         CIVDKk2KTUuepqvFp5DRQ7G3OOVEx+vS6MMrgA0V28ZZ1CWmCVPidIq3DNbj4Qs215qw
         JrY8nhxugqzaaWaXJMbjiqnco1BsOVtZD5cD028B4PNXwd6GPG9tAQTFGmCcw0wIhjSH
         MuCAyVqaoF7+MVSAr2ejQPglXtipsJe9YRDSH3PJ2UYdG9q+ZDT9+91REQDBHAlZDR1C
         FsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBxYXf9XQKgQ+wbszOVA6b3m7kHIkaxtHTOSxwRTgZI=;
        b=LRF765nrNBgzTvP8xhh9wVdHOKS7FzQssItqF8KDuhr90V8lPKT4n92IX2s6N3pvzX
         1N7o1ubbOT78eb7xa7kGYDgBauhErQLsE1DzFjjswBFJPAXbiQSTJP7hyy+cCnP/MEkm
         AWUjIQxUyd8Iu/HtEVMIc628sgvsdNmUAtD3uS+9ZIkHA0TlVpPy07wNWHOrXc8sgnJP
         RDqjM8wrzWT3WC9vXd0pMh25sy1pQvAg8MzZdGnTFl7rEjhgVDhFYTnUu1OxUBTn9F1l
         CBx5tqSK+rh7cCYit0Z8XQCcFZmfup4RmGYs/Imv1YxT2geBJjmi1KzInmgokIN+XTY+
         beHA==
X-Gm-Message-State: AO0yUKVURZTubC87chK+c/KSVdjBHuQDLCBqfOnZKG52WlRo2Y1jxR8W
        qh3aQwp/23H24NxpfofdCpUXAQ==
X-Google-Smtp-Source: AK7set9wh5O2XAdu9rmI1KvS2VWwgf5eHBuZHh/IwPFhtV3HwjOBCkugj/VEbmqZb2xkQGz6PpitVA==
X-Received: by 2002:a05:6a20:8f1a:b0:b8:c646:b0e2 with SMTP id b26-20020a056a208f1a00b000b8c646b0e2mr442277pzk.3.1674595202115;
        Tue, 24 Jan 2023 13:20:02 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:b15:b561:51fb:73c3])
        by smtp.gmail.com with ESMTPSA id c32-20020a17090a492300b002265ddfc13esm8868770pjh.29.2023.01.24.13.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 13:20:01 -0800 (PST)
Date:   Tue, 24 Jan 2023 13:19:57 -0800
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-ID: <Y9BLfUz5GY69zmjn@google.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
 <Y8gpfgEXtialPVLk@arm.com>
 <Y8neaPB2y689WKOf@google.com>
 <Y8/96eIu47UfqsWO@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/96eIu47UfqsWO@arm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:48:57PM +0000, Catalin Marinas wrote:
> Thanks for digging this out. This patch shouldn't have ended up upstream
> (commit 972fa3a7c17c "mm: kmemleak: alloc gray object for reserved
> region with direct map"). I thought both Calvin Zhang and I agreed that
> it's not the correct approach (not even sure there was a real problem to
> fix).
> 
> Do you still get the any faults with the above commit reverted? I'd
> prefer this if it works rather than adding unnecessary
> kmemleak_alloc/free callbacks that pretty much cancel each-other.
Yes, I still see the same problem after reverting that commit. The problem
still persists because there are CMA areas that are allocated through
memblock_phys_alloc_range(), which invokes kmemleak_alloc_phys(). The
allocation call stack is along the lines of:

kmemleak_alloc_phys()
memblock_alloc_range_nid()
memblock_phys_alloc_range()
__reserved_mem_alloc_size()
fdt_init_reserved_mem()

I also followed up on my suggestion about adding a flags parameter to
the memblock allocation functions to be able to use
MEMBLOCK_ALLOC_NOLEAKTRACE in this particular scenario, but that would
involve changing many call-sites, which doesn't make much sense given
that there are only 4 call-sites that actually use this flag.

Maybe adding a new memblock allocation function that allows this flag to
be passed as just a flag can be used to avoid creating these kmemleak
objects for CMA allocations?

--Isaac
