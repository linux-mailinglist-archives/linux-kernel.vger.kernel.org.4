Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4E645D4E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLGPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLGPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:11:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068D95BD4E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670425869; x=1701961869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMPUOHalL8GMbPkTTAqItcCIZWGWGTJQ34nIj7pln6s=;
  b=hOr3MzuJfKxzaw2FUhcv7UZyQ5nl8P8I+MXKsVdPQf8+9eqCpXfAOezJ
   7AYzK/DVMD7+giEgSlSHh/SXHDvxAAav9YbFP6l7gVtCEgBf3DdWU1Gfu
   q0FgkOm2tohoB8ANnUwvvlCebXJPqKotCzGcuaOGI07eJQaRYET/y0PFH
   xWictQmrOV/bSzYbWnaNJMtS9MGZzwptmhmdgfdS+IbeAAKLqNzh+DLrV
   XwPbHbKgjohf0nMCAX6ji9FZhhRbdq97Ao3BTo5EydjStGCLgEJVPZQD/
   qoqRlxFDTiR6EycXjtfJ0mlJNz8BzpUTRhiJ3u/J1Guv0XvHnpPcJdiwA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381204906"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="381204906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:11:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="735424118"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="735424118"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2022 07:11:05 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2B7FB4J0013877;
        Wed, 7 Dec 2022 15:11:04 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/boot: fix relying on link order
Date:   Wed,  7 Dec 2022 16:08:54 +0100
Message-Id: <20221207150854.2077580-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121160030.395096-1-alexandr.lobakin@intel.com>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com> <20221107125528.543764-1-alexandr.lobakin@intel.com> <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com> <20221121120918.388035-1-alexandr.lobakin@intel.com> <Y3t5wxKwIAycpDV8@zn.tnic> <20221121160030.395096-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 21 Nov 2022 17:00:30 +0100

> From: Borislav Petkov <bp@alien8.de>
> Date: Mon, 21 Nov 2022 14:14:43 +0100
> 
> > On Mon, Nov 21, 2022 at 01:09:18PM +0100, Alexander Lobakin wrote:
> > > > Things are a bit busy in the review queue at the moment.  As always,
> > > > we'd love help reviewing stuff.  So, while you're waiting for us to
> > > > review this, could you perhaps look around and find a series that's also
> > > > hurting for review tags?

[...]

> I know, I got it from the first read :D I try to review stuff I have
> mature knowledge in each day, not that lots of them are from the x86
> ML :s

I was hoping it would hit one of the 6.1 RCs as a fix, oh well :D
Why did some other fixes hit the x86 tree during that time then?

> 
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> 
> Thanks,
> Olek

Thanks,
Olek
