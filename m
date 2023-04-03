Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF36D42E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDCLE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjDCLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:04:55 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 04:04:52 PDT
Received: from helium.impl.it (helium.impl.it [IPv6:2a01:4f8:c0c:b78a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241F30E4;
        Mon,  3 Apr 2023 04:04:52 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impl.it; s=mail;
        t=1680518784; bh=yiiBJB/HL/vbuNJbGEqXtHTv47wuBBL4QEy8T9nez6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=O33SscOAJda+GYtlIATC50gPolm+E7ASO6fzicTw5XiVfVG8sZfyeMsjWqDf43+7U
         CVDpaQGOeqEsFh688PGtoWJM6w6xe1wCQuf/LUHXIhL4rhblPUJDcFeqTXHsBnmIOE
         1+9RKsv0b67Wri1n2RxGUey9mDp6GVp1zF8a+Ye0=
Date:   Mon, 03 Apr 2023 12:46:24 +0200
From:   Benjamin Asbach <asbachb.kernel@impl.it>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Benjamin Asbach <asbachb.kernel@impl.it>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add missing T14s Gen1 type
 to s2idle quirk list
In-Reply-To: <a192e386-5385-d18a-9816-273e433eb833@redhat.com>
References: <20230331232447.37204-1-asbachb.kernel@impl.it>
 <a192e386-5385-d18a-9816-273e433eb833@redhat.com>
Message-ID: <4c4fe8ffd12c289308f9f7f6171a44c0@impl.it>
X-Sender: asbachb.kernel@impl.it
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-03 12:03, Hans de Goede wrote:
> Hi,
> 
> On 4/1/23 01:24, Benjamin Asbach wrote:
>>> Lenovo laptops that contain NVME SSDs across a variety of generations 
>>> have
>>> trouble resuming from suspend to idle when the IOMMU translation 
>>> layer is
>>> active for the NVME storage device.
>>> 
>>> This generally manifests as a large resume delay or page faults. 
>>> These
>>> delays and page faults occur as a result of a Lenovo BIOS specific 
>>> SMI
>>> that runs during the D3->D0 transition on NVME devices.
>> 
>> Link: 
>> https://lore.kernel.org/all/20220503183420.348-1-mario.limonciello@amd.com/
>> 
>> As Lenovo distributes T14s Gen1 laptops with different product names
>> a missing one is added by this patch.
>> 
>> Note: Based on lenovo support page there might be some more variants 
>> which
>> are not represented in s2idle quirk list.
> 
> Can you provide some more in info on this? Then Mark can maybe check
> if we need to add more models ?

Sure. When you go to https://pcsupport.lenovo.com/us/en/ and type in any 
of the
models in that quirk list - for example `T14 Gen2` beside `20XK` there's 
also `20XL`.
I assume - but cannot confirm - that the other types suffer the same 
firmware issue.

For my model the issue only arised after I upgraded the original NVMe 
with a bigger one.

Greetings,
Benjamin

> Mark, generally speaking it may help to do a DMI_EXACT_MATCH on
> DMI_PRODUCT_VERSION with ThinkPads ? That contains the human
> readable model string instead of things like "20UJ", and I guess
> that we want to e.g. apply the s2idle quirk to all "T14s Gen1 AMD"
> ThinkPads.
> 
>> 
>> Signed-off-by: Benjamin Asbach <asbachb.kernel@impl.it>
>> Tested-by: Benjamin Asbach <asbachb.kernel@impl.it>
> 
> Thank you for your patch, I've applied this patch to my fixes
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes
> 
> I will include this patch in my next fixes pull-req to Linus
> for the current kernel development cycle.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>> 
>> Link: https://bbs.archlinux.org/viewtopic.php?pid=2084655#p2084655
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
>> b/drivers/platform/x86/thinkpad_acpi.c
>> index 32c10457399e..57428d7a392d 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -4478,6 +4478,15 @@ static const struct dmi_system_id fwbug_list[] 
>> __initconst = {
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
>>  		}
>>  	},
>> +	{
>> +		.ident = "T14s Gen1 AMD",
>> +		.driver_data = &quirk_s2idle_bug,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "20UJ"),
>> +		}
>> +	},
>> +
>>  	{
>>  		.ident = "P14s Gen1 AMD",
>>  		.driver_data = &quirk_s2idle_bug,
