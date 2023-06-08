Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3944E727AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjFHJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjFHJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:02:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85823273E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k24TPocWyCTrlkRrF39AEJEZ6hJzaQQlw4sgwYvwQ5npsU/2g5TuGDfWq2zMm9aZlAw7qj84lD8fdxdWY8urgzzRRP0xIi3qcEv5Oeo6zZCP3QR+bInKnnLz5muXvERKgCvNpQpCAfNASVvh+7cgp9EBJ/CLbwTbBuwWlycMX2GTR1cau0of3xqwiuxJ4ezxmzfOlxqK2kzlmM6dwyi4FXcqzZoJLMjL3C52Sx4KhRaVG09sAhUhSKnfM4nGj7ga2uurEnJgjKbTLR6VkDA8JI3ZcSU11ugB0AlvDbXwW5nKS/MlLyzRadXMgwxdxJ0DFprgNVdAGej60isn49DzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLpj9tpNKlVBU0q0CYNgZPgdew+2C359xKZaeg8yc7A=;
 b=KwuDMMaqT/iqV0eHghsEqgqj3hl4l5qS8vmOHY7g/GyduesOVnDeRVAIIiw3pD4xaKSneDFc90F0K2nsKfJykt+B1XbRn/xH7t5LNx+TXYCUy4fEewZdklAk2s5P+aN7lJz0g+KKxihhfJNsplDv9J8dC2W2OwvKs9+cr5UaczSdfz7KgH162GPgqjImfiItdKeqBe3SO7DYMcyrtEn159fOWe9MgbihXtPdTMdOkiHFX2uQYbRvCWpVxnQrJpI8Ntq9VcNOGpYktO6B7WIGhLLHgGoX+/D18Rj0O090+o9v6FNRSIF8WftvHCdVDZd9OE9jvPFW+IQG4THlsshR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLpj9tpNKlVBU0q0CYNgZPgdew+2C359xKZaeg8yc7A=;
 b=rljqske5HWI4n5H7WtigO0uCuFkdiy79fvysTvk9zSHdC334LUc18YE75K0CyhHM2UuacBiU/lHb/vX4zEF4WnzWBxdpVpyeiReYJDLr17FhcxE5E43BlbX9nnwd47sko39yvNX2S9I7aKLuHOJ2oTpyDKgr9HJRt87tg/u1+Q7/Hz9DYKnccKGODUIAWJdj0TEMTdgtbx/lL1f8tFZu8Ro3wvLM7H6p8Y0mBFl5MDwd4XlNrdf3PFpabYZAP2/PAPUu2OhRDltIcswlibB1ZNcdwhOVDJNAo31qgL/LrUuGeMvaD+H0hpa8LBe5ulAshPDAP3DOpC2GotEwPwMb6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYZPR06MB6467.apcprd06.prod.outlook.com (2603:1096:400:464::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 09:01:58 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 09:01:58 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from add_config
Date:   Thu,  8 Jun 2023 17:01:24 +0800
Message-Id: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|TYZPR06MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 65141537-50dc-4dfc-c226-08db67ff03ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mRVHI2R/S6HOZMHo/fcnGs66UnRa/izNTUe5sxxixCHgaEAsF8XNPIfnQLT15kRMf9WiO5GWNmNQBiRuzMVLWwahU5Y4kg8/WXH4Z4MznjvFlNyy6/aUy6Uq9d+QJ7kfw2Vb2xWMvhNPawrphRuW3P7L3wBkgsIMe/dJB/f2UdC3iVNmZkh6P/GFupln9Y0PJdDUjAknpt7J4F7MWnWItmS8G2t1bREUDEZwzbzy7R3UxOjIDuxoMLzEqN/zM3AB3F5DsoHHE8vNI69dkjP0uugMf99xIoW8l9SlWqyDZSyFSSmDUSxpbYRmUUOQR0vfcHu+TST5ZujX8ZGtAyen45cJFxsIWdxSG732eji/Afe4EO1JI4b3PRLbWWugIUALerco3UlFk/t5BQQG66sVOFNzkFIaZnDvG4h5XgrXywi46436T/YUBgAqti26hvAqdxK38vqI8QJ2dhofuPftgIF2Iiq26PmDZVMLqMy8YNo2HUZKOD+giCVBPxraq/nvjXiND2reCGg5MUrTR15KGw/71Ug1n+bSdmW9pWizL1wAqfJvybiE3V7d7NLnX1ecen0WPhgKoKTcybU+a3mzN9qugnOmb68CvbmGpOTIH/CUd1YrBOxJ2cUIp4pIhJd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39830400003)(396003)(451199021)(8936002)(6666004)(6486002)(478600001)(66556008)(2616005)(83380400001)(52116002)(66476007)(66946007)(41300700001)(316002)(8676002)(1076003)(4326008)(5660300002)(86362001)(186003)(107886003)(6506007)(6512007)(26005)(36756003)(2906002)(44832011)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbgN7Y4jcHgbN43g4UXl4E636RL+Ci/+DkWoyreSQF6NFtrYckWq64RLwNZq?=
 =?us-ascii?Q?wtzluX49LDh6iC3JxSWeLV6+oyV0Yit6KtmWQKsaoGPrO50H61J0DwznuBAf?=
 =?us-ascii?Q?LghAW4FY0vuKlAvpfOI5VTUCCj4AFsd7pHZNv7xdOAg0q6JEiyBw4vbM/rTG?=
 =?us-ascii?Q?Wz914KXhFjkJN8MR/S0qVXu8SQSVhJzckPDeDUSAeHGqYKQHlxGW+JXL4ETh?=
 =?us-ascii?Q?NAIJ+ezf1QlUr+LAGtZiLdkbt99ZTEVtfFKyuFGg+xkPnLebySPjnqJ2oAz4?=
 =?us-ascii?Q?Xu8n4jijwe6qND1FRTMsXUnyPi1eyVkPMMuOf6nYInQ4hcLJctlaRwRz8Voo?=
 =?us-ascii?Q?yzyHUW0Dh/cPGJvtGA6G7u4SPfPIiD628yi9uzNmSs7K0JZ2q00KQmVMBonW?=
 =?us-ascii?Q?2dKGaFiilcbM8pA6vRmoOzO0FvpoE6yn+ptmKJwJ3HSUhRi9UAvHIq2qWqos?=
 =?us-ascii?Q?Yy+PSsJUXDbyE8OLdvbC0urBb57ak8IalgEsqEAQItAIsvvfAIt/8wj5o1ox?=
 =?us-ascii?Q?GGJeSsob5G3FIu2i4b50G7VrPQkYx0qH/ueqcsJncv8pxrtT5kTKorCqUdJ8?=
 =?us-ascii?Q?PmgVRKHF3kn1TUWkbYJcHMYYRWxOTg85TtMsd6nyOIYXR1KAB+cU21FP2EpU?=
 =?us-ascii?Q?rKN0PB8V3G1E9HPDUzmWybrMvVYSO2cPFW+SzJR3dz+XvJWRkll/EucNW4oo?=
 =?us-ascii?Q?hsZg2iqpFgrRDlcIxLlvp2vjs+yOMZhHm/CJG6/+Q0LeGZqZqijuDFKFu0cq?=
 =?us-ascii?Q?HUrVjZtaYKwAUWBRJEiW7bXTSqsck2Y877Cb2pPbDI6I0ukDss6OtUGdtQsw?=
 =?us-ascii?Q?OsavgNLwG9IqYxfM68D3L4LhPQd+ohWkfMb9OEt1K1CTg1ezdDPuOxYM7vsw?=
 =?us-ascii?Q?f2L+bDGIin2u1Clmre5+o1DAj5JdB2gtQCYXAKR3ko3ezAl8wi9vbbkGaF/a?=
 =?us-ascii?Q?f6+hApOewpnrFrjLyzf1/eTmShyW2VKZ7DtgX1CCvWVvcptlrFAWyjtuJsj/?=
 =?us-ascii?Q?OlPme6DINNS8xubnotMAyXPihCNkHlj0et+NCh2myEXvVRhFvBRxD2znj/QS?=
 =?us-ascii?Q?Uw+kYbT2+IQxci6IMol8qHPkmTo2B5ZwCAjv2xJJ0rzvJKoBshQtPUyWduFB?=
 =?us-ascii?Q?Rt+yJcy7oorrr7IIEVHBtWIKlHV+Pq1OjaJ/XwwpY/BwvigZm6qjixBXfRjd?=
 =?us-ascii?Q?1aIxESmTcuoWJHcD9inlVpqA1+/fjJQsbLQopCjWU7h6wW8LmHnqSpuUsp1s?=
 =?us-ascii?Q?XtxSW4qHD0ecf8huLC7YQs+sx4lMN/krovW8lZw9V14mi04D0ffP3B1Y3xIK?=
 =?us-ascii?Q?8j9wYGPNIJxJe6g5jT7qOQQzBqpgyNvXpDsvBKiugbk4JbuWg7iyweNvDVQO?=
 =?us-ascii?Q?hxGj5E77QqKTGwNx8uXLlhWt1R0ATF5YTiZGu4da6hou8ofQ98+FhLMMZr3D?=
 =?us-ascii?Q?UadWqIZoaVlOfuXttVwkx4FkAXh7VuNkDIpV2n2J2oi5sEdsmkRW5nE1Wjil?=
 =?us-ascii?Q?/hVm3nZSy6y5rKL3uNO3LoliKIP1n4uG2zhiF/Nrc26JvT+mo+1V2iF1eQB+?=
 =?us-ascii?Q?ibxvcjWdHF2q/ECtMkeBabjKVKSyDNU0hLeRKCd0ljrM5y7cBdGLvBDwEgfq?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65141537-50dc-4dfc-c226-08db67ff03ff
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:01:58.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qP7ZxKh4a6Kq6VHki1vVYwNWuGe38/dF1Gkg7F+pp3mqO7qRZSXS6Xgvo8zn7pmdUWdGjCmAbzn4h1+qBliPXHok6ZqdfVkuLT+AHnHGaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6467
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When add virtio_pci vdpa device,check the vqs number of device cap
and max_vq_pairs from add_config.
Simply starting from failing if the provisioned #qp is not
equal to the one that hardware has.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
v1: Use max_vqs from add_config
v2: Just return fail if max_vqs from add_config is not same as device
	cap. Suggested by jason.

 drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..c1fb6963da12 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	u64 device_features;
 	int ret, i;
 
-	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, 1, 1, name, false);
-
-	if (IS_ERR(vp_vdpa)) {
-		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
-		return PTR_ERR(vp_vdpa);
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
+		if (add_config->net.max_vq_pairs != (v_mdev->max_supported_vqs / 2)) {
+			dev_err(&pdev->dev, "max vqs 0x%x should be equal to 0x%x which device has\n",
+				add_config->net.max_vq_pairs*2, v_mdev->max_supported_vqs);
+			return -EINVAL;
+		}
 	}
 
-	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
-
-	vp_vdpa->vdpa.dma_dev = &pdev->dev;
-	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
-	vp_vdpa->mdev = mdev;
-
 	device_features = vp_modern_get_features(mdev);
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
 		if (add_config->device_features & ~device_features) {
-			ret = -EINVAL;
 			dev_err(&pdev->dev, "Try to provision features "
 				"that are not supported by the device: "
 				"device_features 0x%llx provisioned 0x%llx\n",
 				device_features, add_config->device_features);
-			goto err;
+			return -EINVAL;
 		}
 		device_features = add_config->device_features;
 	}
+
+	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
+				    dev, &vp_vdpa_ops, 1, 1, name, false);
+
+	if (IS_ERR(vp_vdpa)) {
+		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
+		return PTR_ERR(vp_vdpa);
+	}
+
+	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
+
+	vp_vdpa->vdpa.dma_dev = &pdev->dev;
+	vp_vdpa->queues = v_mdev->max_supported_vqs;
+	vp_vdpa->mdev = mdev;
 	vp_vdpa->device_features = device_features;
 
 	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
-- 
2.25.1

