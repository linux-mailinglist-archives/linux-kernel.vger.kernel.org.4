Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D715B82E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiINI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiINI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:27:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCD6527C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7FbP/ITfgbOj5FbBPVf14A+eusiOzt/7bzMLu+ikvdA=; b=AYi1h6FG0FChkXsD0MOOKXZ4Zf
        fgpZHFdM4SWboDJ5G7Vszygks15NHsdcdGYcVohrkmSfp2zVD4rywDfJZDgBG79vby4rEtfK7kdo4
        3l/GLj5ZM3LWYCi17dVpUH97uxPILf3PkpoJPBPc1Lx2pLvw4YhgCOL20M/5pGlEfdSBFLPuWLfVn
        8Kn5pKjvQ4qJLdbMXV4WJb0EuqciRM0xM+V53DrGARwKplK1S+11v8UA7ESBbO0NbIUlUsGbAhxKx
        ZOXqct6DgupQBNOELiB496t70kOBSBJ/f/s/cScO8iSCU9AQaU7ZWU91+4g7O3E2tfVncunHQ1W3i
        GtPIp8XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYNjP-0000qz-PM; Wed, 14 Sep 2022 08:26:51 +0000
Date:   Wed, 14 Sep 2022 09:26:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCH 2/2] mm: introduce __GFP_TRACKLEAK to track in-kernel
 allocation
Message-ID: <YyGQS0Af7Vu7KPAj@casper.infradead.org>
References: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com>
 <1663126621-26926-2-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663126621-26926-2-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:37:01AM +0800, zhaoyang.huang wrote:
> ---
> v2: code update
> v3: update code and Documentation

This is really not good enough.  What changed?

The documentation is also not good enough.  It needs to mention:

 - This cannot be used for GFP_HIGHMEM allocations.
 - This cannot be used for pages which are mapped into userspace.

I also still want to see selftests.  order-0, order-N (with and without
__GFP_COMP).  What happens if you allocate an order-N page without
GFP_COMP, take an extra ref on the first page, call free_pages() and
then one of the recently-freed pages is allocated again while you still
have the reference on the first page?

I believe Andrew also suggested that 

if (PageTrackleak(page))

become always-false if the CONFIG option is disabled.

> +#ifdef CONFIG_HAVE_DEBUG_KMEMLEAK

This is the wrong CONFIG option, it should be CONFIG_DEBUG_KMEMLEAK.


Add to this the very real question of how useful is this, and I'm not
getting warm fuzzy feelings about where this patchset is heading.

