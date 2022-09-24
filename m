Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F25E880E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiIXDtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 23:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiIXDtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:49:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9521514CA;
        Fri, 23 Sep 2022 20:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTg5YK6bBDxWhJBla0tpeV/SD0l97mN+8A6xVn0ELJWjskR+rc6OVwZj1axHya230XVe/F3x+pq/Avb5tDo8kPp6pOmRDaLod5IhN7tspWSXrb7CsVr4rm3jM0dfW+0PKO91OYrgBnGgxv52VJGIeWsSiPdUef1FlmQBOpXxCFuXNyQhtbgcE1rL/E+iiaVveNFGslVeMRfPOa+ewSHRqtzIwS9XEVm1XofDZGJTANU+sUBehO6cQ/Q8BXP148qHDX2CpU+oQEYWfMR7mxiKVPITRqrxee8RcUYM0vCGmlbwM5D4U5BWOljQcdJTGXHRzVIAX41P66l8bdA36aNnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrmf8j6cyPBq5ZkgsB8Qlyrx7m4pbQkxc58NTKNybKQ=;
 b=nZ6PKgCzujXPvYW7DPmbZYg3ot1hNprXCc1PK6qQkMjz0eRIK1SfsEVOxsx9Pi16UHIjDRFytLII+1js0lzYIYqpECMroQTvaDMfpiHgjMZIaOx/MfHezPt79z9/63usbS6ACDNj1aAegceybvH5uU6M6A6xiJClnUPkKykJkifB4gMxBQCzRRZhz01Au9cV9X/n7dmNQtu3Yx0JLjAVPkcpTIvly9wNnJWyTLMxr/fSjJonSoGsdztw1srdU9D9k5AyCg0r/6men2FnJIgcGaBCZ73OcjkPIpM7/MykCel5pkczy8JI+SsgpIi/zJeglxv7ygwFTHNrN2raVDLICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrmf8j6cyPBq5ZkgsB8Qlyrx7m4pbQkxc58NTKNybKQ=;
 b=jRmvjWMId453Uj8h1wj7hcN9oLDcHoleit+c2wV30S7db2qfwwva9pgPQdV6yNI2G+cE7P5KOdUD9kOzp8yKqWGaCkvVg+38mcOnNoYs3EJg4JNWA3JDORwbOTmNKTO+kjECfSOVp7UMNSS9FuMzbBMCDCrX2mciGWGMgR/DQ7/Rd+3oqdRsFdWBFTAQZfVc0o76p1ZX4u5aA9oV8hwOCXZuQtqAAIISyYaukhk4A8ZaASxVVuLYQOwbjyrG6zAifn61JLeBKq6I45fzse0uRA1dk0+qUguhd2CfeWfbWs8J8gOwRO20498oZEKw3LmwcNNx7wRUV4gkPsl9dXNIGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYUPR06MB6150.apcprd06.prod.outlook.com (2603:1096:400:359::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Sat, 24 Sep
 2022 03:49:13 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5632.019; Sat, 24 Sep 2022
 03:49:12 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com,
        axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Liming Wu <liming.wu@jaguarmicro.com>
Subject: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in init_rq
Date:   Sat, 24 Sep 2022 11:48:54 +0800
Message-Id: <20220924034854.323-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0076.apcprd02.prod.outlook.com
 (2603:1096:4:90::16) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|TYUPR06MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 719eca34-54a8-4e8c-7a9a-08da9ddfbe6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVecQu3FNu8WfR5c1aV9qYioAp0AtH339n0lXw+23Jm266XphCAvgVflzRRDpVOHMvFmVC3hVqSlImb2iFwCXfhUN4Po54htkuPFRbsE3Ud5HLo2dTtLu/8MvBy1AG7/KKb18htsUeyXqJwwsp1wM7eJ05fUmWpknhdDy9n3ukPR0jHS8GjWviA0M+86nndsd6u4zKVPD+EDAAsaeDEExFDFbr+/qycfC0iEYS7JlZAEjKaiuxDZcozKOpSFtAM/wPkPZfFqoUZodhm4XbymbgH0wXi1Q2Flz0+Qn1lZfJkE0YCTfcHqN4uLLcp1rWGR4pc1JwiMNtj5pSPK+Aer4B/luez6edV7F2l7NxwNwGUoW4rZNTgtNGg2Xmi9K/z4SwP5/e0BRhNv43nYNYH6e2uc4P6ouNUhdLhmY98S+aQGri9G8+WYLe4U1Rze0uV8Gt/MyJn4to9DubdY1s7jlbrVLMZtHzUQCLx3WkpdjqOt8pGmkmhdw2UB6BQFg/NGLGDnSlT+rvnBup1I4itjIeDoV6OSKm6jZRmQ9FU2AUsqLQe2MZLAV7UO6szd0mudbRFCpfI37DUPcQppc4CgRltQbzyE5fjzdJexOO59UdCyJ1i7gpitGBDO2HHZsaaE/PfM818I4WnrkubiJNc0iuv0M3E59yD2eOrx8tHEOO76L4qDzfQl+gf/Ubn4ppvfVs/0NC6LraUQe0N2dzBBZstBYuctCIw1m/q6XzfLFLSdmVzEAOwD3kQwF0RqD2t0kQ1P/5JmD3LgguArUnHnzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(396003)(39840400004)(451199015)(316002)(8676002)(4326008)(66556008)(66476007)(66946007)(54906003)(5660300002)(186003)(2906002)(8936002)(1076003)(44832011)(41300700001)(2616005)(52116002)(83380400001)(6666004)(6512007)(478600001)(6506007)(6486002)(107886003)(26005)(86362001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T/kdPtaGTxsr7EtCqvv9B7lKv1Av8W9xWnfIPvSo9dQ1TJyGvzPk2XWTGkjV?=
 =?us-ascii?Q?5m4hoN0+biugQIx/oydXOHoYhNzM4RxLTDTpHv93OVYKbu1VWEAsa4oK1Yhy?=
 =?us-ascii?Q?6qMpLcTpN+J3kiPXhxDTv9zUrJHeU2/AmBjhl8xqXmU8kaAbDZTTZKinu7Ui?=
 =?us-ascii?Q?K2WBqdT/VYh61zK6KR8ST9i+pBrWkotWjSQQRabS3TybQjp46Ss45Gc38IlT?=
 =?us-ascii?Q?PO6UTwwA7H3WVMVS7y1VADdNEEnxps4HmSaOG9bJCsAyV23eA0zbujYm/Ad2?=
 =?us-ascii?Q?vtYICSZ6W/MX9kLgbMf1oLqR07qlIAimCRV4S51QikhR7mtpFIyYXyWSv3Bc?=
 =?us-ascii?Q?AYHX07SdPjxYdYzv6e7XN4dxFUoaiIUGSXWS2uLA1ecB4parVfYmhRCS0ja8?=
 =?us-ascii?Q?zJwwYKNqyvkh5XGBPeP3f7yL5w0K0PwBQGwoh+L5d5unGffnTNJs/VVY9qLS?=
 =?us-ascii?Q?fpMLf0vjhwgfF7izODi8y5NxrAJ9uZrc69DEKGYVlGxsqYo3VKqJcEkeYjLD?=
 =?us-ascii?Q?aIusAeOeOgtSZajWhfiHhp1MuFf8QAJdBRYRzii2qjOlGaN+FmPgZhOQvanO?=
 =?us-ascii?Q?NK8Mv5ISj/sj2yNQC+IAfGWdKpR+qHDC639LxV8NfszvVEWnJYeZ3UNXrmbN?=
 =?us-ascii?Q?iR7k40M0GGTynQqC9BfJIhqHPaU0uRq4Jbz4JaqjLi8CEQnOFIn423+F0VTA?=
 =?us-ascii?Q?3rahVKJ8EG/l/18xA3NlxLxt/q7af4+2KePBTX31yltau+PskVKruMz2pTFB?=
 =?us-ascii?Q?Unk9DDOxVh5BgZLB9m6Db5pkULGEBW5JCyhUZgZhH5//eUYMoWkt97jL2x05?=
 =?us-ascii?Q?MJO3R9HWP55d1kpEwSr8nO1RbKGXmt38+sjL/WCWOlevkoaVYsocv8vol3ya?=
 =?us-ascii?Q?SR8uhtKlXP4PvIEyAL2lQPXSGO/PwMa4Ra2TYcXuO5nEc6xV2KDMJo4JcOff?=
 =?us-ascii?Q?ssg77QH5+B77/psxHab6u2/kZCdGT4FouqF9FmzYvxeIICfizkNDcfRnChq9?=
 =?us-ascii?Q?GcAOfv2zU2v5LPmUwfNpOVYtiqvLzIhonwoWG5IgOaxN0voqLKtvsvaIXuZd?=
 =?us-ascii?Q?u4Pjud9+SVKn5tdoSy1zXWH/LVbJs24UtFWzPyu3DLTQ7Mie31uAAGZL9Iwe?=
 =?us-ascii?Q?PWPG6OH+WAVjbBZ2M3SlpmnfZQ2Q4MtWJiygAmUd7zrmsBc/l7v5KglL5yhp?=
 =?us-ascii?Q?0OpgVOeSiNIUsvc4r70fqJxd8p+tBN6oPdzGeSV+Xljf9TVv3GW+B4oa+xCW?=
 =?us-ascii?Q?7OuAEgjPKTF8Tmfsst+ZvoueZJ9YRdePo3o682trQyXWXWnglBzOl4JBo9Zz?=
 =?us-ascii?Q?pWfVH5H7aOZFRUfHNMr4qmSHf2OiOBQtVxNWb77iXHyY+gJdlxDL/STIx9ks?=
 =?us-ascii?Q?9pbnbm2jeGexZophbii2cYHpMmAsexxY72rq+2Nii5EnHMxG8pLx1FP9WrXg?=
 =?us-ascii?Q?t8TVF5RJB4rsXPcggaT7d/d9EZO/rTY46Nhln0Ykx8pmfsRRX5+cA7ufjar6?=
 =?us-ascii?Q?z88oTV6TCc7kBprbCa2HLe8/fULN8yiiK3rN1P8z2HIQ71aYISM1Wn+D+lRS?=
 =?us-ascii?Q?u3yVV0YbK9o406wcWTjABcha4eChUrLWAUJfQwZqs5RTcNljJOYlzhwgpING?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719eca34-54a8-4e8c-7a9a-08da9ddfbe6a
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2022 03:49:12.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1N2+8rzwiwPaLsooRbz6yVOVMhs4AW4Ou9Qfrw9QIQfAwq+yx4Zi5IKBR91JQvfDcgDw/ezpGH2qtYhbXcWImH9Yce7tiHB/fO4BTPcBb6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The background is that we use dpu in cloud computing,the arch is x86,80
cores.We will have a lots of virtio devices,like 512 or more.
When we probe about 200 virtio_blk devices,it will fail and
the stack is print as follows:

[25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy driver
[25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)
[25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
[25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.21 08/25/2021
[25338.523881] Workqueue: events work_for_cpu_fn
[25338.528235] Call Trace:
[25338.530687]  dump_stack+0x5c/0x80
[25338.534000]  __setup_irq.cold.53+0x7c/0xd3
[25338.538098]  request_threaded_irq+0xf5/0x160
[25338.542371]  vp_find_vqs+0xc7/0x190
[25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
[25338.550223]  ? ncpus_cmp_func+0x10/0x10
[25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
[25338.558846]  virtio_dev_probe+0x158/0x1f0
[25338.562861]  really_probe+0x255/0x4a0
[25338.566524]  ? __driver_attach_async_helper+0x90/0x90
[25338.571567]  driver_probe_device+0x49/0xc0
[25338.575660]  bus_for_each_drv+0x79/0xc0
[25338.579499]  __device_attach+0xdc/0x160
[25338.583337]  bus_probe_device+0x9d/0xb0
[25338.587167]  device_add+0x418/0x780
[25338.590654]  register_virtio_device+0x9e/0xe0
[25338.595011]  virtio_pci_probe+0xb3/0x140
[25338.598941]  local_pci_probe+0x41/0x90
[25338.602689]  work_for_cpu_fn+0x16/0x20
[25338.606443]  process_one_work+0x1a7/0x360
[25338.610456]  ? create_worker+0x1a0/0x1a0
[25338.614381]  worker_thread+0x1cf/0x390
[25338.618132]  ? create_worker+0x1a0/0x1a0
[25338.622051]  kthread+0x116/0x130
[25338.625283]  ? kthread_flush_work_fn+0x10/0x10
[25338.629731]  ret_from_fork+0x1f/0x40
[25338.633395] virtio_blk: probe of virtio418 failed with error -16

After I did some work of this stack,took stap and crash to get more
information,I found that the auto irq_affinity affect this.
When "vp_find_vqs" call "vp_find_vqs_msix" failed,it will be go back
to call vp_find_vqs_msix again with ctx be false, and when it failed again,
we will call vp_find_vqs_intx,if the vp_dev->pci_dev->irq is zero,
we will get a backtrace like above.

The log :
"genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
was print because of the irq 0 is used by timer exclusive,and when
vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
call vp_find_vqs_intx for the last try.
Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
flag IRQF_SHARED.

without config CONFIG_GENERIC_IRQ_DEBUGFS,
I found that we called vp_find_vqs_msix failed twice because of
the irq resource was exhausted.

crash> irq_domain.name,parent 0xffff9bff87d4dec0
  name = 0xffff9bff87c1fd60 "INTEL-IR-MSI-1-2"
  parent = 0xffff9bff87400000
crash> irq_domain.name,parent 0xffff9bff87400000
  name = 0xffff9bff87c24300 "INTEL-IR-1"
  parent = 0xffff9bff87c6c900
crash> irq_domain.name,parent 0xffff9bff87c6c900
  name = 0xffff9bff87c3ecd0 "VECTOR"
  parent = 0x0----------------------the highest level

and stap irq_matrix_alloc_managed get return value -ENOSPC.

When no virtio_blk device probe,the vctor_matrix is:
crash>  p *vector_matrix
$1 = {
  matrix_bits = 256,
  alloc_start = 32,
  alloc_end = 236,
  alloc_size = 204,
  global_available = 15593,
  global_reserved = 149,
  systembits_inalloc = 3,
  total_allocated = 409,
  online_maps = 80,
  maps = 0x2ff20,
  scratch_map = {1161063342014463, 0, 1, 18446726481523507200,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  system_map = {1125904739729407, 0, 1, 18446726481523507200,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

When the dump stack occur,the vector_matrix of system is exhausted.
crash> p *vector_matrix
$82 = {
  matrix_bits = 256,
  alloc_start = 32,
  alloc_end = 236,
  alloc_size = 204,
  global_available = 0,//caq:irq left
  global_reserved = 151,
  systembits_inalloc = 3,
  total_allocated = 1922,//caq:irq that allocated
  online_maps = 80,
  maps = 0x2ff20,
  scratch_map = {18446744069952503807, 18446744073709551615,
 18446744073709551615, 18446735277616529407, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  system_map = {1125904739729407, 0, 1, 18446726481523507200,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}

And we tested the virtio_blk device which request irq success,
we found that in a system with 80 cores and two numa ,one
virtio_blk device with just two data queues consume 81 irqs capacity,
Although it just only three irqs in /proc/interrupt,80 irqs capacity 
is effected by function "irq_build_affinity_masks" with 2*40.

before one virtio_blk device hotplug out:
crash> p *vector_matrix
$2 = {
  matrix_bits = 256,
  alloc_start = 32,
  alloc_end = 236,
  alloc_size = 204,
  global_available = 15215,
  global_reserved = 150,
  systembits_inalloc = 3,
  total_allocated = 553,
  online_maps = 80,
  maps = 0x2ff20,
  scratch_map = {1179746449752063, 0, 1, 18446726481523507200, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
 0, 0, 0, 0, 0},
  system_map = {1125904739729407, 0, 1, 18446726481523507200, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0}
}

after one virtio_blk device hotplug out:
crash> p *vector_matrix
$3 = {
  matrix_bits = 256,
  alloc_start = 32,
  alloc_end = 236,
  alloc_size = 204,
  global_available = 15296,---it increase 81,include 1 config irq.
  global_reserved = 150,
  systembits_inalloc = 3,
  total_allocated = 550,------it just decrease 3.
  online_maps = 80,
  maps = 0x2ff20,
  scratch_map = {481036337152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0},
  system_map = {1125904739729407, 0, 1, 18446726481523507200, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0}
}

We test the new kernel also,it occur the same result.
[Fri Sep 23 04:51:42 2022] genirq: Flags mismatch irq 0. 00000080 (virtio608) vs. 00015a00 (timer)
[Fri Sep 23 04:51:42 2022] CPU: 0 PID: 5749 Comm: kworker/0:0 Kdump: loaded Tainted: G        W  OE      6.0.0-rc6+ #5
[Fri Sep 23 04:51:42 2022] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.19 06/16/2021
[Fri Sep 23 04:51:42 2022] Workqueue: events work_for_cpu_fn
[Fri Sep 23 04:51:42 2022] Call Trace:
[Fri Sep 23 04:51:42 2022]  <TASK>
[Fri Sep 23 04:51:42 2022]  dump_stack_lvl+0x33/0x46
[Fri Sep 23 04:51:42 2022]  __setup_irq+0x705/0x770
[Fri Sep 23 04:51:42 2022]  request_threaded_irq+0x109/0x170
[Fri Sep 23 04:51:42 2022]  vp_find_vqs+0xc4/0x190
[Fri Sep 23 04:51:42 2022]  init_vqs+0x348/0x580 [virtio_net]
[Fri Sep 23 04:51:42 2022]  virtnet_probe+0x54d/0xa80 [virtio_net]
[Fri Sep 23 04:51:42 2022]  virtio_dev_probe+0x19c/0x240
[Fri Sep 23 04:51:42 2022]  really_probe+0x106/0x3e0
[Fri Sep 23 04:51:42 2022]  ? pm_runtime_barrier+0x4f/0xa0
[Fri Sep 23 04:51:42 2022]  __driver_probe_device+0x79/0x170
[Fri Sep 23 04:51:42 2022]  driver_probe_device+0x1f/0xa0
[Fri Sep 23 04:51:42 2022]  __device_attach_driver+0x85/0x110
[Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
[Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
[Fri Sep 23 04:51:42 2022]  bus_for_each_drv+0x67/0xb0
[Fri Sep 23 04:51:42 2022]  __device_attach+0xe9/0x1b0
[Fri Sep 23 04:51:42 2022]  bus_probe_device+0x87/0xa0
[Fri Sep 23 04:51:42 2022]  device_add+0x59f/0x950
[Fri Sep 23 04:51:42 2022]  ? dev_set_name+0x4e/0x70
[Fri Sep 23 04:51:42 2022]  register_virtio_device+0xac/0xf0
[Fri Sep 23 04:51:42 2022]  virtio_pci_probe+0x101/0x170
[Fri Sep 23 04:51:42 2022]  local_pci_probe+0x42/0xa0
[Fri Sep 23 04:51:42 2022]  work_for_cpu_fn+0x13/0x20
[Fri Sep 23 04:51:42 2022]  process_one_work+0x1c2/0x3d0
[Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
[Fri Sep 23 04:51:42 2022]  worker_thread+0x1b9/0x360
[Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
[Fri Sep 23 04:51:42 2022]  kthread+0xe6/0x110
[Fri Sep 23 04:51:42 2022]  ? kthread_complete_and_exit+0x20/0x20
[Fri Sep 23 04:51:42 2022]  ret_from_fork+0x1f/0x30
[Fri Sep 23 04:51:42 2022]  </TASK>
[Fri Sep 23 04:51:43 2022] virtio_net: probe of virtio608 failed with error -16

Fixes: ad71473d9c43 ("virtio_blk: use virtio IRQ affinity")
Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Tested-by: Liming Wu <liming.wu@jaguarmicro.com>
---
 drivers/block/virtio_blk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a8bcf3f664af..075de30a9bb4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -513,7 +513,6 @@ static int init_vq(struct virtio_blk *vblk)
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	struct virtio_device *vdev = vblk->vdev;
-	struct irq_affinity desc = { 0, };
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
@@ -548,7 +547,7 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
+	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, NULL);
 	if (err)
 		goto out;
 
-- 
2.17.1

