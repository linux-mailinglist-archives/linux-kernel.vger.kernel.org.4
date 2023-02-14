Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3856966D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBNO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBNO2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:28:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE6A5F5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyAnKHoesLa6g/gksveICd+hLZQVbhf0YCgZTQkVzyN9rT29zU/B6m4V7YSulPYYXYxb2/pzIrFaN5ERsG5eVcSiHxAEs7/pLCpAHhRz9aPGDVwccDL+0Kwbd48gDMnGvq3hf526R3OjBk13FPWJWSluGMfDtOLvY2Gqlo16+4h1TM48aQe1adDp8lPImcFkAtrtyrIzBy89yyWPkCyQhP3BWT6Rzp9ZuBJKuSit4cMY3zCvdVGlgDyb1bcrf40P4ZEgL78AtWiikvmQoZYMCpxOxqDzO6xlBhc9tSxeQaRBQeSuRn5fvALPmJdjoSicJQcaHea2jU9bdM6IqOeqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf9liNWH/Zm8poTkjdqmXFbDLvS5wm1eG1p6QlBt5KA=;
 b=CMCHy7rkgDFPAnTsHPfmhajPbryJ7ZIjk9bv36zQ2edMV6EMR3u/RoEVwSJ+3Xe2FK55BdXV1qCcMR+U8wlBKSeoY+SwYbBc8Q7BwcTE0MBZslu8GZOf+WHR7qaWQVg/KGTAx9F9v6ozNH1EiK0jwi0vMYy+u0OpUJaWLCvwPi94HvvNNirD6qECDlNmU5PYN9FgUo2SEJwXt2u1R7NoALguO+gTNuaMNFPy4spsAZYyCrfZxvzUENup8x+iXrq5DaeRVzDZmkTZbIhk0mTh6l71jPZ29nSkvn1DKnOOkZ0SrEL1ns80V64ePVVeX5S/kQqJWzYLcOOjYIjwLL79rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf9liNWH/Zm8poTkjdqmXFbDLvS5wm1eG1p6QlBt5KA=;
 b=JHRVJGtuEL2zUWFdbbl4enu0o/m9m5v3fnj09lAMIyola67hc2RqKgNofWceWY/wSAIyDlOEGR3EB8qe8/EsJyxFhy0Be4AkzdcoipyO4D0utodxiplTisabRPwGlz67AKgXb9wE7ZhHUvsV+qG4jwcNj7h1ydG65ZwCGjFOlq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 14:27:50 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 14:27:50 +0000
Message-ID: <046992ea-c201-016d-ee59-e1af72d8a6d8@amd.com>
Date:   Tue, 14 Feb 2023 08:27:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v14 1/3] virt/coco/sev-guest: Add throttling awareness
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
References: <20230213172525.575766-1-dionnaglaze@google.com>
 <20230213172525.575766-2-dionnaglaze@google.com>
 <22e96dfd-21af-681c-22d2-12bcc082f63e@amd.com>
 <CAAH4kHYrz2pZzwAqoy-mpA_om1+tO8qB-4ZHc9jKh_ucwZe3OQ@mail.gmail.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHYrz2pZzwAqoy-mpA_om1+tO8qB-4ZHc9jKh_ucwZe3OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:805:f2::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 9406bd46-518b-4927-dab3-08db0e97a653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k6/oslBxpdvDyvgNDx0/PJGJRJIAQINjuDLR8KNADC+xmPAbO60WVGBu0CbdlkQKKw/nT1Nz0+isvu0PHt0pHy9dvHi3w6nNYftBQTBHhVQu6xWj2Ys22P8Man9QsH5TlOTjYSmg6j+W10Ez+GhU/2JAdZbQVi4DKl9Cb5/7vlfIYnfqEk3funmfaTKLmopNN8oAilqatb6NweLc2imBkf9+9PbziLCcRtStQwGtgEBbSe52PXyo5ULoUZVITx7soB0NpLHWnxH+pMPlpkqmTtENKWK7dXOLFzdYIgNZVuF2nAqLS8WRjmqG4LqhHuZUvsC30iYtToKXJ7DBjBhXt14AsGbkeSZU26vvXMlYz1dm9HodsOzf68Fx+tJhkkwEGNxn5CmamZD030NBAmDjJVSflLk1APc9nNJAwIoJTiElJ4byzSgsDgLi4h5b8On/p3AOFafUSTleWPTddf3kuJUjjbN0ZxqbE9b/OLqZ60WM97Ijm0Ug5aB0caJPeqIA+AN+biu3bExTbaAxcSoxH6TBp4piPSUZXTQqB/AXvi+rxChKeKESD5vKt8zFtRZkgdCbVj3TbesDmigzxEyN4riRIvxSKLUVStoLs1P9JEfbQmZPs0YHgLB3ksG4lT03zipuKTTsguPwx3EvbjTEtW3ioXzfRxsmTMHUEaHsWgSFIoHfecUNHz8339hCbi2qkzylZ5ueqCKi57n2sbVh4gx2jxlqbpIYH8/yOsUC2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(31686004)(2906002)(86362001)(6512007)(186003)(38100700002)(26005)(53546011)(7416002)(4744005)(6506007)(5660300002)(2616005)(8936002)(478600001)(6666004)(41300700001)(6486002)(31696002)(316002)(66556008)(66476007)(83380400001)(6916009)(4326008)(66946007)(8676002)(54906003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2paT0FzUHNJZlRDWC82REp1dkYvdEcvOHdEanBtRXM5U3BBaVBISzZPeHpr?=
 =?utf-8?B?SDV6OWxCR2RhQzFaaEk3TEMrTmFVRnJpMnpDcG5JdC9YV3VqUWRmTHhnVWto?=
 =?utf-8?B?UkhjUzFGNTVkelJhWEIvMXhCT1RkQjVxM3pVdWxZb3VBL0RESEE5ZHhEYW0v?=
 =?utf-8?B?My9QUE1DbUk0QXg0Y21pZ1dxR1lIakl3UDFiWFlUWk5pM01yTy9tVWJ2UFZY?=
 =?utf-8?B?N0lMcXlqWjRZZHlvbUsxU0s0T3hnVytsemxucU81elBIODRCK2tsV1N3eDNU?=
 =?utf-8?B?UEpwNHJWYkJhM29kbnNkMWpoZFNYSjBXY09JN1VHNSs3MVRnczB3TEFvY3dZ?=
 =?utf-8?B?Y0c4Y2tqN2dTeWdPQ2VuYmdyRlhjcitoc2VWTTBqZHpKSHRnN0pRMGZ2Zllq?=
 =?utf-8?B?ajdWc0F5ZTVyMnFYMWNDa3VUU3FkTVpJWjI1WEFsV1kzaE4rN1ZLOWFjT1hl?=
 =?utf-8?B?MWdTdDlyOXZqS1pWUm5XamI3Ky82cllRVXVJbU9idUJ3VzhHV1BFTUtDbmxR?=
 =?utf-8?B?Y09DTnhYRCtrdEwxL3dpWUtGU21lbThxRVVnYnJiRWhPU3NBZEtyS1psdjgy?=
 =?utf-8?B?eWpoYWhwalJXSHNBWUIwN21pV1QydWlEY3dJUVBUanRKcmNNRkRiV3hWdy9j?=
 =?utf-8?B?Zi95dnR6V250T0xuKzZNTFBwelNESkkyTFR4VmxOay9pcTlEQ3Y3RlhwaXdH?=
 =?utf-8?B?WDlsOGZTMWtZcDJ4NHBIK0xHbUN5SS95Q0dSbzRlMnJFQTBGZTBpd2VJUkh2?=
 =?utf-8?B?ZGFWTzhuQitubDFwcFAvelRpL09semFNSElqZkpUVG1aZmkyQ3lKaUF1Vkx2?=
 =?utf-8?B?dWhvZ3Ixdy9rTnp6Y1hJTy8rSXJudkY0UnBKN1EzS1ZkRUo3KzhPSW5Qejdx?=
 =?utf-8?B?aWpGTkJJSVdOSkJoVEZVZHJHZ2w3ekptanVMT0w5UkV2TzUxVFRYMCtMS290?=
 =?utf-8?B?LzBOc2dxZm83dWNZMEh3cWQwbTNwdkI5Ti9uUFFMb2NIYjl2NXFnYWFBd25M?=
 =?utf-8?B?WjNSZmpSWTZsNTlsMks3RmRUUlczV3dYS0tyV2wzWUN6Zk04dEpKNEh2eU9F?=
 =?utf-8?B?RFllS0RVOGdocDdsMms4SVVkelY5N0pZeUlkR3ROdXcrVys2ZTdtRS8rSDRN?=
 =?utf-8?B?bEVqdS9TeklxbVBYTEdNQ01ZbnVrS2RwRzRsV3daVVVvaWw5RmNwbElWSG9l?=
 =?utf-8?B?ekp5L1pNekswaStJbDVRcktWNG91QVhUYzZKTjZPZTdyeUpKQ3RRVitpZ2lo?=
 =?utf-8?B?SjRaVjh2QUpabWVQVmhPcmxDRUZsU3ZsaEhmWXZhM3g3L2dyZVBuMllWbkN6?=
 =?utf-8?B?ei9vTmJsVU4yT3JlWTBKMU43UFB1TE1DeFkwR0c0S2RDelZpc245UDUvbzRk?=
 =?utf-8?B?VzlVVk5LYS9hbUdoV3NGK1c2ZDVrWVZ0alQvSXNoT1MxNTRHTElDenhINjNy?=
 =?utf-8?B?UjVqVGUwbXI3T1NOL0x0RG8zOTRRd3FvSzZ0Qk5oWk53elZldzE0eVk4SXh6?=
 =?utf-8?B?cHpNSk42Z3RWaVBHZGdnQkxlbkV2NGJLNjJDSCtjSmdDM1JIMHZhWnEweFVT?=
 =?utf-8?B?U1hEZzZ0bkNCTkZIMkhQb1VWeDU5WUM5SVdNbEF3QXpmUWZaMmQ4Y013QWh0?=
 =?utf-8?B?N2tpbEgxVHJpbGliMmJzRndjVEUwNTlhbmtKTHZjcFJYclBkc0hlV0o3RUUv?=
 =?utf-8?B?NjZuOVBvYW5mckx6ODRId3hvaWx6ajBHYmE4YXpXck82am43VkNpR3dBSVJD?=
 =?utf-8?B?WE5MT2ZtcGU0dDNzYVlDRzBqQks0THJCeUFXcGJHdnNWOHlkZnFWZzI0Ky9s?=
 =?utf-8?B?WWw3N1YvRk95TjMvMGZ2QytNa09FNjV3ZVJlMUd5Z3ZNUllXKzJra1FvWWQv?=
 =?utf-8?B?YzduaFRQWStHUkc0d2NXM280TUt4ZzdNc3NJY21Vc0xCM1JzM1ZUVU9NRklQ?=
 =?utf-8?B?enFaZ3F1dFJ2bW9KSXR2ZitSeGZZNUJuSm51TjBiSU1QV0VaaXI3WG1adzBY?=
 =?utf-8?B?WjBHdFRwZ3NIZXhPcnd0RnJyc2tOOHhiUyttMkQ5SzRuWFBqcEtvN0lEU0FW?=
 =?utf-8?B?bXdoa1UvdVBoZ084NWpTU0xZUnB6SHcxTTBhcHBaMjF3MmdvVWxXMEs0aU1Y?=
 =?utf-8?Q?3FB+i6m3N5iqpbd581T7HRDtA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9406bd46-518b-4927-dab3-08db0e97a653
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 14:27:50.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XamT4GAPCVHw6nvgw0qo53FbnHw7Ye8LVkGhXT/D1eIQNAIkWnm5ecw/haHBstRrewRN0IjGeTs5NoNEF42fHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 16:28, Dionna Amalie Glaze wrote:
>>
>> This should really be a new, separate patch.
>>
> 
> I had it as a separate patch and squashed since I felt it necessary to
> be considered still a "Fixes" patch. Should both claim to fix the same
> patch?

If they both fix a bug, yes. You can have multiple patches that fix 
different bugs that were all introduced by one commit.

Thanks,
Tom

> 
>>
>> It looks like you will ensure throttling by continually calling the
>> hypervisor for 60 seconds, shouldn't there be a delay here?
>>
> 
> I can change cond_resched() to sleep_timeout_killable(some_constant)
> 
>>> -             rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>>> +             cond_resched();
>>> +             goto retry;
>>>
>>> +     }
>>
>> Nit, add a blank line here.
>>
> 
> Will do.
> 
>> Thanks,
>> Tom
>>
> 
> 
