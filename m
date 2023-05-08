Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B206FBB36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjEHW5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjEHW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:57:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71639038
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683586632; x=1715122632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zre1z8U77x4fwOlFFR0LTHD3zMbcORKEZmRb7JnHWOA=;
  b=UPLO697nQb6TyZorKuyLtvcGUmhcTSgQQFZdQ1RbGXLpMqafJT4roeo2
   Ji2ruIWPwDwPCKuBqp9hSlkKpIiuQoj/R1byfAbOLrVaowNFBLKRi3nsx
   cfdr7+CRxfsiX8oWFS/DpUEtLkTlEbDrfnlTPsHqPIh3tKf0moiILXZ4+
   IGvDo5I3xfevk89bTtw3ZwPXAnv5Lf39TxFvIJgiVyQ+AZI2RX/YR95U/
   OoJUm7poNOKoekeNFtiu4opCYxhGTa8iEEyM0wfD0+7VUWZNFBIVXkna5
   A0BAawcPWJA+KPc2faHwZ3qZuQmM4NXOvPP9/qewUAc/4aVGI0W68TSXo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="377866112"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="377866112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 15:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="842871720"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="842871720"
Received: from ahdamali-mobl.amr.corp.intel.com (HELO [10.212.29.166]) ([10.212.29.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 15:57:12 -0700
Message-ID: <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com>
Date:   Mon, 8 May 2023 15:57:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/shstk for 6.4
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
 <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/23 13:09, Linus Torvalds wrote:
> Now, my reaction here is
> 
>  - the whole shadow stack notion of "dirty but not writable is a magic
> marker" is *DISGUSTING*. It's wrong.
> 
>    Whatever Intel designer that came up with that - instead of just
> picking another bit for the *HARDWARE* to check - should be ashamed.
>>    Now we have to pick a software bit instead, and play games for
> this. BAD BAD BAD.
> 
>    I'm assuming this is something where Microsoft went "we already
> don't have that, and we want all the sw bits for sw, so do this". But
> from a design standpoint it's just nasty.

Heh, I won't name names.  But, yeah, it was something like that.

>  - But if we have to play those games, just *play* them. Do it all
> unconditionally, and make the x86-64 rules be that "dirty but not
> writable" is something we should never have.

There's a wrinkle to enforcing that universally.  From the SDM's
"ACCESSED AND DIRTY FLAGS" section:

	If software on one logical processor writes to a page while
	software on another logical processor concurrently clears the
	R/W flag in the paging-structure entry that maps the page,
	execution on some processors may result in the entry’s dirty
	flag being set.

This behavior is gone on shadow stack CPUs, but it does exist on older
ones.  We could theoretically stop being exposed to it by transitioning
all PTE operations that today do:

	1. RW => RO (usually more than one)
	2. TLB flush

to instead take a trip through Present=0 first:

	1. RW => Present=0
	2. TLB flush
	3. Present=0 => RO

Similar to what we do for doing Dirty=1->0.

We could probably tolerate the cost for some of the users like ksm.  But
I can't think of a way to do it without making fork() suffer.  fork() of
course modifies the PTE (RW->RO) and flushes the TLB now.  But there
would need to be a Present=0 PTE in there somewhere before the TLB flush.

That fundamentally means there needs to be a second look at the PTEs and
some fault handling for folks that do read-only accesses to the PTEs
during the Present=0 window.

That said, there are some places like:

	pte_mksaveddirty()
and
	pte_clear_saveddirty()

that are doing _extra_ things on shadow stack systems.  That stuff could
be made the common case without functionally breaking any old systems.

So, the rule would be something like:

	The *kernel* will never itself create Write=0,Dirty=1 PTEs

That won't prevent the hardware from still being able to do it behind
our backs on older CPUs.  But it does avoid a few of the special cases.
