Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC48F6E25E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDNOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDNOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:38:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC710D4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:38:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A337219E3;
        Fri, 14 Apr 2023 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681483088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCpCRas5e1O/lx2F+9VlD8zzWi4xZYx+jIolm1KhaIE=;
        b=gvhvGfgXdwv3pDtUUVJnxWkc8YLrJwqpOjMW9yKD3n+2/hTlIs9Hc0wyYGgQT4bzdLhdX6
        nrSbjIJXm6+Tx63mI+vtnFJ3PHuaQ+ejvOPuLirHbRz/HtArLXuBNflRKLcs31qT4ZubfV
        NAPz1g/8k+HCgzqCPKLJusr9N+nWEUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681483088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCpCRas5e1O/lx2F+9VlD8zzWi4xZYx+jIolm1KhaIE=;
        b=3pqqZqaMfHrFg0O+sXeEKaxFN73PwVLnc6bNBhRBcDwoCzKUsCWgASjoAY+9Q78bXMBUy3
        ms/38HRV0BNhiyAA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E8A5E2C173;
        Fri, 14 Apr 2023 14:38:07 +0000 (UTC)
Date:   Fri, 14 Apr 2023 16:38:06 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] pseries/smp: export the smt level in the SYS FS.
Message-ID: <20230414143806.GI63923@kunlun.suse.cz>
References: <20230331153905.31698-1-ldufour@linux.ibm.com>
 <20230331153905.31698-2-ldufour@linux.ibm.com>
 <87ttxjaonc.fsf@mpe.ellerman.id.au>
 <0e668a82-3a3e-798a-8707-1a9b622b23b6@linux.ibm.com>
 <87leiuack3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leiuack3.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Apr 14, 2023 at 10:11:24PM +1000, Michael Ellerman wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
> > On 13/04/2023 15:37:59, Michael Ellerman wrote:
> >> Laurent Dufour <ldufour@linux.ibm.com> writes:
> >>> There is no SMT level recorded in the kernel neither in user space.
> >>> Indeed there is no real constraint about that and mixed SMT levels are
> >>> allowed and system is working fine this way.
> >>>
> >>> However when new CPU are added, the kernel is onlining all the threads
> >>> which is leading to mixed SMT levels and confuse end user a bit.
> >>>
> >>> To prevent this exports a SMT level from the kernel so user space
> >>> application like the energy daemon, could read it to adjust their settings.
> >>> There is no action unless recording the value when a SMT value is written
> >>> into the new sysfs entry. User space applications like ppc64_cpu should
> >>> update the sysfs when changing the SMT level to keep the system consistent.
> >>>
> >>> Suggested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> >>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> >>> ---
> >>>  arch/powerpc/platforms/pseries/pseries.h |  3 ++
> >>>  arch/powerpc/platforms/pseries/smp.c     | 39 ++++++++++++++++++++++++
> >>>  2 files changed, 42 insertions(+)
> >>
> >> There is a generic sysfs interface for smt in /sys/devices/system/cpu/smt
> >>
> >> I think we should be enabling that on powerpc and then adapting it to
> >> our needs, rather than adding a pseries specific file.
> >
> > Thanks Michael, I was not aware of this sysfs interface.
> >
> >> Currently the generic code is only aware of SMT on/off, so it would need
> >> to be taught about SMT4 and 8 at least.
> >
> > Do you think we should limit our support to SMT4 and SMT8 only?
> 
> Possibly? Currently the SMT state is represented by an enum:
> 
> enum cpuhp_smt_control {
> 	CPU_SMT_ENABLED,
> 	CPU_SMT_DISABLED,
> 	CPU_SMT_FORCE_DISABLED,
> 	CPU_SMT_NOT_SUPPORTED,
> 	CPU_SMT_NOT_IMPLEMENTED,
> };
> 
> Adding two states for SMT4 and SMT8 seeems like it might be acceptable.
> 
> On the other hand if we want to support artbitrary SMT values from 3 to
> 8 then it might be better to store that value separately from the state
> enum.
> 
> TBH I'm not sure whether we want to support values other than 1/2/4/8
> via this interface.
> 
> A user who wants some odd numbered SMT value can always configure that
> manually using the existing tools.
> 
> But maybe it's less confusing if this interface supports all values?
> Even if they're unlikely to get much usage.

It looks like ppc64_cpu simply enables first n threads of the CPU where
n is the smt value without any interleaving hoping that the architecture
does the right thing. Under this implementation smt=3 is well-defined.

For the dual cluster P9 CPUs that have two clusters of four this might
work out well for some workloads, and others might want that
interleaving. With that the odd smt values are not well-definedd
anymore.

Nonetheless, if the kernel does support some smt=n parameter whatever
the semantic this should be also supported by the runtime knob.

If it's too difficult to get right there is always that option to not
enable any thread by default, and let the userspace to implement
arbitrarily complex schemes :)

Thanks

Michal
