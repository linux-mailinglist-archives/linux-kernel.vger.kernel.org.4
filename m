Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7436E6C07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjDRSYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjDRSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:24:42 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F8659B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681842277;
        bh=l8C30Bk06NQO2IPgpoprDzpUR8zjdgmuLBWX7P7sGEA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=g8ya43wf8TImTXGt4KbIYIy7RtDW/ogz4jBuyjBteD6t7CAsrMhr+vS5WsrmJgwft
         GNedbrSOOmuBLGH9Zdf4Yx8E2mAf59HdHIYYOqdYU8kXuIj/5fGRmcDKrCke3aE2BR
         K/OXxyBDq9zICDu9goE2G9OFPZtmlrbfHtkONg2fsryMKwgth1BTdoAjsrakZ5/K7I
         GvtUCLiLjBRMPpTn8t8coO7f/HQ1qbSTfqDW6RlKKXjMedKKIjeKuVP1e9VCY+qgHW
         wV1W+NQyM5hWfWWuLhmgn1LLtczxZtcHS2x3xxNxKsTekDUPgoULKhnKEPI9Y0Rty/
         nMG7bHrtoxAHw==
Received: from [172.16.0.98] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q1C4j02GBzw29;
        Tue, 18 Apr 2023 14:24:36 -0400 (EDT)
Message-ID: <a340030b-ce07-72e8-ba41-2896b31b4f1f@efficios.com>
Date:   Tue, 18 Apr 2023 14:24:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v8] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
 <20230418112151.GA565498@ziqianlu-desk2>
 <40689cd1-af60-542d-2245-c6362c73a365@efficios.com>
In-Reply-To: <40689cd1-af60-542d-2245-c6362c73a365@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-18 12:01, Mathieu Desnoyers wrote:
> On 2023-04-18 07:21, Aaron Lu wrote:
>> On Mon, Apr 17, 2023 at 11:08:31AM -0400, Mathieu Desnoyers wrote:
>>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>>> sysbench regression reported by Aaron Lu.
>>
>> For postgres_sysbench on SPR:
>> sched_mm_cid_migrate_to() is in the range of 0.1x% - 0.4x%, mm_cid_get()
>> is in the range of 0.1x% - 0.3x%. Other cid functions are pretty minor.
>>
>> For hackbench on SPR:
>> ched_mm_cid_migrate_to() is about 3%-4%, mm_cid_get() is about 7%-8%,
>> other cid functions are pretty minor.
> 
> It's a bit higher than I would have expected for hackbench.
> 
> Can you run with the attached schedstats patch applied and boot
> with schedstats=enable ? Let me know how the counters behave please,
> because I cannot reproduce anything unexpected on my machine.
> 

Also, just to confirm, do you still use this hackbench invocation ?

hackbench --pipe --threads -l 500000

Thanks,

Mathieu

> Thanks,
> 
> Mathieu
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

