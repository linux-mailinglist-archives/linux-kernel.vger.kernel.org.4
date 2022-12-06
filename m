Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458B6644D54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLFUgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLFUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:36:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABD762FA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m01rukIvzBhvQIpIU5wiuYujZROLvs96xl0pLauQaVZUVkvTwvnx30QXWQ33TtNFG/dh7ClHNj4dkIca0+kaQFkRP7HI0K4Q210w8t9kNSU74I/nfg7L2EkZD1JCrC9vh+SGvHDW6CeLWKBH/vxuVmY+JLO+qFd0IqXuo2Bm9jkKHRaShg6Y7yXjgoUxvRRYvnCJdgTkcaVJlxBtuB1iEcNVrxesLjJnDPbHP/GN4gBArdHF/S4lhhVp+YnAyxgUPqhi3dETPvg4hVCFTOnF6WOqmKJeAYThIr7P9j6Kn0fkgKpTyjxG6erdEnWFOuM+DU6bZi8AdLtTtZ0OPFarTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehTgKnsPmb8AVjpsKt7QMK+dSpqLjAviY1LFVmfjNsY=;
 b=CNMhXf3oNnZYxVWDqWmMLXLRNTyqYM7qslFKYCcXUm+9qD9eEjLZ2Pa8/PCWDH1G2DQZnaa0H8KKKWwnWYZ6SHMfvnovVlPwerYXIldeBn9crsa4SvCUMARHcAi+uXX/82MJSapvQWgCGtw0OUGWVgMqsCwfyEVu4G2OCyoBxmPBmMuIrZ8T1f6/gSYdgAqhr9MftAtp4ng9yQPNB98Cjf4ulFx5BAHyXfyu3OO5tnqxS3LCBSACW1mPNi82xO0zGvGs0QKUAZIPwxmZ7QFhH0LoIxDeGh0FDFqh8Ah/1hLpUyOIyAYbHBOYDPwfWNQrlRemq+YLQo2f7/I4lroyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehTgKnsPmb8AVjpsKt7QMK+dSpqLjAviY1LFVmfjNsY=;
 b=SSpXByxvU4vk18jjQvTlglWNULXnNS/QukKSUmJABKS1fDKwBCLzwkoiNG4wEQSlJdAUexhaB9hmPcIoZshZ4G5xSAhkw0SFHFBLWQVTu4meqpcPr3POBWPDiSSON94RS3QxYHCDwGKFPKaHLZXhn34pZGD2J9XD9lu3kfOrHtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 20:36:36 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 20:36:36 +0000
Message-ID: <c23f2bf3-71f4-2346-b940-73df1e173ba1@amd.com>
Date:   Tue, 6 Dec 2022 14:36:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 1/4] crypto: ccp - Name -1 return value as
 SEV_RET_NO_FW_CALL
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-2-dionnaglaze@google.com> <Y4tAX580jEGHOU9d@zn.tnic>
 <CAAH4kHYz-46syE4wKPzo1N9P34wLHcs85obOCjqb6eQ=iv=n3w@mail.gmail.com>
 <Y4ulj38eMr1NiRdX@zn.tnic>
 <CAAH4kHbZM9YW0BvwxrQNFysHwB8JkPJzFRN9RdwhmixhbtsCyw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHbZM9YW0BvwxrQNFysHwB8JkPJzFRN9RdwhmixhbtsCyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:208:329::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccd7759-c425-4eee-8781-08dad7c991a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgVXfKOiYdIFe2xKsmSyvztpg0l3BPsFNwyGvHB0kvH+0FEQxG+nQT7gejOece9PtpiKdLHkITXfnRCmfaDwsoQj3W8T+j5i5atSNlM4kVUzUPAwJ9FHTSAiorhpv+w2fLhw15J5kGpikpx4fTPJKFc4iJ7FHkgGRcWUgdhvvSg5FiuLXeNR1ecAFvTv7UIWZzMlykIqWkFY+rw6LB8Z+lEJKSp6A+6UL3yrOE/LpQfJDa7lZrx+/ztdN9VVGh928H31BSRpt0RXsz4I6ETxkCBNlh3tznnj2i/D/FVF4FnbNQpoLnm7ajgwJPUl1uutXDzLGJOEKAJCgSBNdx6rdNkA7XhNEgXWL3FUw2p0DAzHcuxhGq6/iyqQHN6ZtqDYoyiM/BnOjqhPuwHdBK64VHZNKPmHArSf87kcg1kWbscWJ6eFlkp3Stmcw1XehBAurkEPzbVJ4VzIL6Jc7Xan/o1nbdFvxb8Jj448Hz6HQHrCuVS4BG9jToPdNizyS8Gbj3pvzHIcCmk7p/8jCt7WoX3hNRSCYPm3RXgJwJJG8z4rVL1ogRWPmBU4l0LlffTkKfEcvA+gwU6QQMGebw4kSe2vEuoA7WDVnUf9WHH233pi3beC5zJErup4TTlxYceEpG4OzLKLPKgzdEB8qXbGHIs/0y7LjRxOb+11o81b5lZWYbHGWvDfCY1RNUL/GMYWqAH1I8+dNermGEh9PtjKUyWwfYjZN4SXxvA4tJKMIwee6bMD69jvI+kUm7WmCp62
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199015)(36756003)(26005)(86362001)(31696002)(6506007)(966005)(478600001)(53546011)(6486002)(6666004)(41300700001)(8936002)(8676002)(6512007)(5660300002)(4326008)(7416002)(110136005)(316002)(54906003)(66556008)(66946007)(66476007)(2906002)(83380400001)(38100700002)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9sdE8yWHYyekljTlh6enZNU2MvMGlGcnArQlBrMGtFRFJiV0xKNHJGS1Jz?=
 =?utf-8?B?SVQwR2kwMWZoWHFMSTVJem5tR2I4emkreFhTQml5NmswVjJLbll6clMrYWxr?=
 =?utf-8?B?a0EveWJtNVpzRTJwcFFPV0haUlhhTllNMU54R2NPRjVhSnA3RW92eDRDRW9l?=
 =?utf-8?B?cXY0T0UwWDJyaGI3WVY3NUVRN2Rpc3h6WFJ1QXZsaEhlRWlCdE80MXp1R3pH?=
 =?utf-8?B?cTlSeW10V0JVR2ZGOGh1eWVIYjhnVG9TaUt6QTJxQjFRWjV1Vm1NYkZ1ZHFG?=
 =?utf-8?B?bm9HelMrdFpvL0NZbjZIa3Vpb2VTamhCa0tHbEFEOXlqY2hhbTVuMHU4aFc0?=
 =?utf-8?B?VnRYSVpTNmVpTEJlUXo0OGRSaEpxSVlSVkorSjRXcmJSaDh2aktjTXNWODA3?=
 =?utf-8?B?UkRzZkJ4aExhcldYck1xWjB6eTJTbkp6VzFmK3Y1WUgyNnVMOXhHelFYTVRE?=
 =?utf-8?B?MS9JSVJEVHFYWjlxc1laOEVvN3czUnlkM2hmVzRMUEJBb0hORXBoVTUzMk9R?=
 =?utf-8?B?N1dhKzQzVHM1TFJWaG1FUXEwUlFISy9QZUFyK1QzUkpZRWJMQXlTV0tsajgr?=
 =?utf-8?B?NlpJUHJnNWpSV3ZkYjRJdno1NW4vRFpnQ2tCY0VaazdGeEtsaHVvOGlIRG9U?=
 =?utf-8?B?NU51bFlVUm0zQ0FKemlnYzFZcSt6MUNhcjA0SmpOS0lTeXp2dVFQZVZRbzRO?=
 =?utf-8?B?ejI5VWp4akNxUmxpaU1Ldlp6alJYNHBud2Jwb3l6ejJmVDF1ajA2SjEzYmxZ?=
 =?utf-8?B?YXQxenp6eEptMWt6aEVEaDRCZlg1dzI2TTF3SWl4OTRnZUNaNzV5czNHMUxt?=
 =?utf-8?B?TXFpaVMyRU9ic0ltVmxneDF5WDlUSzFneUpiSElYdEsvbHRDZ2trazNCQ2g0?=
 =?utf-8?B?bWVzaHlpZmlFWEo4bVNYYjNBT1VGZklvU0R6VWMwamVHZjZPaS9qVE9ibmVM?=
 =?utf-8?B?VjNydkcrQzZEcnV5My9tRkJ1SGF0U2ppdU1na3ZwY0ZOcVBjRllVTDVhQVBm?=
 =?utf-8?B?cXRXY2VLTVRZNkN1OTNxaE10dHRSQmpQckVjR3F3ZXJXUW1aZFhmSEVCYlZs?=
 =?utf-8?B?VCszTTh2alBpdnMwbGxqcWM2NDZvWkxmdy9kSStMYkJGNHlWRFRpMzIwckhE?=
 =?utf-8?B?QkdtMkNOQmt0R0VDYTdTMFIrdjdnL3IxZVhlN2M5TjFhUC9aTmRScGRNbUhn?=
 =?utf-8?B?UlZQNGQzakU4MEp0Zlg5NVhsUWZZVnJjZkw4U1ZJS1FnSlNqT2tXd3RTUnU1?=
 =?utf-8?B?WERaTVd2eVh3dklXOHF6bDJTUldNdEk3QitvOWFDdnBDREJXbHgxb1N4a0J6?=
 =?utf-8?B?ckRFQ1c4eCsxRmtaNUNzbUdEcXBkdXNCSFFDblltK2FzSjlYd05zT21hS0VW?=
 =?utf-8?B?T3A2NVlveTYxcVluYWpzYU52MnVIR3Y4R2JYcGRnL3FWZXBib25UcXUxendo?=
 =?utf-8?B?TWViN0V2VHJMOGpPZXdvNDNhbjU3OThnR0p2RWZXakZmejlGWnMvK0ZOZ0Q3?=
 =?utf-8?B?NkZ1dU9lR3JFM0FoMlJ1Wi9RSVhRL3dhR09Wbkx4Mk1LOG9icmp6MGU3N1cx?=
 =?utf-8?B?c0ZlME5MazB3cDE0SUVSdkJCM2txQ1I4a0xvNmVLbmV5RS9wbHBzSFQ5OG0w?=
 =?utf-8?B?cjlRWnBya0hCYlRMQ1F4MUsycEtLbHFTdWlJSzlUY3dOM2c5TUN5VHRDTmZG?=
 =?utf-8?B?REhyQlNMbzVvZ3VSblVPa2xiZ0M2dWEyL3VrU3NrdkxqWm1PWk9CUGYwYVFa?=
 =?utf-8?B?OTF0Rzh3RVRkeU9YQ0h6VjNXbnBQVG1RT1h0UkM2SkhSSkFJUk4yeXRwK2NR?=
 =?utf-8?B?ZUJvV2ZIT1ZFdmRjNGk4UnkyNWdpZHdDMWFpZkt3ZFAwZzlZWnRjb1VHWFNI?=
 =?utf-8?B?YnNqV2NiWTEvTXZGNldNZDRNbGZ4VWtYTEZGbTdhOUhjWnJlOHpIV1hPYTgz?=
 =?utf-8?B?cEJMTTJOSWQzYlhqYkNLYmM1cnBuY2VZSUpaeTRFNnpVUkVmR0xOc3A0T2RL?=
 =?utf-8?B?Njdsb2xlQXdsR3ZQU0tCMzQ0STFGWGVSajN2dzBKS3YzRUMycU1hdXBHTkU4?=
 =?utf-8?B?QklQZHBESzNYUWhiQjhJam9oeVljWWZHRWlCRFNFcVoxZ29EQ3VwKzM4ZFpD?=
 =?utf-8?Q?ccHJk7u1eE/wNwN4L/ZYMEOQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccd7759-c425-4eee-8781-08dad7c991a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:36:36.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKZ3W/wr/ITpOlx63OQcDgKZ4o4zzT8NfedIw6cZNCKM2BCQp7mPOcD6sqnjz6Rx032bKNh1Sxqygkaelz95Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 11:05, Dionna Amalie Glaze wrote:
> On Sat, Dec 3, 2022 at 11:37 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Sat, Dec 03, 2022 at 10:58:39AM -0800, Dionna Amalie Glaze wrote:
>>> It doesn't always overwrite psp_ret, such as the initial error checking.
>>> The value remains uninitialized for -ENODEV, -EBUSY, -EINVAL.
>>> Thus *error in __sev_platform_init_locked can be set to uninitialized
>>> memory if psp_ret is not first initialized.
>>
>> Lemme see if I understand it correctly: you wanna signal that all early
>> return cases in __sev_do_cmd_locked() are such that no firmware was
>> called?
>>
>> I.e., everything before the first iowrite into the command buffer?
>>
>> But then the commit message says:
>>
>> "The PSP can return a "firmware error" code of -1 in circumstances where
>> the PSP is not actually called."
>>
>> which is confusing. How can the PSP return something if it wasn't called?
>>
>> Or you mean those cases above where it would fail on some of the checks
>> before issuing a SEV command? I think you do...
>>
>> So I see Tom has ACKed this but I have to ask: is the SEV spec not going
>> to use -1 ever?
>>
> 
> I'll confirm with Tom, since he's changing the GHCB spec for the
> throttling value.

The SEV API error codes are 16-bits in size, so you'll never see a -1.

> 
>> Also, if this behavior is going to be user-visible, where are we
>> documenting it? Especially if nothing in the kernel is looking at
>> that value but only assigning it to a retval which gets looked at by
>> userspace. Especially then this should be documented.
>>
>> Dunno, maybe somewhere in Documentation/x86/amd-memory-encryption.rst or
>> maybe Tom would have a better idea.
>>
> 
> Agreed it should be in both the Linux documentation and the GHCB spec.

Linux documentation, yes, GHCB spec, no.

Thanks,
Tom

> 
>>> That error points to the kernel copy of the user's argument struct,
>>> which the ioctl always copies back. In the case of those error codes
>>> then, without SEV_RET_NO_FW_CALL, user space will get uninitialized
>>> kernel memory.
>>
>> Right, but having a return value which means "firmware wasn't called"
>> sounds weird. Why does userspace care?
>>
> 
> Arguably it shouldn't ever get this value. We're just not very
> selective when we copy back the kernel copy of the ioctl argument.
> In all cases user space should treat the value as undefined, but still
> we don't want to leak uninitialized kernel stack values.
> 
> Host driver: only on platform init, should just see the negative error
> value and not try to interpret the fw_err in the argument.
> Still the data is copied back and therefore should not be
> uninitialized kernel memory.
> Possible name: SEV_RET_UNDEFINED, or a return value -1 anyway with a
> comment that the argument is undefined.
> 
> Guest driver: The host is issuing a guest request on behalf of the
> guest using patch 4/4 of this series.
> The guest is responsible for keeping the sequence number in sync with
> the PSP, so we want to track if the ghcb_hv_call completed
> successfully to know we should continue with the incremented IV.
> Otherwise we run the risk of the sequence numbers getting out of sync
> and we lock down the VMPCK.
> 
> The guest driver actually sets exitinfo2 to  an undocumented 0xff
> initial value just in case.
> =If the host doesn't write back a documented EXIT_INFO_2 value like
> invalid_len or throttled, then the kernel will emit a log with the
> initial value 0xff (or -1 after this patch).
> 
> I've changed it to -1 to name the same kind of error across host and
> guest: the communication with the PSP didn't complete successfully, so
> the "error" value is not from the PSP.
> This value can also get returned to user space during a -ENOTTY result.
> We can call this NO_FW_CALL or UNDEFINED. I have no real preference.
> 
> Whatever value we set initially, the VMM can overwrite exitinfo2
> during the ghcb_hv_call.
> I'd rather that the "undefined" values were the same across both,
> because the guest is merely receiving a value from the host's PSP
> driver (or should be).
> It keeps the enum for return values a bit tidier and not concerned
> with whether the value is viewed from the host or guest.
> 
> I can see an argument for not using the PSP header for its enum type
> and instead defining and documenting and using the separate the 0xff
> value elsewhere, but this seemed as good a place as any.
> 
> 
>> I mean, you can just as well return any of the negative values -ENODEV,
>> -EBUSY, -EINVAL too, depending on where you exit. Having three different
>> retvals could tell you where exactly it failed, even.
>>
> 
> That's true, those values are already being returned to user space as
> the result of the ioctl.
> 
>> But the question remains: why does userspace needs to know that the
>> failure happened and firmware wasn't called, as long as it is getting
>> something negative to signal an error?
>>
> 
> I hope the above discussion is clear that it's purely a defined
> "undefined" because being pickier about what to copy_to_user during
> exceptional circumstances in order to not overwrite the user's fw_err
> value seems an unnecessary amount of code.
> 
>> Thx.
>>
>> --
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
> 
> 
> 
