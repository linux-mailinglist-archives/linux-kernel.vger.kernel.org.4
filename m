Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9669672E90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjASCA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjASCA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:00:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014C768B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD6A6B81D66
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBCBC433D2;
        Thu, 19 Jan 2023 02:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674093652;
        bh=9rGecye3A9HkDxj4QdN4bMjjPezDbh4TPWj5J+UblD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkPS7iYmiXYaAW5OuXRSyAewoWMJ2IJibKOY5fHSz96x73zwuAWt+FUjg0aYpZ9IB
         OYDI2zVKoIr2Cn2OobjNxGvxfe5B8q0j/0/6dkh4+Ae2Ck+wdMCl3hS0WA4yHFQsS7
         d/57YfEPy32BRMpjS5CL9BVXeT0WNKhfFzfcapHfcobaHHBv/Xv/auDPqsNbnwtD7A
         BgtyQbHQNpOEPpasDEyE8Of9AvstYHHunN8XDfd2PBPZPHmYlZlqiAia/5Yi0eeboe
         QtAy+UxbjWiJ3tpj65/fsFlc92zx0jvDenEH7ruzWPKJD/m3hqF/RY+gV9jHxWHTsm
         cjeqyyBm4wcTg==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        SeongJae Park <sj@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple tree store
Date:   Thu, 19 Jan 2023 02:00:50 +0000
Message-Id: <20230119020050.2156-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117224734.c4lo4spezufwsims@revolver>
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

Hello Daniel and Liam,


Sorry for late reply.

On Tue, 17 Jan 2023 22:47:36 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * Daniel Latypov <dlatypov@google.com> [230117 17:20]:
> > On Tue, Jan 17, 2023 at 11:11 AM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Cc-ing kunit people.
> > >
> > > Hi Liam,
> > >
> > >
> > > Could we put touching file name on the summary?
> > > E.g., mm/damon/vaddr-test: Stop using ...
> > >
> > > On Tue, 17 Jan 2023 02:34:19 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > >
> > > > Prepare for the removal of the vma_mas_store() function by open coding
> > > > the maple tree store in this test code.  Set the range of the maple
> > > > state and call the store function directly.
> > > >
> > > > Cc: SeongJae Park <sj@kernel.org>
> > > > Cc: damon@lists.linux.dev
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > ---
> > > >  mm/damon/vaddr-test.h | 19 +++++++++++++------
> > > >  1 file changed, 13 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > > > index bce37c487540..6098933d3272 100644
> > > > --- a/mm/damon/vaddr-test.h
> > > > +++ b/mm/damon/vaddr-test.h
> > > > @@ -14,19 +14,26 @@
> > > >
> > > >  #include <kunit/test.h>
> > > >
> > > > -static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> > > > +static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
> > > >                       ssize_t nr_vmas)
> > > >  {
> > > > -     int i;
> > > > +     int i, ret = -ENOMEM;
> > > >       MA_STATE(mas, mt, 0, 0);
> > > >
> > > >       if (!nr_vmas)
> > > > -             return;
> > > > +             return -ENOENT;
> > 
> > We could pass in the `test` object here and give more detailed info, e.g.
> >   (if !nr_vmas)
> >      kunit_skip(test, "...");
> > 
> > And below could be
> > 
> > bool stored_all = false; // instead of ret
> > ...
> > for (...) {
> > 
> > }
> > stored_all = true;
> > 
> > failed:
> >   mas_unlock(&mas);
> >   if (!stored_all) kunit_skip(test, "failed to...");
> > 
> > > >
> > > >       mas_lock(&mas);
> > > > -     for (i = 0; i < nr_vmas; i++)
> > > > -             vma_mas_store(&vmas[i], &mas);
> > > > +     for (i = 0; i < nr_vmas; i++) {
> > > > +             mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > > > +             if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > > > +                     goto failed;
> > > > +     }
> > > > +     ret = 0;
> > > > +
> > > > +failed:
> > > >       mas_unlock(&mas);
> > > > +     return ret;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -71,7 +78,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
> > > >       };
> > > >
> > > >       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> > > > -     __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
> > > > +     KUNIT_EXPECT_EQ(test, __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)), 0);
> > >
> > > In case of the __link_vmas() failure, I think we should skip this test using
> > > 'kunit_skip()', rather marking this test failed.
> > 
> > As noted above, I'd suggest we also pass in the `test` object to
> > __link_vmas() and call kunit_skip() from there.
> 
> My thoughts were if we are testing adding nothing to the list, then
> there is probably a problem with the test and so that should be
> highlighted with a failure.
> 
> I really don't mind either way.

I didn't wrote '__link_vmas()' to test vma manipulation functions it internally
uses, but just to offload test setup for 'damon_test_three_regions_in_vmas()'.
I agree that the detailed failure reason could be helpful for better
understanding as the function can now fail from 'mas_store_gfp()'s memory
allocation failure.

That said, I think we can get the detail from the return value of
'__link_vmas()'. I'm further worrying if passing 'test' object to the function
makes people think the function itself is for testing something inside it.

Also, I don't think the function returning non-error for zero value 'nr_vmas'
as a problem but just expected behavior, as previously commented[1].

So I'd prefer doing kunit_skip() here.

If I'm missing something or wrong, please let me know.

[1] https://lore.kernel.org/damon/20230117191614.116521-1-sj@kernel.org/


Thanks,
SJ
