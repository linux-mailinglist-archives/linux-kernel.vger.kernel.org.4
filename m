Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C363E720B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjFBVny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjFBVnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF23D1B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 14:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28DA960EA8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 21:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753E0C433D2;
        Fri,  2 Jun 2023 21:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685742230;
        bh=dqPx4FOL2k0vRoOh1SeNQzO8jYCMtTwE1Ahz/eh3gWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T52eh37fLsuybop6dfq6Nc8yKoSXXOHxovVdxoFd9k8e2VfWvAUB4A4hiv7Jv8CNe
         zH+LUIgfbwxbQgIkLmqV3x2P4RGiSSUUmzQisCmroRZAMYxMVt2MpfLkIAJbC7BotO
         9rVVBlFEjzaaszmESNpP7VuA7nbl/8vajzWsWwgDVioznI2T69IqqO6PwP6mWK4iOs
         LZaFc1VbjNFI8IS7mYO6ya8ylT7Igt2vFCKAEdBKweypt0OW5/ZZ2LNa8GVvXej30K
         fZ5naFmS+rOfoytDwnjxUDA1Klx2325hWNtnB2nHoRVTy+raNQe/0q+qmrC7tRoVdV
         79L1lsAnA0wUQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear young on ptes and pmds
Date:   Fri,  2 Jun 2023 21:43:47 +0000
Message-Id: <20230602214347.85694-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602191501.85553-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 19:15:01 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Ryan,
> 
> On Fri, 2 Jun 2023 18:14:25 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
> > On 02/06/2023 17:35, Yu Zhao wrote:
> > > On Fri, Jun 2, 2023 at 3:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> > >>
> > >> It is racy to non-atomically read a pte, then clear the young bit, then
> > >> write it back as this could discard dirty information. Further, it is
> > >> bad practice to directly set a pte entry within a table. Instead
> > >> clearing young must go through the arch-provided helper,
> > >> ptep_test_and_clear_young() to ensure it is modified atomically and to
> > >> give the arch code visibility and allow it to check (and potentially
> > >> modify) the operation.
> > >>
> > >> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
> > > 
> > > Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
> > > deemed unnecessary?
> > 
> > It was overlooked - incompetance strikes again! I was intending to cc the
> > whole series.
> 
> Not the whole patches in this series but only this patch is intended to be
> merged in stable series, right?  If I'm not wrong, you could add
> 'Cc: <stable@vger.kernel.org>' tag here[1] when resending, to let stable kernel
> maintainers easily understand exactly what patches should be merged in the
> stable kernels.  So, you wouldn't need to touch coverletter or cc whole series
> but only this one.
> 
> [1] https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html

And I just found Andrew added the tag while adding this to the -mm queue.
Thank you, Andrew!

[1] https://lore.kernel.org/mm-commits/20230602205509.9DFBDC433D2@smtp.kernel.org/


Thanks,
SJ

> 
> 
> Thanks,
> SJ
> 
