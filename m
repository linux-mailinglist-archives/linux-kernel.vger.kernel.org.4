Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7386E47A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDQM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDQM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:28:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D8B044B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:27:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF6BE1E5E;
        Mon, 17 Apr 2023 05:28:25 -0700 (PDT)
Received: from [10.57.80.202] (unknown [10.57.80.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47D633F5A1;
        Mon, 17 Apr 2023 05:27:41 -0700 (PDT)
Message-ID: <42d401e9-57d2-1178-eb94-68f975be73e8@arm.com>
Date:   Mon, 17 Apr 2023 13:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Content-Language: en-GB
To:     "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
References: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
 <20230416063028.GA6276@lst.de>
 <DB9PR04MB9236E1467316DFEE177D5E9E849C9@DB9PR04MB9236.eurprd04.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <DB9PR04MB9236E1467316DFEE177D5E9E849C9@DB9PR04MB9236.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-17 03:06, Z.Q. Hou wrote:
> Hi Christoph,
> 
>> -----Original Message-----
>> From: Christoph Hellwig <hch@lst.de>
>> Sent: Sunday, April 16, 2023 2:30 PM
>> To: Z.Q. Hou <zhiqiang.hou@nxp.com>
>> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; hch@lst.de;
>> m.szyprowski@samsung.com; robin.murphy@arm.com
>> Subject: Re: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
>> property
>>
>> On Fri, Apr 14, 2023 at 04:03:07PM +0800, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> Currently, the coherent DMA memory is always mapped as writecombine
>>> and uncached, ignored the 'dma-coherent' property in device node, this
>>> patch is to map the memory as writeback and cached when the device has
>>> 'dma-coherent' property.
>>
>> What is the use case here? The somewhat misnamed per-device coherent
>> memory is intended for small per-device pools of sram or such used for
>> staging memory.
> 
> In my case, there are multiple Cortex-A cores within the cluster, in which it is
> cache coherent, they are split into 2 island for running Linux and RTOS respectively.
> I created a virtual device for Linux and RTOS communication using shared memory.
> In Linux side, I created a per-device dma memory pool and added 'dma-coherent'
> for the virtual device, but the data in shared memory can't be sync up, finally found
> the per-device dma pool is always mapped as uncached, so submitted this fix patch.

Yes, in principle this should apply similarly to restricted DMA or 
confidential compute VMs where DMA buffers are to be allocated from a 
predetermined shared memory area, and a DT reserved-memory region is 
used as a coherent pool to achieve that. Quite likely that so far this 
has only been done with non-coherent hardware or in software models 
where a mismatch in nominal cacheability wasn't noticeable.

It's a bit niche, but not entirely unreasonable.

Thanks,
Robin.
