Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9906870EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBAWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBAWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:21:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174B59E5E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675290081; x=1706826081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KVrvI3gV3AdQGPQq3OUamwy2sMEpd9+SJzXmnPWDBe0=;
  b=VWQbxSr7pEKvboTEwCWrXrTccLogFLScheYEsI6RIDqTdwi9ZNyUeMbp
   EM8SwAPg+QL1W98A0jYTh4Mnbue5sqGFulIqIQ79y+WfAAY+YjXtUpSxS
   4+KljUmBcY7mwdFNgKncDi3kNs/4JiLA9x58PEwv17QdMf2sZ0PXzLGvd
   ip6/PyPEtkYcMEtdPegzGg13uAhmUpCVZ0vL7/uWxyanZH0j6CgbGXcqU
   Z18mxCPpxCrfd6vSwLDBuvgIDAHcAqk17CYDlCNTjkRc9Vb6zRO/TAUMn
   1FxhAW3K6g2KOcBvrRQiUiufXcatEIcHpfvYmJxYMO67je4R2q0lZu9G2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="390680326"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="390680326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 14:21:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993851238"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="993851238"
Received: from sgkhacha-mobl1.amr.corp.intel.com (HELO [10.212.227.86]) ([10.212.227.86])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 14:21:19 -0800
Message-ID: <bfd85699-4b7a-c606-266a-cea7ff336950@intel.com>
Date:   Wed, 1 Feb 2023 14:21:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Patch v3 Part2 4/9] x86/microcode: Do not call apply_microcode()
 on sibling threads
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-5-ashok.raj@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230130213955.6046-5-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 13:39, Ashok Raj wrote:
> Microcode updates are applied at the core, so an update to one HT sibling
> is effective on all HT siblings of the same core.
> 
> During late-load, after the primary has updated the microcode, it also
> reflects that in the per-cpu structure (cpuinfo_x86) holding the current
> revision.
> 
> Current code calls apply_microcode() to update the SW per-cpu revision.

I'm having a hard time following this.  I can't even suggest a better
message because I can't grok this one.

> But in the odd case when primary returned with an error, and as a result
> the secondary didn't get the revision updated, will attempt to perform
> a patch load and the primary has already been released to the system.
> This could be problematic, because the whole rendezvous dance is to
> prevent updates when one of the siblings could be executing arbitrary code.

OK, let me see if I understand:

Today, ->apply_microcode() is called for both CPU threads.  Typically,
T0 comes in and will actually successfully update the microcode.  T1
will come in later, notice that T0 updated the microcode already and
return without even trying to do the update WRMSR.  One thing T1 _does_
do before returning is to update the per-cpu data.

That works great, unless T0 experiences an error.  In that case, T0 will
jump out of __reload_late() after failing to do the update.  T1 will
come bumbling along after it and will enter ->apply_microcode(),
blissfully unaware of T0's failure.  T1 will assume that it is supposed
to do T0's job, noting "rev < mc->hdr.rev".  T1 will write the MSR while
T0 is off doing god knows what.

T1 should not even be attempting to do ->apply_microcode() because T0 is
not quiescent.

> Replace apply_microcode() with a call to collect_cpu_info() and let that
> call also update the per-cpu structure instead of returning the previously
> cached values.

	To fix this, remove the path where T1 calls ->apply_microcode().
	However, this alone would leave the per-cpu metadata for T1 out
	of date.  Call collect_cpu_info() to ensure it is updated.

Right?

FWIW, this seems a bit hacky and inconsistent to me.  It would be nice
if the common T0/T1 work (updating the per-cpu metadata) was done with
common code.

Could we zap the uci->cpu_sig.rev work entirely from ->apply_microcode()
and do it in __reload_late() instead?
