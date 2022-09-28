Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5D5ED3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiI1D55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiI1D5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:57:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA24115A56
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT62my6hRgWoMm6U8H8mj7a9BI2+FTkA4KjoRTk7d7BVrHsZLK6yMPQrdacHbOay7PnmuqyzoWices9VB4NFp+Uv4o936vUe9qRCP7eO87SbH6Ize4dnQROtSdxHTEPJO45l2lswJ7/CKUhAkHCsLTiZ+gSQSNQb9Zuq3gzHSK+Uo/Ag5t+8UPT7gg5jB1e+N4cyOHKgWa/YwtUONzOnxqjox5tjfMsOhZJkB/uSEdeADO88WqiLElBncQ6vbQNMNQMK8C4MsuKdE/SgRFMwBE4OCc2b8ZTQRoroWYEm7hnB45lMKkjK5c/hMZr8ufToD90naDrNyfeuYATj66T2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBzeEsXyc0ePtquYrH8jdpIGKiueek75CcOtEBSOSOQ=;
 b=X4bQe9mIF2iCssiHSfpPk/QHqWXNmKf4H18Fj9GGluSQC4RnbPp58vFgblGXvl9HCOCpY83b8pmDZ1cVa+nq+MYuZLpeYKBhwDc/kdWFmVnn0eBsEe9DMrvwNVY0vAezck+0EjQLdRG6d46zthLsEqUXe87lximIudABl88S5OLMJYHZSHbPm7kUBQft7mvHk+FTkp9rVg6BNQR6b7SYVqKb/YtHmwD3ZyUt8siT0WASdcsrOy20D1yY2mh3mEtE2OHbo5RCQPxcUYHR+7DwMFUcHY/B58cDGav3CWmpEHYXyxGH5Gk8rwmL8EisPjAeWqt8DKACvogxFy79XxEIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBzeEsXyc0ePtquYrH8jdpIGKiueek75CcOtEBSOSOQ=;
 b=Sk1FLY4gfvjxzvxgD7Xqd8n+VhIqshIfYG768RN/jH65oYji40VkpbMLKx9ozvCkxrb+mgIJxaq9SArSqv8Ws4zPdDOMtpAzPw+zoOLNuuYpb+bHRtb6PE0wiby2QnTqZCVCv/HAMHh2iW0zvzzx+If8c02057+B3n4l2cKGzy5xC6Npkq9rLtrPNOB+s6HHaQeF9NovIOMEJj+1FZtzWP7MRj60SUis2azUItiJNjfx8FbKM3EAsvZgT2B/m7n8LWnP9h0OdSE9MELQKa0UffpY4Al8b1+VxsBxptjt2FCyl7e/f/GJxaz3F+FjkvoRFUPW4rD409uHbkzsU1jVcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TY0PR06MB5308.apcprd06.prod.outlook.com (2603:1096:400:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 03:57:50 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 03:57:50 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] virtio_pci: avoid to request intx irq if irq is zero
Date:   Wed, 28 Sep 2022 11:57:06 +0800
Message-Id: <20220928035706.419-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|TY0PR06MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: f365f9c2-0ed3-4caf-00bc-08daa1059c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1caXH8JdqDPQGLJE65ChwBI1u5IaOp3+ql74KxOvGyfoYV6QPOXVof1YpDF4jSzBqqz/A5iVw9GLIX6cnyiGT0o6o1diiGqIH/et5G9PmR0C6Xb0L9B8ziD4Yltd3qNZpTZcpNRiLPHgcV6a1uHl7upvS88Pf4ISkq4V7KbOqxZNR/PlieN/WT3H0PzDeT6FjmAeYI4l5csJm4je96f9Tg1tUYW+rTz2TILgxlrRY+rPUmWUpoXVrnXPHOkurYIyQADTmlH8pJ81WB+fkGLeQSisc/9RQ7016a3uGK4HAaD3KS8T46Ny6dFvRLix0jSCXR9ZzgW07eWNrUnscfni/M4vUljwG7kIIbHscgjsrzJQUO7/Q8tur2x8ESM/xCZVcv6meSTWB+UUqPO6yQ1n1h0J8UAhmvLyN+svRPSoTJsZoK4TyoUfeEE5md2SetWdtjtSvhlWL8flWcQCSWPba5TIE9fcteK5UvCTAvQ/f2vjwwlId9hsAz9FryiClp5BbMlEqggTYj3hHKTqYYEKn6yVWGii/jyX2ZXTROqqSRPuTzczPKEVe1GugC4TcJ23KRxV/Cy2iRDNeWfpM46fxdvUbMSOJ6G9cPBpr/YHxzLMsl+rViGl1+zv0+RXIlEMroaBfUFkEhB+AYjvOymo/eJSbuU2Lp3Cd+5LLn++3FDbiEiTiyuCm+IkKIM9BM7K5tibPaNRuMsUwHeDFJK8BRxKEaKme5m3bS8vLgTgj2wcczwpiVu1Td3Nr3tssrg5RenZZbjWLjZ+4DTIJOWww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(136003)(376002)(366004)(396003)(346002)(451199015)(2616005)(107886003)(6506007)(36756003)(41300700001)(186003)(2906002)(5660300002)(316002)(6486002)(8676002)(66946007)(6512007)(26005)(66476007)(66556008)(4326008)(6666004)(52116002)(478600001)(38100700002)(38350700002)(8936002)(83380400001)(86362001)(1076003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nUT0Lg5WxMQJ69mis/39942bNn1kuudLkLJB8LkNjXrkCocz14FIPbgP/XzL?=
 =?us-ascii?Q?eRMGYoo9uGUF+yYVxLxFCChH+iJtvKuSBNyyfwaNfcNK9yJeWokaud0+Jbnw?=
 =?us-ascii?Q?JXjs0w7ZKQ4mU0T2NyhGILjbfz2jFXrj1kCCJCZMARe5RFQqEH9XPUs+04Fk?=
 =?us-ascii?Q?BlEuxdWUt3eVWnrDg/8mcrk0Gb+n9S0ppKL4rYAHKgWcW+Os8s1oBFYwXtG+?=
 =?us-ascii?Q?xtzp5abtvYL7/+YNfg2l8mLYFYn6C7HIiEThOpZNIUFWJANRwUyHz4DPgmcl?=
 =?us-ascii?Q?QlJ9H/ZTEsj2QgZympC2YsStuqI5kZbH27hOdk7fpeMbSCj960qqF9alDTK5?=
 =?us-ascii?Q?WqSAowx2tprn4pQ08xyT3PaZt0Oc4s6u1+t2TwNJ7nDdegpfJ+jh5V5lj0my?=
 =?us-ascii?Q?vkuvDNGxkKXa1z9woyXLnra+RCct8hIWD6FMHBSlpUJOyyWVf+w4ix54JV/e?=
 =?us-ascii?Q?Q97OjRDlZ7t30lYyBYQbbXnp5eiCtE6lpsdwPyL7PP4TIMyFcGF+gJRqI+oN?=
 =?us-ascii?Q?SAByrji1ALlcNu0ZGUvYRD0/3U3DlMKQbpnULCWtwyzKNHYtLywFz7LUD9Dg?=
 =?us-ascii?Q?Cv8Lcg8On7bPQS42+Fb+502jNlU4NxrN7ajX+4g2xm46WA55RGoaaT325Hf4?=
 =?us-ascii?Q?AtBbNeiDfhZCMluHwJ+GwkIDukxJJZUU1fZMJQQZxE9s80dCIqR5WKjwCza4?=
 =?us-ascii?Q?+J7+cr1pun6wFBhD2wpjnq+G0Fyvpes+Ou93q7Jc7WtUBgWhpTGLcPLIlRHE?=
 =?us-ascii?Q?7PE0T1OjlYSu/XugbkGelCh8PHpnAY801Be5bw7csrxZ3Fy4Xih5QIdjW5hG?=
 =?us-ascii?Q?PDyJJNwvdvWTwMLiAhOmz9Bx84nYK6XDHKk6RhZSvrBr9kRkwLuwYMFaL9nh?=
 =?us-ascii?Q?e9RCdzCmvYElBlo3YTy0BE60Jq8eXCOZ56zu21hO0SnCc6eGb7PbSB8dbvLB?=
 =?us-ascii?Q?aCPwI05ZncsiK0se1P5CLpbG5SyjpibDekxqUfrKRw9fKQ+9RYC36yGELwbx?=
 =?us-ascii?Q?0LnwEcSdsJ5UpMsAd/L/FJPn4CP42CXlEUWXGY82O+F6rgjc686+6TdiBqdR?=
 =?us-ascii?Q?I5fdzRv/Tw06QkfJFnYtKwDP29pdBdZ0otWSCOFDwfi993v5tAVkpYyb7a6d?=
 =?us-ascii?Q?JVgU+WX41iJAZMHcWm/sdCjjfU4oz5Zz4++NqcvmPU52Fi1brxoORlKqGcqA?=
 =?us-ascii?Q?G6GuBQKCu5RTyXwDHnMKd8H9nxILzZr813BIcBE/4QxuTy5aHyIql2cLM32E?=
 =?us-ascii?Q?jTMaoocT1dxPU4P4w9hpObgqHuomzKP4qN961Nu65U0rFHkt1Hk0y57yzb6e?=
 =?us-ascii?Q?pI1FtTETXRxWS0O7bdRZL1fUpRjRgQCLBgfnPVJRxprDhw4NwcQb1w5Rr3L+?=
 =?us-ascii?Q?19JvOuNIZXRlBe8pPPk51gN6ctnwXkZUF1c70KDj98PzntRTmcjGz+HENrDU?=
 =?us-ascii?Q?kh+RR1RxM7kjZyWmuRI/sg4vcWJCOr/BpUH4BpvzbhQ9g7EQu53FD7qunpEU?=
 =?us-ascii?Q?Fr1dSEQJ2muK6Gy4UZ2bzLMOA/AZsYZqhDpKWx5ncM894liVESHWhzitGKQQ?=
 =?us-ascii?Q?PXtCpWdRTtrwlHd+gYh7WJWxcAzeXu9avpiq73p1PDPLRHeDUXy7/G3lP3HO?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f365f9c2-0ed3-4caf-00bc-08daa1059c7c
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 03:57:50.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/+YY5l7DkTduTLP0Lb2BKypFKZ/m/jC2k6O4O0XzRNxuatv6Wr9Bt9cY+uUJkOq3IHZbJSYy9lqUqzFBHkuFVEAACLKqtnizHwtgqojfmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

The log :
"genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
was print because of the irq 0 is used by timer exclusive,and when
vp_find_vqs call vp_find_vqs_msix and return false twice for
whatever reason,then it will call vp_find_vqs_intx for the last try.
Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
flag IRQF_SHARED,we will get a backtrace like above.

When the pci device is vf,the intx
is not allowed and it will be 0.Even if the pci device is a pf,
we should remind that
irq 0 is almost be reserved or used for some device fixed
like timer in x86 without IRQF_SHARED,so we can avoid call it.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index ad258a9d3b9f..3208a2b149b9 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i, err, queue_idx = 0;
 
+	if (vp_dev->pci_dev->irq == 0)
+		return -EINVAL;
+
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
-- 
2.17.1

