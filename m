Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88986837A4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjAaUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:40:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936440E2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:40:46 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05E2B1EC0682;
        Tue, 31 Jan 2023 21:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675197645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oEqVYVNvdE8Ltv7Ob7zODCbyNh/LdOlWdY6JHxFhh/4=;
        b=gNFKLXc4V3zKNPGehUChfUZtPAOacceeAC0wcs4fbXJF3J/wiEDQl9Ebrfvv4PbY0WMt+5
        bZZKYsbIytNLsnc995ut2ZEcF/lEAgfMLptWYPJ/xZh/JkFwCZGvNdeybSAXdNMTKIVnKh
        zIkCT7DwR9ZIcucDZgSn7HXNuI5MZNE=
Date:   Tue, 31 Jan 2023 21:40:40 +0100
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
Message-ID: <Y9l8yGVvVHBLKAoh@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
 <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 05:34:14PM +0000, Luck, Tony wrote:
> But those get out of step when applying ucode on one logical CPU does
> an update to other(s) (in this case the HT sibling for the same core).

They shouldn't.

I presume you're talking about late update. If so and if it finds a
patch in the cache, it'll do this:

apply_microcode_intel:

        /*
         * Save us the MSR write below - which is a particular expensive
         * operation - when the other hyperthread has updated the microcode
         * already.
         */
        rev = intel_get_microcode_revision();
        if (rev >= mc->hdr.rev) {
                ret = UCODE_OK;
                goto out;
        }

and at the out: label it'll update the revision.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
