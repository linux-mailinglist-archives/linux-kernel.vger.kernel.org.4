Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166D068DD18
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjBGPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjBGPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:34:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4D430EB3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675784057; x=1707320057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=42w1wIYF683VoCz886YPm1YRwgV+fo0rImnP0BLPJIs=;
  b=SxWsh9F90V+qiIH2o1mKn/Z/483ZIUwdSgO55kWY/2Nl5AP4XZmzua5l
   kCAtg/XOxizJENmFQiKHDjh2il5tucOUP3i/EvEX6VaUY4rJZbdcbiDel
   aOrDUp0WdNZsOMG5evRsdMitp9bE8r1ETmkRESHERX+SYAnWuyhduc8oM
   36kc92QhTtpSh/HWmZ4oqi6wQveSm7mEkq5zhoS/z+o1TJ1HX9e0atKpO
   m5GWx5zEsARvLtiG8tJVoMAMalMQsnTxPKRke80FjYdlPU/2M5MC0CEiF
   6ucfAD5cEwhj1ufYBnLu9FfyR0lfHdD28hybo7133ribQ5dRinRmsIm7a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327225045"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="327225045"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 07:33:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912370499"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="912370499"
Received: from rwalujo-mobl.amr.corp.intel.com (HELO [10.212.133.200]) ([10.212.133.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 07:33:57 -0800
Message-ID: <9fb39b3a-2edb-7fd3-2b7c-3a347478083f@intel.com>
Date:   Tue, 7 Feb 2023 07:33:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230208002132.63b70cb9d6e5badad45fb828@kernel.org>
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

On 2/7/23 07:21, Masami Hiramatsu (Google) wrote:
>> Nadav, can you update your patch to assign immediate.value directly?
> BTW, there are many similar casts around there. I'll fix those too.
> If we need to be more conservative, 

Let's focus on fixing the known bug first, please.  Cleanups can come later.
