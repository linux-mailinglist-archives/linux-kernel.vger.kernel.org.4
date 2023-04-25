Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429AF6EDF77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjDYJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjDYJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:42:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D078C5BBA;
        Tue, 25 Apr 2023 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682415766; x=1713951766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bftSZwIs1nOeFyqVaNVBQT2KhTtuH2e3mtNCB3+bL3Q=;
  b=PjhhkZa5cGompLxX4aEGvM4a5gTH/922311z5yZkECU+knjeerOVzZHt
   lzdqeG6rba4YqvwGUda579wRpUPMPvTw1BAE2JDe3dRoKQw/PGHA33jcp
   /63ELTkZVmEakQbFPp+bbi7p2Uejx0IFbQ/Ao4Ju8SKLZUQC6HkfNhrNH
   I1saxONet5OqddXiHFivXipK/qQlla0Ufk8Rw4/V2PUxPEEBmZ1889oA7
   v5HscHJnE5fLtx33kjHRafMCF7v8bHHjVCQA6E5skmPEgF6TjKpDEXEuR
   ZYFIn9ZAw9V4t1ezli+btQA/jDpLJ3nveMoCEdnd5dIcUjJ59WTX0Q2s9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345468573"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="345468573"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 02:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="805014078"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="805014078"
Received: from linux.bj.intel.com ([10.238.156.127])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 02:42:44 -0700
Date:   Tue, 25 Apr 2023 17:41:20 +0800
From:   Tao Su <tao1.su@linux.intel.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Subject: Re: [PATCH] Remove blkg node after destroying blkg
Message-ID: <ZEegQCCZ96ij6mw5@linux.bj.intel.com>
References: <20230425075911.839539-1-tao1.su@linux.intel.com>
 <aa5de32c-c92b-d032-e9bb-83d2436ff72c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa5de32c-c92b-d032-e9bb-83d2436ff72c@huawei.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:09:34PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/04/25 15:59, Tao Su 写道:
> > Kernel hang when poweroff or reboot, due to infinite restart in function
> > blkg_destroy_all. It will goto restart label when a batch of blkgs are
> > destroyed, but not remove blkg node in blkg_list. So the blkg_list is
> > same in every 'restart' and result in kernel hang.
> > 
> > By adding list_del to remove blkg node after destroying, can solve this
> > kernel hang issue and satisfy the previous will to 'restart'.
> > 
> > Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> > Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > ---
> >   block/blk-cgroup.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index bd50b55bdb61..960eb538a704 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -530,6 +530,7 @@ static void blkg_destroy_all(struct gendisk *disk)
> >   		spin_lock(&blkcg->lock);
> >   		blkg_destroy(blkg);
> > +		list_del(&blkg->q_node);
> 
> blkg should stay on the queue list until blkg_free_workfn(), otherwise
> parent blkg can be freed before child, which will cause some known
> issue.

Yes, directly removing blkg node is not appropriate, which I noticed some
comments in blkg_destroy(), thanks for pointing out this issue.

> 
> I think this hung happens when total blkg is greater than
> BLKG_DESTROY_BATCH_SIZE, right?

Yes, you are right.

> 
> Can you try if following patch fix your problem?

This patch can also fix my problem, and indeed is a more secure way.

Thanks,
Tao

> 
> index 1c1ebeb51003..0ecb4cce8af2 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -527,6 +527,9 @@ static void blkg_destroy_all(struct gendisk *disk)
>         list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>                 struct blkcg *blkcg = blkg->blkcg;
> 
> +               if (hlist_unhashed(&blkg->blkcg_node))
> +                       continue;
> +
>                 spin_lock(&blkcg->lock);
>                 blkg_destroy(blkg);
>                 spin_unlock(&blkcg->lock);
> 
> >   		spin_unlock(&blkcg->lock);
> >   		/*
> > 
