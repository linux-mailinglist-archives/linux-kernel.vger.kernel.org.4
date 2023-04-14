Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4C6E1B83
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDNFMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDNFMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:12:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DBD5BAE;
        Thu, 13 Apr 2023 22:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlBArVbHSVFr9U6sZEbe9BT5VvLp8zCta1c/7lKt5RHtMdcXbblHJ514MSvgIPBjpPhJ/+rv1oF5v6LT/5ZqtO1Vmfcyxe5bwK44U4R15jMnXS18Y8OdpaFsxNwJZxPPzPM6SCQ6k5FNWpsB4NvTGq2E5e+LXQQdm2qvAM6/l9PT+mPhK/+RI9dZXkM3LzVhqjRVvAo07zl6NoAh2QX0t9HpXEyVBwdXvaaxYpIDbfxANm+I6ZS9MvUF2kN2iRjHWoDsEXdOwW2ePUtjU1HF7N2ooIFX3zyeSl+MDjud5SwHbknMa6iElnXIm2tiY87n2DxXui5l10oJLrKvFKVqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2SNzLHZ4ErYqdEmaxX8Jtd35UX80tM/8AVuVHC6Aho=;
 b=c3JtVzlF/h5mzhXq9ytqYCTj1ertZPS3GWBNcsysQBgRcroz+Ajl+YdtWvwBQ8ZkW0c6h8xwNpznUMBeWws0z3boVFaRSFcMyPNoi8YFg/TVsWNMwrhJcVeuXegAw5Zcns+WLWQYuYR3Nr0PP7HQ4OH+cQqVcLGoJ7cIbVNgOEM53pG3A60aYjSlr7FfJQrVI5l/dgNpuKUEU+dmC0hOGc0uzkfJQJT/MgjYIw91zuxvwgQZdQ8CkcOL7vdPiM9BWGZgAHnUjTPNEeMfQP+zEZrxMh0K97lsgpflUto5JyfpzKu7E+DZtm8G+KkV8ED9X7YJzb8WIewxUSBDmXbvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2SNzLHZ4ErYqdEmaxX8Jtd35UX80tM/8AVuVHC6Aho=;
 b=fD0m3Ra699BjxqQl1ZcOVjWpMMhj6ZJSBxsZXh/nl5olTBVOVQHiGUiBUm3EdHrq4Jbsk9Tx+G4USngPqok9ufu5ILyjfSNHci9VO7m6nUKECNhgU65HUZ5Y3rEBSorD59hFibIWkyjT5fvFoHFOJNkchV0dvAlBTVCaLQUxgUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 05:11:40 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::c70e:6be:19fe:36bf]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::c70e:6be:19fe:36bf%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 05:11:39 +0000
Message-ID: <0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com>
Date:   Fri, 14 Apr 2023 10:41:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: Tree for Apr 13
Content-Language: en-US
To:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        axboe@kernel.dk, Santosh.Shukla@amd.com, Kalpana.Shetty@amd.com,
        Narasimhan V <Narasimhan.V@amd.com>, sfr@canb.auug.org.au
References: <20230413182542.1133335-1-broonie@kernel.org>
From:   "Jain, Ayush" <ayush.jain3@amd.com>
In-Reply-To: <20230413182542.1133335-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 7088658e-7dab-4c07-3108-08db3ca6ba6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIoKQuCk3JiNkEVXmuiVrs9EIE31/D9nEe2VU+bCSaEzoA21Umhz+srGL5/fOa3Joe5Lic61X9JkrnQuKGTHKUlcNK7ULVbwZ+lCZc15+/u/MMF4GOyFSmuKoaybu9C6iGMpOZs9rLLV7AFp2hEqPmv8zaW823lUYbriARoXACjxPnPcEfCMoWzn0mTnshw4YQCUDIZg0yJXIL+V7JoJAf/4pqyeFuv5IIbLSL1NYm9QjLjtbL0duOTwoXjP9aUQvzIO/sL6ArkPqaKRxqq+nViNIiNAYAQxdrlaF2OwfGOczkAp4eMBdC5Qbg6YDFkR/Oi0g/TD5DlJaVNabBIlUHR/0dABkvajdat0etig1JNYkNhlkzu0AwMwsHpQwKNYPsZWsOu/vLXWenSuKfccWc5FYh4N93+QIDFF2LyOKO7DWgqDfGo1Sm7NDIF5hokDKhR0vkqbVjjMk6eVxqKsK1FoJcg5nRz/9ZElMWV9g9m1SI/1RNxTb4VNVzROAqZEC2mi7TkmHbDI23wlK1y8BuYFJH1uPSAKXTpf79gAL+q6IHcUkSljuIsooFKLwfjZN1R07YVKTGZdL1sAXJ8K0cymQeRbQMaAy5HHkWevlZQq688JEwfD0RenaDtepsBp2xyArDrrTyAUeEjiXraf7DTnzC2oYMhftECm01sChCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(36756003)(478600001)(966005)(6486002)(6916009)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(316002)(54906003)(83380400001)(2616005)(6666004)(186003)(6512007)(6506007)(53546011)(26005)(86362001)(31696002)(5660300002)(38100700002)(8936002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bittUTBuKy9BVGwrZ0xkdVh5UytYaEI5L0ZreFlJZlA3QW5mRk5MTW5sSkNp?=
 =?utf-8?B?RGt1MzlPclRsb1RWNHNaTlFqeHB5V3FJYXFldldzcGhSd3FadG5HTlRBdWdq?=
 =?utf-8?B?dDl3aXQ5NlViOGtNV0dYR21LZ3ZaSXZGTEJRb3BIWGVDb1B2WkxZVW0vYklE?=
 =?utf-8?B?MVJpT3FuMXRlL2Q1Qyt2WlFnbmd0cGdURHNDeS94ZzNqUTdYT0VEai9mQ01p?=
 =?utf-8?B?OURUS1JWZ2J4M1JjVEFkZU42VG5aNGVjb3dUTlMwN0tUTURFNlhNekZhd3l5?=
 =?utf-8?B?amo3bEJDcitOS3RKUTBUTzBhV2E2M3hmelVMcU5mQmpHYUxmMVZTLyt6VkhC?=
 =?utf-8?B?dTdwRmNpS3o4aEVUMjZBVlhlQnhCL3dXeGdyNUsrcGU2YU1HaFMrZGNTZUh4?=
 =?utf-8?B?T3dENU9pOGZPeEZhQUIzemd4YUxDTS9lMkhJeXBXL1I3bmZJaElkQ21qUHVl?=
 =?utf-8?B?cmRNS3VzbHRreW1kT2l0UHVqNDF5WTlaN3VmLytjZFFRcGhsRWdFNVRYckds?=
 =?utf-8?B?RThjelhkbzhTalBCWC9LWXdzWTBqb1d0bTE5dWtma3pTZXJmdGFvRWxFN0pJ?=
 =?utf-8?B?OThTR0FHYWdoaGNkRkJHY1B6U3Zac1d0MHdYT3loNE50bERnK2phRUpRUUlW?=
 =?utf-8?B?Zjd1TzRyYnBLdWltTC9LR082VFVnUm1MSVJxRFkvVzArM3U0MzVJTTlwZHpD?=
 =?utf-8?B?N0xObjZab2dPOGRWaUVNRGV3enIyVHIwb3MvdDZoUnVBd0tWK3ZaV3VnVEZX?=
 =?utf-8?B?dE1tMVJpazVoeTVPbDMzL3hDQi8rZnJOeEJra0pMdkJES3NvZ2wzb2UxaXRo?=
 =?utf-8?B?bU82ZXFDL0VBc3dySkJhQjF3V1JsK2tkTkczS1lKOXFtVjJZSHZiTGdPYnhn?=
 =?utf-8?B?VXhBcHBSblh3VjdST0U5MmxNdW93b3BmbnBYYnhIVzJRd2dTbmdXQUJRZzEw?=
 =?utf-8?B?MWVXTWFWNnlBbkJmaHZsUHhqTjNCS09LaHFWZ05mK2ZZbVJPaTdoLzZ2aGpt?=
 =?utf-8?B?N1RGTjN0UTVzUUVFWnVpWXRnTVl5MEhyZUtKUG95RHdYVVdVdmx2SlBYYVVh?=
 =?utf-8?B?cnAxL0g2dTFsdUdGM0JYc3pPNDJHN0NVV3dYYzJwSURaTDdGcTNLWEFHc0k1?=
 =?utf-8?B?T2wyeGpjRlhYcE1ORnEweTU3aTFrQ2dxNEJVNEhLMWFuS24zejVVbkd6MEh2?=
 =?utf-8?B?dzI2ZDRLNmRBSDYzN1F2M3NNRk1leTZiZEhjaVhPQlFwUW1IcW92VWVCOHZu?=
 =?utf-8?B?T2lZQWdTeUFMdmxJd1hhNWF1TWVHNmoyc1ZuMldqR2RWRDhGNldBa2pOTzhJ?=
 =?utf-8?B?bXBDU2c0UVVkMDNLNTNob2p1VjgrVFNZbDM0MTZpbU5BYm1VMHRrdk1oOVo3?=
 =?utf-8?B?UWI4WFh5bkJiVmtSeWZvRWNaT2N2cFVCSFpHcVltWFRCOUtSaVBOQWlXaFdn?=
 =?utf-8?B?S3FXVUdpazJsK2lqL0tYSGY4MG84NnJMNlpWc281TzFBc0ZEYzJNajEybGlR?=
 =?utf-8?B?bm16OUVId3Q3bXhLZmRpaWdJeENMbG42dG40a0ZsZHRpYXh1c2NNUTl6Z3VC?=
 =?utf-8?B?RWRWcm85aHNBVTZCOVY0L2JaSWNvczRjVkJ1WElFMlByREUvQUxxMVRuNFZI?=
 =?utf-8?B?dy9iaU5hUHhKblFvLzlvamVvTjl1ZHA5RitVUlo3VXNPY0tBN3NDNnZLNzdi?=
 =?utf-8?B?Mjd6OHcwUGg4RklCMHd1b25tNGJWejhscXhoNzVmS21Sdy85UEpOaGZ0SXBY?=
 =?utf-8?B?cnRzNTJrSnF3ekpBamtkcnVWZ2Y4TDVpelphN3FDZEZ5VFlWUG9CRkQxSTUy?=
 =?utf-8?B?NWtjMDUvUHhzRVYxSDZ6ZEhOLzU0TDVIdHdVNDhKZmhvUVFOZFlqbDhGY2gz?=
 =?utf-8?B?c3NYbHk3NkpRekF3eE0zdE5yK2lrTVlaOXNUaVB0K1dwcmgrdmFYV0E5cXRH?=
 =?utf-8?B?SnlKMlFGaHBPdmpyMW9UeFd6bEpkTWJ6am9KRjFSSGMyeXZHZ2YyUkNYTUNO?=
 =?utf-8?B?WDNuUmtnajhsT0ZGdGt0N3BsUW90clU2em9VRVpydnVRQ01Jd1VWMzNoS1gw?=
 =?utf-8?B?clFuc3g4NzlkdXZlMDNGcG5ydnFHcHJ0MzlVYVJUU0wvQjN6bVE3Wm5WRHp0?=
 =?utf-8?Q?j0rM9fycUHE5QBgGtzB5yQ+Gj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7088658e-7dab-4c07-3108-08db3ca6ba6b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 05:11:39.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bi6KsSS17xNRuEfSG+/FJI8CBqlsMFAqAv1xv6KiEdulWi9Ydb7dA2MGFqedcONiUkGf07fOWDAMutE+BB6uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Broonie,

When Running fio-test on latest linux-next tree, I noticed that test hung indefinitely, Going back I see that this problem exists since
next-20230316 release, After bisecting I landed on the following merge commit by Jens.

Commit   097d3ca138f9 ("Merge branch 'for-6.4/splice' into for-next")

Running perf I see following trace and call-stack for fio:

  Overhead  Command  Shared Object     Symbol
    25.08%  fio      [kernel.vmlinux]  [k] copy_user_generic_string
       copy_user_generic_string
       __do_splice
       __x64_sys_splice
       do_syscall_64
       entry_SYSCALL_64_after_hwframe
       splice
       0x1c44be0
   ...

On a good kernel I see the following perf trace:

   Overhead  Command  Shared Object     Symbol
     49.93%  fio      fio               [.] fio_crc32
      7.23%  fio      fio               [.] clock_thread_fn
      2.10%  fio      [kernel.vmlinux]  [k] clear_page_rep
      1.55%  fio      fio               [.] __fill_random_buf
      1.35%  fio      [kernel.vmlinux]  [k] loop_queue_rq
      1.05%  fio      [kernel.vmlinux]  [k] copy_user_generic_string
      ...

I see some splice changes being added as the part of merge
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.4/splice

I observe this problem on 3 EPYC system(Zen1,3,4), with the following disk architecture

Zen1: nvme0n1   931.5G Samsung SSD 970 EVO Plus 1TB
Zen4: nvme0n1   232.9G Samsung SSD 960 EVO 250GB

I am running fio as follows:

    $fio fio-simple.job --filename=/dev/test_vg/test_lv

where test_lv is mounted as follows:

NAME                           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
loop0                            7:0    0  12.2G  0 loop
└─md127                          9:127  0  12.2G  0 raid0
    └─test_vg-test_lv            253:3    0   5.5G  0 lvm

You can find fio-simple.job at
https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/io/disk/fiotest.py.data/fio-simple.job

Fio Version: fio-3.34-25-g07ed


Regards
Ayush Jain


On 4/13/2023 11:55 PM, broonie@kernel.org wrote:
> Hi all,
> 
> Changes since 20230411:
> 
> The sh tree gained a conflict with the mm-unstable tree.
> 
> The erofs tree gained a conflict with the vfs-idmapping tree.
> 
> The ext4 tree gained multiple conflicts with the mm-stable tree.
> 
> The net-next tree gained a conflict with the origin tree.
> 
> The bpf-next tree gained a conflict with the net-net tree.
> 
> Non-merge commits (relative to Linus' tree): 10382
>   11028 files changed, 580165 insertions(+), 249563 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There is also the merge.log file in the Next
> directory.  Between each merge, the tree was built with a ppc64_defconfig
> for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
> and a native build of tools/perf. After the final fixups (if any), I do
> an x86_64 modules_install followed by builds for x86_64 allnoconfig,
> powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
> and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
> defconfig and htmldocs. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 357 trees (counting Linus' and 102 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.

