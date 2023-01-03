Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FBE65C069
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbjACNEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjACNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:04:03 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB7B7F7;
        Tue,  3 Jan 2023 05:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6saad0fcXecEhuraJUza9T/j+Rr46hbNFbwdcIJ8GJ+ICXdntiO3Zwk9/Cqnyac6o2LtkzdEYzV4yzLlaAUm7Q+11Q72dw6CXBmosS75LccAZRraeLIDX5RkFow9tRbx5hTN3db7H4XgfgcfNBbMaWjekviPEJkVFSUButHXvOlJcqCy60MtndbpL1YUp26bczEM+Y/yG2/JVxo/g16ob0rHmYproao9IFtHNm+DS1LHW8P7LZkxfb9sAsKciLtRkckPAMBJL1Jx4+oCpa+Gy38PPpdBfL13os2G3/U0xdosmQxzFVU9u1ICsNSq4tf8jVq017ZMQybpxk7We+hnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMbv2aWhZNgg0Q18/dEAgvVAidj3D92TKktzPh4G2OI=;
 b=dVVI49IiYcxMT+v2GnWGd8AZiucyLAf3l+fqIdMZbMnRrB4Hw4lX+frVNXwpPdXL64XWqMbZTPPTzbna9aCvfk3Ls3P6BFh1HGcAJrLq2ORSuYPcTIPMtx550asdSvH5ZWLGPlMs+ofmlI2kCH9Tw0QK1fmhIBVcaMTd18Beyu5gPTz7haDQnhj/jWk5sPLiKB0kKA+bm6RXSI9/vyOHkKPLFUVU9emIf/8nSqPLWPoyWRX1aW+fdIvqqCEb0Xqke3ROyc1q99GNpe57RhK+969KVH6b50t4Fayde4Frx7ixkphPrqUBVfAjVbcLw5iJJni1EZQ8tgwxBSjx0KkROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMbv2aWhZNgg0Q18/dEAgvVAidj3D92TKktzPh4G2OI=;
 b=lbd5LExACul34MvqfI3vAypg12g0spLDlmd61IF3LOpFO4SZ1OOX1QItdfHfkFSGMDvFzg1+RA0f62GX7EBKMxHTsv5l1fVj9vIZTk8bCfH/uDCqPfu/ZWkB9cv5ge60iqDzqrHIbNBGKH2iYSWSPGmqSXE4euY6gwe95LKSFjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:03:59 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 13:03:59 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix build when CONFIG_IIO_TRIGGERED_BUFFER=m
Date:   Tue,  3 Jan 2023 15:03:48 +0200
Message-Id: <20230103130348.1733467-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BEXP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::27)
 To VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AM8PR04MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 2034c5ce-c4dd-44d3-ae95-08daed8afa8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/ajFQlk/0leblkCsLYRM9VGbOIB0QS1j+xZUEmPyJDcJ/bztAZ9c9FyYHiH1oKBj/HX1hezoZ8LmoDr1giS5Vx7JIL6+N5LcbyA7A9wD/9tzyyzmzVM/SgAUxLpuKXXtroY3lCxSuN3l20POsIjMy0soxnxVXyz/6k1UDkeCoCXQ8OJAigNx0IJl6J0YEzyvo2/6+pDASUtpuM/Y2kbRcuV5O3XJKdBpCK+QxUIqbuBpwhv5u6GaXsT2uPbTOcOv0eTOeJLG6MCvCTRUuXtwWUgL3vd/gy8qE6FmgVskAqtDuUDrJL3sbscenrqk4tco3vpbMjvCNQKQoYYtn0OX7x5e/AjQPTCKoMzFLbiemfVbsfZyEuu296Aw0GDeBFu7wkVd2SixyH/rEhOXiygia6JfD63O/CCSqHByIPmMcoeuMSZ2dO9D8L/hFTF5LeiHfmAg1HrxGU01NZXyoQtTBjT9757aapwIaIIcwr50NsMLkm2jkIk0pbLDAA+uVd80afedTfQyVNLF13K3O8U09kbkybXkL8XcCGQOcVKBtvDeVd+y1Eew+q1TWWNNcVUrVuIORG5wl13H6QQrUThBac1snfYrP7bFC2+dDKJkMP1VKd34SXnuEj3A4Uc1ilaleW033Ya62n2+PGmxxNZ6aH1/nEhM6l1Wpn0iA2n5lWii0Uoo8WI/wJjMl79kU2kLXoRStSUVA5/wTeMKoiXrt2J+iZbu6V2qhnSqpr/V4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(1076003)(6512007)(26005)(6666004)(6506007)(86362001)(36756003)(38350700002)(38100700002)(2616005)(186003)(478600001)(41300700001)(4326008)(8676002)(2906002)(5660300002)(44832011)(8936002)(6486002)(52116002)(66556008)(66946007)(66476007)(54906003)(316002)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lMc+ZcL5aSpWWoB48VfejPhDLHi8uodQyMdJCeTE0ZSyaIy6wgrIeHX7ckrn?=
 =?us-ascii?Q?8O2x49TX5a8o11fYcLOzzl3MtvIDHiR4hBf495IGvV/i5fNEsUG3+c6MUkX3?=
 =?us-ascii?Q?AlupYBobFOmO4esKpq4jVot4TXhm1POoysAjuFy64dtw6IRl8Sb//hksSvrW?=
 =?us-ascii?Q?bVmZ5mWWc6DBhjppRCrzySd/f02/8dD3j8udNZ0/0r2G3FBufXDHc2HHqwQO?=
 =?us-ascii?Q?7YFQA+now9yleBK3mqEKg/p4/ROXEUyaBYPCbG7CJE8yzZ/O0TZkWCFmYgL1?=
 =?us-ascii?Q?aaUL1MIxvMEv/+ZjLMzLA50DeKF5+JsKJtxbTWYWNuq/HeO3kiOzJKeMTl/t?=
 =?us-ascii?Q?AjyYgcjS7MQVaslKh9MNJjeyM1jrpijj3HFVLrFvQC8gACrYRS/vqhZxQ2SM?=
 =?us-ascii?Q?ZG+zOY9HsiTzrbMTZBo2uwwYt6Sccd1/gdzO2cplDwe6p9UEuvKwEYKqvkjo?=
 =?us-ascii?Q?rj9QME4SFPTqWrG6uDpt9x6reP6x4DXYmk7PlxrmlFxv745Z535Ji5KN+fVD?=
 =?us-ascii?Q?YyOZIoxov3wavZFAywpKrEvf6GSQleM1y3/vZ4WrDfivECj4b3NzHopQZWM8?=
 =?us-ascii?Q?4aFIzpQqQBeotFJPvUaFXdrnf5Y6tDnJaA+dsLXAzIMfoAaKV2P7HZMEMKlE?=
 =?us-ascii?Q?40Vgwa90jupMDjKeoZfOp1mVHg8e+sNuwSmZVnLm5943Sw5aPNxZ8HYZbkCs?=
 =?us-ascii?Q?NLZAOaAfuS8wIhqLbqmqsUq7BjVsSQe9ttHqgCYXg2lDgNOEl500Gr4c/G+m?=
 =?us-ascii?Q?4LmE1DQKfNyl9Gq8fG5KUH80Zt2QlBiKYPwMupd8xVSbiSlEn2ic7GMcVGzn?=
 =?us-ascii?Q?A9voSWD4Bf9mtc6OS9IKdrbnh796nS+H408uuIJB6BOm64uYNt/TomemlpoT?=
 =?us-ascii?Q?fLD2C2/DanscYrhbZq5ywcctEMa/lgWno1Ap6klX+JSIrADjXDYYzvK6HPgN?=
 =?us-ascii?Q?SBv+4cmrkCBd9fyc/b7BzQHHDVEVtH6Khn4dDDMl5rQ786AfqBlHUaV50l+1?=
 =?us-ascii?Q?C4kTPlSb4aEjQZ/PncPhLeo74wOLAp+SaCD1n8dPbdq4EVmddxKikGuOkmJQ?=
 =?us-ascii?Q?SscnPg1+fUC89nQmYMH8btwXuH/RUmzabCC2mpVxw4OaX0CA+jA3PDXZOWwY?=
 =?us-ascii?Q?+fuOxUN1WRUnjhW+LnOnNl4J2iHvZvCkrtXcYf4x1AnU+FRm8Co+eZ/A/08t?=
 =?us-ascii?Q?iK/CR6wGYJ/KdiDtXeeA1HV/sSRnaZ5zCu+2HAiRj7IDmGZwgorSkyv8bbR/?=
 =?us-ascii?Q?yOKcc9U+Uedw+EUXoGZ2LMlb7PMRkSS+KxP515kpXRqZ2HjWhSaPTj5SPYFL?=
 =?us-ascii?Q?KtqAdeX3g1nxnjHe416gfJeseIdNK7pVfpxwzqzPminr9WF/y40ssRcvtzCW?=
 =?us-ascii?Q?R4GDEA02809dPam+WCohAKiWTSqhjzaT91pcP+gXMpRLuAm7GFLJzIWC9oON?=
 =?us-ascii?Q?yZLxgxic0DuwKh3v7gj49warDpssNlQELGjdu9FIoxQ6RjrU0Pu0Go6jmKgi?=
 =?us-ascii?Q?KAczDUiYr55+W9uybGBpxsja/B6WqK/WNiQIFM8wy7mywfHfvZd0imHC28NB?=
 =?us-ascii?Q?k92wCAbUW5rLdkJb0oilZGLZPmgGWm6cnVg7L/4mgsboVvur4eLW4S0G3lcW?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2034c5ce-c4dd-44d3-ae95-08daed8afa8d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 13:03:59.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6cQZ7x9xgtBrcapRbqrFsBREaxWhcEhKbscRTHaufouRldyqmq3utUY/iM2nJXndA7W0vlp0Lo7Ep5PvG8yXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following kernel linkage error:

st_lsm6dsx_core.o: in function `st_lsm6dsx_sw_buffers_setup':
st_lsm6dsx_core.c:2578: undefined reference to `devm_iio_triggered_buffer_setup_ext'

is caused by the fact that the object owning devm_iio_triggered_buffer_setup_ext()
(drivers/iio/buffer/industrialio-triggered-buffer.o) is allowed to be
built as module when its user (drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c)
is built-in.

The st_lsm6dsx driver already has a "select IIO_BUFFER", so add another
select for IIO_TRIGGERED_BUFFER, to make that option follow what is set
for the st_lsm6dsx driver. This is similar to what other iio drivers do.

Fixes: 2cfb2180c3e8 ("iio: imu: st_lsm6dsx: introduce sw trigger support")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index f6660847fb58..8c16cdacf2f2 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -4,6 +4,7 @@ config IIO_ST_LSM6DSX
 	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
 	depends on (I2C || SPI || I3C)
 	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select IIO_KFIFO_BUF
 	select IIO_ST_LSM6DSX_I2C if (I2C)
 	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
-- 
2.34.1

