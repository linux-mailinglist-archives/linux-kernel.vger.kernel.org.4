Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9CD7086AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjERRWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjERRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7EE40
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC0F643A8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EF7C433EF;
        Thu, 18 May 2023 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684430533;
        bh=OZgSrTfO4ThuInBExHzNs7TMmFHDdgXi7iQ9bpEIZA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cu3GH6B/ShuAcPKltcQ4hxgZZVxbP8UZl0y4WcWeK3QhLDBZdN214TOVxev71vZXh
         syOW2/1dCV1I17xeAO0gV3hQPb96EBSv5e+hpv3qDJrhW+mbidSxkWbQN+mIBMqx8N
         Zkt/Md3dzX/R9AS2d84ruUZEuGhQ8UAbbfoeI1jfpbsSYbLsikeTr9oURt9a36ivMh
         gVjCuNfypMRZ2xcVNnxJcRYBV1GVmv6AEeKREAuE159PbAzmhVNNPYlrgdlTmLv4oF
         bHLVCqz/JTUBinIaYL0DJk2gya2wmJYMzG6O2h74U0rzHRO8lWENqTRSFW3eD2Isxd
         mFhryDZ+wvqEQ==
From:   SeongJae Park <sj@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 5/5] mm: ptep_deref() conversion
Date:   Thu, 18 May 2023 17:22:11 +0000
Message-Id: <20230518172211.84101-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518110727.2106156-6-ryan.roberts@arm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 12:07:27 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Convert all instances of direct pte_t* dereferencing to instead use
> ptep_deref() helper. By default, the helper does a direct dereference as
> before, but it can (and will) be overridden by the architecture to fully
> encapsulate the contents of the pte. Arch code is deliberately not
> converted, as the arch code knows best.
> 
> Conversion was done using Coccinelle:
> 
> ----
> 
> // $ make coccicheck \
> //          COCCI=ptepderef.cocci \
> //          SPFLAGS="--include-headers" \
> //          MODE=patch
> 
> virtual patch
> 
> @ depends on patch @
> pte_t *v;
> @@
> 
> - *v
> + ptep_deref(v)
> 
> ----
> 
> Then reviewed and hand-edited to avoid multiple unnecessary calls to
> ptep_deref(), instead opting to store the result of a single in a
> variable, where it is correct to do so. This will benefit arch-overrides
> that may be more complex than a simple (optimizable) pointer
> dereference.
> 
> Included is a fix for an issue in an earlier version of this patch that
> was pointed out by kernel test robot. The issue arose because config
> MMU=n elides definition of the ptep helper functions, including
> ptep_deref(). HUGETLB_PAGE=n configs still define a simple
> huge_ptep_clear_flush() for linking purposes, which dereferences the
> ptep. So when both configs are disabled, this caused a build error
> because ptep_deref() is not defined. Fix by continuing to do a direct
> dereference when MMU=n. This is safe because for this config the arch
> code cannot be trying to virtualize the ptes because none of the ptep
> helpers are defined.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305120142.yXsNEo6H-lkp@intel.com/
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
[...]
>  mm/damon/ops-common.c                         |   2 +-
>  mm/damon/paddr.c                              |   2 +-
>  mm/damon/vaddr.c                              |  10 +-

For above mm/damon/ part,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

