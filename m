Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74006613E85
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJaToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJaToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:44:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2811613F3B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667245458; x=1698781458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tLGW1EUQG/cIHkMNWqHtDTwUiAHVvGRUohgjVasvx7g=;
  b=Zdy6CluFpTlWycKObHCQGrPyOEsZGXZL6HTK10kYNazWgNYIJq1zADCy
   VNYX+MHA2Aptn5McSJLUhoeXtLV4cylf+75YUnHQJ7LosVz6GqLO4z/xj
   2aQpDU1AlKwATqNezDP+KtQg9UscQineYPvAW/HCM0pdJ7+pVZq5b83nN
   xiTx9OIDXLYWYKPLo5XWSG6YzVYyxUkwuELqtDkjq0JgY+nfCqo0S+taO
   dqIWO9b+9VPT7tJ2zJFKkPHGUHG4uF/btbwOGlofgb4Uk7cSm0oEIaPX3
   KWin+NOdwa/efrmidiFoH5Qvbw+/lvHoHK/rH2Rxe2JpR4TZ4yrOxR3jc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="307710088"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="307710088"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 12:44:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="878852265"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="878852265"
Received: from jfbondi-mobl1.amr.corp.intel.com (HELO [10.212.163.129]) ([10.212.163.129])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 12:44:16 -0700
Message-ID: <d3469e0b-32a5-d130-41b1-facdf0d91a92@intel.com>
Date:   Mon, 31 Oct 2022 12:44:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Content-Language: en-US
To:     Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
 <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
 <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
 <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
 <8887d182-a3e3-f62a-8b8f-36db1da75b19@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <8887d182-a3e3-f62a-8b8f-36db1da75b19@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 12:27, Andi Kleen wrote:
>> Moving panic() after earlyprintk working is not good idea as it exposes
>> kernel more: by the time we already have full #VE handler.
> 
> It should be fine to move since there is no user land at this point (the
> attack requires user land)

Maybe I'm misunderstanding the exposure.  A normal MMIO #VE goes
something like this:

	1. %rax points to some MMIO
	2. Kernel executes: mov (%rax),%rbx, trying to read MMIO
	3. #VE handler is triggered
	4. Handler emulates the 'mov' with instruction decoding
	5. Handler asks the VMM what the value of %rax should be
	6. Handler puts VMM value in %rax
	7. Return from #VE

I think the attack scenario subverts a normal MMIO to the following
(changes from the normal flow are marked with *):

	*1. %rax points to some private kernel memory, VMM removes
	    Secure-EPT entry for that memory.
	 2. Kernel executes: mov (%rax),%rbx as part of normal kernel
	    execution, not an MMIO read.
	 3. #VE handler is triggered, assuming a MMIO read
	 4. Handler emulates the 'mov' with instruction decoding
	 5. Handler asks the VMM what the value of %rax should be
	*6. Handler puts (malicious) VMM value in %rax
	 7. Return from #VE
	*8. Now the guest kernel is running with an attacker-controlled
	    %rax

This effectively gives the attacker the ability to override the contents
of a memory read.

Am I misunderstanding the attack scenario?  I don't see guest userspace
needing to be involved at all.


