Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97F067677A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjAUQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:47:00 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D1113F1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674319619; x=1705855619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fo08ZcIrtTPKlL29c86Ws9ZwUgBRmQsU5QgIWyncqZQ=;
  b=MuOROfp1cJ29C5lVhJgq53WtYn3Rziy8J7176A3mqa0TucIIYgfLLubD
   9pFonUK9kPQrKG6frMaUyr0j+WrpSSMEHIGj3Lo05FTIwMySHx9w+NExt
   RkdFDbqpTlOy6YOsTq62rEqRe9AjOrr5dHTQXApFziGoSWG0kaL0JOZ83
   Vp91IM2saj2HYib03YPG3dYJk+i88BoW68j+2kO3aJfKxXs4oQtTlewCP
   Cmkf0MQoLT8cLHLm7aLEuz3pGIT3nlFoGgA9N+PG748SJDS5seUVB8PVI
   Yag818QHedC33KX61oM/sk6uwE5+QT4sNudNBD9nwohnhDXpYkGxKP4wz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="313693275"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="313693275"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 08:46:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="693187852"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="693187852"
Received: from aureliaw-mobl.amr.corp.intel.com (HELO [10.255.230.48]) ([10.255.230.48])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 08:46:59 -0800
Message-ID: <5703e698-a92a-2026-e5d4-3c6340578918@intel.com>
Date:   Sat, 21 Jan 2023 08:46:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>, "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 20:59, H. Peter Anvin wrote:
>> If not intentional, it might be something that can still be fixed.
>> If it is intentional and is going to be with us for a while we have
>> a few options.  If userspace is _really_ depending on this
>> behavior, we could just clobber r11 ourselves in the FRED entry
>> path.  If not, we can remove the assertion in the selftest.
> We can't clobber it in the FRED entry path, since it is common for
> all events, but we could do it in the syscall dispatch.
> 
> However, it doesn't seem to make sense to do so to me. The current
> behavior is much more of an artifact than desired behavior.
I guess the SDM statements really are for the kernel's benefit and not
for userspace.  Userspace _should_ be treating SYSCALL like a CALL and
r11 like any old register that can be clobbered.  Right now, the kernel
just happens to clobber it with RFLAGS.

I do the the odds of anyone relying on this behavior are pretty small.
Let's just zap the check from the selftest, document what we did in the
FRED docs and changelog and move on.

If someone screams later, we can fix in some SYSCALL-specific piece of
the FRED code.
