Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0A5ECEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiI0Uq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiI0Up7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:45:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582AB107DFA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbU9O1vL7byOsAjsfSYb5Td86DTB7yelhMYjCOXCr1ZQ0gZFetJXS5M46rVf5Oowy6p/iqXPOX0VnSekduQh/sRE6zFSprYdb8i0C735kFGsEAEcgsT7kXgPGraEH+vuyV95oX1rO/UUsxVzHf/5lx5WJ6FaiaCFA1ZWpK8REh6hEdDYCcaQ1GGeBkswLxa9P0jxFlHrlG8mAhYgpmwEWl9eoL/XQwtlRfor1gyyplkcVDcRFvfagF3j/yRRg8yi1YDqoTDcw0u65aocqCLyClxKQeg7CCSm6yVutV0J4m8KNGzotgQtMEDribmQvoGTAaptIkVD77zTPeuBtii3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HCrL2EmxLMjSddcWYXAGPW1YYq8nk5LbUo+8uvB8nc=;
 b=Arp6gW8TzMeYD6jHB+ApD41AeuqAXLObB5UDmXY4RuxIraLEtJJreyOhXkhdKdQqSjwBQbHwCxbjuGxfBtaEcuY6tnltJPE9pubGsLaLbixlujN8cHawHadRrcatzk2+3EkC2hpC3WxMIvLn1L3EW0aLrtyRrPlEelTXKgh2WAeA6AgcIAXa6NbyOztWlM+NrzGwyeEV+IFC0fF55QGoThDhzTxo5Ghqr0xRa1qDidrR6PKPZRiPuVkkGD7B36nE68J1fVDMziD6XxdBxdzMBykbUgYcykcl9fQgdgZnBVB7oxMmyc5J+Fy/870x+eGDm4ixncoGgmNH26HVINZ8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HCrL2EmxLMjSddcWYXAGPW1YYq8nk5LbUo+8uvB8nc=;
 b=elUaPJygSwfWR0OTa5tqjGozY6iTfbl4o0iqjvbO2JXQzgC89KJmBf4a+IpKkQyqBt5PTUF8Zd/HMfG5xk/+LDLOCPzxHaLpkE27N+pCAnd+HayGQ6DZfODifTCfkU5RKzNYxaLKgialyEsB6vbd8FTBXbiu4rseiAo0NAkHSHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 20:45:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 20:45:53 +0000
Message-ID: <30026d7b-a736-5660-2e5e-7e9fcef10101@amd.com>
Date:   Tue, 27 Sep 2022 15:45:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/6] x86/sev: Fix calculation of end address based on
 number of pages
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1664298261.git.thomas.lendacky@amd.com>
 <afd222473c7b18ea942e754a6c4df26ed74eedee.1664298261.git.thomas.lendacky@amd.com>
 <51eeb843-204f-5b9d-9f7f-9bf3c22d2c00@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <51eeb843-204f-5b9d-9f7f-9bf3c22d2c00@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaa0be6-9aa8-460f-32c5-08daa0c9447b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQGVUrn3Sq6n8DQJz34BUR424KmyL3zn/8c5htw8Xl+IluuazqW3fQ9YfRcj1rxcIZG8UIhqfC2tVrRFrpvYfSSGL532rwK5DzwV4XcfK8Q9Bu796XU8cUdQbOmyl99KAeHK87TEZyFoY9EXeZN/4dI5EC3Ao9W5j85PktHJ/grkF9cUE0GGGhNJzkjX28eUWnJ3J6emxn4paBpiWP0jgvNHECMhLmMuBKedWoNsm3t1gUkuruzCHKoanNS+ZxyVnuaIcTk7O8IaAv5PAdPM/+CCikWHKab37Q+9WAedX70O1s8lHZ9o2ACp7cYv3vEThdl6B5POQwt9BatrzVW3FdUgWm7Z4+/IbMctLDqtUEW4uItyZ7ZXqDLIYumS/ZkIfneWcqgmT98CHVZ08ZqsZ0UgCwkCLioiq13PIkrDXtgHnUWvkz9gcBqIQLIYsYGFnLy48L8nz067RJLmrPqrQAmCC23YXcGq6VCeB478pVdEE9TFe4Vgxo5TDPpYg2f1MIur57NJ2WwAh/jKuBQXupsxH7rdyvdH7XL/zjzbzDBWKGTJMKGnRqTqiLqFpri2R8BA7HMuz4aQ8wC6fLsIVpSsYpXm/zq35G+usbsOcFgIIUZXvTbV/BE9wWA72jpfNSA8oRXhvFzAfx8q5TOsFM4fXV88bVtgAoY4RUUhT4w7MQ/YXLUsmUsfujz76AK/PI05dHnV09vu9e3ixK4L/ldWbKULEzln3IOIh+uzNZbyg05G4iRJjppBeMRFooPiz6kR/G6lDBayhCXCWf6Y7plHDTWDViTqXGtcY790OoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(83380400001)(31686004)(86362001)(38100700002)(31696002)(66476007)(36756003)(66556008)(2906002)(4744005)(6512007)(8936002)(7416002)(66946007)(5660300002)(4326008)(8676002)(6506007)(316002)(2616005)(26005)(41300700001)(54906003)(53546011)(186003)(6486002)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZ0TkI1Sy92aC9aRUlqZ2FEN3Y4c0xsKzdsQzIzZVNJOEwvVUR5T2VxakVm?=
 =?utf-8?B?NFZjQ2J1aUFUa0o1UXVXaUxMRVlQd2VKSytvUEx4MlArSklVbERoTTI2SElP?=
 =?utf-8?B?RjZ6MFZzK2hJalNrajF4dU96QzMwNEpsMzRwRG9oT3l3WUpwRE5DU1V1RHlV?=
 =?utf-8?B?enFaLzlNNmJJcVRQTldHdENPRmpxdzdwYkJaVDRCQXhIMHlzeFVDRzZDdnRG?=
 =?utf-8?B?REZLTUhUcGk3ZVRMaVdVSWZQNjBobmE1OG15QzVhVGhTUzFTT09BNytab3Vs?=
 =?utf-8?B?ZVQxZmhZdFQ1NGNQNkZvRnB0UXA5MkEzTnVUcDZRUGwwMXYxbjZWOThQbWIr?=
 =?utf-8?B?NDhPdWQ5TmNxQ3dTMmJkSWorbFZVRXpCZFc5eTNZaWczM2c0YUNEb1piVVNU?=
 =?utf-8?B?cXBwdmw3VDd4ZEJDYXZ3VlFrRXFtVWp2M05iY0xMWTNxcmJxUE5ldy80YmhY?=
 =?utf-8?B?NTR0QlhHdlBhdTZNS25uT1JhczR3R2lNMy82eXJtUUZvdlAydW1ILzlhRUQw?=
 =?utf-8?B?dnhJVDZ0L2huZkdLNXF3OTN1MVhyejV1UGpGVWxUN3ZkRm5Uc2hnY2RNeFI5?=
 =?utf-8?B?ckRDc3hpMDJxYXZOQmhLVktkeU5NU1RiSVQ3YU5wd1JpRXJWeFhISFNHRmxq?=
 =?utf-8?B?Q0xYaTVoKy9KUDNDcno1a0F5VjlXcm5EL0JpdXdWV1BSMlhnUkN0QmFQWmE3?=
 =?utf-8?B?R2ZBM0x5b25zV3hMRVgvQVBCY1hwWSs3Y3EySTNiSTlqWU0rZzFKM1pPUXRh?=
 =?utf-8?B?UUV2MElTQk5zV2lRTUtmM01DTUJaQnIzb0NQdGRRbG9tL3g3N0lzeWdOcCto?=
 =?utf-8?B?Sys3OUpoMnBjaGliRjZMTk53UUJDTjJJWkRzNHVlNEpndDhnUHJCQ1hSMnJq?=
 =?utf-8?B?Z285Zk9qNGZ3Mm9Ka0xsY2Z6MmJEeFQ1RUpWTXJ6dm50N2V5Y3ZZbnJ6KzRL?=
 =?utf-8?B?V2RnUFpPeVhDWnJHdkhucVpkRWZ2NEdCRmg2cnJxdTNyTW92MnNReVBTekRl?=
 =?utf-8?B?d3cvRVE1d2hWRnlERUZWcWZOQXBSbWhQTWV3MTFXWVZCZ1hsUUZjUDMwVXRw?=
 =?utf-8?B?VkgrYUtYTE95eVF6emlUUStxZG1iK05tbnN3ZkVjYXpKeE9MdkxIRXVseTZr?=
 =?utf-8?B?dGJxU3N1dk1rVjZsazZUU3FESlE1R2swRExsMjUzbnBpdmEwN3FxbGx3MU5J?=
 =?utf-8?B?WTRSWDNBVzFrRjlvUGJSVmFZUExSZlBySGZXWjFKT1A0djhLS0doZ2RtaUpm?=
 =?utf-8?B?ZmFGNDFWaDdRVjYxb3JiZ1BsbHdjQ1VaMkM5QTZWVStNeU5PU0paOHFhZE0w?=
 =?utf-8?B?VmJ3VXIvNmllYWVmVzBhalZJcS9VdGtxeDlFMUd4cEJNUnJLZFhnQjFtcmhj?=
 =?utf-8?B?M2ZVdWp2dUVWVHpyakVaVU5jeHluanBHbVYySm9scWg2bXNBdVY2NU1kUVBz?=
 =?utf-8?B?WlQ5RE9TMCs1ZW85ck9RRjBtWHV1V0dDeEFsWTlLVkkrU25NS2JXSHhWcEJN?=
 =?utf-8?B?L1hHeElzOFdFNURpTDhxT1NYdExBVGJGQmdOM1ZaTm0yUWc1Tm9qM0lTUDJp?=
 =?utf-8?B?YzVWT0lOdE1NSUwrZlZZOHhBWXZXTDRjMGZ3NWQ2bHNiTXZnYkNmcW56VG0z?=
 =?utf-8?B?QTNEdUwrRGtqUTl4dk1BdmkwaStqaVJqVy9VTjRibGhaS3E4OC9TVnE5MDRj?=
 =?utf-8?B?SWcva0RWckdFZ0w0b0JPWElEUDV1R3VzblY0UVpTNFU1Mmo1L3VQeGtFNUo5?=
 =?utf-8?B?SzdPYnNQRkZFSVVGOE9qaXNPM3hUcUtzVDVnbEVHNzNmTVY0N1pGK21XQ3FX?=
 =?utf-8?B?cjh2aTk4S1RsSUhQNUNnalNDbnp4Tk42U3NjKzdlTTZEWm1GU0IyejhlWU9z?=
 =?utf-8?B?RHNGdGRFdjJIeDRTQ0hUbjFEa09UN09CMVhhRndMbmNQdXR1U0cxVFZPTXNx?=
 =?utf-8?B?bmZockN3UVovK2RPckwxVlplSnRKYzZRM0Y2a21MM1VjL3o1bVJGdDE4NE0w?=
 =?utf-8?B?c2tqSXg4TU9EMmlsVlIwMWFxZXpaYTBmcmpaaWpRL21ENk5RUGRWTDV4UFBn?=
 =?utf-8?B?dHQybk5ISTBNOTAwWnVmcXlMUGoySlBMZ3huTExMd3NVNmREcGF1TXl0dHJO?=
 =?utf-8?Q?1+30jgP0u6+ZKHQG/3xYDwANc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaa0be6-9aa8-460f-32c5-08daa0c9447b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:45:53.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYjedV9URQf4r1AzlwFZdooZ6KYlCDs4hNv83yxBO0+OUET2lbPMfNpAO/CSpCh9AIHZ2o0/AUmgfYW8WNOC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 12:10, Dave Hansen wrote:
> On 9/27/22 10:04, Tom Lendacky wrote:
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -649,7 +649,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
>>   	int rc;
>>   
>>   	vaddr = vaddr & PAGE_MASK;
>> -	vaddr_end = vaddr + (npages << PAGE_SHIFT);
>> +	vaddr_end = vaddr + ((unsigned long)npages << PAGE_SHIFT);
> 
> Could we please just fix the fragile typing that cascaded down to this
> point?
> 
> Shouldn't 'npages' in this interface be a long?

I'll take a look at that.

Thanks,
Tom

> 
>> struct x86_guest {
>>          void (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
>>          bool (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>>          bool (*enc_tlb_flush_required)(bool enc);
>>          bool (*enc_cache_flush_required)(void);
>> };
