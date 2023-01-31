Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D50683857
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjAaVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjAaVJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:09:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77253982
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:08:58 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79BA81EC0104;
        Tue, 31 Jan 2023 22:08:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675199337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LMP/QMFsFKhoP9e1MvUTWpew6YMs3U0h5i1EaPY92UQ=;
        b=EwMtOlDiRCT4wJONiPQwtEbJyA/stzMzHWjqvGB6ZN9/h9wgNHY1fSexiTSMmsdPWxodls
        3N24+SbRKXwMtIQ+PehXry/l+GD3pw3eQeCRIJqLuiAvWvc16yh7oSl7B7Zs8W+LYneO2Q
        +TeAbRLEicg9YQqu0Yf5NVPjIFliRBk=
Date:   Tue, 31 Jan 2023 22:08:48 +0100
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
Message-ID: <Y9mDYMASXCFaFkNU@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
 <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9l8yGVvVHBLKAoh@zn.tnic>
 <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:49:52PM +0000, Luck, Tony wrote:
> What happens here if the update on the first hyperthread failed (sure, it shouldn't,
> but stuff happens at large scale).  In this case the current rev is still older that the
> the cache version ... so there is no "goto out", and this hyperthread will now write
> the MSR to initiate microcode update here, while the first thread is off executing
> arbitrary code (the situation that we want to avoid).

Lemme see if I can follow: we sync all threads in __reload_late() and
once they all arrive, we send them down into ->apply_microcode.

T0 arrives, and fails the update. That is this piece:

        /* write microcode via MSR 0x79 */
        wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);

        rev = intel_get_microcode_revision();

        if (rev != mc->hdr.rev) {
                pr_err("CPU%d update to revision 0x%x failed\n",
                       cpu, mc->hdr.rev);
                return UCODE_ERROR;
        }

We return here without updating cpu_sig.rev, as we should.

T1 arrives, updates successfully and updates its cpu_sig.rev.

T0's patch level has been updated too with that because the microcode
engine is shared between the threads. T0's cpu_sig.rev isn't, however,
as that has happened "behind its back", so to speak.

Is that the scenario you're talking about?

If so, if you look at __reload_late(), it'll say

	pr_warn("Error reloading microcode on CPU %d\n", cpu);

and the large scale operator will know.

And well, the easy fix is, do the reload again. :-)

That'll update the cached values too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
