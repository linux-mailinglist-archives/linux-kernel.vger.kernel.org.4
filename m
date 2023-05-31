Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD635717FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjEaMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaMWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:22:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FFD5134
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:22:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64FEB1042;
        Wed, 31 May 2023 05:22:50 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3F63F67D;
        Wed, 31 May 2023 05:22:04 -0700 (PDT)
Date:   Wed, 31 May 2023 13:22:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230531122201.3n3ak5n3cjisbmtm@bogus>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
 <20230510191207.GA18514@ranerica-svr.sc.intel.com>
 <20230515093608.etfprpqn3lmgybe6@bogus>
 <20230518012703.GA19967@ranerica-svr.sc.intel.com>
 <20230518093414.qhwyogcig4wv3r5s@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518093414.qhwyogcig4wv3r5s@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:34:14AM +0100, Sudeep Holla wrote:
> On Wed, May 17, 2023 at 06:27:03PM -0700, Ricardo Neri wrote:
> > On Mon, May 15, 2023 at 10:36:08AM +0100, Sudeep Holla wrote:
> > > On Wed, May 10, 2023 at 12:12:07PM -0700, Ricardo Neri wrote:
> > > > Hi,
> > > > 
> > > > I had posted a patchset[1] for x86 that initializes
> > > > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > > >
> > > 
> > > It is entirely clear to me if this is just a clean up or a fix to some
> > > issue you faced ? Just wanted to let you know Prateek from AMD has couple
> > > of fixes [2]
> > 
> > My first patch is a bug fix. The second patch is clean up that results
> > from fixing the bug in patch 1.
> > 
> > > 
> > > > This means that early_leaves and a late cache_leaves() are equal but
> > > > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> > > > fetch_cache_info().
> > > > 
> > > > I think that we should check here that per_cpu_cacheinfo() has been allocated to
> > > > take care of the case in which early and late cache leaves remain the same:
> > > > 
> > > > -       if (cache_leaves(cpu) <= early_leaves)
> > > > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> > > > 
> > > > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> > > > last_level_cache_is_valid().
> > > >
> > > 
> > > I think this is different issue as Prateek was just observing wrong info
> > > after cpuhotplug operations. But the patches manage the cpumap_populated
> > > state better with the patches. Can you please look at that as weel ?
> > 
> > I verified that the patches from Prateek fix a different issue. I was able
> > to reproduce his issue. His patches fixes it.
> > 
> > I still see my issue after applying Prateek's patches.
> 
> Thanks, I thought it is different issue and good that you were able to test
> them as well. Please post a proper patch for the NULL ptr dereference you
> are hitting on x86.

Gentle ping! Are you still observing NULL ptr dereference with v6.4-rcx ?
If so, can you please post the fix as a proper patch ? Some of the patches
in v6.4-rc1 are being backported, so I prefer to have all the known issues
fixed before that happens. Sorry for the nag, but backport is the reason
I am pushing for this.

-- 
Regards,
Sudeep
