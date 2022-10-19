Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA736040C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiJSKP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiJSKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:14:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A28F6786FD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:56:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D1C91063;
        Wed, 19 Oct 2022 02:28:56 -0700 (PDT)
Received: from [10.57.68.61] (unknown [10.57.68.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D653F7D8;
        Wed, 19 Oct 2022 02:28:48 -0700 (PDT)
Message-ID: <e37e12ab-9701-2883-724a-2a281ad35df2@arm.com>
Date:   Wed, 19 Oct 2022 10:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [Question] Question about supporting sysreg only CoreSight
 ETMv4.4 on ACPI machines
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        yehaiyang2@hisilicon.com, wanghuiqiang <wanghuiqiang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
References: <6e85db13-a65f-d4c6-1b6b-660a94cb7060@huawei.com>
 <9fc5ab20-c7f0-a917-4938-403e3661109f@arm.com>
 <Y0+5cESVK1LVXROj@shell.armlinux.org.uk>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <Y0+5cESVK1LVXROj@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell

On 19/10/2022 09:46, Russell King (Oracle) wrote:
> On Tue, Oct 18, 2022 at 10:18:08AM +0100, Suzuki Kuruppassery Poulose wrote:
>> That is true. Unfortunately, supporting this requires us to move away from
>> the AMBA framework (at least) for ETM4x devices. This is currently
>> developed by Anshuman. We can share it as soon as this is complete.
> 
> Can we not find a way to create AMBA devices from ACPI?
> 

There is a way today and that is how the AMBA devices (including ETMv4)
  work. But, the problem is ETM with system register access are not AMBA
devices. On a DT based system, they have different compatible and are
created as platform devices.

But on ACPI, there is a single HID (which makes sense, because they
both are ETM devices). Now, if the instance has memory resource, we
need to use the AMBA hook, but otherwise fall back to the platform
device driver. And this is not reliable, depending on which driver
gets to the scan hook first.

Also, another reason behind moving away from AMBA, in general is:
we need to explicitly add PIDs of all new CPU ETMs to the driver
to be able to probe them successfully. This doesn't work very well
for older kernels running on newer platforms. Even now the list
of PIDs is not complete and that would go on forever.

And the "party bag" of this change is the runtime power managment
on ACPI platforms, that works out of the box for platform devices.

Thanks

Suzuki
