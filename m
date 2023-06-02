Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1977E720056
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjFBL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjFBL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:26:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EA411AB;
        Fri,  2 Jun 2023 04:26:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79CBB1063;
        Fri,  2 Jun 2023 04:26:47 -0700 (PDT)
Received: from [10.57.84.31] (unknown [10.57.84.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75AB3F7BD;
        Fri,  2 Jun 2023 04:26:00 -0700 (PDT)
Message-ID: <4bc59e32-a3cc-4e8c-0264-e509aadeb534@arm.com>
Date:   Fri, 2 Jun 2023 12:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/5] perf: arm_cspmu: Support shared interrupts
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
 <20230601030144.3458136-3-ilkka@os.amperecomputing.com>
 <e2f2c524-c7c5-7a55-aee5-699b069a445a@arm.com>
 <77b19b2d-a84e-eb13-db38-78cb34a444a8@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <77b19b2d-a84e-eb13-db38-78cb34a444a8@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-02 08:04, Ilkka Koskinen wrote:
> 
> Hi Robin,
> 
> On Thu, 1 Jun 2023, Robin Murphy wrote:
>> On 2023-06-01 04:01, Ilkka Koskinen wrote:
>>> Some of the PMUs may share the interrupt. Support them by
>>> setting IRQF_SHARED
>>
>> This has the usual problem of allowing any PMU instance to move the 
>> IRQ affinity to a different CPU without also migrating all the other 
>> PMU contexts, and thus breaking perf core's assumptions of mutual 
>> exclusion.
> 
> I see, I wasn't aware of such an assumption. Sounds like there isn't 
> necessarily an easy and clean solution for the shared interrupt case. I 
> drop the patch and get back on the issue if we come up with something 
> reasonable later.

What comes to mind is factoring out the explicit interrupt-sharing 
machinery that we wrote to solve this problem in arm_dmc620_pmu, or 
possibly trying to do something with IRQ affinity notifiers (however, I 
recall looking into that a while ago and it didn't seem like they 
actually interact with CPU hotplug in the way we'd want).

Thanks,
Robin.
