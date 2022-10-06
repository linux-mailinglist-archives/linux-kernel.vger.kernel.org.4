Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE35F6A47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiJFPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJFPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:08:10 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8290B40F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ct+ugeiGe5ZUJT05mSd4JWZvy7uxzMWXbOYbAxuOk9o=; b=np18cOJRqTPhA6MsKxQmImGmPz
        s6sI/bAv15k0BdCYeiadrSIczAZda+omLFa/85B/W7ItPJvHSFemZQ8S7k0MaTG26UdtTV4PVBNsy
        5YCRfg03eocMHbNel+j1Ki5JqHuRhfpMTUCaqsW/0pKPSlM3ievu5LXdSUa8B21ITfmyCa1a1kzxO
        ksWkzzpSqPWn1ZMtcdKvSa0W6Yb2HAv+9HuPkvEPUqa+HnnT1/iBGK2Lt7MIcqpRYBsK9pc6A6STi
        2c02DmQCfQQYQkzLUYIOafPHpSK/QrCwS8+o8wh6sAh9PvetYE9vZYfB2lXKZqsQUBnsmjpOsUGO8
        plzwgKVg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogSTJ-00BcBW-04; Thu, 06 Oct 2022 17:07:37 +0200
Message-ID: <7403891b-c84c-d0e5-e6e6-caf1bd4fcf51@igalia.com>
Date:   Thu, 6 Oct 2022 12:07:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>, "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20221006090418.GA14960@amd>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221006090418.GA14960@amd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 06:04, Pavel Machek wrote:
> [...]
>> Why not just use the workaround suggested in that bug report:
>>
>>    "so manual switching from default setting to split_lock_detect=off helps as workaround here"
>>
>> If you add this extra mode, I'm going to argue that the kernel default
>> should be "seq" rather than "warn". So these game players will need
>> to add a split_lock_detect=off (or warn) option.
> 
> Kernel should not cause userland regressions, and this is one. That
> should make it pretty clear what the solution is.
> 
> And no, I don't like CONFIG option, either.

Thanks for your opinion Pavel! Good thing is that seems everybody at
least understands the problem exists and is affecting userspace.

Now, about the action we should take: what if we go with a revert in
this "misery factor" based on Dave's reasoning? I have a patch ready and
tested, let me know otherwise or I'll submit it as a V2 by the end of
this week.

Cheers,


Guilherme
