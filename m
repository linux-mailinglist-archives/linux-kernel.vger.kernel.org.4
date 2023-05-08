Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E26FBA54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjEHV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjEHV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:56:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6A558F;
        Mon,  8 May 2023 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683582989; x=1715118989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AE6SUd2363E4VTjRmU37zPu5kev7mNtUwbtFRFXQ0vI=;
  b=fK46CDCE7Ya+R24WDTnVLA2Gndw8IR6QvmW0zI0O21dp6dsFVBuXzLGk
   Q3f1d6Kv1eK8REqoSmITAEyLDDuwwJBUDD/bONwNlXkYAKysPtE/5X3nf
   nR2gKHC+R4c/dKfqxFN7SQxZNV+BXJYV4fE0rpitOH1YbwYkw7N9LpyrL
   TgxjGM8s+ohyPTHiPbCRxW55V6F/x3xo8B16oZBpav+m478GlUTBZPhka
   bmYfd1qYhwl4r0cHCTFnmNU180bN7iJIOGPlcrDxpF1tOKBhZxz5dHmkp
   u0HIIl7S4RZMFAx51D2j4OKObip3s4TSaoc/63CzZu30zcS6rShOYpzGM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="377859367"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="377859367"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788274135"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788274135"
Received: from ahdamali-mobl.amr.corp.intel.com (HELO [10.212.29.166]) ([10.212.29.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:56:28 -0700
Message-ID: <8748511c-cf9a-f3ce-e560-d0646dc3d108@intel.com>
Date:   Mon, 8 May 2023 14:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-8-chang.seok.bae@intel.com> <ZFWLoOZZTnBrid+7@gmail.com>
 <1b2eb485-2320-b33b-a0ac-53f7cb170adc@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1b2eb485-2320-b33b-a0ac-53f7cb170adc@intel.com>
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

On 5/8/23 11:18, Chang S. Bae wrote:
> On 5/5/2023 4:05 PM, Eric Biggers wrote:
>> On Mon, Apr 10, 2023 at 03:59:31PM -0700, Chang S. Bae wrote:
>>>   +#ifdef CONFIG_X86_KEYLOCKER
>>> +void setup_keylocker(struct cpuinfo_x86 *c);
>>> +void destroy_keylocker_data(void);
>>> +#else
>>> +#define setup_keylocker(c) do { } while (0)
>>> +#define destroy_keylocker_data() do { } while (0)
>>> +#endif
>>
>> Shouldn't the !CONFIG_X86_KEYLOCKER stubs be static inline functions
>> instead of
>> macros, so that type checking works?
> 
> I think either way works here. This macro is just for nothing.

Chang, I do prefer the 'static inline' as a general rule.  Think of this:

static inline void setup_keylocker(struct cpuinfo_x86 *c) {}

versus:

#define setup_keylocker(c) do { } while (0)

Imagine some dope does:

	char c;
	...
	setup_keylocker(c);

With the macro, they'll get no type warning.  The inline actually makes
it easier to find bugs because folks will get _some_ type checking no
matter how they compile the code.
