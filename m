Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F05F7ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJGUdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJGUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:33:35 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D60127BDE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:33:33 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 297KXGvC3894036
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 7 Oct 2022 13:33:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 297KXGvC3894036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1665174797;
        bh=sCUozOJREW+6jCM07ChwUe55Gdqcou4pd//vL3vvLXA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pXkaCWu3qf0yG1HDzpOgUlx+RN2xR4xRVA9F4u7li+bwFQ9rEYW3n+ty/vdZbboPv
         JDd9r2OAh0cKoSxelREPND1CF3ybN72dj2jlhBdSeerlTo367RgtGfCLlHJNZvs+bA
         fySzxscTqqgrxFa8PiUqCsCUUHz++U2hpK1pOCIwaDMRtm2bvbS/V0Z/GsRMv6j1+U
         EZRqBEV1a2urf7brjoMMnpN1RyGQMINhrxf37IwYig7VY6/0VvdUOQ5oSJ52xQdFUE
         CerBS6CapzvRowV/YiQn2e4kIzaAsU0kR0PvcjeDE/5eEV5KIcn/BRbtJKXxiEcm2O
         o73gBECYsWuKg==
Message-ID: <b2943f49-41ba-59c9-2592-d1a91a151138@zytor.com>
Date:   Fri, 7 Oct 2022 13:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
 <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
 <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com>
 <Y0CKz/wjvYYYgH3P@hirez.programming.kicks-ass.net>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Y0CKz/wjvYYYgH3P@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 13:23, Peter Zijlstra wrote:
>>
>> Perhaps the two of you need to compare confugurations?
> 
> Whatever for? I know the robots report this warning because there was
> one from the KVM cross-merge when the .fixup removal went in. It got
> reported and fixed and that was the last of it.
> 

To help track down what appears to be a problem?

> Anyway; try:
> 
>    $ git grep "\.fixup" arch/x86/
> 
> there isn't a single usage.
> 
> Andrew Cooper suggested upgrading the orphan section warning to a hard
> link error, orphan sections are bad regardless.
> 

Agreed 1000%. This is a no-brainer. From IRC:


<andyhhp> -LDFLAGS_vmlinux += --orphan-handling=warn
<andyhhp> +LDFLAGS_vmlinux += --orphan-handling=error

	-hpa
