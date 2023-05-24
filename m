Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E393070F819
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjEXNyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjEXNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1AE9E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684936431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/JE+/VA6wS2JR/X9eVdEeZwiqUU8bEuDrv3SbGQ10E=;
        b=aZLdBuFjfwjLQOwqJAN2xr9ZcW7Ir00JXZ+tu5fneWprYBKPcCShH05oYC9wI+Xw1DJ+hJ
        jcZGwrkREaDxDlkYgYPW6zt1JxaftLMCv+Y9biUU+3J+yXgC29QVN6Yj1smxDZSItlPvME
        WE7qybvs2/NzBZplmis3OsREVJ3yMAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-93pexv7lOdW0qHkPt48qTg-1; Wed, 24 May 2023 09:53:45 -0400
X-MC-Unique: 93pexv7lOdW0qHkPt48qTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 141C5802355;
        Wed, 24 May 2023 13:53:44 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF1CE40C6EC4;
        Wed, 24 May 2023 13:53:43 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id EA382400DBEF5; Wed, 24 May 2023 10:53:23 -0300 (-03)
Date:   Wed, 24 May 2023 10:53:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v8 00/13] fold per-CPU vmstats remotely
Message-ID: <ZG4W01AcwhD5AiQU@tpad>
References: <20230515180015.016409657@redhat.com>
 <ZG4Ia4fQROyynSVG@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG4Ia4fQROyynSVG@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:51:55PM +0200, Michal Hocko wrote:
> [Sorry for a late response but I was conferencing last two weeks and now
> catching up]
> 
> On Mon 15-05-23 15:00:15, Marcelo Tosatti wrote:
> [...]
> > v8
> > - Add summary of discussion on -v7 to cover letter
> 
> Thanks this is very useful! This helps to frame the further discussion.
> 
> I believe the most important question to answer is this in fact
> > I think what needs to be done is to avoid new queue_work_on()
> > users from being introduced in the tree (the number of
> > existing ones is finite and can therefore be fixed).
> > 
> > Agree with the criticism here, however, i can't see other
> > options than the following:
> > 
> >         1) Given an activity, which contains a sequence of instructions
> >            to execute on a CPU, to change the algorithm
> >            to execute that code remotely (therefore avoid interrupting a CPU),
> >            or to avoid the interruption somehow (which must be dealt with
> >            on a case-by-case basis).
> > 
> >         2) To block that activity from happening in the first place,
> >            for the sites where it can be blocked (that return errors to
> >            userspace, for example).
> > 
> >         3) Completly isolate the CPU from the kernel (off-line it).
> 
> I agree that a reliable cpu isolation implementation needs to address
> queue_work_on problem. And it has to do that _realiably_. This cannot by
> achieved by an endless whack-a-mole and chasing each new instance. There
> must be a more systematic approach. One way would be to change the
> semantic of schedule_work_on and fail call for an isolated CPU. The
> caller would have a way to fallback and handle the operation by other
> means. E.g. vmstat could simply ignore folding pcp data because an
> imprecision shouldn't really matter. Other callers might chose to do the
> operation remotely. This is a lot of work, no doubt about that, but it
> is a long term maintainable solution that doesn't give you new surprises
> with any new released kernel. There are likely other remote interfaces
> that would need to follow that scheme.
> 
> If the cpu isolation is not planned to be worth that time investment
> then I do not think it is also worth reducing a highly optimized vmstat
> code. These stats are invoked from many hot paths and per-cpu
> implementation has been optimized for that case.

It is exactly the same code, but now with a "LOCK" prefix for CMPXCHG
instruction. Which should not cost much due to cache locking (these are
per-CPU variables anyway).

> If your workload would
> like to avoid that as disturbing then you already have a quiet_vmstat
> precedence so find a way how to use it for your workload instead.
>  
> -- 
> Michal Hocko
> SUSE Labs

OK so an alternative solution is to completly disable vmstat updates
for isolated CPUs. Are you OK with that ?

