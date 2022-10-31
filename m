Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265AE6131D8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJaInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJaInl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44710A8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16B0E61040
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06681C433D6;
        Mon, 31 Oct 2022 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667205817;
        bh=ZORsrJ+DI1lsCWe5MTS/iD4Fym79i/CO9pTJG5NNgoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGtiO1rrn5fISj2g8SbzKS1L2IFtrZ/5xVFdNzxLGc+il2TvvlrPA1ieXr1hxYo4D
         f2p5Nwk/NuJxY3a5+YVakaNeS0V6VtA+k0EHwGDF9sw/MU49Ag2sFoE9Nt0lOhsAqO
         774reLOCQpQZmJE0Rg43U+VqKhWdGLDS9JG+lvgG3dsMrNd641kpQqtQJxGGuSqtaU
         inEwhnR4TM3ARuYXW39pbmC5p2+zmmeVFAkJnre7drgOhPHwE11mRDJlyD650C3oPn
         HS8QwoM7xDROPlj83JLVmSBZLJX9brCgCuBP2wqOtVUybNX3uW086ny89Q03qM0XQV
         O6pbOsMgj9bHg==
Date:   Mon, 31 Oct 2022 10:43:24 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/5] memblock tests: add tests for
 memblock_alloc_exact_nid_raw
Message-ID: <Y1+KrIyFAOZ/oNqp@kernel.org>
References: <cover.1666203642.git.remckee0@gmail.com>
 <20221031050006.GA15612@sophie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031050006.GA15612@sophie>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rebecca,

On Mon, Oct 31, 2022 at 12:00:06AM -0500, Rebecca Mckeever wrote:
> Hi Mike,
> 
> I noticed that the memblock tree has been updated since I sent this
> patch set. Do you want me to send an updated patch set applied on top of
> the current tree?

No need, the only actual conflict is in TODO, I'll fix it while applying.
 
> On Wed, Oct 19, 2022 at 01:34:07PM -0500, Rebecca Mckeever wrote:
> > These patches add tests for memblock_alloc_exact_nid_raw(). There are two
> > sets of tests: range tests and NUMA tests. The range tests use a normal
> > (i.e., UMA) simulated physical memory and set the nid to NUMA_NO_NODE. The
> > NUMA tests use a simulated physical memory that is set up with multiple
> > NUMA nodes. Additionally, most of the NUMA tests set nid != NUMA_NO_NODE.
> > 
> > For the range tests, the TEST_F_EXACT flag is used to run the same set of
> > range tests used for memblock_alloc_try_nid_raw(). The NUMA tests have the
> > same setup as the corresponding test for memblock_alloc_try_nid_raw(), but
> > several of the memblock_alloc_exact_nid_raw() tests fail to allocate
> > memory in setups where the memblock_alloc_try_nid_raw() test would
> > allocate memory. Also, some memblock_alloc_exact_nid_raw() tests drop the
> > lower limit of the requested range in order to allocate within the
> > requested node, but the same setup in a memblock_alloc_try_nid_raw() test
> > allocates within the requested range.
> > 
> > ---
> > Changelog
> > 
> > v1 -> v2
> > PATCH 0:
> > - Add missing memblock_alloc_exact_nid_raw to subject line
> > 
> > v2 -> v3
> > Based on feedback from David Hildenbrand:
> > PATCH 1:
> > - alloc_nid_api.c, alloc_nid_api.h, common.h:
> >     + Add TEST_F_EXACT flag so that tests in alloc_nid_api.c can be run
> >       with that flag to test memblock_alloc_exact_nid_raw()
> > - alloc_exact_nid_api.c:
> >     + Update to run range tests in alloc_nid_api.c with TEST_F_EXACT flag
> >       instead of using a separate set of tests
> > - alloc_nid_api.c:
> >     + Rename tests and other functions by removing "_try" so that the
> >       function names are general enough to refer to any of the
> >       memblock_alloc_*nid*() functions of the memblock API
> > ---
> > 
> > Rebecca Mckeever (5):
> >   memblock tests: introduce range tests for memblock_alloc_exact_nid_raw
> >   memblock tests: add top-down NUMA tests for
> >     memblock_alloc_exact_nid_raw
> >   memblock tests: add bottom-up NUMA tests for
> >     memblock_alloc_exact_nid_raw
> >   memblock tests: add generic NUMA tests for
> >     memblock_alloc_exact_nid_raw
> >   memblock tests: remove completed TODO item
> > 
> >  tools/testing/memblock/Makefile               |    2 +-
> >  tools/testing/memblock/TODO                   |    7 +-
> >  tools/testing/memblock/main.c                 |    2 +
> >  .../memblock/tests/alloc_exact_nid_api.c      | 1113 +++++++++++++++++
> >  .../memblock/tests/alloc_exact_nid_api.h      |   25 +
> >  tools/testing/memblock/tests/alloc_nid_api.c  |  542 ++++----
> >  tools/testing/memblock/tests/alloc_nid_api.h  |    1 +
> >  tools/testing/memblock/tests/common.h         |    2 +
> >  8 files changed, 1425 insertions(+), 269 deletions(-)
> >  create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
> >  create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h
> > 
> > -- 
> > 2.25.1
> > 
> Thanks,
> Rebecca

-- 
Sincerely yours,
Mike.
