Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5096268E88B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBHG5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:57:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8D0113C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675839426; x=1707375426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Paue5LGGuXlKFnksbvsnpvdQQOQrLPb711QKRAiuxEY=;
  b=O3PE0ITb6dWtlvpY0R1bxce+evAomBYIfjZg3QfjYC70rqNjXAX1Vfto
   j9Ppb/qhqHavXyc/142Ogrz15ZWawSDoENDYQ3xKy85UEY1OE/MCHf07y
   CP1quOKAx98yZ4MWLK8++fz/T3qddzXfKZFwJmZdVl9aDlD4TvqckPqqF
   yT+rA/nzOvOiKW/zyxC3otnDMwXpBLynCuazecZwtwnAUaVm1Ivr4Iv6T
   6cIBmo/wnN1QVd87Vmf1ECmRuvE9iGK6qy39TEuMolGxLeGCvC6UlEn5S
   em6+Hy1zQj2rFUAQhTekdwV4NFnLzhqhdyZSBthiEKtyWtJsivIeoYck+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="310078199"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="310078199"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 22:56:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="660548264"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="660548264"
Received: from tbacklun-mobl.amr.corp.intel.com (HELO [10.209.14.225]) ([10.209.14.225])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 22:56:49 -0800
Message-ID: <b1300308-8f29-fa73-5542-25d06925ca84@intel.com>
Date:   Tue, 7 Feb 2023 22:56:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230204210807.3930-1-namit@vmware.com>
 <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
 <C4863EDA-106B-4AF9-8D39-D603EEE4BEDC@vmware.com>
 <dc964552-dca7-dd83-52a2-283be7f51555@intel.com>
 <20230207095424.42f4c0147f693a8cef25757c@kernel.org>
 <20230208002132.63b70cb9d6e5badad45fb828@kernel.org>
 <9fb39b3a-2edb-7fd3-2b7c-3a347478083f@intel.com>
 <B790D31A-A0BE-4707-BA01-398B5668C3D8@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <B790D31A-A0BE-4707-BA01-398B5668C3D8@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 22:34, Nadav Amit wrote:
> As you said, I guess the change you and Masami proposed can be done on top of
> this patch, which is (and was) only intended to fix the bug, and should
> therefore go into 6.2.

Nadav,
	
To fix this issue, you proposed:

	p->ainsn.rel32 = *(s8 *)&insn->immediate.value;

But, this is, um, rather obfuscated and potentially less correct
compared to:

	p->ainsn.rel32 = insn->immediate.value;

I'd appreciate it if you could update your patch to do this simpler
thing and resend, unless there is a strong reason to do what you
originally proposed.


