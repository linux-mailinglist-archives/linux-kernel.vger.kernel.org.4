Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F715F0C65
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiI3N0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiI3N0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:26:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF818B5CE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:26:04 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C59271EC04DA;
        Fri, 30 Sep 2022 15:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664544357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lp7hZW6fL4gPkdYmrpDiNF39G6gXzVijhgQhSUy+zh0=;
        b=Pcn8be89+VAVOJS0cfzE1/U0IVaPLFkQ9HorTbZuSeS7l+DUWA95HnMsYl1o+vezldXhfz
        TB0JHqgFCWgM/ZYj95/+5sLKmuOcoWlHI9gq12TYtXWDZ3l76bqJRXdlXEfI0otvyjLbmv
        WJws7lZZcATn54MEu2WjdWfl5QYuZK0=
Date:   Fri, 30 Sep 2022 15:25:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzbuYfLGm918NmeR@zn.tnic>
References: <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
 <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com>
 <YzQui+rOGrM6otzp@zn.tnic>
 <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com>
 <YzRyaLRqWd6YSgeJ@zn.tnic>
 <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
 <b707e459-4e21-80f5-c676-c275528c06ae@suse.com>
 <YzbZJEeVHkTnWIfc@zn.tnic>
 <2e843e28-2836-910e-bcd8-f35872adf21a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e843e28-2836-910e-bcd8-f35872adf21a@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:11:07PM +0200, Juergen Gross wrote:
> Yes, this can be done. It would practically have to be the first one just
> after CPUHP_BRINGUP_CPU.

Right.

> The question is whether we really want to call the MTRR/PAT initialization
> on hotplugged cpus only after enabling interrupts. Note that the callbacks
> are activated only at the end of start_secondary(), while today MTRR/PAT
> initialization is called some time earlier by:
> 
>   start_secondary()
>     smp_callin()
>       smp_store_cpu_info()
>         identify_secondary_cpu()
>           mtrr_ap_init()
> 
> I don't think this is a real problem, but I wanted to mention it.

Yep, I saw that too but I don't think there will be a problem either.
I mean, it should be early enough as you point out not to need proper
MTRR/PAT settings yet.

But we'll make sure we test this real good too.

> The next question would be, why MTRR/PAT init should be special
> (meaning: why are all the other functions called that early not
> realized via callbacks)?

Well, our init code is crazy. Frankly, I don't see why not more of the
"init stuff on the freshly hotplugged CPU" work is done there...

> Is it just because of the special handling during boot/resume?

... unless this is the case, ofc. Right.

> It might be worth a discussion whether there shouldn't be a special group
> of callbacks activated BEFORE interrupts are being enabled.

That's a good question. /me writes it down to ask tglx when he gets back.

I mean, that early I don't think it matters whether IRQs are enabled
or not. But this'll need to be audited on a case by case basis. As I
said, our boot code is nuts with stuff bolted on everywhere for whatever
reasons.

> Thanks. I'll write a patch for that.

Thanks too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
