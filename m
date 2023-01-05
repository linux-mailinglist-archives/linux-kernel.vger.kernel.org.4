Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C964B65F11E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAEQ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjAEQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:27:40 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8168524C;
        Thu,  5 Jan 2023 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1672936056;
        bh=2a02sfWya305xpJqy3l4emrqEUTjLaoJnNzo6PDwdFY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XXnczx6XasS3m9YJ+17km0hpRa4ycidnkkmHh/F8nuFmwNqxs1hgD5qNtlrTv9AVz
         Od0ct5ir/fNj9I6Ku1bLL7fcP7LkxyKpyoSAEYtMKGIC60vifuaJs9z4btVvv/S5eH
         +swuSVp8AFh+6JFiO0GeanJ3z8dRHwZi9TkQd5WWrbz6htsmVAfgrHcLXwZHBNt8JA
         qdmHAOfq3XGJLQ70t1dLXB39lrK0P/8pz5aD+4oQUkVWIiRTe5nadm+fyJUcUQ8jDy
         JRMcen3JvdzBcARtAGXhN4tRHDXemK4ZQW/JIsr2k2zBHMjvtRdMvPwdv25RUAv4CY
         CWHZM63B9Tq2A==
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NnsMD2jblzffb;
        Thu,  5 Jan 2023 11:27:36 -0500 (EST)
Message-ID: <f8c0afe3-14e1-f38d-c9cf-0ec9b18b6e9b@efficios.com>
Date:   Thu, 5 Jan 2023 11:28:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 05/30] selftests/rseq: Use ELF auxiliary vector for
 extensible rseq
Content-Language: en-US
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
 <20221122203932.231377-6-mathieu.desnoyers@efficios.com>
 <87a62yun6l.fsf@mid.deneb.enyo.de>
 <cce499bf-6083-558d-5431-9ceab05a98d6@efficios.com>
 <87tu15rm21.fsf@mid.deneb.enyo.de>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87tu15rm21.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-05 11:19, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> 2- Now about applications (and libc) use of rseq fields:
>>
>> Using both __rseq_size (from libc) and the result of
>> getauxval(AT_RSEQ_FEATURE_SIZE), a rseq user can figure which rseq
>> fields can indeed be used. The important part is how
>> get_rseq_feature_size() is called in the rseq selftests:
>>
>>
>>                   rseq_feature_size = get_rseq_feature_size();
>>                   if (rseq_feature_size > rseq_size)
>>                           rseq_feature_size = rseq_size;
>>
>> which basically sets rseq_feature_size to the feature size exposed
>> by the kernel, except if libc's __rseq_size is smaller than the
>> feature size exposed by the kernel, in which case it will truncate
>> the rseq_feature_size to __rseq_size.
> 
> Ahh, this happens to work because we pass 32 today from glibc, and
> there is nothing left to do in glibc to enable these new fields.
> 
> If true, that really argues in favor of this approach.

Yes, you are correct..

> 
>>> Maybe we should just skip the existing padding and use it only for
>>> some vaguely kernel-internal purpose (say through a vDSO helper), so
>>> that it is less of an issue how to communicate the presence of these
>>> fields to userspace.
>>
>> The fact that libc's __rseq_size is included the original struct
>> rseq padding is unfortunate, but I really see this as a purely
>> userspace ABI concern, which should not dictate the layout of the
>> kernel ABI exposed to user-space, especially given that all the
>> information required to allow rseq users to know which fields can be
>> used is readily available by combining the value loaded from
>> __rseq_size and the result of getauxval(AT_RSEQ_FEATURE_SIZE).
> 
> But we must pass size 32 to the kernel today, otherwise rseq
> registration fails.  It's a kernel-mandated value, not something
> that's purely a userspace concern.

What I mean when stating the "userspace concern" is the semantic of the libc's
__rseq_size symbol: whether it means allocated space (including padding)
or actively populated feature fields.

In terms of rseq registration rseq_len argument, here is the updated check
in the system call:

         /*
          * If there was no rseq previously registered, ensure the provided rseq
          * is properly aligned, as communcated to user-space through the ELF
          * auxiliary vector AT_RSEQ_ALIGN. If rseq_len is the original rseq
          * size, the required alignment is the original struct rseq alignment.
          *
          * In order to be valid, rseq_len is either the original rseq size, or
          * large enough to contain all supported fields, as communicated to
          * user-space through the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE.
          */
         if (rseq_len < ORIG_RSEQ_SIZE ||
             (rseq_len == ORIG_RSEQ_SIZE && !IS_ALIGNED((unsigned long)rseq, ORIG_RSEQ_SIZE)) ||
             (rseq_len != ORIG_RSEQ_SIZE && (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
                                             rseq_len < offsetof(struct rseq, end))))
                 return -EINVAL;

Which keeps accepting rseq_len=32 (original ABI), else requires that enough space
is available to hold all supported feature fields (but never less than 32 bytes).

Do my explanations take care of your concerns, or are there still aspects that
you are uneasy with ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

