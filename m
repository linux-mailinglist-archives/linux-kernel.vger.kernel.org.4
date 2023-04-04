Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAA6D5838
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjDDFvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjDDFv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:51:29 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54A18C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztw+xjZN5xPHXwt4GiOwDsZsKfLbEWBPh/yM81tv2o/a/lhRA53SWqmt6q1z2AbVKmFNelOHUSNYCvL3lHdwQAWy2yMVbnogLJreT6yi2CMssn9TDrrB75zW3UyTRtnsPU3QDqnCHH+3IvdRqzREQ31nSxTnLdZN/qO78oOfz9gXgH/LNeIgOHPcNpi9qeIz2neliVfn6OU636SE72voeXOnPpY71uV/acFLe4rNXiMT+0fB3p9Z7ezs6oNZ/Vvg0lrZuOXyAOcIazMUEuSyGH0JvtIMAY8qD+Fpa6yPHrc7v2sYtvCrzog3CILfb1vuB8G6YNeleRO5cIDhtBL/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2BRzw1VbGAflp8lTBwuOTxOGvL6oK8JVyy994TwfJ0=;
 b=L0qAs5N8rpeyrehCr2IWab1bqI9SelMIef1D2qxhmWk0QUjYOWN+Zxk2R9ITmMEQmhntyZ/WEELlFAUeQ5shfTdDgK3pKvIq/bJsWDTcUZzMdtiSCTG2YkIdTk8LJKBvStcoIK2M/DPh2nRlfpBliS4injNRRH388vCDNLCduQrfxnUtyFRjIQC1LEdsXcsSCqO2dYBXhJA2mM/2Kwi20J/W6Ows83RciSVf2OA8Idm593HlloiVpm6pXk6piE0yrNnkqzr2rjAygVVEeQXJoLu/XTpkkGWHcjgkBiNFiCNmIRWlaSq4pdwzIJ987cYg9SfRxu2L884vB02kztdM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2BRzw1VbGAflp8lTBwuOTxOGvL6oK8JVyy994TwfJ0=;
 b=yD+IfqPktZrJLCpXTuD7R4rZiJda5MDUKxIhFhd88D2UK1GQmsTmJhkoanIg+hu5gKcqqToaLxMOyQKVX30+qnpC2FFaOvbxjXJyKBzLOtx7NLMUdoz3kS/qAfut0yWjC9eLVCy1gFSuqmOTvD/ay57S7+XuCQcWzYQMPNUBCPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 05:51:23 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3f99:52bd:6b66:d22f]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3f99:52bd:6b66:d22f%4]) with mapi id 15.20.6254.026; Tue, 4 Apr 2023
 05:51:23 +0000
Message-ID: <748f1939-a5b5-25e5-8b45-e0ec89a39d6f@amd.com>
Date:   Tue, 4 Apr 2023 11:21:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer"
 configuration in IRTE
Content-Language: en-US
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        "Nikunj A . Dadhania" <nikunj@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
References: <20230331061723.10337-1-kvijayab@amd.com>
 <575ef405-9d43-b99c-cae7-f88cfd6063e2@amd.com>
From:   Kishon VijayAbraham I <kvijayab@amd.com>
In-Reply-To: <575ef405-9d43-b99c-cae7-f88cfd6063e2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ea7e0a-86d7-43cc-4477-08db34d09f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FiFTOtBsXPGWrf53G/RtZEl5hKx3713kDsXPMVQLnUgb7s/RPHiH8dqf+44zTLQ4aIYIQQReUWd6g0q61fg3iuh/c4/3aYuuasp8dQ0iyd4u5EnlxLBJEO1aNOw/bGiZqvbTcEjKZj1QrWUgA26ekfqkdrSZYwlF27gL3RPmLmfnxueD8HAVIkg86a2kB2hZu9j1bUym2dMluENM1FyN5ZUnTkkaFJXDcX/1fZs7hFPH0llNNCtD8FsAet6eE9AGrMlOd/HCyNpaIwYX0f4PtJq+65UcdXBnGKk+9dugVpAYgzdCAx0FmbEhvN7AlsP/X/7UAW5DBvr7n0Pij47bbJqaFbJA+Bg0VuubLj0VBTO5GdWgvKAxB60OwmpcVqlvF3CaFmmUt2Vcn6gy79aSCJAkI8NV1cUT3NBkYgfYkLQlE+atHM1HQrrK0a6A21GW4GqUZWUrU0sA0uQWqKQuJXLBiS4AcvxVNVx3pFEyWufoKHMeCXfv21SQH+T+ALV5KxUDwVThEFxZ2hsc42heRKAk0vVqtq7QzLdkJ7WfwVLL4j27ElCtvRn4DKmarQdIf33HnAJ1jIEzCLeTT8b3QbkMKNi/FZKtfGtP7Y5RcZG5F9QaZkrjrEcHEQJTguzHeEdQ/VFhyT0//yZ6ajLlqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(31686004)(186003)(26005)(6666004)(53546011)(5660300002)(8936002)(2906002)(31696002)(6512007)(54906003)(66556008)(66946007)(4326008)(110136005)(316002)(6506007)(2616005)(83380400001)(41300700001)(478600001)(8676002)(38100700002)(36756003)(6486002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpJdXNmeVFjZGRDSkJBVVZjSldLSFhBbW9lTWhJS2M0cGZ5eDFVVDhJdWFI?=
 =?utf-8?B?QWl1djI0WXMrSDFiaUQyUkczNlRCaEdYTzhIM1lsMlBmTWUzcUtvUU94ZXRs?=
 =?utf-8?B?Uk1sU3ZvOWdUT3VzQ1FOVVhFS1NoTXB4aUl3ZUxoWG91OTZJcTFYSGFxUWFW?=
 =?utf-8?B?dEw1NWR3MjJ3Vjg5V0NBV0JyaXk4dlZsT0Vkc1BMQTRSWVdiTTBRWG5tSUtN?=
 =?utf-8?B?YnFtWkFJSVN6cUYrQ3FtVThLWWhHOUx6VlJoMnBUczN1ZWJKWU1tdXpERGND?=
 =?utf-8?B?M0sxQUEreHAyeStRVXpib2hzRlZGZDRTc09NelN5amdyc1ZFaGlXNUQ3eWFY?=
 =?utf-8?B?ZXo2ZVZaT3NlSnl2SzJqdS9LYTd2ZlRHbzJGTnZTUjdRRFNHMUtxbittWDB2?=
 =?utf-8?B?TkZVQ3lXRkJaN0NXbExTS2VCZlI3bGg3NTFkSUtCTlFqQk9VRFc0RWhQVXdu?=
 =?utf-8?B?TU0yejdGMjE0eisrbktlOXI5d3FpdlhhSHNTWEd1bXFGcGhZT1pvUHR4Z2gw?=
 =?utf-8?B?dWtpTzl3STZjYU5vRXltYUdRbTJxMXBDWEhtdmxNVm5NcUxlNDVQU2Jjbkh2?=
 =?utf-8?B?VFRaWkFsWllPbW1GbW9NMXhlV1VuK3lQdmRXS3E5SG1oeTJDQ012OXpjT2Z5?=
 =?utf-8?B?blpuTzBLSC9NTEhxeHZwbWNWOTBNcWdLcWdEWFBnS2JVZG5rVXhaQ29SZUZB?=
 =?utf-8?B?WFBJMUdDdlJuSnpLN1B5VmtrUjA1T2hXMzdkeDhlZnQrdjJLNklDMll6ZHlN?=
 =?utf-8?B?REVoOE5BcWgrUmRSdjdpMEhaUVZjSi8zcjRJZGJlTGdRVm5Zeks0enZva0Na?=
 =?utf-8?B?T3U4VUpraVM5TVBJNjRhMGRFOURWeFl2MVdSQ2xSQ2VaUkh2VUVWcUZoT2p2?=
 =?utf-8?B?TVYvN0daYlBDd0l5b0hDQW4vWjZpY0hMZUtHTDkzZHZMRUY3bGJuOVA2QVN6?=
 =?utf-8?B?dmlpN2VkS3pWS0VGcnRIU0gvME9aK05wMXdsYVVjOThGTjBQaEpiMS8xNDBF?=
 =?utf-8?B?d1d0SUgyK1ZZZEdvb29XU0kyb2MwSmtVNHdmN1NFcVl3akVMdDhydWFBS2R1?=
 =?utf-8?B?WDFyOHQ0TnlWejMycFZQOEduRVp5TUJ2ZlVCVk9qbnBQbTFsZXhQZnI0Y1g5?=
 =?utf-8?B?ODR6NmhPZUszZXgyTGE1ZTFoOS9ISHdtbWUrMXRIWUMxQ3Y5bEdxK3FmS3Vs?=
 =?utf-8?B?WGt6UGQ2UnVVNS9Hd3piV3FGOExqYjY0UERSY05TajNhUjZVWHI5d1VEMXVx?=
 =?utf-8?B?WmQ1WEhoYnQrWlpLcjZpSmlyekZtWWhQTDNpUFZjVkZya214UmpsNzIyaVc0?=
 =?utf-8?B?cGY2YkxzVzdIbE1BMEVWNU15cTZvK2NlZUFSNms3ME45WnFwcTdmZXFhWWh0?=
 =?utf-8?B?NlZNbS94dEJ5eTEyQm9mWm1MRzgwRkE3WmU1b2tIcGFlTGU5VENTNERqOTh2?=
 =?utf-8?B?TUwxc2NVK0xQcjNObWVnOXFEcW80cUNjZmU5TjZsbEhVUEhkRkd3d1U1VEtV?=
 =?utf-8?B?M2x5Y3UwU1VuSzhRU2FRWVRDQVUrUEtIeFRCT3pnWmVvMEFnMTlQWFFTaVM4?=
 =?utf-8?B?S2s3WkhLT2NrZ0tzODhsY2Vod0lDL0hLV1VleDhtTGZPeDVUSWJ0dW1UTTZP?=
 =?utf-8?B?bnRQMnI3MCtwMHlWaEJHWDcxNUFQMWZ5NjhnMTRMcTNnT2dtVEs1R2JDNFpy?=
 =?utf-8?B?QUEvTHJuRjhNR1JDQXlHbk9wWmJWeEhzLzNIeTdKeTR1T1hLUXcyQWVCYXJK?=
 =?utf-8?B?RDFGSXpWN2NQRFhmMGRseGRNYUVqTDNPdkZNVENybFkyZ2dobHJ4d3hBMGxQ?=
 =?utf-8?B?dUpjOHY5WCttZjFxNkM5MXdNUW9DSWowZ3VnT3pFaW9DVUtHN1VJbDMwazJh?=
 =?utf-8?B?aUxjYnBEaURtRTAwU0lhTE5adVMrSDVsanFIMlZWRFNlKzdabGNxNlg5MWhF?=
 =?utf-8?B?aDJtZG1wVXdvRzBrYWQ4eXN6eDk1OWxkUy8zbkUwVkNuR0IxS09ubC9IUGRz?=
 =?utf-8?B?d1JxZXllYXJYM0NFWndwL2xicTBUTjQzTTVLSW5naEo0TnBFVTd3SEFOekQw?=
 =?utf-8?B?eXUreER5YjNneWYzeVc2TDJCRVB6c1lLVkNJZitUdEF1SlJBeDk0WmtiTVlL?=
 =?utf-8?Q?Ikq2J5caxhDQRrwNmUTFbY1HR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ea7e0a-86d7-43cc-4477-08db34d09f2b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 05:51:23.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjqq4z9VVZZm5yOXAiEi91FqJKXjcqqn7gQJ5YimaKtzerbsoG1387IvR7nCkP+9vYOE6E578c0/DVIqDQB3bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On 4/3/2023 9:59 AM, Suthikulpanit, Suravee wrote:
> Kishon,
> 
> On 3/31/2023 1:17 PM, Kishon Vijay Abraham I wrote:
>> commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
>> (de-)activation code") while refactoring guest virtual APIC
>> activation/de-activation code, stored information for 
>> activate/de-activate
>> in "struct amd_ir_data". It used 32-bit integer data type for storing the
>> "Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
>> "ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
>> Table Entry).
>>
>> This causes interrupts from PCIe devices to not reach the guest in the 
>> case
>> of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
>> bit in the "ga_root_ptr" is lost before writing it to the IRTE.
>>
>> Fix it by using 64-bit data type for storing the "ga_root_ptr".
>>
>> Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC 
>> (de-)activation code")
>> Cc: stable@vger.kernel.org # v5.4+
>> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> 
> Please also add
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

sure, will add it in v2 of this patch.

Regards,
Kishon
