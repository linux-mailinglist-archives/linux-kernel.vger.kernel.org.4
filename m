Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DEF686649
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBAMxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjBAMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:53:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CA558E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:53:34 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D07E61EC0691;
        Wed,  1 Feb 2023 13:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675256012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QCSNqE80tGMEO4sQcnGk1Vn2CvpIBiPcvlWbZkvRnQw=;
        b=YcBBEppLGYyEFDkL8tBugvladbjXoW6b+EBgLCxqiNPGJl4akNEueSEVRoKb4ro9Zoptql
        K7xcwNqdXjlR/RbD4unDLAeYqyqcwQRBeRMQ2aHm3V0R819wQ4D9FQ04XGr5Y6oZhQyXs/
        p0WyvE39B1j643zB4iYs6Mm6yHETV7k=
Date:   Wed, 1 Feb 2023 13:53:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: Re: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Message-ID: <Y9pgzGr4MccwEJAl@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
 <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9l8yGVvVHBLKAoh@zn.tnic>
 <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9mDYMASXCFaFkNU@zn.tnic>
 <SJ1PR11MB608384F3B075E0D2F25683D3FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608384F3B075E0D2F25683D3FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:43:23PM +0000, Luck, Tony wrote:
> In an ideal world yes. But what if T1 arrives here and tries to do the
> update while T0, which has returned out of the microcode update
> code and could be doing anything, happen to be doing WRMSR(some MSR
> that the ucode update is tinkering with).
> 
> Now T0 explodes (not literally, I hope!) but does something crazy because
> it was in the middle of some microcode flow that got updated between two
> operations.

So first of all, I'm wondering whether the scenario you're chasing is
something completely hypothetical or you're actually thinking of
something concrete which has actually happened or there's high potential
for it.

In that case, that late patching sync algorithm would need to be made
more robust to handle cases like that.

Because from what I'm reading above, this doesn't sound like the
reporting is wrong only but more like, if T0 fails the update and T1
gets to do that update for a change, then crap can happen.

Which means, our update dance cannot handle that case properly.

Hmmm...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
