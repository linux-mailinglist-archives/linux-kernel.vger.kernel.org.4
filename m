Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3EB694A20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjBMPEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjBMPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:04:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927BA1C7ED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:04:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 124F91F385;
        Mon, 13 Feb 2023 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676300674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OToXXZIiWyAXEWcNWyx7IuheXO6/EAzirjW2J5oIVV8=;
        b=jeiuJTj7Atw+amz6Q6JVcsHkMzhJtLLZAZB0WGuZruMAcoS6BkxP2GDc5J6w/IhAt1Zxc3
        33Gs/gyhDUJTn+en/dTdYkILOT06hkOkv6pkKfGr0I3aXB5v7CwsIcFxBBAP50RLNt1woY
        8Dmd3mUYubLXPE9908DGDz2J0N89/Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676300674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OToXXZIiWyAXEWcNWyx7IuheXO6/EAzirjW2J5oIVV8=;
        b=Fuyr7ypH29sejDdyzCavt4aKXfOGvtbOIQ8gs49CBpeEkD0xjflMdNhW25mvxU7yGphGBq
        9ObgRgxkM0d4w0BA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2A9DF2C141;
        Mon, 13 Feb 2023 15:04:31 +0000 (UTC)
Date:   Mon, 13 Feb 2023 16:04:29 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/cpuhp: respect current SMT when adding
 new CPU
Message-ID: <20230213150429.GZ19419@kitsune.suse.cz>
References: <20230213124510.12651-1-ldufour@linux.ibm.com>
 <87ilg5aahx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilg5aahx.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 13, 2023 at 08:46:50AM -0600, Nathan Lynch wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
> > When a new CPU is added, the kernel is activating all its threads. This
> > leads to weird, but functional, result when adding CPU on a SMT 4 system
> > for instance.
> >
> > Here the newly added CPU 1 has 8 threads while the other one has 4 threads
> > active (system has been booted with the 'smt-enabled=4' kernel option):
> >
> > ltcden3-lp12:~ # ppc64_cpu --info
> > Core   0:    0*    1*    2*    3*    4     5     6     7
> > Core   1:    8*    9*   10*   11*   12*   13*   14*   15*
> >
> > There is no SMT value in the kernel. It is possible to run unbalanced LPAR
> > with 2 threads for a CPU, 4 for another one, and 5 on the latest.
> >
> > To work around this possibility, and assuming that the LPAR run with the
> > same number of threads for each CPU, which is the common case,
> 
> I am skeptical at best of baking that assumption into this code. Mixed
> SMT modes within a partition doesn't strike me as an unreasonable
> possibility for some use cases. And if that's wrong, then we should just
> add a global smt value instead of using heuristics.
> 
> > the number
> > of active threads of the CPU doing the hot-plug operation is computed. Only
> > that number of threads will be activated for the newly added CPU.
> >
> > This way on a LPAR running in SMT=4, newly added CPU will be running 4
> > threads, which is what a end user would expect.
> 
> I could see why most users would prefer this new behavior. But surely
> some users have come to expect the existing behavior, which has been in
> place for years, and developed workarounds that might be broken by this
> change?
> 
> I would suggest that to handle this well, we need to give user space
> more ability to tell the kernel what actions to take on added cores, on
> an opt-in basis.
> 
> This could take the form of extending the DLPAR sysfs command set:
> 
> Option 1 - Add a flag that tells the kernel not to online any threads at
> all; user space will online the desired threads later.
> 
> Option 2 - Add an option that tells the kernel which SMT mode to apply.

powerpc-utils grew some drmgr hooks recently so maybe the policy can be
moved to userspace?

Thanks

Michal
