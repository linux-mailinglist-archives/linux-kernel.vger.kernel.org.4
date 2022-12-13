Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3964B8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiLMPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiLMPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:49:24 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2026.outbound.protection.outlook.com [40.92.98.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAFC220E8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBzpB29jo4U7rKJUlu/J9Ps/msxU+ApxGJtHJqwRPjSyOz6uklp65oq7ZRQB6GtfMJ9bVHn/lOapEZ/7HaYq7TYmmVx3ZAvublp7h0/Bnvpe0R1oY6DKMpMro/+1xLv/a6TVp+xOFIaWEEQ1tM449BRqhdL9IrumqMgNSmdVD8UuY6+xXPDNzOC/HuVwBjbbKyZ8c5ZAb25DcURCAcIFVzJC/3GzQ4PztN1IwP90+ICsaoeDNG6XdvGeUdxYTX6s9jRQtG+WF7qfmuN9HoFWEXgNCs8ZPM9dT20Yuzvi/9RHkSyOqI6jk+gOGEl7jSmhxhzZJQHCHTjcDMIfKUCF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPSr3vTFyf4g308stz5pBdSs8FX4E7G1g4FXN60zMVM=;
 b=P6gQRObQM5qyi13bnpGBYlQkJ/8UvnM3k0RGFC9mqLDDcsiDMXbgaDhC5sHO+lDGr7qWI21Ph1EBWRvtDuEqnB44G4l7Xq2hfQgC+1zOh5eMaNn/xFPsAdOvah6FyjLsCFr9peGrHyT3C6oYQbV3t7XNS7lgc27lIArXjNWJT8CNySCaAYyVP33Yc8xaRLbekHPPov5dVl1I2lnkpIVDPBehB8Z9n36HXMnn1u5ekN4FRktFZjxP43LuTy/goS6ldFSLK/mn+WoIPFDm/H5ycQCNWPZ0tVg1qHbG7zXjlSnHTWjbILWDwxiWUZkNAIewWL1iNErsBykG0rBOfvDr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPSr3vTFyf4g308stz5pBdSs8FX4E7G1g4FXN60zMVM=;
 b=lUr1tsA3lLNvdelYqWgTqcQyFAYGZnQBVTcU2FRzl1Ah2dAXWOLZE5esVIp5avWoGJW5I1G19AXYT7Rx4e6wv3K+bwR1Kx5NorQMqYBmr1d67c/q0B56y3cXJg2g81U+QjPJGsxDvqdy15Tq3opuDqmiHzqZO/7i3b5aXjXiu0lFCDrii2NQqqmqjADgGpaaB4LtRIK0nhYnSzFJ4CWdYZmuNk+vv0vAAphvf1zFmdmRUoH+fb0JAr7HkH0izmgiwtcPCluG4T3PORZM3UMFyMLuGQhqItz1ARINE7EFpHAMZA+6DtmpgVJ/A3qmzx68P4P+nO8clMRBpj9CFtuydQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB2227.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 15:47:08 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 15:47:08 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     roger.pau@citrix.com, peterhuewe@gmx.de,
        oleksandr_andrushchenko@epam.com, airlied@gmail.com,
        dmitry.torokhov@gmail.com, wei.liu@kernel.org, bhelgaas@google.com,
        jejb@linux.ibm.com, gregkh@linuxfoundation.org, ericvh@gmail.com,
        tiwai@suse.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] xen: make remove callback of xen driver void returned
Date:   Tue, 13 Dec 2022 23:46:52 +0800
Message-ID: <TYCP286MB23238119AB4DF190997075C9CAE39@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bUw3LIKsGFBdoyvDHSf7gjXqCJ9EO3cn]
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221213154652.78360-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYCP286MB2227:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a69a06-ae5c-41d7-b09b-08dadd214a80
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRscvYkgDebxiuAUYjwcBrMtWuDiwhRbFxQKCsJhL0oJSF5c0oS6vHnAMh+RBYztonasNcT/F/cpGt1LrwmrltxRS/+H8gOpwewKkVaBuO+gho++yFmjthc2rrM0v1r5uTinNOo0h+NlMhvVlk1hxacbGBqnA94bmNIQiEiDkpY3adh/5L7m4tYl6wGv62WPlst9FeWynTolF3UOzw4UZ6ePGOt7DMQAiFn6xT+TdV+UNf+50xq/OltijjHy/UkKuMM1xeWrbC01aqCc3hiPE5Jkvn37oxywUH9nut0c+0HASgSCOx0M3WqZwX+yEaeNVh/Eo9atu5br2TV/FY1LNAtS9P5WWVg/uG6n3acHnSvjipofl/rbDN+anzrB2txwYOBv0Cwfk+/7i8GpkbHfRL4iTVPFFOfG731G+2DF+k9aT8ESJTXGrNiowtP34YntxoxWF7r4UIxnX0yNU7xZv77264LrbtLEIotPBoLw5Me+D+AvjkWK2zuxFSaZiMx62xCfam44obO4PakJufEcxFL5rOaZOj5Y1eMdR6PkDXiTTfgLVzsU8qo6nCKyhaComaYGH0+fbu9wok/gaDygxlWGVnnURU2ZIpMlXkarglFwHqq5cTB2AdlSrFoRQr0CTSjlaxX3dHiB9fGbD1zYcmrfQOU2XqIPsVkIwizgPbPuNIxIUwYlGDPfWBqlpYrGe1Wf181FUksoZJ1vv/ANvSsyYBrCq4aWFTZE6Kk+4Om8NiMbU72D+JaXu+hEXuXZFSEPba8vuzsUus1kQVemCcTNirU0bpGgOTU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PukBzQpB7qwyNPxNyRzugREyUdqiza9jCMHnjDrAE6wpC5XPiczqfNebnmNbs0FKmw2pd/ZU22YVn8ULpQuPXk8TZGP8TZllRvd6pqmGC/NwdvqpLBilWDQXR8IW9ScZmKXxwRYgBpfLJmYG4Z8Xzuq2IIvXR6BDH4wt90cUmE8Yf7olIqPmErnixzCmHZMlzBbX4m6Q+pqJbbIVOCwvLa3sD2Pel/oyyTqsj612f4TrDyo+v8dlRzbogOsephIZ+ljOEseBd698YKkYHozgmFwsGycduns+uoMxnO/80jfyGIvTReg+r3Ov6zjS0r0POksHt//bBsxcG+d7wK8swoiNvENDHs9j/UGDhztvUWgCuDUB64TCmmRD8bfTiwr2wzy5/oiY8AWCPh6+F/dU2+2r/aTNgIFEL8GcfIpDTPX7u6vATwKnMYJN7kPaz+HemxosCu0LPaHCg31qDtdwgYbpkLqoPBHXO1/fZAKPXOZMKQGsHABT8K2ZKgrHMG+I7qvhOg+SPK460xFN5ftBw52maaORkbpW70NxxvlJ7vpMPuPwiQzVcYoovlVUhfVdLeoGBT7Fuhw9acM1pNjdVd2xTiiaEaS31IIt88HW1Y4yhMieG2yce25ckaojIN22Nj8BOxAnAQWXk/UVg18RmQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjXmm/CpzQxoxChDGHVM462Xul6qOCLFp0RZHWimxU+Qg/ADvGPKQnB5nPCd?=
 =?us-ascii?Q?x38jXBzxC0J55rTp9f7BLwhVOHOqYDpnMS56aV2jNQN2YyZ2wfE/2yXgLF40?=
 =?us-ascii?Q?77T+btbS+dOSHHR50eO/GW17nHF8uCTDoTZGNK9n4wl/Ox2s/6IlXxRPiT0J?=
 =?us-ascii?Q?kzB41ltb+M8uqUsHRkHWlXsKMymRN5TncJZzgTS+kkAk3fxs0Oliocl+j3Xf?=
 =?us-ascii?Q?WeAwaQrh8q/+5vH2qeRtToyXWqxz8NLMvG87j1ifQHH74p+QBFwNMDcAW2R4?=
 =?us-ascii?Q?g9kiX4gtP8M39tvvHfcNk2Gz9Dfs5jo6RjanIiJTpMlaYMQOjiG5H3hMNhmO?=
 =?us-ascii?Q?hmX0iWAz4sdjNEfXVzb3VfUVxXYb1R0xcq0KUd/+7K0c8U83FqfyE4Kkp6yz?=
 =?us-ascii?Q?wUhqTsq9onDra3BGVDZmHm04WaOG3noakDd/dl1H/Y7VgG0Vu2AGFoBatEtb?=
 =?us-ascii?Q?asenGrpctJypiWcMlhw5Hz7tWfrUSlyr28T3N7RtBXwOCWM6VOmwBfPRKITO?=
 =?us-ascii?Q?5FoUpkc2H6Sh9FSRDy6OJqcV0H58o938dbXsUkCPULohyEIGXN1UjklNxwYs?=
 =?us-ascii?Q?LA7JvXpN5I+Xr99iK+UcQRvCvWJ1M+a+LPJylxVBSWtXBmptCoC3Yjkjd5zR?=
 =?us-ascii?Q?lWPA0tO120c47hHZjA6CP7do1hx7YZOjBZ59YLEj1RI1r8DOgZEXS+b4DsnS?=
 =?us-ascii?Q?6+vdbo5unaFS599NDjhxfRWUhrp4qFyhjfBCE4Uiu3lKaoI2mW9WXww63Vb2?=
 =?us-ascii?Q?N97mf9mcPjHzbYwYzDIouZLjOPHd/s1df330Pdco+prPphAxNZysZCOiMX5D?=
 =?us-ascii?Q?Q0kxmabVDFgv8grhwQoIWjFoxTZbUNIDrtpwEZfaTZllTjOH8/UG070wBUxF?=
 =?us-ascii?Q?4EZtuECPB7h8G5URdVIYxAK+00tY8hDPgUSxIwpRJ4G7ggVC1DZZhnk3wUno?=
 =?us-ascii?Q?nIPAx5iCj0F3x1i3+hJnJt2ls85Wm7tHSwjiDh6n5xzQP7Hn0PpRui6BzDbx?=
 =?us-ascii?Q?SaY33BzfZkmaZeXvh5qq8hq1P2zXnTiSRYNUZZ4OcBpCWUmigNHBb07JScO9?=
 =?us-ascii?Q?me2xKaSDYdtmE3f2lr2MXMIOdW9BJyk5dFyY5xBxpMopN1jnm22CrtXmZJdi?=
 =?us-ascii?Q?DIykFiTMqmZAWsB2Fq/jEkFwWXQSpdBmOz6kLMeA4WFKMttBxy16wQQ9Wnjl?=
 =?us-ascii?Q?4knR95GvHT8LEEPDibvvoSIgQ/qMYeTMfhEoTNuyoT9fad0IyrUXRDCse6K5?=
 =?us-ascii?Q?/4hlb7gjOdvaPCTBXTvpQwWEoZkkPXY186zEneKFbg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a69a06-ae5c-41d7-b09b-08dadd214a80
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 15:47:08.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2227
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fc7a6209d571 ("bus: Make remove callback return void")
forces bus_type::remove be void-returned, it doesn't make much sense for
any bus based driver implementing remove callbalk to return non-void to
its caller.

This change is for xen bus based drivers.

Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
v1 -> v2
- Rebased on latest xen/linux-next.
- 72 columns wrapping on changelog.

v1
- https://lore.kernel.org/all/TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
---
 drivers/block/xen-blkback/xenbus.c  | 4 +---
 drivers/block/xen-blkfront.c        | 3 +--
 drivers/char/tpm/xen-tpmfront.c     | 3 +--
 drivers/gpu/drm/xen/xen_drm_front.c | 3 +--
 drivers/input/misc/xen-kbdfront.c   | 5 ++---
 drivers/net/xen-netback/xenbus.c    | 3 +--
 drivers/net/xen-netfront.c          | 4 +---
 drivers/pci/xen-pcifront.c          | 4 +---
 drivers/scsi/xen-scsifront.c        | 4 +---
 drivers/tty/hvc/hvc_xen.c           | 4 ++--
 drivers/usb/host/xen-hcd.c          | 4 +---
 drivers/video/fbdev/xen-fbfront.c   | 6 ++----
 drivers/xen/pvcalls-back.c          | 3 +--
 drivers/xen/pvcalls-front.c         | 3 +--
 drivers/xen/xen-pciback/xenbus.c    | 4 +---
 drivers/xen/xen-scsiback.c          | 4 +---
 include/xen/xenbus.h                | 2 +-
 net/9p/trans_xen.c                  | 3 +--
 sound/xen/xen_snd_front.c           | 3 +--
 19 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index c0227dfa4688..4807af1d5805 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -524,7 +524,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	return 0;
 }
 
-static int xen_blkbk_remove(struct xenbus_device *dev)
+static void xen_blkbk_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
 
@@ -547,8 +547,6 @@ static int xen_blkbk_remove(struct xenbus_device *dev)
 		/* Put the reference we set in xen_blkif_alloc(). */
 		xen_blkif_put(be->blkif);
 	}
-
-	return 0;
 }
 
 int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 35b9bcad9db9..e68576ded7cb 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2468,7 +2468,7 @@ static void blkback_changed(struct xenbus_device *dev,
 	}
 }
 
-static int blkfront_remove(struct xenbus_device *xbdev)
+static void blkfront_remove(struct xenbus_device *xbdev)
 {
 	struct blkfront_info *info = dev_get_drvdata(&xbdev->dev);
 
@@ -2489,7 +2489,6 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 	}
 
 	kfree(info);
-	return 0;
 }
 
 static int blkfront_is_ready(struct xenbus_device *dev)
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 379291826261..80cca3b83b22 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -360,14 +360,13 @@ static int tpmfront_probe(struct xenbus_device *dev,
 	return tpm_chip_register(priv->chip);
 }
 
-static int tpmfront_remove(struct xenbus_device *dev)
+static void tpmfront_remove(struct xenbus_device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&dev->dev);
 	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
 	tpm_chip_unregister(chip);
 	ring_free(priv);
 	dev_set_drvdata(&chip->dev, NULL);
-	return 0;
 }
 
 static int tpmfront_resume(struct xenbus_device *dev)
diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 0d8e6bd1ccbf..90996c108146 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -717,7 +717,7 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
 	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
 }
 
-static int xen_drv_remove(struct xenbus_device *dev)
+static void xen_drv_remove(struct xenbus_device *dev)
 {
 	struct xen_drm_front_info *front_info = dev_get_drvdata(&dev->dev);
 	int to = 100;
@@ -751,7 +751,6 @@ static int xen_drv_remove(struct xenbus_device *dev)
 
 	xen_drm_drv_fini(front_info);
 	xenbus_frontend_closed(dev);
-	return 0;
 }
 
 static const struct xenbus_device_id xen_driver_ids[] = {
diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 8d8ebdc2039b..67f1c7364c95 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -51,7 +51,7 @@ module_param_array(ptr_size, int, NULL, 0444);
 MODULE_PARM_DESC(ptr_size,
 	"Pointing device width, height in pixels (default 800,600)");
 
-static int xenkbd_remove(struct xenbus_device *);
+static void xenkbd_remove(struct xenbus_device *);
 static int xenkbd_connect_backend(struct xenbus_device *, struct xenkbd_info *);
 static void xenkbd_disconnect_backend(struct xenkbd_info *);
 
@@ -404,7 +404,7 @@ static int xenkbd_resume(struct xenbus_device *dev)
 	return xenkbd_connect_backend(dev, info);
 }
 
-static int xenkbd_remove(struct xenbus_device *dev)
+static void xenkbd_remove(struct xenbus_device *dev)
 {
 	struct xenkbd_info *info = dev_get_drvdata(&dev->dev);
 
@@ -417,7 +417,6 @@ static int xenkbd_remove(struct xenbus_device *dev)
 		input_unregister_device(info->mtouch);
 	free_page((unsigned long)info->page);
 	kfree(info);
-	return 0;
 }
 
 static int xenkbd_connect_backend(struct xenbus_device *dev,
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index c1ba4294f364..001636901dda 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -977,7 +977,7 @@ static int read_xenbus_vif_flags(struct backend_info *be)
 	return 0;
 }
 
-static int netback_remove(struct xenbus_device *dev)
+static void netback_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
 
@@ -992,7 +992,6 @@ static int netback_remove(struct xenbus_device *dev)
 	kfree(be->hotplug_script);
 	kfree(be);
 	dev_set_drvdata(&dev->dev, NULL);
-	return 0;
 }
 
 /*
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 9af2b027c19c..bc17f5391b1a 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -2640,7 +2640,7 @@ static void xennet_bus_close(struct xenbus_device *dev)
 	} while (!ret);
 }
 
-static int xennet_remove(struct xenbus_device *dev)
+static void xennet_remove(struct xenbus_device *dev)
 {
 	struct netfront_info *info = dev_get_drvdata(&dev->dev);
 
@@ -2656,8 +2656,6 @@ static int xennet_remove(struct xenbus_device *dev)
 		rtnl_unlock();
 	}
 	xennet_free_netdev(info->netdev);
-
-	return 0;
 }
 
 static const struct xenbus_device_id netfront_ids[] = {
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 7378e2f3e525..fcd029ca2eb1 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -1055,14 +1055,12 @@ static int pcifront_xenbus_probe(struct xenbus_device *xdev,
 	return err;
 }
 
-static int pcifront_xenbus_remove(struct xenbus_device *xdev)
+static void pcifront_xenbus_remove(struct xenbus_device *xdev)
 {
 	struct pcifront_device *pdev = dev_get_drvdata(&xdev->dev);
 
 	if (pdev)
 		free_pdev(pdev);
-
-	return 0;
 }
 
 static const struct xenbus_device_id xenpci_ids[] = {
diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 66b316d173b0..71a3bb83984c 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -995,7 +995,7 @@ static int scsifront_suspend(struct xenbus_device *dev)
 	return err;
 }
 
-static int scsifront_remove(struct xenbus_device *dev)
+static void scsifront_remove(struct xenbus_device *dev)
 {
 	struct vscsifrnt_info *info = dev_get_drvdata(&dev->dev);
 
@@ -1011,8 +1011,6 @@ static int scsifront_remove(struct xenbus_device *dev)
 
 	scsifront_free_ring(info);
 	scsi_host_put(info->host);
-
-	return 0;
 }
 
 static void scsifront_disconnect(struct vscsifrnt_info *info)
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 7c23112dc923..c879f922c716 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -394,9 +394,9 @@ static int xen_console_remove(struct xencons_info *info)
 	return 0;
 }
 
-static int xencons_remove(struct xenbus_device *dev)
+static void xencons_remove(struct xenbus_device *dev)
 {
-	return xen_console_remove(dev_get_drvdata(&dev->dev));
+	xen_console_remove(dev_get_drvdata(&dev->dev));
 }
 
 static int xencons_connect_backend(struct xenbus_device *dev,
diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index de1b09158318..46fdab940092 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -1530,15 +1530,13 @@ static void xenhcd_backend_changed(struct xenbus_device *dev,
 	}
 }
 
-static int xenhcd_remove(struct xenbus_device *dev)
+static void xenhcd_remove(struct xenbus_device *dev)
 {
 	struct xenhcd_info *info = dev_get_drvdata(&dev->dev);
 	struct usb_hcd *hcd = xenhcd_info_to_hcd(info);
 
 	xenhcd_destroy_rings(info);
 	usb_put_hcd(hcd);
-
-	return 0;
 }
 
 static int xenhcd_probe(struct xenbus_device *dev,
diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 4d2694d904aa..ae8a50ecdbd3 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(video,
 	"Video memory size in MB, width, height in pixels (default 2,800,600)");
 
 static void xenfb_make_preferred_console(void);
-static int xenfb_remove(struct xenbus_device *);
+static void xenfb_remove(struct xenbus_device *);
 static void xenfb_init_shared_page(struct xenfb_info *, struct fb_info *);
 static int xenfb_connect_backend(struct xenbus_device *, struct xenfb_info *);
 static void xenfb_disconnect_backend(struct xenfb_info *);
@@ -527,7 +527,7 @@ static int xenfb_resume(struct xenbus_device *dev)
 	return xenfb_connect_backend(dev, info);
 }
 
-static int xenfb_remove(struct xenbus_device *dev)
+static void xenfb_remove(struct xenbus_device *dev)
 {
 	struct xenfb_info *info = dev_get_drvdata(&dev->dev);
 
@@ -542,8 +542,6 @@ static int xenfb_remove(struct xenbus_device *dev)
 	vfree(info->gfns);
 	vfree(info->fb);
 	kfree(info);
-
-	return 0;
 }
 
 static unsigned long vmalloc_to_gfn(void *address)
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index d6f945fd4147..ea52a2092bb8 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -1181,9 +1181,8 @@ static void pvcalls_back_changed(struct xenbus_device *dev,
 	}
 }
 
-static int pvcalls_back_remove(struct xenbus_device *dev)
+static void pvcalls_back_remove(struct xenbus_device *dev)
 {
-	return 0;
 }
 
 static int pvcalls_back_uevent(struct xenbus_device *xdev,
diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 1826e8e67125..5328f4d35f25 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -1085,7 +1085,7 @@ static const struct xenbus_device_id pvcalls_front_ids[] = {
 	{ "" }
 };
 
-static int pvcalls_front_remove(struct xenbus_device *dev)
+static void pvcalls_front_remove(struct xenbus_device *dev)
 {
 	struct pvcalls_bedata *bedata;
 	struct sock_mapping *map = NULL, *n;
@@ -1121,7 +1121,6 @@ static int pvcalls_front_remove(struct xenbus_device *dev)
 	kfree(bedata->ring.sring);
 	kfree(bedata);
 	xenbus_switch_state(dev, XenbusStateClosed);
-	return 0;
 }
 
 static int pvcalls_front_probe(struct xenbus_device *dev,
diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index d171091eec12..b11e401f1b1e 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -716,14 +716,12 @@ static int xen_pcibk_xenbus_probe(struct xenbus_device *dev,
 	return err;
 }
 
-static int xen_pcibk_xenbus_remove(struct xenbus_device *dev)
+static void xen_pcibk_xenbus_remove(struct xenbus_device *dev)
 {
 	struct xen_pcibk_device *pdev = dev_get_drvdata(&dev->dev);
 
 	if (pdev != NULL)
 		free_pdev(pdev);
-
-	return 0;
 }
 
 static const struct xenbus_device_id xen_pcibk_ids[] = {
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 6106ed93817d..954188b0b858 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1249,7 +1249,7 @@ static void scsiback_release_translation_entry(struct vscsibk_info *info)
 	spin_unlock_irqrestore(&info->v2p_lock, flags);
 }
 
-static int scsiback_remove(struct xenbus_device *dev)
+static void scsiback_remove(struct xenbus_device *dev)
 {
 	struct vscsibk_info *info = dev_get_drvdata(&dev->dev);
 
@@ -1261,8 +1261,6 @@ static int scsiback_remove(struct xenbus_device *dev)
 	gnttab_page_cache_shrink(&info->free_pages, 0);
 
 	dev_set_drvdata(&dev->dev, NULL);
-
-	return 0;
 }
 
 static int scsiback_probe(struct xenbus_device *dev,
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index eaa932b99d8a..ad4fb4eab753 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -117,7 +117,7 @@ struct xenbus_driver {
 		     const struct xenbus_device_id *id);
 	void (*otherend_changed)(struct xenbus_device *dev,
 				 enum xenbus_state backend_state);
-	int (*remove)(struct xenbus_device *dev);
+	void (*remove)(struct xenbus_device *dev);
 	int (*suspend)(struct xenbus_device *dev);
 	int (*resume)(struct xenbus_device *dev);
 	int (*uevent)(struct xenbus_device *, struct kobj_uevent_env *);
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index aaa5fd364691..9950e1a5acb7 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -303,13 +303,12 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 	kfree(priv);
 }
 
-static int xen_9pfs_front_remove(struct xenbus_device *dev)
+static void xen_9pfs_front_remove(struct xenbus_device *dev)
 {
 	struct xen_9pfs_front_priv *priv = dev_get_drvdata(&dev->dev);
 
 	dev_set_drvdata(&dev->dev, NULL);
 	xen_9pfs_front_free(priv);
-	return 0;
 }
 
 static int xen_9pfs_front_alloc_dataring(struct xenbus_device *dev,
diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
index 4041748c12e5..b66e037710d0 100644
--- a/sound/xen/xen_snd_front.c
+++ b/sound/xen/xen_snd_front.c
@@ -311,7 +311,7 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
 	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
 }
 
-static int xen_drv_remove(struct xenbus_device *dev)
+static void xen_drv_remove(struct xenbus_device *dev)
 {
 	struct xen_snd_front_info *front_info = dev_get_drvdata(&dev->dev);
 	int to = 100;
@@ -345,7 +345,6 @@ static int xen_drv_remove(struct xenbus_device *dev)
 
 	xen_snd_drv_fini(front_info);
 	xenbus_frontend_closed(dev);
-	return 0;
 }
 
 static const struct xenbus_device_id xen_drv_ids[] = {
-- 
2.25.1

