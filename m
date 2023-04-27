Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D737D6F029C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbjD0Ib3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbjD0IbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:31:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3050949F4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:31:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2E3821A4E;
        Thu, 27 Apr 2023 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682584281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAqWxeoT6YMgHdJzhyWG3lkDvVYHyX2WVhhTgyrw/4o=;
        b=qFeK/9WWgFt3omX3TNm9MjLqbsP0LlYdLsWLyHdh+KWVclDHWLa56aAfJdCDpFumUjChCB
        5gA8j6gO/V+KNJmcuPCk8JxmqcCeG5Yy79zEqOqDjf1LgJkjsfZ4zASC6jV0rLpEQAkV5b
        LR4z1o5OwGvCfwTkQ09GxiAFv9aisdc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4DC9138F9;
        Thu, 27 Apr 2023 08:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u9UkLdkySmQIVQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 27 Apr 2023 08:31:21 +0000
Date:   Thu, 27 Apr 2023 10:31:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZEoy2aYpGJ4/wOK7@dhcp22.suse.cz>
References: <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
 <ZEFB8FSKWms2VmaL@tpad>
 <ZEk2WHjwLl2qWZR3@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEk2WHjwLl2qWZR3@tpad>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-04-23 11:34:00, Marcelo Tosatti wrote:
> On Thu, Apr 20, 2023 at 10:45:20AM -0300, Marcelo Tosatti wrote:
[...]
> > There are additional details that were not mentioned. When we think
> > of flushing caches, or disabling per-CPU caches, this means that the
> > isolated application loses the benefit of those caches (which means you
> > are turning a "general purpose" programming environment into
> > potentially slower environment for applications to execute).

I do not really buy this argument! Nothing is really free and somebody
has to pay for the overhead. You want highly specialized workload to
enjoy all the performance while having high demand on latency yet the
overhead has to pay everybody else.

> https://www.uwsg.indiana.edu/hypermail/linux/kernel/2012.0/06823.html

This is just talking about who benefits from isolation and I do not
think there is any dispute in that regard. I haven't questioned that. My
main argument was that those really need to be special and careful to
achieve their goal and Thomas says a very similar thing. I do not see
any objection to an explicit programming model to achieve that goal.
 
> > (yes, of course, one has to be mindful of which system calls can be
> > used, for example the execution time of system calls which take locks will
> > depend on whether, and how many, users of those locks there are at a
> > given moment).

This is simply not maintainble state. Once you enter the kernel you
cannot really expect your _ultra low_ latency expectations.
 
[...]
> > So it seems to me (unless there are points that show otherwise, which
> > would indicate that explicit userspace interfaces are preferred) _not_
> > requiring userspace changes is a superior solution.
> > 
> > Perhaps the complexity should be judged for individual cases 
> > of interruptions, and if a given interruption-free conversion 
> > is seen as too complex, then a "disable feature which makes use of per-CPU
> > caches" style solution can be made (and then userspace has to
> > explicitly request for that per-CPU feature to be disabled).
> > 
> > But i don't see that this patchset introduces unmanageable complexity,
> > neither: 

As I've tried to explain, I disagree about the approach you are taking.
You are fixing your problem at a wrong layer. You really need to address
the fundamental issue and that is that you do not want housekeeping done
on isolated cpu(s) while your workload is running there.

vmstat updates are just one of schedule_on_cpu users who could disturb
your workload.  We do not want to chase every single one and keep
doing that for ever as new callers of that API are added. See the
point? "Fixing" vmstat will not make your isolated workload more
reliable. You really need a more generic solution rather than a quick
hack.

Also vmstat already has a concept of silencing - i.e. quiet_vmstat. IIRC
this is used by NOHZ. I do not remember any details but if anything this
is something I would have a look into.

There is close to 0 benefit to teaching remote stat flushing. As I've
said stats are only for debugging purposes and imprecise values
shouldn't matter. So this just adds a complexity without any actual real
benefit.

-- 
Michal Hocko
SUSE Labs
