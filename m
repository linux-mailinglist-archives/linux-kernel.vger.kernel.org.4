Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2737B6BD2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCPOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCPOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:51:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E71B26B7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:51:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 469282F4;
        Thu, 16 Mar 2023 07:52:04 -0700 (PDT)
Received: from bogus (unknown [10.57.52.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90BB3F67D;
        Thu, 16 Mar 2023 07:51:18 -0700 (PDT)
Date:   Thu, 16 Mar 2023 14:50:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        conor.dooley@microchip.com, ionela.voinescu@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, Pierre.Gondois@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arch_topology: Clear LLC sibling when cacheinfo
 teardown
Message-ID: <20230316145045.if3iw5qdtfjyroea@bogus>
References: <20230314075345.1325187-1-suagrfillet@gmail.com>
 <20230316092910.doolw3xiuwwakile@bogus>
 <CAAYs2=gaTkA2f65SXkexxAUkSPxgaPNQGdkSKS4pYmJ3hO7z-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYs2=gaTkA2f65SXkexxAUkSPxgaPNQGdkSKS4pYmJ3hO7z-Q@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:30:52AM +0000, Song Shuai wrote:
> Sudeep Holla <sudeep.holla@arm.com> 于2023年3月16日周四 09:29写道：
> >
> > On Tue, Mar 14, 2023 at 03:53:45PM +0800, Song Shuai wrote:
> > > The teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE now only invokes
> > > free_cache_attributes() to clear share_cpu_map of cacheinfo list.
> > > At the same time, clearing cpu_topology[].llc_sibling is
> > > called quite late at the teardown code in hotplug STARTING section.
> > >
> > > To avoid the incorrect LLC sibling masks generated, move its clearing
> > > right after free_cache_attributes().
> > >
> >
> > Technically in terms of flow/timing this is correct. However I would like
> > to know if you are seeing any issues without this change ?
> >
> > Technically, if a cpu is hotplugged out, the cacheinfo is reset first
> > and then the topology. Until the cpu is removes, the LLC info in the
> > topology is still valid. Also I am not sure if anything gets scheduled
> > and this LLC info is utilised once the teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE
> > has started.
>
> There is no visible issue in the entire offline process(eg: echo 0 > online).
>
> However, when I hotplugged out the CPU into the state before CACHEINFO_ONLINE on
> my kernel with the CONFIG_CPU_HOTPLUG_STATE_CONTROL configured,
> the share_cpu_map had been updated but llc_sibling had not, which
> would result in a trivial issue:
>
> At the end of stepped hotplugging out, the cpuset_hotplug_work would
> be flushed and then sched domain would be rebuilt
> where the **cpu_coregroup_mask** in sched_domain_topology got
> incorrect llc_sibling, but the result of rebuilding was correct due
> to the protection of cpu_active_mask.
>

Wait, I would like to disagree there. While I agree there is inconsistency
between cacheinfo cpu_shared_map and the llc_sibling in the tear down path,
it is still correct and terming it as "incorrect" llc_sibling is wrong.
The cpu is not yet completely offline yet and hence the llc_sibling
represents all the cpus it shares LLC. When the cpu is offlined, the
cpu_topology is anyway removed. So I don't see it as an issue at all.
If you follow __cpu_disable()->remove_cpu_topology(), it gets updated there.
If the sched_domain_topology is not rebuilt after that, then we may have
other issues. What am I missing ?

I am not bothered by cacheinfo cpu_shared_map and cpu_topology llc_sibling
mismatch for short window during the teardown as technically until the cpu
is torndown, it is sharing llc with llc_sibling and it is definitely not
wrong to have it in there.

> The stepped hotplugging may not be used in the production environment,
> but the issue existed.

What issue ? If it is just inconsistency, then I am fine to ignore. That
is just artificial and momentary and it impacts nothing.

> Even in the entire offline process, it's possible that a future user
> gets wrong the llc_sibling when accessing it concurrently or right
> after the teardown of CACHEINFO_ONLINE.

As I said, even if someone access it, it is not wrong information.

--
Regards,
Sudeep
