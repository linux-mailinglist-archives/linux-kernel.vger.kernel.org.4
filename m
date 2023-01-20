Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C65675367
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjATL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjATL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:27:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C345F75
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:27:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9040E61F22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D4C433D2;
        Fri, 20 Jan 2023 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674214049;
        bh=rfM9XoEsJ3fxixGBFYlNuvWTsDntB4jiWzzWwt4TgPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwvfcJdwevZ+aASmlryPCVwN+yyKPDFI7isQ9VtTUc1nRq0Ca4LyE9GQLAGQUNLeO
         4dNYSz7ym833D6GvCQNzz/WS649ynrYw8/CABb4fTxXN1+9wuvW0BA0m1D7rpswnB1
         nF1qAdm4DbjHu3/G3IAe0j3r2lKEj63fER5WkN6g=
Date:   Fri, 20 Jan 2023 12:27:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] drivers: base: cacheinfo: fix shared_cpu_map
Message-ID: <Y8p6ns/XNrk/CDww@kroah.com>
References: <20221219105132.27690-1-yongxuan.wang@sifive.com>
 <20221219105132.27690-2-yongxuan.wang@sifive.com>
 <9cfb3356-3e3b-e9f3-1e16-ff02790e5829@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfb3356-3e3b-e9f3-1e16-ff02790e5829@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:00:39AM +0100, Pierre Gondois wrote:
> Hello Yong-Xuan,
> Except for the nit below, I tried the patch and everything seemed ok, so
> with that:
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> Regards,
> Pierre
> 
> On 12/19/22 11:51, Yong-Xuan Wang wrote:
> > The cacheinfo sets up the shared_cpu_map by checking whether the caches
> > with the same index are shared between CPUs. However, this will trigger
> > slab-out-of-bounds access if the CPUs do not have the same cache hierarchy.
> > Another problem is the mismatched shared_cpu_map when the shared cache does
> > not have the same index between CPUs.
> > 
> > CPU0	I	D	L3
> > index	0	1	2	x
> > 	^	^	^	^
> > index	0	1	2	3
> > CPU1	I	D	L2	L3
> > 
> > This patch checks each cache is shared with all caches on other CPUs.
> > 
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >   drivers/base/cacheinfo.c | 25 +++++++++++++++----------
> >   1 file changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> > index 950b22cdb5f7..d38f80f6fff1 100644
> > --- a/drivers/base/cacheinfo.c
> > +++ b/drivers/base/cacheinfo.c
> > @@ -256,7 +256,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
> >   {
> >   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> >   	struct cacheinfo *this_leaf, *sib_leaf;
> > -	unsigned int index;
> > +	unsigned int index, sib_index;
> >   	int ret = 0;
> >   	if (this_cpu_ci->cpu_map_populated)
> > @@ -284,11 +284,12 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
> >   			if (i == cpu || !sib_cpu_ci->info_list)
> >   				continue;/* skip if itself or no cacheinfo */
> > -
> > -			sib_leaf = per_cpu_cacheinfo_idx(i, index);
> > -			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
> > -				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
> > -				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
> > +			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
> > +				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);;
> 
> It seems there are 2 ';' above (same in the block below).

Yes, the kernel test robot complains about this as well.

It needs to be fixed before this change can be accepted.

thanks,

greg k-h
