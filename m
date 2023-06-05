Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6C722BF5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjFEPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjFEPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:51:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F650AF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685980302; x=1717516302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wBlzO0m7e+06ffK6F4CZHPjf68k4XsbL0e49Ityn51E=;
  b=c5wjYYv6xmGdSrQoHLfcYPHU01rNn2Z+ToVVIdsPMB7dD7UPM9OiH2fa
   n6iAQBKgmLAFUfHT2lp34PMQrSmaKi+NDHGLX8RPoRWdDP5jHzoOmeoEs
   oCXTO4q5PHTCgSEIJbG7P6Gb36XYLiUG3WCmgzCx1VhFfIwlh6duq9mvh
   I4D0A7l2Fq4JnCzw/M9YnWAVWoloansOuAQaYRdjnp6/kHUZtK1bE1B5M
   i18B3xKb6kIwkzXih2s4r/A5hzwynXO0SgiwKH71icl2ZCtbZP4k76zJg
   WfcRe1DqGwjW4POs8qupXyWz8G0nu3KhwiavNxGLc2yTCt+cyrJc/+bgR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359714609"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359714609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773779105"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="773779105"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.8.179])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:51:33 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Marek =?ISO-8859-1?Q?Marczykowski=2DG=F3recki?= 
        <marmarek@invisiblethingslab.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RESUBMIT][PATCH] x86/mm: Fix PAT bit missing from page protection modify
 mask
Date:   Mon, 05 Jun 2023 17:51:31 +0200
Message-ID: <2227080.iZASKD2KPV@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <5083c051-dfcf-ae23-195f-4c92bb875009@suse.com>
References: <20230519183634.190364-1-janusz.krzysztofik@linux.intel.com>
 <bd70e7b8-1971-6982-979a-ce1eb4c93465@suse.com>
 <5083c051-dfcf-ae23-195f-4c92bb875009@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(fixed misspelled Cc: email address of intel-gfx list)

On Friday, 2 June 2023 16:53:30 CEST Juergen Gross wrote:
> On 02.06.23 16:48, Juergen Gross wrote:
> > On 02.06.23 16:43, Borislav Petkov wrote:
> >> On Thu, Jun 01, 2023 at 10:47:39AM +0200, Juergen Gross wrote:
> >>> As described in the commit message, this only works on bare metal due to 
the
> >>> PAT bit not being needed for WC mappings.
> >>>
> >>> Making this patch Xen specific would try to cure the symptoms without 
fixing
> >>> the underlying problem: _PAGE_PAT should be regarded the same way as the 
bits
> >>> for caching mode (_PAGE_CHG_MASK).
> >>
> >> So why isn't _PAGE_PAT part of _PAGE_CHG_MASK?
> > 
> > This would result in problems for large pages: _PAGE_PSE is at the same
> > position as _PAGE_PAT (large pages are using _PAGE_PAT_LARGE instead).
> > 
> > Yes, x86 ABI is a mess.
> 
> Oh, wait: I originally thought _PAGE_CHG_MASK would be used for large pages,
> too. There is _HPAGE_CHG_MASK for that purpose.

Since _HPAGE_CHG_MASK has the _PAGE_PSE aka _PAGE_PAT bit already set, while 
_PAGE_CHK_MASK has not, the real question is not about large pages processing, 
I believe, which won't change whether we add _PAGE_PAT to _PAGE_CHG_MASK or 
not.

If we extend _PAGE_CHG_MASK with _PAGE_PAT bit then its value will be not any 
different from _HPAGE_CHG_MASK.  Then, one may ask why _HPAGE_CHG_MASK, with 
_PAGE_PSE aka PAGE_PAT bit set unlike in _PAGE_CHG_MASK, was introduced once 
for use with large pages, and _PAGE_CHG_MASK left intact for use with standard 
pages, if we now think that adding that bit to _PAGE_CHG_MASK won't break 
processing of standard pages.

If we are sure that adding _PAGE_PAT to _PAGE_CHG_MASK won't break any of its 
users then let's go for it.

Thanks,
Janusz

> 
> So adding _PAGE_PAT to _PAGE_CHG_MASK and _PAGE_PAT_LARGE to _HPAGE_CHG_MASK
> should do the job. At least I hope so.
> 
> 
> Juergen
> 




