Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65587015D3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjEMJhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEMJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:37:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD53C1D
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc4tmu4y/pbmnzmBS9tnisOiio0LcG6aYnLbA8mgVBWCra29hlNd12MN95dKo/Q64/cmiZkWxPiuwKxnaMGgGgkyP3Lun2hBm55B16FDKWqmkFUPNbKSnVr7KPcsAyle4qPnEAS7ClJbgYnE2AnMCLRFu33trgOtXhILqfLGYikb6LI7GaUgqqMeOi2iRerXyN9BRZngyCgwHRE3y1IemWxL2z0iIp/Q9HY+ZFY/52+WIZd+l/zjvsUN+8HRIeJGQHfFv4Jkpjly78N9DjI395QPgPHGsyNOPpc9Q25N3DxZSdC9C5JC1ygIOdn0EVSVcmvZiLPIXPBcu+4p+mgtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBcrZx1f4XazXnuQ0vy5DSDrn5yhxC8k0H8VenF6peE=;
 b=aEbTrSdC52v40Nhxa/ZhjdMx7/L/QcSsQa6DcM/3AqqsTM5BPD8OHodLoc+bLoL/jyb7xiVTvYtfEUrxRTCLyQIMNapkNfa4xB50G+XT9U+LodRZxWzhj5Vv9nYVIKorz7kiUw8QCYLWOan8W2O3IAJQ+jUd8eJfUTcYzlvBRj3ha92YbDFr2LFdmicAUgIZ01L4V5NykGfj8QEUsEpdkTgpA8pPLXHrNalL+kfAv4MrkgLtAL2EWW/XK4/uM32Ft5wMwEf8XbkCuGGQTbtTXUAvEIL0VhFQK3WVfiV5rkIWl2POLDh7bNuJZvZoalU9Nfd8iQSEqhOWUEWHf7FPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBcrZx1f4XazXnuQ0vy5DSDrn5yhxC8k0H8VenF6peE=;
 b=eb5pNznGaE/TglmtbfRmNifoNDNHcffCPTeUNJD15AMghy1G43XNyPsYHnH1CJPk26k690w2NjhYYhWgZX/v/zwNMNfsrjYrd3I6CrbirurIDez0GhdIAggDkK6uK9tCbSDfcMGp+baQ3OgV58KfC4hs2DLE6z9RMF3ul6KE24d1t8VvkbH4RAoYyQdzJ/snqwOmqCHW/94q9mnLWoW8gycGGIs2V6rvRERDkpQBh06b7EeU/YjfinteEYOSxvlEQulP/sjdg6ZF/qw5pfpCa6OD1SylroOcA5PtmdFvTfTaapU8ZvbRcTfeDlVlq0yT8Ubg5ccVgY9TIE5SnzTioA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Sat, 13 May
 2023 09:37:35 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%3]) with mapi id 15.20.6387.027; Sat, 13 May 2023
 09:37:35 +0000
Date:   Sat, 13 May 2023 12:37:28 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+3384541342de0ca933f1@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues
Message-ID: <ZF9aWEeQ5+Xvc+oF@shredder>
References: <00000000000026b68305fb78c24d@google.com>
 <871qjldbes.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qjldbes.ffs@tglx>
X-ClientProxiedBy: VI1PR0701CA0027.eurprd07.prod.outlook.com
 (2603:10a6:800:90::13) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ff2a5d-d6fc-4358-0b7d-08db5395aecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ray2LxxAfanvt4Di9ROf4roaB3VSa1cuqWwWsP9MpDOEwaOMNEvZbFSfP5j4TSbk9f9hwQOKuvQR97F3tUdxMEQL0OmhuzHI5qHkSDpEvElUxETooihD6xpr2Cp4yr5ME/RQIVXd7XyE3TPcIIPwNk23uW0ei84Z6OYdh6zthjVwkYdXKN6SqMPvZTk+rM7SvJ9MWRYTiyOjJHLv7JZRJZNhmXKO+aY1JbX+2Ddl27Qp9fGb56PL3d8iwM8/V+A8yXSqIOLCFoSVCU3T1fE+0iuks20L3PwAM5OYItK/nuab4Kvm3PprbLmXDdKorkabdLwsQJ/6uNTW0hpAYk4y8PUXCUVKAfqYAynUOFPUczC2BwqR1Jqkg1FxBNk1Qq766inpxPHNqikZ0HTHPu0Dte6V4Ys8w1SscXPD+OxZk3mu5+uMBfWiFdx5R8YCsQ5JuOimJrI5xR2KJP+nh38b32sLlWwVEXFUqlFUHWWXjtR7yXeO0W61XQR7wqRE2l0YxFjbgJavuvoZ01QwqLmuL0CJXOF7EdngUIcpE5ddnaK7UJ7pibWZjeDTPwjYxx0H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(6666004)(66476007)(478600001)(66556008)(66946007)(2906002)(6916009)(4326008)(26005)(9686003)(38100700002)(5660300002)(6506007)(6512007)(86362001)(6486002)(41300700001)(83380400001)(33716001)(186003)(316002)(54906003)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ktu/C4/yaXYp+Kjd2HV9bdSYG7BkzG7irgWRfhHRMT0XGAhvDTLKMHEMWtac?=
 =?us-ascii?Q?LUW/7+r1nX3ON4b7bLwKh9Tw/nnuG2Hl3C6UzAVbrUSUYo3V5QwkS5aEr43s?=
 =?us-ascii?Q?UWyApONyTnQ8X0iY4LPo11XRnEk8+9eMMdR0rbaHugIGPjhLBRVJZPAzMKyP?=
 =?us-ascii?Q?I3cIMJ+ZD97odNwTj+rHU6noQ10DNSv/y3TgPc9ZLwC29dlUScBJMXoXoA8n?=
 =?us-ascii?Q?qVeBUN9HMTCDfI6ElGX7+F3CO26BkaCzgZTNn5byB2gGM+SMLs9Mey7OePXQ?=
 =?us-ascii?Q?PlkctDkj9nsF5HWNTPP3rlrKYUF9LC4pce7IlRTKycWRw4Qvvf7kHfiG1C3o?=
 =?us-ascii?Q?TdAvVYuGuPIsYIKwkO3fYVkeruh03CKGhp+R+QfGYmihHTCWnEomy/IAully?=
 =?us-ascii?Q?yVJSIneYNvWF9PD5QvqfFOFaOTqVVpU0CR/EKxAoJ7fJ49Xr7RsinoFGSrJ4?=
 =?us-ascii?Q?DKAF2wvoYEa7Q6BI7cYRMXyxonucEthZJ+5mScCmgrp5OhOEPWXB5AppcRTt?=
 =?us-ascii?Q?iHNhmI25dfWg7hwsfGfYiJEenXMnX40cb44QFT2kIBPw+IppgE7iSAVMb+1H?=
 =?us-ascii?Q?5f6gA/Moux4sCOG4IqD6EyrEnP9/cIRAeoP233Ly2G/3kn6VJcPD5BVL75kV?=
 =?us-ascii?Q?cv8d9x3PKcm0b/ZTw9m3jipbr85bQplw2OPAb1NW2OnYMYUQfFxbcs/dYtbv?=
 =?us-ascii?Q?9yBaNkPKv95/2+EouLir4NzBKolhaB3YmnHeRL034CRHkGxASBhc3i4Oa+Il?=
 =?us-ascii?Q?9Loyk+Shg3ioOylo4Go3vB1iGtRDt4Rum8DAoTYiqnJgtvm0q4y6OkRv8HJR?=
 =?us-ascii?Q?dlnlIrHvlDMRnp5o9MLjej8upxfy06pdVubLYgVKRrbBQLWKb9O7kf3d1ClP?=
 =?us-ascii?Q?bitOaUsguJO3eDeb29ljGmq2T7YS1+dngD31xcWc+5KmlSfFNU3fmn9y/DSQ?=
 =?us-ascii?Q?7D5rWo6PXalu2RG0AdGY6uiIvc3NjbwNwHupUK7eUH0MvsWWgfJtwERKFNoU?=
 =?us-ascii?Q?qZoyphVDaCFJXDiWEV5GaNPSpQdspQz64hJQ6cmB5Q7xrR+CZCoNhfuI0pWQ?=
 =?us-ascii?Q?YNwYWWJ1Rzq+2CkORmBlyL3mH5xnAvSpYNsmgYGp+Gv4iLVhcN72u06A4qkA?=
 =?us-ascii?Q?KwIU5GHfIA2cpR0dC5ulj3MMR/ZnO865eYJ/SlIyQW1Fn8c5zQLL6/pdJ4R9?=
 =?us-ascii?Q?HFzBpc7YmvGDoIgSJeqqnofhejkkUJeo393H/7sNoG2gP21SCDxq05ZAEICg?=
 =?us-ascii?Q?NlIbxJmFOsGkYMGT6HPYoEY3jdqzT6RSzP1MwjRjEBbxjLclraW0smtLPmL+?=
 =?us-ascii?Q?hhF9nYoN/naE3qZSA4Y0dCOPzjl2AxKpghbMy32mO2qFDy/Tvdl5jhhxdNbv?=
 =?us-ascii?Q?BxTVt1tQmIheYC8Cl5nO1AScUEkTpUfCGPddNhoqvFl/SJg1DlYPFbGPeCkJ?=
 =?us-ascii?Q?Xgsu3x7aSok604+WKwXkhKnmCoI9b5FZZPRLeLhRSZeflE+A5AF2dCznTZjk?=
 =?us-ascii?Q?Uc7n/CxQZflgf49ChForekvj4RZnuMYCYbn/6DMo6eIlpzWDSUHMR4OF4TMg?=
 =?us-ascii?Q?hooZDEmgocsp69W2ibZTSU4t+D1Vo6Opf/B2ULDy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ff2a5d-d6fc-4358-0b7d-08db5395aecb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 09:37:35.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljuuyubSpcCNo5xtpeOhJQZPzkS1kBYZnU6Slxeko+T4slqD5SMdakP0FPcbJU8Pabh5OIqDP0C3E4FGG0OTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 01:41:47PM +0200, Thomas Gleixner wrote:
> No problem. The lockdep splat is enough data.
> 
> Fix below.

Thomas, I applied the fix on top of net-next (which includes
0af462f19e63). I'm getting the splat below during boot and then the
systems hangs.

Thanks

[    1.708425] ============================================                           
[    1.709253] WARNING: possible recursive locking detected                           
[    1.710079] 6.4.0-rc1-custom-gba79e9a73284-dirty #52 Not tainted                   
[    1.711016] --------------------------------------------                                                                                                                  
[    1.711842] swapper/0/0 is trying to acquire lock:                                                                                                                        
[    1.712593] ffffffff8863bfb0 (&obj_hash[i].lock){....}-{2:2}, at: debug_object_activate+0x149/0x560
[    1.714037]                                                                        
[    1.714037] but task is already holding lock:
[    1.714947] ffffffff8863bfb0 (&obj_hash[i].lock){....}-{2:2}, at: debug_object_assert_init+0x279/0x410
[    1.716411] 
[    1.716411] other info that might help us debug this:
[    1.717419]  Possible unsafe locking scenario:
[    1.717419] 
[    1.718332]        CPU0
[    1.718716]        ----
[    1.719099]   lock(&obj_hash[i].lock);
[    1.719695]   lock(&obj_hash[i].lock);
[    1.720282] 
[    1.720282]  *** DEADLOCK ***
[    1.720282] 
[    1.721195]  May be due to missing lock nesting notation
[    1.721195] 
[    1.722245] 2 locks held by swapper/0/0:
[    1.722861]  #0: ffffffff8863bfb0 (&obj_hash[i].lock){....}-{2:2}, at: debug_object_assert_init+0x279/0x410
[    1.724393]  #1: ffff8881f61e9618 (&base->lock){....}-{2:2}, at: lock_timer_base+0x5f/0x200
[    1.725718] 
[    1.725718] stack backtrace:
[    1.726396] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc1-custom-gba79e9a73284-dirty #52
[    1.727737] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
[    1.729091] Call Trace:
[    1.729473]  <TASK>
[    1.729816]  dump_stack_lvl+0x91/0xf0
[    1.730400]  check_deadlock+0x618/0xb10
[    1.731023]  __lock_acquire+0x2226/0x62d0
[    1.731664]  ? lockdep_hardirqs_on_prepare+0x420/0x420
[    1.732475]  lock_acquire+0x1a7/0x4e0
[    1.733057]  ? debug_object_activate+0x149/0x560
[    1.733791]  ? lock_sync+0x180/0x180
[    1.734354]  ? lock_acquired+0x238/0xa30
[    1.735000]  ? lock_acquire+0x1a7/0x4e0
[    1.735613]  ? find_held_lock+0x34/0x110
[    1.736238]  _raw_spin_lock_irqsave+0x46/0x90
[    1.736936]  ? debug_object_activate+0x149/0x560
[    1.737669]  debug_object_activate+0x149/0x560
[    1.738372]  ? debug_object_destroy+0x210/0x210
[    1.739095]  ? _raw_spin_lock_irqsave+0x60/0x90
[    1.739820]  ? lock_timer_base+0x184/0x200
[    1.740469]  __mod_timer+0x820/0xea0
[    1.741047]  ? timer_fixup_activate+0x2c0/0x2c0
[    1.741770]  ? find_held_lock+0x34/0x110
[    1.742397]  ? lock_release+0x3b5/0xbd0
[    1.743013]  add_timer+0x67/0x90
[    1.743528]  __queue_delayed_work+0x1a2/0x270
[    1.744226]  queue_delayed_work_on+0xce/0xd0
[    1.744912]  crng_reseed+0x124/0x270
[    1.745485]  ? random_write_iter+0x20/0x20
[    1.746137]  ? add_device_randomness+0xbd/0xf0
[    1.746851]  ? blake2s_update+0x106/0x4e0
[    1.747492]  random_init+0xcd/0x1a0
[    1.748054]  ? random_init_early+0x2a0/0x2a0
[    1.748739]  ? hrtimers_prepare_cpu+0xab/0x330
[    1.749446]  start_kernel+0x226/0x520
[    1.750039]  x86_64_start_reservations+0x18/0x30
[    1.750776]  x86_64_start_kernel+0xf4/0x150
[    1.751432]  secondary_startup_64_no_verify+0x106/0x10b
[    1.752264]  </TASK>
