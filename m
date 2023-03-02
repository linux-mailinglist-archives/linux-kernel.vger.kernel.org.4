Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738F06A79B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCBCyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCBCyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:54:52 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DAF474F0;
        Wed,  1 Mar 2023 18:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTV6b9Tdf4wcTXkjriDpTDaZseoEjcdpPg0ajfiaTuRrpVjMb52ZBtrclff5FtAh6IPYiA/fhBEz67imtApAEJkzuzNPPjlQqahZ+JKaoj3dLsj/IAgNtgh1M09WaTB9ibbdtzw5d69zkwBC/4rzLsrIDvFjkt/iRihTYR8HVAy1y6x5d8n+Golmy5GlxOXyNsmARWLln7D3jJlxPLpqIIH0R1RGe1jPyJBwbklSHKi/k/7fjmkab1X8RUdBa3eiSWjqlE54crcMJze1iS+dziL4/tcisuvIeXF66b17rs4CUm8ZGl8c1MlAi+NdigxrVFiEJimZTwSDEQ+CqJonGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ8PvhovwCUIGOpaDyVD3KuR/G8p8aLcTJGblmZocRI=;
 b=BK81/Fbf99WTh6kVMlFJeofkllqJa8sviJRYXz+4HMJDbN/MGAlEtzIYNZ1jILbip+I8torewfQAm+Hjk/pUt9/SMv4JDV5ckEFwzBo4MYB19WiLZCbapSMhpf8cxZIiB92u5dm6qy9FVrcFtyJv4s+3SyTrZY2Xb9opt0DU9MvY+4kkQJJbjI8QcAtCUMo8fi7mE9F+H7wcs8GyJa9bbwn7G07q8q7svZ1sn1hlXgGv7LqXlUDLaD8kQUlOgGMn6r56N3iI20RE3EQ3zL6nP8WZ79XaR8kcMEsgLbpmPHLUKt/pfp9GVwstCFoyfNO4YeqLQq1sTp0b+fgBZyZTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ8PvhovwCUIGOpaDyVD3KuR/G8p8aLcTJGblmZocRI=;
 b=DLC1yyczdYbI1Dyze1HIPLBqiUZwlzHkLyDkZ+5UipjidjU+d/lJP9f9AByGxYP4W0hodzDcW1P1ivOZQIv4xELSVlEGUhmlJffjNfgOpg/bmlbVvNlxmkhKGEX6rb7HCXHSBW8lGrR7fIQRjOahnDSp8zIXhUAQBuMUWhdFrk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 02:54:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 02:54:44 +0000
Message-ID: <3eb98441-5343-7d43-69e7-30028c38b354@amd.com>
Date:   Wed, 1 Mar 2023 20:54:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
Content-Language: en-US
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
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
 <eeda1f38-0dd7-7439-5e77-db1a411e995f@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <eeda1f38-0dd7-7439-5e77-db1a411e995f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2398d66e-d38a-4664-815f-08db1ac97a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfDz+2aX6wqXJcFcvtiHTYl2ioynI7pokwo6zR+QlnJkE1Sy0igv9oSNJ8frWoTZoHMuQ5BEPqBp8gZIPt++ylRakyB/3F2/Kx0YpDKmsD98ShcYwIu3NMyMfDzt9gC5l8wbXpWWnOba/EAgsAcXPNytJxFw5DZ0FgRCMubHtPjd4Nxdtr+VVwKYbNSgM38ot9+B1LAFf9s62RGE7rpFRwQ8t4fr4KQpW6AoC1JgBTVFf41iwx642HfCi9EOS7XSHArFawtaaN7Wha5tNebmfOkox2WZw7/39yk5sauuL66ZDKUYz3afSfmDcLMX3O/qj0to182xnhxnI2AiINI8WTcmITbTxbWAyzIa5YlHz1V29q/yHPSeTc8deMV0CkxvO3BDoDJNeiBOz/8e4ic9W2t0XzEEkNEGZ2l6piUb9ddnZa8ag8+VKKjycHl3XrcSnJEqaLCZUpdJVj1B6ORKrvZpbN4dkFgpx/CI8T80ZFG+wnAIh3XBbCSslOJWbnM2mw0hsn4dZK+e0qrw7VQYU9zsTFXzSDbqPaP8nRcM0PehhkTBTFVh5kVOXLF4i/DvBV/ngn7Ze+LRXdBZlkI+GD+Rwq5UguivjhHzdcm/oUol4d5u+mXLok/E05E3f1CN5M+RMk+7Smimi5RXy9yE3da8u7jsdWpJUopsdG4KS7JFpePDItJQueK6dOpXw/IxjZzHVTOsrUFgd/cTg0w+LSwFwv52XawGcUHkrDa2ah0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199018)(31686004)(36756003)(478600001)(83380400001)(110136005)(54906003)(316002)(4326008)(8676002)(38100700002)(66476007)(2616005)(53546011)(6506007)(6666004)(6512007)(6486002)(66556008)(31696002)(5660300002)(66946007)(44832011)(8936002)(186003)(41300700001)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBtVjNKYTZpeDRaTlJ3N2oyRGhhRVg0Z2pKTzNGaUVPZFRCQ1BSbDFpL0hQ?=
 =?utf-8?B?MG4rWjdQcnpJU2xpTndFa2RQTkxLL2Ywdk0ybkxpd2tIbUNTeDM5bnRqZzdS?=
 =?utf-8?B?N1FOZ3M0ZHpxbUtnTGxPSkRBMjl3NHlWaXJaR045b2dRcjkxTXZ5ajFsdGY2?=
 =?utf-8?B?NGVqWk1pUTlNMXpQRWxhQTV0LzdkaXl1YlJsYzFYcU9BR1ZaOSs3QnNSUkY3?=
 =?utf-8?B?ZG8vSXd4bXgwd3p4NGE0L1hqcDFuWkhJMnZUN3BLZVE5RVgvdUlMekZEVnBk?=
 =?utf-8?B?cTVBaEhvWCtLd2ZreTg5U3NlSEhSZWhRZVdGR1FWK3dEV0NvT3Nrc05WMGRY?=
 =?utf-8?B?U0N2MXd3aWkvSy9MODRPT0Q4TnZIT3JFdFJYM3hJRzRmZmVIemhac21iMmtE?=
 =?utf-8?B?SU5RWkQ1Q1dOSVhFRFEzSXlqZFdEeGlyYkhLMytBTks3UjEwVG8yN054bGRK?=
 =?utf-8?B?MTFXVmtHU2RkVzl0WkRiL1lIZGZTN1dtS2YyZklGZU5SZ0NFbEdKaythd0hj?=
 =?utf-8?B?ZzZMYVNvVEZxNW5IUCszQWNDS2JNZXhzY1RqRitzQ01VRktsK1l2UlI5TWdq?=
 =?utf-8?B?SDM1aUNVNXhDRXVkY1BQVUdmL1hXcExlK0w4ZnJjeFB2S2cwWU04akFXYzJu?=
 =?utf-8?B?aTBSanBUZHJhS3IvTHV2NzY0V0hLaktQcUI5RVBudEY4UG55alowbUJuTjZl?=
 =?utf-8?B?d0FraTZ4ZzVKMWhuZUVMdFg5MmdPM3JyQWpuUmt5aEVNZkY5MXp5RHZZNlRl?=
 =?utf-8?B?TVZCcXB1c2hDU0ZzUnBBeVJoNVk2ZUxJS2NtSXY4TEE4Z2NmRGpHR2FCakw1?=
 =?utf-8?B?NVdTNytSTm5JZHVBdEZEb0V5TG5yUGJSLy9KMnNoZHU4Z2FlbUQ3OFFMajZa?=
 =?utf-8?B?d3ErK1pqNEg0cGdUcC8rd0JESkp2UWV4QWU3NUdUWG01VllFT3VKaVNORTJm?=
 =?utf-8?B?dUVWbzJNdFJmSW0zSThCNWFXdVRWeFJCNDN1Zi9NSXVESnZmN1M3bzIrNTZW?=
 =?utf-8?B?R1NiUTRRMU9aekJOY1lwNHVHMlB6M25CN1N5R0xCdnIrdVg3NDMzZW9LcGJy?=
 =?utf-8?B?dm5FUlpWZHhZYmhCYjU5YnJYWi85RVZYTUZDUkRFb0h1MHNyWG1SSWlOUUpH?=
 =?utf-8?B?RXhOMmpHcWhLamJGYzRaTDJidGxJNHNqWDVYY3pNVk9vanp0NzQ2RFREUGxS?=
 =?utf-8?B?V2JiRThkZUZkSytuVXFHUktZQng5cnc0QVlrUUJJOXFVY0FKU0Y1QWoxaEMv?=
 =?utf-8?B?M3BLanpWb0NJNlFDR1FYbTJKMWFFeFBzZHJUeTdJT3diQlRWbTlPMWh3S2dn?=
 =?utf-8?B?OTN1UjZLblY1ZytjTmt6NHV1bktoajB2ZWxCZ2dubG4veDltNVc2RnZvdTda?=
 =?utf-8?B?MVJuTm5EZm1iQ3dXbmlzUE9QMkxsK1ZDT295elhaM3F6S0JlWmRnSWxhS0lZ?=
 =?utf-8?B?c0QvSWdZbnlQRUZ2UEhNSEVlWVR4TmVRdGpBM3VRWkt2T09qcWVTY3FCclJj?=
 =?utf-8?B?STRlcE1kT2VMWGJ3WjNEL3dkalcvMWlEdjBielJsM0JBVllFVmJtOEdwOHNQ?=
 =?utf-8?B?SzhidWhKQjBoZHRMVzR2SmhVcUlUYlkrVjlQTFE2UjBmZy9nYjhoQjZIKzlh?=
 =?utf-8?B?R1p0RmtOR25FdU5MVGFsditML3hpN3l1dWU3NGxaR0xYbjh2MEVkcGRQTUFH?=
 =?utf-8?B?QmdTaDVhZSsyVlZ2MjROa2llOXliVXMyUGJVQU0raVI5WW1MRkJwWlN1aUg1?=
 =?utf-8?B?RW5mcjZrRkdOVE1vcjFYWDFpTnJyZk5LQ1ZXWTc0OC9CMHRKSklRakVMWkZr?=
 =?utf-8?B?dWdNNmZkeXNYSkNmTWV5ZkhHNmdxbUVDSFk4SHVmZk9uK252ZnhJbmkraXQz?=
 =?utf-8?B?cU9tUE13UTBqcmxpMG9IZW03OGJ6dTNtR0tKVENqVDBDM0lpYXB1Wjd6c2FT?=
 =?utf-8?B?MXJCb0ZFbGt0VTNZOWo4cEZhOWFSbVJjZ09kV1JIMzQ2UDdXRkROZW95TjVq?=
 =?utf-8?B?a3o4aGNScTJYNlJraC9tZ1g0eHZjU1ByalpNQkNEQXRrYjMwUHVXWSsyTHFS?=
 =?utf-8?B?RTVxM2ZIVjd0YkVYcHNheDNKZGJGNiswSnkvYkIzMUNrdUY3QW5ZRUpQN2VZ?=
 =?utf-8?B?UHg4VmJONTlmOEM0WVhZR2pyb2VoMkFsaWE4MnFVcDhOVFErMHBhay9xUGov?=
 =?utf-8?Q?n65rMWHuhvps4wKv5UzPV6om1c7pfSUNnOn2w5V8+HHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2398d66e-d38a-4664-815f-08db1ac97a13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 02:54:44.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcxoyrZwrIJWtU2O8tSLAZJtkTIffSd1QA7X0SRwlo7BQD8OZAG0P/QPZE0KGOQqlymlvhAHy72fyAUYRGgssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 20:50, Shyam Sundar S K wrote:
> 
> 
> On 3/2/2023 8:12 AM, Mario Limonciello wrote:
>> On 3/1/23 20:39, Shyam Sundar S K wrote:
>>> Hi Mario,
>>>
>>> On 3/1/2023 9:01 PM, Limonciello, Mario wrote:
>>>> [Public]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>>> Sent: Wednesday, March 1, 2023 09:28
>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>>>>> <Shyam-sundar.S-k@amd.com>
>>>>> Cc: Mark Gross <markgross@kernel.org>; platform-driver-
>>>>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>> Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for
>>>>> checking
>>>>> minimum SMU version
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 3/1/23 16:08, Mario Limonciello wrote:
>>>>>> In a few locations there is some boilerplate code for checking
>>>>>> minimum SMU version.  Switch this to a helper for this check.
>>>>>>
>>>>>> No intended functional changes.
>>>>>>
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>    drivers/platform/x86/amd/pmc.c | 49
>>>>>> +++++++++++++++++-----------------
>>>>>>    1 file changed, 24 insertions(+), 25 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/platform/x86/amd/pmc.c
>>>>> b/drivers/platform/x86/amd/pmc.c
>>>>>> index 2edaae04a691..c42fa47381c3 100644
>>>>>> --- a/drivers/platform/x86/amd/pmc.c
>>>>>> +++ b/drivers/platform/x86/amd/pmc.c
>>>>>> @@ -418,6 +418,22 @@ static int amd_pmc_get_smu_version(struct
>>>>> amd_pmc_dev *dev)
>>>>>>        return 0;
>>>>>>    }
>>>>>>
>>>>>> +static bool amd_pmc_verify_min_version(struct amd_pmc_dev *pdev,
>>>>> int major, int minor)
>>>>>> +{
>>>>>> +    if (!pdev->major) {
>>>>>> +        int rc = amd_pmc_get_smu_version(pdev);
>>>>>> +
>>>>>> +        if (rc) {
>>>>>> +            dev_warn(pdev->dev, "failed to read SMU version:
>>>>> %d\n", rc);
>>>>>> +            return false;
>>>>>> +        }
>>>>>> +    }
>>>>>> +    if (pdev->major > major)
>>>>>> +        return true;
>>>>>> +
>>>>>> +    return pdev->major == major && pdev->minor >= minor;
>>>>>> +}
>>>>>> +
>>>>>>    static ssize_t smu_fw_version_show(struct device *d, struct
>>>>> device_attribute *attr,
>>>>>>                       char *buf)
>>>>>>    {
>>>>>> @@ -526,14 +542,7 @@ static int amd_pmc_idlemask_show(struct seq_file
>>>>> *s, void *unused)
>>>>>>        struct amd_pmc_dev *dev = s->private;
>>>>>>        int rc;
>>>>>>
>>>>>> -    /* we haven't yet read SMU version */
>>>>>> -    if (!dev->major) {
>>>>>> -        rc = amd_pmc_get_smu_version(dev);
>>>>>> -        if (rc)
>>>>>> -            return rc;
>>>>>> -    }
>>>>>> -
>>>>>> -    if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
>>>>>
>>>>> The 2 major checks here originally were not in sync, so for major == 55
>>>>> *and* major == 56 it would only succeed if minor >= 37.
>>>>>
>>>>> Where as after this patch for major == 56 it will now always succeed.
>>>>>
>>>>> This feels like a bug in the original code, but might have been
>>>>> intentional ? Please verify this.
>>>>
>>>> @S-k, Shyam-sundar as the original author of that, can you please
>>>> confirm?
>>>
>>> I cannot completely recall :-) It was something like if the major
>>> version is greater than 56, there is no need to check the other part of
>>> the "OR".
>>>
>>> which is kind of similar to what you are now doing in
>>> amd_pmc_verify_min_version().
>>
>> OK yeah, then I'll split this correction of the logic off to that in a
>> separate patch to make this one "really no intended functional changes".
>>
>>>
>>> Like we discussed off-list, we should have this boilerplate in place, so
>>> that the future checks would not be duplicated.
>>
>> Something else I noticed that we probably need to consider is that there
>> is no examination for the "program" version which may be important.
>>
>> We don't have any version checks for YC, but if we did for example YC A0
>> and YC B0 use program "0" or program "4" respectively so version checks
>> could fall over.
> 
> Checking for "program" version may not be required as A0/B0 are never
> meant for production and IMO its a logical overhead.
> 
> Do you have a specific case, were you felt the real usage of "program"
> version?

A0/B0 of YC was just one example.  The reason I mention it is I think 
technically it's possible that A0 is leveraged for an embedded product.

I know similar thing had occurred for Renoir leveraged products too.

> 
>>
>> I'll add something like this in for v2 of the patch as well.
>>
>>>
>>> Thanks,
>>> Shyam
>>>
>>>>
>>>>>
>>>>> After verifying please post a v2 updating the commit message to
>>>>> point out this functional change.
>>>>>
>>>>
>>>> Sure, thanks.
>>>>
>>>>>> +    if (amd_pmc_verify_min_version(dev, 55, 37)) {
>>>>>>            rc = amd_pmc_idlemask_read(dev, NULL, s);
>>>>>>            if (rc)
>>>>>>                return rc;
>>>>>> @@ -686,15 +695,8 @@ static int amd_pmc_get_os_hint(struct
>>>>> amd_pmc_dev *dev)
>>>>>>    static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>>>>>    {
>>>>>>        struct device *d;
>>>>>> -    int rc;
>>>>>>
>>>>>> -    if (!pdev->major) {
>>>>>> -        rc = amd_pmc_get_smu_version(pdev);
>>>>>> -        if (rc)
>>>>>> -            return rc;
>>>>>> -    }
>>>>>> -
>>>>>> -    if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
>>>>>> +    if (amd_pmc_verify_min_version(pdev, 64, 66))
>>>>>>            return 0;
>>>>>>
>>>>>>        d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
>>>>>> @@ -718,14 +720,10 @@ static int amd_pmc_verify_czn_rtc(struct
>>>>> amd_pmc_dev *pdev, u32 *arg)
>>>>>>        struct rtc_time tm;
>>>>>>        int rc;
>>>>>>
>>>>>> -    /* we haven't yet read SMU version */
>>>>>> -    if (!pdev->major) {
>>>>>> -        rc = amd_pmc_get_smu_version(pdev);
>>>>>> -        if (rc)
>>>>>> -            return rc;
>>>>>> -    }
>>>>>> +    if (disable_workarounds)
>>>>>> +        return 0;
>>>>>>
>>>>>> -    if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
>>>>>> +    if (!amd_pmc_verify_min_version(pdev, 64, 53))
>>>>>>            return 0;
>>>>>>
>>>>>>        rtc_device = rtc_class_open("rtc0");
>>>>>> @@ -772,13 +770,14 @@ static void amd_pmc_s2idle_prepare(void)
>>>>>>        /* Reset and Start SMU logging - to monitor the s0i3 stats */
>>>>>>        amd_pmc_setup_smu_logging(pdev);
>>>>>>
>>>>>> -    /* Activate CZN specific platform bug workarounds */
>>>>>> -    if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
>>>>>> +    switch (pdev->cpu_id) {
>>>>>> +    case AMD_CPU_ID_CZN:
>>>>>>            rc = amd_pmc_verify_czn_rtc(pdev, &arg);
>>>>>>            if (rc) {
>>>>>>                dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
>>>>>>                return;
>>>>>>            }
>>>>>> +        break;
>>>>>>        }
>>>>>>
>>>>>>        msg = amd_pmc_get_os_hint(pdev);
>>>>>
>>>>>
>>>>> Patch 2/2 looks good to me.
>>>>>
>>>>> Should I queue v2 (once posted) up as a fix for 6.3-rc#  ?
>>>>
>>>> Yes please.  If it makes it easier I can re-order the series so that
>>>> we add a check in 1/2 and switch to the helper as 2/2.
>>>>
>>>> This might make it easier to take the LTS kernel too for stable,
>>>> but I don't feel strongly.
>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>

