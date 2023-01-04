Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3136F65DD1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbjADTu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjADTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:50:54 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC94BE3C;
        Wed,  4 Jan 2023 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1672861852;
        bh=48nRR4yDM2of4G0U/5nAQS3/E1gw47c30wKkGr9FPZc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CvaFhL5g+bj1DcTsofyvlHksYq8rhrI0SSKOd3YKHXAk/Q8mWx8U6ckt/yLwN+wJ3
         afGTPirFeyZJjCmYO+kFudV9HEBxL5pHEpCxnFVIB/miChm7d4/e5zF0VylmSH1Olp
         Al2eRYYbN76doHoiOwU2zC6V1TS514G8eqEooXBgyz+knxYbI5flz3AfZLyXuEhhWV
         0Wv6TCWRfiPE1d+n7KfKaEeGtWeoq4xC/tVFB2jC4Qef6ddYmpHbhKdHDSty7hRxjN
         IUDWCP2IauyZD66tVlGb0DfJqwgSZ1G7hGXp7qLYmlorpAU1pxwFnKMTzgg5RgELp7
         7XoVBd44D/iBw==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NnKwC6psmzfw4;
        Wed,  4 Jan 2023 14:50:51 -0500 (EST)
Message-ID: <cce499bf-6083-558d-5431-9ceab05a98d6@efficios.com>
Date:   Wed, 4 Jan 2023 14:51:22 -0500
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87a62yun6l.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-04 14:14, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> +static
>> +unsigned int get_rseq_feature_size(void)
>> +{
>> +	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
>> +
>> +	auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
>> +	assert(!auxv_rseq_align || auxv_rseq_align <= RSEQ_THREAD_AREA_ALLOC_SIZE);
>> +
>> +	auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
>> +	assert(!auxv_rseq_feature_size || auxv_rseq_feature_size <= RSEQ_THREAD_AREA_ALLOC_SIZE);
>> +	if (auxv_rseq_feature_size)
>> +		return auxv_rseq_feature_size;
>> +	else
>> +		return ORIG_RSEQ_FEATURE_SIZE;
>> +}
> 
> Do you intend to use the auxiliary vector as the userspace handshake
> for glibc-managed rseq, too?

Yes.

I don't think it works if the kernel
> overtakes glibc.  Or is there some other approach shown in the series
> that I missed?

The handshake I am proposing is as follows:

1- libc init:

issues getauxval(AT_RSEQ_FEATURE_SIZE) to learn the rseq feature size supported
by the Linux kernel. It can be either:

a) getauxval(AT_RSEQ_FEATURE_SIZE) == 0, errno=ENOENT: pre-6.3 kernel or CONFIG_RSEQ=n.

Need to issue the rseq system call to figure out if rseq is implemented/available or not.
If rseq is indeed implemented, use a __rseq_size=32.

b) getauxval(AT_RSEQ_FEATURE_SIZE) > 0:

The kernel exposes its supported rseq feature size. libc either needs to register rseq with a rseq_len
of 32-byte (original size), or with a rseq_len larger than 32 bytes with enough space to hold all
features.

2- Now about applications (and libc) use of rseq fields:

Using both __rseq_size (from libc) and the result of getauxval(AT_RSEQ_FEATURE_SIZE),
a rseq user can figure which rseq fields can indeed be used. The important part is
how get_rseq_feature_size() is called in the rseq selftests:


                 rseq_feature_size = get_rseq_feature_size();
                 if (rseq_feature_size > rseq_size)
                         rseq_feature_size = rseq_size;

which basically sets rseq_feature_size to the feature size exposed by the kernel, except
if libc's __rseq_size is smaller than the feature size exposed by the kernel, in which case
it will truncate the rseq_feature_size to __rseq_size.

This allows rseq users to know which feature set is supported by the kernel and for which
libc has allocated enough space.

The only thing here is that rseq users cannot rely on libc's __rseq_size symbol to get the
feature size. But considering that this is a contract between the kernel and the rseq user
(libc is mostly just there to allocate per-thread memory), I don't think it's a concern to
request users to query getauxval(AT_RSEQ_FEATURE_SIZE) in addition to load __rseq_size.

> 
> Maybe we should just skip the existing padding and use it only for
> some vaguely kernel-internal purpose (say through a vDSO helper), so
> that it is less of an issue how to communicate the presence of these
> fields to userspace.

The fact that libc's __rseq_size is included the original struct rseq padding is unfortunate,
but I really see this as a purely userspace ABI concern, which should not dictate the layout
of the kernel ABI exposed to user-space, especially given that all the information required to
allow rseq users to know which fields can be used is readily available by combining the value
loaded from __rseq_size and the result of getauxval(AT_RSEQ_FEATURE_SIZE).

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

