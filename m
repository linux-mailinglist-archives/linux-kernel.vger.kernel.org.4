Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6445769C906
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjBTKvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjBTKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:51:02 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012C16337;
        Mon, 20 Feb 2023 02:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXUtDtmC/8NTOd6GGT4lDkKL/Ar9wMw3nc9UBge+RD7NkN+FHdTOgt9+PKefsHfMyKxfKioES82c0NFlRrdMN7bsShFdtFX0ncSIRFwdz7ESEjIKJs8EMU27m0FDHGBzYs2QHdn6hXKMGtKVPKC9UfTaOT/FFN/DqtqB4Q2HvpHvlicL36OSq4odClm6qGixXRPJzwFC5wt2uObxn9BGoMPZ5znem54oY90K2NuPeWDBuUvUTOD4iZN2yVZZWYVkaMuOcMxiopkdAckk0Vp1DMM/uvBeNMJazH+97gFgxVLYXHGlu9Z+IqD28/A+W4TJu83qYHsdAqDPCcQSh88Ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iw3bARIXB9Ci0V10LB5HCq4NgPDxUJAqpA8Y4ZkJIA=;
 b=idSEX2ukIJr8AhYRJMyD1tAXhQbuiJUhDGXThk/hJPxU2zNDx8Bv16FQnZmcf90xP0GDfJFc4dsxIwW+moAouL/VIrcI41eZfRyAPsRc+9aquhrh3zGsMPZGSAoUu/rOumXtnd3jKCnX8K7D5rTpiorqadofT/YISAtyyVzn1m790Kl8+9YWqJeQj9KJTa+6LwupK2ljV6deev4m+33tRd7Ak5Fs+Azhy2cgQ4cDB028X8Uf/s+QI4BQb5CmIXgqFHBk7tdYc8R6DxdNC/dFAFtJ398NSrxBJQFwslRqZKUX0iFxQndHE2/TvMrSkTRJi337bwSYdZT6HAbEuaiTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iw3bARIXB9Ci0V10LB5HCq4NgPDxUJAqpA8Y4ZkJIA=;
 b=PwBGSv8of8e0sVkYO1j8iu7ZHOcGMhR/wkL832GeREjVo+M4EPezgjSnF+9xJffhmaPcCx2Trd8+A5l1bhAQoNQGPjjKsI9E2I71DX925w3X/b+c9Z2YoerxCifyrMKUQMoukMS7b1TUYpCQL7bgrWO+iBUZK58QKnxdQaakQ7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 10:50:55 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%4]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 10:50:55 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, VIJAY.BALAKRISHNA@microsoft.com,
        Tyler.Hicks@microsoft.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, franck.lenormand@nxp.com
Cc:     linux-imx@nxp.com
Subject: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
Date:   Mon, 20 Feb 2023 16:20:33 +0530
Message-Id: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: e1872c03-5f35-4c03-c660-08db133057ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ef65MMMWsuZBVJHmc/ivtK6NJczu7ple/pdC9jggm6+DomfL7YndXYzntnpylXvyvTYIUSnp3BgnHoMqMxeE9a+DgXZ+wHHgdUiaf5kh2gxmjexJIL9NA5U2Edw2/BMfWk2D/ff03LadPFD1/BaX6mjqw0fvKepRDHmTwBTKENrwscN9+W6I+WJUSKL0LRfRZ2EG4xM5CbqSRUdm1V0APiIcb35IVuwh3wu/otqos/q2DiwHhmGsqcrXi9O4HlFz5wG9FUwNnA19wqd36faJW0/Xjnzpgf36QdW5I9kHgTW3veaL/UiZMtr0Jl8le5V2tg2ORQxzLPCHXRcGwcO5YRLpgyvOB+SemWv9CAR9H/6bkqucBjZsmzn3wubkmbiQUF07X26D36yH3BSt187eu4MwXyOKn7sxVrUCk2v7xgFsAxH0ZCF+0nXnNUUNf0IM3xQAI97Xu6aPPdYUaVW80gh/uqqvIBl5l0Qsbu2TQja56uYCJxToNtKunx4QuumysppqOoYxDbbJVujge1Q20qYj8woLe8cp59QHUusQ76pmClsMzpDTM/qGomV19pjwms5ljMQy+pEAlZy0Jifvdt74nw/Iz7EBW4WwIswIYyIFB6V8c0vwSq6+NvTujh/baU3mp7wmLo54S6dE6kwTtyr89vYMx2WBRQsvGtytrHpkYGrFLDgpIlPhHEuNC2KZWThr7lTpUGyPWXhG/FPU72N5m3RZpMd32V/nvEa60/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(6666004)(66946007)(8936002)(316002)(66556008)(83380400001)(66476007)(6506007)(8676002)(2616005)(4326008)(1076003)(41300700001)(26005)(186003)(6512007)(9686003)(6486002)(478600001)(52116002)(921005)(36756003)(86362001)(5660300002)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sM5B0IeiLDAEDd6Oebp/csI9Qb9OLrUMzaafbrTHoW4G/P2Tj34u1m+K/avi?=
 =?us-ascii?Q?IzkIa+1auyzeWKL6DM1mVLnUUE8L9uIM45luzL0BXHeLENemiZPs/oUzzmvl?=
 =?us-ascii?Q?FbH/3Gz3TlZicQgu4QYoSdtUn4zxNewTZbR7YG+02xHOMNILDs8Rsri25sDI?=
 =?us-ascii?Q?TY8q5LSHmYVA8MzjNgaQHE20aiQaH9GmAxVpQDWfCKgp1LMMlqB2RZWoUQve?=
 =?us-ascii?Q?psnYi3tSzSFs0ckvlFNaUcUYBHbHY6kaLDSKyUCTiGkPYcKCD4TeXOkEbo+U?=
 =?us-ascii?Q?byuHBGv415Tql2OBDxTMWMCH6NtWAJJ+4CsgzAU5DrL0GuaxGRm0blvgEjYe?=
 =?us-ascii?Q?DJ5lOXznAxEfTgK3B7pn0hmMYGUVvIFtpBWHLLSnAzzpxOINq4/FPPsYLHja?=
 =?us-ascii?Q?M5tCQzZ0R0ZKsE7njdIfGeQIcR2lKUr0X5V0ye2eN+TaN4UMaYOv7E9RpWht?=
 =?us-ascii?Q?dkp3crMkiXDkWAdcR28AsKgn4Ruw2VyATTzoa29Lld5xVeXFw9xCtqwSZ5HR?=
 =?us-ascii?Q?LLP9iyLDu9Se5VP3dOtwks0YuMv39m70NWlzh4K4yY4ovUGJBQNOQo8LCnTk?=
 =?us-ascii?Q?Gmtg5h45ZmzlzJY8M/zhIazRDJjbakRkKucRkIkd+yThajjEAGiTNoSn3699?=
 =?us-ascii?Q?UPnpN7BPyC2JFAlACylpKVjN6/z19uTGnkUsEc5LYAQJZftRA9XJCj6N1bid?=
 =?us-ascii?Q?35BRyb8giDQzXmFhgvA7ZEQEtCVlgz5BHVanPMg4/c2fc09hemGweDoHn5xl?=
 =?us-ascii?Q?TkEOwAMvtvY52EnZmrVI8THf0CVikUsWIypLLLOoDNLsZpn5ALG3duwy39t+?=
 =?us-ascii?Q?5U/KUnU9Gh/nlC4XWUO9D09ktn6wenOTHPmHWOwZ15kXqD2XIUPV8EkjuR7+?=
 =?us-ascii?Q?555ImgENsBTkEdBSBRzn/gNvS/0/T3hE5fo/cxDQ6sY+ZlXveBQ5F8w3OS5A?=
 =?us-ascii?Q?8LXxMIidNM+t25wfcx1WyNy5IjxoguNzMUlNkkxR7tgK7S58KO4rJ5ZssSCy?=
 =?us-ascii?Q?npP16htWhNWa8pjIwlo1ILwgvsU2mv4d9Qmo94gws0p1T1YShaoYZxtKaamH?=
 =?us-ascii?Q?/7rY5fGhNyQIAPhkgko2VRaut0LArf+8Nh3BVz6weR1NFnhlLH7qTJoHTvbw?=
 =?us-ascii?Q?I05DKzRQYMyDEPSKqpWuRKhO7ryGLF7Grr263FzTrqZOWr3qXBmz3dTslcZ6?=
 =?us-ascii?Q?kvlFtJYz4xmJq54zUpZVN5PoYaxLPd3T33TsnldJ+v4VQqEqg2PzlJo9Rv9B?=
 =?us-ascii?Q?uUdmQxSk0bAtbgELN2qym/JHpMbFi0wog15+Q0ooqhc45ofPJ6/LofIidkXr?=
 =?us-ascii?Q?7PaKm8R5hSwt/zY03bFmsbhatuGAnqBb0tpmZgkeVLvh7+XkZthSZpW3PgD0?=
 =?us-ascii?Q?n+tZdU3ADDrWbL3VvCQG8ptFIYBfnvez6aTpEyZA/3OW7BgnweEtaoojoya6?=
 =?us-ascii?Q?Tfg+/+7TLqwaK83aPKtlKGAN5B/m6UCXLxWYP0alw1ExkwlAlAIuYnmOoHh0?=
 =?us-ascii?Q?cBLWW4s1ORgN1BBEPN6A84mGTcqkv1HmzcdHpr4FEz8gZbeWvaZoZ/noGmeC?=
 =?us-ascii?Q?81A/L6u8Fd5NJHs4YBZ07ozkwSxc9/UhSGMhfp1/4uFMZ9O6GWseQvFj3Xon?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1872c03-5f35-4c03-c660-08db133057ac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 10:50:55.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q64uDiRde/Ker9iqo9Hw1THHM0I7Qo9MmD0ooLM7xB6tCvOhmywLRrlM+Tfb708dKYoP7FDQ1hNtfj4aII3tA88w32yoDVAijpV4vBaFOTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geanta <horia.geanta@nxp.com>

Issues:
- Job ring device is busy when do kexec reboot
- Failed to flush job ring when do system suspend-resume

Fix:
Flush the job ring to stop the running jobs.

Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 drivers/crypto/caam/jr.c | 53 +++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 724fdec18bf9..8745fe3cb575 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -72,19 +72,27 @@ static void caam_jr_crypto_engine_exit(void *data)
 	crypto_engine_exit(jrpriv->engine);
 }
 
-static int caam_reset_hw_jr(struct device *dev)
+/*
+ * Put the CAAM in quiesce, ie stop
+ *
+ * Must be called with itr disabled
+ */
+static int caam_jr_stop_processing(struct device *dev, u32 jrcr_bits)
 {
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	unsigned int timeout = 100000;
 
-	/*
-	 * mask interrupts since we are going to poll
-	 * for reset completion status
-	 */
-	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
+	/* Check the current status */
+	if (rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_INPROGRESS)
+		goto wait_quiesce_completion;
 
-	/* initiate flush (required prior to reset) */
-	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
+	/* Reset the field */
+	clrsetbits_32(&jrp->rregs->jrintstatus, JRINT_ERR_HALT_MASK, 0);
+
+	/* initiate flush / park (required prior to reset) */
+	wr_reg32(&jrp->rregs->jrcommand, jrcr_bits);
+
+wait_quiesce_completion:
 	while (((rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_MASK) ==
 		JRINT_ERR_HALT_INPROGRESS) && --timeout)
 		cpu_relax();
@@ -95,8 +103,35 @@ static int caam_reset_hw_jr(struct device *dev)
 		return -EIO;
 	}
 
+	return 0;
+}
+
+/*
+ * Flush the job ring, so the jobs running will be stopped, jobs queued will be
+ * invalidated and the CAAM will no longer fetch fron input ring.
+ *
+ * Must be called with itr disabled
+ */
+static int caam_jr_flush(struct device *dev)
+{
+	return caam_jr_stop_processing(dev, JRCR_RESET);
+}
+
+static int caam_reset_hw_jr(struct device *dev)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+	unsigned int timeout = 100000;
+	int err;
+	/*
+	 * mask interrupts since we are going to poll
+	 * for reset completion status
+	 */
+	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
+	err = caam_jr_flush(dev);
+	if (err)
+		return err;
+
 	/* initiate reset */
-	timeout = 100000;
 	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
 	while ((rd_reg32(&jrp->rregs->jrcommand) & JRCR_RESET) && --timeout)
 		cpu_relax();
-- 
2.25.1

