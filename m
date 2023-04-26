Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB306EEC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbjDZCWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbjDZCWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:22:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE158688;
        Tue, 25 Apr 2023 19:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682475722; x=1714011722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aZSnevCV0ZRoHK+SA5IxOde8adJ7cTFjbdtLQdZjCrA=;
  b=dQn0yCXm9RqN6DYVe8IuUVa2iDTPXDkYChbDjtacrLCnnKRZgHX66w3o
   q8jf+yVzww9SAp9LWIfWy2ZLjcvhB8LQor7aJKljR3rGuKdaZq7YmQ8UT
   gSQKqBk5x5jKwrdLqDVqNZjTw3DBxBVJsYpYfwUwaA2t4G29KAom28dr9
   YivFtZ3zslKSBxgb6Jls0FplVlyCs3MKzj9t7d6OlwPmKBLAUOfN8LxeV
   pwnNQN6daCCuW696+t3plxalkJUFJV3pyTbHj/3zq+LENlJw+a+5hLb9w
   LqdidmdP3DBU4P/GWNr1/CfJDzDr9q1gq8nhpgcyN8AOgAkmXKVQv2WSB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="345718608"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="345718608"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 19:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="763111662"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="763111662"
Received: from linux.bj.intel.com ([10.238.156.127])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 19:21:59 -0700
Date:   Wed, 26 Apr 2023 10:20:34 +0800
From:   Tao Su <tao1.su@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] Remove blkg node after destroying blkg
Message-ID: <ZEiKcqqxqWtY2MQA@linux.bj.intel.com>
References: <20230425075911.839539-1-tao1.su@linux.intel.com>
 <aa5de32c-c92b-d032-e9bb-83d2436ff72c@huawei.com>
 <ZEegQCCZ96ij6mw5@linux.bj.intel.com>
 <6d486f85-87ed-fa35-00cb-4c37fef17536@huaweicloud.com>
 <9f5eeba2-fbc9-3b56-c7ed-d8ecc1c888b3@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f5eeba2-fbc9-3b56-c7ed-d8ecc1c888b3@huaweicloud.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 09:13:08AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/04/25 19:09, Yu Kuai 写道:
> > Hi,
> > 
> > 在 2023/04/25 17:41, Tao Su 写道:
> > > On Tue, Apr 25, 2023 at 04:09:34PM +0800, Yu Kuai wrote:
> > > > Hi,
> > > > 
> > > > 在 2023/04/25 15:59, Tao Su 写道:
> > > > > Kernel hang when poweroff or reboot, due to infinite restart
> > > > > in function
> > > > > blkg_destroy_all. It will goto restart label when a batch of blkgs are
> > > > > destroyed, but not remove blkg node in blkg_list. So the blkg_list is
> > > > > same in every 'restart' and result in kernel hang.
> > > > > 
> > > > > By adding list_del to remove blkg node after destroying, can solve this
> > > > > kernel hang issue and satisfy the previous will to 'restart'.
> > > > > 
> > > > > Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> > > > > Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> > > > > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > > > > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > > > > ---
> > > > >    block/blk-cgroup.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > > > index bd50b55bdb61..960eb538a704 100644
> > > > > --- a/block/blk-cgroup.c
> > > > > +++ b/block/blk-cgroup.c
> > > > > @@ -530,6 +530,7 @@ static void blkg_destroy_all(struct gendisk *disk)
> > > > >            spin_lock(&blkcg->lock);
> > > > >            blkg_destroy(blkg);
> > > > > +        list_del(&blkg->q_node);
> > > > 
> > > > blkg should stay on the queue list until blkg_free_workfn(), otherwise
> > > > parent blkg can be freed before child, which will cause some known
> > > > issue.
> > > 
> > > Yes, directly removing blkg node is not appropriate, which I noticed some
> > > comments in blkg_destroy(), thanks for pointing out this issue.
> > > 
> > > > 
> > > > I think this hung happens when total blkg is greater than
> > > > BLKG_DESTROY_BATCH_SIZE, right?
> > > 
> > > Yes, you are right.
> > > 
> > > > 
> > > > Can you try if following patch fix your problem?
> > > 
> > > This patch can also fix my problem, and indeed is a more secure way.
> > 
> > Thanks for the test, for a better solution, I think 'blkcg_mutex' can
> > be used to protect 'blkg->q_node' list instead of 'queue_lock', so that
> > the 'restart' can be removed because softlockup can be avoided.
> > 
> 
> I looked into this, and I found that this is not a easy thing to do.
> 
> Anyway, feel free to submit a new patch based on my orignial suggestion.

Thanks for your contribution and careful review, I will submit the new
patch if no other comments.

Thanks,
Tao

> 
> Thanks,
> Kuai
> 
