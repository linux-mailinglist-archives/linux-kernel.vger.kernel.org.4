Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61216F8B89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjEEVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjEEVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:46:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E984455B2;
        Fri,  5 May 2023 14:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpOP9dQgxkgSpG5Va/2eX4uHwbv8J+08Of22+tBEAcUsD47dOHuCfcs5A4oMdHNnSdLd2nRHSA7ZUkz+9e/orC03oMKwpnVbUkyVkREd3g4rtm2CJf83RbxpFfsWRk+I+ogb+xMPR6yRrESbN9V1UR7gKuyUO4c0moca+cSKg8aUMVgCjdI/tzfD6rStFtAphRpUDaxl50kjxEb6C81kZwnt3U7W+gPG2HIz1z8/Q8P4KpYH5JRcKwzTUR6Ro9fPRT1aqE37oq1378Rl5hQBUJBFf64JUih7jrjERyM36daIuc+EYxeZ692UndT9lJ8az+O38oCbyI6wRN2U+kOIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx2fKMmO67YOKYoa2+3SI9bBKD6Y+zlHDp/HtaJ5PXY=;
 b=FUiPqZHBWWoL01AP8T68WbDCJ8+E/SnJCfobsorghF+1RKofu3mihcyB19hpJn19qoAQqQ17pTXSa7FxgCIBeW74YME5SGy2ROAfQzAJpuVtsF7pyd41DBr23QkYWvzTLWeof4sIFWx+YaoDtg7f6pIOITJy/CjZsofkeVOeU8ixjvDhD/FWyEDKvk1JA2pWd+4/R5W6CoWe7I9pH5AjgDrTO4ezMIy4d6MNBCPccXtOEv/osxfKYmqsIZOGo5OyhegVItpKqaIbn1o7dpKaRE+WcsN9K0ONCrZ6/PkyeHqVT2TTosL29FgBJ6ec28YDrnBmkCcLYFnv2qPoptXEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx2fKMmO67YOKYoa2+3SI9bBKD6Y+zlHDp/HtaJ5PXY=;
 b=xDoLs7NGfWMOzKT/Nx9c16293a98Ed3eUiVZvSEszl2Mi+orC2kTCaPamHarYXOE2oxNcVO/D16iQw62Jfb5vSMLVqJYLBNsQ5RhXRRgYUAk8KTbugx+xKYATH3MJFFNCa7QNSeutlKi2q+HI8m5EfA97qmi49dTlEf7Xk5R+ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 21:45:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 21:45:27 +0000
Message-ID: <88de8b87-6bcc-4794-5e20-cd7ef9891ede@amd.com>
Date:   Fri, 5 May 2023 16:45:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 6/7] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
 <1cec24f4-e4b1-682a-3ada-b51d2a7c83a4@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <1cec24f4-e4b1-682a-3ada-b51d2a7c83a4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 27528286-e979-4fab-69d5-08db4db20a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+Cq5ZpBUv+mh0jDtFxKAxzemGmvN6XcfuieS5Q9Ezgm+515+BWDTp5xuNn8ac8DFIn0XQMWZffHP4Y+kDRZ3yz7ROFDLoL+ATr4hI2tgpd8ch8N04gN9YKgy/MprtH7oGXlBkwy2cAglCpIc+CMgh2pjDKJrT2V1yyambz4+/3rff0MicSKc7XoLrJEwoemfCoVLBvexRMKZ6FXnUIBcf1+HGkAqGQ4ixD1eJcoeyT8IP77eGQyG3THnseAFQrQtPUU8X8sp1t2Jwhkrf493BL3vWcko6thYE1iMZRra7ml/7pwwaGVr+PpWcKbBVbCUyWA2WxA2+WDJLAhSjX7do5IpDX2RIhic76KAnIuxoiG+g1nHkqmoBJG0fU3D82Il+IuF7afVoVdBL1A+58XvY+Ai+1Rzb1JIo8RB48CIRbcJITmgNjwx2uSEtlfDhJ1TiWsyvLv5Qe2+sDwfDIrqV+tnOTHr6AHm5gUgoRYU1HppH3bDqgDN6HsB1dH3Ddr15UAFVhJU26QSZlNtreFKGfTT5TF4BaZec5Yc8FNQdMvLmEYM7jDYEvKOcixKBsOT9BHYg5tFFHGpjAhPMSwxCksitGDMw7LEUedKHFepSnGHjDCVxKxA13d3CG0wcDgKGIobGLruzECO0zO2YCQTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(31696002)(36756003)(478600001)(316002)(110136005)(66946007)(66556008)(4326008)(66476007)(6486002)(6666004)(41300700001)(2906002)(8676002)(5660300002)(8936002)(7406005)(7416002)(38100700002)(53546011)(2616005)(6512007)(26005)(6506007)(83380400001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpKS2NxQU1MQkhSbHRHTnZUdUE3c0ZpNXJHcGMvSitsajUybXBYQ1VLQU1z?=
 =?utf-8?B?bmtCQk93OE5XSytVeUtuWSt5K0F6UW5YQUxjNWZKLzdZTC92cW1vWm01Skd2?=
 =?utf-8?B?Vjh2b3VpWi9DWnJZdW5oVW12dFlXNitzeGRTSmVVZGxkY056enMybit5OHBv?=
 =?utf-8?B?MzA0MFhicm9tdVh0RjRkWFBaNHlCekRvR0xmUVVodWszZXFYVGNvekdwcXZR?=
 =?utf-8?B?RU9pTUVjWENQMDd1SWJDajdGSEJpVzZXclB0OG1wdE53NnoxZGdSOTVQKytQ?=
 =?utf-8?B?VXZUUTZOQ2czRm5lNnlsbFJSc2Jsbk9OSjh5OWNlUW81V1lBUW5pb2ZPMTJW?=
 =?utf-8?B?SHdlRWE2QVdZUkxDOWVLdXRVbDRFaE9kYWFpUGZZc1Z4YmNHY0x6cEdLRUF3?=
 =?utf-8?B?clhOcU45SXlDaUUrL1dCa3k1VVVrODFRQ0JsWmJrRWMwenl1TUtES085VmJF?=
 =?utf-8?B?UlJjSEhTSnNPQis4eDFld085RGh0Rmw2U0FTdEdEODF3NEJRL2t5MXVYMGwy?=
 =?utf-8?B?L2tGTFNML2ZNalFmVGlOUndYY01MaDQ3b2FSOHZkaXhDeC9iUlpMYjlYSk9y?=
 =?utf-8?B?ejVud1ZMOHdBaUl3VGRDVk50WnNGRW41QSs1SUlUWml0ci9tSWxVTCsvVHg0?=
 =?utf-8?B?cjl0YkxZRU05L2Z3L1Jpa0NBOXdZSXUwVHBmVFJDczlvUFJEaVpqREV2YS8v?=
 =?utf-8?B?WmdMVVZTeE0ySnVXNEtwbEtBVzZCRHd6aGZaM2t1ajVwNXVjSmRrRzliaHht?=
 =?utf-8?B?MlhHekM4YzdRbUxXWXFBcmdFOUM0dkxzUkFYT2xQMXh0a1I3YTRveENOMk5m?=
 =?utf-8?B?N0tvZVZGUHBJNTF1ajRnRU9OczZVS3V4TzdoYzJrbWpWWlJpSVBqUEZMRWJK?=
 =?utf-8?B?aUlzZ0ZiMDNQU1pzVnVVMzBpVlh4L0NFYjBheTNOaGNKSCtEeFJ0UzY0a25z?=
 =?utf-8?B?OFFxOWd5bjNnSjdFOFJqZ2ZHTzJzRXNYQ2Z5ZW1SS2x5SXNRQkRSTlpEMkMx?=
 =?utf-8?B?bEYxNmhicERjeUJJMy9XVFpHN1pkdlQrWTd6Um9oWFdQcHVqWmN5TDlJR3BO?=
 =?utf-8?B?SmtwQm9qRWdXV3R6blFBTFM2TG9OREFuYlhSa1VWRnRFUkthSFFBSE56bUo4?=
 =?utf-8?B?Unhuc3AyNFNyaVhMTFpORXhXYnU1QTRRbFlJTEx1WmhYMWkyU2szSlhpYnBz?=
 =?utf-8?B?YWlJUFExanI1U3F6cmVYNHY3UDdaSEdqWEd4Q0Y1RXMzQkExWE5SckZMVzNB?=
 =?utf-8?B?bHoxUTlkL2NHQ2JwN0NCZmNCd09lSWdKd2VaY3NqMXVwYUUxWituQWNXa2ln?=
 =?utf-8?B?THEvWUg3VXpmVzQ3UmZwVWJZd1hIUFJTd09QZ1UyK0lwOFphVVRlRmppZURI?=
 =?utf-8?B?NWkvUU9MU0hKS01pWms1QitWVnNER3QwVWhFMkJyWG9FRG9Qc05NZ3ZRYzcw?=
 =?utf-8?B?QTRUVXFVMlc5WEJxOXR3ZE1ISnZuVXVRdUI4YWYzYWNjK3p3VUhkSnZsNGVu?=
 =?utf-8?B?RUVqVkdVUzRJcmRJZU9XSzZyVHZ0WnJMWUltcHJmb1FnSDB0Q0lNMXN0YWEw?=
 =?utf-8?B?bFdJQ2N3WXFlUjNVV1lBNDU1TjRtYmh4RG1hWjJTOXYyc0JxYkM5S3ZYQVJ3?=
 =?utf-8?B?R3lDdUFIakJTcFlkaHIwcGZrVlRHUythNEpoUy80NXc5R1dLN0hnV0dwU1Rs?=
 =?utf-8?B?cTZQeVhQdlZZL0FiTTJHb3BBWFllbEhacnVqSWZ5UWg2anJHbkhTSDF4Q2pC?=
 =?utf-8?B?TE5sSVNCUVp4ZEF3Uk5ud2FaZjFDWXprMk1nR1g0M3NxeUJBTUtsMk1aU2pS?=
 =?utf-8?B?YnVCdktjOGwraWNsZ3N5aUY0Z0E1WERHL3NOSUtDVEQvODRLaDhrSmQzZFVa?=
 =?utf-8?B?NDZmYWhQUkpkRUtBc3RITm01RWhIUU1NdThHaExSMWhHbENoUVFRQk5oM2hB?=
 =?utf-8?B?djA3RXdmNGp2elE5d0o1SXNyMUp0dzRoT09LdmQvbFQ2TklxTW11cENjZFJJ?=
 =?utf-8?B?NXRlTlg1SkwrRXZCS2ZkdDVVM2RBSW1KdWkxa2ZaVFVzKytVUGwvUWU3RXc4?=
 =?utf-8?B?STcyMXRNbXJmTjcweU5LcW5JUHJwZGhUQVMvSDBBYm9tU1FidW1OZjJDdkpX?=
 =?utf-8?Q?1/rWNAsUHqGvc2Z23kpJzfB4t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27528286-e979-4fab-69d5-08db4db20a5a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:45:27.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mIeputbi9Z66bIa9cOTow0160wOA+ZBovlyo2c+aiBLz2u+YvK7Jf75JmEJ3BKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 5/4/2023 2:04 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 4/17/2023 4:34 PM, Babu Moger wrote:
>> When a user creates a control or monitor group, the CLOSID or RMID
>> are not visible to the user. It can help to debug the issues in some
>> cases. There are only available with "-o debug" option.
> Please see: Documentation/process/maintainer-tip.rst
>
> "It's also useful to structure the changelog into several paragraphs and not
> lump everything together into a single one. A good structure is to explain
> the context, the problem and the solution in separate paragraphs and this
> order."
ok Sure.
>> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
> Please highlight that CLOSID and RMID are x86 concepts.
ok Sure.
>
>> display in resctrl interface.
>> $cat /sys/fs/resctrl/clos1/clos_hw_id
>> 1
> This example does not match what the patch does (clos_hw_id -> ctrl_hw_id).
My bad. Will fix it.
> I also think this change would be more palatable (to non x86 audience) if
> the example resource group has a generic (non-x86 concept) name.

ok. In this example the clos1 name sounds x86 specific. I can change it 
to ctrl_grp1. Hope this is what you meant.


>
>> $cat /sys/fs/resctrl/mon_groups/mon1/mon_hw_id
>> 3
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   Documentation/x86/resctrl.rst          |   17 ++++++++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index be443251b484..5aff8c2beb08 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -345,6 +345,14 @@ When control is enabled all CTRL_MON groups will also contain:
>>   	file. On successful pseudo-locked region creation the mode will
>>   	automatically change to "pseudo-locked".
>>   
>> +"ctrl_hw_id":
>> +	Available only with debug option. On x86, reading this file shows
>> +	the Class of Service (CLOS) id which acts as a resource control
>> +	tag on which the resources can be throttled. Kernel assigns a new
>> +	CLOSID a control group is created depending on the available
>> +	CLOSIDs. Multiple cores(or threads) or processes can share a
>> +	same CLOSID in a resctrl group.
> Please keep other content from the documentation in mind when making
> this change. CLOSID is already documented, including the fact that it
> is a limited resource. Please see content under: "Notes on cache occupancy
> monitoring and control" where it, for example, states that "The number
> of CLOSid and RMID are limited by the hardware."
>
> Considering this the above could just read:
> "Available only with debug option. The identifier used by hardware
>   for the control group. On x86 this is the CLOSID."
ok. Sure.
>
> Similar feedback to the "mon_hw_id" portion.

Sure.

Thanks

Babu

