Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2FC69D610
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjBTWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBTWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:01:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211EB4C3B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:01:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676930478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfqBIrdn5rWMQ3+U0cKrDyXxSebET4rDLTATkZ1AnaI=;
        b=qLliU2OdF3CeCWdUu/vgg+84f2MEcYKOprom+1N3lo3YmqUY2WVd/egbgwUd54ueHzc75A
        MoZxZhkJi9KCH/zGuNwzYbZpsa4xsC9kNjUPSpzhB//fz5DNhl4SHHro5KqvRJaeIQ5IRc
        /8DIrz0rbH0cJB/Cluoq5OUIiJQF0E6A+AiTZFPrpT6jLodbuFZul1h9b5X694jV76zi4y
        OfP8mzpQmGt7NkjDn1auLZjcTgetZflhWDUyqNjWRjegKWRJM8P6QXZ5Rcy2LGy/1uqB3+
        W19YfkHtA3ahKQUADvW9bNOe6rTnG9dD/+w0SnT/Xb/F5JZoDTKXSJMcpXzbsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676930478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfqBIrdn5rWMQ3+U0cKrDyXxSebET4rDLTATkZ1AnaI=;
        b=yEZzRQZzZkp6F4iyf7NMpiysEygey1YR2ob12Bb9ctIazuHEPk6p4wSzkSdVo8P1IBuHRZ
        UYBZUPspScc/R2AQ==
To:     Krister Johansen <kjlx@templeofstupid.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: Re: [PATCH linux-next 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
In-Reply-To: <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
Date:   Mon, 20 Feb 2023 23:01:18 +0100
Message-ID: <87h6vgov2p.ffs@tglx>
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

On Mon, Feb 20 2023 at 09:17, Krister Johansen wrote:
> @@ -495,8 +496,7 @@ static int __init xen_tsc_safe_clocksource(void)
>  	/* Leaf 4, sub-leaf 0 (0x40000x03) */
>  	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);
>  
> -	/* tsc_mode = no_emulate (2) */
> -	if (ebx != 2)
> +	if (ebx != XEN_CPUID_TSC_MODE_NEVER_EMULATE)
>  		return 0;
>  
>  	return 1;

What about removing more stupidity from that function?

static bool __init xen_tsc_safe_clocksource(void)
{
	u32 eax, ebx. ecx, edx;
 
	/* Leaf 4, sub-leaf 0 (0x40000x03) */
	cpuid_count(xen_cpuid_base() + 3, 0, &eax, &ebx, &ecx, &edx);

	return ebx == XEN_CPUID_TSC_MODE_NEVER_EMULATE;
}

Thanks,

        tglx
