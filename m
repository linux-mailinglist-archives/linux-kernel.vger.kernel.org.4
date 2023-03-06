Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405916ABE38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCFLeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCFLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:34:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33BED252B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:34:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C7312FC;
        Mon,  6 Mar 2023 03:34:43 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 884DB3F5A1;
        Mon,  6 Mar 2023 03:33:57 -0800 (PST)
Message-ID: <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com>
Date:   Mon, 6 Mar 2023 11:33:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 23/01/2023 15:33, Peter Newman wrote:
> On Fri, Jan 13, 2023 at 6:56 PM James Morse <james.morse@arm.com> wrote:
>> MPAM's cache occupancy counters can take a little while to settle once
>> the monitor has been configured. The maximum settling time is described
>> to the driver via a firmware table. The value could be large enough
>> that it makes sense to sleep.
> 
> Would it be easier to return an error when reading the occupancy count
> too soon after configuration? On Intel it is already normal for counter
> reads to fail on newly-allocated RMIDs.

For x86, you have as many counters as there are RMIDs, so there is no issue just accessing
the counter.

With MPAM there may be as few as 1 monitor for the CSU (cache storage utilisation)
counter, which needs to be multiplexed between different PARTID to find the cache
occupancy (This works for CSU because its a stable count, it doesn't work for the
bandwidth monitors)
On such a platform the monitor needs to be allocated and programmed before it reads a
value for a particular PARTID/CLOSID. If you had two threads trying to read the same
counter, they could interleave perfectly to prevent either thread managing to read a value.
The 'not ready' time is advertised in a firmware table, and the driver will wait at most
that long before giving up and returning an error.

Clearly 1 monitor is a corner case, and I hope no-one ever builds that. But if there are
fewer monitors than there are PARTID*PMG you get the same problem, (you just need more
threads reading the counters)


Thanks,

James
