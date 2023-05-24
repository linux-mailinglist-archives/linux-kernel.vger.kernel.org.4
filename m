Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5818170F6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjEXMwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjEXMwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:52:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221CBB0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:51:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD4A0221F4;
        Wed, 24 May 2023 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684932716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/gy0k3e794wotWy75Qhs+8/ZV46Dj45SDKUp9pn8Rc=;
        b=m7WrSXyUialsi0sAVP4s1PWnGSWrhOkeY+NmvcKtrk3dY24FjdIM6DrsG3xbL8RLEUnTNf
        sKKuvWguR3MUViMwdNUOQtYriJaKmyoJdGQTwOX4rR99v2jtl5c9HGo8aJNeeC/H2GTNPp
        AAOw4xQDbkYFmV0iEIQKNtDZGgUeWf4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FD88133E6;
        Wed, 24 May 2023 12:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a+zlIGwIbmQVdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 24 May 2023 12:51:56 +0000
Date:   Wed, 24 May 2023 14:51:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
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
Message-ID: <ZG4Ia4fQROyynSVG@dhcp22.suse.cz>
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515180015.016409657@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a late response but I was conferencing last two weeks and now
catching up]

On Mon 15-05-23 15:00:15, Marcelo Tosatti wrote:
[...]
> v8
> - Add summary of discussion on -v7 to cover letter

Thanks this is very useful! This helps to frame the further discussion.

I believe the most important question to answer is this in fact
> I think what needs to be done is to avoid new queue_work_on()
> users from being introduced in the tree (the number of
> existing ones is finite and can therefore be fixed).
> 
> Agree with the criticism here, however, i can't see other
> options than the following:
> 
>         1) Given an activity, which contains a sequence of instructions
>            to execute on a CPU, to change the algorithm
>            to execute that code remotely (therefore avoid interrupting a CPU),
>            or to avoid the interruption somehow (which must be dealt with
>            on a case-by-case basis).
> 
>         2) To block that activity from happening in the first place,
>            for the sites where it can be blocked (that return errors to
>            userspace, for example).
> 
>         3) Completly isolate the CPU from the kernel (off-line it).

I agree that a reliable cpu isolation implementation needs to address
queue_work_on problem. And it has to do that _realiably_. This cannot by
achieved by an endless whack-a-mole and chasing each new instance. There
must be a more systematic approach. One way would be to change the
semantic of schedule_work_on and fail call for an isolated CPU. The
caller would have a way to fallback and handle the operation by other
means. E.g. vmstat could simply ignore folding pcp data because an
imprecision shouldn't really matter. Other callers might chose to do the
operation remotely. This is a lot of work, no doubt about that, but it
is a long term maintainable solution that doesn't give you new surprises
with any new released kernel. There are likely other remote interfaces
that would need to follow that scheme.

If the cpu isolation is not planned to be worth that time investment
then I do not think it is also worth reducing a highly optimized vmstat
code. These stats are invoked from many hot paths and per-cpu
implementation has been optimized for that case. If your workload would
like to avoid that as disturbing then you already have a quiet_vmstat
precedence so find a way how to use it for your workload instead.
 
-- 
Michal Hocko
SUSE Labs
