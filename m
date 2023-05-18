Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB33707CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjERJeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjERJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:34:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 554B6212C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:34:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADCEC1FB;
        Thu, 18 May 2023 02:35:02 -0700 (PDT)
Received: from bogus (unknown [10.57.22.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CDCA3F73F;
        Thu, 18 May 2023 02:34:16 -0700 (PDT)
Date:   Thu, 18 May 2023 10:34:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230518093414.qhwyogcig4wv3r5s@bogus>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
 <20230510191207.GA18514@ranerica-svr.sc.intel.com>
 <20230515093608.etfprpqn3lmgybe6@bogus>
 <20230518012703.GA19967@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518012703.GA19967@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:27:03PM -0700, Ricardo Neri wrote:
> On Mon, May 15, 2023 at 10:36:08AM +0100, Sudeep Holla wrote:
> > On Wed, May 10, 2023 at 12:12:07PM -0700, Ricardo Neri wrote:
> > > Hi,
> > > 
> > > I had posted a patchset[1] for x86 that initializes
> > > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > >
> > 
> > It is entirely clear to me if this is just a clean up or a fix to some
> > issue you faced ? Just wanted to let you know Prateek from AMD has couple
> > of fixes [2]
> 
> My first patch is a bug fix. The second patch is clean up that results
> from fixing the bug in patch 1.
> 
> > 
> > > This means that early_leaves and a late cache_leaves() are equal but
> > > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> > > fetch_cache_info().
> > > 
> > > I think that we should check here that per_cpu_cacheinfo() has been allocated to
> > > take care of the case in which early and late cache leaves remain the same:
> > > 
> > > -       if (cache_leaves(cpu) <= early_leaves)
> > > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> > > 
> > > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> > > last_level_cache_is_valid().
> > >
> > 
> > I think this is different issue as Prateek was just observing wrong info
> > after cpuhotplug operations. But the patches manage the cpumap_populated
> > state better with the patches. Can you please look at that as weel ?
> 
> I verified that the patches from Prateek fix a different issue. I was able
> to reproduce his issue. His patches fixes it.
> 
> I still see my issue after applying Prateek's patches.

Thanks, I thought it is different issue and good that you were able to test
them as well. Please post a proper patch for the NULL ptr dereference you
are hitting on x86.

-- 
Regards,
Sudeep
