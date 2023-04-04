Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6086D630B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjDDNev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjDDNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:34:32 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9F3A8E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680615246;
        bh=h4RW9UuDQhINIiy6LaY51/jH2U56rWdjR71c2kGwdvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LyN9h/+pPpSR1gOhKw+8QelVYXganE9EOFRW4ilN+NRBRa2w7ElPSDJX8aEGRMjSV
         43Gcw2vZW/4w6NecZZocPe+oDR8vQsCc/PaiRiS9tTdYG3T4mEn4e3LVzJ27RVzvVf
         Qtnbd03egTpek3nbteX4NKR10hWFnXe54Oau8K3VUP3aONyqEJJ/tUF0+GiGvxmoZh
         q7awnZ+A0dRfoKgQYrPKZzWN0FDSW1TKkgW0lhvYaNpnMrHc1vEypUibLbghh8SevR
         SWb5HEIZfTu5Gmt7CLLfRaqVAmJ9jgSbtNAovapkkOCGzRkDGaEHw1dYC9Vuk+7Ha0
         qizxBQnua2HCg==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PrTHy56Jtztx8;
        Tue,  4 Apr 2023 09:34:06 -0400 (EDT)
Message-ID: <dfab31c3-a2cf-d52c-966d-0a3bb14b4fdc@efficios.com>
Date:   Tue, 4 Apr 2023 09:23:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
 <20230404085749.GA284733@hirez.programming.kicks-ass.net>
 <20230404091005.GA285330@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230404091005.GA285330@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-04 05:10, Peter Zijlstra wrote:
> On Tue, Apr 04, 2023 at 10:57:49AM +0200, Peter Zijlstra wrote:
>>
>> Sorry for being a little late to the party.
>>
>> On Mon, Apr 03, 2023 at 02:13:42PM -0400, Mathieu Desnoyers wrote:
>>
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 0722859c3647..21466fdc4dc6 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -609,6 +609,14 @@ struct mm_struct {
>>>   		 * were being concurrently updated by the updaters.
>>>   		 */
>>>   		raw_spinlock_t cid_lock;
>>> +		/**
>>> +		 * @pcpu_cid: Per-cpu current cid.
>>> +		 *
>>> +		 * Keep track of the currently allocated mm_cid for each cpu.
>>> +		 * The per-cpu mm_cid values are serialized by their respective
>>> +		 * runqueue locks.
>>> +		 */
>>> +		int __percpu *pcpu_cid;
>>
>> This *might* be a problem... Consider running *many* single threaded
>> processes, this could exhaust the limited per-cpu storage (32bit) or use
>> excessive memory on large CPU systems.
>>
>> Consider having to allocate per-cpu storage on a 4K CPU system while
>> only running single threaded processes -- but *LOTS* of them..
> 
> Ah, mm_struct::rss_stat[] beat us and set precedent, so not our problem I
> suppose :-)

Yes, exactly. When I've seen that mm_struct::rss_stat[] did not care 
about having per-mm/per-cpu data, I went the same way.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

