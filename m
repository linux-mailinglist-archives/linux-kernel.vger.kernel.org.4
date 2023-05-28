Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49D713974
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjE1MoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 08:44:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE51B9;
        Sun, 28 May 2023 05:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhUcuSOh5XYiQ4m5qaB+Y5klsFxkx7a3z97duU9HX+SERBd91M/FDWCEnMZyzT3KboNtZn5+nfcB6IV2fpz2f1awPOGnKqAG3aTADzPoocdtErc0QsD2NtTODb+mwZo34ObbnWbpM8x8JR9yYzbIvN38k0vTIbCAWeqbkcwxjYROFcJPBl05nJrrn7Yel6TMIRWSKIAatLyZQVn5EwJOy4lQ3T8IxwBjV4KuQX4M6okQyvaEKRttWsHp2S9d+iOZR2fhYuCcNQjOAs0TuQh2K146qLtcxXk1cuHqpkhWYHUUNTMdx0Mhc3dquZVNKXdV7nuIy8vhBSUJ3Gdx/niOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3ADXnT76gKJG+XW3nvG74bDwmaYj1pk4rChzsQGITk=;
 b=nSlq3LM+Y1F2QwvvOzrLg41vz+Uh6vxgWIRN/Up6x2yb3YCgwUYteiA3MV6HLzymeksKA/EZvCWVvDvuCMUC5x0nALk/sVgS327KMlY5BoW3IeSz2qo7AwX+tvTAz1E9SSgmQXOzNGeeJh8HeiEOgg8Z7fLm/12G3tgmetK1WeX8IYp08bAk70Hb5d2cvfJ0tQjrVHG5K33aHvvJID4rGTjLOrtzujh+2zavqj/i+ILcW/32JskeuocAiAllm0PtaVGiJhhwsEmQgrnvNMu0gD5R8hiZA6UgAUHXU6IKr5lSVgH9prY9iWNlElgXw8K7SR0nLGD5pyxrNl6ekZm8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ADXnT76gKJG+XW3nvG74bDwmaYj1pk4rChzsQGITk=;
 b=Z5eiVoIyDMi3qcsX8piJWNPfDOwGApjY0tB0/ONJCkZWXN1XFaavWA9KmLnfN1LPCoZiAsFXbdWM36Q0YhtwaXXbDg61di3YG2cUQYGLnjNY/tfy5v2wlptWqMyHuTtdzvgefYOsALzSh7x4nS4mL+LD4U8bdgTlE6J6QYjg1TY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sun, 28 May
 2023 12:44:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Sun, 28 May 2023
 12:44:08 +0000
Message-ID: <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com>
Date:   Sun, 28 May 2023 07:44:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Nick Hastings <nicholaschastings@gmail.com>,
        1036530@bugs.debian.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZG3mbc3zdR4KcUW/@eldamar.lan> <ZG6cY8xjfob4Bvcs@xps>
 <ZG98fQ+MD4O0nGGE@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZG/8cxxTJ9ZzrVPQ@xps> <ZHCYRmD7YeIWoy2W@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZHL5cCNUzVdleiag@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fbc910-d1a8-448b-89ef-08db5f793a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUnGRGPRgsuUlCrVsPZgtZZxxc52o3/beYi+DxEtdFknAA/GA4XppxOyuWhSa7YIHU0SlgbacrnfZUX5ZYSmmfFxdp/jv6P9HLWoBAdxl/foAAJ8JIP6hR2U88vMjy2l4NWtHsK0eMfv+1oC/Ki/5JWoxKs2Kh3wyaaFAUq7sP0B2DLDLaYdC9E8uEc+JXR955rwhGvyQT/FA7GkAp+Gaj0ZwoY2LF23WZ1/+JOwyorxWVux84Z2SWcAMWDz2zqH/ALvkzUZlBABzTCr3qPSIHGmcGkocJYyYsBKXeINisLMo9vN/xy7iKU009r9GSkSO/duYyHg6omNP2GWtjsL1SqOQcz9BtXtLq6RxTtf9olld/YCHK0z4OKVCyRRtAnXPq92ekdghfub9BKa6vjapbE83u7919p1pdDEZqTkIeG47jmAvqClxPeR5bZB/7LCH8EfRwV12N3mGG5VlhbhRcGyTGpDYI0yGlzowHFhsSD+3+FZKWBmomYbFRvLTL5rlD6L9+mosbmnHTuh0895257WGn7t2yRgv4wHp9nIP6HmqQyL2OZ4u3awY+ZU/0gt65nM7+ypag2ypAiJ6MpvgSnZ9Wsecrc7hCcZ7uda5UhXGcZMagMhjTNpHDv9FXC+I9laLRsZhHmdZLJ2ne/I3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(83380400001)(5660300002)(316002)(6666004)(66946007)(36756003)(66476007)(66556008)(4326008)(966005)(31696002)(8676002)(6486002)(41300700001)(38100700002)(8936002)(86362001)(44832011)(110136005)(54906003)(53546011)(2906002)(2616005)(6506007)(6512007)(186003)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUc2R25lNm1STytqWHRrWHdta05ZS0k5Yk5yZDBDT1hTNklJN3loNzZEcG05?=
 =?utf-8?B?SVFEN1V1ZURDNHliU1BZWVVNWkwvK1I2Mi9Jd1MxYk9zeXRVaGt0dGJoQmI3?=
 =?utf-8?B?eWJsZXJpZWkzU21zRHFUNjZHOFEvc01VMDFYamtvSnB1UVhZbWNOS3F5UGhT?=
 =?utf-8?B?VTQzVnFXM1VLN2YvVldCY0xSTkZHeHE5MTJGSzVZUnNyc0kxclBiRHdZVGt2?=
 =?utf-8?B?Tk4vT3k5MXlKVEN1bG05aWltbmFhSnRoZyswZXhZYkVja1NUNGs2d3N1K281?=
 =?utf-8?B?UHZ5TXp5WkZiQ1hqTXpkalFjSVZ6dW56aktNTVRhSW5pZXF3LzAvRHBRYm5t?=
 =?utf-8?B?a21hNklFZFBhUk9rUDlwNUJHMk1aNlVqVUNHZ0xRN0xTOWc1dE5QeDFhRVJF?=
 =?utf-8?B?TTV3dmJlUW9kaXdEOUd2blN1dHE1NVQ3em5vVzNOTEI2UDNJYnp2Rjd0dnlq?=
 =?utf-8?B?OFpaNWJYMmNoSnhISklEQ0lFSGVRTldmTFpaRFQ4UUJ0Y0FhV3lhYkU4Slcr?=
 =?utf-8?B?aVVjZHhLNlJZalErVVdUU0I3Z3Bkb2s0NzlmYytmS2hTZ2lwWktWSVFObDBp?=
 =?utf-8?B?S2laekU2ZUZIOE9pSWtucTBVMy8zSEdDMlZ1TWJVZVNQd3d6ZHZlQVBKVFdp?=
 =?utf-8?B?dXc2eU91ZjlSSXhTRHNOMks4TXhtMGhGdC9PTG11VXZCVG1aMUJKV0ZZV2NQ?=
 =?utf-8?B?bjZKOXFoazdDVlhnTEttaTdCRW55Ri9hcGdzNk1GY0t0bHl1VFh3cy9GQVU5?=
 =?utf-8?B?S2NqVk1aTmUrdzlTVGpIVHJ1NjVZZGdycDhVZnk4emRnTzJ0NGpsNU9IRmpP?=
 =?utf-8?B?djF6MWZZbmw4amN0SXZkMnVWUFhlRlNGeVBPQ29LSGJabVNYeHBEMG9mR0pi?=
 =?utf-8?B?bEtkaitKbWhkQTZyMTJKYytLdmUvYmZVLzUzaGx4QUhza1k4c24yVXVYYkNV?=
 =?utf-8?B?Q0w3ZUxPWVROQ0lzOTFzdHpxTHZVMCtpQVdad1BnM3dYUVpnV3R3WkY5WGNO?=
 =?utf-8?B?YjlrRzlYN0w1SFEvanJaSFh2T3krVHpsY2hoYVc2VFpocGNUYU4rSXpxUCtC?=
 =?utf-8?B?bVpWemFFOG41S3JWa1JRZmp1bWdnYmhxK1NLQkFQRzJ6U3pncTFGVngwUGZR?=
 =?utf-8?B?WTdQSEtFQTZua00xNFM2WUVFTDBuZ1AvZ1Q3TndyWnBHN3ovYktkM0lPTHhD?=
 =?utf-8?B?S2U5SlBUbGdlbUplYmdJQ0tGazZMRWU2bjJsZHZCUlV1MGdXRFFNMVNvazhX?=
 =?utf-8?B?bXFQWWdPZnFOTDAwUWcrVUhkcWszam45RUovMEQyZGlkaVZuTVpLWlU2cmox?=
 =?utf-8?B?RzdWaFBCdG54WlNlRlY3N0FLcS9QZGJaV3dvSjQrMDFCWUtDOUw0SGQxOGxP?=
 =?utf-8?B?b24rOFFnWmFDeFkwcUhvN1BGYllqRDlaSG9ZRTAveWtxWVNtdlVhREhwZWwy?=
 =?utf-8?B?M1FMU29yT2RhNWlWMzFFOUdwZm5lYndGVzZXbU40bk4vekRKWEVnN1BLeCsz?=
 =?utf-8?B?M0doVC8yZHJETm9tcmtaSnJtbE1xcG1TeGNRT0szMjM4N3IwaGMzT21zM2lF?=
 =?utf-8?B?WWNEWklYT2NSNlFQc21BVldZZnZWVHpFYW5XaUdpZzRUOGRhejQ2d1JzUWc4?=
 =?utf-8?B?bkREUnpERFp0WEEvR1RNaFFRbzRhUUc2ZVp3MjdSLzZGYWduSXMydWpoeDd5?=
 =?utf-8?B?bm5DTXZIaUJsRlYrRjV3K1hUajROdjJ1ZjZYUmtGZmg0R1lOMWwvZDZ3cGtF?=
 =?utf-8?B?RHJCaHUyY3J6eTFDN0F0WHplVHhKQ3VWOE90eUFHZlBHYzFHMnNianA3WjJE?=
 =?utf-8?B?UTQ1dFpBbFJmelNSZVAvMm96YTBrWFNWRFZ0eFl1UWVueHdTTm02VnFBMlZQ?=
 =?utf-8?B?blRrZFNjZUt2UHkxS3IwUWQ4SnZHcFhBSEx3YURTWUNBZVhPMVo3ZlNUdVcv?=
 =?utf-8?B?TUdEejNrQXN4TGJXajZ4OWdMZmFHcWRweWwvTXdGcWpNT2FjcDAra1hhQjBX?=
 =?utf-8?B?bWlXaElMdVFWYjFpQUQ0TGRpQ21BZFlwb3RvejMwRDFrNWZRZXRCd0ZKRTNZ?=
 =?utf-8?B?ckx3K1UwakNyVnFUU0NId2h6d25vSXVvZWFmNEJRVVB2R08xT2taVXpyM2l4?=
 =?utf-8?B?emF0OTJHTjhUc3UyUExFTjFZUUtyeVFCcVg4UEgwOU43ODdQRlFoZmRKTkNP?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fbc910-d1a8-448b-89ef-08db5f793a71
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 12:44:08.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0E5pb0ae37+dpGg6DVZ7vtRlc6mo8hqZOETrN6MMypwaMlNqYuS+zzQJqhbgM5jTR0Ndn37YzVUuskE6ZaJDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/23 01:49, Salvatore Bonaccorso wrote:
> Hi Mario
> 
> Nick Hastings reported in Debian in https://bugs.debian.org/1036530
> lockups from his system after updating from a 6.0 based version to
> 6.1.y. >
> #regzbot ^introduced 24867516f06d
> 
> he bisected the issue and tracked it down to:
> 
> On Sun, May 28, 2023 at 10:14:51AM +0900, Nick Hastings wrote:
>> Control: tags -1 - moreinfo
>>
>> Hi,
>>
>> I repeated the git bisect, and the bad commit seems to be:
>>
>> (git)-[v6.1-rc1~206^2~4^5~3|bisect] % git bisect bad
>> 24867516f06dabedef3be7eea0ef0846b91538bc is the first bad commit
>> commit 24867516f06dabedef3be7eea0ef0846b91538bc
>> Author: Mario Limonciello <mario.limonciello@amd.com>
>> Date:   Tue Aug 23 13:51:31 2022 -0500
>>
>>      ACPI: OSI: Remove Linux-Dell-Video _OSI string
>>      
>>      This string was introduced because drivers for NVIDIA hardware
>>      had bugs supporting RTD3 in the past.
>>      
>>      Before proprietary NVIDIA driver started to support RTD3, Ubuntu had
>>      had a mechanism for switching PRIME on and off, though it had required
>>      to logout/login to make the library switch happen.
>>      
>>      When the PRIME had been off, the mechanism had unloaded the NVIDIA
>>      driver and put the device into D3cold, but the GPU had never come back
>>      to D0 again which is why ODMs used the _OSI to expose an old _DSM
>>      method to switch the power on/off.
>>      
>>      That has been fixed by commit 5775b843a619 ("PCI: Restore config space
>>      on runtime resume despite being unbound"). so vendors shouldn't be
>>      using this string to modify ASL any more.
>>      
>>      Reviewed-by: Lyude Paul <lyude@redhat.com>
>>      Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>>   drivers/acpi/osi.c | 9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> This machine is a Dell with an nvidia chip so it looks like this really
>> could be the commit that that is causing the problems. The description
>> of the commit also seems (to my untrained eye) to be consistent with the
>> error reported on the console when the lockup occurs:
>>
>> [   58.729863] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
>> [   58.729904] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
>> [   60.083261] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
>>
>> Hopefully this is enough information for experts to resolve this.
> 
> Does this ring some bell for you? Do you need any further information
> from Nick?
> 
> Regards,
> Salvatore

Hi Salvatore,

Have Nick try using "pcie_port_pm=off" and see if it helps the issue.

Does this happen in the latest 6.4 RC as well?

I think we need to see a full dmesg and acpidump to better characterize it.
