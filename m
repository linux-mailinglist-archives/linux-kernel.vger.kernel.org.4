Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9D645DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLGPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLGPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:32:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF862E8B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670427148; x=1701963148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hilpLqpxqU7tC71QEaO1JpjDWV0AUQXPiO9iRBcnREc=;
  b=Iw50CPCfjAxK0MaeBtaWIETyNu07wuAfPdiIKIjP6dxqaG/iPd6Z2TuI
   S4th/69TorgtQBiWV6pX2nsjBsygpSz7vpS4uwesZ041TIbUzFG2LlPu+
   ul9qC8KU6LmkV7WcPAPWLE/uOtsb1jZ6+RSOr6HlNc0mjJVmQgDdNCyZo
   hqyRC02k6XfMJFsJH5hOSuZUFFCNdXM2GCrnOkglvcRlmu2I+gqlLzuRh
   9gNbu4v2RpDRWacZqNr8QAQ6wzmSkbeN99OpCJQ4HiHF2STNSJoQjLsOr
   IplRkiwqC6LH2FZxsxc0rVrtWUkg6BD3z2h+OH+XLn8eqfFE4qDyMXzHd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="297271798"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297271798"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="771138373"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="771138373"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2022 07:31:52 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2B7FVoGe019218;
        Wed, 7 Dec 2022 15:31:50 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>, x86@kernel.org,
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
Date:   Wed,  7 Dec 2022 16:30:00 +0100
Message-Id: <20221207153000.2146772-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y5CwECT3a7tySawo@zn.tnic>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com> <20221107125528.543764-1-alexandr.lobakin@intel.com> <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com> <20221121120918.388035-1-alexandr.lobakin@intel.com> <Y3t5wxKwIAycpDV8@zn.tnic> <20221121160030.395096-1-alexandr.lobakin@intel.com> <20221207150854.2077580-1-alexandr.lobakin@intel.com> <Y5CwECT3a7tySawo@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>
Date: Wed, 7 Dec 2022 16:24:00 +0100

> On Wed, Dec 07, 2022 at 04:08:54PM +0100, Alexander Lobakin wrote:
> > I was hoping it would hit one of the 6.1 RCs as a fix,
> 
> As a fix for which existing configuration which breaks if this fix is
> missing?

Ugh, fair enough :D Without it, FG-KASLR is broken, GCC-LTO is
broken, but none of them is in the mainline.
I recall there were some folks with LLD for which this $(head-y)
removal caused issues as well. But if they're quiet now, seems like
they don't hardly need it.
But not every fix is a fix only when it's easy to find a repro,
right...? But at least such are not urgent, you're correct here.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Thanks,
Olek
