Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D56D40D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjDCJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjDCJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:40:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D4A111E8A;
        Mon,  3 Apr 2023 02:40:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 456AA1063;
        Mon,  3 Apr 2023 02:41:01 -0700 (PDT)
Received: from [10.57.56.209] (unknown [10.57.56.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7A83F840;
        Mon,  3 Apr 2023 02:40:15 -0700 (PDT)
Message-ID: <d232392a-dadb-ec53-9613-d9b561fe1e87@arm.com>
Date:   Mon, 3 Apr 2023 10:40:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] perf/arm-cmn: fix regitster offset of
 CMN_MXP__CONNECT_INFO_P2-5
Content-Language: en-GB
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ruidong Tian <tianruidong@linux.alibaba.com>
References: <1680169620-26012-1-git-send-email-renyu.zj@linux.alibaba.com>
 <3b95e362-300a-12af-0d55-76672c60be9f@arm.com>
 <ZCqD/HlIRgewdnwA@FVFF77S0Q05N>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZCqD/HlIRgewdnwA@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-03 08:45, Mark Rutland wrote:
> On Thu, Mar 30, 2023 at 11:34:22AM +0100, Robin Murphy wrote:
>> On 2023-03-30 10:47, Jing Zhang wrote:
>>> In the CMN700 specification, it is described that the address offset
>>> of the mxp_device_connect_info_p0-5 register is 16'h8 + #{8*index}.
>>> Therefore, the address offset of the CMN_MXP__CONNECT_INFO_P2-5 macro
>>> defined in the code is wrong, which causes the cmn700 topology map
>>> incorrect printed in debugfs.
>>>
>>> So correct the address offset value to make the cmn700 topology map
>>> correct in debugfs.
>>>
>>> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
>>
>> Ugh, these offsets are correct for CI-700, so strictly that commit is fine.
>> What I failed to notice is that CMN-700 shuffled the mesh_port_connect_info
>> registers out of the way, so it's commit 23760a014417 which should have
>> added more handling for this difference.
> 
> I'm assuming that means that this patch breaks !CMN-700 ?
> 
> i.e. a more substantial fix is necessary, and it's not just a matter of
> changing the Fixes tag.

Yes, indeed. I have half an idea, and the plan for this week was to work 
on other CMN stuff anyway, so I'll see what I can cook up.

Cheers,
Robin.
