Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82726328E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiKUQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiKUQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:01:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65FFD2881
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669046478; x=1700582478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pLe/ct9SeJ901K1pmaY7qOYT9Jr+za1iO1Vv3IlDQlw=;
  b=XP1YJSfA7T1pMFn537cqyycHKN1HutXrcprs1Uv4w1ZrCm1fgg4eAcTB
   D7GSUd13vxMw1vLoR9yNRsWivYeAjqfyxW2JjNLWWZpGV7nOjylBBKl/F
   CBDuL1Egoh/NGGpvLQSgI62cII7DeOTol5TYx/nZ7l1dckaqA4VQtaPbe
   jgNnQuEOeVhlGn+rKNz/0irOikqNA/XJ3+PK3U1yfEg96eKOTeGabzJtN
   SUL4LeP9/Hs0JZIGOvREp7p90cDO8aIoXnb4vmyQhTBSXs8wSGrrKhL80
   c/BmH2Kugjrlz/6QZK42tiALPo0LxTTxuvjtxKqJ6ofxCWrx3J+JYblEz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377851207"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="377851207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 08:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="815756351"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="815756351"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2022 08:00:43 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2ALG0fJh014870;
        Mon, 21 Nov 2022 16:00:42 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/boot: fix relying on link order
Date:   Mon, 21 Nov 2022 17:00:30 +0100
Message-Id: <20221121160030.395096-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y3t5wxKwIAycpDV8@zn.tnic>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com> <20221107125528.543764-1-alexandr.lobakin@intel.com> <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com> <20221121120918.388035-1-alexandr.lobakin@intel.com> <Y3t5wxKwIAycpDV8@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Date: Mon, 21 Nov 2022 14:14:43 +0100

> On Mon, Nov 21, 2022 at 01:09:18PM +0100, Alexander Lobakin wrote:
> > > Things are a bit busy in the review queue at the moment.  As always,
> > > we'd love help reviewing stuff.  So, while you're waiting for us to
> > > review this, could you perhaps look around and find a series that's also
> > > hurting for review tags?
> > 
> > I've got Reviewed-by and Tested-by from Jiri, isn't that enough? Or
> > I need also some other group to get tags from?
> 
> What he actually means is if *you* yourself help out with patch review.
> Like find a set on lkml which you're interested in - I believe there
> will be no shortage of such sets - and poke at it, review it, ask
> devil's advocate questions, etc.
> 
> The distribution of work - gazillion submitters vs a handful of
> maintainers simply cannot scale and instead of submitters pinging
> maintainers all the time when they can look at their set, submitters
> could review other submitters' work in the meantime, while waiting.
> 
> I.e., a win-win-win situation. :-)
> 
> Makes more sense?

I know, I got it from the first read :D I try to review stuff I have
mature knowledge in each day, not that lots of them are from the x86
ML :s

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Thanks,
Olek
