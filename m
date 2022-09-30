Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9E5F06EF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiI3Iy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiI3Iyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:54:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA40AE7B;
        Fri, 30 Sep 2022 01:54:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79AB41F8CE;
        Fri, 30 Sep 2022 08:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664528086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0RO0XshdYgWaME5PM9pXp6vGBFepyhLWsPakc7rMWg=;
        b=tOkdfQhPIuh6ZCbA7P2S7ms44Q0z8BvZJax7S3xaeyugGeuJEkG/1rddoJsCWJFTlaBnwv
        RfjXQDQ5HSCNVlVMdFf4+8aBNSuRay4eSwVW4TbgrX4lcL2/UJDV//KnKpmuCI+8TH2a/P
        JFpq7TKChTm3h4X6uWZD3QpW5MgoVWU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B63F13776;
        Fri, 30 Sep 2022 08:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Teq0GNauNmOfTwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 30 Sep 2022 08:54:46 +0000
Date:   Fri, 30 Sep 2022 10:54:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC] proc: Add a new isolated /proc/pid/mempolicy type.
Message-ID: <YzauqRWu+Ex9PjF7@dhcp22.suse.cz>
References: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
 <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
 <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
 <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
 <7ac9abce-4458-982b-6c04-f9569a78c0da@bytedance.com>
 <YzLVTxGHgYp3Es4t@dhcp22.suse.cz>
 <9a0130ce-6528-6652-5a8e-3612c5de2d96@bytedance.com>
 <YzMBnKUo8ny9S/7+@dhcp22.suse.cz>
 <4e2aa5c2-3d8c-2a2f-691b-218e23e7271f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2aa5c2-3d8c-2a2f-691b-218e23e7271f@bytedance.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-09-22 11:09:47, Abel Wu wrote:
> On 9/27/22 9:58 PM, Michal Hocko wrote:
> > On Tue 27-09-22 21:07:02, Abel Wu wrote:
> > > On 9/27/22 6:49 PM, Michal Hocko wrote:
> > > > On Tue 27-09-22 11:20:54, Abel Wu wrote:
> > > > [...]
> > > > > > > Btw.in order to add per-thread-group mempolicy, is it possible to add
> > > > > > > mempolicy in mm_struct?
> > > > > > 
> > > > > > I dunno. This would make the mempolicy interface even more confusing.
> > > > > > Per mm behavior makes a lot of sense but we already do have per-thread
> > > > > > semantic so I would stick to it rather than introducing a new semantic.
> > > > > > 
> > > > > > Why is this really important?
> > > > > 
> > > > > We want soft control on memory footprint of background jobs by applying
> > > > > NUMA preferences when necessary, so the impact on different NUMA nodes
> > > > > can be managed to some extent. These NUMA preferences are given by the
> > > > > control panel, and it might not be suitable to overwrite the tasks with
> > > > > specific memory policies already (or vice versa).
> > > > 
> > > > Maybe the answer is somehow implicit but I do not really see any
> > > > argument for the per thread-group semantic here. In other words why a
> > > > new interface has to cover more than the local [sg]et_mempolicy?
> > > > I can see convenience as one potential argument. Also if there is a
> > > > requirement to change the policy in atomic way then this would require a
> > > > single syscall.
> > > 
> > > Convenience is not our major concern. A well-tuned workload can have
> > > specific memory policies for different tasks/vmas in one process, and
> > > this can be achieved by set_mempolicy()/mbind() respectively. While
> > > other workloads are not, they don't care where the memory residents,
> > > so the impact they brought on the co-located workloads might vary in
> > > different NUMA nodes.
> > > 
> > > The control panel, which has a full knowledge of workload profiling,
> > > may want to interfere the behavior of the non-mempolicied processes
> > > by giving them NUMA preferences, to better serve the co-located jobs.
> > > 
> > > So in this scenario, a process's memory policy can be assigned by two
> > > objects dynamically:
> > > 
> > >   a) the process itself, through set_mempolicy()/mbind()
> > >   b) the control panel, but API is not available right now
> > > 
> > > Considering the two policies should not fight each other, it sounds
> > > reasonable to introduce a new syscall to assign memory policy to a
> > > process through struct mm_struct.
> > 
> > So you want to allow restoring the original local policy if the external
> > one is disabled?
> 
> Pretty much, but the internal policies are expected to have precedence
> over the external ones, since they are set for some reason to meet their
> specific requirements. The external ones are used only when there is no
> internal policy active.

What does this mean in practice exactly? Will pidfd_set_mempolicy fail
if there is a local policy in place? If not, how does the monitoring
know the effect of its call?

TBH I do not think this is a good idea at all. It seems like a very
confusing semantic to me. The external monitoring tool should be careful
to not go against implicit memory policies and query the state before
altering it. Or if this is required to be done atomicaly then add a flag
to the pidfd call.
 
> > Anyway, pidfd_$FOO behavior should be semantically very similar to the
> > original $FOO. Moving from per-task to per-mm is a major shift in the
> > semantic.  I can imagine to have a dedicated flag for the syscall to
> > enforce the policy to the full thread group. But having a different
> > semantic is both tricky and also constrained because per-thread binding
> > is then impossible.
> 
> Agreed. What about a syscall only apply to per-mm? There are precedents
> like process_madvice(2).

Differnt mm operations have different scope. And some of them have
changed their scope over time (e.g. oom_score_adj). If you really need a
per-mm functionality then use a flag for pidfd syscal.

-- 
Michal Hocko
SUSE Labs
