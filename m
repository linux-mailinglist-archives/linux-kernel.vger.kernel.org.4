Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9C747A94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGDX5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGDX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:57:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A10DE41
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=12jw7f37Y05R+QFxMlhYK7Zaoz60JCyqvKUQKE8Aprs=; b=Epqs/HbhRoft4XM5q4tKqGXcOk
        0jFcDZF01KB1zjYQKv3tprKnDYITw7X/XyAc/PgoK/A9BZ3ihs3DLb8XObg0zwQDK1FbGPv772wGN
        /xryW9aQF7CGjipkbPDIER5mW30SKc+Og96eGXmIXmPUYDT41vo6lWNzei6pDwmT5dkcnuR/MKeg5
        qHm+Ske3XlDLBrTexloPScJF48aex2SNsVUbuGhWUHVnY7nNVZ9zR/9CL0+5UpX/rWMCANtBMG72B
        sO9aRAtmguhssvFIAK3GT/rZCXXbwKQJSGkju+K8UPR6UWB83MyCPo3o9GRc1tES700+9+hfc13Zh
        ilOVsdTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGptd-009ZtG-FJ; Tue, 04 Jul 2023 23:57:25 +0000
Date:   Wed, 5 Jul 2023 00:57:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
Message-ID: <ZKSx5Udt3Oh8Kr35@casper.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <6865a59e-9e40-282d-c434-b7c757388b65@intel.com>
 <f364d9f1-8f7b-f531-ab9e-400c57a60c16@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f364d9f1-8f7b-f531-ab9e-400c57a60c16@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 03:20:35PM +0100, Ryan Roberts wrote:
> On 04/07/2023 04:45, Yin, Fengwei wrote:
> > 
> > On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> >> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
> > THP is for huge page which is 2M size. We are not huge page here. But
> > I don't have good name either.
> 
> Is that really true? On arm64 with 16K pages, huge pages are 32M and with 64K
> base page, they are 512M. So huge pages already have a variable size. And they
> sometimes get PTE-mapped. So can't we just think of this as an extension of the
> THP feature?

The confusing thing is that we have counters for the number of THP
allocated (and number of THP mapped), and for those we always use
PMD-size folios.

If we must have a config option, then this is ANON_LARGE_FOLIOS.

But why do we need a config option?  We don't have one for the
page cache, and we're better off for it.  Yes, it depends on
CONFIG_TRANSPARENT_HUGEPAGE today, but that's more of an accidental
heritage, and it'd be great to do away with that dependency eventually.

Hardware support isn't needed.  Large folios benefit us from a software
point of view.  if we need a chicken bit, we can edit the source code
to not create anon folios larger than order 0.
