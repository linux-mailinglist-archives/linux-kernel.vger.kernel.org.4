Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23966CF335
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjC2TeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC2TeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:34:09 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FFA49D5;
        Wed, 29 Mar 2023 12:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abFVUUaQBkYrhmv1Sy7rOj2rvb+gi+ckyDRJB9GPne33BAd2ePRqKvlnVMtTfMyg4K/7WGQdB6rJkqTByB30phbg7VC/lQBkG4CAvlLsLGxEhvje2OQDNUnugBsw5lC0G0J3q7Oxm01pC2UQhA0/pm2YO0Hb/y33WGeDUSO+wMBMlVehegUKBM1mhHWOybodMQ+an8WhgVBEVbnuSAHSQ2grzsLNJcUruA/BaYUAQ7NFQedu+Zistp9x1nuXJyF/NGDR///IfyKllrIS7QHthFrwREKJLiCiZU1cgIeHJNd1T7UKHXCxN1yqQp6Y7OOaSWxRRhjp5f4mSxdcbUs0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjf16/r32djD1yFi1nAzI8lbKp9o13Bjl7aJVCuaUTM=;
 b=WgfxlSTB22J8E1hdASdGIDhkqSogxGSdpM9Th7abRSE/Y7XS6iGsxL6m7p/WCvMiNPoTJeUwQ1g90Ks/D9CGHxdUOuj9krByalt4R2EqN/XdRQiZ9inG4qnDigd7Kmi36SgZcbpCxb7ttNUS1zqz86atKrS87o6nxlJQ1YfRSr521RIcxt0CC86FtHDpSUc5nkQOWZRnB0NuAtK0eHyzzKk7ILvNHaRuMlIbwL23BOGQPkeCYTCTkMCvGTnYozxdKYdKg77K1Hj/3E+4+f+qfxdcXDTsc/fF8uJDnmV4cWYzSYezG0C5AsJ2S5FhkYX7k3pU5Y1i+Wu3UXxinxhmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjf16/r32djD1yFi1nAzI8lbKp9o13Bjl7aJVCuaUTM=;
 b=CP58kL91zzwd4M97iYyN0ujE6R4OjaPbodMXqKTBRloKyz/UZfZlg0MDNIfTiM/D0026eEgeuUZHoR0ztgu1mYvQhVAv/OecMSfEQW4SdUm6YIHdBDccz+dSIOwX3i8/aRlBTsd+ADCkqwaaVOalI6pYlS3o/BlhAK7JfGPC7ZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 19:34:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 19:34:06 +0000
Message-ID: <cb5ba93f-fd0b-3858-b801-2546d821a637@amd.com>
Date:   Wed, 29 Mar 2023 14:34:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] x86/acpi: acpi_is_processor_usable() dropping
 possible cpus
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Eric DeVolder <eric.devolder@oracle.com>
Cc:     rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvijayab@amd.com,
        miguel.luis@oracle.com, boris.ostrovsky@oracle.com
References: <20230327191026.3454-1-eric.devolder@oracle.com>
 <20230327191026.3454-2-eric.devolder@oracle.com>
 <20230327195737.GDZCH1MWNvFQrXdY9M@fat_crate.local>
 <a4efd5cd-cab1-b204-1395-670495bc33cd@oracle.com>
 <20230327202545.GEZCH7yUqcsddJx7Y5@fat_crate.local>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230327202545.GEZCH7yUqcsddJx7Y5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0242.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b29525-d0fd-4b2f-7fa8-08db308c8f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xP8K7inb8LUKpflTPh0IqeLqk94oKNlR76DFl8sf3ohP7lo1Y6A/vE2847QpsBCoTDFqR2eqVb1ZESxYoJyhYatV/PS9dAroF4y9jOeXPeN6BLZEH9EVEYV2C9CcgE2L8tvIgHwtRVYROj9FVC1ScuLYMnvVsxMljROSK7sj2lynzphoFETcOoB2dWEGkXNRI34D/Zql53qnmvWNk5tqwIcWGpjoZ2Iua52R6Fobt+4oYkSi5EcyzjvKRNWFnZ5i5NzCHkS6hXsTZyuv+EqazrR8MhFBCDRFD257SQBEG2Q+MZ/W/HWcVaSmM1Zjy1MuRroozKOgmHtadJ3sIIwPf7nZwodZMIra26eDhupasdWXpWbbgV593KOhMxJC+bFu6PtDzEp0f1fwoDrZUFn5FPpYXEEImALXmWSNPSlYoaat5dXnXlYKhY9WMJz8KGI60oAmn5QJYOQNVuKDX2W9cRJbfws19ySKs5Ygjao578WOw4Z+2zrU4dhEdU8/vgN62wwup+Kizmq6X59j9lFpJRCF4TCiI0Odc3/Pyu1RDWyDsOorHOEH4oqxvihGxtCpiJBqAuSQ5BAOlOA53hb/AKIa/d8A3h6eiSSk2+KwVqg7T9ep38PTKNbqmZi3eyb8Gyr5C4pTRqRb9OjoEOGa4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(6486002)(478600001)(966005)(31686004)(6512007)(26005)(6506007)(2616005)(4326008)(4744005)(8936002)(53546011)(6666004)(7416002)(5660300002)(41300700001)(186003)(2906002)(110136005)(86362001)(316002)(38100700002)(31696002)(66946007)(66476007)(66556008)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNXYmdwVkkxdTFOS2ZJMU0yamdCbkh4bUJJMXd2VFdyZVJITzhNYTVqNS80?=
 =?utf-8?B?WVNkc2VKV2g4RFE5WDJoaW5hY2hva1o5d041MTJsTUlTazNLbzVmUGt3MlVV?=
 =?utf-8?B?KzFQeUR2NWxIRWtwQ2hhQTRNSjhRdkVETmRsWDRmdDdVcjBrdmhHdFhwV3gv?=
 =?utf-8?B?UVBEREdPOUNaaFJhdm1qeGJDVkdSeEdQclRHYlN5bHhWTFNQZFBnNlVIcHc2?=
 =?utf-8?B?c1MrZ3RMRU55M1VCQzNHWjlyWmVBK3E3SmpuTzJXbEpiWm9qRDV4RUs4WUhk?=
 =?utf-8?B?STBRVHFNT1pmVlZ4QVdnT3JHdmdGT3hvSC9DZncrVEZhdVBKREhTWG9SdU5E?=
 =?utf-8?B?YUpYS1Y5aUQzbzBobzFnNXM5eENkU1JxWnZsTDhFUERoWHlQaDhTRk9wa2l3?=
 =?utf-8?B?eXVwRFJxQWlYUXl1ZWFLVUVpQ0hXTjRoS25KL1Z3VGROR1dEc2VKallTVTN4?=
 =?utf-8?B?c2x2SVRHVjB3WHpjMmhKSndSaEhQcHNUaE1Wc3RMVC9TMFphZ3RvYTlwNkJF?=
 =?utf-8?B?citxY1FVMzNIbTdJUUYySEJIelpKQms3RElvaEpIR0RtaHcrTzFNVTNsMjZ5?=
 =?utf-8?B?UEVvUVNnUkxNUHdUUHVQb29nRmlUNS9SMXQ1N0ZlQjN2VWhTMHNVVGlIYjFK?=
 =?utf-8?B?TDhybnh0WFMvVkhNdE1YTjRLQjZTZktYRlk2VzRjbGQ4YWNYVlhtQkdGMlo3?=
 =?utf-8?B?OGxyenk2bDVKQzJmTEFpU3FpMEs5bmdRalRQb1VoNXV1RmM3czZ5L0xra2c5?=
 =?utf-8?B?VWEvcHFESVZHdjVhQzRkWE14dU5iNjdpRTYwdFJFS1oyUGNvU2Z2Vnpzb00r?=
 =?utf-8?B?aDRkZU5sYVBOdVhONUNraU0xV1ZaMmxhRjM4bVFjRmlBK25RUFBXTTYybGJM?=
 =?utf-8?B?UVFJRFp3NEpQanZ1NHlRYkNUU0xFU3FPaStQVXl5Nm1Sd042dk9wQzhGMXdl?=
 =?utf-8?B?Q1M1TTNtZitwbjRHZ2NFd3Jid3NWempiSHBGcnZtcVNvY1UrMnJCZzFDamw0?=
 =?utf-8?B?dWxtRVBJbnNUSDhzck15dnpxQVF0S0ZJMkozSTBHTzM0eWF2L2Z6TGo5Ymhl?=
 =?utf-8?B?T280RkcxRzJxcE03d1M1Y0ZQRnJURFpaMjloRUtIZC9HMXlZcnpTTTlkcW54?=
 =?utf-8?B?TWpXS3dRaTVUYW93VEZvRnAwcjZha1g5ZTN5UUFWODlqcmJSRGZRK1FLTWtr?=
 =?utf-8?B?SkRQano3VS9wVHZ5b3gxRjBlU3lBTkVXeFJYVVFVMGVIb3BvR3FZWGU2V2hC?=
 =?utf-8?B?NzJ1YnRLaDd1bGo0OWpOUWRaZlZ5cjVLU2RCUVFzWEV0NDBtYTNEYkQwR2ZF?=
 =?utf-8?B?OWZyeXRjTmIyaWRlempqMzVKMHc1ZmVzN0c3ZEtDZ3ZJL1BRZ09XS3dMcjVl?=
 =?utf-8?B?SmFIa3hCZ3lQWElwdjlIem9ZQklRRTAxWjgvYzlkcFJmT1U0VmZpQ2hVOTk3?=
 =?utf-8?B?bmJKaHR3QnhET1Z3bVVQb0c1bnpUbWd0aHl6TklZSVMrRnhkOGZxZ2MzelZ5?=
 =?utf-8?B?b0p1ZHdwR1B1bTd2UHRZZ2pPenNQUEh3aGtPd3hKL05lRFVPUmpQN3JoTnJk?=
 =?utf-8?B?MVpwM0tQOGJzWHJwNmVBOEwxY0o3cUFIdHVIdjhYczdpZXRuR0pnL3NNL1R3?=
 =?utf-8?B?M0VaNlZDakpEajBuUWdwbDdUTjZvR0JFcTYxL3BnQ0xoQlFPdUtzc3ZUbTFo?=
 =?utf-8?B?UWhiMVZJZEVlMEI5NFhXc0s2M3V3RkxMS2ZyZXVrTXdxSnBMYnhXTzkwOC8z?=
 =?utf-8?B?THBqREIyaiticHlaaGhlTHg2c1ZRbEdDODZ4cXhMMU4xVTlSTVBkVFNFUnZl?=
 =?utf-8?B?Ri9qdWJKNUZSVjNhb2hUY3Y4TFFNSTU4YU45aTFEWXNCbTVJbSt5VzBSME5J?=
 =?utf-8?B?bi92cTljTk5aRVhMSXhSOVVOWHYvZDZZc2NSeFp2NCs1TTRVeEtzbi9PMVFn?=
 =?utf-8?B?WEF6SW9hcW15cno4ckVjV2NIRW56MlJzeitjUFl2bERYTG9EVFBHckNnL0Nu?=
 =?utf-8?B?a3lMckJoeVQrYTBFbFdYZ1lLY2xiYzM1eCtaWC9ZSFU0bnBJcCt4ODVPYmhH?=
 =?utf-8?B?aDNpRXJsNXNWU2ZjcnA4QmhnaUt4ajEwTm5sd292SFdHbk11WFBNVFpwc3Fn?=
 =?utf-8?Q?AclsiYLE7g5OAowf/xh+UPreI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b29525-d0fd-4b2f-7fa8-08db308c8f4f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 19:34:06.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e3yvNMqtszbBl5UW44+kaflQl5vXC/NWHBMFDNLhKBeFelSfwcKiCjavTQtQpAPZcrdL2G58f8qAbQbZB3iWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2023 15:25, Borislav Petkov wrote:
> On Mon, Mar 27, 2023 at 03:07:23PM -0500, Eric DeVolder wrote:
>> https://ueif.org/sites/default/files/resources/ACPI_6_3_May16.pdf
>> Section 5.2.12 MADT. Table 5-43 is the MADT Revision is numbered 5.
>> However, ACPI 6.x specs got a little "sloppy" with Revision,
> 
> Yes, I've found what you're pointing out too. But exactly because of
> this sloppiness I'd like to see this more explicitly. Because we're
> basing functionality off of it and it is not some meaningless
> paperweight anymore.
> 

Boris and I talked offline and got the situation clarified.
The corrected patch for MADT version handling is sent here:

https://lore.kernel.org/linux-pm/20230329174536.6931-1-mario.limonciello@amd.com/T/#u

Eric - Your patch is still needed though.
