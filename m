Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71D35B7A13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiIMSvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiIMSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:50:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6844F71BDB;
        Tue, 13 Sep 2022 11:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqe3hHHyT6gm6WzwIUTzuelxV9C6ktfL1/tcfkCb3V5Orl2sDW0viXf9zgzwH5r33+6BblRfb7ynPkVBWbiAqeV6PC4zjRJVdV0GcX8B07GC1HGhJgZFa83PI/3kAKa6b03joAjglbxyM+2U0GDNGvDgdfV9/v0MQce3md+9jlb36rXkXwcSLE2kBEn7fJ68cFo6jRa/+XAajHMpq0RSNCrsykqzQ2RBmmnDuRAcJSCXl2EO3pwGrkmtVcKUFk0b3SZkflPIRDfvMyHuEhjEhRA2Y2dhueo4i29URa5BFJYja984GE32ASwfa7AxLQH+rdZ6PkQObLV3kKe4tZ6YOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfHt50Ubt0QrOxkmihhT18cu4IdD/2zIohBE1hePIJc=;
 b=Qa6N0Xa0MtRIuMOrOLEmx0DCXLROJ58mQX7bS4VrJRfF7n1ngXNbCT+f62n5BAOrSGhVG4HVYyAAanHRXj/C/EaOLfogA3VWCdk2znUgMxxZXyQDK927iXU6ZUJkVRDOUtG8EVmM1XaPqc+DFV+OkQFkjj5ckyEDrk0z4RoRRMhuep++MDT3Nq8SBZgP1+nRxmKsLaeiNCYZZQZ1t7bs5fwB4qHz547MIc4aDQzkDSfdEElJXrikhbciUiUCUcljYhJujhrSgUWTG0+QwEDKZMWJMB6VbaG8q6lFniy+mK2Heq+igybs/bp/zWvrf2mVNbKY+0akErSsvQ52h1+6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfHt50Ubt0QrOxkmihhT18cu4IdD/2zIohBE1hePIJc=;
 b=Cg/AEdDcquJnToa0KatWfCgc0IxRSaYU1E/yCp5UzDeiX8vC9Um8UuLfyv18gdNtCtPkRTJXhgOgbFrV1Wc6prTJT73SwAsZ/vgomrgz0UV95umpq0AdkM6eDKCZyaMn4wr27prWtI34+ruMdh9b1kfTSydGPgtVU3OYNWyKYok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 18:30:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c%7]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 18:30:37 +0000
Message-ID: <4ec6d46f-b5c9-3c47-a102-6356e72c5225@amd.com>
Date:   Tue, 13 Sep 2022 13:30:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, Armin Wolf <W_Armin@gmx.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "hmh@hmh.eng.br" <hmh@hmh.eng.br>,
        "matan@svgalib.org" <matan@svgalib.org>,
        "corentin.chary@gmail.com" <corentin.chary@gmail.com>,
        "jeremy@system76.com" <jeremy@system76.com>,
        "productdev@system76.com" <productdev@system76.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-6-W_Armin@gmx.de>
 <b1b794b4-f6c3-7697-5d5a-b811809a9313@infradead.org>
 <2aae0ae9-9608-675a-ec0c-6e7526e57363@gmx.de>
 <MN0PR12MB6101CE9055DC152A6E96B2EDE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
 <7224d38e-9b51-0f81-e113-72f065909ea0@infradead.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <7224d38e-9b51-0f81-e113-72f065909ea0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610::16)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 85af36f0-1ed0-42a9-7780-08da95b60d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpKmPW+a7QpERZGQhvKrZKEdRQQb36ZYo4G60RV79xlMUe2D0BuIJaV9unZQ3EH8ayGi8XNkbShz9IV/j7hiXjTn1344U4Wn7B5F7zCyqyMm05rZhi7bnwzC0VqsytklMQdjZSibZQIkYhtjvamAaa9M75iefd0R313sKTB7mWhGrkJqxM0sgMOV7R1bfBZQxd6NpqDpLcDzUmt+r7gr3/D/WmsTGuoTKZ2ZGX8/fsbvZ6VYkME9S2GhqHoTbZ1sy0X3OigRPCP5YlgfEwl9UEgD3pdPCARiqU5U8IEMDpU6EvWw40V06kkHbVBwk3ySw2Z0qTRtm9htEYT0DYtsZNksHRqpOP6HGZCQcMh9V5k78uXPOwkol2SNw9Sl0mgb5a5U8iciYTtiI+V9hiAQ2vucQ++3KdI6P558TzZt4Q+XzvimkE8SvVSPp8JqWVUf0BSaQFGnK6tNQcInqiFSb7sNg9BU71BQMSPbEzsd4gjO0b2W5q6jH7ayCQ9LfsloMfMBrTsrk4HtBdTExsdxyKm9ZAZm5baaACww5YRXJJAzGGMw+GpM3RLzBSbzTSJ8obUzxIVwOHOXZsRsl2jWaVn7J1PTAJWcDznArQIm4HKjhxObATtVuLknps82LDfuaKAFZWrGTN9Z7mT9TJuagzX3vaVPkfgIJsn4e5iw3TyNTmJuJYe49TmZRib80MJ3S7OdYYZC+UMO0WIK0hgvWNSI89hpt7iVqx0gYKDoazZQS8RjzzHqzyyBgfFHgK9CPSIyCTwawHcjy59hbfzC5YG42GaZZoY3miX5bI5+mpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(54906003)(66556008)(7416002)(38100700002)(478600001)(5660300002)(66476007)(31686004)(186003)(8676002)(2616005)(2906002)(316002)(4326008)(83380400001)(36756003)(6666004)(26005)(6512007)(41300700001)(8936002)(86362001)(53546011)(6506007)(110136005)(6486002)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allOaWJqYTZRTzNZUlhRYkRSbWN3RngxTklxQUc0amQ1V3E5cmtqc2VoZFhI?=
 =?utf-8?B?VjBmOGhBdkZpenRuMG1sUnpSOWswbENmeDNCNzAwZTB2ZCs0WHFIck5HcUl4?=
 =?utf-8?B?aFJkU1hHK0JNWlFWOXhNYlFUcE5JL2M1YklQbkFiZmd1VHdzYjBPQzFLcVJD?=
 =?utf-8?B?TEw1d0VoYjNPME9LVTRWalRtNFpHK3BPVlBqNWJoMlVWbTcyNzdZV1JsNDNm?=
 =?utf-8?B?cXg3TGc0TGRpUEFaKzhXQXRaUjJRS3V6LytPT0Z2ZG9JZGMrSEhaNkNuYWVW?=
 =?utf-8?B?aGhTSVlqM3FpUG1ONWx2Uk5IUTk1WnBRYStzQmdzNjdnUnpqa3F5Q3dETGhS?=
 =?utf-8?B?SlYya0lpelluNTNyN0VtaWoxdDQ4eXIvQStCYmIzdmJKcC9ndFJmSnR3V2xP?=
 =?utf-8?B?WEFQRG9Fd09Pb1ZXaXB1bTg3WE1WRmhiS1ZRVDdxZjh5SGhjTGc5cUlYckNq?=
 =?utf-8?B?bWhtY2J0bzZKbGVXZW9aTTJPSERwaXE0d2xiMFRpOXkyK2RvUWpEVWVYajhB?=
 =?utf-8?B?OHRYODBSSE5MbXJQS1ZqM2lQRHpmdlRydzA1b2VpbWFaN2NGVEc0akFnZmZB?=
 =?utf-8?B?ZWQrNE1zSFZhTkdOSVJQb3kyYXdIamJxRDlyZW0rUUVUa0RUOFIvRXZFRXFo?=
 =?utf-8?B?QlpELzVPcUx2K3E3eE1MN2pzaUtCSEZ3SnovYktUMHRuTWlHU0R2Ym82T1Fl?=
 =?utf-8?B?NE5valB4d2gyTVhKMnRNQ3lZNHUxRXZxaHkrajJFZ0lSQXp5NWpTN3lYY1lt?=
 =?utf-8?B?cWZSdDVyUFRCeXhWNVNwSE1qNW9BTUkwZ0ZmVjdRUEFTY056SnNmSU1NWHBu?=
 =?utf-8?B?WHIrUzJncHgySDliK2wxWW1OMFBTcWdVc09KWFlLZTZnc0M3cHdlV3VpOXNX?=
 =?utf-8?B?Q05hVXJUL1BDMGIrWnpVK0ZrcWt3T3ViaHYyNlFadllja0J4d1RVakExeTNL?=
 =?utf-8?B?eE10SFh6ekZxMHBISzA4R3pzM3lWQkJiSlFvR2dTQjE2R2VzVkd3NUJ2VjBQ?=
 =?utf-8?B?TWk1Z2FrLzZUMkJuV1l4Z3NjdzBmeHNjbS9KMFpGc3lMaUZqcW1TNXlsRk9Q?=
 =?utf-8?B?OUpyOTBJemRNd1YwaFFDY3B3ZzhZZnorN3QxZUNJRG0yb01yRm8zQURtWkhJ?=
 =?utf-8?B?aS9WclRMS0pYb0RmalV0b3picytZN2d1cm1vZWFua3g3K1dKVG50M1VDcnVx?=
 =?utf-8?B?elRKckRmU3E2K0RyTGRYU3dNR2JIMEdmODBpUFlQNXdLa0hUN2ZyVldwVVBT?=
 =?utf-8?B?Zk1jdDV6UHBUY2s5bW5WZXBYRlkwbitkNFlRa2tMZGgrYzR1YkJzQTZnMDBF?=
 =?utf-8?B?M0ttZ2d0NkpyWFpvalRZQU0rR2c3dE9MQkNDY3JzN1FhdkdqOHc1NjZPQktY?=
 =?utf-8?B?b0xWblpvVGw3bTdzUWlvMzhlYzJvNWhUT0k5ZWJzNjVVTEpWY0tWNFpEeGZz?=
 =?utf-8?B?eGMyYnVMUGhZcjlzbVBibnlzWDN0dTBGS1BYTkxONUlxUVBRVVowdU5kTzBp?=
 =?utf-8?B?SmllcTZzVm1CbTdyVnZkQk9SYWVnR0Rsa2ZTM0JjZlFxMlpGR0k3TTNxRFpZ?=
 =?utf-8?B?a2xWYXlKSEF2dHJVeXRPblA5S1RZWGowNE1aQndxTHg5blZ4QkRYZDBGZDJt?=
 =?utf-8?B?WTYrejR0aUtpNGJqMDdQelhvSXM0aWkyZ1JFQU92bE9lcForVk9jaW9GMzdQ?=
 =?utf-8?B?Mm1EQlFXWmJYYVQ1UjBicHJaVExORUdLNi9oZytFaVJBRWV3WG0yZzBoYjAz?=
 =?utf-8?B?ZTJHaW5kUnNKZzdwaWFCWWs4Z2VnaEhmNFJOczJRQ1BGM0JFR3FlcVNQNmNR?=
 =?utf-8?B?eFM2U2tHUHlrSXJBb0lHTDdmdFRrMG1qeXhtN0YvcHdiRk8rNnZXcXhsRWVL?=
 =?utf-8?B?R3NOUWhDL0F2cThuZlFEZGl2TGVkSVcxMDRxMDZVallBVWRMQkxZcW1VQS8v?=
 =?utf-8?B?K1JuS1ZaNUwxUFlpUTdKcWZMT3pMQjBKZVAycWdaK2RTWUlLM25JODUxRDN5?=
 =?utf-8?B?YmdEYVdKVVkwV2NXVkdUL2Rrci80alk2N1VFZkF1d2p1OU1uVWFGSHZPT0dM?=
 =?utf-8?B?cDdjWkZjNlpGdXVMMG9HYndzdy9mK3lxbmFnc2lrN1lmbm0zTzFPeFE4TDh2?=
 =?utf-8?Q?bB4xsD9uanwJkhfMPW1Q+x2NF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85af36f0-1ed0-42a9-7780-08da95b60d1d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 18:30:37.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSidyB0CIJrxRkk1TTTXnKmYDyt/TBxyp0QGGmchFa103KbowrXqJrIksizYlDIB60ZkJADq375LKk2XXRNVfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2022 13:27, Randy Dunlap wrote:
> 
> 
> On 9/13/22 09:08, Limonciello, Mario wrote:
>> [Public]
>>
>>
>>
>>> -----Original Message-----
>>> From: Armin Wolf <W_Armin@gmx.de>
>>> Sent: Tuesday, September 13, 2022 09:41
>>> To: Randy Dunlap <rdunlap@infradead.org>; hdegoede@redhat.com;
>>> markgross@kernel.org
>>> Cc: rafael@kernel.org; lenb@kernel.org; hmh@hmh.eng.br;
>>> matan@svgalib.org; corentin.chary@gmail.com; jeremy@system76.com;
>>> productdev@system76.com; platform-driver-x86@vger.kernel.org; linux-
>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
>>>
>>> Am 12.09.22 um 23:56 schrieb Randy Dunlap:
>>>
>>>> Hi--
>>>>
>>>> On 9/12/22 05:53, Armin Wolf wrote:
>>>>> diff --git a/drivers/platform/x86/dell/Kconfig
>>> b/drivers/platform/x86/dell/Kconfig
>>>>> index 25421e061c47..209e63e347e2 100644
>>>>> --- a/drivers/platform/x86/dell/Kconfig
>>>>> +++ b/drivers/platform/x86/dell/Kconfig
>>>>> @@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
>>>>>    	default n
>>>>>    	depends on ACPI_WMI
>>>>>
>>>>> +config DELL_WMI_DDV
>>>>> +	tristate "Dell WMI sensors Support"
>>>>> +	default m
>>>> You should (try to) justify default m, otherwise just
>>>> don't have a default for it.
>>>
>>> I have chosen default m since many other Dell platform drivers are being
>>> default m. Since this driver is not essential for normal operation,
>>> i will drop default m then.
>>
>> Actually Dell drivers directory are a bit unique in this regard.  There is a special
>> top level boolean.  I would suggest to keep it as is.
>>
>> Take a look at:
>> menuconfig X86_PLATFORM_DRIVERS_DELL
>>
> 
> So all of those "default m" and "default y" drivers are *needed*
> as opposed to desirable?
> 

It was supposed to be a convenience option, it's first introduced in 
f1e1ea516721d1.

So if you have a Dell laptop you set the one option and then get 
defaults for all those modules.

>>>
>>> Armin Wolf
>>>
>>>>> +	depends on ACPI_BATTERY
>>>>> +	depends on ACPI_WMI
>>>>> +	help
>>>>> +	  This option adds support for WMI-based sensors like
>>>>> +	  battery temperature sensors found on some Dell notebooks.
>>>>> +	  It also supports reading of the batteries ePPID.
>>>>> +
>>>>> +	  To compile this drivers as a module, choose M here: the module will
>>>>> +	  be called dell-wmi-ddv.
> 
> thanks.

