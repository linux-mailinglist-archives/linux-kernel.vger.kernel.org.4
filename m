Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87C668421
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbjALUlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjALUke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:40:34 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB175D17;
        Thu, 12 Jan 2023 12:10:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/zlaxnOKakRWGHtQnCdMjeOR5Qw1nhhkHoW3uKnv8QnEKOReUCIxwWND7P6NBfp+62AHoo1Na2HRHljjj43EA25RYSYfO74P7NL0nI+S8HcJwN8NSRBSedat/qG07IbpHt1oWF5V7ROC1QtSIKlTu7SCiqJyFZYedmWwRK2NLROCrmybEekn3cyUVSTzGI6+OduDPJ0lD/oxNxfk1rNYS3v3/IXxVSDy/uH0q9oolR1z0Fafg/amt9C9lifamihBMCaPJHdr0Vy4vbrCyVfElcSvGkWG+6anwmXNuftA2djX/PefjVYRqfUMy/WBKvl+TBa3/gt1H+nHprw9ddhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rgLNCsdJegiJyBsOFOBfrGxUu1f4j8umh3D8vo1fjY=;
 b=i3MgZejSJcIVzEaqaVxfFdd7O9y4bk/Fy7UF2r4jNdd79TtoA/hspWuyqnoQ0ZmUhqL7EYqtsfz5q54CIjVvj5DsSCpK+RyQ0WdcSVMhCJ0ljJ6NDVlYjFaTcq7y6n4fHPn144Awx4WQ0KUgQ5sZzPr1OWAaNy68TpEnd4fFph3+Ap40s7Z20fcsUnIYOykpoq490btPFZti2C4sXe+d89yxJeP/JqRwu9zcL6GinAO79NZJUGQMvp49YXEAKsBx3az5Yvi2JaaTQ6V+P1PuGKU7W7ewYPREumBcpZZHkDWDA6SCh+WiFpvxs0z+lfY30/vbiFrwBri5M0jepsT+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rgLNCsdJegiJyBsOFOBfrGxUu1f4j8umh3D8vo1fjY=;
 b=YFR3OmYY4DTCnny4pOWaK5REe/yWHdvDGxoXdlVmroa7wqkTLfQgq9XazFbQgZA6chG0fmTp2B+aUJENy3R/vdJvyQGbQDTPGtZY+E51iRD7ta8nz5AqBlOUiWktSN8UySgzTd/TiRvCLF6Q5qzPjM5W/ZztzlP/8DySpuXIWno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 20:09:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 20:09:58 +0000
Message-ID: <9a88391c-699f-e366-f88b-70fa481aaf7d@amd.com>
Date:   Thu, 12 Jan 2023 14:09:54 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, timvp@google.com,
        linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
 <5824c823-dced-bdff-dbd1-5cec9e89480f@tuxedocomputers.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <5824c823-dced-bdff-dbd1-5cec9e89480f@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:236::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ed8bcd-843d-44c4-3007-08daf4d8faa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS56HBOBNUnHEKKpm7YIVd/Q38ZTG0sXgKXMh0aG3hR8Q9/69sx9gwMa8PDcIm9PLx2RNnCvy+nleSxbTrpdYBjDr7QPnIJp9CU+hN4i6JqXzKXGiCbZQDvJpNd2GwDdFYhDh+pQ2WqP32Ye1lKSxfSHN956G29w5jp/CW1aMmOMovFoQxg7/D9y21b+NmoC5AGLhqtSHMJLsvdWCzPh2FywVtAauWRv4hIWSSBk+rDohqo1djsfegQPVrbzHqep0SyRnb11tHscK+2ylnlG8yTxYn03PoGdwfXJdBGwXG60zKM59VUUUmM5hxVOaRjI02VSS4OiB7hhEOf2Rx8/PutO9b6rQVxqQ6QDZ7+shY4ggnrZvP1JUIQMcCKwHh47gL0tjN0fChY8xuEMTXr8od9ixWPWf6rydZcUxeK0Vlm/ZW3nFPR7wz15SV3OoaVX3/D+dlX93w5YbO8wXelLi+eIuaNBBVHJIm+TPUomYgOoq8SCpXN6RUdspkrp4diEHJ74dcTTSgdEpoMD5MmqRRqyoEsUmxd+iyhJiUBGnvEboQlXvlYflCUHAfgy6JspyPt6Rahu982q1o5cW4LMhqXM0KEBPgVJ7nUF/cpfjggpxQav6tdblZzmEnNhw/tc2LMiNb9F35qp3IK6OXFJkH3xanKyEKOkB6Ekb2mgBj4/cU6Bw3lxwJe3VM8AYC3g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(36756003)(31686004)(86362001)(110136005)(83380400001)(66946007)(4326008)(66556008)(8676002)(54906003)(31696002)(41300700001)(66476007)(38100700002)(53546011)(186003)(6506007)(6486002)(26005)(966005)(6666004)(7416002)(5660300002)(316002)(8936002)(2906002)(478600001)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LytQNkwxS2Z1U2NnZ1VyRzlsWmdXUmZVdWNCVmFjWmlNYTFYaGt4V0NIaER4?=
 =?utf-8?B?Q3JRazVWaUFsQnMwVFdsTUE3cU8rbUFRTGZPeENMM0U3bkt1TTBOclN4Q3Nk?=
 =?utf-8?B?UlE3RjdIbVRvQ2M5Uy9vaGxGOXE1Uk1RNVBlWThQWGtJWnFob2pyNUtoZlpw?=
 =?utf-8?B?WXNYL0NFdm5iYUpHSTJXSEUxQ2RuZUtuTWpHYWZFbXZKbjhpWFFtM2JvOE8v?=
 =?utf-8?B?RjRBY1ZlVTFQNUdnQi9HN3lmbkppcjl0a0E4bVNGRk9nSGFEalliZm40Z3F4?=
 =?utf-8?B?WE5ScnoxMkU3NHhCQldWdGJRNzJydjlxaVVoL0tDSElWWTd0OENBVTVQcncy?=
 =?utf-8?B?TmVWRzg0YXBpTUFRWnVuQ1JHWU5RZS8xQVRCYjJqV2pvcFlvcTJkWUlyZ29W?=
 =?utf-8?B?T3VNZVZWL3M2UnpXdGNWTHJwcEs2YW03ZG5Venh3c1daVnN4a0xSUDljSDVx?=
 =?utf-8?B?dE9DRHhjaVhUcyszbzIyc3htcTdYZTNZbHVvYnRMN1R1T2pmbkpEcnVlOSti?=
 =?utf-8?B?YWg3Y2pvK24zSDJudXJ6ZjgwcDllMWFJYXBWRUwyRldtNmdjMXYvanc1TXNx?=
 =?utf-8?B?a25EaTV2RE5ScDNOTk52bzlEY3VGekxKU0JMNjdMMEM3UU5KWTFOandZYklU?=
 =?utf-8?B?MTlNRldLNGxVY1Jwd2YwUWowS3IvUlhwRFdxNjJOWHd0NlF1QnlWU1hMQ0ta?=
 =?utf-8?B?V0oxUXUvUmM1QVlxaE1IR3dZVWd3R3hDa2NEaEJjbmhKYkllY1lrUW41VkVQ?=
 =?utf-8?B?bm5EeGhOekRtNk9zSXVxMVpSUFJzNVVsMVp0ZDNHYkQwNFB1ejBQR2NJQkxi?=
 =?utf-8?B?ZGFvUlluQ0p5VmJUWUNYbFd4dWVBb3M3dmNKNjF4ZjVya1pIdk8vTGs3di92?=
 =?utf-8?B?OXRQYlY3VGZNV1N4RXJnQ2VFZ0VOaDFydHFZUm10Qlh1eWdJWEtDT2tmUjl2?=
 =?utf-8?B?SVlNTTZGSW1LaEhYZkZ2Qkd0UUpaTVZNTXNNUjlGamZKTDh6WlVObm5NbmZZ?=
 =?utf-8?B?SHViNEg5TmVlM0EyNTJCMkJEMTljd0thTW9MOWx3Sko2eU9oTDBHd0o5Uyts?=
 =?utf-8?B?OTVpSXhpdnNxS0tYaVZIRURTWnUzdVBxRTlManFBZk1ucWtRbXpSb284bHo5?=
 =?utf-8?B?SlhOMnVZVlJiMUtJWlpUNTFDT1Q0UjQwcFRmRXJNc2dpd1JoM1ZGMi9iT3Jt?=
 =?utf-8?B?aGR3OXhEbmlVMHBBNzBHWjV6eG1FNTY4SlFVSzdlWFdKeFBGS3A2TGw4Qm9C?=
 =?utf-8?B?V2VHak5NTmh1dnNmM0x0djdpZTI0VEppbjlkVlh1a2lIbE1wNUdJL2tmN2tU?=
 =?utf-8?B?b2FxSFBVNkpRbzhaSlZYd3F6YkZkbEhaVlFGYXNDQkYxZ0E2OGpYQUZ0RVpK?=
 =?utf-8?B?emNkVHpIOVp1QkVnbEZjVHgxMjhVUlRJbWpRWXB5N2JxT0J6dks0Y1FXWGhx?=
 =?utf-8?B?NkpUMjVVYVhwd0w3dU1uazc4M0ZLV2ZBaTl3amFtSzQySGpJL3N4WG5RdGE1?=
 =?utf-8?B?OVdUV0FnSDdzYWV5SnBvN3dlT01aZXRTUHp4K1ZnaTZCNkpSK1NwSW9RbjI3?=
 =?utf-8?B?dS9rNW1qV1hSUjNibDdkT1pIU2JxU0NVV3gwUkdBVEc3emxtNzliVE5ab0xX?=
 =?utf-8?B?LzhrZGQwSkV0UDNPWUdjREk3NjMzQ2NRb0hLVXdQOUhPWTRyTnFsUCtSNGQ2?=
 =?utf-8?B?R3pHa3BIRjNkcjdPRlVIVk5vZExld1hhNWdYaTZQcnBObkVrc0dYQTBRQ3BU?=
 =?utf-8?B?VmZHTnBMUlJVY1Y0SGRuVjRXQlF3NjRVdm82UTJkTTNwU1Fvc2IxemY2ajgw?=
 =?utf-8?B?cWdGN0NGQzdRMlIrT2JPZ2pGMjVTZmsvNnJUZ3ZIVjAxcWVXSE5hUXhveTdB?=
 =?utf-8?B?UUVNZDVzN1VuOU8vWjZWdGxzYVp5cG9VRW51aFF6a1cvOVZhNzh4eUl6cmZO?=
 =?utf-8?B?L2J3MHhLNFQvWTlZNFNpMmVnRkhlaGthL09keGNnVXZHQjBaVWJEREY1b3lV?=
 =?utf-8?B?TDFGVU4vQjUrbE14djFCWlVkTlczWHRtZmxaR2hnL01veUtCNDZZRWZOSENG?=
 =?utf-8?B?dE5oZFhBUTlUK0pjQ2RETjBNQzJCODZadGowcTZpRHRyakpRTUxWdlFCUUJ0?=
 =?utf-8?Q?q7cIZPL4bfipLLkaoVQhkjCKR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ed8bcd-843d-44c4-3007-08daf4d8faa2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:09:58.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08xICaOwxP9f6iJeYTdre05iUN0xDpysZGRiQYo/hHtFEB9BCHTETWXSK7bUOE9AVOsfkndG0fuKWv8QmdDxCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/2023 13:57, Werner Sembach wrote:
> Hi,
> 
> Am 29.09.22 um 18:19 schrieb Raul E Rangel:
>> This is now handled by the i2c-core drive >
>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>
>> (no changes since v5)
>>
>> Changes in v5:
>> - Added Acked-by: Benjamin Tissoires
>>
>>   drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c 
>> b/drivers/hid/i2c-hid/i2c-hid-acpi.c
>> index b96ae15e0ad917e..375c77c3db74d92 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
>> @@ -105,11 +105,6 @@ static int i2c_hid_acpi_probe(struct i2c_client 
>> *client)
>>       acpi_device_fix_up_power(adev);
>> -    if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>> -        device_set_wakeup_capable(dev, true);
>> -        device_set_wakeup_enable(dev, false);
>> -    }
>> -
>>       return i2c_hid_core_probe(client, &ihid_acpi->ops,
>>                     hid_descriptor_address, 0);
>>   }
> 
> this patch is causing a regression on the Clevo NL50RU of which the 
> touchpad instantly wakes up the device when going to sleep. That wasn't 
> triggered until this patch by the default settings: Setting wake capable 
> but not enabling it by default. So unless a user enabled it by hand, the 
> device went correctly to sleep.
> 
> I'm not deep into this subsystem so I don't know what the best approach 
> is to ?work around this firmware bug?/?fix this issue?:
> - Changing the default back again?
> - Adding a quirk list for bad devices?
> - Maybe this isn't a firmware bug, but the touchpad was not meant to 
> wakeup the device and we can somehow detect that?
> 

"Generally" laptops that support modern standby/s2idle can be woken from 
the touchpad.

By chance can you check Windows?  Wait a few minutes after you put it to
sleep to ensure it's really gotten down to a hardware sleep state.

> For reference: The debugging issue that lead me here: 
> https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1719789

TLDR - That bug has multiple conflated issues, and you can ignore 95% of 
it.  It's just the last few comments we concluded and bisected down this 
regression.

