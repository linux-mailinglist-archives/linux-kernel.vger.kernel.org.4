Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E96678C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjAXADs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAXADq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:03:46 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404313B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:03:46 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30O01HqA2535250
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Jan 2023 16:01:17 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30O01HqA2535250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674518478;
        bh=NHJHgnSG8jyhXZXGAu0TlGZDvS8MY8esiGefW16SkM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MY0NC4GUOtR2nKLOJvOeRE80LAgvbifOF1tMyH2O6+QrCoE2KoJMUMlC//PkoNZ+q
         lOalhIbTo8UiF8TLS//yeqto71sxNhG4IKYP7Zk9bhjAQYdKP6552O7qC7jnzryDbP
         qX+vHGNlZlG0onXxye2P6/z9HgP7G3q4xSzVMB8E5Yw7VbtX4Yagh1TpsT29waYPkg
         LmG9oD/XGJX+wlqFIFdqBP7Eenpy/TrR35bnIfU2g+LuvgLT5t2bAGKbAE20gPStZX
         1gcBnP/kYuFC1VVpxZbkxYj52uMVowlZDO9pRaijz0eSXGNZ6TMoU8DSsNZ0golcet
         00/GlQiD0lErA==
Message-ID: <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
Date:   Mon, 23 Jan 2023 16:01:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 15:53, Andrew Cooper wrote:
>>
>> A simple workaround is: just compile it with "-mno-red-zone" flag.
> 
> You can't compile userspace like that, unless you recompile and
> statically link everything including libc.
> 
> The proper way to fix this is to add a "+r" constraint on the stack
> pointer, at which point the compiler will arrange for nothing in the
> redzone to be live around the asm block.
> 

So you are of course right that that is The Right Way[TM] to fix this.

However, to be picky: since the redzone is not in use across function 
calls, it is perfectly legitimate to inhibit the redzone for one 
function only.

	-hpa
