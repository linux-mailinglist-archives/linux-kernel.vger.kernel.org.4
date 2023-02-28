Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71E26A5A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjB1NvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjB1NvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:51:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E0305E6;
        Tue, 28 Feb 2023 05:50:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9FA681FDC1;
        Tue, 28 Feb 2023 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677592253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+axJ4fDmePQKpl5oDQ9xI+mAYeRUk3jBZn02hzcYwk=;
        b=IYQKcMF4XvBnvvKRj/q+4NsA4zlgvalUeOeZo1lBfkaF3u2BNeUHa15J5mK2wKQUGa2QzL
        7DHSTLBQQX4mHTOkhneDNjY8k6kwgvqUD4TOa2szu510WQDdc/g+V5bXW+oLqUMQDQCzLK
        //rYSrtyAx9tgv/KUWmg5yxRdrZunok=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 798E913440;
        Tue, 28 Feb 2023 13:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jU5ZG70G/mPKQQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 28 Feb 2023 13:50:53 +0000
Date:   Tue, 28 Feb 2023 14:50:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>, johunt@akamai.com
Subject: Re: [PATCH] psi: reduce min window size to 50ms
Message-ID: <Y/4GvIMtjVoEozWE@dhcp22.suse.cz>
References: <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
 <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com>
 <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz>
 <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
 <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz>
 <CAJuCfpHXwbtjdhH_K9r28-LUYtzC6+NaZ+RrKCtiNBk8PfXhLw@mail.gmail.com>
 <Y/0ASztGOwfM6bNK@dhcp22.suse.cz>
 <CAJuCfpHYMR6O_uJvaeq1f+ZvgW9oN6zTRG=UvTXyLJLSFOV3jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHYMR6O_uJvaeq1f+ZvgW9oN6zTRG=UvTXyLJLSFOV3jw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-02-23 11:50:48, Suren Baghdasaryan wrote:
> On Mon, Feb 27, 2023 at 11:11 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 27-02-23 09:49:59, Suren Baghdasaryan wrote:
> > > On Mon, Feb 27, 2023 at 5:34 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 24-02-23 13:07:57, Suren Baghdasaryan wrote:
> > > > > On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > > > Btw. it seems that there is is only a limit on a single trigger per fd
> > > > > > but no limits per user so it doesn't sound too hard to end up with too
> > > > > > much polling even with a larger timeouts. To me it seems like we need to
> > > > > > contain the polling thread to be bound by the cpu controller.
> > > > >
> > > > > Hmm. We have one "psimon" thread per cgroup (+1 system-level one) and
> > > > > poll_min_period for each thread is chosen as the min() of polling
> > > > > periods between triggers created in that group. So, a bad trigger that
> > > > > causes overly aggressive polling and polling thread being throttled,
> > > > > might affect other triggers in that cgroup.
> > > >
> > > > Yes, and why that would be a problem?
> > >
> > > If unprivileged processes are allowed to add new triggers then a
> > > malicious process can add a bad trigger and affect other legit
> > > processes. That sounds like a problem to me.
> >
> > Hmm, I am not sure we are on the same page. My argument was that the
> > monitoring kernel thread should be bound by the same cpu controller so
> > even if it was excessive it would be bound to the cgroup constrains.
> 
> Right. But if cgroup constraints are violated then the psimon thread's
> activity will be impacted by throttling. In such cases won't that
> affect other "good" triggers served by that thread even if they are
> using higher polling periods?

That is no different from any other part of the workload running within
the same cpu bound cgroup running overboard with the cpu consumption. I
do not see why psimon or anything else should be any different.

Actually the only difference here is that the psi monitoring is
outsourced to a kernel thread which is running ourside of any constrains.
I am not sure where do we stand with kernel thread cpu cgroup accounting
and I suspect this is not a trivial thing to do ATM. Hence longer term
plan.
-- 
Michal Hocko
SUSE Labs
