Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C674A4F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGFUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFUal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:30:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D181FC3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688675434; x=1720211434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9NNDxT5o56mI1rdVTs07QKziZnDMMQN7nrmhhlyZN8I=;
  b=I5jqpYefddOROebhzcipp5qV1vMQef3upLbql+/5EwZh1GUJrsEvZ3DD
   EiwbJiD+UrDFeuO/TZUhKLKOdRL2bA6lrBoLTegt+XZIiMKwRU3Vyvscv
   MlmTlJVOn1ADrEek/u355ugNJVjoKYIuTYOOC6BTmcOgA4i5T+44+wonx
   hEMLlxgrhUYoB/h/jLrsJ4AOyr3dVZLo4daFBRei75JrxH2hs/XdsXYy2
   h2hlxCKyYKu9Cz10sQbEiDIVA/236p2Oe1dBPhprSbYfA+FwyvES2XwAd
   pKgqAXOzzeACOU+IY3Q4nzzLBxQnxTrF8X0X+ll2CqO8cI4NfSiao7Eyi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="367209263"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="367209263"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789693348"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="789693348"
Received: from adityan1-mobl1.amr.corp.intel.com (HELO [10.212.197.9]) ([10.212.197.9])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:30:32 -0700
Message-ID: <8ec7f329-a0a3-7631-ba05-225944b19771@intel.com>
Date:   Thu, 6 Jul 2023 13:30:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86: Remove the arch_calc_vm_prot_bits() macro from the
 uapi
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Thomas Huth <thuth@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230706190217.371721-1-thuth@redhat.com>
 <2d9bb146-e1ec-4fc2-a4bc-e1c67cfda723@app.fastmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <2d9bb146-e1ec-4fc2-a4bc-e1c67cfda723@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 13:22, Arnd Bergmann wrote:
> On Thu, Jul 6, 2023, at 21:02, Thomas Huth wrote:
>> The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
>> not part of the uapi, so the macro is completely useless for userspace.
>> It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>> config switch which we shouldn't expose to userspace. Thus let's move
>> this macro into a new internal header instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Fixes: 8f62c883222c9 ("x86/mm/pkeys: Add arch-specific VMA protection bits")
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> It looks like this was introduced right after the uapi split,
> and probably is the result of an incorrect rebase.

Yeah, I bet I just glossed over the "uapi" in the path.

Is this causing any real problems?  Or is it OK to just send it along
during the next merge window with other random cleanups?
