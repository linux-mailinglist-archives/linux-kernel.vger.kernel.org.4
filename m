Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65BA6CBDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC1Li4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjC1Liy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54C55BB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 237DCB81C14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D88C433EF;
        Tue, 28 Mar 2023 11:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680003525;
        bh=jOmrs/Lchl59dAkRYGNIhG6/nypGKLzZbxjHzoW4mfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXBdL1RALxKCk3tpTvdW+ixaWAD/0SsshjdwXvmH8P9hpo6oNhoKa6ijmxu9vljze
         IwKi5Yj2uz+xgwqKnWglcpcvOP7WeKFVnmVhKl7CsSyjbo+mBbmUWr3UBLZB93cuoK
         XB3+IE1O0Ed6CcAXtIppJDAc6C9c3jGLnFcTq39vlwKMTrRwfamVrDqDmsxvHS380A
         t+2o5gJWTkxoYgjr435kPSfKPdad19ykRkuJso4zt1PaXJ+H1IUHXKBW2++kyHn8z8
         yqlSIFxiwGJcYZkNQoDN8re986Nf0lI/xTaEClN9vatYwz24DjDz/n72JZn3x3Kiy+
         jCrrG/Y8zJ10A==
Date:   Tue, 28 Mar 2023 13:38:42 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <ZCLRwgAHc7/TAOiN@lothringen>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
 <ZBSyaVk919Fi07Wv@tpad>
 <ZBSy2QZYZRtCNBd8@tpad>
 <ZBVwlv+Mi+GfR1E3@dhcp22.suse.cz>
 <ZB4lt3IaPWVmn41n@localhost.localdomain>
 <ZCFu9jFm/rskeNlM@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCFu9jFm/rskeNlM@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:24:54AM -0300, Marcelo Tosatti wrote:
> On Fri, Mar 24, 2023 at 11:35:35PM +0100, Frederic Weisbecker wrote:
> > Le Sat, Mar 18, 2023 at 09:04:38AM +0100, Michal Hocko a écrit :
> > > On Fri 17-03-23 15:35:05, Marcelo Tosatti wrote:
> > > > On Fri, Mar 17, 2023 at 03:33:13PM -0300, Marcelo Tosatti wrote:
> > > > > On Fri, Mar 17, 2023 at 02:44:47PM +0100, Michal Hocko wrote:
> > > > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > > > 
> > > > > > Provide this new API to check if a CPU has been isolated either through
> > > > > > isolcpus= or nohz_full= kernel parameter.
> > > > > > 
> > > > > > It aims at avoiding kernel load deemed to be safely spared on CPUs
> > > > > > running sensitive workload that can't bear any disturbance, such as
> > > > > > pcp cache draining.
> > > > > 
> > > > > Hi Michal,
> > > > > 
> > > > > This makes no sense to me.
> > > > > 
> > > > > HK_TYPE_DOMAIN is set when isolcpus=domain is configured.
> > > > > HK_TYPE_TICK is set when nohz_full= is configured.
> > > > > 
> > > > > The use-cases i am aware of use either:
> > > > > 
> > > > > isolcpus=managed_irq,... nohz_full=
> > > > > OR
> > > > > isolcpus=domain,managed_irq,... nohz_full=
> > > > > 
> > > > > So what is the point of this function again?
> > > > > 
> > > > > Perhaps it made sense along with, but now does not make sense
> > > > > anymore:
> > > > > 
> > > > > Subject: [PATCH 1/2] sched/isolation: Merge individual nohz_full features into a common housekeeping flag
> > > > > 
> > > > > The individual isolation features turned on by nohz_full were initially
> > > > > split in order for each of them to be tunable through cpusets. However
> > > > > plans have changed in favour of an interface (be it cpusets or sysctl)
> > > > > grouping all these features to be turned on/off altogether. Then should
> > > > > the need ever arise, the interface can still be expanded to handle the
> > > > > individual isolation features.
> > > > > 
> > > > > But Michal can just use housekeeping_test_cpu(cpu, HK_TYPE_TICK) and
> > > > > the convertion of nohz_full features into a common housekeeping flag
> > > > > can convert that to something else later?
> > > > 
> > > > Actually introducing cpu_is_isolated() seems fine, but it can call
> > > > housekeeping_test_cpu(cpu, HK_TYPE_TICK) AFAICS.
> > >  
> > > This is not really my area. Frederic, could you have a look please?
> > 
> > The point is to have a function that tells if either nohz_full= or
> > isolcpus=[domain] has been passed for the given CPU.
> > 
> > Because I assumed that both would be interested in avoiding that flush
> > noise, wouldn't it be the case?
> 
> Yes, that is the case. But as a note: for the two main types of
> configuration performed (one uses isolcpus=[domain] and the other
> cgroups, for isolating processes) nohz_full= is always set.
> 
> So just testing for nohz_full= would be sufficient (which perhaps would
> make the code simpler).

Ok then all is needed is to test tick_nohz_full_cpu(target), right?
