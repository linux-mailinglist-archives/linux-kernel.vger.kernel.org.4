Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9E67DFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjA0JV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjA0JVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:21:50 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FA783E3;
        Fri, 27 Jan 2023 01:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICtUV7QDI0N+AFjVkirGs/Ovdp5edeYe7i2SLXBMYATCIMRimhpNkCvYvtGG86qxWEWDQSZVfg5Z0kO8FhtOiXQwSCIkJFfvycH9IdNUCCtpXMsKkCvxqplq3gg3PGgXp17N3mPdM8aoZmYEj7/cJu+e5tZ+SYvYvbJu4M58tbgNOYdsshYu59SMye4DRqjYF69aTC2CoCKaKWuNE8DH+FpyhgBApXu+7dub28P6HT8pFURxZXLjMtrZQjvWdQTzF91JXn5zphMdwHbqqxtJa+xraR3rRm4Ti2h50hmMq3LQum2gt8ExtDCS09xFZ5d73w9GMTzmsm46NdSrvwqT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSPoFCp1WU1ODs5miVRwkzxQHfokDiDO6FyQQnFZ4VI=;
 b=aRYbkXJIdhWQ+Wzcdb4XmufV1Q3zd95zo7Sbqxcd24o3nSgfG/PTIaC41mIsqKLH2pePBK60ip7o7W1YIlzgImQW94lEOZlE5YpGljheq82P4/SxnA/zIECTMgSNbRKcJYzCCVhjwManln4vuwacj6CJSsSBb/c0DuGFy0w4to6uYH9VnzyZDt+7nHTKc2Kyvw2JQkB16aCRkSD3SnUxNCoAC8sIiMGMvmIJRqTFUvoBzC7P8myePJB55HpGPeUzvx2vIo+TsyZpxoe2STxp7t+pQ2CzDXcAG5ZumbM3XSTj9Ww+8Kwk17V34gVVzYTSWw0N2kWBMJny/O6RaSeq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSPoFCp1WU1ODs5miVRwkzxQHfokDiDO6FyQQnFZ4VI=;
 b=ej+GT+26g990fJAdEPqm2iQ9GmSPSQ1nKojOaEZL+7L2q14nNry0/it0SuqCR7rjyqW0FxzJFWkq2Tz11rZ6+WfqR2VYTNmQDnZ8TkjBPEat+mXuWu/7tJGxf5b9ozvLRCtkJd+j4oTBUOogL0Sx4onq8air2LPmAwGQQasiNGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 09:21:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6002.033; Fri, 27 Jan 2023
 09:21:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/6] remoteproc: imx_rproc: correct i.MX8MQ DDR Code alias mapping
Date:   Fri, 27 Jan 2023 17:22:43 +0800
Message-Id: <20230127092246.1470865-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecc2f5d-c375-4740-af0d-08db0047e6a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Z8KMrfvXgQChqE08Q5K1JO3ZzVibMxlItJAeBF8tiOtS8apZDiSv8OyuFYCE3rCZMjtqdl5HPLSKt6NzbxQl9xY4/LWO4PCaYXn/xyIQvnWAeP5EfN6Q+rLnx/Vf3WF6FnftdB8rBz8A7vY63I0pJnRm0kZdZVTEC5dInYKWrjyN0XGySmEMhHlSJGCSN14GMdRV1mx0FgOSvlB1ktmK/Rc4dn0KJF3Ytw5SN0l2PyeHeSVsxHQQFzAvIsU7yA65FcIIlkd2pom+BA249De/pXwZO/BExdSC6v6yMn2jiuSaaCEaUgY78siCU+fzHURL3p25IrSBaYFGf0Q6BJ+x/9frBsz5HbievAnpraxJz9vjQSIChCHIRUq1Frjg9sFKklnKvZFVaqJM+/DC52OiEneapADxYUVpaD2vg5vSJam71a/T7Za1LIJFspBifNz1Q7X2ICKh6JWOwMLIU7ToA/C35PD7OxwsOC+jibLradDx0EjErA0ocoQWpgoxsDr8H/ygT60QTSpXiRMm76Z8n/WD8EDdMd7P3w2r1fLt/O+qx4YQ7w6DE3okOhrta6uCCzK+pskDcBXRqJS9iQ45DoeYwMsttqSLVYVDz2QMajNavTLSfQgMq+5cz68NGfB4JO265t8AelesXaHPvdPlgib2xfIeF6SinhPoc4idGXbN5CzE5vysnWI9LtznSRCJupTv2X5tAO2iox6IFMWHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(4744005)(38100700002)(1076003)(2616005)(8936002)(38350700002)(2906002)(316002)(52116002)(41300700001)(6486002)(478600001)(86362001)(83380400001)(6512007)(186003)(26005)(6506007)(7416002)(8676002)(66946007)(5660300002)(66476007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mp/zFgVmm8zWmGCkf61p5Uqfbxi+R2bDojnl+gqeInGw2kWy64gs4HF/SApB?=
 =?us-ascii?Q?uW1mH/8Ey1eAZVUpXx1norxRVU8B6W0fW8iQotGmiUuMGh6Iz7DQQnaY5BTZ?=
 =?us-ascii?Q?SMWAFRqFPM9UycP40lrgZuOzhpdc6PRH12u9N3Hd/C1fOsxuCo1l0/QmFTsB?=
 =?us-ascii?Q?QTgPJvD4cQeyKqjJqzVeaBBiwaetLx2vAYg5fJ3cWHAx9PEhyQ/RH3q1Ke5/?=
 =?us-ascii?Q?8kwgwKGa2SwjkG3MVpwjTb0yJx/a8Er2P1aHbzjB8AGhvjPB4Z8t26WjRNWM?=
 =?us-ascii?Q?JATyk9c/Oj4odFfBr8uNqgxEAUKm8QZmAnSWxBAOpO3pYXBOUlQineG2HedZ?=
 =?us-ascii?Q?kYGmxqzyNAATkcmCAKOsCeT3A6zPj8K6vGYlxgep/9qps+yM9QHW6SaUoB8Q?=
 =?us-ascii?Q?NH1k+j6UjCtCMNB75T0ZYoUw2gWcdgCo9SbznpdoAesL3iCnFCu49OIbXv1w?=
 =?us-ascii?Q?lbs9BmxJ8ZdBPPetgn8PtGEZbjv8zt5QCJmnIyNy/g2IGGrEVSZnk0t9JIav?=
 =?us-ascii?Q?UrL90w9plHletuzObHCgSiw3vKYjnectYWHP/l6YHHaYM0BHn9LgBGK0J2nM?=
 =?us-ascii?Q?FGPqp79ivKEO119Wk5GuH5fkq7qJ4hH/7o9W6Fa5vx9Bzv49XScabdsxsj0n?=
 =?us-ascii?Q?QpMxveMN+j+kNMPYcz33WjMufYmqcoqN2O4Y4Rwbm/FjB6hK8qQ+KZkDI5ee?=
 =?us-ascii?Q?vL1Xj8pEibo/XxElUx6/Tlq5N4UsCYTVyPkiRLNV2XmmR+Yzs+47hMSZgHIH?=
 =?us-ascii?Q?yoj+5tb3ki7JXDGwp0cMq4OVwU9BBQylMHhNp3NUZLlwoC6Wik+L7piVdA+I?=
 =?us-ascii?Q?t8LkgyVavjSTF0bV51nNsMEsLfq6UP7oBqLzvKBlKqRXDTjd0ZI+ccYTxm7i?=
 =?us-ascii?Q?mXKdDqgrWrjdhGPVykEf25Na6iwTHcl2B+W6FSoHh7SKdYz8JYR85fYKKBAs?=
 =?us-ascii?Q?k3RE41kVpVKDdfeah6UJ8QUU349v3lKpqXN78SYYHZ+mflpEh6HISD0TFwbT?=
 =?us-ascii?Q?q5TGD7DDuVcOh10VCxFWtIqm8h3rm+63OqSBnVADyPdgiPKtNBctf9zRIBM7?=
 =?us-ascii?Q?aDsNkJSWQyWnU6OJ9Nj8fp4XHuvOyzIh/hYTvEyx02mMcwnBp8FAnvSfjgw6?=
 =?us-ascii?Q?VNE/Ie+F+tiNywoHxDQNXSFb2mR4S75eoApim6wkDg+EQDLWltV6BtczEg4a?=
 =?us-ascii?Q?7ljo4TLB77EsNDHwd7pcWOWRqR3EmnDW8bkGKw1/LbJiN7PT1B3FmuBapGtD?=
 =?us-ascii?Q?1fV+n5+D8N6kGQmCGkyoeZ5i+IULCGtK5+3K9GDfAjjP+iIAX6Lm0TmfX0mK?=
 =?us-ascii?Q?ljeTSnJNpxc+/B9n009tTHWylTH6NiVqTlG6JrsjbpPaqfr/1Q1imoONn7lt?=
 =?us-ascii?Q?+COrcgrMxh8D42UUkVD8IXWBCne5yWyZ7/gAPdXhynzFATwgzwKkmw/836aO?=
 =?us-ascii?Q?qx5xZE4tVsYnyb/uJKPqBTdtM73Y3iwZo6iV+iE1mA7i04X0EnIK6ypSh9S9?=
 =?us-ascii?Q?nV3TBFPWK9mnq/4sCCOvrPwj41E+/ifGI8jntQJ76w5FUBS99h7roMIlAavv?=
 =?us-ascii?Q?36CwlixBhAPqHhIron9olrfwflM6NxW8hFGV/uzf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecc2f5d-c375-4740-af0d-08db0047e6a3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 09:21:41.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T4Sb2+2qX2G8S3xml+94cU20VCrbP9hM5I/62P9/PFop0uwqlNO6SfSDUaaEIoVbD05zzQKMLg4eh4h27pr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MQ DDR starts at address 0x40000000, so correct it for
the DDR code alias.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8a282fb67a4d..13199e593b47 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -206,7 +206,7 @@ static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
 	/* QSPI Code - alias */
 	{ 0x08000000, 0x08000000, 0x08000000, 0 },
 	/* DDR (Code) - alias */
-	{ 0x10000000, 0x80000000, 0x0FFE0000, 0 },
+	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },
 	/* TCML */
 	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN  | ATT_IOMEM},
 	/* TCMU */
-- 
2.37.1

