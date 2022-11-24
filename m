Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE9637B67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKXO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKXO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:26:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C877E9172
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndcl95vLPMBWvKVp/xizOHSN3lZCPkof9G5dL1iD0BixCC5kswKK9Jgq2UyU+QhTnayaKuMTkxi84Qm/6VWCGiwSqT+KomK76UtHkj+uEKFVwd7mb+AnndOuYhg6Ehxm4M8c4kSv3dFK1wCg/anzWh0wpfJ8V6sZmOkR7cSIynaQVfos6xpifY2jZlsY3sPRyumzdSY/QbyOvhJ0NkG/xfiQGmgiaUfW5cm5XiiDp+ygt+bAhnw2rtZjJa0xbKspZ67x2LWDjK+o8FPvGovGp82e2utnO1ajLQDWq9BwsBONU1aD1tRUsfM7RqvKHC7AUpGWP0R5XminvzlBy9oLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pUCgeFdZP0mSFnD9cqfI6NizeMAwEofU/AnRB6lvAk=;
 b=Z4XVgIGFHnNp6H6L5kBWGbxhku4wiF5apvSXub4JSV2RC00Xljd0sfVGS3QYOn0Zn9+e2Z5wJiF53luIeRIEtO1RvHAKkJql8U9DIkO25bmd3lw64aworGCneFgT7SIhjOrPsxdvs9LCWKWOfbxHqYYdoSxUFvFqpGT/DcZN3Sb38+dP1A9J/LkD/iwvr5sKqeRyl2mCh+v00p0w2LX7ip3htV35IRQLqF3jsDXxGvU62YlSCBBK/+vMb0673f9RzwOlW1SBOmdhW07ynsjOGXrBz9OqRb9Uw3YnC0Y4WWMlJ9Owi61mq1YZJZNOOBUBt8VcxWgi5J7ji82Mx12Uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pUCgeFdZP0mSFnD9cqfI6NizeMAwEofU/AnRB6lvAk=;
 b=fV+qGmMmCvkTNPJaF9OOKF8WQ2M1/2rSPgOY8e1fYLUrCkIXfXZyb422r9CJB/6LHctj7TyvMR86wROVCiMYNBMjpSjcTAm84cHqbQ+ihrKPvmbT62iVzoaHtdYnQUgeg/WwdLI6YBgomnNfHfPuVmv3UR36wl1+TX5pduLV9A0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19; Thu, 24 Nov 2022 14:26:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d2d2:c91a:5927:104b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d2d2:c91a:5927:104b%5]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 14:26:39 +0000
Message-ID: <763b73a4-55b6-2cd3-02e9-1086d36cf270@amd.com>
Date:   Thu, 24 Nov 2022 08:26:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/2] Map initrd as encrypted when relocating if SME is
 enabled
Content-Language: en-US
To:     Zelin Deng <zelin.deng@linux.alibaba.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
References: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:5:40::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d54d80-1c54-4d42-4498-08dace27e6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pavZTAZzJ28rt4VOYTAdhlCtWkU011U2zouXMkR8qWjBKKDbXhvy5x1crrr78jXHaQoQ4lVDF4dPMOol+PV79Z8grAnOlOKp89feUKYXSl9E6z9gtLQQGNOiK4p48T8SA8AlX99kMq4cVkFL1A2PYKbnzoX2NSEQ9ySSpKF6shuStZ1gQ2akEreOPoDX6c0yuI46k7p8UY3fYVQqIdkehzx/tjzJOmEAyyPvghd0hwg0emxKx+YbYdTo6POhyhVscfG9YehESwPmtPgrVZPuTGHFTHI2IFs6wFl5hRabfV8XlgiTkq8tE5dDTpeJM6oZB/VNAPKS4OyFdY3B7cYD5CptoUEJt/tN2bBMUi0/G0BpgE9hvuuWBefCCFLXqwLEJvE/1MpJR688vnGSLiOUKiMrPLyXFN5RXU3HK3PqSt5purPtw8GjykRfPkMCRLW+acD+p7nx62t6oxudwUA5wtrW3jPoN3qIhGR9y34WoUGd3W137qV7E7NN53tZtLVj1CKy7cXYXLwne4l8Drlcc7ogVJNSxBvOP/nvi1Acuw1Xr9+SWQmZbAyVGadDIUxJlIVuX2KhPYaGuJ51vhcIc7Ma7shWEURXT5JOu6813ttJqIW+FI6Xl9fUT2mOyI2DQQahjVdCk3QWNgEKFmW8shCgveErFqkz7wqV1rgJV0uED3kgVbqnoKdCeiWW/XMmQPBvAlMFTFoyo2c5fgFuZa/3+P4lhI/WHPNiQV/Jkrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(38100700002)(31686004)(66556008)(36756003)(66946007)(66476007)(6486002)(478600001)(8676002)(54906003)(6512007)(316002)(53546011)(26005)(86362001)(31696002)(6506007)(83380400001)(41300700001)(4326008)(2906002)(2616005)(5660300002)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGl1bk9HOFBKMGo2aERFMCtLMDRoV3o4WDIrUVFKNjBGM09BQjRJQ1hDS0Jv?=
 =?utf-8?B?Rzk1VmVDVEtlTHhmNXc0Y1pudC9SMjZyOFlKeVRUdXNOcGIvTWVwVzFtSnBK?=
 =?utf-8?B?V1I3UDJURm1NOXVkUWxaN3NOc2xqNFlxZXNucTB0Rzc3MUhEbkhWTUc0bC9B?=
 =?utf-8?B?NnIrVml4K1NoYW9PRTdnZHkzU0lqcXJhYXRkK1Z4TWhmNWhnRTN1NTdzZ2ly?=
 =?utf-8?B?WENwUzlGbUdVVWo1Y20rQlFzdy91WEVxYjRBbGNiRnNiYkhQK1FqSVA4N3Fw?=
 =?utf-8?B?ZFVjb0Zmdm84RnE5UWtrZDMvcVdIWUtrZnFFV1VZS1orLytYbTB1RFV1NlYz?=
 =?utf-8?B?eDF6Tkl0eXk3WXRIM3lyR1RSYWxESk1Ha2hxbjd0bnRBTmVCdWprR1g3Q2lM?=
 =?utf-8?B?ZmFGUE5YSmlSSlZXL3Fnam1OWlNSV01ZMDBTMGhrSUZ6RXRKVFEwb0JMbnpm?=
 =?utf-8?B?dnNRWjFiTUJSbEJNaEJrZlgreXhZN2Iya1ZpT1cwUnc5anhDU2ZjQU1mNmNV?=
 =?utf-8?B?aklyQm1tcyswVzE0cTFnbHFBLzhLb2kwdmhMQW9WSDdEZHJXekI0VnlNaUZ2?=
 =?utf-8?B?WXo2ZWgyMmtaWEtoNkNZVTJhMkc5OHBoRXcreS9hNFFXVlp5V2l0Uy9qcXdv?=
 =?utf-8?B?dnpUcElBM0ZYMm51OG5uUjVVS0d1QysyYW1OamJMZWR5THZrNUJxejk0Y2Z5?=
 =?utf-8?B?aGNuN2FNWENiZWVENThCRHlWRmJvbkptOFNpdjZEa0pyWTk0eEhQcTMxeE9G?=
 =?utf-8?B?aFExNnEyMVhMeUJOWDJlVjJmSTFUQkpvTytaSWw5d2oxZzVrN2w3T3UrdmEr?=
 =?utf-8?B?ejNnN0JoamoxQTJkb2kxNnBvY0NEM2tIck5Hek5EWjNSOGt4Myt2a2poUVQ0?=
 =?utf-8?B?dUVFYWxXWkRGT3cwUS9WcWJncTA0UW15MDBzUjkzdlg5dnhrc2pzOVVGSmts?=
 =?utf-8?B?aUlyM1N6MWVZd29ycGNHS3loYThlNkpodDU2MkoxK2V1M1NKMmp1SmxwcXV1?=
 =?utf-8?B?OVZ1cW1JUWdFZUU2VHBxZVFDSk9TanhjbjdwQVdCemtITkFySldadTBCVFFw?=
 =?utf-8?B?bm1rQ2VlaUZlMGJxWlpzQThvVVRIeU4yRG53Q2psV3dGSEF3NDEzaHg4dDFJ?=
 =?utf-8?B?YVcxS2kzZG9KSVhrSGhDSDU1eks0dDB1U0xJQU9CVUxmdWppUzd4RytnaDdx?=
 =?utf-8?B?KzVuek9aY3d2b0Njd3JOK0pEQXhDdzBiK3A1a3lOZmdDcjhVU2RVVnlnWVlM?=
 =?utf-8?B?NGtuc2lEKzJFQXJRZ1RwSmVQK2NLSWpvc3dvZ3hIWkgzcloweWpISHVWZ0tn?=
 =?utf-8?B?SytWdmNhQmJaVnBnVmNJSTRrdXY5bEV1ZjBqTXVRTHdDWEl2RVZJdmEzMGFh?=
 =?utf-8?B?UGliQTVwOTdHaUU1YWRkL3pnUmNnWHJzckhYMnptR2lzNCtOczN2MmhoR0VI?=
 =?utf-8?B?SHFpQWFaL2Zkd3NqWVVRMm1Ib3VRMSt6WGJ1TUVzSmJBdlJlRVE3dkQ4RnBB?=
 =?utf-8?B?SWZsRExnZkhjcUc2SW91Q3l4VDBrK2tadngyU0swNnoranNwVzhZUlRqeXBF?=
 =?utf-8?B?VCthcUNlZGFtSHdKNjVUNkFNWWxyNjQ3a29EdzBGZWdPSmM2dVVhYXc5TVA4?=
 =?utf-8?B?cEt1VkJrMVh2d1BqZ09nUVgrMnVUZlNQZEZrMWxiQzZlY2VUWXh4ZDkrUCtO?=
 =?utf-8?B?K0NEcHM1VTh3ODVZVUFUWE9hU3ZoRFg5UWlCWk5jZW56ZStXQ1ZuVzU3b3pX?=
 =?utf-8?B?dGxTK3prMDdONUtWa2RLbmdOdkpuczZHa0Ywd0JRSW1vMVlaV09LdEM5U2hQ?=
 =?utf-8?B?bnI0Q2NFVFJIa0RlZ1lhVnVXQ2J2a2JWaDZxRDVQbnNlRU1FV28rdHdacGdo?=
 =?utf-8?B?Rzg4ckszN1BMVjhKR2t1dXVnS09nQUdrYlF3blV3anRyeXJxa3NLdXkrR2JP?=
 =?utf-8?B?YlVWc2RYK1RJem0waVR4L1F0bHRnVEZsUytPMVpIamNSc241STAyaStIQTB2?=
 =?utf-8?B?dWdaWTJpS282UTEzVmxCbWwxVE4xVGNwbHlCellPaFluaHltK3lFaSswOUV6?=
 =?utf-8?B?N1JPVUhna2R2RFZOSWozeXhIcWFKaW94NitlYmNLY2JEU1Z4b25BWTlKUlc2?=
 =?utf-8?Q?zprrhCzFmSzKCt69thtxbEcHt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d54d80-1c54-4d42-4498-08dace27e6d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 14:26:39.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjSV8eAUpMa8esFuZmDOhsdEbMrkW4IR+ToN2ZdGg2TPpNGlNPsbkDNEfKOTQ6NTirSnt3b7/I2KYsAoijFIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 03:12, Zelin Deng wrote:
> I found an issue on SME enabled AMD machine when initrd is relocated if
> it was located in e820 reserved area.
> For example key dmesg output:
> ...
> [mem 0x000000005aafe000-0x000000006005ffff] reserved //e820 mapping
> Move RAMDISK from [mem 0x5aafe000-0x5ccd5167] //relocate_initrd()
> ...
> 
> Early initrd will be copied by copy_from_early_mem() which will clear
> encrypted pgprot flag as initrd source address is not in kernel usable
> area. As initrd has been encrypted at earlier stage, encrypted data is
> copied, which leads new initrd cannot be unpacked, then rootfs cannot be
> mounted.

This is actually a bug in Grub where the kernel and initrd was moved out 
of loader_code/data and into runtime_service_code/data. This commit has 
since been reverted because it goes against the UEFI specification. It was 
a small window, but the bad version was picked up by some distros. No need 
for a kernel change, please update your version of Grub.

Thanks,
Tom

> dmesg output:
> ...
> [   11.296725] Trying to unpack rootfs image as initramfs...
> [   11.302127] Initramfs unpacking failed: invalid magic at start of compressed archive
> ...
> [   16.698152] /dev/root: Can't open blockdev
> [   16.702255] VFS: Cannot open root device "PARTUUID=0ad58d87-05c7-43f8-b147-93140ad315e5" or unknown-block(0,0): error -6
> [   16.713114] Please append a correct "root=" boot option; here are the available partitions:
> [   16.721462] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> [   16.729716] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc5-next-20221114 #3
> [   16.737099] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, BIOS RYM1008B 01/19/2022
> [   16.745175] Call Trace:
> [   16.747623]  <TASK>
> [   16.749727]  dump_stack_lvl+0x38/0x4c
> [   16.753393]  panic+0xfb/0x28a
> [   16.771999]  ? _printk+0x4c/0x52
> [   16.775224]  mount_block_root+0x143/0x1dd
> [   16.779237]  prepare_namespace+0x13f/0x16e
> [   16.783334]  kernel_init_freeable+0x15a/0x164
> [   16.787687]  ? __pfx_kernel_init+0x10/0x10
> [   16.791785]  kernel_init+0x1a/0x130
> [   16.795268]  ret_from_fork+0x29/0x50
> [   16.798840]  </TASK>
> 
> To fix this issue, early initrd must be mapped as encrypted when it is
> being relocated.
> 
> Zelin Deng (2):
>    mm/early_ioremap.c: Always build early_memremap_prot() in x86
>    x86/setup: Preserve _ENC flag when initrd is being relocated
> 
>   arch/x86/Kconfig                    |  1 +
>   arch/x86/kernel/setup.c             | 30 ++++++++++++++++++++++++++++-
>   include/asm-generic/early_ioremap.h |  6 ------
>   mm/early_ioremap.c                  | 21 --------------------
>   4 files changed, 30 insertions(+), 28 deletions(-)
> 
