Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7171F829
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjFBBqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjFBBqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:46:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83A2107;
        Thu,  1 Jun 2023 18:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCh4FGFVJBKDpU/hWJHYM3euhCK75BLxMW7y8zDNSZyYXKjniIDd8cEf5ysSS2AkHWRgmGbNRRrozndwT4x7MZFBbIphb+eEXpOjyzUUA9oog1ZU2FxISQc688CtPqumAwrbDvPgZXhOJLR9w58W4lwPLybQpzLsp5uki7BguI/TXsW3Ls1aPN8W4jlPv058QIOM6LkRfxjKNzJX7vaOkigoAJXWCI2YJHRB83ASxMTscWNpHR4kUl27CannXM5oq1DJdoTtIYrMY2WAvj6oR/QV4XfwfOMEsmfLrB+jAkHm820UZryOhJg6QIJhcDv7ZcE0Z6OsPdAiCJwtTNLDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nbBOTO2A6TbkObmvjmOUU36Ful4FErXMyLbceaNNRI=;
 b=WYOj58oTicAE5GwiD8l2xXxsR62k1YIkAk7gTb4eGUmjbg780b7DzwU0HZ419p9ia5RV4Y96Vu5jjKeeEqYA8mLu8LUM1o2zSWYzF8TAVClgwRcv1iIbUQphyvT6fWZ5bkVMEZlkKJsVWPcN2A8bigAXY++iHr6g6Umo2gNx2KISoEt0jsaE2f5Ipq50JZHMAtBKRZr78PILfyAJnYA0yXcbfyh73fQmbPQcx02fVGj4xYH3SB6hGeqW8o6GdTzdTygsToJcQp8HO+Q7Owg1+6kw5oBqDuKKogcoekzoqsYe6U56s/ukRDtZN0Mn/PgakazCNb6ONSoUeyZRinrZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nbBOTO2A6TbkObmvjmOUU36Ful4FErXMyLbceaNNRI=;
 b=10Od4ff5Lf4Eub6VDHea1E1fVnowPJ4COrf+7o43UwBIOg83ZzEW6+v6Cv1CwYIVzvkjYvUkcC5XxoA8karPvnUEA4kB/4JguxCgfUZbTCsAoVcQcIy4Srpbfm2r3FJ520cqpd6Q+A1l23cdys04DejU/BPXtw1hIBRNe2P02Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 01:46:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 01:46:26 +0000
Message-ID: <b0e0abc0-26ba-d104-ff73-b89745510be8@amd.com>
Date:   Thu, 1 Jun 2023 20:46:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] ACPI: x86: Adjust Microsoft LPS0 _DSM handling sequence
Content-Language: en-US
To:     david.e.box@linux.intel.com, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230601233953.1332-1-mario.limonciello@amd.com>
 <d1e0d5fc837753c292f78a5357fd9ba4531f06d2.camel@linux.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <d1e0d5fc837753c292f78a5357fd9ba4531f06d2.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 03392974-7e8d-4d52-3e40-08db630b2db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DU8GfqvD+iTGs86U/yNeE9Kb+qLtn0SP7uGBT6XSJsJfF+OjNQbYSXXxlOG9lWQhI9lYJ5HgBuy5LRr/+dPVVZAC16DuItYdS84Yhur6YrsWOUoh2O1CRy594t7AbWuF6tUAUo3WjBGI0CO3KpBkDs7mjUNC+NZ2kBNDJm5XW1WMag+onryKCwCEeV/DedY/x53VCz7Ok9HQFo0glI4S2s2H+jQolU8hZL0y9fzApLNBwElT4v1sdcmroiPfCUGuqR05b6Z6Z36US9AyqQjeZ01rC1rciyIh0zQWc27jS/dxeumyMyXAA5TJWfFxX7Br1L0nq5NEEuxup86iaO6XIWot9+WR8pnyu6oW9ms6yCJO2uIViBYHdEMCLDcsVCz+7DHg1UlR9IyLxYxihyhpLTi9RXecCsE9dv0EAemKlZdFB443y/3Vx8l0ppSXJriYe14oGm3S2kn5WTkksGFZ5U8BUP3GM6Hi0osISl6ZfFZYaRZXPcC0R3uwNSy/pjjewe5WV2Tiztn4Zbhl8cBIjnIIzba2tPYxgz5JG2Koj5qO+H78Krqxr9zC0VXmbXBLOgNYWy80MW/G70B78UBZTi/p83EAqnnqS/kFCgGPFahlpuzwKhotQdEREpSZF37hXwkTmFk2nS4Ec3PQYeKkjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(47530400004)(451199021)(53546011)(186003)(6486002)(6506007)(6512007)(2906002)(52230400001)(316002)(966005)(5660300002)(41300700001)(36756003)(8936002)(8676002)(38100700002)(45080400002)(31686004)(4326008)(86362001)(31696002)(2616005)(66556008)(66946007)(478600001)(83380400001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVRmaTM2eU45SVB5cUVmZ1lmSjFXLzdCTGJNam5Ednh5eXlOUDlpNHJTMUIr?=
 =?utf-8?B?ME56YWZMYVI5dEVxWVpHUWMvUm9NQXlKajFNdjBYc2FuVEZkdlIxL3JaRmpR?=
 =?utf-8?B?RGEwK1NYZjk5ckU5MFpmSEQrMzZhcDZnNlFlb28vOUpLcU9YT3FGVURNSmlC?=
 =?utf-8?B?ZmdvUzU5SWVIcHY4eVFjbHUvelhNbkZFV1o4NXFPOTBGVE5zK2NJVC9JdU9T?=
 =?utf-8?B?T2F4SmFaNlZqQnZqbXpqb0dFbzJUaDltRk9sSUJRNEpDSnQrSFZjL3BVZE9m?=
 =?utf-8?B?cE5TbDhmczVycmVMUzd0bXQ5WHJFcHFyMlhtbmVURlVUbEE5YzVQVUZJbENm?=
 =?utf-8?B?L2x2cjBVbUw1a1NEVEF4SU9sVTJ5c0FhUDlyYTQ5bDgvRDJKb2JCRUliV0xq?=
 =?utf-8?B?dWZ4Y2tjRFhMVUI2VWR0VW02b3VoTDNiMjBxMXNRckphOGNxUTlUZXhwN1lj?=
 =?utf-8?B?UWNkZ1o3ZER2K2xMdUE3aGNoM0RUWEhnMHp1VUtiY01TeWdMYmtsWTlpNC85?=
 =?utf-8?B?VnhOOVZ6VE83a1ZFK3EzU0VIN3JxSXpuZTlhS2pqSE91MDAvdXluR1phZU5w?=
 =?utf-8?B?TFlmYWNlNVpWZ3I1V1hCWXBodFdGZVVrMEwyV2tkdGVpUC9XcHIrZFRPcitp?=
 =?utf-8?B?elRQTHFCQUtTeEttWDZQQlZGU09Ed2xVcUVpUksvNnhhT3FlZEZ3aEZvU2Zp?=
 =?utf-8?B?YVEyR3BZNVNjc1JuK1B4S1VNZ1RRNXRkT1N4NjBYNm9aOTdTeCs2MTRuUWZT?=
 =?utf-8?B?dXFrMzFRT05nemxzU29GWjJEY2pkZU5Fd1FBd1puck9vQjUxa0J6aUR1SjM3?=
 =?utf-8?B?WFdPZ1N0bW1jKzJTUXdLUEg5Rk5UYlFNdUVLSTBjc0dpQjVJZmc5akd4SjZn?=
 =?utf-8?B?QUpqeEhQMENrVTM0Qmk2ODNNTnEvSjdEaXlWMlljRWl5bm9qOTBhWFN6WXdV?=
 =?utf-8?B?QTFTREpCT1lsWjRaVThlaW0yUDFEYzVOd0R6aVM4MDRqNXNXNGpQbFlEc2RZ?=
 =?utf-8?B?SVFFVUIzcUtjYit1S0QvM0RMakQvVXFSRk9FbmUzMEp4Qkwzb2s1TXRQOStU?=
 =?utf-8?B?REJZWTl1NVdYZkpVZFJCNnlSeVIwalllemxrcGJlRENTNFNxWXl3WnhudmVG?=
 =?utf-8?B?b0FpRm1xd2ZQRVpWY01UM1ZyY21lSE5GZHJSMVBleUZJMnl1NnpudGVwd0w3?=
 =?utf-8?B?QmJaMjJtb0ZSNWg0emFSTDRnSUMvTlhHSVMrVTVVeFVUY1o2YURFemlLTU1h?=
 =?utf-8?B?eFYxNno5aDF0WDdtVjFDdDRWRllOUEZXQ0JvbnFYTGk5TkFpcDZlcnJ5ZnA4?=
 =?utf-8?B?MnhzeTdKNW00b0xZdTk2SElJVHZ5VVExdHpoeDhvbENoajlqWnAzZUQ5VnZq?=
 =?utf-8?B?b2VjUXFvcnVyQUt4anRydExmclBSNnI1YnFpVWZHbUY3L0VNdVNGQUllZ1pW?=
 =?utf-8?B?ZmNXNVJmS0RySTJETHNld0xvcnhSMkNQaWh2SWVxaXF5QU1kSlB3MDNqQ0Fq?=
 =?utf-8?B?bXZmaFVmbXhoTTlwWFBUM3hPM3lqdkQwRXJrL3VJRWZkQUMxdUhwVXl6czk4?=
 =?utf-8?B?WUtQRFFtWVlrbk9NVzdaTWUxSU1YRkxZQnVKYlpwS2FQbUxIRHJvVG1Cc2pY?=
 =?utf-8?B?R0hVNmExeFlkaWdYYlRieWtyL2pPc3FFNXJ1NG1jenRqNUh2WS9IVmFoNmJS?=
 =?utf-8?B?WHRodHJqc1ZwWXhRR3pjQnJZUmorbWJZWkI3aUEvdm5yYWEwbTF1TExpOXVj?=
 =?utf-8?B?R2FGNG5GOFFqaHUwOG5WVVRPcGlIVEt2RGJmeFNZc2cxRVk5Yy9ZdkRYOTNV?=
 =?utf-8?B?Wnp0bGI2c2VpK0RkaUJmODFnUFR6S2tsa3VKajNYSStQVW5vWHVacTBYVFJr?=
 =?utf-8?B?V3psZWd6RFlqN1pYVDdycTdMTXBQTjN4T2RVVm5wbkVPK210dXhUTVN3a1NQ?=
 =?utf-8?B?aE52alpYZTRnQXVmLzRWOW5qNmRxMlNIS05qUlpGUzY0a2gvUmszRm54MThi?=
 =?utf-8?B?eDZkM2tuc3V3YzY5V2xoYWpDK21Kb1FheUhFd0lrZ0drN0s0SDlsa08vM2N0?=
 =?utf-8?B?dHBhZTZESXNpcFhLVC9jb1pzRXQxdEVhdUN3azEzaHArdzE4VHBrRUFaWEpN?=
 =?utf-8?B?a3JhK0hvTXR3N3BTVWV5TjZTT2xraGdadkpkdEtQNWg5ZndvZ0Fvb3l6UGxx?=
 =?utf-8?Q?fEpU8gcbz4aKP4f5hI6W7wrBAbKp0Qyh/5E95SHQaUQm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03392974-7e8d-4d52-3e40-08db630b2db6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:46:26.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+tE1raPZXy4r9bgv4FnhoV/q+oIFU9eByALqNgA1aEp3QHK6M19YkqWmSc0hKHGqBWj52o4hCqTHAMoF+1uRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2023 8:31 PM, David E. Box wrote:
> On Thu, 2023-06-01 at 18:39 -0500, Mario Limonciello wrote:
>> In Windows the Microsoft _DSM doesn't call functions 3->5->7 for suspend
>> and 8->6->4 for resume like Linux currently does.
>>
>> Rather it calls 3->7->5 for suspend and 6->8->4 for resume.
>> Align this calling order for Linux as well.
>>
>> Link:
>> https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states
> I didn't catch the ordering in the link.

Yeah it's tough to interpret from the link, because the picture at the 
bottom
is missing annotations.

Basically if you look at the picture the blue part is the screen on/off.

The green part is "modern standby" and then the little "humps" are LPS0 
enter/exit.

> Was there any issue that prompted this
> change?


We were debugging an unrelated problem and noticed the difference 
comparing the

BIOS debugging log from Windows and Linux.

If an OEM depends on this call order in that code used in LPS0 phase 
requires
changes from MS phase I could hypothesize this fixes it.


> David

BTW - is there interest in supporting the Microsoft _DSM GUID for Intel 
side too?

It's an incongruity today that we run both AMD GUID and Microsoft GUID 
for AMD systems
but only run Intel GUID for Intel systems.

>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/x86/s2idle.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index e499c60c4579..7214197c15a0 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -485,11 +485,11 @@ int acpi_s2idle_prepare_late(void)
>>                                          ACPI_LPS0_ENTRY,
>>                                          lps0_dsm_func_mask, lps0_dsm_guid);
>>          if (lps0_dsm_func_mask_microsoft > 0) {
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>> -                               lps0_dsm_func_mask_microsoft,
>> lps0_dsm_guid_microsoft);
>>                  /* modern standby entry */
>>                  acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>>                                  lps0_dsm_func_mask_microsoft,
>> lps0_dsm_guid_microsoft);
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>> +                               lps0_dsm_func_mask_microsoft,
>> lps0_dsm_guid_microsoft);
>>          }
>>   
>>          list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
>> @@ -524,11 +524,6 @@ void acpi_s2idle_restore_early(void)
>>                  if (handler->restore)
>>                          handler->restore();
>>   
>> -       /* Modern standby exit */
>> -       if (lps0_dsm_func_mask_microsoft > 0)
>> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>> -                               lps0_dsm_func_mask_microsoft,
>> lps0_dsm_guid_microsoft);
>> -
>>          /* LPS0 exit */
>>          if (lps0_dsm_func_mask > 0)
>>                  acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
>> @@ -539,6 +534,11 @@ void acpi_s2idle_restore_early(void)
>>                  acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>>                                  lps0_dsm_func_mask_microsoft,
>> lps0_dsm_guid_microsoft);
>>   
>> +       /* Modern standby exit */
>> +       if (lps0_dsm_func_mask_microsoft > 0)
>> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>> +                               lps0_dsm_func_mask_microsoft,
>> lps0_dsm_guid_microsoft);
>> +
>>          /* Screen on */
>>          if (lps0_dsm_func_mask_microsoft > 0)
>>                  acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
