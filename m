Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054765F518
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjAEURE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjAEURC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:17:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584DDFB2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:17:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C51ABB81BC0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 20:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55F4C433F0;
        Thu,  5 Jan 2023 20:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672949818;
        bh=r3UUh01lMIQpHkRFoc0xsCt5i0tnsap0EO6qM6kQfmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZ41CXtxvnwcp4WgInyMxrMcSIoEwQbVWAd8MAelnrZzGFRcvmgFQX/ZtqSRZ9NQf
         Y339Drwthb7PxFoFu6G7iK89Oj3nCKBywcyC4wUWvr58X1iZd/g3Y09r8d3U7jx07l
         CQPTKHTVIYZ8Bot2f+1Ucwhs5OnOBBzcm3vcmpaMLI8K4n/iXSwKk6691Mv1JYiIed
         y8OQqRGxc6Hy96BlbAGWtsz3P0O6WwDgJn+jP7iZYN+QlbSaNAeol1wuaDKTxwx2Zc
         Rb7l87axgTRk5TTyLktKRipIn+vvguBBQC4VqXw6SW6awlDVYVhmAJi4sN/FvEwbHr
         Bpz98GnoTxjTw==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     SeongJae Park <sj@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 26/44] mm/damon: Stop using vma_mas_store() for maple tree store
Date:   Thu,  5 Jan 2023 20:16:56 +0000
Message-Id: <20230105201656.49522-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105195213.acthhrocx5vz33uy@revolver>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Thu, 5 Jan 2023 19:52:21 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * SeongJae Park <sj@kernel.org> [230105 14:33]:
> > Hi Liam,
> > 
> > On Thu, 5 Jan 2023 19:16:00 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > 
> > > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > 
> > > Prepare for the removal of the vma_mas_store() function by open coding
> > > the maple tree store in this test code.
> > 
> > But seems this series is not really removing 'vma_mas_store()'.  Wouldn't it
> > better to do the preparation and removal together in a same patch series?
> 
> It does from the all code but the nommu side.  The definition is dropped
> from the header and c file in "mmap: Convert __vma_adjust() to use vma
> iterator" [1].

Thank you for nice explanation.

> 
> > 
> > > Set the range of the maple
> > > state and call the store function directly.
> > > 
> > > Cc: SeongJae Park <sj@kernel.org>
> > > Cc: damon@lists.linux.dev
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >  mm/damon/vaddr-test.h | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > > index bce37c487540..41532f7355d0 100644
> > > --- a/mm/damon/vaddr-test.h
> > > +++ b/mm/damon/vaddr-test.h
> > > @@ -24,8 +24,10 @@ static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> > >  		return;
> > >  
> > >  	mas_lock(&mas);
> > > -	for (i = 0; i < nr_vmas; i++)
> > > -		vma_mas_store(&vmas[i], &mas);
> > > +	for (i = 0; i < nr_vmas; i++) {
> > > +		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > > +		mas_store_gfp(&mas, &vmas[i], GFP_KERNEL);
> > > +	}
> > 
> > On the latest mm-unstable, vma_mas_store() uses mas_store_prealloc() instead of
> > mas_store_gfp().  Seems the difference would make no problem to this test code
> > in most cases, but could I ask the reason for this change?
> 
> mas_store_prealloc() expects the maple state to have the necessary
> memory to store the value.  Using this function is the right way of
> storing the range.  In fact, we would only need a single node since
> these values will be append operations anyways.

Again, thank you for nice explanation.

> 
> > 
> > Also, should we check the return value of mas_store_gfp()?
> 
> I can add this.  The only reason we would return an error is on ENOMEM
> which seems unlikely here.  Again, it is a single node that will be
> used.  The size is 256B, but it's safer to add the check.

You're right.  I'd prefer having the check, but I'd not block this for the
trivial nit.

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
> [1] https://lore.kernel.org/linux-mm/20230105191517.3099082-28-Liam.Howlett@oracle.com/
> 
> 
> Thanks,
> Liam
> 
