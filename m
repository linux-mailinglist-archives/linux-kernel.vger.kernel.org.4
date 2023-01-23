Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C881678C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjAXAA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAXAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:00:55 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E699823C4C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:00:51 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30NNwHJr2534652
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Jan 2023 15:58:17 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30NNwHJr2534652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674518299;
        bh=4+cZhiADgXXgHhtrVCWwABKWPIPIew2C/Vpr95W/WKY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bWYn21AnZOvC2vT9ycYq/gTXDJKK0EdzFYa64i4+BZO88Rd5wF/WijqnDXRRwHAIw
         +AySKCzbnjMfYAD7bQLrS/8E5e2AL6SgXDtrVgWibJ+EoNUu8S21ESQ9bc0nZNR99i
         /n+Z1UyIVWc5L4NT2gOdW6akDgjCAQRMvBIEdJfJV93+h3D8kdydpBrFS4/W/zQhcP
         +qYsnBnl/t++pMoKrS32nuLuax6fYNmnIXRh6Wg99blkJZ7iSb2MaN5e4sNircSZ6f
         QrzBdX4hFJygZ6HtQ7Cc6xNTaoQCe73EMZi0bnspS/xXg8YC/Zo0RZJBU6Xverkd5P
         xdsmN70izZIBw==
Message-ID: <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
Date:   Mon, 23 Jan 2023 15:58:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
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

On 1/23/23 15:43, Ammar Faizi wrote:
> 
> Align them to spot differences:
> 
>      0x200893 = 0b1000000000100010010011
>      0x200a93 = 0b1000000000101010010011
>                               ^
> 
> Or just xor them to find the differences:
> 
>      (gdb) p/x 0x200893 ^ 0x200a93
>      $3 = 0x200
> 
> ** Checks my Intel SDM cheat sheets. **
> 
> Then, I was like "Oh, that's (1 << 9) a.k.a. IF. Of course we can't
> change rflags[IF] from userspace!!!".
> 
> In short, we can't use 0x200893 as the rflags_sentinel value because it
> clears the interrupt flag.
> 

Right, my mistake.

	-hpa
