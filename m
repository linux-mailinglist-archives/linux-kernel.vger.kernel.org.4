Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02926728144
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbjFHNWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbjFHNWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:22:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74842D40
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686230555; x=1717766555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7LFCJpqQk3CtFV+JOHfXY2sfWnruFCxaYOEoUTkSQJU=;
  b=J6ZjLnwqEjYJ4kl9xSFZVwh+qhnMh6fwbmQmbiAy1GF0HrdaE7ok4wjL
   qNj5lOTESZt4pRogX/H5QBdjddAXzuYFJaBXT5oU+ER1sAqXaQWQC6b5+
   ZG402aPVs0z0mXh62QdhHmjbm6bJxRE88zNMMEVLpfcrWobDk9q+ihrPi
   HXomfJ9wwnWh/bW0gmpjC2+KYFU0nxzMtV5m/OXkYpoBiSRE8o91E5Mkm
   6i+pQvh0o7hg+M1TldVtce6zVps3F44v6U/rLFjXfGTUgy5jEvqC2s9tb
   rOABp3kKwnRF4at7lKRwfzigUyApa2dSW9WTZuYmsRwd9s+k13dlwesa1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="336935989"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="336935989"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709979904"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="709979904"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.20.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:19:14 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Gross, Jurgen" <jgross@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] x86/mm: Fix PAT bit missing from page protection modify mask
Date:   Thu, 08 Jun 2023 15:19:12 +0200
Message-ID: <3942492.ZaRXLXkqSa@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <8bcfad6697316e200f78bd13e737345dc0436404.camel@intel.com>
References: <20230607152308.125787-2-janusz.krzysztofik@linux.intel.com>
 <20819659.0c2gjJ1VT2@jkrzyszt-mobl2.ger.corp.intel.com>
 <8bcfad6697316e200f78bd13e737345dc0436404.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 8 June 2023 00:47:36 CEST Edgecombe, Rick P wrote:
> On Wed, 2023-06-07 at 23:33 +0200, Janusz Krzysztofik wrote:
> > > So since _PAGE_PSE is actually the same value as _PAGE_PAT, you
> > > don't
> > > actually need to have _PAGE_PSE in _HPAGE_CHG_MASK in order to get
> > > functional correctness. Is that right?
> > 
> > As soon as we add _PAGE_PAT to _PAGE_CHG_MASK -- yes, that's right. 
> > But we 
> > may still want to add _PAGE_PSE to _HPAGE_CHG_MASK to have the need
> > for that 
> > bit explicitly documented.
> 
> _PAGE_PSE is already in _HPAGE_CHG_MASK though, right? I'm confused.

Yes, it is, sorry for confusion.  I should have said: we may still want to 
keep _PAGE_PSE explicitly added to _HPAGE_CHK_MASK to have the reason for 
including that bit documented.

Thanks,
Janusz


> 
> > 
> > > 
> > > I think it is still a little hidden (even before this) and I wonder
> > > about separating out the common bits into, like,
> > > _COMMON_PAGE_CHG_MASK
> > > or something. Then setting specific PAGE and HPAGE bits (like
> > > _PAGE_PAT, _PAGE_PSE and _PAGE_PAT_LARGE) in their specific define.
> > > Would it be more readable that way?
> > 
> > Yes, I think that's a good idea, and I can use it in my patch.
> > 
> > The question if _PAGE_PAT vel _PAGE_PSE added to _PAGE_CHG_MASK is
> > really 
> > harmless for pte_modify() and its users is still open for me though.
> 
> When you say "vel", this is similar to the english acronym "AKA" I
> think?
> 
> So I think you mean, when you add _PAGE_PAT to _PAGE_CHG_MASK, you are
> also adding _PAGE_PSE to it. So does that cause any problems? I see,
> good question... 
> 
> vm_page_prot is used when creating PTEs and huge PMDs, and the setter
> only uses _PAGE_CHG_MASK, even though it won't actually know where that
> prot is going to end up.
> 
> Having _PAGE_PAT/PSE in _PAGE_CHG_MASK certainly doesn't make it easier
> to think about. One thing it's favor though is vm_page_prot is not
> applied to page table entries that are pointing to other page table
> entries (PSE = 0). So you shouldn't accidentally set PSE=1. And
> _PAGE_PSE shouldn't be being set in there, so you also shouldn't
> accidentally be setting PAT=1.
> 
> But yea, I see why you are concerned. I would /guess/ it would be ok
> functionally. That probably doesn't help much...
> 




