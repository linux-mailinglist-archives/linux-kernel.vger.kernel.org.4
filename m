Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E88671C09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjARM2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjARM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:27:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E39EE1B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674042381; x=1705578381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JoF9vVe1tkCvj804j2tCzb7TiNPsCz/UXlCdDCW6W10=;
  b=Dyk0+1StIj5D+rFIVWm32ehZMagKFZGW4ne69E7Mq3fYCo+19Y/88lI4
   HLJCguE4bDLeWZUNKPNdWfQIww58Ln/d+sDTOkpzvZ8J2o8wvv3O1Wkdq
   FvcnFLGpitfVODjG7D39sxWQDAnYQFEiRyrj3fPUuqJSXD63/nKdviy3J
   x02fEPU9DLidqOVXNRrB4IY6yCHG8u8gO0Q1kzK5VtSdMJdPiZKbhALsV
   LUbvkPfZa4WHSHAHMXx1ykJ2SlI1DXsZB1gciJnmM3f8s3vQ84dGpicdd
   s3UEH3Zcra5sKn/lx2aW2h4QNnE5Me77GuJnt3v9WihUOmENv70HjMW6G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="352210616"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="352210616"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 03:46:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="690160335"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="690160335"
Received: from semenova-mobl1.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.53.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 03:46:17 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 83581104CC6; Wed, 18 Jan 2023 14:46:14 +0300 (+03)
Date:   Wed, 18 Jan 2023 14:46:14 +0300
From:   kirill.shutemov@linux.intel.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, jroedel@suse.de,
        dave.hansen@intel.com, kai.huang@intel.com
Subject: Re: [PATCH v2 1/7] x86/boot: Remove verify_cpu() from
 secondary_startup_64()
Message-ID: <20230118114614.x2shsi6s3noiopux@box.shutemov.name>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.589522290@infradead.org>
 <Y8e/yKgVZgbqgvAG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8e/yKgVZgbqgvAG@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:45:44AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 16, 2023 at 03:25:34PM +0100, Peter Zijlstra wrote:
> > The boot trampolines from trampoline_64.S have code flow like:
> > 
> >   16bit BIOS			SEV-ES				64bit EFI
> > 
> >   trampoline_start()		sev_es_trampoline_start()	trampoline_start_64()
> >     verify_cpu()			  |				|
> >   switch_to_protected:    <---------------'				v
> >        |							pa_trampoline_compat()
> >        v								|
> >   startup_32()		<-----------------------------------------------'
> >        |
> >        v
> >   startup_64()
> >        |
> >        v
> >   tr_start() := head_64.S:secondary_startup_64()
> > 
> > Since AP bringup always goes through the 16bit BIOS path (EFI doesn't
> > touch the APs), there is already a verify_cpu() invocation.
> 
> So supposedly TDX/ACPI-6.4 comes in on trampoline_startup64() for APs --
> can any of the TDX capable folks tell me if we need verify_cpu() on
> these?
> 
> Aside from checking for LM, it seems to clear XD_DISABLE on Intel and
> force enable SSE on AMD/K7. Surely none of that is needed for these
> shiny new chips?

TDX has no XD_DISABLE set and it doesn't allow to write to
IA32_MISC_ENABLE MSR (triggers #VE), so we should be safe.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
