Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30346BFEDE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 02:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCSBet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 21:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSBer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 21:34:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2752681;
        Sat, 18 Mar 2023 18:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy4RSLWAGshQztSv1XaRWWSdU0ffeQSjsca6Z+mb7cLfF/I5SNyxQyTmz8Ofp66dMIQqZgxguRal9bmrMP2gLg9jV+cWYGaQclTWKLlE/gzzUw8nTFgxTgXyu3JVnhIscXd9f4Y6A00sq2Uy2ecyOsNkP2N7kTCPN8bk6PA+ji9Wgl5VPftwbeDnLH0jYS33qdXBBA0CJ6dI8v96uPIW4dd66ZLwe+px72DHW2hg3/JnA8MVYVydTFrcLaF2TP/F8DfB4prlwaWlNV8BdL2cceLxv5jTtBYvKO7wPYwRCplmWCyInbson9EcLOJWTrCPTeTxdDulKKz51Rx1Pq4VfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JYbzfCWuqS8KE3Nj0RWaVe5/Q4OtSt3QMwsAZExmTE=;
 b=ja3Iyc8Hcy06KTw/ipQ4yM4P7+M7TNd52mOdsj8cSgKAzpq0wGvYWUl2PVd0AVycCNXfRM33/VvwZgeRzeCejhEPQl/FVgHJDUvwdKqMmEwGMtxFq0/AjbbbDkUzIoyCnrKiknYYrxVJkbmE75YHwvElTN69I+o0KJ8S9cFfUfyZmW2gfgXEnSXAurHLttr07e5xJEeFqBG+ekVTPE77FqjTz7Gz+tHQ6UpfSTUzZ5v2ra7Uf42BMXyLEqbUQ+UbZp8BTAOkJYbT61Uh9eOAvZSBro6lM3p/zKriNv5g5FjICOjiU8Pr03FBO3ovolfoJwwz4CJuB9EKPUjMMxZidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JYbzfCWuqS8KE3Nj0RWaVe5/Q4OtSt3QMwsAZExmTE=;
 b=XwP2OgW7mzhPUbIXxy+NrfDWGIhrcX+KMaF9awAIodXlFIvaHP7nWnPgxaaP25m8m2K3ZkhB/EincIwNzWqUi1lt14pLlUAt4uwtlQiAh+Jyse8Mum+2Gi+zSKudhwUb8A/mWimnzpu35KVVuSzSpYmNmBranwdgcaUoBMXfPpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 01:34:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.036; Sun, 19 Mar 2023
 01:34:33 +0000
Message-ID: <2802c4c6-99d4-e084-baa4-5be7c123ddd6@amd.com>
Date:   Sat, 18 Mar 2023 20:33:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] thunderbolt: rename shadowed variables bit to
 interrupt_bit and auto_clear_bit
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tom Rix <trix@redhat.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315220450.1470815-1-trix@redhat.com>
 <20230316102048.GR62143@black.fi.intel.com>
 <20230316103744.GS62143@black.fi.intel.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230316103744.GS62143@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9d98d9-172a-4b6d-4bf9-08db281a1734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 625GeS3J2g62nZJy2gBpDKQdwjJ6ruxmsLriD8x4oxDdT4DtkcGXDh2T3x2/HWYZV7BAeV0ZLFEpalJJj9vDWShwyoIlb+g5idGRJnlSyQ3sp95TllbZF+LweGjjVkSGx+UWOZV75XkrfwJ8basGPtZMuMmD0uKm12x9xoVKSWvsskq/kAcqz5HOBi2VDr4fFfpjitm2o+BM8HglI4wnh3zLVQkHpvCN52NMJTEo24oteAuvj8lz63L6WYlMjc3DnWzK6oka2LWtns3x6Fy4ce2Jb8zEwk2nlRCfVk5DaLGFljSccUb/Qf8k0mrrIGeQL7i+UPs+iGfwtSI9Tphiwy9f2bg4MfzT03dnCLAiRPDcn66Xh46eCmLaibsVHph0tUcviNZZ47TOMc8zq6XJFLtClXb6x+0Px2i1S2P8pvhbUqab89dpWtU/ZFHCluOhi/USqdqsgJTt+hbST43yLeYWYZwJQcnYLEEjRrsYTka2nJ7UmZYuG09f/ZHlIJdibwBllKpP8CRNl1Df7q4XXvvskKTPRIMgXQVq5ydY6CIHPcAinItLOTWl2RSUOdaVVwVoMR9YRLINnpdUGiSrpUbxR5Ew8HEuNw5ZpWr+4bHBLGwWBKs7LxDRsLE9msXIX8Byal1PmuhC+60QsZbXkv97WloSLjlnjXFjW02+ZLB3j5HH8agQFxwIXJXduDDgh9FwF2Af1Pu0sm+E5yvKFFZECeqQWsAWrcHu14IeL6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(2616005)(6666004)(186003)(53546011)(6512007)(6506007)(31686004)(6486002)(316002)(110136005)(4326008)(66556008)(66946007)(66476007)(478600001)(8936002)(5660300002)(2906002)(44832011)(41300700001)(84970400001)(8676002)(66899018)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzN4eUU2a3JOT2ZoRVJkZ1c0Uzh0Y0doOVlqa2txc2ltOEticThxamgyUnpK?=
 =?utf-8?B?ZElWSURlenFHa0R3clE3V2h0dWhQTmZyeldvWWY5S3RSakxMbVFrQnhQMmNV?=
 =?utf-8?B?Z1NDMXNHNUtBcGFXOEhlSzFORHhQNGdPWHI1NVVXeXBXdVpERzRFS041Wkcr?=
 =?utf-8?B?d09JWUZWcGl5Sm5lTUdsVmREUlN0Nksrd3REU1FMTzlJMUs1ZjU3OTgybFUz?=
 =?utf-8?B?WUdmZ0VEcXd3bklFM3B2TlVWbHIzR1JPUWVsb0FkTDg5WVhoelFYWDRYNVRY?=
 =?utf-8?B?d1FmVGpZblNqell5VlhMdG52aTd1dHhoYyswSEJIdExTTVpBdzhWNVFuYkRO?=
 =?utf-8?B?Wlp3R00wRWZ1ck5UQmx5dks3eVZISFNRSVBZd0lBMDQ3aEVpSWhjclpERG44?=
 =?utf-8?B?NmVjMy9OM1dDZGFuT0RLUDMraWNMT28wTFh0SFZTckhoODdrTDF2b1ZUb3pn?=
 =?utf-8?B?WWVCYWI3eWNwU1BYNWFUcXg0UEQzZmJPckNCUEM2R1NoWmtKQytxUkY4b0or?=
 =?utf-8?B?UnI2ZVFzU3NhS0wyVUNxTXo1bFQ2Q2VYWnJCTXlXSDJLT01FQUVPbmRvMXND?=
 =?utf-8?B?R3RueHhyQlhaakpLZFQ2S0JtekdreXdJdkFZaml6aTg0bmJhbW9telBjOExZ?=
 =?utf-8?B?Y2FmL0tPM1o0WnRXUzhZWDhYYnB1cUJBOVRaMVpOR1EvWXIrMVlvUjh5SW84?=
 =?utf-8?B?MkxWV0dYVXRHYS9ORURETkFNcGloaVN3Q3dhaVpUcEorVjlGUVU4cVVaUWhX?=
 =?utf-8?B?dlZUKytmTUM0a0VXbmdobEFXbGUyWlJJQ0UyVGtjUXRYRjhOWG1ZSXpRNjAx?=
 =?utf-8?B?KzRKOHBNZUxhVGg1R3lMZUNYWjZpZnl4NTNwLzIyWUkrelJCdWhsa3RvZlZn?=
 =?utf-8?B?bElSYlFHQ3pEdDBYK3ZjZG5KSTUyR2c2U1ljeFhWaVVBQjlxOE1hSHBCQ2lj?=
 =?utf-8?B?UUloQzQ0a1dLU0FxM3pKb2dxa0tmd0N2Y3pWekoyWnd2cmJMSTVYU1BwV3JX?=
 =?utf-8?B?MnZJR3JkdFFHRnN6Zm1DdGhwek1VTENObDNsdGtrUTQ1UmlEcTVsVWpUcXR5?=
 =?utf-8?B?Zmd0d3ZzSUdiUjRDcmpQSkxOQWk2aXI0bnptMUgrbHdGcXAzNGQyZnF0UldO?=
 =?utf-8?B?bWdvbHpCRUlpOFZKU3N1RjVvUkkvd2NrbjhRbUdGYitvSWJram9rRys2ZENL?=
 =?utf-8?B?dG5KSVlneXhzNGt1TktjRC90MHoxaVE5b1hmeXpOaHNtRGM5bTF3SUR1RkUy?=
 =?utf-8?B?Z3dKRjQwTXdYQlVMai9HUFJtVExvYm1yWmJjS0FtY0QrN1YyZVM2dkx2R3Jr?=
 =?utf-8?B?R0lPL2N4TCtWUDVMNk9HbmNEaGlQOFBLcGtSUHhKNjQwRGRMNFRQK2tKM2xs?=
 =?utf-8?B?SStONCtVT1RCaFY0MGNaYktaVjIySW5yV0hKeDNOd1MzK3l6M1FXTEFRL1M5?=
 =?utf-8?B?UGxkRXFicjhycEFUWjB6K0ZLYmlUZml0MEx1aE5BeGFOcURmZ2lydzl6dWRv?=
 =?utf-8?B?RWwxMlIydjNDWXV0U1JmeVpKQklwUjl6ZSs1R2h6THM4QVFjUzBwU3FoR3l3?=
 =?utf-8?B?MTIra0IvQk9LdFlRVzVlUFNHMVdOZE40SmtyQTg0WmRnK3F6cEZGSG5aVkVM?=
 =?utf-8?B?TWZ1d2JkMk1wZHArWmo4M0x6cXFnU2NhM25NV3lieGUyc3JneFFnSW5hWnJ2?=
 =?utf-8?B?WFgvbjBBS3p4aVdtMGE1QXQrWEhzSlBQZ3htTnU2Z3RGcmtBVHlRTjJYVzVl?=
 =?utf-8?B?NDRpQ0IyZjY0cFNDMmtjTGkrMk1hZkozSG9JcUZqTk9MamlwdzN6N1ArcEtD?=
 =?utf-8?B?T1Blai9WUDlIQmlkNnVSSllhcVlJV0g5RWl5NysxaEYwZFRDTXZjVEdPcWg0?=
 =?utf-8?B?MmRCaFRsRFNMNGFObzFtUTUzOVdvYTJiV0QwRmw2VmhTMS8wNG1KUHMzRytC?=
 =?utf-8?B?VkpZY0tmL1RsK0RMQ2VHdjFHSkNMSXpXTmVWdE9maXNPTmdDOTdlcCswL0Q4?=
 =?utf-8?B?SHFVTzFNQU42SDF1UUttL2lnVlVyZ3BuSDNLeEVjNVlVTVRrb0w2Z2l6ME5x?=
 =?utf-8?B?RFlnakM1U1JtZTNpeCtUQTA1bXcxQWtmUmhvMDZlUU5ISFc1bHdIS3lqL3Fu?=
 =?utf-8?B?eGhrYXlxNCs5NGdsMmRzTmkzM05tY0x5dW02UE15bnRUME1BOWNmVnFPOUhn?=
 =?utf-8?Q?+XNG0h0uEL48/4NmesXDq4ew2lgqpBSmU46A9o+O2r1U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9d98d9-172a-4b6d-4bf9-08db281a1734
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 01:34:32.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ut8xYeQgJruLQZBVZe33YUIGmEOYBD3OfZjv357P/F/n6bBibTrYdJimV4qG/yd6fI07qiTFxeJRn0LDEMaU2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/16/23 05:37, Mika Westerberg wrote:
> On Thu, Mar 16, 2023 at 12:20:48PM +0200, Mika Westerberg wrote:
>> +Cc Mario
>>
>> On Wed, Mar 15, 2023 at 06:04:50PM -0400, Tom Rix wrote:
>>> cppcheck reports
>>> drivers/thunderbolt/nhi.c:74:7: style: Local variable 'bit' shadows outer variable [shadowVariable]
>>>    int bit;
>>>        ^
>>> drivers/thunderbolt/nhi.c:66:6: note: Shadowed declaration
>>>   int bit = ring_interrupt_index(ring) & 31;
>>>       ^
>>> drivers/thunderbolt/nhi.c:74:7: note: Shadow variable
>>>    int bit;
>>>        ^
>>> For readablity rename the outer to interrupt_bit and the innner
>>> to auto_clear_bit.
>> Thanks for the patch! Yeah, this did not show up in any of the kbuild
>> tests perhaps they are missing cppcheck :(
>>
>> I'm thinking that I'll just move the two commits from "fixes" to "next"
>> and add this one on top (and drop the stable tags) as the code that we
>> should be sending to stable should not need additional fixes IMHO. I
>> know Mario is on vacation so probably cannot answer here so let's deal
>> with this when he is back.
> Applied to thunderbolt.git/next (along with the two commits from Mario).

Thanks for the fix Tom!

Mika - It's unfortunate that a fixup was needed but I'd still like if we
can get these 3 commits into 6.3-rc and also to stable.

