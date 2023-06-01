Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E794171EE92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFAQSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:18:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D135112C;
        Thu,  1 Jun 2023 09:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOkxPyzG18MUxpWzdmTbXKuQIoFvxlLfeapL4tTlMI1RwXGLtiUS1BoyU4uUwz3vP9Y75YdMwCCwzM8kVKbEubgtm6TL+BdwT4A1THrx3EjBLCiqK9ohlY+X2a4CdFmkZCVRVLpU3/TCoyMOEYD2kNHqq5A4tPYliq2VAtIhmDW05j7pQ87AH8Fp1Wx8ccy38qEq1BYMzxBCIVyS1qCIo0G1NgEUHgXIAd3vtOQk+McaR7ZwLi7JL+pBwK1L5tlzkFmzjPJNYShi/dA45/LWpDd5Sg9WpmrI3eAtBgtldPppCgWf3INhOFJzRSu1zfHxozkmU0SM8YVcZkrdl+KjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSmCyBsLsppFhav2efnForbqStgnm72FFb6O9hwGZws=;
 b=VDP869V6E852tmFkQXb+Il07K59Ok2jKJrdr/ztoner5WbA0XLpX13RADS1cVCFqKDxqMoshqJCeQJ8uha9UMFk5+P7DN0nWYDC+ffKYepSL6ydRySl+v/x6HXM8qa+3IBhCxvWIJOralFm+jcYU8uerd2UyhAeiqAVbcc62POrni8iO+5TYnmXmqM8EHGLZs84XWLgUwsqb/3W7BqWTjojKyrFxrXh2r81GgV2bm15KJDzwysu/fL1wpuv7wT3jXmPGbP74/c0m4YKqozbI3FUZS9mA4EZcEqi5SUxUIlZix3hpqE/1aTfC76V9p7YCkj8qoWaj+AZbDyfyMDArZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSmCyBsLsppFhav2efnForbqStgnm72FFb6O9hwGZws=;
 b=m4994QcazAs0cNRNAKlEr6vIAudWxcGDZh9SBpRu/dIXMWoo9rtjzx+id4l6eRStwFkZOjuijHhZz/EZMgPJjqQfnud2PX8Ye8W9P1TlY32iGbKdHUIVvDHitHklKDjMnucbxhPXnGr5gXcCg3oCGs0kx+kcum79lmcVV74kSS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 16:18:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 16:18:05 +0000
Message-ID: <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
Date:   Thu, 1 Jun 2023 11:18:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
To:     Nick Hastings <nicholaschastings@gmail.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        kherbst@redhat.com
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1036530@bugs.debian.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com> <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com> <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps> <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <ZHWfMBeAONerAJmd@xps> <ZHfa/wQlaVCeUC22@xps>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZHfa/wQlaVCeUC22@xps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:806:22::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 276a2cc9-2260-4278-6bcd-08db62bbc7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6utTbGrpQSbPeMXRtqPta04b71GBPbBC0md77TmveeTKLPTNTRElHHmUrGZ5eQpMSKTF1BsSMhYAYniTeK7hMANoMh+i/BBc44MjSAv5DWJOrrHjU0AwfcIdDOu43GWn0Bm+tcdoSDURaIjET71LEU3dFUPq8mWyT+WK4QqJ+cPDzdlWlwSMchpquauaGQc+vU7eEa5wn5lJgKF1X2qpUXEybMECTslaBz95Cr7jxRHHDZHki/NujIQvmSziDawoqAN7aHQ86njpRjcaIR5iih/G2s0KCQ+NG6L6xBDWdYFi8+4Y2PXR094Z9wuRSAwaV7EsaDfEPxnq2aQ6cDL8YQytNSrPVMnsyBiK8Th8QX4Al3nd2N4iiPSLiCcEwpVnfQEz3jSeMnIkdpT5pu/9RMlb/lns5A9/p8SLmRsm/jdZWfPLszdGYBaR9Dews3f9QXl/Mfg6mKcUtA1GA/z10THa8z4MkXWUm8X/ZbFLtEnr17r/PrTPF1LCnUGw48/GocbtMiSLkV6SGa3KoiBdyflSALM/22o2SQNIH2AeiC546l8jnyIyEHNfnqbaksx3UvZr+gwV8sqp3fOB4JctzOvg72cTM6pJKOkbY5EIAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(66556008)(66476007)(31696002)(66946007)(6486002)(86362001)(26005)(53546011)(6506007)(6512007)(478600001)(6666004)(110136005)(54906003)(186003)(5660300002)(83380400001)(8676002)(8936002)(2906002)(7416002)(316002)(31686004)(2616005)(4326008)(966005)(41300700001)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWw0RFNwWU5HMis4TXFESDJBYzFoTi9iVFAwQjdJRTZ1V2VhSnlReUVhdklC?=
 =?utf-8?B?Z0EyaW1ZMS9oTTZ0TjdPMyswcUpwUTl0QkhtV3h5bnZBMFR1UTVaY3RGSGxS?=
 =?utf-8?B?UDhiL21IcFNKeUtXUzU3dzVDajV4bUE1VzRic1h0amRZRHpKei9lYlRLMXps?=
 =?utf-8?B?cU1QeGtPeXE3U2ptaEN4YnhFUm1HQllFTmlKUkd1ck0xeTF2WGpuVERhc21s?=
 =?utf-8?B?NklBeVYxZHVNWk9jTDF5Qk52WCtxWlZIM0FqbWloMFd1U09XUTdwaExOZ05a?=
 =?utf-8?B?UEdQQ3Z3RmgxKzJpbmZDYnpzVXlRckJBUnJhSU1hZ3pXaS9nYWFNYWRnWk5P?=
 =?utf-8?B?dlRyNzFnUjBPb0ZzSjR0OSswU011MForY2VSM0E4VUQzdlNtaVJrSS9HVVRX?=
 =?utf-8?B?aHFYUjU5U2NGU0pMVTVjQXIrRER5eWtPeTZJdDVad3dQYVo2ZDdJdG0wNmNx?=
 =?utf-8?B?NkNIMTI4eGROdmZISy8xKzFvMTllZXF6RmcvSVdkVE9mZGllMjJpcVg2SUJM?=
 =?utf-8?B?YnZaNHBacDZYUXBGcnVqM1lieDZaUWczSFRiUlU4SlBOQlhOQmQrRG5jeXFu?=
 =?utf-8?B?MkFNeFlNQmJvaXRIVzFCSGdJOS9qNHJockx4eU54bFRZUFI0RTNnM1pGd3Fr?=
 =?utf-8?B?Sm0wNmxOcCtRVkZBeWZId28vY1B6eWlDYVFWL3hhMmxvZmN5bTNGWXl0ekE1?=
 =?utf-8?B?eGt6aFprZmw3eVk4dkNFbnJQcklEOVlHa3JKZ09BRDNDTWdERE9oMHZTam96?=
 =?utf-8?B?N0o0YUlUZWZZY2h1TVhIYVIrRWFMMkR1NmFGRHlFcWpsbUEwd3FmR2hIanVK?=
 =?utf-8?B?K2swVlM2a2w3ejFlcjRCSVgrTXVsQkZnbGxjK2RkaDU0RnFINkJSN2t3bml1?=
 =?utf-8?B?bjUxT0M1U1dPd2NmZXV2MThldlBkYUdnOEozZm5QOGN5UC9VWk4yMTJGY2R4?=
 =?utf-8?B?QnRSbDBNSERBS0dLY1NqY3VhbWwxdCtnRW9BYXBCUEtHZXEvdmxGMFFqS0U2?=
 =?utf-8?B?dXZRZk8wK0E0TW1PT3FHSThpaXRWSUVEd2psR1hsclExSytFQ3FNVGtVQUx3?=
 =?utf-8?B?djN4TmFHU201c2RVSlNlUjZLMFp4SG55Qis3R3B2eEI1VDhZdVo2SVBCWERH?=
 =?utf-8?B?ZUVISCs0VDRsQnlsOXh0cFRTOHliRExFVEpOZDlRRURmeDFucEFJRk53TjNX?=
 =?utf-8?B?bWt3cjVtd2hJUzVlczQyMlc2U1JxRGN5ZFg1WU91Q014WFZ6WWVzMzN1RTlW?=
 =?utf-8?B?UUljNDNFcWRkWkxmWENlK0xJS3VpMDRvWnJLTHF4SlJnQjBlSWJOdURXOXJB?=
 =?utf-8?B?QzZyaFpDOHRNUE00U0tlTVJGRlV0bFNrVm5KTkREQlU1Qnl2a2ZndFBmT0dB?=
 =?utf-8?B?SFVHMld4R2hXTW9GVDYvZSt5NVpJbkpWVzVINEZhVVdCMHI3THhoWnp5WmN0?=
 =?utf-8?B?eFdRdGptMXB0MllvazNDVXBDc1RTSkUremptMmZINUVSSS80aXljUjF4R2FQ?=
 =?utf-8?B?NkRkWkxSVDA0YXpJc1YvUG4xTHNYeHZKUGk2aDdib294Tk84RW5XUW9Lb1c2?=
 =?utf-8?B?TlFMMGpORFdNWHVRZ2hGbDMyejFBeGQ0Nnhid0dGN3Uzek1nNXN1OThyNzh0?=
 =?utf-8?B?UTQ3N1JvNkVxNHQ3cFNIeHRyV0oySUxsMnZLcjZlU3RNcGhlQkhaZTZraGFa?=
 =?utf-8?B?alR4WUYwVnJOZ1IxUG0vUXdVdDRnN2gxeUtKK1krRUovbThlUkMwUmtXVkF6?=
 =?utf-8?B?bGppVCsyUFlsZmwwNElOZ3U1a2ZUNm52TmdOdzA5WHhIZmRSUGxBWTZ0TEY3?=
 =?utf-8?B?cVFlY1BJMlpZY2N0WUpGNkUrcDdEY3FkQ2k4R1pyTWpuSjh0UWs2RDZtalJh?=
 =?utf-8?B?ME5Da3Vpc1FBYWZSVXEzMVFPUktablQ3STlPNEFWN0xqMWNXZWVFMjBaejF1?=
 =?utf-8?B?YnJobFBhQVNXc3lWVXBxNEpaVTFvMVVLV2IyVmdrbGJmTVB3VkFDMXJqZ3lu?=
 =?utf-8?B?WEVEWE1qY1BiQmg1U0ozRmNzY2FRa2ZnVmZmeUpaTUhRYXlhcWkySVlERmZV?=
 =?utf-8?B?dTVBN2kyRlNRenljdWNrTzZxMWUvUTMwQ2txN1E2WFdwUXpEQ2VqVGRTSkpR?=
 =?utf-8?Q?ysja0mtjdGLHz1r9tHSg+yhKW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276a2cc9-2260-4278-6bcd-08db62bbc7b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 16:18:05.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ta0RgQClG+0tEby+ZDTnscP8blTgJLNWeN2heKyhjw9aZpHooqUO+OFXQKFI+NiJOlxA90N8e7OlozuGCTk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Lyude, Lukas, Karol

On 5/31/2023 6:40 PM, Nick Hastings wrote:
> Hi,
>
> * Nick Hastings <nicholaschastings@gmail.com> [230530 16:01]:
>> * Mario Limonciello <mario.limonciello@amd.com> [230530 13:00]:
> <snip>
>>> As you're actually loading nouveau, can you please try nouveau.runpm=0 on
>>> the kernel command line?
>> I'm not intentionally loading it. This machine also has intel graphics
>> which is what I prefer. Checking my
>> /etc/modprobe.d/blacklist-nvidia-nouveau.conf
>> I see:
>>
>> blacklist nvidia
>> blacklist nvidia-drm
>> blacklist nvidia-modeset
>> blacklist nvidia-uvm
>> blacklist ipmi_msghandler
>> blacklist ipmi_devintf
>>
>> So I thought I had blacklisted it but it seems I did not. Since I do not
>> want to use it maybe it is better to check if the lock up occurs with
>> nouveau blacklisted. I will try that now.
> I blacklisted nouveau and booted into a 6.1 kernel:
> % uname -a
> Linux xps 6.1.0-9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.27-1 (2023-05-08) x86_64 GNU/Linux
>
> It has been running without problems for nearly two days now:
> % uptime
>   08:34:48 up 1 day, 16:22,  2 users,  load average: 1.33, 1.26, 1.27
>
> Regards,
>
> Nick.

Thanks, that makes a lot more sense now.

Nick, Can you please test if nouveau works with runtime PM in the
latest 6.4-rc?

If it works in 6.4-rc, there are probably nouveau commits that need
to be backported to 6.1 LTS.

If it's still broken in 6.4-rc, I believe you should file a bug:

https://gitlab.freedesktop.org/drm/nouveau/


Lyude, Lukas, Karol

This thread is in relation to this commit:

24867516f06d ("ACPI: OSI: Remove Linux-Dell-Video _OSI string")

Nick has found that runtime PM is *not* working for nouveau.

If you recall we did 24867516f06d because 5775b843a619 was
supposed to have fixed it.

