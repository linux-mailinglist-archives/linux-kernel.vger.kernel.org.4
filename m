Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0473F8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjF0JnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjF0Jm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:42:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A471226A9;
        Tue, 27 Jun 2023 02:42:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759C62F4;
        Tue, 27 Jun 2023 02:43:37 -0700 (PDT)
Received: from [10.57.28.204] (unknown [10.57.28.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C407A3F64C;
        Tue, 27 Jun 2023 02:42:50 -0700 (PDT)
Message-ID: <ca00f50f-3c65-f5e3-eec3-5d5aa598d50b@arm.com>
Date:   Tue, 27 Jun 2023 10:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH V5 6/6] coresight: etm4x: Add ACPI support in platform
 driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        scclevenger@os.amperecomputing.com,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230529062511.52016-1-anshuman.khandual@arm.com>
 <20230529062511.52016-7-anshuman.khandual@arm.com>
 <150b90b5-23fb-c115-6517-e6941b9b06df@arm.com>
 <2023062736-spearhead-spinster-0fbf@gregkh>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <2023062736-spearhead-spinster-0fbf@gregkh>
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

On 27/06/2023 10:20, Greg Kroah-Hartman wrote:
> On Tue, Jun 27, 2023 at 10:06:11AM +0100, Suzuki K Poulose wrote:
>> Hi Greg,
>>
>> On 29/05/2023 07:25, Anshuman Khandual wrote:
>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>
>>> Drop ETM4X ACPI ID from the AMBA ACPI device list, and instead just move it
>>> inside the new ACPI devices list detected and used via platform driver.
>>>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>> Cc: linux-acpi@vger.kernel.org
>>> Cc: coresight@lists.linaro.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for ACPI specific changes)
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    drivers/acpi/acpi_amba.c                           |  1 -
>>>    drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
>>> index f5b443ab01c2..099966cbac5a 100644
>>> --- a/drivers/acpi/acpi_amba.c
>>> +++ b/drivers/acpi/acpi_amba.c
>>> @@ -22,7 +22,6 @@
>>>    static const struct acpi_device_id amba_id_list[] = {
>>>    	{"ARMH0061", 0}, /* PL061 GPIO Device */
>>>    	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
>>> -	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
>>>    	{"ARMHC501", 0}, /* ARM CoreSight ETR */
>>>    	{"ARMHC502", 0}, /* ARM CoreSight STM */
>>>    	{"ARMHC503", 0}, /* ARM CoreSight Debug */
>>
>> This is a bit awkward request.
>>
>> I would like to get your opinion on merging this to coresight tree.
>> This change is removing the coresight ETMv4 from the ACPI AMBA
>> scan list and moving it to the coresight driver. This change is
>> essential for
>> 1) Adding ACPI support for later versions of ETMv4 that are not AMBA
>>     devices.
>> 2) Adding power management support for AMBA ETMv4 with ACPI.
>>
>> The above change has been reviewed by Sudeep (Arm64 ACPI reviewer), but
>> hasn't been Acked by the ACPI maintainer (Rafael) even after a month of
>> follow up with at least 4 reminders [0].
>>
>> Are you happy with the Reviews from Sudeep and given the minimal
>> change to the drivers/acpi/acpi_amba.c file ?
> 
> As we can't do anything now with the merge window open, please resend
> after 6.5-rc1 is out and ask for the ACPI developers to ack this.

Sure, will do that.

Thanks
Greg

