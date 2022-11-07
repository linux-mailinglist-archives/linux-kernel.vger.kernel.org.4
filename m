Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E325761F462
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiKGNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKGNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:31:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFA1B9FA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667827865; x=1699363865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v1gI9Pe6bvHrL0dWTyJyctWSrUg2IYLGOLoOANLiJ3Y=;
  b=FUE/MnYuJUdy5AfXF9/nr+Q9403SmU1wcQrDXeze85TLtywAhcV8zxje
   ko5A3ucGKlZrnUPSK6PnAmj2sMeZXCvmbl8jzX4ZVCRxh63OCCZy22irs
   pqMCG8FMNo+WtE1jZ/sPkgrQsysC3KBaaPZNEq82MWTOGSgpbHmNKsVwg
   MRHpfQFjcMoTgZ8t98t0UY/htBKoZfoHUVwyLwLfDKmg0UypNx+wiFXdg
   zNHgpVNlKWH8ZKBk7R/LbC+DdYkkLM1RodJIVgvYBNOwNGK9nMzlmNUi2
   AuPCnBCbYacYmQwIIO/P1sN5IDkrcvVM0NUPt3dfvdPbS6cvlqGgbnWE4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="297900053"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="297900053"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 05:31:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="586968694"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="586968694"
Received: from dkthrons-mobl2.amr.corp.intel.com (HELO [10.209.29.113]) ([10.209.29.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 05:31:04 -0800
Message-ID: <3cdb5bf8-7f26-0416-46d2-a5640dd27f22@intel.com>
Date:   Mon, 7 Nov 2022 05:31:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
Content-Language: en-US
To:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com
Cc:     ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        x86@kernel.org
References: <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
 <b5d04a6c-79b4-bbdc-b613-6958d9f75d53@linux.alibaba.com>
 <4bfcd256-b926-9b1c-601c-efcff0d16605@intel.com>
 <c2b60735-84a8-649e-536c-877c790eb101@linux.alibaba.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c2b60735-84a8-649e-536c-877c790eb101@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 21:10, Guorui Yu wrote:
>> Without ATTR_SEPT_VE_DISABLE, a #VE can occur on basically any
>> instruction.  We call those kinds of exceptions "paranoid entry" points.
>>   They need special handling like the NMI or #MC handlers.
>>
>> I'd be happy to look at a patch that does the MMIO path check *and*
>> turns the #VE handler into a robust entry point.
>>
>> Bonus points if you can do ~5 lines of C like the approach in this
>> thread.
> 
> Yes, there is a fix to satify your requirement and get the bouns points 😄
> 
> Please refer to
> https://github.com/intel/tdx/commit/f045b0d52a5f7d8bf66cd4410307d05a90523f10
> 
> case EXIT_REASON_EPT_VIOLATION:
> + if (!(ve->gpa & tdx_shared_mask())) {
> + panic("#VE due to access to unaccepted memory. "
> + "GPA: %#llx\n", ve->gpa);
> + }
> +
> /* original from Kirill and Kuppuswamy */
> 
> It's already there, but it just didn't get into the main branch.

Could you explain how that prevents the #VE from occurring in the
"syscall gap" or in a place where the kernel is running with the user
GSBASE value?

It doesn't as far as I can tell.  You need the SEPT_VE_DISABLE check for
that.
