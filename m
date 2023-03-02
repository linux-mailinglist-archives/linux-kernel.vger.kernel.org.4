Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0E6A79AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCBCuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:50:50 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432341B2D2;
        Wed,  1 Mar 2023 18:50:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX3Yn7Ho4dfEIrAA3IxT1C2RJTPPEy9NU/s29jTb/NdaF7BiwN9QvMcTbZMhiDFJlaQ0672sQcDq8vqM5rNvdh07ilQnDyXxPFPzwtFjVhLqxckxNNvsAWgIqyTEo2xvnFYpho6GkUhtk8M6q6p2orQHoFVx30R93XjhqQOvMSCALVWzvsvO2XCs4mINTlLXWxLxjryVIIR5Aph6tVVF6YURi88AJnTEr9ILVjjkvjcwOI+7biK2fa0f/U+wK7Z+ZLooExHRt8Jx1UU4eMfSg3LZsFeiDbyri4unVmGvx1X0oZt7mw9J+sdRaoa+HoSRBn4SOqkQkLqAy7hnnbAsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggSbuLBlRAPkx+4YxZGrsIAGc8fSdGmZ6GkiPmY0fWs=;
 b=PBTb43YsXOqc1WOTChYmwQXj8QSbPUOcn7bIfbsjZSn/UQlvqo1Xz4m5ZxUnvEwSjqNXodOdwEJSXgehIv1M2guUKy9DNTUIX8cJlyfpDwfe0pKEBrXm2pRQE/W1mIArk0m3m+cxYrUTT696KpPp0ScoQKeILSEBWHl+TUT52FEc+cfz/tCzY0LI0Lmkd1VILif+OfV/5D+qtA83JtwUEbgWRsYK3wwGnruuSOYgPb0fgS6WyYNugc+SAh/az+HlV3+EkgwR/gdcdOw/1n3LfalXua+67wN5YbRsykulpfYna+TB4/z9DJcjBUvmhQa7JwSbLbPxclpIMFBaXMUrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggSbuLBlRAPkx+4YxZGrsIAGc8fSdGmZ6GkiPmY0fWs=;
 b=rDxj4Pp6Swqbwl0zsXTzDkTveJsuul1FJm1qxXOdiFRHPvyFds27zOWUiiRgk+h9mN6xenS62BRHud1+mGEpVYjmHNzD+ABerMb8/a0/q1aC43ngSkEP+12P89fjXU9mR1cbIExSfWIVqc4soRw8yIYOlxh5BpRSJ1pPkRw1p3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 02:50:46 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::8db1:ed03:e196:be2e]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::8db1:ed03:e196:be2e%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 02:50:46 +0000
Message-ID: <eeda1f38-0dd7-7439-5e77-db1a411e995f@amd.com>
Date:   Thu, 2 Mar 2023 08:20:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230301150821.9791-1-mario.limonciello@amd.com>
 <846d6f46-07ab-4d4a-5623-417a469c3d0b@redhat.com>
 <MN0PR12MB6101781FC5089EA217CA48A9E2AD9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <e4a8f2ef-d6bf-1b14-ddaf-057fcd5abf11@amd.com>
 <727bdbb5-50cd-aebc-72e4-5849ae2c6f3f@amd.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <727bdbb5-50cd-aebc-72e4-5849ae2c6f3f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BL1PR12MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e13763-d3d2-4adb-a63b-08db1ac8ebed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TMj6Lk50Zb3DDpeb1enm7ndNiWxO8Tm82cV91GHrbQFjPRVodAN07AVFGvsm9SDm9aXlFs5SL3gh4Bd9Gy/vkuFYSb3JfVXgqeVjCBzLN1nSPd5gXF346vDYul9urwSCHvrCX1ecAuE0w+eQHF7O2r22kBH4wTCpcc8VEsVZmDUuHTFU2OvIkkhSdfLL/9bJWtywr+EwFDJKWAm0t3miV3e05Hj7zV4kw1XHfrxeiJWHnvNZ0G6Ar/DG0F5qdKdfezruCxeRqQOQOl65/7nkeBG5D/B+j9dZnwM5OmBCm0ZAZH73bmoYceOvyOEZOxiaNJmD+YPhJCF8Cr586IvwHy2ENxPwrEIRu/RtBvaw/aPlK2A5JMV81zsC9KhsWgmYnAvmbqNjjYBeRtEmcW6NPK7uIAPIC0X4FmrV+3zGQtSCnHBCn4DUqSICziXkyxe53xzOTNgTSr6zDnZo6TogR6hCaIELUQo9n6cHxfqXXGTSUjSHRWn3nYXPxb17w28uYrA7IwLmGOW4uegYat2RTPV+JON9SHxqNsVo+t+aJKX0O+mGwd8NIPVJS8kNjepOsUJP9aQkgGsxxrASRP7wYynaZQ9qiCsjAe/tqypUjpX+WE0a/34GUvJtS+Xla/0D18Z69bjU4XZhDyAyR+xM7J3sw3tsVEAR9qeItD0JcDekmwXYNoWy5g8TAmv4k4c0i95lO24KcUPiswzvrFnsRaivRFyI1w4PvlN4HPy3Rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199018)(31686004)(5660300002)(36756003)(4326008)(41300700001)(83380400001)(2616005)(316002)(66946007)(2906002)(66476007)(8676002)(66556008)(8936002)(6486002)(38100700002)(186003)(26005)(53546011)(6506007)(6512007)(6666004)(31696002)(478600001)(86362001)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJCb2pHS2pJQTgyQndyZ2F1OWYxNlZ2Q1ZRTkxidktYV1hhRzBIVkY4VXJX?=
 =?utf-8?B?bVM3R0xuR0RmVEd0QXpuU010b0NIWVlOLzNBTmtqZWc4V2RwdUZJY1NlRzF2?=
 =?utf-8?B?cnBIZUJ2TG5QWUE1ZmhnU1ZHdmRpWEpnUU1MSWVaSVc2MFJLMnhyVEpES0h2?=
 =?utf-8?B?bi85NHdWWndjR1Z3K2JSbE10MlBhSVYwRnRoUHlrY2M4TjBmWnpDOHZ5VVlN?=
 =?utf-8?B?RlFIcDVaWW5NS0dIUVNUWUtBcG1DQ3VISllKandUU0IrSzFZSkQyM2trZDZH?=
 =?utf-8?B?endEeDZ5OCsrTlVZVnh6ZktBYkxWMGZhaDJlUDRMYUFRdVFCa0dRbWd2U2xt?=
 =?utf-8?B?TW9zUEMvSHFvNWtrdDBMOFAralhaUXFNbkZBb011R3BOTHhrdmQxVythaEdK?=
 =?utf-8?B?Q2crVUV6aGd3Z29scXZMaS9Ra1Q0ZWVCdTgrcTBDblBXb0krY2RPbmdXN05r?=
 =?utf-8?B?ZGk0VzhYcWI4aWtpNXhFUXluTzA2UFdvMzNGd1pYNHhxSWNrZnVkbFpKbW1l?=
 =?utf-8?B?cWszeDhtdEdBNy84dEsvTldwTnc0UEFOQ1pPRXB0Tk1sM0QzUWV6SmFrTHVS?=
 =?utf-8?B?VDV4dnZqaFY5RVJqMHRRalR3VUdZU3c5NlBXQTg3eGNOY2hLTXM3NHN2YnMw?=
 =?utf-8?B?Y0sxclppY1RBSGFSNCtXeUZpZmJxTWZ3aGZadmRHTGQrYnpaT2FkcitVeFNL?=
 =?utf-8?B?Y25Pem82NjNqR25BVVpkTUZtODg4VHd3SVl2L1R6bTVpYVREN0s3Q2RyQVk4?=
 =?utf-8?B?VVF5aWpHellQSzJKU3dTWVpoTlFTY2VROU5XcWNBcGJHLzJKN1Fmb0QxU1g4?=
 =?utf-8?B?dTRRWVUxcnBJYThoR2dKNFBPc1dEUXpkQTZXS0ErcW9EMXdMSXkybnRROFdv?=
 =?utf-8?B?eWQ2Y3ZqVXZGNzEzWXZiVVRoQ3ZQTmFhN3BmSTNwa2pGcmlQYmdYc3R2dFFx?=
 =?utf-8?B?MHJ6ZUpCV2FQUHFDVFQ2ZGQ2SzY2ZHNSNlk5alpQV3cyT016ZlAreUlxNkkv?=
 =?utf-8?B?S1hSMVFEdnd2cWxiVy9ublRZQnFvNFpWQWtJbXR4b21kcFhFR2Q4NmdTb1dl?=
 =?utf-8?B?bTMwS1ZCMFZPNHNjczBhRmlaS3h5NjBFMWI4dUM4dVA5NGhraThxWTJ3VW44?=
 =?utf-8?B?SlMrVkxVSlV2N2cxeXhuaDJPNkYrcFNrVXVyT0pVWm9CbGRBdTNMVkhtTVRj?=
 =?utf-8?B?QmRRbk00dEM0Z2hUb0EwTm1WSFNNYTBpbHM2aWNxNlgybm1ZdXZUMWw1RGN5?=
 =?utf-8?B?R05CRkJRQjllVElwU2gwMEoxbmxncXAxaTJjNlMxN0VWRUsvTjhDV0FUQTVJ?=
 =?utf-8?B?NUtDV1llWE1Ha0F3RDJOOTBMV0hjMzBBYk9QenJCUENsdDVZTk5VaGtScDMr?=
 =?utf-8?B?R1k4L2VlNVAzTDI3NWlsM3hUcFBxdHBqazRyR2orNURxZG5kaklGaTFGU3NH?=
 =?utf-8?B?RllYd0J5aVdQNkp4MUczN3YwcUZDRDE2dUVockZTQVBtKzFkYm9BTW1RRmVZ?=
 =?utf-8?B?a2U0c1I2Wks0U09Zd1JBUm5HcXZ6NkhjbkovL1FkUEpBT1R6Y1lNcTQ0SHlr?=
 =?utf-8?B?OUFXN0dxcmU1QkpmSXMxbFBWU1ZiRjZZMGY1T2tMYzUyb0dWc1F2VXdwZTF6?=
 =?utf-8?B?SGl1S0lKMmhTejdQNjhxbE5WYmRobjUyZjhVZE0rR2ppQTB6d0xZOVpsSWZ2?=
 =?utf-8?B?NjI4dEJ5bzN0WVlKL1RHSDQ4VDBQNEFzLzAzcHF0cmNlb0JVbVEwMXc1R2dX?=
 =?utf-8?B?NlM0UmMzdFpWL2wzL0RFcXBoRy9kMEZSUWxXbFdXRUVwMjdVZ3M3bXFQZ2JN?=
 =?utf-8?B?bG8wemVWaW5QaXVMR1pHWS9Da0ozNHdsc0FGQ2xXdCtKZ1NxK2JMQ2twcTRX?=
 =?utf-8?B?MklaTS9BYmZEd0dORyt1R0lCVnEwb3BqekdEcFNuSi9URjhFc3UxNUxSbjd1?=
 =?utf-8?B?M1FiQWs1M1FGdVpaUm14dHR6cXU3MHNFK2c0QnliSXdsUG90QXJxcG5ydUxj?=
 =?utf-8?B?N001bjY0bUhJT01sNURXbGpEYm5rUEdjNFZjNnM5SkpEQU9ZVStJaG04Q01z?=
 =?utf-8?B?b2F3S3ZYQ25DUG1laUxXWGRwTjNMeENKM2dCcmlSMWJ4c2svUEcwbjh5TXZV?=
 =?utf-8?Q?oFbnUR7S5QCIvHmphDNmOp6gj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e13763-d3d2-4adb-a63b-08db1ac8ebed
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 02:50:46.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWV4jZXFKsxtMvs+znTLHwjXbiNBgZGl/2dcBZ/hb+InnrLvlilC0Ll1txn6OZDf5oRvVTUHhKoC78AqLM0l6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/2023 8:12 AM, Mario Limonciello wrote:
> On 3/1/23 20:39, Shyam Sundar S K wrote:
>> Hi Mario,
>>
>> On 3/1/2023 9:01 PM, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>> Sent: Wednesday, March 1, 2023 09:28
>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>>>> <Shyam-sundar.S-k@amd.com>
>>>> Cc: Mark Gross <markgross@kernel.org>; platform-driver-
>>>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for
>>>> checking
>>>> minimum SMU version
>>>>
>>>> Hi,
>>>>
>>>> On 3/1/23 16:08, Mario Limonciello wrote:
>>>>> In a few locations there is some boilerplate code for checking
>>>>> minimum SMU version.  Switch this to a helper for this check.
>>>>>
>>>>> No intended functional changes.
>>>>>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>   drivers/platform/x86/amd/pmc.c | 49
>>>>> +++++++++++++++++-----------------
>>>>>   1 file changed, 24 insertions(+), 25 deletions(-)
>>>>>
>>>>> diff --git a/drivers/platform/x86/amd/pmc.c
>>>> b/drivers/platform/x86/amd/pmc.c
>>>>> index 2edaae04a691..c42fa47381c3 100644
>>>>> --- a/drivers/platform/x86/amd/pmc.c
>>>>> +++ b/drivers/platform/x86/amd/pmc.c
>>>>> @@ -418,6 +418,22 @@ static int amd_pmc_get_smu_version(struct
>>>> amd_pmc_dev *dev)
>>>>>       return 0;
>>>>>   }
>>>>>
>>>>> +static bool amd_pmc_verify_min_version(struct amd_pmc_dev *pdev,
>>>> int major, int minor)
>>>>> +{
>>>>> +    if (!pdev->major) {
>>>>> +        int rc = amd_pmc_get_smu_version(pdev);
>>>>> +
>>>>> +        if (rc) {
>>>>> +            dev_warn(pdev->dev, "failed to read SMU version:
>>>> %d\n", rc);
>>>>> +            return false;
>>>>> +        }
>>>>> +    }
>>>>> +    if (pdev->major > major)
>>>>> +        return true;
>>>>> +
>>>>> +    return pdev->major == major && pdev->minor >= minor;
>>>>> +}
>>>>> +
>>>>>   static ssize_t smu_fw_version_show(struct device *d, struct
>>>> device_attribute *attr,
>>>>>                      char *buf)
>>>>>   {
>>>>> @@ -526,14 +542,7 @@ static int amd_pmc_idlemask_show(struct seq_file
>>>> *s, void *unused)
>>>>>       struct amd_pmc_dev *dev = s->private;
>>>>>       int rc;
>>>>>
>>>>> -    /* we haven't yet read SMU version */
>>>>> -    if (!dev->major) {
>>>>> -        rc = amd_pmc_get_smu_version(dev);
>>>>> -        if (rc)
>>>>> -            return rc;
>>>>> -    }
>>>>> -
>>>>> -    if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
>>>>
>>>> The 2 major checks here originally were not in sync, so for major == 55
>>>> *and* major == 56 it would only succeed if minor >= 37.
>>>>
>>>> Where as after this patch for major == 56 it will now always succeed.
>>>>
>>>> This feels like a bug in the original code, but might have been
>>>> intentional ? Please verify this.
>>>
>>> @S-k, Shyam-sundar as the original author of that, can you please
>>> confirm?
>>
>> I cannot completely recall :-) It was something like if the major
>> version is greater than 56, there is no need to check the other part of
>> the "OR".
>>
>> which is kind of similar to what you are now doing in
>> amd_pmc_verify_min_version().
> 
> OK yeah, then I'll split this correction of the logic off to that in a
> separate patch to make this one "really no intended functional changes".
> 
>>
>> Like we discussed off-list, we should have this boilerplate in place, so
>> that the future checks would not be duplicated.
> 
> Something else I noticed that we probably need to consider is that there
> is no examination for the "program" version which may be important.
> 
> We don't have any version checks for YC, but if we did for example YC A0
> and YC B0 use program "0" or program "4" respectively so version checks
> could fall over.

Checking for "program" version may not be required as A0/B0 are never
meant for production and IMO its a logical overhead.

Do you have a specific case, were you felt the real usage of "program"
version?

> 
> I'll add something like this in for v2 of the patch as well.
> 
>>
>> Thanks,
>> Shyam
>>
>>>
>>>>
>>>> After verifying please post a v2 updating the commit message to
>>>> point out this functional change.
>>>>
>>>
>>> Sure, thanks.
>>>
>>>>> +    if (amd_pmc_verify_min_version(dev, 55, 37)) {
>>>>>           rc = amd_pmc_idlemask_read(dev, NULL, s);
>>>>>           if (rc)
>>>>>               return rc;
>>>>> @@ -686,15 +695,8 @@ static int amd_pmc_get_os_hint(struct
>>>> amd_pmc_dev *dev)
>>>>>   static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>>>>   {
>>>>>       struct device *d;
>>>>> -    int rc;
>>>>>
>>>>> -    if (!pdev->major) {
>>>>> -        rc = amd_pmc_get_smu_version(pdev);
>>>>> -        if (rc)
>>>>> -            return rc;
>>>>> -    }
>>>>> -
>>>>> -    if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
>>>>> +    if (amd_pmc_verify_min_version(pdev, 64, 66))
>>>>>           return 0;
>>>>>
>>>>>       d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
>>>>> @@ -718,14 +720,10 @@ static int amd_pmc_verify_czn_rtc(struct
>>>> amd_pmc_dev *pdev, u32 *arg)
>>>>>       struct rtc_time tm;
>>>>>       int rc;
>>>>>
>>>>> -    /* we haven't yet read SMU version */
>>>>> -    if (!pdev->major) {
>>>>> -        rc = amd_pmc_get_smu_version(pdev);
>>>>> -        if (rc)
>>>>> -            return rc;
>>>>> -    }
>>>>> +    if (disable_workarounds)
>>>>> +        return 0;
>>>>>
>>>>> -    if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
>>>>> +    if (!amd_pmc_verify_min_version(pdev, 64, 53))
>>>>>           return 0;
>>>>>
>>>>>       rtc_device = rtc_class_open("rtc0");
>>>>> @@ -772,13 +770,14 @@ static void amd_pmc_s2idle_prepare(void)
>>>>>       /* Reset and Start SMU logging - to monitor the s0i3 stats */
>>>>>       amd_pmc_setup_smu_logging(pdev);
>>>>>
>>>>> -    /* Activate CZN specific platform bug workarounds */
>>>>> -    if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
>>>>> +    switch (pdev->cpu_id) {
>>>>> +    case AMD_CPU_ID_CZN:
>>>>>           rc = amd_pmc_verify_czn_rtc(pdev, &arg);
>>>>>           if (rc) {
>>>>>               dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
>>>>>               return;
>>>>>           }
>>>>> +        break;
>>>>>       }
>>>>>
>>>>>       msg = amd_pmc_get_os_hint(pdev);
>>>>
>>>>
>>>> Patch 2/2 looks good to me.
>>>>
>>>> Should I queue v2 (once posted) up as a fix for 6.3-rc#  ?
>>>
>>> Yes please.  If it makes it easier I can re-order the series so that
>>> we add a check in 1/2 and switch to the helper as 2/2.
>>>
>>> This might make it easier to take the LTS kernel too for stable,
>>> but I don't feel strongly.
>>>
>>>>
>>>> Regards,
>>>>
>>>> Hans
> 
