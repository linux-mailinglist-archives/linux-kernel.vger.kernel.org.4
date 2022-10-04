Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF235F41A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJDLK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJDLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:10:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 075764E857;
        Tue,  4 Oct 2022 04:10:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB4D11FB;
        Tue,  4 Oct 2022 04:10:40 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A3AF3F67D;
        Tue,  4 Oct 2022 04:10:32 -0700 (PDT)
Message-ID: <98026867-fce0-da60-6b66-e50dfcf884b4@arm.com>
Date:   Tue, 4 Oct 2022 12:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] of: Fix "dma-ranges" handling for bus controllers
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <112e8f3d3e7c054ecf5e12b5ac0aa5596ec00681.1664455433.git.robin.murphy@arm.com>
 <166456654423.756056.16732005186500514187.robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <166456654423.756056.16732005186500514187.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30 20:39, Rob Herring wrote:
> On Thu, 29 Sep 2022 13:48:38 +0100, Robin Murphy wrote:
>> Commit 951d48855d86 ("of: Make of_dma_get_range() work on bus nodes")
>> relaxed the handling of "dma-ranges" for any leaf node on the assumption
>> that it would still represent a usage error for the property to be
>> present on a non-bus leaf node. However there turns out to be a fiddly
>> case where a bus also represents a DMA-capable device in its own right,
>> such as a PCIe root complex with an integrated DMA engine on its
>> platform side. In such cases, "dma-ranges" translation is entirely valid
>> for devices discovered behind the bus, but should not be erroneously
>> applied to the bus controller device itself which operates in its
>> parent's address space. Fix this by restoring the previous behaviour for
>> the specific case where a device is configured via its own OF node,
>> since it is logical to assume that a device should never represent its
>> own parent bus.
>>
>> Reported-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v2: Fix !HAS_DMA build error
>>
>>   drivers/of/address.c    | 4 +++-
>>   drivers/of/device.c     | 9 ++++++++-
>>   drivers/of/of_private.h | 5 +++++
>>   3 files changed, 16 insertions(+), 2 deletions(-)
>>
> 
> Applied, thanks!
> 
> I assume this was not tagged with Fixes or stable because there is not
> yet a user that needs it? I didn't add it either because I'm a bit
> worried about regressions and applying this just before the merge
> window. So send it to stable later if anyone cares.

Indeed this was only brought to light by a patch series that Serge is 
working on, so although it's technically a fix I don't believe it's 
affecting any in-tree users yet, thus doesn't warrant backporting.

Cheers,
Robin.
