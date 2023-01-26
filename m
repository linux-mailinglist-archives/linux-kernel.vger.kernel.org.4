Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3171167D525
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjAZTMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjAZTMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:12:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAAF558C;
        Thu, 26 Jan 2023 11:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674760359; x=1706296359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Trd6VrHdwLqP3BKT7sgNfrHrXj7Zj8mqjVHKY0jO6r4=;
  b=IrNEGle95rQdcDETi1c+1OPA4Cc0fH1cAGrASetx3BLZRQjP0WAjWUHD
   /5llyqrlxj+FvztZgsTEdAw86L1GSv6B9+rmquoXocbYmnpCOHmjSZxKi
   R6CKC3PC4DjhmiV6M/4XQDXZhtywfV4s5MmORm+mDxwTlhj5GEuIax4AG
   jAdEwaRq/7hv3TphBhuGHIhUuTIYZPmdHkwFf5yj+no4xqdzqL3az8E8z
   0Nk9SZqwwwcXroxvpJnP/x/0SUUAkbzz2MqdIlB8NWMWQhCh3q+1ZNVuA
   hkyeRs+DgbZlgMk2+1n/B/pZaEzDY5vLwem7Sz05jP8kBO+ol7vkWfkgw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389268106"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="389268106"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 11:12:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="662976851"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="662976851"
Received: from ernestom-mobl.amr.corp.intel.com (HELO [10.212.255.13]) ([10.212.255.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 11:12:36 -0800
Message-ID: <e37a17c4-8611-6d1d-85ad-fcd04ff285e1@intel.com>
Date:   Thu, 26 Jan 2023 11:12:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Content-Language: en-US
To:     Jann Horn <jannh@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20230125012801.362496-1-ebiggers@kernel.org>
 <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
 <394c92e2-a9aa-37e1-7a34-d7569ac844fd@intel.com>
 <CAG48ez0ZK3pMqkto4DTZPNyddYcv8jPHQDNhYoFEPvSRLf80fQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAG48ez0ZK3pMqkto4DTZPNyddYcv8jPHQDNhYoFEPvSRLf80fQ@mail.gmail.com>
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

On 1/26/23 09:52, Jann Horn wrote:
>> Maybe I'm totally missing something, but I thought the scope here was
>> the "non-data operand independent timing behavior for the listed
>> instructions" referenced here:
>>
>>> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html
>> where the "listed instructions" is this list:
>>
>>> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/data-operand-independent-timing-instructions.html
>> For example, that includes XOR with the 0x31 and 0x81 opcodes which
>> there are plenty of in the kernel.
> That list says at the top: "The table below lists instructions that
> have data-independent timing."

So, first of all, apologies for the documentation.  It needs some work,
and I see where the confusion is coming from.

But, I did just confirm with the folks that wrote it. The "listed
instructions" *ARE* within the scope of being affected by the DOITM=0/1
setting.

Instead of saying:

	The table below lists instructions that have data-independent
	timing.

I think it should probably say something like:

	The table below lists instructions that have data-independent
	timing when DOITM is enabled.

	(Modulo the MXCSR interactions for now)

Somebody from Intel please thwack me over the head if I'm managing to
get this wrong (wouldn't be the first time).
