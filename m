Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA883707762
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjERBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:24:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290BD30E4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684373047; x=1715909047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fE7YgCkSDZ+nIO0tTZnSypacGkqjCiEQ9o1FV5TUhlM=;
  b=bBHVBRWt8avgTsUDhM9IO5E9YfnB5KNw4OyZVnjrvNj6WWQzB/9QCnfS
   fCajrt+MEoy2YykcTAGf20PvhRR6WnZw4FramOM8OA9lz8tzvI8MAPYkt
   m3ZEYbLUwV12jAPaVqJ+6k8Hg7qub65O6oI2gFifIQVz6GzxwjxlHNwSG
   nJpljjyb3X16KCehWl/36T0ZeduLHd8lYO+sxIM5+dxh95cSrrzbrxIv8
   fdh0NaC9DcqUrwxFRYlPRhg4+cexbHgsKooDTGmokAZdKWKiXpJyRNs+t
   VPJKym+wuWQ7sPTK27Oc+sg01E147dOrG100vq4U6SPJWTiHHDhT0ZkiQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="355113382"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="355113382"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 18:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="814121371"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="814121371"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2023 18:24:06 -0700
Date:   Wed, 17 May 2023 18:27:03 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230518012703.GA19967@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
 <20230510191207.GA18514@ranerica-svr.sc.intel.com>
 <20230515093608.etfprpqn3lmgybe6@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515093608.etfprpqn3lmgybe6@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 10:36:08AM +0100, Sudeep Holla wrote:
> On Wed, May 10, 2023 at 12:12:07PM -0700, Ricardo Neri wrote:
> > Hi,
> > 
> > I had posted a patchset[1] for x86 that initializes
> > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> >
> 
> It is entirely clear to me if this is just a clean up or a fix to some
> issue you faced ? Just wanted to let you know Prateek from AMD has couple
> of fixes [2]

My first patch is a bug fix. The second patch is clean up that results
from fixing the bug in patch 1.

> 
> > This means that early_leaves and a late cache_leaves() are equal but
> > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> > fetch_cache_info().
> > 
> > I think that we should check here that per_cpu_cacheinfo() has been allocated to
> > take care of the case in which early and late cache leaves remain the same:
> > 
> > -       if (cache_leaves(cpu) <= early_leaves)
> > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> > 
> > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> > last_level_cache_is_valid().
> >
> 
> I think this is different issue as Prateek was just observing wrong info
> after cpuhotplug operations. But the patches manage the cpumap_populated
> state better with the patches. Can you please look at that as weel ?

I verified that the patches from Prateek fix a different issue. I was able
to reproduce his issue. His patches fixes it.

I still see my issue after applying Prateek's patches.
> 
> -- 
> Regards,
> Sudeep
> 
> [2] https://lore.kernel.org/all/20230508084115.1157-1-kprateek.nayak@amd.com

Thank you for the suggestion!

BR,
Ricardo
