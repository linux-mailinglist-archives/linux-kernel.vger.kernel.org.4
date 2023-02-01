Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45CE686930
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBAO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBAO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:57:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EBD66028
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:57:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgJO/nq8eNoX+l1MIOTfA1vnFJc3auiPVv5INCtkmt0osepdGrUZtzvpl1upHlODiyI0eXul+epI/3U8L905KwsVcJDsw34hpRwbZKPOkwidsxpgpDfTvQjCd+GIlGf3eD7j8/HrDMPgaYPDBxC2HFCy6nsIpg8DC2M/ddy6wynRnU5paSo/YihgoMtvpCpPWKilgfVQW8zDlOdDzTc7yoOrrtNAVMoPJPR9cCF9qev0RPV39kzQ87qr64YgsEMXly3hTaef0tUAICc0iaiE1q1ecXvk5qZhtO0IW3eAJhV95BPsoIlRp2jTKBcEl7R+e+foxG37vW1Br0x7xHZ/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yExOB4QodvBlH6WLwKU87MU63BQOh0Wl0owTBeZoHUM=;
 b=H7LnofBxLuahRIsYb0W0xsa2nm/BVHJp+mPoZvwPJ/2ZJoNs+JM0yVX63T7PfyKhGTa+cqoJU0ABSmMWHzEdc9yF4NfpyFRmOrazO1kB7233MnJfn2J8ztn2miV/CNfFbVeFfu/JfbtPH24M3/KD++9Zk6I6ovSf2vOTWg4MiI2zb/Iu5NvLICzOrpOpGQ5zugIXAXHZseHSocrq9YYRR/ozvJJKLmmPcqciamVhZ49WJvu0n9YydArsoklYZYVvqUah6SO1Ty+3TL///gr41kCD4saKtaxotE29JgG6G89YzGuiX718xw0MQPuqUeoA+6vH2NcVOu9rZWr1+FJfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yExOB4QodvBlH6WLwKU87MU63BQOh0Wl0owTBeZoHUM=;
 b=vrBMWxnypk2Z3bls2sjMhJq9fMtAQLTs9xA0vYAiN1SkkKX0mbrbXm4Wue8T76NSbF3UQTUUgzy2MKRTGTpQNBVF0Pd5DRKHBfOCm/scNv0YmWkgcZWVtfzJJmYk4p4fkpCnxksu2BYTlwzPhyoPHBtIMmaoNWzGTPA/VBrUiFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 14:57:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 14:57:40 +0000
Message-ID: <74008dc7-ee85-003e-b172-209f8c97963d@amd.com>
Date:   Wed, 1 Feb 2023 08:57:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/8] x86/psp: Register PSP platform device when ASP
 table is present
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-4-jpiotrowski@linux.microsoft.com>
 <194d8448-dde2-3452-7ccf-4e88fddbff75@amd.com>
 <20230201140952.GA31392@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230201140952.GA31392@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:5:80::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbeb73d-e7ee-4ac4-b88b-08db0464aa05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAutJY+glmXZ4tQXqwpSEmhwKBWrsgLL8BGXjczJBPcNSDSYtTNtasT5KfRUHq+gIrGxAa9xOBXwcFSW/vhKP/boGWlnEe/jvZP60b52sfzZAnKZb89wVklHS3kycrgRcaoJk4G2K6u7QjSzCbFSydDT1wP2+0dRDM5ZhbXRnOB6spXidJQ1h9jbSnCIUD+AvOjwOFc8uZeYZ07qHYc6whuSA313JBlou85nDpREVGZMIeHAkI8MrJqPFcw3PdZtnghobZcT6IscBoMfBvZHWb1oEzdf8VXPiE1WvnU9A8qj92yzM0jnIuSybUiDJ2dIKYv7s92wfzyeGd5kQOJlP9sTr+yyABXrvvmgFBBairLv6dpgKfaQtPPZ3dhQZ1huRJk41zrRChetjMfVAeVSs8WKSB2q2gclmrIpGtbV9T+cNw3shxgYZNWscOt9TyGofebVeSnY8GIdUwuxxEZi2etOuICINXT1geoitMldlIrtVQyEjAp4lOQQOhUUupE/LgDGdAxdws0YXm0a2s/U4VfPmUO8YjBxo+7Wq/scpe0ypLwZyzemENnzDbBvXVEFqSsRTltegxoAuicWftfnP7s9YHxrdRkHiyB7vOoeEIbBFun61Pv7+WDTE73jkfpBlRhQXiB3uRDuGb6yZbkDK5GGR+7Px3HYulxQjeAyTz1jYPi18gX/x2LtHbuxfLz5rJxPCHvPhxWBFvMvbYAw4MXsrfpVLST/JxCpQHPbFEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199018)(31696002)(38100700002)(86362001)(36756003)(6916009)(41300700001)(5660300002)(316002)(8676002)(66946007)(54906003)(4326008)(66476007)(8936002)(66556008)(2906002)(2616005)(6486002)(83380400001)(478600001)(186003)(6512007)(26005)(53546011)(6506007)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkR4VmpkUnlac2RkZFZuc3d0U2ZwaTRRY3F2NjZ0UDJRNzF1cHhKWHNuZk4x?=
 =?utf-8?B?R3RKQktmY0s2bTh5QjVBV1JZWGRlQmJwQkdZQTd5aVRUakhBKzZkU2VDcm1z?=
 =?utf-8?B?cmZUQnVhNFVrVi9IWXNBaytKOXJKOVNWZkhRTkhSU0k2dWxIa0VGcXJsVDRw?=
 =?utf-8?B?T2t4cEM2TXhOUXhUbEk1c01YQ0tsTDc5VWtqTnhZeEJUNXduYUtRd2RkQVpH?=
 =?utf-8?B?WTJ4bGV0SVpNUWN1bHVlUmdKcHJRL0VXY3BUaVhvallBMGxscDM5SkIyRnVv?=
 =?utf-8?B?N1NaOTdTcGJsb05VSnd3Rk55ZExzNnNiVGNFdngwNEZZd25zazh4Y2xBT0tI?=
 =?utf-8?B?WWdldEt6dHJiKzlqR2lWVGxkSGdmNDdZeDcvRmRRbXNrLzFQL2NhVDd0Qk80?=
 =?utf-8?B?RGRPNkhzUkxxWlVhYUx4TmdLYWRpdGpxNHpQSmQ5R3JUOGE3bm9vZ00ycEZS?=
 =?utf-8?B?TXlFSFFRa1JKL2tUSmFpaWl4clVBMXhIYWFVMXZhWGx3TFpmbkZsdXZKUVhi?=
 =?utf-8?B?WXd1bHVqUmV3NzZDQzZVYnJ3S0JrcExuamhybDBDbHE4dG9pTXJzb3FSamJP?=
 =?utf-8?B?YlV3czFreXdoVE1iODVoZHcva0F1MW80aFlaK280Tm13Q1VSSHZoVk93NklB?=
 =?utf-8?B?b1BtRlFHYXQwTmF0VkthcS93cm1SYVQrdHlMU3I4NUQzaVNDSk9OZjFrd2Uw?=
 =?utf-8?B?TDhCZjhwWVBRVGZRSWZLL0Z5VFF5M2IrdHUyT3pSZzM0OStEdkFERWtkWTJs?=
 =?utf-8?B?VEhZWHV3WWMzN2kwVHUzT05GTlhlS1hhTE5SSDFqMW53VU1vK29mQjBFRHNI?=
 =?utf-8?B?akY5TDRZZUdsZVM4VFBJMmxmYVRwdWo2R1VLMTFxQmEzenk0WmVoYk1vY2x1?=
 =?utf-8?B?aitTMGlQTUUvK2o0N1p5Y2V4RVE4K044bDZZZXV3QWh4QnZNVHMwSnBaRndh?=
 =?utf-8?B?TVdXdnc0RFVZbzRodzNBYU1hbkxYdXJ5dlE0RitKTXFmb1ZIWlRKMUp5dHRC?=
 =?utf-8?B?SVhBOGxUdm9TVEp0SXYwRnozcFNNa203NmdZaURJOUpxaHQvbU1GMTRlbGVD?=
 =?utf-8?B?eStyK2Y3T24yRGdndlJxNllUdHVtNlJOR2MzZFJIUXN2Lys2OG13UHlUSG91?=
 =?utf-8?B?d1BpZVBLc0cyYXlGdHYxc3h3Q3AwaEVabkdVYXRHM2tMcjk3M2JpZ2lyY1ZY?=
 =?utf-8?B?cHZ2RHNEQlVVREk4ZEpYZyszOEF1eFplSnBVWm5Ld3FZNjNBUHRWbGNCWGVo?=
 =?utf-8?B?UTI3TW9ScEk3WlpFbkVPN0ludFdZb2RaSS9jZ2E3UTFoWjdTQzNRMHFUbWdY?=
 =?utf-8?B?MEE5bnNYRW9NdjB1ZXErRzAwNzNvVkkvdGFRbHY0amJxeTFUNldIRCswZVJQ?=
 =?utf-8?B?alltU0NnUFlxVnFiblQ3dktmMXI4Q3FKSlRBUDFoTDl6b0NYQUwwL2Uvc0lT?=
 =?utf-8?B?OHlva2V2RFNaRzJVdmx1WmRmb1cyR0FCdVBPK0NKRmh1cmRVTVNYRWw1L1p1?=
 =?utf-8?B?QUpxRVlLbyszeVRkV2lkUFRqVm9FYzlxRnMycEFvUUVtdzN5TmFIdTU1Tm96?=
 =?utf-8?B?RnlRMXhWRXVyUFlVL3pwZkVjSUJoN01VaXREU0M0SkpuNWhMY05XaGRRWTBB?=
 =?utf-8?B?MGhBakxjczFwT0NBTlRFbUE1Q3N4MjJodEhMcG1aVW9MU2U5aWRDcmFqMDd6?=
 =?utf-8?B?b1M1UkJGMVBWd3RZVm9iOHdCcjU5Vndnb2RqYkNOZzRRZHFWMjRka202Mytl?=
 =?utf-8?B?cFRmTWdiOWpmVkNzQ0FGM1ZZZlBMeG5TblZmejBtallrOWNqMlUrMk5HZTc4?=
 =?utf-8?B?d2ZKb0YzYUU2SlptaVYvQUlrT2tkNTNaWVlLdVFGUklOeC9CckJCK1ZvanhD?=
 =?utf-8?B?bk9YT1RjTE1uZFk1YTN2NUlyN042N290NGRzSmdGcXQ2RGJVZGg3QnZNazda?=
 =?utf-8?B?M1JuYWdoN0NZVVhRYU9yd25PZ3ZZblVOcXpoRXpJQXJtMlNqQlhvS1dZQUVy?=
 =?utf-8?B?UjBrbmc0UllBNHRIdXM1Tjg4ejdXb3BSRWZISWVFZU51cDhFbU02cXI4MVlv?=
 =?utf-8?B?YzBKRU1yNXY3MmdYWWNRM1IybitYZjFMdHBsYm8wRGdxakw3RnBCUnJ2cFF0?=
 =?utf-8?Q?pB4jGQk/gsxB7adKhmw02QX5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbeb73d-e7ee-4ac4-b88b-08db0464aa05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 14:57:40.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIHS/MRCP/LWjfynndJbGBFI8AUgp1wcYdQBpf+SkgZdXcne0OQm6GV9BuEJ2udoeQvaImpZjY8XueDUbFWiPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 08:09, Jeremi Piotrowski wrote:
> On Tue, Jan 31, 2023 at 12:49:54PM -0600, Tom Lendacky wrote:
>> On 1/23/23 09:22, Jeremi Piotrowski wrote:
>>> The ASP table contains the memory location of the register window for
>>> communication with the Platform Security Processor. The device is not
>>> exposed as an acpi node, so it is necessary to probe for the table and
>>> register a platform_device to represent it in the kernel.
>>>
>>> At least conceptually, the same PSP may be exposed on the PCIe bus as
>>> well, in which case it would be necessary to choose whether to use a PCI
>>> BAR or the register window defined in ASPT for communication. There is
>>> no advantage to using the ACPI and there are no known bare-metal systems
>>> that expose the ASP table, so device registration is restricted to the
>>> only systems known to provide an ASPT: Hyper-V VMs. Hyper-V VMs also do
>>> not expose the PSP over PCIe.
>>>
>>> This is a skeleton device at this point, as the ccp driver is not yet
>>> prepared to correctly probe it. Interrupt configuration will come later
>>> on as well.
>>>
>>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>>> ---
>>>   arch/x86/kernel/Makefile |  2 +-
>>>   arch/x86/kernel/psp.c    | 39 +++++++++++++++++++++++++++++++++++++++
>>
>> Based on comments about other SEV related items, this should
>> probably be moved into the arch/x86/coco/sev/ directory.
>>
>> Thanks,
>> Tom
> 
> I'll do that. This will make the code depend on CONFIG_ARCH_HAS_CC_PLATFORM
> and CONFIG_AMD_MEM_ENCRYPT, the latter selects the former. This will work
> as long as CONFIG_AMD_MEM_ENCRYPT continues to be needed for both SNP guest
> and host sides.

CONFIG_AMD_MEM_ENCRYPT is only required on the guest side. It is not 
needed to launch an SEV guest of any type. I believe the latest SNP 
hypervisor patches are being updated to remove that dependency and replace 
it with CONFIG_KVM_AMD_SEV. So you'll have to figure out what you want for 
your CONFIG requirement.

Thanks,
Tom

> 
> Jeremi
> 
>>
>>>   2 files changed, 40 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/x86/kernel/psp.c
>>>
>>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>>> index f901658d9f7c..e2e19f2d08a7 100644
>>> --- a/arch/x86/kernel/Makefile
>>> +++ b/arch/x86/kernel/Makefile
>>> @@ -139,7 +139,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
>>>   obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
>>>   obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>>> -obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
>>> +obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= psp.o sev.o
>>>   obj-$(CONFIG_CFI_CLANG)			+= cfi.o
>>> diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
>>> new file mode 100644
>>> index 000000000000..d404df47cc04
>>> --- /dev/null
>>> +++ b/arch/x86/kernel/psp.c
>>> @@ -0,0 +1,39 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +#include <linux/platform_data/psp.h>
>>> +#include <linux/platform_device.h>
>>> +#include <asm/hypervisor.h>
>>> +
>>> +static struct platform_device psp_device = {
>>> +	.name           = "psp",
>>> +	.id             = PLATFORM_DEVID_NONE,
>>> +};
>>> +
>>> +static int __init psp_init_platform_device(void)
>>> +{
>>> +	struct psp_platform_data pdata = {};
>>> +	struct resource res[1];
>>> +	int err;
>>> +
>>> +	/*
>>> +	 * The ACPI PSP interface is mutually exclusive with the PCIe interface,
>>> +	 * but there is no reason to use the ACPI interface over the PCIe one.
>>> +	 * Restrict probing ACPI PSP to platforms known to only expose the ACPI
>>> +	 * interface, which at this time is SNP-host capable Hyper-V VMs.
>>> +	 */
>>> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
>>> +		return -ENODEV;
>>> +
>>> +	err = acpi_parse_aspt(res, &pdata);
>>> +	if (err)
>>> +		return err;
>>> +	err = platform_device_add_resources(&psp_device, res, 1);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	err = platform_device_register(&psp_device);
>>> +	if (err)
>>> +		return err;
>>> +	return 0;
>>> +}
>>> +device_initcall(psp_init_platform_device);
