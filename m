Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C56DCF75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDKBjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjDKBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:39:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D5E74
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ1n0JX918skvSMgugBCc/nQAAhUFeaWdTgmWwp8KbjuDvpEM7pRN6hQxi53mhh6BccnYwqdtmCkWCWhTPidhJgurkSxMLXfkmPg0jZF0pjs6r5BGwN08Fmhird9zly8QqxtViYAJAJd2WyG0dgHbFIC09SD/zkb8QiLcw9OuffbvytTAvDFqy57htPOf9W+StpwXX3C8/2x2vtIMG4msjKLPqZdFcIJVuvZAyg2W6yoetMnnei7zsX/XDlVfrfeTRjFJzcldj8nWVINH6DtoRR+znJ1kEqsPk+nUn6oqlBeIxxzXuEykhcjdgWB4i8Aus54iCm5Pl3zonCSaXAXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U9REKgZemls8cqnPaK2AvjqC7Do2b/BeD24+09MIds=;
 b=kNAxuiBYDepuw1aimew1WywXIujzP3GCF5ZRtlaZxUAWz/gMYvk0VxELCW3r0kjZelJS0PM68CI7vhUrd+UGbbperO8mka+MbzR9AGKIEZTt0jgHBwfi4YT/rExNcIWxO+cIW1GTtXReZq2UAM3c6Hua385oOCMwu41uGmfnL6bzXefcJUZVkPSEwORHGIe+xeuv4ZX29a+q4WpdLfDXlxW1eJWPq1av4npRqzJnvUm+Ub0Y5NzQkd3bpCI+620/Xi9ack6hHoo7Y0iCsrMZ606sDBfh2gShxEvN83cdDI2CzhStRtHCCBJR7Le0KOVvkGiGrC2dc2CjEcDb6lzecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U9REKgZemls8cqnPaK2AvjqC7Do2b/BeD24+09MIds=;
 b=NfRk3S5yWnfYSxsy7ABDSdRPpTIcB61R7O9r56a41c8t14i01Tcak9W/Fa/8AnPdDPoWwjDyZGz+Rcy7XBojNV8OLG+kntrBvl8oakn509p8nsr90OHO46cTq/sa9Cam4DhBJEQI1yMkB0kjrjQOeNw8wU5Ap4+QunJh/JtUIwUmor/ck+RGcFDhyeupxppsAHhGm7oVb4glLPy71G0+xuQn9y7GOx9ZMvsK2V7nnB7B6trR/HcAWrDk6DND7O9cdkE6Mqe4c6GbCDS5nokwnaqsQJDYwdsktk/0LL8NJypURcDhUaQEkyUmo1PZ3OFgU1eRhm5CUblwSz+OnUYCfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SEZPR06MB5607.apcprd06.prod.outlook.com (2603:1096:101:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 01:38:57 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 01:38:56 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] virtio_pci: Wait for legacy device to be reset
Date:   Tue, 11 Apr 2023 09:38:32 +0800
Message-Id: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|SEZPR06MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c2d42f-4b64-4f78-233c-08db3a2d83b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcmFr2zbGQ70PiFGTYP9BcgXodz3SOLdnsw9bS+a5i8XmIlLXDEbdNHZKEuy7fwwkDq5twc3F4+5Dp7gXBoGLK+Z0qKW536FRA6u1QGEXdf9hfcn7n4fC0qjbZgwnr+zbWlLJ3uxPSVt6Ftoks1uJlZxKAiYRY4Mtwj5srVVHH4Sj9SACZllKN3RYZvYx7oosoRtQAJjEDRgkGwHrKBZ8VIvXy6P3KvLYHgw1tDvFsANa+eqV/PhD7F4p13S7Ci6hlsh7E0dtcnp15YWv50UfnVg3WJLijGCeLkjDRBie/EFxCNGwUrjC6prBh+mSPwPtG1mwRCCGAIjRX51bXvM847gdkW4X93j9GuDqFpyRfAYyOq1bzJ8VLBJPBlgcuS0e+69RQiJRbvG/aVmKtlZxI2JoFxAhqW+WqQCImTSB6nFcwhC6ktfajhdMlorlLypWvzUq0iav5Qx4OBdjRp9cnQdYp5JAkERHppIdZYPdH7pwgC16f1ttzdQKLDAkdLn6aCV3ic0WgZxzVXt1lbz/whR0qy3CF1aOkdwYn0EPVlA/STLjTH3G6bj4jVtnL8We3g1qiX6Yx3jA22O0Uo4CoVFPmMbo9gAtxdUyM0kFzGY7D09IaQRDigE/2L28FRE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39840400004)(346002)(451199021)(6666004)(478600001)(52116002)(83380400001)(36756003)(38100700002)(38350700002)(86362001)(2616005)(6486002)(2906002)(44832011)(6506007)(316002)(186003)(6512007)(1076003)(26005)(4326008)(8936002)(5660300002)(41300700001)(8676002)(66476007)(66556008)(66946007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qhKWz4OeM8+JoY1ipoJx7Kc+Ocyet7DAh4fOqYwm4K52DbQpfmrHYajMLRXB?=
 =?us-ascii?Q?ZgHMahuy0LWkAW04Eoq4YIG082flpQ/R0jQemPnFIhAP079Mxs7KUJneo5X4?=
 =?us-ascii?Q?naJ5+rjJI5FYNyc70apPs6fv0HytXjt0rMqNnBgcorfdd6JaMvVhNULLV6Ac?=
 =?us-ascii?Q?H9ilKtU7xVycjCtRWxWJh1eRs3sL6edvjYmxqEo8CcNqKEmJwuoFy6m1u7Zl?=
 =?us-ascii?Q?1ZExOCfY1e1y4qtt3QcNUsNTYbzkwQUJp+gldd2Rd9FDyLslbPsWCqx++CkI?=
 =?us-ascii?Q?Z6y3P0LoAYjioNEL0KEYyeKSyZltiJpj+8YD53TIv2IO1Bu6vb8y406WMiLa?=
 =?us-ascii?Q?e3qqcnYcXm+ygg+KxS63R5n+nMvtkIVCOup0KL6ROO9OrCPYscd2lwzal+wF?=
 =?us-ascii?Q?wj5c2aao+4NghlwSTu1UnjUyfAvXoT025r59xBJ9yvr23GsQ0QwtkBrqD1HA?=
 =?us-ascii?Q?gXOiYZRGt8AEgg+sFIFc6YI+HWa9OEdnEG/5MwrOq9IS0skwxnoR29vJ8uhn?=
 =?us-ascii?Q?RGdhkpiwB1H3HxkuuCnFrGQD089oYPiQg9Ka8YIGXLjH1LlkJe6DROsDV7cF?=
 =?us-ascii?Q?j+s3HoCIxTg4q7lXucfhYuDUq5WQhbZUA4W/5rsL7BH/ovM60uFJUK2eEIie?=
 =?us-ascii?Q?qVMBWLO+242lf1EcfQym1T1i09pBCmodLpU37RH4lcYAXXW5g6slhDLYaNU7?=
 =?us-ascii?Q?Lm1WVN+BbKLl2sTR+aQvkqB/y2VvtVm9BQuBgAj6t4ns7LBfN6fWzYccZ3oL?=
 =?us-ascii?Q?c62sSM0AIpltq7r9zfBLbMo/fHc6OLwScAY0Aj0tqb+5Cq/zLnMI1JX374vB?=
 =?us-ascii?Q?dGZjQEVu6+gV3WsF3+FrsSoscz60gGsDFfgmWQJgog/XD+/qGObwv89AIne0?=
 =?us-ascii?Q?OFUe9HEt8u3dnQuoxfvs4uMTLGgoSshXRu0CTJrgeaRdf752Qmwwcw4roCUY?=
 =?us-ascii?Q?PbHo1JGeDWWW8q53w03G6gOYP7QQdQ1pQ4gAtqE4ncmxeZv9wdpWED2rfRfl?=
 =?us-ascii?Q?nUGPKmT+8FkTuT5miTubYTusI5Gf7UWtrF+0GiUEhUmn82bcqBDnwfD52pqM?=
 =?us-ascii?Q?KY5xZ1RJWBcTtYCU1fyYjGvAxvMjW7BUowr87DzMBRUdvSYaMceL5InYj2xX?=
 =?us-ascii?Q?r33tV3pk+gEA4X5dcuWv3MqLrjqjMefmuAO2XnLYnaYDwD7MpyZbtJgB0jPi?=
 =?us-ascii?Q?ZssyPT+E3/OymViVsPRLxrwrM+B1aYZwTTGcMDAibtY9p6C3Lfst9Zekvgyv?=
 =?us-ascii?Q?n5SKl6olgwwnCfhrahUvaNdPAw9PkXIYLSJ983vGimDX6rIfzcH+cY2/Wo/Q?=
 =?us-ascii?Q?wFdGJRyt/LFW3e8tMNTPJSbINQcqy2bZS5QSHdWyFUougImJwLfC/D2N1WTx?=
 =?us-ascii?Q?OMiILYUD6LUdtdVY4qT83VFH6Mk3OOcuVCJDi6IEXO/zvb5pIjtjvwtEnZct?=
 =?us-ascii?Q?7FkYVD5C3mBp6LCgGzzjCD/TOEAYS5FSR/Oh5feLQp+1ACneyEdFAm4E3Brj?=
 =?us-ascii?Q?r01T3ZOp6TIOC+zemBBeCd3JbNjahe7Pkq9v3LVksYUrVnwNRwtEmq9ktP1q?=
 =?us-ascii?Q?OcC1RmItnn9alwLyEQX/lmU279scU28HaGzomnPiKuX2EalwTOY/nVSRcHqQ?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c2d42f-4b64-4f78-233c-08db3a2d83b8
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 01:38:56.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSoBkD1KHci9CaKZkA/n1z9TKSkiMbFFlCCjZ4LIMCsuyt/kVu4M74kyZ71FE4exPKwRlcrAWE8r96o9poq/ZrzNPj9prW2q54POJ4ZsQOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5607
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We read the status of device after reset,
It is not guaranteed that the device be reseted successfully.
We can use a while loop to make sure that,like the modern device did.
The spec is not request it ,but it work.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/virtio/virtio_pci_legacy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2257f1b3d8ae..f2d241563e4f 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -14,6 +14,7 @@
  *  Michael S. Tsirkin <mst@redhat.com>
  */
 
+#include <linux/delay.h>
 #include "linux/virtio_pci_legacy.h"
 #include "virtio_pci_common.h"
 
@@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_legacy_set_status(&vp_dev->ldev, 0);
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
-	vp_legacy_get_status(&vp_dev->ldev);
+	while (vp_legacy_get_status(&vp_dev->ldev))
+		msleep(1);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
-- 
2.25.1

