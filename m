Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7F06E10AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjDMPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjDMPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:11:18 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD1A5E4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681398674;
        bh=gIeGr2QK7yXqx9+zy8LtKL96LEIhGVJJ5hb6SnKOjKQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O/14wAR0ZBjZcbTKna+aedBTgS3To67poqnd/fxXJf7k/xIja9IIx+NVyubyY4oe+
         /sIiMGlocweGuXMuuoJyIYXYAzLOHdmSMu5MxUrJNtUxpiWZvcWt3H2FItJI6OL8t0
         IBISqRUkJzYqhLzbUwWUBakg/iwo0LrIRzQJcWBT1kR+fMRCAHUtj+hyY4u7aABur/
         WFBqbFm4BNJhuhc53dbSYnGHZaMC3n5hDH2Z9Ew16ceu9nobjSS3VWG1c3eybYzYAZ
         rGdWSKYab7NaZpArjDLP92FWGmwSmCWCTbWX0JbqiBYO7UZoQyHiIYKbGSRxGiyojg
         1Y4+0TQl60y7A==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Py31t1nwqzvRq;
        Thu, 13 Apr 2023 11:11:14 -0400 (EDT)
Message-ID: <7c8e5b5c-2039-8477-1d79-61cd450da00c@efficios.com>
Date:   Thu, 13 Apr 2023 11:11:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v5] sched: Fix performance regression introduced by
 mm_cid
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230413140248.230479-1-mathieu.desnoyers@efficios.com>
 <20230413143744.GA221757@ziqianlu-desk2>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230413143744.GA221757@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 10:37, Aaron Lu wrote:
> On Thu, Apr 13, 2023 at 10:02:48AM -0400, Mathieu Desnoyers wrote:
>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>> sysbench regression reported by Aaron Lu.
>   
> Initial test using postgres_sysbench showed the lock contention is gone :-)
> Will check how it affects hackbench tomorrow.

That's good news! Not unexpected though.

One thing to look closely at is whether it's just that the qspinlocks 
are gone from the profiles but replaced by time spent in __mm_cid_get() 
due to cache-line bouncing of find-first-zero/test-and-set on the per-mm 
cid bitmap.

But if both are really gone from the profiles, then it's really good news.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

