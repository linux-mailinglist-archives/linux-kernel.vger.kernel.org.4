Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC2735D19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjFSRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjFSRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:37:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011709D;
        Mon, 19 Jun 2023 10:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epG3D+7DJ3yN9H8IiUhIxyuHuXi/t7jzYqPxamzPAiMZ8ECnUyMUojNghHMaAhaw5YW9HLebHQHghnltCIB7RPcboaaIZMwPqbaOgtLLgD1viIJIINBCQE3A2FBlbTM/hp/FArFUxQxb/SVzu4g267OKefQUX0txwcaOJK6gentrzGc2gQU8gbT7tk3Z0zUK51Nz+TbVWSMgBmkgsJSBfrcYiHJlupYq2lXv2lJd8y448puJw/VciyPUyvQ/Si+hRa8dGCdeFnwJeHK6qqAvg4qKOTHuet7dMg92acD9HvDaR+FnS7R0ljuyxd03Ntrdt4hE3dipswECixC4bKKcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I219eKtoHTd5xajVytzf4050f7yUIVsFIMLgddzBtBU=;
 b=Gb+s7Lq2EdXuyDsnGwEAI+Ij0ClIk6NHzctZH73e3y0goryl3ufLVeyUb2FO6/p6UuLqlVAUjHatblepf1stwIHEui3+TwOtrgcSKkhtS6ZS1pUux1y1JekMvq2swI08i9Y4A4E/139DJEaxIuDo8lLg2b46V/M1wRF+sWcoFW6RNK9T+1Zw+1CP6X0fWaenknjvxRwcZkiYBLyZaPZD7+kSbM6YRMIHbdf+wvVQ7FYheX1ZmhYyTtCIjYJeqBATuYH45QSYFguiCI2fko3ssIPseK7OXPAaEgRxwxul1voaTA58SZq3VCX+PISL4Ovj8TIoM1EmR/8YrFH2Zw8qYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I219eKtoHTd5xajVytzf4050f7yUIVsFIMLgddzBtBU=;
 b=GUmrfXGj8ujKoS1/zjNfIDFTZNgLofi4lWZSjYeTsQ1fJIz7CT60w3VmLdAdFQVaiXfG7QktFb3COrkG/uS0VdN2WWOJQSa5jEWSdHhSwP4psxhuGYKezCIiorjz2pNb5tb+r+MnhZviJB1fQdZYvnZreM6kVeVhraCQ3Rg3+Fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 17:37:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 17:37:06 +0000
Message-ID: <ca501364-a7d6-8d56-1f32-91430b9bcf4b@amd.com>
Date:   Mon, 19 Jun 2023 12:37:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/5] cpupower: Recognise amd-pstate active mode driver
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        gautham.shenoy@amd.com, Ray.Huang@amd.com, Perry.Yuan@amd.com
References: <20230616120620.147643-1-wyes.karny@amd.com>
 <20230616120620.147643-2-wyes.karny@amd.com>
 <348fbe1a-6c2d-68d2-b4fc-278407ede33c@amd.com>
 <ZJCQ2ypbQgZOOjt3@BLR-5CG13462PL.amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZJCQ2ypbQgZOOjt3@BLR-5CG13462PL.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9c3310-e2cd-4fed-3a4c-08db70ebccff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6iOe0IZ/FUqKEdOikJlz8GhZiC+tZGuB/6+qL09Jpz3fnP/BHp5xV47xTEZyMdLUWGeeGuNOHmRNZc9dW3x2anZInmnAkcS+0CkJ5J/Rpe8LM/c3rFhi+UWtD4ekGS7VdBLcuNyoymFdmOgTC+aU3eSr2kFpdH2hQgkrpvXwoJqOZMPL8Xlpx6HbQDf5JlIFz0cGJhIfgJ40evNGtzvjCSD3nP31pJOwUhXUt5rDmz9x33rSpwYn9b2mmHlURKRL9HJvp/wNV2MYcoVmUBjBHhbgLSzTBGexFN1jVwp34wrs/pgManEwoT5nrYo5k9W3zbvfxXjLhWGp2zgrLeUda/UoV+BkF+FiyRtMvxLR4hcTJG00UylhWh+5R/SWD7FO1zQVsPD9mbE7XMDmcH0wM1JRVO9cDYkdSxwctUniN0DB0XaN4HpzRvBFJev5YMzgrAjYZzx4Cudj/OnrmlbJoGSHXQHuVxFMPbGg9Uui4u1tsQ96o1EKDPOV1GbQBIa0s6ey3WwfzzucC9q9wKjW9VcQ9dGgwVdzRr8QgSdRW2NohoNCV/AS/oHgmzXTOA9aeXDp88qzQtlw6cIjvrt49jy6DTnFD2p//DXvdGZ/7KykA6nBSmhIXW80iEL7i22uSX+WrvQoHPHW2nyMqXAxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(478600001)(6666004)(6862004)(31686004)(66946007)(66556008)(66476007)(8676002)(36756003)(4326008)(6636002)(41300700001)(2616005)(83380400001)(38100700002)(31696002)(6486002)(86362001)(2906002)(5660300002)(37006003)(8936002)(316002)(6506007)(53546011)(6512007)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUFoZUVkcU5CSndYUUdwL0hwenAxWkxVS3ZXKzRIdUhydDhzUmp3TWQwUFFG?=
 =?utf-8?B?VVcyYUVZejVIRGlEcGplN1Rpb0Qzei9vZG9iZmRmTU1JT3AwU2lyUzR2WlE1?=
 =?utf-8?B?cmwwZElkWWlkVDNuaWdwN0p2UjhhQkJ2R3p3RVA3b0JnYkhhZDJNZWRaOW5l?=
 =?utf-8?B?TWJQaHNGdzArYWR5VC85Q2lHck9zZzl5VWt6NUI4ZFdCWHdsbTRXbUkvQkhX?=
 =?utf-8?B?RXNqVHhYdHp3YkNsdHpSQlp2MmYveDByemNXMDlWWWN6SGhyeWFzYVpkcHVM?=
 =?utf-8?B?TjNja1AxU2VBbkdXMVYvcElQeDdrSDJndDFWL2xvV2VOMFdyZUU0bDJ4eUxC?=
 =?utf-8?B?ZkZuaTFQNUhZc25vQmhjOG5kSlUxSmh0RnE4UkxXL2ZYSEJId1FnWTFLcG5V?=
 =?utf-8?B?TFlnS2F1TnVmN2hBQjlwQlhKV3d2bFVrNVJYT01yVHdQQXVTanByZ3E5TXFY?=
 =?utf-8?B?UmVCelV3akIwZEdDZ09wSlNDZk8ybzJET3ZQZnR3WWd2VFQrYkpHc09FSHpK?=
 =?utf-8?B?Q1NBZkxvRUUydlZEQWEyZTNlTHRxVDdDOU9LVVc3SVgwbzFTV0FQVlp6dFZp?=
 =?utf-8?B?QnF5YWJuTDBPcGFhRUhZNmlraG1sRFFieTN6b0l6K2s0ejlOU1pyUklKMmUy?=
 =?utf-8?B?Q3ZadjlDYlBValMrcGtqeFZJRXNmSFR4cG16dk9aTmxHaEE5QkJaZXdFZGFJ?=
 =?utf-8?B?LzNkemplV0JrZDRZUHdIM3dZZk5LSWNWalZIdTR6OTMrMC8vdW5xUGpJQUMv?=
 =?utf-8?B?a1FibGczbmpvL1E1dVpVOVRXUmQzeGREblphUzRhYjNRODhoVXpMRjBoRmhy?=
 =?utf-8?B?UTZrTlAvSVpDT3RKUkV4TS84cXhVTHVITlJxVXNiUmRiaU1DT2lUSnBDVmlL?=
 =?utf-8?B?S0tVMTNMRVlrTEg5MWJGRkJBUUQwSjJEcm9EY0FCZkJlTERLdXpYV05qZWZw?=
 =?utf-8?B?Q3U4UXNIL0FGdkt4Rk1qbU5uU3JLMlNzOHhLbUZjZkVsTXBBbDNoK1NvNXU2?=
 =?utf-8?B?aFdhcW9aNHhpY0oxMDNqakJlTXFKeFVEbXlxdmlHcFJMZTF6WlJ2c0JIOWVh?=
 =?utf-8?B?cGYzeml0M2FSY3YySncvWmVEZEtiRUpOV0pNVDlLZ0twOEM3anBJTkh4WDVK?=
 =?utf-8?B?TEtZR1RzZFYzRC92N1Z2NjV2anFheUdsYlk0N3RpZGVveTcxaGd4elhGVkVy?=
 =?utf-8?B?NjJMVFFKNkE2emgrOGtUVEpkUzVhWEk3ZmlFNi9lOVRwc2IvdkJMSFd2ZFhR?=
 =?utf-8?B?Tkh1RkFyVnd5MUFuR051MHd2eFhEQVlYdEhMTmV4SEo5WTBqcmpYbSs4V1hK?=
 =?utf-8?B?bVViU0lhTjcwalUxTGQvMExCcGphdXd0aHFRdlp4eHFOQ2puaHRpNmtJUTJB?=
 =?utf-8?B?VVVNT0lIaUVhRktUdlRMNHR5NWRNeHJ1RVp0cFZpTHY0am5oMWZYKzNrbDNu?=
 =?utf-8?B?UjVmSUMvTU9QVktSNExRK1NZZ3JrZW5CNjlGNjN0YzZGNWx2N2FFZjMxZ3RX?=
 =?utf-8?B?emN5RnhMcHkwTjg3Mzc3cUhtVmMxc2gvL1hpRzRSbHBNV2FpTWlaenl4NDk5?=
 =?utf-8?B?V3dUZ3VPY0E3SE1EWnB4QUw3Z1pKVzhUaUpCaFkrRmt3WEd4UDN4OTVzaFhu?=
 =?utf-8?B?N01wNlhwNzJvdjBaTjdyVU9qSTdSbkJ2MHBiMTdOZGJmaTR6NVlHa3NjMVQz?=
 =?utf-8?B?a2pZVE1NbWxaVi9MejBTSjBkNHFDcHRXRDVMWjI2QjkwbW5qbzk3SWF4aEtw?=
 =?utf-8?B?UEE3L0hQbnJQWmtRRXBtbmE2OEhBLzJOU3BLRUpBQU02bHRuOW1kcVJJY2g4?=
 =?utf-8?B?RnN0UlF0R202cTFtMGYrQjVuRktYSDVxREhkWkY0TjBsMVdmSkE1WnN4aGoy?=
 =?utf-8?B?YlhZdTAyR1VNWVR2dEFrYWhyYnB2L21lcnhkRUh5QUYzRGRPOTVUbGxpcTF3?=
 =?utf-8?B?V2FSczBDaVFEa3VWa0xacy9nMTd3OHFQTnBqelV2SUVQQzBjdXo3VUNxN2to?=
 =?utf-8?B?Mi8wYWhmK1lDY3N2K051WHBmdFZOQVMyWWNHNDBFTXEwTHBVdUNXaHEwa2Mz?=
 =?utf-8?B?WEpxYVRJc3JtdWZISFI5UVpvVjVJK3RYUjlzTEdDS3p4b0xGdDJuS0NsTGN5?=
 =?utf-8?Q?+jeUT/n3VzcQsMZaOqwEl844i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9c3310-e2cd-4fed-3a4c-08db70ebccff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 17:37:06.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o58AUm4DG0fQgGWRTdTRl0nGu+MkXzVCy3jk977pD+JKTY2wQtkWKcRT/ZCWAU6/MsCZ1ooZfERnJOdEXKE/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/19/2023 12:31 PM, Wyes Karny wrote:
> Hi Mario,
>
> On 18 Jun 20:58, Mario Limonciello wrote:
>> On 6/16/23 07:06, Wyes Karny wrote:
>>> amd-pstate active mode driver name is "amd-pstate-epp".  Add this to the
>>> string matching condition to recognise amd-pstate active mode driver.
>>>
>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>>> ---
>>>    tools/power/cpupower/utils/helpers/misc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
>>> index 9547b29254a7..21f653cd472c 100644
>>> --- a/tools/power/cpupower/utils/helpers/misc.c
>>> +++ b/tools/power/cpupower/utils/helpers/misc.c
>>> @@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
>>>    	if (!driver)
>>>    		return ret;
>>> -	if (!strcmp(driver, "amd-pstate"))
>>> +	if (!strcmp(driver, "amd-pstate") || !strcmp(driver, "amd-pstate-epp"))
>> To avoid getting caught in the case that a kernel didn't have the patch
>> separated from this series (for example if a distro missed it in a backport
>> from separate directories), how about using strncmp() instead and just look
>> for the prefix?
> Sure, I'll update the patch.
> I'm thinking of using strncmp(driver, "amd", 3), because in the above
> case the epp driver would be "amd_pstate_epp" therefore common prefix is
> only "amd".
>
> Thanks,
> Wyes
Sounds good, thanks!
>> This would also let the tool be more future proofed in the case another
>> amd-pstate driver was introduced later down the road as long as it stuck to
>> "amd-pstate*"
>>
>>>    		ret = true;
>>>    	cpufreq_put_driver(driver);
