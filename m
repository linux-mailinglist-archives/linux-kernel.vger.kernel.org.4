Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08E467281B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjARTXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjARTXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:23:42 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11EF53E50;
        Wed, 18 Jan 2023 11:23:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiPsWdERAnH4ealY6pAwKsZcZ/qm6E10d7XPgqa79YHYqh1H/I+XCzJ2xSr/BDxNvDQdWKmFIZZ5yg4zDl2JZlIfK6eiH8IwQ+rfAWoYNdn1N1JWJKwV9yGECsZQVSnk8MV5rqIXROrn5Vh3tEPQ992Fj6oQI/9tgGqWme4iGP4/8raUwrxo3W+oUFDheSL7sfA+X7/F1AaNnG+x6N/mMmiM6/wDGgceCQi0KJEVkZVmzeJ5LBNtU5CYD6odrfzNNrdu3amN9xeW+CKFtJY8eeFTDtTvdttE7kj2JKaYY29oQLV7pHL69aCmk26jDJijs0oEAxG6Zr9p+M7/AnMJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLUzAN3mCn7ZZYACXcDtHF7Qg6xTBjh2QbzB30Yr81c=;
 b=oLSImNgqFPLIqgrf5NIceGpdW0iAnTl9VhcEdz7KJjWXgEl7uMBjiAJ0iRTdtFvX+w5EJpjOfWgUHvyEg8zVUpR0aDwrvEnrK9r/f756qRQH+PrBadYJWv26fLpLQSUdzyXiFk6K3sSx+I2beTh+vCILapd/pHXRlqxKtXUBR6ulEshMxcBZqCmKClKE6EvKIxL46wEAU2IfyZWqSGLorEktP6weUoXotgiYjDTM4jqlNqJa2CQXjrHeQq8udHtMOb6Zb9yUXRrzH9teIGVVCICBGJX0KzlwbXvXmZobzMgDdSD4EBb7Tu6ZdBp2KzBE6bbN62HcJd0XmZczoCusyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLUzAN3mCn7ZZYACXcDtHF7Qg6xTBjh2QbzB30Yr81c=;
 b=vGRrcdGuv5ibUrCRPD/qFpuG3sxwmCct88UTL1NLx7XVBfJSqIbLH2IXr50XnOk6BZAl9DPiiX2YeViGf9iVlJiCeE3SofMBVcJIFP1SRHCMDv85lHzKtBUO0HxzNcI7CsGPQSA2KBzr1hW3s1kJx0DCzkqaUAYE/qExlkfsBaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 19:23:36 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 19:23:36 +0000
Message-ID: <b7c5d9ba-f5c4-48ff-a65c-da7d7d8d8b32@amd.com>
Date:   Wed, 18 Jan 2023 11:23:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <6f43e320-b533-e5fb-3886-1b6ccc7f9548@linaro.org>
 <b79f7e0a-8048-d0e1-ad0b-d15d72288fde@amd.com>
 <9f4994de-e468-43ea-f8db-d4a37ebc30e0@linaro.org>
 <980d9c9c-3dbf-3ebd-28a1-5b3b4b58e93e@amd.com>
 <96081a96-e74c-8165-c0e6-212a670c9074@linaro.org>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <96081a96-e74c-8165-c0e6-212a670c9074@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CH2PR12MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8674cf5e-ff10-4e1a-4777-08daf9897f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WlF5oYsdeGeBioAMnmY/GIdO8GmAbuS+AEU1eCkqD9rL07S6Nr9XvG786OFs32erYCZryHtpHcfCJwsWCBLuqxzFIzOwjb23zJZDnwB46+eei72MwBkeanQMQeSKFbADHmL4Rw5wmJmRhzTgd26F1CXZJuiVHwFdPdt/Ce3ZR5mM3B9kNiu/WUO/zw/8jFHGYMnSkCDu69DOZoaNftCmLKBFg8QJTIyK25h4W1oR71yta4sEnqV9SQzDwsH6eytYruXxthw64vmUkIaDLr+CzUtpQsJGxr0pvB4KNga4/fI27IuV89byNrJzMrfa/helQ7ld3YdFiRT3mUl/i5M240h6bG5uWKAvq6KpNm1ySLxpYnZWR5yLwfJ4FMvtKFboe3YqU05kaXuELWU9QyDImKTqXtHK3P9NDRwi2ZaVt2HIpgJ0x3gpJa7se88xmXP0ufWT6aoWNfphFZAr8v6/8vqEfsXLyEHv+zNrlAJIrFSdMqQ5BlpBq2sGrvUfY956QjUH0tHtDDdxOfcoF3oEVA2G9qzZAJTjOjLXsK8OR1jpPw+Wf5PQ1j1HUiTqyaeHF+Ij05mW63LfaSnE/EEYmlWdQNlT8H4l+CJ+9bYJfTOt+nyNuIfRsLhJOEARzC+bqWIdoD/8K5KAUKpKK/R0TSIEF8GlNJwE1UepP57DLxXnKKbSCW+HuPp8PmVGl+WlFBXvyus2zXkzRXupBj00qDI3lVQz9rmLR+TUdKHzdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(38100700002)(31696002)(6486002)(36756003)(316002)(66556008)(6512007)(66946007)(4326008)(186003)(8676002)(66476007)(478600001)(31686004)(2616005)(110136005)(53546011)(5660300002)(6506007)(41300700001)(8936002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFrd2JvUmNOMFNPQzNJbWR2OFpMYzBxWVpzOFI4bFAvaGxsNzRWMVFYNmUw?=
 =?utf-8?B?d1ZQWm1XQllQWjU0MTFMU2RXU3luM1h5bUVWc2ROOXIxNDZueXczcFlhdkZn?=
 =?utf-8?B?dGhSZVFMc0JnRkgrcUtyYTRWM3pOMm5OUzVzSHl2SW02dS84MDB0WDBzbGhM?=
 =?utf-8?B?VGxGaVU3ampseGE0VVBVUkthM05hazY0S3NYS0NaalErd1Q4Wk1KT2JpNFRU?=
 =?utf-8?B?b3d6MzJRVnV4WTIwYzBtb1owb2lxaTlSaWxVWllUTHN5UHdNNnUwQVRlK2NK?=
 =?utf-8?B?akdtYndubUIwN2tiMldPSmNzUjNodnlFa0RlYk1mcS9ydGV2WSthYVdETE9J?=
 =?utf-8?B?bnJQNFpjN2pOQ0pEcDJuVVRtdU1PTVZZaWVJR2xzY3RrdGdrakIzQWJHVy92?=
 =?utf-8?B?SDJ3N085b2tLdEM4TTA2cldlWWhucXJuOXlHbDRDQWRyZm12SzFTMkMwazhq?=
 =?utf-8?B?WlJFQXFKTjk3M0RMb1g4WEkzUkJCYjFtekhiYjJoRXhzT3Ntc0M3U09uZ3Rz?=
 =?utf-8?B?Mmx2YjNQcCtDZEx0UWJUNjBSTmpObW9sZHlLN2hhdUNodWZHaEIyK3FpRm9W?=
 =?utf-8?B?b21ZbjRmQ2ovUGZRbjdoYTlVSHNqeFlSajVyZ3ZLRVExcWx6azdlTSs5ZVdQ?=
 =?utf-8?B?ZG51eGdkZ20rVnIzc3BPNDEwSUVEVExUMTdBbnBFL09zWEsxcU51UDNDRUxy?=
 =?utf-8?B?MTVCU1ZFM1lxODRkNzYzNGM3MmMzbnFsV0o2b25KSUZtZmwxY1phaVYrZW5W?=
 =?utf-8?B?blBRVVgvK1FRdUlJbzlldXB6bUd1bm05NXp0T0QrbDJ5VGZUS2VjQ0RsRWhJ?=
 =?utf-8?B?MFd0dHhzNU8rVXpqKytTRG5obVNxSG1CL29qcGhrUHpLTU5LTDBlV0tZWmRn?=
 =?utf-8?B?WVhwSVhYVmdOQXBYa1hKSWkyeURFaFJ4RUlHQWg5aksvNGZuVlVwMXpjVHY3?=
 =?utf-8?B?dTNFU1FnZ1B5dkpRUEwyaHpoditnY3A2Um5NVzFXZ0F1YzFpNkJXb1gyTGRR?=
 =?utf-8?B?anBSME5EeGZDOGxYek4vbWNJcVg1ME1hODZuSnNmd0puem1LalByUmlSd1JW?=
 =?utf-8?B?azMzSDloaGJ4VUlwUTg4dmpuYXFxUFNQOWNveFJsRkZlVmdoVmhiczhLVGlr?=
 =?utf-8?B?L2FFK0dPRDVhemVHNHhnVzdyeXV0TlJGRTc3dUFjSnhya2NBL3ZmTWdlb2Rl?=
 =?utf-8?B?WU9IaHo0SElKUTlPMVZyREo0WlJmZGIwdEdJRCtLcVpVaEVSVTV6K1NCL1Fr?=
 =?utf-8?B?cFRDVWowY3BsTUI1T3pkOFhyMVArZWptVXJEdWdnVUhCL1A2eWpBQWFZWUF0?=
 =?utf-8?B?MWQ2dG9rckFaUnh6enkrTWMwVGc1YThsVkpVZmErbktHdThKYUp5VmFGQkJC?=
 =?utf-8?B?R1hHWDlNeUlEU2g1bHNQNHBSQncwVFlFQWJoZnNMcVhJYjVSMytpWS9vL1A5?=
 =?utf-8?B?MzVhOE1qcUQvTU5JZ0pHRDVBZVhGUkVBamRMalUwUFJObEVHb21oUlROVTY5?=
 =?utf-8?B?bW5OZlBXc0gvYnNZRy9aWW5ZckRmaXRtQ3p6WFk4SWoyNm5SdHBHYVpsb0xG?=
 =?utf-8?B?U1RaeExLak1PMFJnMjI3TkkvT3JSYXZLUTZQb08vMVdaSitFQmJNUmt1RWg4?=
 =?utf-8?B?eURiMzhnT0JJMmRhYjBIQXFMdTRUTXg2R2tpK1FFOU1rbmphK3paVDdtTE5B?=
 =?utf-8?B?S3BOQVU3SnFHNld2QThja2dyWkFxeVZzQTJWQ2NvVG9rNG13a0t6ZjlYaGty?=
 =?utf-8?B?UTFyVzNYUTJGRXI2b3Z1ekd1YWhpa1VjRlRZTEpwUWpGdmt0QWtEQXM1NDVl?=
 =?utf-8?B?SnRReFd1bXRBUTk3ekxoMTFYQXVIVjArNTNtTU8vZFVPZ2dSQjh0RCtiQ2k1?=
 =?utf-8?B?WFMzR3NMVEMxVVdsV0IwUjNvRkVHS2t2WTk3aDJDbk10eHlPQ3d6aHFGQ2pV?=
 =?utf-8?B?QmdsNURTb3psT3lJQmxpelhvQkhxU0x0U2doT2NBaVhuMENRMzR1azEzbGtV?=
 =?utf-8?B?TmkveWNneFVPYk45T1BuZWtsclNCcFNYOWxUdThYSGZ6OG1VRDhpb0Y3M2lw?=
 =?utf-8?B?bWV4NGwwVjFkbnRmN3VMSmJ1RmI0ZUtlM0l1TVhVUVJGS2kwbzdPVzBRdHFh?=
 =?utf-8?B?ZGRaaXRvTjQ2L3drNTJ3SkVIbXpFNndzQVJid09iOVlxc0JxODZFZXRnelQ2?=
 =?utf-8?Q?K6bO8ugUu4tqfC1gP7sWw+SIwIBKOdFv40KxygrCHkH4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8674cf5e-ff10-4e1a-4777-08daf9897f0f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:23:36.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAL7FMXnXzikiCrKi2iuRbZ+NarXEgFUSR3KqqWCHvdV/w2mNtZk0ms+SZDKGbFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/23 12:16 AM, Krzysztof Kozlowski wrote:
> On 16/01/2023 18:43, Tanmay Shah wrote:
>> On 1/15/23 6:38 AM, Krzysztof Kozlowski wrote:
>>> On 13/01/2023 19:08, Tanmay Shah wrote:
>>>> On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
>>>>> On 13/01/2023 08:30, Tanmay Shah wrote:
>>>>>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>>>>>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>>>>>> driver. This bindings will help in defining TCM in device-tree and
>>>>>> make it's access platform agnostic and data-driven from the driver.
>>>>>>
>>>>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>>>>> prefix is already stating that these are bindings.
>>>> Ack.
>>>>
>>>>
>>>>> Where is driver or DTS? Are you now adding a dead binding without users?
>>>> TCM is used by drivers/remoteproc/xlnx_r5_remoteproc.c driver. Howerver,
>>>> we have hardcode addresses in TCM as bindings are not available yet.
>>> I don't see usage of these compatibles there. You also did not supply
>>> DTS here. Please provide users of bindings within the same patchset.
>>
>> ACK. I will supply dts as well.
>>
>> However, Is it ok if I convert this patch to RFC patch, and once
>> bindings are fixed I will send actual patch with driver support.
>>
>> If bindings design is not correct then I might have to change
>> corresponding driver design lot.
> First, why this driver is particularly special? Why should have other
> treatment then all other cases?


It's not different than others and shouldn't be treated differently. I 
just didn't know correct bindings representation.

Now I have some idea how this should be represented, so I will send 
bindings patch, dts patch and driver patch all in same series.


>
> Second, so think about bindings and do not submit something for "driver"
> but something describing hardware.


ACK. It will take me some time to post next patch, as I will add support 
of this tcm device in xlnx remoteproc driver as well.

Thanks for all your suggestions, they were helpful.


>
> Best regards,
> Krzysztof
>
