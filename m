Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11A56DDF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjDKPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjDKPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:13:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68F59D1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQUKi0+k2mbM23zgG922wuzIdflW4q1itK379fIp66Ybsz1S9E+GD95uBVSpx10+TzeQCEL4PdwBleQEd3cDGgjTOA01xAMwC47mIMbg+QXYrwMXhTFaZW52XlMtvl9BZDKHdtwFF+IzNT6oMQX2pV2kyL6p9GjQTEmu76ew2EOBBV1zN3i7anCZ0KWkSLtgz3pzUZOMt4hYzvrSnJ7hePOoTtqkAoYW1yAVf0L+sBnSb/xeyBvT2kcFmsI6JNQzyIXbUyMnPi/PetSmrxjzc9UQq50YNf+7cH8gGX9pHzOAkPm7G6zpWz1XYb3m0lhNFwtlilaVH3LOknm5Cph0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AloRxyzXNNRlEN/Zfgm4cGLjnoNr+p/TXsgf2GZk/BU=;
 b=hpsZxgLpMwOk58ls4Kfh3/EcHSuGnfGK3v5+94iKHluEzaVs5P2LHEBu6S7wzCohDtnz3Uissj+Gp0LR7OTrDF+PXeHDEN53VfMmZ+z9RhN5WTT2WkU+/3W9SanDE2snzm/PK01Pgfa3BeqtLoMyl/cNdUtXx6xa73Ybj05GbzBMC2p/agyzx/oD2V8iTkKvJ1H+CbmPMToqy0FmuA29in9flUWlsXAvLATSAOWdxwTZDrOIAVnTzeNOWxWq8oRFc6VhX9kWWDSqYqEvnU02jnQxc6g/ttmJbiKq7YV2YuQwwxz4MyPAJRM+9FE2VN7e8JwWR1q1MdcAnD5QVL9+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AloRxyzXNNRlEN/Zfgm4cGLjnoNr+p/TXsgf2GZk/BU=;
 b=WjWx4J10B4GME7PlFSCYzIy7SQt+CB062+hq326CRF9MWk64QlRenlI4x8Ih/z71PQ7nVSpl0j8TpfK+ikJOvp0F5dzHjZMvzEg3uQbM/oU6CvXGTtkBN/xuNmLaHp7FiBTn5cB3uYbY3uugEQU9DCDtDNTDC44VITMXp8+cT+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB9064.eurprd04.prod.outlook.com (2603:10a6:20b:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:12:00 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:12:00 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP 6/7] firmware: imx: add ELE MU driver support
Date:   Tue, 11 Apr 2023 21:55:35 +0530
Message-Id: <20230411162536.30604-7-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411162536.30604-1-pankaj.gupta@nxp.com>
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c13d890-1312-4ccb-e8b4-08db3a9f18f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nRlbmXKG23zVpAQbcLzukG58YCfpXd9fCW+zk36E+c0/6WAnyJEsgjnpa8H/hMt/3tzSZHhf2hjx/mHwhiFcahCDP9tvxJBAl/Wo7NlnT6fcA5XZUOFehAW2wX/1YnpcSh2cUUWz9gbuY/ElCOERa26d5UF10l2EFA3G4X9FSTklUXtr9lwBBLqDvlb5bE6mLg9C8tGJVHaokYR451Uvi0rZeqE0jjJmuoBS+GQQS4VBCrxN0wtqtuM3BVbyruBVR6nwc5Jn7GBdWnS4lYsyTSFvJPKA3LwpUiS8Qq7mhm+KWZNcMszHURU/bqOT4+yKzgSfQqKVgoqBsCBk6GyRGjN3AYVyOdwAwH+c6DYVZgcr9vDYxeJsvFYMdXhitblqyVyJdQEw+M5TM7BOztR/+yjU9uYX8qJbkkedm8kfstSdBTpTzF2knZiyw+AOD9iLhtty2nI4J64IyIHgH/edIejb9UvE09Qt0PpVPD3CUcnhcvKD9m3vxm/YuxsrHzeFKlKGeIr/LUclmQciP8uXq06PouYtzL2gv64b3JOJT+pDqDFSBBYb5vXuSqf5Ui5yQyvSWeefyOpc9mYLkH7r78e96PK/h7d4TESj/iDiUw71EKzDlnACZ5Kvs+r1S9gkY7NuPLVsc73ngQ5vJwePA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(52116002)(66946007)(4326008)(8676002)(66556008)(66476007)(186003)(5660300002)(83380400001)(86362001)(316002)(6666004)(41300700001)(8936002)(6636002)(478600001)(2906002)(36756003)(26005)(44832011)(1076003)(6512007)(6506007)(6486002)(2616005)(38100700002)(38350700002)(30864003)(921005)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLJ9/ur7wGmgc+oTiPzK6+dYsR1ATZ6fPeySCkv5Z2kznWdm3MLhDaeC62uR?=
 =?us-ascii?Q?uOqdPfiJmjVL4S5HrMVlsFHj3JIcNOqQbzOEfCB8y6619tQtRjum2AtMPLPQ?=
 =?us-ascii?Q?uyqWK+TpMJMU54YtuqoBdslbffKamJ5ARvuvSYWDSm7MPUdmIPBxnSClxbKi?=
 =?us-ascii?Q?wx+wlphEG4s1HLD0oCLANGhUDE6aoMDBr839+1/Q/MsRqn8ucBQ76gt5yEUh?=
 =?us-ascii?Q?F4ppoIZB+oc5/Mo1g4kwjJE95NH/FeRJYnUzHc2Fn9H6w704AUd5O9tt9k+1?=
 =?us-ascii?Q?PB8YonGBH+nnR7ZDVmSihTOxhEyEn31wH06gZezkkLxx7AVNOXm0mzsn6aNL?=
 =?us-ascii?Q?arQzdYCVfLu+bAM/4kma+b//QQyDcnHkBLWOMIS+refFkDoh4x2bd7qYGWtT?=
 =?us-ascii?Q?f1890CAMB0OeVri7PdyTNHuc9eUFF+f1bexQw3SMgvtN128zQw99WPoXRpXj?=
 =?us-ascii?Q?ssDn/r74fd3DvSjTS9FSeIuEDclCYhSPSpPUUvhGtyIFx0al1rCs1leKx0NR?=
 =?us-ascii?Q?SEltcV5OEfvrkt4ncFJjzxKNkMi+4bg1+MHPiyoWVejSjN3W5rnKoONt7uOI?=
 =?us-ascii?Q?cA+sdcICmQ8PwHhj7yIK+mBsvEcXG6z+IYxzfwwikDbaKR3KNL5BRAcb1S55?=
 =?us-ascii?Q?tDo8iGrK/gfN6NsZO9GFOQSKvQvRHyQ1XdqBryuSNMmF1IGFEpsXXS40CjDG?=
 =?us-ascii?Q?SifUOjoUf+SRLUjpKD/FH2NUjTDpss84OKEMd/b1wDeLmo0RbjeTj/fAVk9/?=
 =?us-ascii?Q?P2Qupvq/I2ULgDiN541Sq//Exgj5mzf3EYekA5WM2/4VkGwkjfPa0btmcLoZ?=
 =?us-ascii?Q?mRevLNW9iQVg3JW00LGzDCopJ5sgcibvzILDDHPG/4dJ98GXeIFZrysHwo5y?=
 =?us-ascii?Q?XKuMpsP6gFQ1vjelcg/PqOL8H9ccLpKDSXngHQFQXqM1WhOizloL1IpBqmKP?=
 =?us-ascii?Q?dkrkZ0pAkPsV1WXLVgB8RQDFNUA9l2AHb63SSXTinZ+q0BU/M4UMpwbJwLFV?=
 =?us-ascii?Q?lhflvdmvf8c9ZyqhTTEZ9hx5YPsikZymmba3jZQCrHZgUafUk+qhx0gAs8pB?=
 =?us-ascii?Q?fN+mFymQesAAgu2+K85CO5L++odlfLPzI4gXssmUYSJ+y+55g3qOc74AybiQ?=
 =?us-ascii?Q?oxtJOKPob6QprjNddTr50DPXqQMNSNOe5WqBIt6VPbQqWkO497a3gfqQgr2e?=
 =?us-ascii?Q?5BupUDUEXTyorfQg6w7OVLWZmHtgwvGrfUo1bGybkst7IBfDDaL0EZ2WUUbV?=
 =?us-ascii?Q?/MkKVEr9ZlLT70/DJM45Vjb7sgwEf2GurUO6bZKJFacNK2p/Q7KK+WfjA93q?=
 =?us-ascii?Q?W6ggoSxCOHqHVv08wySoGpHcwk+nFqg/smCt0bvxpI2LPBeY3Y99Ht3Uzj2O?=
 =?us-ascii?Q?1FF1sNMVTGmhP4sA8fP09TShVkw/WlOcep96AZQ8gyN0iizteph7Vnsz5Xp8?=
 =?us-ascii?Q?okTobWr+utUt99aZ2N1Lk7IJX6UzDlc4P6vLfxOFQwgRfPXVxpB6u32m+JE1?=
 =?us-ascii?Q?iH2r/KKaKhxbzJd2O76UdiFlee+V68xY1VH0h54nNT46sgkbjzbXFxq6YWyk?=
 =?us-ascii?Q?RDD975KhZ76839QQYXOBpHPVFLA84/c0X8RA7zuO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c13d890-1312-4ccb-e8b4-08db3a9f18f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:12:00.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sAs5bEKBNRjrZnVEvAaooXXH4qB8MEKiKb3xRBMBjwBUt5HOFhe8B3IMmVDNt0erRBZiIW8PjWXLdjvTVdQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9064
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Edgelock Enclave Message Unit (ELE MU), is a message based
communication channel, to communicated with ELE Firmware.

This runs on a dedicated MU present between application core and
ELE H/W IP. It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93

This patch implements the mail-box based communication with
ELE firmware.

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig              |   11 +
 drivers/firmware/imx/Makefile             |    2 +
 drivers/firmware/imx/ele_base_msg.c       |  377 ++++++
 drivers/firmware/imx/ele_mu.c             | 1284 +++++++++++++++++++++
 drivers/firmware/imx/ele_mu.h             |  174 +++
 include/linux/firmware/imx/ele_base_msg.h |   66 ++
 include/linux/firmware/imx/ele_mu_ioctl.h |   52 +
 7 files changed, 1966 insertions(+)
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_mu.c
 create mode 100644 drivers/firmware/imx/ele_mu.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c027d99f2a59..8b4d627e48b8 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -28,3 +28,14 @@ config IMX_SCU_PD
 	depends on IMX_SCU
 	help
 	  The System Controller Firmware (SCFW) based power domain driver.
+
+config IMX_EL_ENCLAVE
+	tristate "i.MX Embedded EdgeLock Enclave support."
+	depends on IMX_MBOX
+	default m if ARM64
+
+	help
+	  It is possible to use APIs exposed by the iMX EdgeLock Enclave like base, HSM &
+	  SHE using the SAB protocol via the shared Messaging Unit. This driver exposes
+	  these interfaces via a set of file descriptors allowing to configure shared
+	  memory, send and receive messages.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index b76acbade2a0..886385e79bf2 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
+el_enclave-objs			= ele_mu.o ele_base_msg.o
+obj-${CONFIG_IMX_EL_ENCLAVE}	+= el_enclave.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
new file mode 100644
index 000000000000..5c7667674089
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2023 NXP
+ */
+
+#include <linux/types.h>
+#include <linux/completion.h>
+
+#include <linux/firmware/imx/ele_base_msg.h>
+#include <linux/firmware/imx/ele_mu_ioctl.h>
+
+#include "ele_mu.h"
+
+/* Fill a command message header with a given command ID and length in bytes. */
+static int plat_fill_cmd_msg_hdr(struct mu_hdr *hdr,
+				 uint8_t cmd,
+				 uint32_t len)
+{
+	struct ele_mu_priv *priv = NULL;
+	int err;
+
+	err = get_ele_mu_priv(&priv);
+	if (err) {
+		pr_err("Error: iMX EdgeLock Enclave MU, used before probing.\n");
+		return err;
+	}
+
+	hdr->tag = priv->cmd_tag;
+	hdr->ver = ELE_BASE_API_VERSION;
+	hdr->command = cmd;
+	hdr->size = len >> 2;
+
+	return err;
+}
+
+static u32 plat_add_msg_crc(uint32_t *msg, uint32_t msg_len)
+{
+	uint32_t i;
+	uint32_t crc = 0;
+	uint32_t nb_words = msg_len >> 2;
+
+	for (i = 0; i < nb_words - 1; i++)
+		crc ^= *(msg + i);
+
+	return crc;
+}
+
+int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
+{
+	unsigned int wait;
+	int err;
+
+	mutex_lock(&priv->mu_cmd_lock);
+	mutex_lock(&priv->mu_lock);
+
+	err = mbox_send_message(priv->tx_chan, &priv->tx_msg);
+	if (err < 0) {
+		pr_err("Error: mbox_send_message failure.\n");
+		mutex_unlock(&priv->mu_lock);
+		return err;
+	}
+	mutex_unlock(&priv->mu_lock);
+
+	wait = msecs_to_jiffies(1000);
+	if (!wait_for_completion_timeout(&priv->done, wait)) {
+		pr_err("Error: wait_for_completion timed out.\n");
+		err = -ETIMEDOUT;
+	}
+
+	/* As part of func ele_mu_rx_callback() execution,
+	 * response will copied to ele_msg->rsp_msg.
+	 *
+	 * Lock: (mutex_unlock(&ele_mu_priv->mu_cmd_lock),
+	 * will be unlocked if it is a response.
+	 */
+
+	return err;
+}
+
+static int read_otp_uniq_id(struct ele_mu_priv *priv, u32 *value)
+{
+	unsigned int tag, command, size, ver, status;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+
+	if (tag == priv->rsp_tag &&
+	    command == ELE_READ_FUSE_REQ &&
+	    size == ELE_READ_FUSE_RSP_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == ELE_SUCCESS_IND) {
+		value[0] = priv->rx_msg.data[1];
+		value[1] = priv->rx_msg.data[2];
+		value[2] = priv->rx_msg.data[3];
+		value[3] = priv->rx_msg.data[4];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int read_fuse_word(struct ele_mu_priv *priv, u32 *value)
+{
+	unsigned int tag, command, size, ver, status;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+
+	if (tag == priv->rsp_tag &&
+	    command == ELE_READ_FUSE_REQ &&
+	    size == ELE_READ_FUSE_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == ELE_SUCCESS_IND) {
+		value[0] = priv->rx_msg.data[1];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+int read_common_fuse(uint16_t fuse_id, u32 *value)
+{
+	struct ele_mu_priv *priv = NULL;
+	int err;
+
+	err = get_ele_mu_priv(&priv);
+	if (err) {
+		pr_err("Error: iMX EdgeLock Enclave MU, used before probing.\n");
+		return err;
+	}
+	err = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_READ_FUSE_REQ, 8);
+	if (err) {
+		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
+		return err;
+	}
+
+	priv->tx_msg.data[0] = fuse_id;
+	err = imx_ele_msg_send_rcv(priv);
+	if (err < 0)
+		return err;
+
+	switch (fuse_id) {
+	case OTP_UNIQ_ID:
+		err = read_otp_uniq_id(priv, value);
+		break;
+	default:
+		err = read_fuse_word(priv, value);
+		break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(read_common_fuse);
+
+int ele_ping(void)
+{
+	struct ele_mu_priv *priv = NULL;
+	unsigned int tag, command, size, ver, status;
+	int err;
+
+	err = get_ele_mu_priv(&priv);
+	if (err) {
+		pr_err("Error: iMX EdgeLock Enclave MU, used before probing.\n");
+		return err;
+	}
+	err = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_PING_REQ, 4);
+	if (err) {
+		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
+		return err;
+	}
+
+	err = imx_ele_msg_send_rcv(priv);
+	if (err < 0)
+		return err;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+
+	if (tag == priv->rsp_tag && command == ELE_PING_REQ &&
+	    size == ELE_PING_REQ_MSG_SZ && ver == ELE_BASE_API_VERSION &&
+	    status == ELE_SUCCESS_IND)
+		return 0;
+
+	return -EAGAIN;
+}
+EXPORT_SYMBOL_GPL(ele_ping);
+
+int ele_service_swap(phys_addr_t addr, u32 addr_size, u16 flag)
+{
+	struct ele_mu_priv *priv;
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	ret = get_ele_mu_priv(&priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_SERVICE_SWAP_REQ, 24);
+	if (ret)
+		return ret;
+
+	priv->tx_msg.data[0] = flag;
+	priv->tx_msg.data[1] = addr_size;
+	priv->tx_msg.data[2] = ELE_NONE_VAL;
+	priv->tx_msg.data[3] = lower_32_bits(addr);
+	priv->tx_msg.data[4] = plat_add_msg_crc((uint32_t *)&priv->tx_msg, 24);
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		return ret;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+	if (tag == priv->rsp_tag &&
+	    command == ELE_SERVICE_SWAP_REQ &&
+	    size == ELE_SERVICE_SWAP_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == ELE_SUCCESS_IND) {
+		if (flag == ELE_IMEM_EXPORT)
+			return priv->rx_msg.data[1];
+		else
+			return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(ele_service_swap);
+
+int ele_get_info(phys_addr_t addr, u32 data_size)
+{
+	struct ele_mu_priv *priv;
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	ret = get_ele_mu_priv(&priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_GET_INFO_REQ, 16);
+	if (ret)
+		return ret;
+
+	priv->tx_msg.data[0] = upper_32_bits(addr);
+	priv->tx_msg.data[1] = lower_32_bits(addr);
+	priv->tx_msg.data[2] = data_size;
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		return ret;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+	if (tag == priv->rsp_tag &&
+	    command == ELE_GET_INFO_REQ &&
+	    size == ELE_GET_INFO_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == ELE_SUCCESS_IND)
+		return 0;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(ele_get_info);
+
+/*
+ * ele_get_trng_state() - prepare and send the command to read
+ *                        crypto lib and TRNG state
+ * TRNG state
+ *  0x1		TRNG is in program mode
+ *  0x2		TRNG is still generating entropy
+ *  0x3		TRNG entropy is valid and ready to be read
+ *  0x4		TRNG encounter an error while generating entropy
+ *
+ * CSAL state
+ *  0x0		Crypto Lib random context initialization is not done yet
+ *  0x1		Crypto Lib random context initialization is on-going
+ *  0x2		Crypto Lib random context initialization succeed
+ *  0x3		Crypto Lib random context initialization failed
+ *
+ * returns: csal and trng state.
+ *
+ */
+int ele_get_trng_state(void)
+{
+	struct ele_mu_priv *priv;
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	/* access ele_mu_priv data structure pointer*/
+	ret = get_ele_mu_priv(&priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_GET_TRNG_STATE_REQ, 4);
+	if (ret)
+		return ret;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		return ret;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+	if (tag == priv->rsp_tag &&
+	    command == ELE_GET_TRNG_STATE_REQ &&
+	    size == ELE_GET_TRNG_STATE_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == ELE_SUCCESS_IND) {
+		return (priv->rx_msg.data[1] & CSAL_TRNG_STATE_MASK);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(ele_get_trng_state);
+
+/*
+ * ele_start_rng() - prepare and send the command to start
+ *                   initialization of the ELE RNG context
+ *
+ * returns:  0 on success.
+ */
+int ele_start_rng(void)
+{
+	struct ele_mu_priv *priv;
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	/* access ele_mu_priv data structure pointer*/
+	ret = get_ele_mu_priv(&priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr((struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_START_RNG_REQ, 4);
+	if (ret)
+		return ret;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		return ret;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+	if (tag == priv->rsp_tag &&
+	    command == ELE_START_RNG_REQ &&
+	    size == ELE_START_RNG_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == ELE_SUCCESS_IND) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(ele_start_rng);
diff --git a/drivers/firmware/imx/ele_mu.c b/drivers/firmware/imx/ele_mu.c
new file mode 100644
index 000000000000..674c7954546b
--- /dev/null
+++ b/drivers/firmware/imx/ele_mu.c
@@ -0,0 +1,1284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2023 NXP
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/firmware/imx/ele_base_msg.h>
+#include <linux/firmware/imx/ele_mu_ioctl.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/sys_soc.h>
+#include <linux/workqueue.h>
+
+#include "ele_mu.h"
+
+#define ELE_PING_INTERVAL		(3600 * HZ)
+#define ELE_TRNG_STATE_OK		0x203
+#define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
+
+#define ELE_GET_INFO_BUFF_SZ		0x100
+#define ELE_GET_INFO_READ_SZ		0xA0
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xCA
+#define ELE_IMEM_STATE_BAD		0xFE
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+
+#define RESERVED_DMA_POOL		BIT(1)
+
+struct ele_mu_priv *ele_priv_export;
+
+struct imx_info {
+	bool socdev;
+	/* platform specific flag to enable/disable the ELE True RNG */
+	bool enable_ele_trng;
+	bool reserved_dma_ranges;
+};
+
+static const struct imx_info imx8ulp_info = {
+	.socdev = true,
+	.enable_ele_trng = false,
+	.reserved_dma_ranges = true,
+};
+
+static const struct imx_info imx93_info = {
+	.socdev = false,
+	.enable_ele_trng = true,
+	.reserved_dma_ranges = true,
+};
+
+static const struct of_device_id ele_mu_match[] = {
+	{ .compatible = "fsl,imx-ele", .data = (void *)&imx8ulp_info},
+	{ .compatible = "fsl,imx93-ele", .data = (void *)&imx93_info},
+	{},
+};
+
+int get_ele_mu_priv(struct ele_mu_priv **export)
+{
+	if (!ele_priv_export)
+		return -EPROBE_DEFER;
+
+	*export = ele_priv_export;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(get_ele_mu_priv);
+
+/*
+ * Callback called by mailbox FW when data are received
+ */
+static void ele_mu_rx_callback(struct mbox_client *c, void *msg)
+{
+	struct device *dev = c->dev;
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	struct ele_mu_device_ctx *dev_ctx;
+	bool is_response = false;
+	int msg_size;
+	struct mu_hdr header;
+
+	dev_dbg(dev, "Message received on mailbox\n");
+
+	/* The function can be called with NULL msg */
+	if (!msg) {
+		dev_err(dev, "Message is invalid\n");
+		return;
+	}
+
+	if (IS_ERR(msg)) {
+		dev_err(dev, "Error during reception of message: %ld\n",
+				PTR_ERR(msg));
+		return;
+	}
+
+	header.tag = ((u8 *)msg)[TAG_OFFSET];
+	header.command = ((u8 *)msg)[CMD_OFFSET];
+	header.size = ((u8 *)msg)[SZ_OFFSET];
+	header.ver = ((u8 *)msg)[VER_OFFSET];
+
+	dev_dbg(dev, "Selecting device\n");
+
+	/* Incoming command: wake up the receiver if any. */
+	if (header.tag == priv->cmd_tag) {
+		dev_dbg(dev, "Selecting cmd receiver\n");
+		dev_ctx = priv->cmd_receiver_dev;
+	} else if (header.tag == priv->rsp_tag) {
+		if (priv->waiting_rsp_dev) {
+			dev_dbg(dev, "Selecting rsp waiter\n");
+			dev_ctx = priv->waiting_rsp_dev;
+			is_response = true;
+		} else {
+			/* Reading the EdgeLock Enclave response
+			 * to the command sent by other
+			 * linux kernel services.
+			 */
+			spin_lock(&priv->lock);
+			priv->rx_msg = *(struct ele_api_msg *)msg;
+			complete(&priv->done);
+			spin_unlock(&priv->lock);
+			mutex_unlock(&priv->mu_cmd_lock);
+			return;
+		}
+	} else {
+		dev_err(dev, "Failed to select a device for message: %.8x\n",
+				*((u32 *) &header));
+		return;
+	}
+
+	if (!dev_ctx) {
+		dev_err(dev, "No device context selected for message: %.8x\n",
+				*((u32 *)&header));
+		return;
+	}
+	/* Init reception */
+	msg_size = header.size;
+	if (msg_size > MAX_RECV_SIZE) {
+		devctx_err(dev_ctx, "Message is too big (%d > %d)", msg_size,
+				MAX_RECV_SIZE);
+		return;
+	}
+
+	memcpy(dev_ctx->temp_resp, msg, msg_size * sizeof(u32));
+	dev_ctx->temp_resp_size = msg_size;
+
+	/* Allow user to read */
+	dev_ctx->pending_hdr = dev_ctx->temp_resp[0];
+	wake_up_interruptible(&dev_ctx->wq);
+
+	if (is_response) {
+		priv->waiting_rsp_dev = NULL;
+		mutex_unlock(&priv->mu_cmd_lock);
+	}
+}
+
+static void ele_ping_handler(struct work_struct *work)
+{
+	int ret;
+
+	ret = ele_ping();
+	if (ret)
+		pr_err("ping ele failed, try again!\n");
+
+	/* reschedule the delay work */
+	schedule_delayed_work(to_delayed_work(work), ELE_PING_INTERVAL);
+}
+static DECLARE_DELAYED_WORK(ele_ping_work, ele_ping_handler);
+
+static int imx_soc_device_register(struct platform_device *pdev)
+{
+	struct soc_device_attribute *attr;
+	struct soc_device *dev;
+	struct gen_pool *sram_pool;
+	u32 *get_info_data;
+	phys_addr_t get_info_addr;
+	u32 soc_rev;
+	u32 v[4];
+	int err;
+
+	err = read_common_fuse(OTP_UNIQ_ID, v);
+	if (err)
+		return err;
+
+	sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram-pool", 0);
+	if (!sram_pool) {
+		pr_err("Unable to get sram pool\n");
+		return -EINVAL;
+	}
+
+	get_info_data = (u32 *)gen_pool_alloc(sram_pool, 0x100);
+	if (!get_info_data) {
+		pr_err("Unable to alloc sram from sram pool\n");
+		return -ENOMEM;
+	}
+
+	get_info_addr = gen_pool_virt_to_phys(sram_pool, (ulong)get_info_data);
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	err = ele_get_info(get_info_addr, 23 * sizeof(u32));
+	if (err) {
+		attr->revision = kasprintf(GFP_KERNEL, "A0");
+	} else {
+		soc_rev = (get_info_data[1] & 0xffff0000) >> 16;
+		if (soc_rev == 0xA100)
+			attr->revision = kasprintf(GFP_KERNEL, "A1");
+		else
+			attr->revision = kasprintf(GFP_KERNEL, "A0");
+	}
+
+	gen_pool_free(sram_pool, (unsigned long)get_info_data, 0x100);
+
+	err = of_property_read_string(of_root, "model", &attr->machine);
+	if (err) {
+		kfree(attr);
+		return -EINVAL;
+	}
+	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
+
+	attr->serial_number
+		= kasprintf(GFP_KERNEL, "%016llX", (u64)v[3] << 32 | v[0]);
+	attr->soc_id = kasprintf(GFP_KERNEL, "i.MX8ULP");
+
+	dev = soc_device_register(attr);
+	if (IS_ERR(dev)) {
+		kfree(attr->soc_id);
+		kfree(attr->serial_number);
+		kfree(attr->revision);
+		kfree(attr->family);
+		kfree(attr->machine);
+		kfree(attr);
+		return PTR_ERR(dev);
+	}
+
+	return 0;
+}
+
+static int ele_do_start_rng(void)
+{
+	int ret;
+	int count = ELE_GET_TRNG_STATE_RETRY_COUNT;
+
+	ret = ele_get_trng_state();
+	if (ret < 0) {
+		pr_err("Failed to get trng state\n");
+		return ret;
+	} else if (ret != ELE_TRNG_STATE_OK) {
+		/* call start rng */
+		ret = ele_start_rng();
+		if (ret) {
+			pr_err("Failed to start rng\n");
+			return ret;
+		}
+
+		/* poll get trng state API, ELE_GET_TRNG_STATE_RETRY_COUNT times
+		 * or while trng state != 0x203
+		 */
+		do {
+			msleep(10);
+			ret = ele_get_trng_state();
+			if (ret < 0) {
+				pr_err("Failed to get trng state\n");
+				return ret;
+			}
+			count--;
+		} while ((ret != ELE_TRNG_STATE_OK) && count);
+		if (ret != ELE_TRNG_STATE_OK)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t ele_mu_fops_write(struct file *fp, const char __user *buf,
+				  size_t size, loff_t *ppos)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
+	u32 nb_words = 0;
+	struct mu_hdr header;
+	int err;
+
+	devctx_dbg(dev_ctx, "write from buf (%p)%ld, ppos=%lld\n", buf, size,
+		   ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != MU_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < ELE_MU_HDR_SZ) {
+		devctx_err(dev_ctx, "User buffer too small(%ld < %x)\n",
+			   size, ELE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	if (size > MAX_MESSAGE_SIZE_BYTES) {
+		devctx_err(dev_ctx, "User buffer too big(%ld > %lu)\n", size,
+			   MAX_MESSAGE_SIZE_BYTES);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	/* Copy data to buffer */
+	err = (int)copy_from_user(dev_ctx->temp_cmd, buf, size);
+	if (err) {
+		err = -EFAULT;
+		devctx_err(dev_ctx, "Fail copy message from user\n");
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     dev_ctx->temp_cmd, size, false);
+
+	header = *((struct mu_hdr *) (&dev_ctx->temp_cmd[0]));
+
+	/* Check the message is valid according to tags */
+	if (header.tag == ele_mu_priv->cmd_tag) {
+		/*
+		 * unlocked in ele_mu_receive_work_handler when the
+		 * response to this command is received.
+		 */
+		mutex_lock(&ele_mu_priv->mu_cmd_lock);
+		ele_mu_priv->waiting_rsp_dev = dev_ctx;
+	} else if (header.tag == ele_mu_priv->rsp_tag) {
+		/* Check the device context can send the command */
+		if (dev_ctx != ele_mu_priv->cmd_receiver_dev) {
+			devctx_err(dev_ctx,
+				   "Channel not configured to send resp to FW.");
+			err = -EPERM;
+			goto exit;
+		}
+	} else {
+		devctx_err(dev_ctx, "The message does not have a valid TAG\n");
+		err = -EINVAL;
+		goto exit;
+	}
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	nb_words = header.size;
+	if (nb_words << 2 != size) {
+		devctx_err(dev_ctx, "User buffer too small\n");
+		goto exit;
+	}
+
+	mutex_lock(&ele_mu_priv->mu_lock);
+
+	/* Send message */
+	devctx_dbg(dev_ctx, "sending message\n");
+	err = mbox_send_message(ele_mu_priv->tx_chan, dev_ctx->temp_cmd);
+	if (err < 0) {
+		devctx_err(dev_ctx, "Failed to send message\n");
+		goto unlock;
+	}
+
+	err = nb_words * (u32)sizeof(u32);
+
+unlock:
+	mutex_unlock(&ele_mu_priv->mu_lock);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t ele_mu_fops_read(struct file *fp, char __user *buf,
+				 size_t size, loff_t *ppos)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
+	u32 data_size = 0, size_to_copy = 0;
+	struct ele_obuf_desc *b_desc;
+	int err;
+	struct mu_hdr header;
+
+	devctx_dbg(dev_ctx, "read to buf %p(%ld), ppos=%lld\n", buf, size,
+		   ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != MU_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	/* Wait until the complete message is received on the MU. */
+	err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
+	if (err) {
+		devctx_err(dev_ctx, "Err[0x%x]:Interrupted by signal.\n", err);
+		goto exit;
+	}
+
+	devctx_dbg(dev_ctx, "%s %s\n", __func__,
+		   "message received, start transmit to user");
+
+	/* Check that the size passed as argument is larger than
+	 * the one carried in the message.
+	 */
+	data_size = dev_ctx->temp_resp_size * sizeof(u32);
+	size_to_copy = data_size;
+	if (size_to_copy > size) {
+		devctx_dbg(dev_ctx, "User buffer too small (%ld < %d)\n",
+			   size, size_to_copy);
+		size_to_copy = size;
+	}
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	while (!list_empty(&dev_ctx->pending_out)) {
+		b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+						  struct ele_obuf_desc,
+						  link);
+		if (b_desc->out_usr_ptr && b_desc->out_ptr) {
+			devctx_dbg(dev_ctx, "Copy output data to user\n");
+			err = (int)copy_to_user(b_desc->out_usr_ptr,
+						b_desc->out_ptr,
+						b_desc->out_size);
+			if (err) {
+				devctx_err(dev_ctx,
+					   "Failure copying output data to user.");
+				err = -EFAULT;
+				goto exit;
+			}
+		}
+		__list_del_entry(&b_desc->link);
+		devm_kfree(dev_ctx->dev, b_desc);
+	}
+
+	header = *((struct mu_hdr *) (&dev_ctx->temp_resp[0]));
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     dev_ctx->temp_resp, size_to_copy, false);
+	err = (int)copy_to_user(buf, dev_ctx->temp_resp, size_to_copy);
+	if (err) {
+		devctx_err(dev_ctx, "Failed to copy to user\n");
+		err = -EFAULT;
+		goto exit;
+	}
+
+	err = size_to_copy;
+
+	/* free memory allocated on the shared buffers. */
+	dev_ctx->secure_mem.pos = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	dev_ctx->pending_hdr = 0;
+
+exit:
+
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Give access to EdgeLock Enclave, to the memory we want to share */
+static int ele_mu_setup_ele_mem_access(struct ele_mu_device_ctx *dev_ctx,
+					     u64 addr, u32 len)
+{
+	/* Assuming EdgeLock Enclave has access to all the memory regions */
+	int ret = 0;
+
+	if (ret) {
+		devctx_err(dev_ctx, "Fail find memreg\n");
+		goto exit;
+	}
+
+	if (ret) {
+		devctx_err(dev_ctx, "Fail set permission for resource\n");
+		goto exit;
+	}
+
+exit:
+	return ret;
+}
+
+static int ele_mu_ioctl_get_mu_info(struct ele_mu_device_ctx *dev_ctx,
+				    unsigned long arg)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev_ctx->dev);
+	struct ele_mu_ioctl_get_mu_info info;
+	int err = -EINVAL;
+
+	info.ele_mu_id = (u8)priv->ele_mu_id;
+	info.interrupt_idx = 0;
+	info.tz = 0;
+	info.did = (u8)priv->ele_mu_did;
+
+	devctx_dbg(dev_ctx,
+		   "info [mu_idx: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+		   info.ele_mu_id, info.interrupt_idx, info.tz, info.did);
+
+	err = (int)copy_to_user((u8 *)arg, &info,
+		sizeof(info));
+	if (err) {
+		devctx_err(dev_ctx, "Failed to copy mu info to user\n");
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/*
+ * Copy a buffer of daa to/from the user and return the address to use in
+ * messages
+ */
+static int ele_mu_ioctl_setup_iobuf_handler(struct ele_mu_device_ctx *dev_ctx,
+					    unsigned long arg)
+{
+	struct ele_obuf_desc *out_buf_desc;
+	struct ele_mu_ioctl_setup_iobuf io = {0};
+	struct ele_shared_mem *shared_mem;
+	int err = -EINVAL;
+	u32 pos;
+
+	err = (int)copy_from_user(&io,
+		(u8 *)arg,
+		sizeof(io));
+	if (err) {
+		devctx_err(dev_ctx, "Failed copy iobuf config from user\n");
+		err = -EFAULT;
+		goto exit;
+	}
+
+	devctx_dbg(dev_ctx, "io [buf: %p(%d) flag: %x]\n",
+		   io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* Select the shared memory to be used for this buffer. */
+	if (io.flags & ELE_MU_IO_FLAGS_USE_SEC_MEM) {
+		/* App requires to use secure memory for this buffer.*/
+		devctx_err(dev_ctx, "Failed allocate SEC MEM memory\n");
+		err = -EFAULT;
+		goto exit;
+	} else {
+		/* No specific requirement for this buffer. */
+		shared_mem = &dev_ctx->non_secure_mem;
+	}
+
+	/* Check there is enough space in the shared memory. */
+	if (io.length >= shared_mem->size - shared_mem->pos) {
+		devctx_err(dev_ctx, "Not enough space in shared memory\n");
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	if ((io.flags & ELE_MU_IO_FLAGS_USE_SEC_MEM) &&
+	    !(io.flags & ELE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
+		/*Add base address to get full address.*/
+		devctx_err(dev_ctx, "Failed allocate SEC MEM memory\n");
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (io.flags & ELE_MU_IO_FLAGS_IS_INPUT) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		err = (int)copy_from_user(shared_mem->ptr + pos, io.user_buf,
+					  io.length);
+		if (err) {
+			devctx_err(dev_ctx,
+				   "Failed copy data to shared memory\n");
+			err = -EFAULT;
+			goto exit;
+		}
+		/* flush this memory "shared_mem->ptr + pos"
+		 * with size = io.length
+		 */
+	} else {
+		if (io.flags & ELE_MU_IO_FLAGS_IS_IN_OUT) {
+			err = (int)copy_from_user(shared_mem->ptr + pos,
+						  io.user_buf,
+						  io.length);
+			if (err) {
+				devctx_err(dev_ctx,
+					   "Failed copy data to shared-mem.\n");
+				err = -EFAULT;
+				goto exit;
+			}
+		}
+
+		/*
+		 * buffer is output:
+		 * add an entry in the "pending buffers" list so data
+		 * can be copied to user space when receiving FW
+		 * response.
+		 */
+		out_buf_desc = devm_kmalloc(dev_ctx->dev,
+					    sizeof(*out_buf_desc),
+					    GFP_KERNEL);
+
+		if (!out_buf_desc) {
+			err = -ENOMEM;
+			devctx_err(dev_ctx,
+				   "Failed allocating mem for pending buffer\n"
+				   );
+			goto exit;
+		}
+
+		out_buf_desc->out_ptr = shared_mem->ptr + pos;
+		out_buf_desc->out_usr_ptr = io.user_buf;
+		out_buf_desc->out_size = io.length;
+		list_add_tail(&out_buf_desc->link, &dev_ctx->pending_out);
+	}
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	err = (int)copy_to_user((u8 *)arg, &io,
+		sizeof(io));
+	if (err) {
+		devctx_err(dev_ctx, "Failed to copy iobuff setup to user\n");
+		err = -EFAULT;
+		goto exit;
+	}
+exit:
+	return err;
+}
+
+
+
+/* Open a char device. */
+static int ele_mu_fops_open(struct inode *nd, struct file *fp)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	int err;
+
+	/* Avoid race if opened at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* Authorize only 1 instance. */
+	if (dev_ctx->status != MU_FREE) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
+					MAX_DATA_SIZE_PER_USER,
+					&dev_ctx->non_secure_mem.dma_addr,
+					GFP_KERNEL);
+	if (!dev_ctx->non_secure_mem.ptr) {
+		err = -ENOMEM;
+		devctx_err(dev_ctx, "Failed to map shared memory with S40x\n");
+		goto exit;
+	}
+
+	err = ele_mu_setup_ele_mem_access(dev_ctx,
+					  dev_ctx->non_secure_mem.dma_addr,
+					  MAX_DATA_SIZE_PER_USER);
+	if (err) {
+		err = -EPERM;
+		devctx_err(dev_ctx,
+			   "Failed to share access to shared memory\n");
+		goto free_coherent;
+	}
+
+	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	dev_ctx->non_secure_mem.pos = 0;
+	dev_ctx->status = MU_OPENED;
+
+	dev_ctx->pending_hdr = 0;
+
+	goto exit;
+
+free_coherent:
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a char device. */
+static int ele_mu_fops_close(struct inode *nd, struct file *fp)
+{
+	struct ele_mu_device_ctx *dev_ctx = container_of(fp->private_data,
+					struct ele_mu_device_ctx, miscdev);
+	struct ele_mu_priv *priv = dev_ctx->priv;
+	struct ele_obuf_desc *out_buf_desc;
+
+	/* Avoid race if closed at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* The device context has not been opened */
+	if (dev_ctx->status != MU_OPENED)
+		goto exit;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_dev == dev_ctx)
+		priv->cmd_receiver_dev = NULL;
+
+	/* check if this device was registered as waiting response. */
+	if (priv->waiting_rsp_dev == dev_ctx) {
+		priv->waiting_rsp_dev = NULL;
+		mutex_unlock(&priv->mu_cmd_lock);
+	}
+
+	/* Unmap secure memory shared buffer. */
+	if (dev_ctx->secure_mem.ptr)
+		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
+
+	dev_ctx->secure_mem.ptr = NULL;
+	dev_ctx->secure_mem.dma_addr = 0;
+	dev_ctx->secure_mem.size = 0;
+	dev_ctx->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+	dev_ctx->non_secure_mem.ptr = NULL;
+	dev_ctx->non_secure_mem.dma_addr = 0;
+	dev_ctx->non_secure_mem.size = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	while (!list_empty(&dev_ctx->pending_out)) {
+		out_buf_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+						struct ele_obuf_desc,
+						link);
+		__list_del_entry(&out_buf_desc->link);
+		devm_kfree(dev_ctx->dev, out_buf_desc);
+	}
+
+	dev_ctx->status = MU_FREE;
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return 0;
+}
+
+/* IOCTL entry point of a char device */
+static long ele_mu_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
+	int err = -EINVAL;
+
+	/* Prevent race during change of device context */
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case ELE_MU_IOCTL_ENABLE_CMD_RCV:
+		if (!ele_mu_priv->cmd_receiver_dev) {
+			ele_mu_priv->cmd_receiver_dev = dev_ctx;
+			err = 0;
+		};
+		break;
+	case ELE_MU_IOCTL_GET_MU_INFO:
+		err = ele_mu_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case ELE_MU_IOCTL_SHARED_BUF_CFG:
+		devctx_err(dev_ctx,
+			   "ELE_MU_IOCTL_SHARED_BUF_CFG not supported [0x%x].\n",
+			   err);
+		break;
+	case ELE_MU_IOCTL_SETUP_IOBUF:
+		err = ele_mu_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	case ELE_MU_IOCTL_SIGNED_MESSAGE:
+		devctx_err(dev_ctx,
+			   "ELE_MU_IOCTL_SIGNED_MESSAGE not supported [0x%x].\n",
+			   err);
+		break;
+	default:
+		err = -EINVAL;
+		devctx_dbg(dev_ctx, "IOCTL %.8x not supported\n", cmd);
+	}
+
+	up(&dev_ctx->fops_lock);
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations ele_mu_fops = {
+	.open		= ele_mu_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= ele_mu_fops_close,
+	.unlocked_ioctl = ele_mu_ioctl,
+	.read		= ele_mu_fops_read,
+	.write		= ele_mu_fops_write,
+};
+
+/* interface for managed res to free a mailbox channel */
+static void if_mbox_free_channel(void *mbox_chan)
+{
+	mbox_free_channel(mbox_chan);
+}
+
+/* interface for managed res to unregister a char device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
+static int ele_mu_request_channel(struct device *dev,
+				 struct mbox_chan **chan,
+				 struct mbox_client *cl,
+				 const char *name)
+{
+	struct mbox_chan *t_chan;
+	int ret = 0;
+
+	t_chan = mbox_request_channel_byname(cl, name);
+	if (IS_ERR(t_chan)) {
+		ret = PTR_ERR(t_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev,
+				"Failed to request chan %s ret %d\n", name,
+				ret);
+		goto exit;
+	}
+
+	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
+	if (ret) {
+		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
+		goto exit;
+	}
+
+	*chan = t_chan;
+
+exit:
+	return ret;
+}
+
+static int ele_mu_probe(struct platform_device *pdev)
+{
+	struct ele_mu_device_ctx *dev_ctx;
+	struct device *dev = &pdev->dev;
+	struct ele_mu_priv *priv;
+	struct device_node *np;
+	const struct of_device_id *of_id = of_match_device(ele_mu_match, dev);
+	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
+						: NULL;
+	int max_nb_users = 0;
+	char *devname;
+	int ret;
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		dev_err(dev, "Fail allocate mem for private data\n");
+		goto exit;
+	}
+	priv->dev = dev;
+	dev_set_drvdata(dev, priv);
+
+	/*
+	 * Get the address of MU to be used for communication with the SCU
+	 */
+	np = pdev->dev.of_node;
+	if (!np) {
+		dev_err(dev, "Cannot find MU User entry in device tree\n");
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	/* Initialize the mutex. */
+	mutex_init(&priv->mu_cmd_lock);
+	mutex_init(&priv->mu_lock);
+
+	/* TBD */
+	priv->cmd_receiver_dev = NULL;
+	priv->waiting_rsp_dev = NULL;
+
+	ret = of_property_read_u32(np, "fsl,ele_mu_did", &priv->ele_mu_did);
+	if (ret) {
+		ret = -EINVAL;
+		dev_err(dev, "%s: Not able to read ele_mu_did", __func__);
+		goto exit;
+	}
+
+	ret = of_property_read_u32(np, "fsl,ele_mu_id", &priv->ele_mu_id);
+	if (ret) {
+		ret = -EINVAL;
+		dev_err(dev, "%s: Not able to read ele_mu_id", __func__);
+		goto exit;
+	}
+
+	ret = of_property_read_u32(np, "fsl,ele_mu_max_users", &max_nb_users);
+	if (ret) {
+		dev_warn(dev, "%s: Not able to read mu_max_user", __func__);
+		max_nb_users = S4_MUAP_DEFAULT_MAX_USERS;
+	}
+
+	ret = of_property_read_u8(np, "fsl,cmd_tag", &priv->cmd_tag);
+	if (ret) {
+		dev_warn(dev, "%s: Not able to read cmd_tag", __func__);
+		priv->cmd_tag = DEFAULT_MESSAGING_TAG_COMMAND;
+	}
+
+	ret = of_property_read_u8(np, "fsl,rsp_tag", &priv->rsp_tag);
+	if (ret) {
+		dev_warn(dev, "%s: Not able to read rsp_tag", __func__);
+		priv->rsp_tag = DEFAULT_MESSAGING_TAG_RESPONSE;
+	}
+
+	/* Mailbox client configuration */
+	priv->ele_mb_cl.dev		= dev;
+	priv->ele_mb_cl.tx_block	= false;
+	priv->ele_mb_cl.knows_txdone	= true;
+	priv->ele_mb_cl.rx_callback	= ele_mu_rx_callback;
+
+	ret = ele_mu_request_channel(dev, &priv->tx_chan,
+				     &priv->ele_mb_cl, "tx");
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request tx channel\n");
+
+		goto exit;
+	}
+
+	ret = ele_mu_request_channel(dev, &priv->rx_chan,
+				     &priv->ele_mb_cl, "rx");
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request rx channel\n");
+
+		goto exit;
+	}
+
+	priv->max_dev_ctx = max_nb_users;
+	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * max_nb_users,
+				  GFP_KERNEL);
+
+	/* Create users */
+	for (i = 0; i < max_nb_users; i++) {
+		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
+		if (!dev_ctx) {
+			ret = -ENOMEM;
+			dev_err(dev,
+				"Fail to allocate memory for device context\n");
+			goto exit;
+		}
+
+		dev_ctx->dev = dev;
+		dev_ctx->status = MU_FREE;
+		dev_ctx->priv = priv;
+
+		priv->ctxs[i] = dev_ctx;
+
+		/* Default value invalid for an header. */
+		init_waitqueue_head(&dev_ctx->wq);
+
+		INIT_LIST_HEAD(&dev_ctx->pending_out);
+		sema_init(&dev_ctx->fops_lock, 1);
+
+		devname = devm_kasprintf(dev, GFP_KERNEL, "ele_mu%d_ch%d",
+					 priv->ele_mu_id, i);
+		if (!devname) {
+			ret = -ENOMEM;
+			dev_err(dev,
+				"Fail to allocate memory for misc dev name\n");
+			goto exit;
+		}
+
+		dev_ctx->miscdev.name = devname;
+		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
+		dev_ctx->miscdev.fops = &ele_mu_fops;
+		dev_ctx->miscdev.parent = dev;
+		ret = misc_register(&dev_ctx->miscdev);
+		if (ret) {
+			dev_err(dev, "failed to register misc device %d\n",
+				ret);
+			goto exit;
+		}
+
+		ret = devm_add_action(dev, if_misc_deregister,
+				      &dev_ctx->miscdev);
+		if (ret) {
+			dev_err(dev,
+				"failed[%d] to add action to the misc-dev\n",
+				ret);
+			goto exit;
+		}
+	}
+
+	init_completion(&priv->done);
+	spin_lock_init(&priv->lock);
+
+	ele_priv_export = priv;
+
+	if (info && info->reserved_dma_ranges) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret) {
+			dev_err(dev,
+				"failed to init reserved memory region %d\n",
+				ret);
+			priv->flags &= (~RESERVED_DMA_POOL);
+			goto exit;
+		}
+		priv->flags |= RESERVED_DMA_POOL;
+	}
+
+	if (info && info->socdev) {
+		ret = imx_soc_device_register(pdev);
+		if (ret) {
+			dev_err(dev,
+				"failed[%d] to register SoC device\n", ret);
+			goto exit;
+		}
+
+		/* allocate buffer where ELE store encrypted IMEM */
+		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
+						     &priv->imem.phyaddr,
+						     GFP_KERNEL);
+		if (!priv->imem.buf) {
+			dev_err(dev,
+				"Failed dmam-alloc to store encrypted IMEM.\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+	}
+
+	/* start ele rng */
+	ret = ele_do_start_rng();
+	if (ret)
+		dev_err(dev, "Failed to start ele rng\n");
+
+	if (!ret && info && info->enable_ele_trng) {
+		ret = ele_trng_init(dev);
+		if (ret)
+			dev_err(dev, "Failed to init ele-trng\n");
+	}
+
+	/*
+	 * A ELE ping request must be send at least once every day(24 hours),
+	 * so setup a delay work with 1 hour interval
+	 * to ping ELE periodically.
+	 */
+	schedule_delayed_work(&ele_ping_work, ELE_PING_INTERVAL);
+
+	dev_set_drvdata(dev, priv);
+	return devm_of_platform_populate(dev);
+
+exit:
+	/* if execution control reaches here, ele-mu probe fail.
+	 * hence doing the cleanup
+	 */
+	if (priv->flags & RESERVED_DMA_POOL) {
+		of_reserved_mem_device_release(dev);
+		priv->flags &= (~RESERVED_DMA_POOL);
+	}
+	return ret;
+}
+
+static int ele_mu_remove(struct platform_device *pdev)
+{
+	struct ele_mu_priv *priv;
+
+	cancel_delayed_work_sync(&ele_ping_work);
+	priv = dev_get_drvdata(&pdev->dev);
+	mbox_free_channel(priv->tx_chan);
+	mbox_free_channel(priv->rx_chan);
+
+	/* free the buffer in ele-mu remove, previously allocated
+	 * in ele-mu probe to store encrypted IMEM
+	 */
+	if (priv->imem.buf) {
+		dmam_free_coherent(&pdev->dev,
+				   ELE_IMEM_SIZE,
+				   priv->imem.buf,
+				   priv->imem.phyaddr);
+		priv->imem.buf = NULL;
+	}
+
+	if (priv->flags & RESERVED_DMA_POOL) {
+		of_reserved_mem_device_release(&pdev->dev);
+		priv->flags &= (~RESERVED_DMA_POOL);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ele_mu_suspend(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	const struct of_device_id *of_id = of_match_device(ele_mu_match, dev);
+	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
+						: NULL;
+
+	if (info && info->socdev) {
+		int ret;
+
+		/* EXPORT command will save encrypted IMEM to given address,
+		 * so later in resume, IMEM can be restored from the given
+		 * address.
+		 *
+		 * Size must be at least 64 kB.
+		 */
+		ret = ele_service_swap(priv->imem.phyaddr,
+				       ELE_IMEM_SIZE,
+				       ELE_IMEM_EXPORT);
+		if (ret < 0)
+			dev_err(dev, "Failed to export IMEM\n");
+		else {
+			priv->imem.size = ret;
+			dev_info(dev,
+				 "Exported %d bytes of encrypted IMEM\n",
+				 ret);
+		}
+	}
+
+	return 0;
+}
+
+static int ele_mu_resume(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int i;
+	const struct of_device_id *of_id = of_match_device(ele_mu_match, dev);
+	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
+						: NULL;
+
+	for (i = 0; i < priv->max_dev_ctx; i++)
+		wake_up_interruptible(&priv->ctxs[i]->wq);
+
+	if (info && info->socdev) {
+		struct gen_pool *sram_pool;
+		u32 *get_info_buf;
+		phys_addr_t get_info_phyaddr;
+		u32 imem_state;
+		int ret;
+
+		ret = ele_do_start_rng();
+		if (ret)
+			return ret;
+
+		/* allocate buffer to get info from ELE */
+		sram_pool = of_gen_pool_get(dev->of_node, "sram-pool", 0);
+		if (!sram_pool) {
+			dev_err(dev, "Unable to get sram pool\n");
+			return -EINVAL;
+		}
+
+		get_info_buf = (u32 *)gen_pool_alloc(sram_pool,
+						     ELE_GET_INFO_BUFF_SZ);
+		if (!get_info_buf) {
+			dev_err(dev, "Unable to alloc sram from sram pool\n");
+			return -ENOMEM;
+		}
+		get_info_phyaddr = gen_pool_virt_to_phys(sram_pool,
+							 (ulong)get_info_buf);
+
+		/* get info from ELE */
+		ret = ele_get_info(get_info_phyaddr, ELE_GET_INFO_READ_SZ);
+		if (ret) {
+			dev_err(dev, "Failed to get info from ELE.\n");
+			goto exit;
+		}
+
+		/* Get IMEM state, if 0xFE then import IMEM */
+		imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
+				& ELE_IMEM_STATE_MASK) >> 16;
+		if (imem_state == ELE_IMEM_STATE_BAD) {
+			/* IMPORT command will restore IMEM from the given
+			 * address, here size is the actual size returned by ELE
+			 * during the export operation
+			 */
+			ret = ele_service_swap(priv->imem.phyaddr,
+					       priv->imem.size,
+					       ELE_IMEM_IMPORT);
+			if (ret) {
+				dev_err(dev, "Failed to import IMEM\n");
+				goto exit;
+			}
+		} else
+			goto exit;
+
+		/* After importing IMEM, check if IMEM state is equal to 0xCA
+		 * to ensure IMEM is fully loaded and
+		 * ELE functionality can be used.
+		 */
+		ret = ele_get_info(get_info_phyaddr, ELE_GET_INFO_READ_SZ);
+		if (ret) {
+			dev_err(dev, "Failed to get info from ELE.\n");
+			goto exit;
+		}
+
+		imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
+				& ELE_IMEM_STATE_MASK) >> 16;
+		if (imem_state == ELE_IMEM_STATE_OK)
+			dev_info(dev, "Successfully restored IMEM\n");
+		else
+			dev_err(dev, "Failed to restore IMEM\n");
+
+exit:
+	gen_pool_free(sram_pool, (ulong)get_info_buf, ELE_GET_INFO_BUFF_SZ);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops ele_mu_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(ele_mu_suspend, ele_mu_resume)
+};
+
+static struct platform_driver ele_mu_driver = {
+	.driver = {
+		.name = "fsl-ele-mu",
+		.of_match_table = ele_mu_match,
+		.pm = &ele_mu_pm,
+	},
+	.probe = ele_mu_probe,
+	.remove = ele_mu_remove,
+};
+MODULE_DEVICE_TABLE(of, ele_mu_match);
+
+module_platform_driver(ele_mu_driver);
+
+MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
+MODULE_DESCRIPTION("iMX Secure Enclave MU Driver.");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/imx/ele_mu.h b/drivers/firmware/imx/ele_mu.h
new file mode 100644
index 000000000000..371a3c635f50
--- /dev/null
+++ b/drivers/firmware/imx/ele_mu.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2022 NXP
+ */
+
+#ifndef ELE_MU_H
+#define ELE_MU_H
+
+#include <linux/miscdevice.h>
+#include <linux/semaphore.h>
+#include <linux/mailbox_client.h>
+
+/* macro to log operation of a misc device */
+#define miscdev_dbg(p_miscdev, fmt, va_args...)                                \
+	({                                                                     \
+		struct miscdevice *_p_miscdev = p_miscdev;                     \
+		dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
+		##va_args);                                                    \
+	})
+
+#define miscdev_info(p_miscdev, fmt, va_args...)                               \
+	({                                                                     \
+		struct miscdevice *_p_miscdev = p_miscdev;                     \
+		dev_info((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name, \
+		##va_args);                                                    \
+	})
+
+#define miscdev_err(p_miscdev, fmt, va_args...)                                \
+	({                                                                     \
+		struct miscdevice *_p_miscdev = p_miscdev;                     \
+		dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
+		##va_args);                                                    \
+	})
+/* macro to log operation of a device context */
+#define devctx_dbg(p_devctx, fmt, va_args...) \
+	miscdev_dbg(&((p_devctx)->miscdev), fmt, ##va_args)
+#define devctx_info(p_devctx, fmt, va_args...) \
+	miscdev_info(&((p_devctx)->miscdev), fmt, ##va_args)
+#define devctx_err(p_devctx, fmt, va_args...) \
+	miscdev_err((&(p_devctx)->miscdev), fmt, ##va_args)
+
+#define MSG_TAG(x)			(((x) & 0xff000000) >> 24)
+#define MSG_COMMAND(x)			(((x) & 0x00ff0000) >> 16)
+#define MSG_SIZE(x)			(((x) & 0x0000ff00) >> 8)
+#define MSG_VER(x)			((x) & 0x000000ff)
+#define RES_STATUS(x)			((x) & 0x000000ff)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
+#define S4_DEFAULT_MUAP_INDEX		(2)
+#define S4_MUAP_DEFAULT_MAX_USERS	(4)
+
+#define DEFAULT_MESSAGING_TAG_COMMAND           (0x17u)
+#define DEFAULT_MESSAGING_TAG_RESPONSE          (0xe1u)
+
+//#define ELE_MU_IO_FLAGS_IS_INPUT	(0x01u)
+//#define ELE_MU_IO_FLAGS_IS_OUTPUT	(0x02u)
+//#define ELE_MU_IO_FLAGS_IS_IN_OUT	(0x08u)
+
+#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
+#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
+
+struct ele_imem_buf {
+	u8 *buf;
+	phys_addr_t phyaddr;
+	u32 size;
+};
+
+struct ele_obuf_desc {
+	u8 *out_ptr;
+	u8 *out_usr_ptr;
+	u32 out_size;
+	struct list_head link;
+};
+
+/* Status of a char device */
+enum mu_device_status_t {
+	MU_FREE,
+	MU_OPENED
+};
+
+struct ele_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+/* Private struct for each char device instance. */
+struct ele_mu_device_ctx {
+	struct device *dev;
+	struct ele_mu_priv *priv;
+	struct miscdevice miscdev;
+
+	enum mu_device_status_t status;
+	wait_queue_head_t wq;
+	struct semaphore fops_lock;
+
+	u32 pending_hdr;
+	struct list_head pending_out;
+
+	struct ele_shared_mem secure_mem;
+	struct ele_shared_mem non_secure_mem;
+
+	u32 temp_cmd[MAX_MESSAGE_SIZE];
+	u32 temp_resp[MAX_RECV_SIZE];
+	u32 temp_resp_size;
+	struct notifier_block ele_notify;
+};
+
+/* Header of the messages exchange with the EdgeLock Enclave */
+struct mu_hdr {
+	u8 ver;
+	u8 size;
+	u8 command;
+	u8 tag;
+}  __packed;
+
+#define ELE_MU_HDR_SZ	4
+#define TAG_OFFSET	(ELE_MU_HDR_SZ - 1)
+#define CMD_OFFSET	(ELE_MU_HDR_SZ - 2)
+#define SZ_OFFSET	(ELE_MU_HDR_SZ - 3)
+#define VER_OFFSET	(ELE_MU_HDR_SZ - 4)
+
+struct ele_api_msg {
+	u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
+	u32 data[ELE_MSG_DATA_NUM];
+};
+
+struct ele_mu_priv {
+	struct ele_mu_device_ctx *cmd_receiver_dev;
+	struct ele_mu_device_ctx *waiting_rsp_dev;
+	/*
+	 * prevent parallel access to the MU registers
+	 * e.g. a user trying to send a command while the other one is
+	 * sending a response.
+	 */
+	struct mutex mu_lock;
+	/*
+	 * prevent a command to be sent on the MU while another one is still
+	 * processing. (response to a command is allowed)
+	 */
+	struct mutex mu_cmd_lock;
+	struct device *dev;
+	u32 ele_mu_did;
+	u32 ele_mu_id;
+	u8 cmd_tag;
+	u8 rsp_tag;
+
+	struct mbox_client ele_mb_cl;
+	struct mbox_chan *tx_chan, *rx_chan;
+	struct ele_api_msg tx_msg, rx_msg;
+	struct completion done;
+	spinlock_t lock;
+	/* Flag to retain the state of initialization done at
+	 * the time of ele-mu probe.
+	 */
+	int flags;
+	int max_dev_ctx;
+	struct ele_mu_device_ctx **ctxs;
+	struct ele_imem_buf imem;
+};
+
+int get_ele_mu_priv(struct ele_mu_priv **export);
+
+int imx_ele_msg_send_rcv(struct ele_mu_priv *priv);
+#ifdef CONFIG_IMX_ELE_TRNG
+int ele_trng_init(struct device *dev);
+#else
+static inline int ele_trng_init(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
new file mode 100644
index 000000000000..04a8797b5468
--- /dev/null
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021 NXP
+ *
+ * Header file for the ELE Base API(s).
+ */
+
+#ifndef ELE_BASE_MSG_H
+#define ELE_BASE_MSG_H
+
+#include <linux/types.h>
+
+#define MAX_RECV_SIZE			31
+#define MAX_RECV_SIZE_BYTES		(MAX_RECV_SIZE * sizeof(u32))
+#define MAX_MESSAGE_SIZE		31
+#define MAX_MESSAGE_SIZE_BYTES		(MAX_MESSAGE_SIZE * sizeof(u32))
+
+#define MESSAGING_VERSION_7		0x7
+#define ELE_NONE_VAL			0x0
+
+#define ELE_PING_REQ			0x1
+#define ELE_PING_REQ_MSG_SZ		0x02
+
+#define ELE_OEM_CNTN_AUTH_REQ		0x87
+#define ELE_VERIFY_IMAGE_REQ		0x88
+#define ELE_RELEASE_CONTAINER_REQ	0x89
+
+#define ELE_READ_FUSE_REQ		0x97
+#define ELE_READ_FUSE_RSP_MSG_SZ	0x07
+#define ELE_READ_FUSE_REQ_MSG_SZ	0x03
+
+#define OTP_UNIQ_ID			0x01
+#define OTFAD_CONFIG			0x2
+
+#define ELE_GET_INFO_REQ                0xDA
+#define ELE_GET_INFO_REQ_MSG_SZ		0x02
+
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x03
+
+#define ELE_START_RNG_REQ		0xA3
+#define ELE_START_RNG_REQ_MSG_SZ	0x02
+
+#define ELE_GET_TRNG_STATE_REQ		0xA4
+#define ELE_GET_TRNG_STATE_REQ_MSG_SZ	0x03
+
+#define ELE_GET_RANDOM_REQ		0xCD
+#define CSAL_TRNG_STATE_MASK		0x0000ffff
+
+#define ELE_BASE_API_VERSION		0x6
+#define ELE_SUCCESS_IND			0xD6
+#define ELE_FAILURE_IND			0x29
+
+#define ELE_MSG_DATA_NUM		10
+
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
+int read_common_fuse(uint16_t fuse_index, u32 *value);
+int ele_ping(void);
+int ele_get_info(phys_addr_t addr, u32 data_size);
+int ele_service_swap(phys_addr_t addr, u32 addr_size, u16 flag);
+int ele_start_rng(void);
+int ele_get_trng_state(void);
+
+#endif
diff --git a/include/linux/firmware/imx/ele_mu_ioctl.h b/include/linux/firmware/imx/ele_mu_ioctl.h
new file mode 100644
index 000000000000..3ad93ded23ed
--- /dev/null
+++ b/include/linux/firmware/imx/ele_mu_ioctl.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2019-2022 NXP
+ */
+
+#ifndef ELE_MU_IOCTL_H
+#define ELE_MU_IOCTL_H
+
+/* IOCTL definitions. */
+
+struct ele_mu_ioctl_setup_iobuf {
+	u8 *user_buf;
+	u32 length;
+	u32 flags;
+	u64 ele_addr;
+};
+
+struct ele_mu_ioctl_shared_mem_cfg {
+	u32 base_offset;
+	u32 size;
+};
+
+struct ele_mu_ioctl_get_mu_info {
+	u8 ele_mu_id;
+	u8 interrupt_idx;
+	u8 tz;
+	u8 did;
+};
+
+struct ele_mu_ioctl_signed_message {
+	u8 *message;
+	u32 msg_size;
+	u32 error_code;
+};
+
+#define ELE_MU_IO_FLAGS_IS_OUTPUT	(0x00u)
+#define ELE_MU_IO_FLAGS_IS_INPUT	(0x01u)
+#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
+#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define ELE_MU_IO_FLAGS_IS_IN_OUT	(0x08u)
+
+#define ELE_MU_IOCTL			0x0A /* like MISC_MAJOR. */
+#define ELE_MU_IOCTL_ENABLE_CMD_RCV	_IO(ELE_MU_IOCTL, 0x01)
+#define ELE_MU_IOCTL_SHARED_BUF_CFG	_IOW(ELE_MU_IOCTL, 0x02, \
+					struct ele_mu_ioctl_shared_mem_cfg)
+#define ELE_MU_IOCTL_SETUP_IOBUF	_IOWR(ELE_MU_IOCTL, 0x03, \
+					struct ele_mu_ioctl_setup_iobuf)
+#define ELE_MU_IOCTL_GET_MU_INFO	_IOR(ELE_MU_IOCTL, 0x04, \
+					struct ele_mu_ioctl_get_mu_info)
+#define ELE_MU_IOCTL_SIGNED_MESSAGE	_IOWR(ELE_MU_IOCTL, 0x05, \
+					struct ele_mu_ioctl_signed_message)
+#endif
-- 
2.34.1

