Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0A686576
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBALdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBALdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:33:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D87113F1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:33:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675251198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nI1PAwKddaSlonMOIonB4C8xfAlPiE+lPzih70stM2Q=;
        b=DEP0O1kN6+ScaSW6M0RPcv/dP/fRnYqSxB1GUlqBk3fBf5Rz31zEVvaXsgLWhJ3l0q9qDf
        p88rrVpmb+uDEhJ2WEcn/qm6KA/lyhhRAj6y546vrUFf1H1Iub12F036/L18p7LH3HenTA
        1j4JwR2ZNFJwx7Enz0GGndT0LLLTWFqZ+c3NH936h5hv2vKTWnSDBmu7k2HZ2hBSnBYK/F
        44KVo0WHhUmy2nuj306rJt6lbcdmSUf/9ljZJK+GcdkB8hbz5J7ufdlsSbo9LCDru/renp
        2sjsLwwMD2shZgKiEZn5BOXr8MHczLZp7SaYQBQqRZ9Hd1lpMnkt/oqj6vsBkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675251198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nI1PAwKddaSlonMOIonB4C8xfAlPiE+lPzih70stM2Q=;
        b=Ig6VyHyEiPO2YkxAMHiu3NPx6My5ePCG7Qh0v6zCmtEwdojwebYra/4Lti5kIshJvQsSNN
        Haz3abKT7gzfHVCw==
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <20230131224236.122805-6-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com>
Date:   Wed, 01 Feb 2023 12:33:17 +0100
Message-ID: <87sffpzkle.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric!

On Tue, Jan 31 2023 at 17:42, Eric DeVolder wrote:
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -366,6 +366,14 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  
>  	/* Prepare one phdr of type PT_NOTE for each present CPU */
>  	for_each_present_cpu(cpu) {
> +#ifdef CONFIG_CRASH_HOTPLUG
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +			/* Skip the soon-to-be offlined cpu */
> +			if ((image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU) &&
> +				(cpu == image->offlinecpu))
> +				continue;
> +		}
> +#endif

I'm failing to see how the above is correct in any way. Look at the
following sequence of events:

     1) Offline CPU$N

        -> Prepare elf headers with CPU$N excluded

     2) Another hotplug operation != 'Online CPU$N'

        -> Prepare elf headers with CPU$N included

Also in case of loading the crash kernel in the situation where not all
present CPUs are online (think boot time SMT disable) then your
resulting crash image will contain all present CPUs and none of the
offline CPUs are excluded.

How does that make any sense at all?

This image->hp_action and image->offlinecpu dance is engineering
voodoo. You just can do:

        for_each_present_cpu(cpu) {
            if (!cpu_online(cpu))
            	continue;
            do_stuff(cpu);

which does the right thing in all situations and can be further
simplified to:

        for_each_online_cpu(cpu) {
            do_stuff(cpu);

without the need for ifdefs or whatever.

No?

Thanks,

        tglx
