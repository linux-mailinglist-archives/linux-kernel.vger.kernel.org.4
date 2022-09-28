Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97275ED448
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiI1Fgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiI1Fga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:36:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE193118DD6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld2YLr11YIopsleAC3Z4npn/TGgTTvDFUqUCwPy/cIrjQhEBwQnJIlk/Qa4lcDs2f6h73tUY2S1M6lJ+Zyk1ubUPQdrnV9sHdRHGL443QJJO6mcnekIKtYVBNBXUS0JJjl9sykkcoZWLXJYy97Rl3/MQukUW0KCwKN1/3L0fI5D+IGTwFabbna1Hys8RSI5LLrknydgZMSkLfpcQEwPCyJJacwe12AHnkE98RvEPH8LaklBp6U5TK82mUFqHHb4E9bpeTU9WJ9+a9mpSwqnk5tM6VWdebEUB1wH6Z/huG5wjVMnoM8m5Ue2yEdeCSnj3R1/2A2WgiB3tK9i/QKLtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBDRrRic8NAI0snkOSzb6cLkNRamUCglgUPqsIpnc00=;
 b=kKQZepAgNbC6yWfEQo/G1Bf9PNo73m88Q64zziSyaNdT5V+LP8oX6kIOxR0kS14rQYGUKHzNyQR81LG/keAlKmVx3/pB67rbiBHiCQDnx/TuonDOSUE5iIY9kPjARpS38+oaAkdLEjbcDSG6T1WbW6dvkzisko4nT/px3YoExI0BokcCBT5q3Nsn6IdBmvLbl3pifX3jkDQa3jBxd7+fjNAG/GA4kWQUgl+ngt9rRQCJhYCTu1MpwpxXvn3AcBhrtQprfRwLXgK7lvkGWennW7dr6MC3z5YMnbgBpwdpl+uCTdN5LVksw0MD0W3wCqNlZK4RphPWpU9h0ewB8faGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBDRrRic8NAI0snkOSzb6cLkNRamUCglgUPqsIpnc00=;
 b=IWvMsKb5mCN41QOjKmkQtCDk8jTN6Q+nB5hQMx1Xf/eiYUC1Mz4T2LX6YCzZOIEkI/bkSz2Orb/U/ePyEP+/gyUsZdjhFf5ydEhwrJFDfGosFszE05MUiq1mAPCVsf5MgGv9VzTDM8ySAUk5G3npSx3iHDs0SmUpxCeFgqS63uKy8Jglkq3HcaUzI5+91rtSTQGEmsfxjG6MAnDcWEUWt3gqdEsWKG3HnxDRkwwpvVRwqJXOjN19fY9S5/+E+Q/a+qkvGvfsn1kpDw+Mk73iF6gC/FbG4V0BPlfHKBxbw55OQN/BHfmhOqZhYpMV5nOmjOJYAh0/tVtdxcd/7Ti/ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SI2PR06MB5243.apcprd06.prod.outlook.com (2603:1096:4:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 05:36:23 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 05:36:23 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH v2] virtio_pci: avoid to request intx irq if pin is zero
Date:   Wed, 28 Sep 2022 13:35:22 +0800
Message-Id: <20220928053522.440-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|SI2PR06MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: e30123c4-620b-4e45-aabe-08daa11360ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZmlIZRLRB0D4hPHI9YOHSnvBtbMVgXS7P98hZepzrHv8Qox7nEzsbA9SJK+kZNdFLlOq33xVtdfmux8expsIE75mxnwmJ9UREtYrIkqZhTUas2K/EgvIisgQ1XMIQyAo5WrSe1LS3PzhMBfebuuq7MXVpasYM3RqW0rpUREwUrB22YVEOgWK2G8eM6rxvgSMfH3H49UPgwlRFPrVfvQxBZlHC10zd6e5UifSu1REVBNfK2sh5mYjBUtU5dGfn+EDgL5A7Mg1PlZC3cGfJNbapaWsRjnnHhffDgVpfsXBKgkqMYRbmxkfLJko84yBnKI4fDHUwgrhSH9iwWZ7ggQpQ2Brr6Sj2GHcL57uEUVJ723u8o6vKWREjRdJCtX2UzcsGRYE2pi8E5E7JauPv5nc1vxbuyWoMQ+VXjKoh9/sbtVQSuXYINgNBU0IbqBhYiRHXzcLKwrI0hJh2GGUR3cBASOPEyPDsbCzGfPtN+CWthaA8Z9enAEZiEqZ5QowXJAzf7UzNiUwsknMfHqMZzVHI2ASaK91Bx1ubqmIO1dHs3vsn0tXdz6OCU7ihEe9CHvGm6F1U004SM94vOs6D5mnP4o5atghQUEqYs4A3XT2V/+Tj+Pj98YYIDDJU/xY3J2cbbHcuS+5cgZAJmNHBkmhRY0P1UWBakT2mCOJid29MRxxF5qBNBDx9JhvBv+iVxSftTrkKy2h5z6qw70ysNfeFylk7NmQC9gUqk8/g+1NfAaaaDAKhoE1xirHTEJjxOxVKbhIMK63sQdkK6Bld3sNwTpaZFb4wKFhAtr7CRnGSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(396003)(39840400004)(451199015)(66556008)(2906002)(8936002)(66946007)(5660300002)(4326008)(8676002)(66476007)(38350700002)(6486002)(107886003)(6506007)(478600001)(38100700002)(6512007)(26005)(52116002)(2616005)(186003)(1076003)(41300700001)(316002)(44832011)(86362001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUJEZ7I4IhwZ4DZsF2z09VZ1FGgesOAuznIbYC85y1AeafW390WcFZbv+q+T?=
 =?us-ascii?Q?cLZWn6sk7neNh9fIYyjMHStWFw6F3t4a3tAHlPIzHsW4m0Gffk2zqBQS2Nt1?=
 =?us-ascii?Q?vh2UBByCnebACdDLm5RaKHXli85809G2vBDiXdwDRIroYmRJoBPwTStUU/CE?=
 =?us-ascii?Q?dtqXVqeY6NW9IXShBsKBBZegfgFXUV4N4ux7/EFmKAFMFk1yYp5GAT3gZTGp?=
 =?us-ascii?Q?T3z2qFopltRpokJDpdo7UDXx49Al6RdhvgRpjzGr7u1Mep2fM5Vd51Xzsdsb?=
 =?us-ascii?Q?lXzczAOaCknBjeNbh0M/VSSY3q0Y8eNT27hfhFLwQnbDL3qwCXD4QfSXNxEo?=
 =?us-ascii?Q?uxNXMPGEi3UGOgc11CbKQuZk3tjVRxx+pXZoJgsmLJudCMubHr22tstY6DuN?=
 =?us-ascii?Q?9M09GIJo8MscLqmsrJFgm5HacPBl+p2mqVyFVHS8qtKSWusleE1ps8hNVzZs?=
 =?us-ascii?Q?ZV+7OyHqKcG+OyBrnL9g3c/TiAcbTZj3dLYJRa7oGtFdNJcgk70quCd4znpK?=
 =?us-ascii?Q?Q3b3WOlmBkmQw9TewGP4pOkII2tbqK2WMcvGcicEy4NaQ5Qy9XqPjNvq0/52?=
 =?us-ascii?Q?zIHk9jO3VD341FiPtjB4DDDUOz94pj0IlXfE0AqjPO8LFDF5UNgXXHiuURr/?=
 =?us-ascii?Q?YF4ubaFCgxs3KbiEQOtt6TO+FgRbUJf79onKZzsUCUWhR8JCtziEbXZUzEoy?=
 =?us-ascii?Q?8jmICKLU7Jet5E5xZ5eaXywq6fJpc7WpiwZCsbrlgY0OOCOD6SssnNNJ7ujW?=
 =?us-ascii?Q?LE25pTnY8rRs3QRbtUfH5LzXv2NiuMH4gbJ5mySY4/YvsDk1i1NMEr2nREkW?=
 =?us-ascii?Q?TgSZrgunsVouuPe3h+KvGeC5Hi6JI0QtN6zx+KOyjEHdschRRuimhHHeu3Xx?=
 =?us-ascii?Q?KnoG2CyKwd8v6V0giiXxNHzuvx1i5jv3wh5eYHyIU8PrmIJMHJ7McUygqJq9?=
 =?us-ascii?Q?fE+zcsevMEc+n/4YQ8SpYn5aK19ncEP1IUtPkhZf1I/rz3lzIL70ONkVuwqU?=
 =?us-ascii?Q?oNC5zM3Y33++o7gxxzafN3S4pSwAJa69t7SE4IzNPZSc8p5M1ClH1OEOi4Ji?=
 =?us-ascii?Q?REmy4qVpp//0iepDi9G3u0Z40dXv+WlWpIc5ne6Qt7kkCbPHyawhvJDJLK41?=
 =?us-ascii?Q?vbm88sCS1j1v4D2i2e5Qr89MAqjt2UiJwu2EI8g+GpMA8VV9P+R4U/gMzvcz?=
 =?us-ascii?Q?AMpRrOxQ3i3LHy4moW9nVOVVt8iDyY37PeSOZpiLHRxatVPnx9A6JJXa4RsP?=
 =?us-ascii?Q?BVuvFrXoGw1lQnRaA0+9XwKuIfOJC8zpBLp6zEcs2A87A5cNdy52cOFGuP8F?=
 =?us-ascii?Q?DIUMATI2aFslYMltmWyDhXTnJLWX3cRjvim/ASMHfCclddWlfY9Y5Hu5bj+K?=
 =?us-ascii?Q?gKEuxab5Ba63MtgkLeFnWeYiBhQrhjzbFVwmdynJNco862eMGG8h4z748ZlI?=
 =?us-ascii?Q?wZ9jj+fL24DXzW5T2bLGxv88Ro5jDCul2aLpGOgQpxl23OV20EhnBiIaEnNL?=
 =?us-ascii?Q?H7g6u4l9fDV9MtWywbXDDTDAlnpT6zkJZALOQgFDJdJeQr4lrTV5wc7Y/vKQ?=
 =?us-ascii?Q?7NxqjUFQRBQEXAdnZopalEyO5e9TcCy1Cw+HRhU5+Hhy3tG2kuiV0rulF8oO?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30123c4-620b-4e45-aabe-08daa11360ae
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 05:36:22.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbcCQT5uJQ+2y4rFiRow4UsVYf3ypOv24tYWfCF6fv8zyvZ4GY0RJ4/je3jGpZ5tVHYIuSy6lsRE7VRU0QH8JObAhSv++jE6l5pLGxpCioE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5243
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

according to PCI spec , Devices (or device functions)
that do not use an interrupt pin must put a 0 in this register.
So if vp_dev->pci_dev->pin is zero, maybe we should not request legacy
interrupt.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---
v2:
- Decide whether to request an intx interrupt by pin instead of irq
- suggested by mst

v1:https://lore.kernel.org/virtualization/20220928000228-mutt-send-email-mst@kernel.org/T/#u

 drivers/virtio/virtio_pci_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index ad258a9d3b9f..81225e503e69 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i, err, queue_idx = 0;
 
+	if (vp_dev->pci_dev->pin == 0)
+		return -EINVAL;
+
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
-- 
2.17.1

