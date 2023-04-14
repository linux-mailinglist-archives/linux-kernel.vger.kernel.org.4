Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630D6E20A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjDNKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNKYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:24:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA464C06
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:24:09 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6A371EC0691;
        Fri, 14 Apr 2023 12:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681467847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzwGmagy1MIMXAlSo+f5eCVMJJv19H9njCTpV2nxbJQ=;
        b=Km+bVBsEXHNxE+eeFfgY5ed3dzBvFv4vupo30rdDxHJ+2LItz7zkNIjjmpWVWRgO72lCs+
        OVoD62Awwj19BXL61k+49NgAvmet04Gbgxz8B1DJkNqJB5eT8UWsRlzSNspJBm6DxU0ie7
        T3RqA2bJ/x7HoM558D5Z1JI/4vVAvhw=
Date:   Fri, 14 Apr 2023 12:24:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: AMD EPYC 25 (19h): Hardware Error: Machine Check: 0 Bank 17:
 d42040000000011b
Message-ID: <20230414102401.GAZDkpwUHfFM64dpIK@fat_crate.local>
References: <21a09968-296b-5b21-8079-6d9d4e0769d4@molgen.mpg.de>
 <20230412163240.GAZDbdKHjmQcxqkeDQ@fat_crate.local>
 <a5ab1099-fd08-c708-5532-21dc2a622695@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5ab1099-fd08-c708-5532-21dc2a622695@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:26:27AM +0200, Paul Menzel wrote:
> It says “no action required”,

Yes, it means you had a single bit flip in some DIMM and it got
corrected by the ECC so you don't need to do anything.

> but out of the identical 14 servers with the same workload this is the
> only one having shown this errors three times.

Or you could enable CONFIG_RAS_CEC and don't see those errors anymore.

It all depends: a DIMM could be producing correctable errors for a long
time before going bad. If ever. If you don't want to risk whatever
you're running on that machine by a DIMM *potentially* going bad, sure,
you can replace it. That's a budget call. :)

> Maybe the DIMM at bank 17 should just be replaced.

Bank 17 is the CPU MCA bank which reports the error - not a DIMM bank.
In order to pinpoint the location, you should have amd64_edac loaded so
that it decodes to which DIMM. You could try loading that module and
injecting all errors you have to see what it says, it should work this
way too as the error signature has everything needed for decoding,
AFAICT.

But Yazen can chime in here if I'm off.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
