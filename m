Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CFB6981AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBORM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBORMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:12:55 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A7F751;
        Wed, 15 Feb 2023 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1676481173;
        bh=B8yQrj70Bj6HZp7M/reP6bFwWk74Ys9Ns/ym59ZM4Qw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=FQKQ1rMohLKWgJHJu1gofamtNpBIFgFZbdEjSPkcXOO4T2/mJEX7lVD1t/zzB4nFH
         6SWn4fRxadaN3B5zKXuAeZYkz2me9hHudaqGdQWfshV9AfWhWv+pewknqMNbuB7fUU
         nRManwKZFOtpHjVo10ZyjCOH48DEW/7QvaEmGGOwlyb2vj2j5+FrvAC97sUpmueMo+
         W+9yxyN3HGgv2V8KVONJ5Kts8F2zCo8svmetPDI7vgT7aCvCThqVuaBcADRxBouOhM
         VpkEsjlIHttLRuaAkSJRt+QReMCr5UyRB8HX5+QIRZpwOCYgjKZv0Ckv9MxnIrD8dA
         Da7u7TiAzH2vQ==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PH4QY0VQyzlp3;
        Wed, 15 Feb 2023 12:12:53 -0500 (EST)
Message-ID: <f5f27a04-2541-9267-cefc-47fd1c656ca9@efficios.com>
Date:   Wed, 15 Feb 2023 12:12:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>
In-Reply-To: <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15 12:09, Mathieu Desnoyers wrote:
> On 2023-02-14 20:20, G. Branden Robinson wrote:
[...]
>>
>>>> +user-space performs any side-effect
>>>> +(e.g. storing to memory).
>>>> +.IP
>>>> +This field is always guaranteed to hold a valid CPU number in the 
>>>> range
>>>> +[ 0 ..  nr_possible_cpus - 1 ].
>>>
>>> Please use interval notation:
>>>     [0, nr_possible_cpus)
>>> or
>>>     [0, nr_possible_cpus - 1]
>>> whichever looks better to you.
>>>
>>> We did some consistency fix recently:
>>> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=147a60d792a5db8f3cb93ea16eefb73e16c1fb91>
>>>
>>> Also, do we have a more standard way of saying nr_possible_cpus?
>>> Should we say nproc?
> 
> nproc(1) means:
> 
>         Print  the number of processing units available to the current
>         process, which may be less than the number of online processors
> 
> Which is the number of cpus currently available (AFAIU the result of the
> cpuset and sched affinity).
> 
> What I really mean here is the maximum value for possible cpus which can 
> be hotplugged into the system. So it's not the maximum number of 
> possible CPUs per se, but rather the maximum enabled bit in the possible 
> CPUs mask.
> 
> Note that we could express this differently as well: rather than saying 
> that it guarantees a value in the range [0, nr_possible_cpus - 1], we 
> could say that the values are guaranteed to be part of the possible cpus 
> mask, which would actually more accurate in case the possible cpus mask 
> has a hole (it tends to happen with things like lxc containers nowadays).
> 
> Do you agree that we should favor expressing this in terms of belonging 
> to the possible cpumask set rather than a range starting from 0 ?

Actually, the field may contain the value 0 even if 0 is not part of the 
possible cpumask. So forget what I just said about being guaranteed to 
be part of the possible cpus mask.

Thoughts ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

