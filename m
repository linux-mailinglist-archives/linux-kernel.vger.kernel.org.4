Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4557049E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjEPJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjEPJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:58:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FCA11C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG49ZxbP/4zypKZHvp+uzhrhfC3+4rWGBz4K0/rWZzDO/rj02irYYGnVAvlplEBDTQNyKmbi5dDh6Z6szFalFrF2ZE9QoLjArpoQa4DI/iKn54K3qjsLGzDRAEogs0DFEitwR94UlJ+WOMFv9ugyZ7zcfP4LYXsirpnrNbNyNiUnebblV8n3zWIhnd9c5g10/KNr1WBQjlFhfQHnnS5i71rathIFV3GEXR/ZqmrepPKQ8GMLjt2EbRmQxifvzTaLvBrviT+UO++uzw61KbB9GH8Y+pajMLURzXilpNyng+bbilxxK9vVV7x3rDWV9tTixmEnbVuchfdP8/rKZOLZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfNVCX3Cv3QvANHqCcCDs8BRb/tgJVWUwxgec0vFesw=;
 b=FWTzyL3G4fAW3/UweEgbxE5dfSGuafhaxHpAIh9AfifIeH/oWLhbk9DzQG+t08gOtKBC8vskvImtFpgqRr+S3v53FYKMB1v4a2gPNQWEUWMGOPiKxEvo67wYvnuh3Jt2LGNGqil0L+QO/S3hOV4zzTCSjxzXs3uyX72F3SdgK9ZdW87UOBuRHjIi73QNaTsvRoL4NYlcOSmkhjBUmhoPhP+BHCA8S2RCdmczzAQwBCP+ObHuIpTonCVwJZcoDMPa9LPz5MSE75nKK6/g5V7oAalKLoIc/UJ+PQenz9bIZbiU/hy5cnr4ReEMwDmqTctqHrodubck586qSK9YqzaNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfNVCX3Cv3QvANHqCcCDs8BRb/tgJVWUwxgec0vFesw=;
 b=HQ8UWwoPaJsYkWQOAHTwvu2G+B95QFL0hp9GG6CzH7QW5ykI76i0bqSx0DTaSXHvOTpmklfE6JzMntAkXSZEPA+gpOFouQpsptIFElwkMXMnXrybVccA3ZMZo6+AYPObnxwTjabtUNNVVdaOMd/nQ1wu81vCGnxwvbhH20wmUBpPOYk1Ev2Ron36PzptHn2JXs+TyMFY2WhBtE6JYHB7PAg3L94Y5S7I2Mog6WbsJFnaw3R9rmN8DKHPIChgQBTdS2s0+3xCXJnsI8XbDgPYYo+Y7kgfjGDXUFk86QCCi5DRpukAc8ef9BPRngnlQJ5RQaAze/DdZ2Iy3LG+0zz3lw==
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 09:58:27 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::ab) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34 via Frontend
 Transport; Tue, 16 May 2023 09:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 09:58:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 16 May 2023
 02:58:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 16 May
 2023 02:58:14 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Tue, 16 May 2023 02:58:11 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eli Cohen <elic@nvidia.com>
CC:     <gal@nvidia.com>, <tariqt@nvidia.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] vdpa/mlx5: Fix hang when cvq commands are triggered during device unregister
Date:   Tue, 16 May 2023 12:58:01 +0300
Message-ID: <20230516095800.3549932-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb9d91e-9af9-425d-2668-08db55f41846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59c78zXrMwzc3V2/LMvS5js7i/gxnCV6vkmB1ZWU4jbD7fuqzofIfk7zs1sobNodiBdPIupZV5VDnc1h5GBopTiAOmNW3vXazygoVQnunc+GATcIcTIPAyz5QDNoP8avT6Z1rw5YUlCYu3tAycJwqmtg5AdE1jIjXh4YfUcoozSbLmbGL6U7FNFdXfBx8Y+e2A4mnqP8ilLM/mDFSk24b4Jn7qtqbbeTYNwDaz2vOobIT87YD4bGpgMeIpIt/X09koXXI0n52dWV04ApmzwnqnV5MfLXvxXnuzdBZy+V/wlGYJzBnZ2b+iyyuklkth0tdZFOVe6tif3HqOyppRIX5Sc74rjeKCvF52My2P9/IAjfr65BC9Y0azTMkYVG+mfqmdCdOfISCgtye8QTtCrJrZNwSgjQNRCwuTlVbZZYMIYSemWUa8yrdUbJSDip8ncSSO/m+YGviD7kUEWotg2PdQsERPPaoUVqfAneuuwaEXk6o0q2Fl0/cqxjTT5F8bXFOVM20zovYkkxcWy1HXmFZFaI24HPYouFgDH2IwiccFxRjJC70WxeZOd8OFc94i7au85EcbGDZ7PZeLdMsGDmg4LtDduWx7CAHaIsgDjPo+2IFLK6RenOvqSy7DamDB6TNYfHce/o1eOxxOwLhKs641tG5iKr85YzbSWIV5/xh0h3hQaZDMeKBzJ9r3nJHHqVEH8fAdfGQ/h074LG9W+bfIVirmJrjWaey6R31kw9IRYDKkn1Yg5+XQVKKGG7R2B3
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(110136005)(54906003)(6636002)(4326008)(478600001)(70586007)(316002)(6666004)(8676002)(8936002)(40480700001)(41300700001)(2906002)(5660300002)(1076003)(82740400003)(26005)(356005)(7636003)(82310400005)(86362001)(336012)(2616005)(426003)(83380400001)(40460700003)(186003)(36860700001)(47076005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:58:26.9595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb9d91e-9af9-425d-2668-08db55f41846
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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

Currently the vdpa device is unregistered after the workqueue that
processes vq commands is disabled. However, the device unregister
process can still send commands to the cvq (a vlan delete for example)
which leads to a hang because the handing workqueue has been disabled
and the command never finishes:

 [ 2263.095764] rcu: INFO: rcu_sched self-detected stall on CPU
 [ 2263.096307] rcu:        9-....: (5250 ticks this GP) idle=dac4/1/0x4000000000000000 softirq=111009/111009 fqs=2544
 [ 2263.097154] rcu:        (t=5251 jiffies g=393549 q=347 ncpus=10)
 [ 2263.097648] CPU: 9 PID: 94300 Comm: kworker/u20:2 Not tainted 6.3.0-rc6_for_upstream_min_debug_2023_04_14_00_02 #1
 [ 2263.098535] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [ 2263.099481] Workqueue: mlx5_events mlx5_vhca_state_work_handler [mlx5_core]
 [ 2263.100143] RIP: 0010:virtnet_send_command+0x109/0x170
 [ 2263.100621] Code: 1d df f5 ff 85 c0 78 5c 48 8b 7b 08 e8 d0 c5 f5 ff 84 c0 75 11 eb 22 48 8b 7b 08 e8 01 b7 f5 ff 84 c0 75 15 f3 90 48 8b 7b 08 <48> 8d 74 24 04 e8 8d c5 f5 ff 48 85 c0 74 de 48 8b 83 f8 00 00 00
 [ 2263.102148] RSP: 0018:ffff888139cf36e8 EFLAGS: 00000246
 [ 2263.102624] RAX: 0000000000000000 RBX: ffff888166bea940 RCX: 0000000000000001
 [ 2263.103244] RDX: 0000000000000000 RSI: ffff888139cf36ec RDI: ffff888146763800
 [ 2263.103864] RBP: ffff888139cf3710 R08: ffff88810d201000 R09: 0000000000000000
 [ 2263.104473] R10: 0000000000000002 R11: 0000000000000003 R12: 0000000000000002
 [ 2263.105082] R13: 0000000000000002 R14: ffff888114528400 R15: ffff888166bea000
 [ 2263.105689] FS:  0000000000000000(0000) GS:ffff88852cc80000(0000) knlGS:0000000000000000
 [ 2263.106404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 2263.106925] CR2: 00007f31f394b000 CR3: 000000010615b006 CR4: 0000000000370ea0
 [ 2263.107542] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [ 2263.108163] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [ 2263.108769] Call Trace:
 [ 2263.109059]  <TASK>
 [ 2263.109320]  ? check_preempt_wakeup+0x11f/0x230
 [ 2263.109750]  virtnet_vlan_rx_kill_vid+0x5a/0xa0
 [ 2263.110180]  vlan_vid_del+0x9c/0x170
 [ 2263.110546]  vlan_device_event+0x351/0x760 [8021q]
 [ 2263.111004]  raw_notifier_call_chain+0x41/0x60
 [ 2263.111426]  dev_close_many+0xcb/0x120
 [ 2263.111808]  unregister_netdevice_many_notify+0x130/0x770
 [ 2263.112297]  ? wq_worker_running+0xa/0x30
 [ 2263.112688]  unregister_netdevice_queue+0x89/0xc0
 [ 2263.113128]  unregister_netdev+0x18/0x20
 [ 2263.113512]  virtnet_remove+0x4f/0x230
 [ 2263.113885]  virtio_dev_remove+0x31/0x70
 [ 2263.114273]  device_release_driver_internal+0x18f/0x1f0
 [ 2263.114746]  bus_remove_device+0xc6/0x130
 [ 2263.115146]  device_del+0x173/0x3c0
 [ 2263.115502]  ? kernfs_find_ns+0x35/0xd0
 [ 2263.115895]  device_unregister+0x1a/0x60
 [ 2263.116279]  unregister_virtio_device+0x11/0x20
 [ 2263.116706]  device_release_driver_internal+0x18f/0x1f0
 [ 2263.117182]  bus_remove_device+0xc6/0x130
 [ 2263.117576]  device_del+0x173/0x3c0
 [ 2263.117929]  ? vdpa_dev_remove+0x20/0x20 [vdpa]
 [ 2263.118364]  device_unregister+0x1a/0x60
 [ 2263.118752]  mlx5_vdpa_dev_del+0x4c/0x80 [mlx5_vdpa]
 [ 2263.119232]  vdpa_match_remove+0x21/0x30 [vdpa]
 [ 2263.119663]  bus_for_each_dev+0x71/0xc0
 [ 2263.120054]  vdpa_mgmtdev_unregister+0x57/0x70 [vdpa]
 [ 2263.120520]  mlx5v_remove+0x12/0x20 [mlx5_vdpa]
 [ 2263.120953]  auxiliary_bus_remove+0x18/0x30
 [ 2263.121356]  device_release_driver_internal+0x18f/0x1f0
 [ 2263.121830]  bus_remove_device+0xc6/0x130
 [ 2263.122223]  device_del+0x173/0x3c0
 [ 2263.122581]  ? devl_param_driverinit_value_get+0x29/0x90
 [ 2263.123070]  mlx5_rescan_drivers_locked+0xc4/0x2d0 [mlx5_core]
 [ 2263.123633]  mlx5_unregister_device+0x54/0x80 [mlx5_core]
 [ 2263.124169]  mlx5_uninit_one+0x54/0x150 [mlx5_core]
 [ 2263.124656]  mlx5_sf_dev_remove+0x45/0x90 [mlx5_core]
 [ 2263.125153]  auxiliary_bus_remove+0x18/0x30
 [ 2263.125560]  device_release_driver_internal+0x18f/0x1f0
 [ 2263.126052]  bus_remove_device+0xc6/0x130
 [ 2263.126451]  device_del+0x173/0x3c0
 [ 2263.126815]  mlx5_sf_dev_remove+0x39/0xf0 [mlx5_core]
 [ 2263.127318]  mlx5_sf_dev_state_change_handler+0x178/0x270 [mlx5_core]
 [ 2263.127920]  blocking_notifier_call_chain+0x5a/0x80
 [ 2263.128379]  mlx5_vhca_state_work_handler+0x151/0x200 [mlx5_core]
 [ 2263.128951]  process_one_work+0x1bb/0x3c0
 [ 2263.129355]  ? process_one_work+0x3c0/0x3c0
 [ 2263.129766]  worker_thread+0x4d/0x3c0
 [ 2263.130140]  ? process_one_work+0x3c0/0x3c0
 [ 2263.130548]  kthread+0xb9/0xe0
 [ 2263.130895]  ? kthread_complete_and_exit+0x20/0x20
 [ 2263.131349]  ret_from_fork+0x1f/0x30
 [ 2263.131717]  </TASK>

The fix is to disable and destroy the workqueue after the device
unregister. It is expected that vhost will not trigger kicks after
the unregister. But even if it would, the wq is disabled already by
setting the pointer to NULL (done so in the referenced commit).

Fixes: ad6dc1daaf29 ("vdpa/mlx5: Avoid processing works if workqueue was destroyed")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e29e32b306ad..279ac6a558d2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3349,10 +3349,10 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	mlx5_vdpa_remove_debugfs(ndev->debugfs);
 	ndev->debugfs = NULL;
 	unregister_link_notifier(ndev);
+	_vdpa_unregister_device(dev);
 	wq = mvdev->wq;
 	mvdev->wq = NULL;
 	destroy_workqueue(wq);
-	_vdpa_unregister_device(dev);
 	mgtdev->ndev = NULL;
 }
 
-- 
2.40.1

