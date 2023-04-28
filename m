Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A116F11FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjD1Gvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345285AbjD1Gvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:51:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2D30E8;
        Thu, 27 Apr 2023 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682664693; x=1714200693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aB2YsP1K3RdhXZS8cylTDflNzVA0nU4HK1q9q5xhY3s=;
  b=KoQKVBPpfgizayAK6YpfB0D9GZGS5gBSbkpXj6PtvEE7O/GDKTvXbRd9
   dKmdQuiPS5FCtcjmhZ/yqwpmj+5iiw04twk65XdJfEf03jkmXf1S/YsZt
   Sza5kEWPGIYbd66QaVPsX/2rO221V2pW0FySdIe/CRIbaWFoT2K4Bf2rZ
   Ip0cR6tUT1GNyUrs98hU0MrkVHexexQ0u8YlRFqCeKdwNCQJPJxvJrwIK
   eayNzUyq7NC/ymYfY9b83CVAXCtrq36cupeiZzlT8gPPEC+DHdvCR4r2O
   YwmrFCmMb3z7LAo+qzr2OmKP4GwCoZXOYV7WJDTKOD7730y+KsR2GDtfs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="347694937"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="347694937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 23:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="644999650"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="644999650"
Received: from linux.bj.intel.com ([10.238.156.127])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 23:51:30 -0700
Date:   Fri, 28 Apr 2023 14:49:53 +0800
From:   Tao Su <tao1.su@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2] block: Skip destroyed blkg when restart in
 blkg_destroy_all()
Message-ID: <ZEtskeNOTKeqW2rS@linux.bj.intel.com>
References: <20230428045149.1310073-1-tao1.su@linux.intel.com>
 <c007f189-8573-8390-4338-ae4c281ffbee@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c007f189-8573-8390-4338-ae4c281ffbee@huaweicloud.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:12:06PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/04/28 12:51, Tao Su 写道:
> > Kernel hang in blkg_destroy_all() when total blkg greater than
> > BLKG_DESTROY_BATCH_SIZE, because of not removing destroyed blkg in
> > blkg_list. So the size of blkg_list is same after destroying a
> > batch of blkg, and the infinite 'restart' occurs.
> > 
> > Since blkg should stay on the queue list until blkg_free_workfn(),
> > skip destroyed blkg when restart a new round, which will solve this
> > kernel hang issue and satisfy the previous will to restart.
> 
> Please add a fix tag:
> 
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from
> blkg_free_workfn() and blkcg_deactivate_policy()")
> > 
> > Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> > Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
> 
> You can remove this tag, and feel free to add:
> 
> Suggested-and-reviewed-by: Yu Kuai <yukuai3@huawei.com>

Got it, thanks!

Tao

> 
> Thanks,
> Kuai
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > ---
> > v2:
> > - change 'directly remove destroyed blkg' to 'skip destroyed blkg'
> > 
> > v1:
> > - https://lore.kernel.org/all/20230425075911.839539-1-tao1.su@linux.intel.com/
> > 
> >   block/blk-cgroup.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index bd50b55bdb61..75bad5d60c9f 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -528,6 +528,9 @@ static void blkg_destroy_all(struct gendisk *disk)
> >   	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
> >   		struct blkcg *blkcg = blkg->blkcg;
> > +		if (hlist_unhashed(&blkg->blkcg_node))
> > +			continue;
> > +
> >   		spin_lock(&blkcg->lock);
> >   		blkg_destroy(blkg);
> >   		spin_unlock(&blkcg->lock);
> > 
> 
