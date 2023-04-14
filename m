Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60EA6E1EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:05:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B1F34EF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:05:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B77D32F4;
        Fri, 14 Apr 2023 02:06:30 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEC2B3F587;
        Fri, 14 Apr 2023 02:05:44 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:05:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 2/4] cacheinfo: Check cache properties are present in
 DT
Message-ID: <20230414090542.rbidu45cx4halja4@bogus>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-3-pierre.gondois@arm.com>
 <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
 <20230413195032.bw3yu7a6puqziinx@bogus>
 <d44baa58-8c39-407c-db94-390bc0d12dbe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44baa58-8c39-407c-db94-390bc0d12dbe@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 01:06:46PM -0700, Florian Fainelli wrote:
> On 4/13/23 12:50, Sudeep Holla wrote:
> > On Thu, Apr 13, 2023 at 11:16:37AM -0700, Florian Fainelli wrote:
> > > On 4/13/23 02:14, Pierre Gondois wrote:
> > > > If a Device Tree (DT) is used, the presence of cache properties is
> > > > assumed. Not finding any is not considered. For arm64 platforms,
> > > > cache information can be fetched from the clidr_el1 register.
> > > > Checking whether cache information is available in the DT
> > > > allows to switch to using clidr_el1.
> > > > 
> > > > init_of_cache_level()
> > > > \-of_count_cache_leaves()
> > > > will assume there a 2 cache leaves (L1 data/instruction caches), which
> > > > can be different from clidr_el1 information.
> > > > 
> > > > cache_setup_of_node() tries to read cache properties in the DT.
> > > > If there are none, this is considered a success. Knowing no
> > > > information was available would allow to switch to using clidr_el1.
> > > > 
> > > > Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
> > > > Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
> > > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > > 
> > > Humm, it would appear that the cache levels and topology is still provided,
> > > despite the lack of cache properties in the Device Tree which is intended by
> > > this patch set however we lost the size/ways/sets information, could we not
> > > complement the missing properties here?
> > > 
> > 
> > I am confused. How and from where the information was fetched before this
> > change ?
> 
> I applied Pierre's patches to my tree and then did the following:
> 
> - before means booting with the patches applied and the Device Tree
> providing cache information: {d,i}-cache-{size,line-size,sets} and
> next-level-cache
> 
> - after means removing all of those properties still with the patches
> applied
>

Ah okay, I assumed something totally different and hence thought patches
broke something.

> My expectation is that if we omit the properties in the Device Tree, we will
> fallback to reading that information out of clidr_el1. However as can be
> seen from the "before" and "after" outputs, there is loss of information, as
> we no longer have the cacheline size, number of sets/ways, the rest is valid
> though.
>

Correct and that is expected. We dropped ccsidr_el1 support to fetch cache
geometry with the commit a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based
cache information probing") after Arm ARM added wordings not to infer the
information. However clidr_el1 info still holds except it may not include
transparent system level caches. Hope that clarifies.

> So my question is whether this is expected and in scope of what is being
> done here, or not.
> 
> > 
> > > If this is out of the scope of what you are doing:
> > > 
> > > Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> > > 
> > 
> > Just looking at the lscpu output before and after, it looks something is
> > broken. What am I missing here ?
> > 
> 
> What is broken in the "before" output? It contains the entire set of
> possible information we know about the caches. As for the "after", well yes
> there is information missing, the whole point of my email actually...

Sorry, I was not referring to "before" output. I assumed "before" means
without patches and "after" means with patches, hence I thought patches
broke something but got confused why are you giving tested-by :D.

-- 
Regards,
Sudeep
