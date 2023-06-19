Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F269735D39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFSSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSSDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:03:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458912A;
        Mon, 19 Jun 2023 11:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WokwJCGYln7dSJSADhRdx86tfxEEJNjlMPN/QUy4pnbxaG8Q550dSxJZn9tuxhwrdjd5jFyOjYJBBMr/z6C5uMpcrrOvMpRVrNmMQ8tG6YRHcORDGfQ/yTOtLEQgceYlddvNxmtkVnk5VRrMSZwQXdtlAR6ETcLP1j1fye+fLqZEJzI3yw72n0U8OxpHltu3I03Z0CiphINdR9phOp4hFVZcygVuy6AUz7cYiWuoxbX3O9L6OE9MqKRmH3FGaU54a0hQzDKRCF3bA3L5amcDqCfoVjYhW9b6g29VfXXEPnL70aOr0o/TyX+XwkAIGKm5CKdJhTv4ao8SVaPNBjbPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VvWqtN4rWALfsGTp6W4crpOuYVBkmfQnYw0rUwt+Eo=;
 b=UoMGPmsL5vmFsz3EM4WMDUzg4uVVhL+jN2kwbR905y3KWJH/S0bJoqG0oUeriEZF9RqccABk3nGd8+R0qPs8IcdOcATaVWHAeuxCQXvPL/wNtIgP4AlGHHI32yQBv7EIAOaT+2xNd11pwDB4PK+isTiyVp8+mm4DyRb34/Dijpw4P+E85CrJ6kL0b8Vv/XwuuZbe9ZrfjXcjaGcC0Db9EE+hT+HglSCx9p3/fBsiPtVEqXE9kNw5bW5DlPaJueBVft/oiBX2rUjHNSbjfvapFaSWBKfH9OlXG0mKFHQTAcBg3A06sad6eyntYudS1wbnF+w9uAqiyLCm0YZK2ILWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VvWqtN4rWALfsGTp6W4crpOuYVBkmfQnYw0rUwt+Eo=;
 b=sLnyb0Aql1g0lBjatnB0XOu934Nf7LgtMk3wegu2OBmcCxVk200vBFRRYucrlaHMTkmVuSFADqRdCr6jIYuVNvuX//Q82mCSeowCEVVj6hClOajQb9zldhXpz40fAVO3uDGrPZ2e1zLyHcsWke2sMgv71FUARDfP8EBXZ3sYRnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 18:02:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 18:02:58 +0000
Message-ID: <012ea369-52ec-4a7a-ec66-812690d430ad@amd.com>
Date:   Mon, 19 Jun 2023 13:02:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Baskaran Kannan <Baski.Kannan@amd.com>, babu.moger@amd.com,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619165413.806450-1-Baski.Kannan@amd.com>
 <4585ec62-b7bb-9f2a-eee0-07032648e55a@roeck-us.net>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <4585ec62-b7bb-9f2a-eee0-07032648e55a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:5:100::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: b03676c6-6f88-4cd2-319e-08db70ef6a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8zwOiOjEajT61iFDFuAFUGx1IY6mPO5oirmXOKRunPjIjbMOoiptB4AzuFbjFKLzbv1vcb7L81okD5gXiiQ+P3gQavsH/fcTq6IQjfYL6wh0PhCQrffUnnzhLXrNwgjfRikh3Uq4B43/eb6uinq6iCwUW8FcdnyI6OnhslMohbm6MmGhxlrFTCF43vm+GzUHuzQXwyd8CW/sTUWVVvQ8+GmoYKaU6kQsQ2dAzzIPkqf5gMMH2mwNTG+kQBoeienXnTVTQOPGVZoLb0qWdDgPuVP6syEGlSn9KjjtbXx8QBOwqtbLyiH5Wd4lSexKZqooR05JTuJ+vlhTL/ajgGfHw67v8ro9jBwzT4RG85vgjUj1mQzZbqMQiTYVbVDGgBqWoYUdTStK1pD3/19uBikJ80xISL+SRVuM6onBuHI3CJjQgO9VYKebpRPtbWq7fGnx8a5nCUnbRmlkqgXnYuNY3mWu65UQxYd5e5oQ5kLYarh//Gun91ADcNJaZHqYltRYI4uCKWdqvX8etDi11pb4jefYR7MHorsOL4n/VjPTkhpRUjjlG5ST34mqHxJcY0MXAFT6wclSooDkzsCLsR9Smy3rOHOgCgaLZhoAzJgFNrqyufOmlG6UpbHyKEcpsvTLGUXREec4rNBVpt04GYv5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(53546011)(186003)(6512007)(6506007)(2616005)(26005)(31686004)(36756003)(6486002)(6666004)(478600001)(83380400001)(110136005)(66556008)(66946007)(66476007)(38100700002)(316002)(41300700001)(8676002)(8936002)(5660300002)(2906002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxPdGV0eVQrbjkxSUcwMSt1NFNSTEZ5YW01MTAxUlIxcjV3aEtrRHduaUpk?=
 =?utf-8?B?UWpIdEtNVDh2Wk9XWEtLZDg2LzYvVElPU2RiWE1CeGZRYllUNm9NZ3BqdE0z?=
 =?utf-8?B?TWc3bEtBVWovdE80dFZ4TEpLUExrc1hNV2loV0JNWi9IMUJ2a2FmbGdBQzYz?=
 =?utf-8?B?ViswLzMrTklKcS92Wk0wemlTT3V4OVpRbVkvZ00vcTVwNk5qZFE2L3ZHelc5?=
 =?utf-8?B?aEtKMGh1ZWJzTGdMUWVlcDlaa2Z6OEx1RGtlcDV4TlBhK21CSFB5TWs2TGtj?=
 =?utf-8?B?eFNPTnRkdTBZSGljUmplR3VYVHY1cDl3NUJ4ZkVYU1hlcVVjcythbVFvZG5k?=
 =?utf-8?B?N29Ta3N2U25ab2pOVnZncUxwcXNxTVFuem9NWU1uWGVLd1BwWGQ0R25iT1pJ?=
 =?utf-8?B?ekd5L1JZZk5NTk8wanFXUFd4eU1kbVMxbFVpb1h4bGt1TzFpdXJib2c5ZFlN?=
 =?utf-8?B?WXdjOExXanRvV1RtbjRDN0N6am9RRmlGSUg5RVZQak14N2xKczZSVGJGd2hv?=
 =?utf-8?B?TkNkVG81Rk9ieC96TTg1aElkMFlLejBJSUJHdTB2SThkNDhKaUlwZ1hHeTR5?=
 =?utf-8?B?dEpFb1p3dDNzbWhjWkhEdkxrbHRaVk1MTDBkUFVRRjRJVG5UNy9MRk8rZ1V6?=
 =?utf-8?B?T2ZlU0tyMGxyVWh6ZHg0bjRmRkpZcjF2MHpwR2oxdFgwcHFqbXRqZXJlZzF1?=
 =?utf-8?B?aWQzOUh4WVpSSGNPQTRyVnRqK2xJSWdNcHMvOExUalczSVdjYkp1NjJHRkRT?=
 =?utf-8?B?S1MwSW5LNVczZ0l1VzQxdS9rSkpIdTVQL1pZekF2RXEwaXNhelJ4S1VoSUd0?=
 =?utf-8?B?eU5JVEh3UUh1TWNBYlNDbGQ0RU4rWVVSMnkrYjJvemVrQnFadkw5QUQwUmJp?=
 =?utf-8?B?SVh4OXVPTkt3dEdXK1hSeXJiZENlTXo3di9kcThPTGxmZVVKRUVFV3pMNUtY?=
 =?utf-8?B?NFR2M0JzQlFxNEw2QVBlZzEzL1lNZzgxNXcrRSt4RFZPY0dQbUlsZkJDY1NI?=
 =?utf-8?B?Qjgxamhpc3JmanMzV3lSZGk5VytkQ0d3V0VCM3YwS3Q0b05TK3hNdysrVzZC?=
 =?utf-8?B?cU9oRWF3TE5Iem4xak16T3QzM1o1dzlKbnJwell2STFxb2p0L1IvMHl3cndG?=
 =?utf-8?B?ck1UekRqVVNzU2JHSGR1ZWVGZ0tNZ3hiZWk5YWVuUHBtOUVRcEJKeGJrQnBn?=
 =?utf-8?B?dHh3L2Ric1pNcERQeWdFTFdlUXV2ektKWU9GbmsvakY1SE5nRDNRNHg3QUpP?=
 =?utf-8?B?UXF2c1VRZ05DUEtPei9wWEtKT055L1VHWkN4Q04xOHg1Vyt4UEVMSWRwS2dy?=
 =?utf-8?B?aytBVk5lQWNoUW9ZSkp4eUZoVWhrQWNTYWM3TFdXdHVyaUhNeGN5Qm1PbkpW?=
 =?utf-8?B?VzJTdFpCYVcwZlhGSzJmUFVJUTJaMHpBWDYwTWdWZVdzaytGOHFRMmYrUVZU?=
 =?utf-8?B?TW5idkxWcXh3RkZpdy9oWDJVU1c2ZVF4clJpRktlNjdSN25FMk5yR1d1eWZY?=
 =?utf-8?B?NFltSnUvNE1mZkJOVitvc0JRcEg1Z2VWSUUwRVVzUVRYODhoUEd3cFdRU0pJ?=
 =?utf-8?B?UzlySG1mMjVFQ3habm91aGVDVU5SdGxwVTFLMFZsWmZsL3d3bGtoM0Z6dXBz?=
 =?utf-8?B?b0E1R21YZVlPaUhPL2tTb1oydG5aKzl5d0pUaXJCSm5NcEE0WFVqdUM5TWhD?=
 =?utf-8?B?a0NHYWo1YXVVUVNMOGNQOGF3amVTcEcxTXBBcEFMYkVrSjdPb3NzbjhhOTR1?=
 =?utf-8?B?dU43bXdlTWNDK2dEU3FhVmRrSWtGaDd4V0xYR1B5dlB6ZEZYWHc2MVlLRkVJ?=
 =?utf-8?B?NjQzdklaemtKdlFaZDM3WVlabWl4dU9laDRFTTQ2b2tBL0NPOEdrUUFBeGpQ?=
 =?utf-8?B?SFppbi80Z3lCbTVQRHIwaTJucHVYWGg2bEFFTklUNXRoUmJqRTJxQXpCczhq?=
 =?utf-8?B?bDUyTitRelhXMjgyVGZJYytWaEFITko0Z1BiZnlOM0hhdU1lZzZIbkxmRmFK?=
 =?utf-8?B?eExTMEhwWUl6bW9pTjRsZlZYZVRXekRZRlhrUUxoaW5wRjhVbW9pYmFUbEJV?=
 =?utf-8?B?eGhiWWs4U1BwRC9VaE9Lc3dHcm5lZ2toNnpGNkRsMlR1NjJNdzN6eFY4T1VT?=
 =?utf-8?Q?UiHYN9v2ruNMg8bLzn+x2cHoi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03676c6-6f88-4cd2-319e-08db70ef6a14
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 18:02:58.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrHWlekJOfZU1uR4kX7M+wjLKQH2AxymhfRCSu1yOyEEILQ4PHtRMIIpoBz+uuLODkN3MrydIKh3zRW7A6ESFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/19/2023 12:07 PM, Guenter Roeck wrote:
> On 6/19/23 09:54, Baskaran Kannan wrote:
>> Industrial processor i3255 supports temperatures -40 deg celcius
>> to 105 deg Celcius. The current implementation of k10temp_read_temp
>> rounds off any negative
>> temperatures to '0'. To fix this, the following changes have been made.
>> Added a flag 'disp_negative' to struct k10temp_data to support
>> AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
>> is found during k10temp_probe.  Flag 'disp_negative' is used to 
>> determine
>> whether to round off negative temperatures to '0' in k10temp_read_temp.
>>
>> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
>
> Now you have made changes you were not asked to make, extended the flag
> to cover a range of processors instead of just i3255, and did not provide
> a change log nor a comment in the code describing why processors with
> certain model numbers should display negative temperatures.
>
i3255 happens to be one of the industrial processors in family 17h models
01h through 08h.  These are potentially used at subzero temperatures and
so displaying negative numbers makes a lot sense.

So I think the commit message needs to be be amended to better explain that.

I guided Kannan against leaving a comment in the code with specific models
because it either won't age well as other industrial processors are
introduced or may need to be ping-ponged each time.

But perhaps it should be more generic like:

/* Industrial processors may be used at sub zero temperatures */

> Guenter
>
>> ---
>>   drivers/hwmon/k10temp.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index 7b177b9fbb09..2613420d43ff 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -86,6 +86,7 @@ struct k10temp_data {
>>       u32 show_temp;
>>       bool is_zen;
>>       u32 ccd_offset;
>> +    bool disp_negative;
>>   };
>>     #define TCTL_BIT    0
>> @@ -204,12 +205,12 @@ static int k10temp_read_temp(struct device 
>> *dev, u32 attr, int channel,
>>           switch (channel) {
>>           case 0:        /* Tctl */
>>               *val = get_raw_temp(data);
>> -            if (*val < 0)
>> +            if (*val < 0 && !data->disp_negative)
>>                   *val = 0;
>>               break;
>>           case 1:        /* Tdie */
>>               *val = get_raw_temp(data) - data->temp_offset;
>> -            if (*val < 0)
>> +            if (*val < 0 && !data->disp_negative)
>>                   *val = 0;
>>               break;
>>           case 2 ... 13:        /* Tccd{1-12} */
>> @@ -405,6 +406,9 @@ static int k10temp_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>       data->pdev = pdev;
>>       data->show_temp |= BIT(TCTL_BIT);    /* Always show Tctl */
>>   +    if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model < 0x8)
>> +        data->disp_negative = true;
>> +
>>       if (boot_cpu_data.x86 == 0x15 &&
>>           ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
>>            (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
>
