Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24966C3129
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCUMCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCUMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:02:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AAB3EB54;
        Tue, 21 Mar 2023 05:02:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BEF8AD7;
        Tue, 21 Mar 2023 05:02:47 -0700 (PDT)
Received: from [10.57.53.10] (unknown [10.57.53.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993363F71E;
        Tue, 21 Mar 2023 05:02:00 -0700 (PDT)
Message-ID: <458b2a97-494b-7772-3499-4fba088b6a67@arm.com>
Date:   Tue, 21 Mar 2023 12:01:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 0/7] coresight: etm4x: Migrate AMBA devices to platform
 driver
To:     Rob Herring <robh+dt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        scclevenger@os.amperecomputing.com,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
 <CAL_JsqKsnq0d-x3m3xQe8m0pnk_Jeh9J1oFBtPAn3LV8-MFH0w@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAL_JsqKsnq0d-x3m3xQe8m0pnk_Jeh9J1oFBtPAn3LV8-MFH0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 14:17, Rob Herring wrote:
> On Thu, Mar 16, 2023 at 10:05 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> CoreSight ETM4x devices could be accessed either via MMIO (handled via
>> amba_driver) or CPU system instructions (handled via platform driver). But
>> this has the following issues :
>>
>>    - Each new CPU comes up with its own PID and thus we need to keep on
>>      adding the "known" PIDs to get it working with AMBA driver. While
>>      the ETM4 architecture (and CoreSight architecture) defines way to
>>      identify a device as ETM4. Thus older kernels  won't be able to
>>      "discover" a newer CPU, unless we add the PIDs.
> 
> But v8.4 discourages MMIO access, so this problem will go away on its
> own. Even if not, adding IDs to stable kernels is standard practice
> whether it is PCI VID/PID, compatible string or AMBA PID.

Yes, it would eventually go away. As for adding the PIDs, the
fundamental issue is, unlike other drivers, except for the "PIDs"
everything else is architected and each CPU has this PID alone
different and we have plenty of CPUs implementaions out there.

But all that said, since we added this as an AMBA driver in the first
place (all for simply getting the apb_clk management), I am happy to
choose the "Add PIDs to stable kernel approach" for this problem.

> 
>>    - With ACPI, the ETM4x devices have the same HID to identify the device
>>      irrespective of the mode of access. This creates a problem where two
>>      different drivers (both AMBA based driver and platform driver) would
>>      hook into the "HID" and could conflict. e.g., if AMBA driver gets
>>      hold of a non-MMIO device, the probe fails. If we have single driver
>>      hooked into the given "HID", we could handle them seamlessly,
>>      irrespective of the mode of access.
> 
> Why are we changing DT for ACPI? Just always use the platform driver
> for ACPI and leave DT systems alone.

This was mainly due to (1), given we have a platform driver anyway for
ACPI. As mentioned above, we could leave the DT alone.

> 
>>    - CoreSight is heavily dependent on the runtime power management. With
>>      ACPI, amba_driver doesn't get us anywhere with handling the power
>>      and thus one need to always turn the power ON to use them. Moving to
>>      platform driver gives us the power management for free.
> 
> This sounds like an issue for any amba driver. If this is an issue,
> solve it for everyone, not just work around it in one driver.

This alone wouldn't be sufficient. We need a platform driver anyway to
handle the two different modes in  ACPI for ETMs. But this will be a
an option for the other CoreSight components which are always MMIO.

Thanks
Suzuki


> 
> When someone puts another primecell device into an ACPI system, are we
> going to go do the same one-off change in that driver too? (We kind of
> already did with SBSA UART...)





> 
> Rob

