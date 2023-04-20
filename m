Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB666E8CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjDTIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDTIk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:40:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398340C7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:40:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE9A72188F;
        Thu, 20 Apr 2023 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681980025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psUcnuY/w561sLF9FEzotMA5NMwI4obQ8dTonjhOYWQ=;
        b=vEM1P4IF7e2R2tj9sfsDmTf1Y8+LO0GGYN9OH9KqScwkYgNEmoqUVXvbhT8G14JIQ/6Tie
        gbBTccs8gMqtmQ134Ulr4wrkWDSyMRxBCaxrzXYYSBsPmwKbPnNa5TbyOpFZLaqI2msPJj
        FFZQ3ftw9NgMa0fPe4RmYqzKyNs/8Uw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE2E61333C;
        Thu, 20 Apr 2023 08:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7lwYLHn6QGRBdQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 20 Apr 2023 08:40:25 +0000
Date:   Thu, 20 Apr 2023 10:40:25 +0200
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
Message-ID: <ZED6eS2VEqZUvc4I@dhcp22.suse.cz>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEAYQBJmVwsjpjGY@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-23 13:35:12, Marcelo Tosatti wrote:
[...]
> This is a burden for application writers and for system configuration.

Yes. And I find it reasonable to expect that burden put there as there
are non-trivial requirements for those workloads anyway. It is not
out-of-the-box thing, right?

> Or it could be done automatically (from outside of the application).
> Which is what is described and implemented here:
> 
> https://lore.kernel.org/lkml/20220204173537.429902988@fedora.localdomain/
> 
> "Task isolation is divided in two main steps: configuration and
> activation.
> 
> Each step can be performed by an external tool or the latency
> sensitive application itself. util-linux contains the "chisol" tool
> for this purpose."

I cannot say I would be a fan of prctl interfaces in general but I do
agree with the overal idea to forcing a quiescent state on a set of
CPUs.

> But not only that, the second thing is:
> 
> "> Another important point is this: if an application dirties                                                                          
> > its own per-CPU vmstat cache, while performing a system call,                                                                       
> 
> Or while handling a VM-exit from a vCPU.

Do you have any specific examples on this?

> This are, in my mind, sufficient reasons to discard the "flush per-cpu
> caches" idea. This is also why i chose to abandon the prctrl interface
> patchset.
> 
> > and a vmstat sync event is triggered on a different CPU, you'd have to:                                                             
> >                                                                                                                                     
> > 1) Wait for that CPU to return to userspace and sync its stats                                                                      
> > (unfeasible).                                                                                                                       
> >                                                                                                                                     
> > 2) Queue work to execute on that CPU (undesirable, as that causes                                                                   
> > an interruption).                                                                                                                   
> >                                                                                                                                     
> > 3) Remotely sync the vmstat for that CPU."
> 
> So the only option is to remotely sync vmstat for the CPU
> (unless you have a better suggestion).

`echo 1 > /proc/sys/vm/stat_refresh' achieves essentially the same
without any kernel changes.

But let me repeat, this is not just about vmstats. Just have a look at
other queue_work_on users. You do not want to handy pick each and every
one and do so in the future as well.
-- 
Michal Hocko
SUSE Labs
