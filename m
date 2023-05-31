Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC9718800
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEaRFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjEaREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:04:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ACFE53
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685552673; x=1717088673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=clCi0GqbbqJuiE1UGmODAynJdSHJgnX6hsB7eRepfGM=;
  b=anVTB1HGw4OZx3Q+4zkkwB8uSQLYOkhKUIFhpD54kXLvK/MPpwQ1TNWt
   8sgI9T7TyMwg6k/n5ydTaMPisis4HrU0WisxTfNPedyM0lr5Qe4LTjn+3
   xyoaI4CJ2rbCR9gKPlGvQY5+An2KTeUZFVjReViLjVn10Pfn1iOFIaiRr
   G1GQU6NKCJUDOt6+wzL0LrzHMw87QIgNzGnJ8aT96nopRChBd+X1boq2B
   K5OUECFCmEAkzk84CRJVe+58UVnP5euFBdF+teMicrNLCcpWgW/QeCapE
   NdxDBwA5u7tsci/KiVzl3Xh/1RdCRW3FmuGrWfcuM1t7n1XXndRdvOmhO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339896636"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339896636"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 10:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="657418722"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="657418722"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2023 10:00:42 -0700
Date:   Wed, 31 May 2023 10:03:36 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230531170336.GA22753@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
 <20230510191207.GA18514@ranerica-svr.sc.intel.com>
 <20230515093608.etfprpqn3lmgybe6@bogus>
 <20230518012703.GA19967@ranerica-svr.sc.intel.com>
 <20230518093414.qhwyogcig4wv3r5s@bogus>
 <20230531122201.3n3ak5n3cjisbmtm@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531122201.3n3ak5n3cjisbmtm@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 01:22:01PM +0100, Sudeep Holla wrote:
> On Thu, May 18, 2023 at 10:34:14AM +0100, Sudeep Holla wrote:
> > On Wed, May 17, 2023 at 06:27:03PM -0700, Ricardo Neri wrote:
> > > On Mon, May 15, 2023 at 10:36:08AM +0100, Sudeep Holla wrote:
> > > > On Wed, May 10, 2023 at 12:12:07PM -0700, Ricardo Neri wrote:
> > > > > Hi,
> > > > > 
> > > > > I had posted a patchset[1] for x86 that initializes
> > > > > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > > > >
> > > > 
> > > > It is entirely clear to me if this is just a clean up or a fix to some
> > > > issue you faced ? Just wanted to let you know Prateek from AMD has couple
> > > > of fixes [2]
> > > 
> > > My first patch is a bug fix. The second patch is clean up that results
> > > from fixing the bug in patch 1.
> > > 
> > > > 
> > > > > This means that early_leaves and a late cache_leaves() are equal but
> > > > > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> > > > > fetch_cache_info().
> > > > > 
> > > > > I think that we should check here that per_cpu_cacheinfo() has been allocated to
> > > > > take care of the case in which early and late cache leaves remain the same:
> > > > > 
> > > > > -       if (cache_leaves(cpu) <= early_leaves)
> > > > > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> > > > > 
> > > > > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> > > > > last_level_cache_is_valid().
> > > > >
> > > > 
> > > > I think this is different issue as Prateek was just observing wrong info
> > > > after cpuhotplug operations. But the patches manage the cpumap_populated
> > > > state better with the patches. Can you please look at that as weel ?
> > > 
> > > I verified that the patches from Prateek fix a different issue. I was able
> > > to reproduce his issue. His patches fixes it.
> > > 
> > > I still see my issue after applying Prateek's patches.
> > 
> > Thanks, I thought it is different issue and good that you were able to test
> > them as well. Please post a proper patch for the NULL ptr dereference you
> > are hitting on x86.
> 
> Gentle ping! Are you still observing NULL ptr dereference with v6.4-rcx ?

Yes, I still observe it on v6.4-rc4.

> If so, can you please post the fix as a proper patch ? Some of the patches
> in v6.4-rc1 are being backported, so I prefer to have all the known issues
> fixed before that happens. Sorry for the nag, but backport is the reason
> I am pushing for this.

Sure. Sorry for the delay. I have the patch ready and post this week. I
will post it as part my previous patches in [1].

Thanks and BR,
Ricardo
