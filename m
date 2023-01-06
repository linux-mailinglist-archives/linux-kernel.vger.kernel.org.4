Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE256608F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjAFVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAFVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:52:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7C2ACC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:52:51 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05DD81EC050D;
        Fri,  6 Jan 2023 22:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673041970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1vG7fuBPXuSMpd/HqQSUuei5CKmi9QnuuMsptlD6Zz0=;
        b=sEzy+SsOjNvlm8Q86TTK2em+j2IhtNeUfA2qmAqawxJnrJFVd75r+1kIpD27PZSLtTTznX
        wZ1StJdPanL3qSzt7rL5r/r4Ap3Tm60JySaDs/1Qe5wZkmA4gliae/VJbnygzKXWEZr7Qr
        s1uS5YNNo86tdG5uc7qsIidky/c/s34=
Date:   Fri, 6 Jan 2023 22:52:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Message-ID: <Y7iYLbEJSYnVn+dW@zn.tnic>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com>
 <Y7XMtWqSrs0uGkD7@zn.tnic>
 <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
 <Y7h8dpIQHnL93RdC@zn.tnic>
 <SJ1PR11MB6083BD0E0191061B72A47982FCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083BD0E0191061B72A47982FCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 09:35:41PM +0000, Luck, Tony wrote:
> # dmesg | tail -1
> microcode revision: 0x40001a -> 0x4001a
> 
> User doesn't notice that the version didn't change and thinks
> that all is well.

The version did change. One '0' less.

Users don't read even if you put in there:

	"Corrected error, no action required."

User still complains about maybe her hardware going bad and "should I replace my
CPU" yadda yadda...

But whatever, since both of you think this is sooo important, then pls do this:

Success: "Reload completed, microcode revision: 0x%x -> 0x%x\n"

Failure: "Reload failed, current microcode revision: 0x%x\n"

Or something along those lines.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
