Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4406F6655
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjEDHxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDHxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:53:01 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B92728
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSuPA7cYwZ/iMF/P/Q9FHfUrkPSelPMFnFRCeu06+zdn+gIx5GV0Fw4tnbENnotlpdXyEMoIoOWyLNE8NN9642/z3OqR66Qw3irAvSb8OBb7Dt6uwr/E7Q7RrbJ05vW6iQRLNqgND7458muA0uV0/q63FYzQ5vy0nUeqPGWqQRGjYz8GxaTV21i4rcxuUm+h+tqk5bpHRqDTbq9NCOluXyJuBouCsVwnp91WvnHN3JwG0HCw2Fc846TXtvYc8L/pCjskWqFFgh5N3/skNx0obXCmmr3VGErr7wBwzBMDg408fVITFzHr+lCDWd2b1RuATL7Db28Ts2CpTCVZi+21ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRz1ZethrgtzQMZOoNEZw2O+Tk1vjAqmjeHRBSBSOzk=;
 b=HGyzLHlryjNKc1noCMsh7iJekxWqsGZZGWxXwWM4eQw05d2wp8LnM6P24BtEKn1JFoGpHUbhwtXFlJBT1nnq5mOyqnDABHK3s6PmSAtYH+pa4XLhJOHC7jePtVI3BT602/imdrPXn/mtH1UksBcDMok1Ho7rFTt1mTvZDW7mY2+k4JkKc2DIsZ0Ps6LskKhEXicJpzura6qL+i4+3x5CUPM/7X0qrPze8V5rSJT7PbYiZAVIZdXmLNzBfMmgBvyFCmISTHfu4zQK1XcmGcRS7VQ3LQrR8N7pftNw/zZZqRogNt7kJGKWzhfxQ75qDXNEykKvMrOM3Bcl0NbEOl7DJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRz1ZethrgtzQMZOoNEZw2O+Tk1vjAqmjeHRBSBSOzk=;
 b=VdGsDh8tz9LQX7GaRMzPepQekdpV3EAwMnCpmTWuKdpsp55svASF1I8fkvJKEYntodwFNN++NS3xnVZHUHqh9jmSqo4CGNUJAvcmwpPotMcI02XcUW8Gm7b8M/S/K6mqQ60MB41gd9cl4Kr5MpCyaKniUI7gR0xe7sg25rWG70g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 07:52:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 07:52:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, hdegoede@redhat.com,
        jgg@ziepe.ca, saravanak@google.com, keescook@chromium.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, abel.vesa@linaro.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] devres: provide API devm_kstrndup
Date:   Thu,  4 May 2023 15:57:54 +0800
Message-Id: <20230504075754.372780-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a77a42-0a46-452a-1436-08db4c7491f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxvRzSgECj95/gfmuAX09WV4pybuhlPtYgSo+nmfayMVn2wTTYodv2AcUzgJt4KeJAgsF3Kik6sR6lxgvxKTHFtgrKs4ggaQTlsFrGOvbgwWz72DilkvOq6mGo1rGvTwYRiftoN6jjxqk2WfXWhjkfaV5hZH1N7DWkT8Kuj7E8xtWzrs0VmyAT6eqWWsEtvlzGzn11baESA7EKrTYeElsbmGlsbiBR7c+pwIb8wY5eTlxB4u5UgIzTn9z+ds5+xzULfYdMkodxsAaeSzWC8WqeY5as5KbykgxABHRhnILKApfSrE2lqH/TSTG6JVBGPEN/6id67eUT6ZEs/1F4gln7xmtXVC8azvi3Kxqc0DExzR5FENQuO4gAQ68ao3iTwWw0bV73MjdWaHzlR5oqRsV6mLhnAEhFy6Mapl64BLv3B/IJaa5zXZxTDx0D0f0XE3xI2c4/5j5+DppMkrvFQggOMe/kKhazqwceLLQgPX3N+l7vYuaBoIrXHPVe7pH4M9S1+EPZ00xXnt66fFeuf7+b59pRGo10hCdU9+50gj2bvqma68Q5b0I05zvWlq3g8JxaWeWZLuzcbOTqCxEQLQQl1XP5pWOp1XWKwlE704C9N1Jy0OrkFMtgik5qTbVndw21zgeI/vT1dxz+rIz10ntg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(316002)(41300700001)(2906002)(6512007)(186003)(6506007)(1076003)(2616005)(6486002)(52116002)(66476007)(83380400001)(4326008)(26005)(66946007)(66556008)(86362001)(7416002)(38100700002)(478600001)(5660300002)(8676002)(8936002)(921005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2PBbR7NvoJSYRHwc72j0wWB3z8+sI9YgqQK0aypc/5kcxoeWS1CmkT4wpOGw?=
 =?us-ascii?Q?p53vTo8Ii0zajAM4HVf6o9dcgZsj751pqiZYh/SAl0c4Sn2c3rBseYN0Ap4Y?=
 =?us-ascii?Q?7Ll6zKkh4hjQpscGeS8H5E8i2oux4Vdel8Q6to0pvOPBJHXa+KojRFaVscCt?=
 =?us-ascii?Q?mzAWh8b7FzqVfoAQcZMl1SkRH2H09QvoswUToCDgAgBeMDPd/0jsO6J0NEHx?=
 =?us-ascii?Q?8+WTgkZiCxLIfGr5AmWySjAyN7ujCN+nrjWODMphocmU04ieLAcr3kUgvs6P?=
 =?us-ascii?Q?8IdQVStmSweR73g8BFdSlcXWGRdLyiZ6E+V9u5HQHbKaHOYqNAfN73WJGkxh?=
 =?us-ascii?Q?AeWp0Szuq8XNx4Dk6Na3swBbHW3eA/6dYdk7xdbH3iczev/9EgzUmJM1BDRr?=
 =?us-ascii?Q?oS23OqOhAQCZ9ut4XunNbScdRGvZ/X+m9P00nBTSXc/IiZbTDYIr0bUTa5+R?=
 =?us-ascii?Q?YEZcU/FM8DQBSJCjgpn/Tcr8zsLScqwXAWIBNLfVDA4qZgGjWcrsWmtM2LG3?=
 =?us-ascii?Q?VV2csxozeZoJt3LcMKKrq+tmSA07ZqNf++WfeUJTqxYQlEL/+IlUR0l8cf9U?=
 =?us-ascii?Q?DSoGG+QL3lV9RyGhLDB0VEPCed075w00ESzxxP6EmOYx3C2fm6lB/N3QpjKb?=
 =?us-ascii?Q?m2pMUB1QDPBZF8nvnpPt4IUzOW769feJl3IZnNMKxEq5gyMQwMsuRiGkbVtE?=
 =?us-ascii?Q?NLmaY923cTLyNV1IFDdQPKKeivlXM9DVIGt9RCpgnRk66SUsGslrxbBhhGXx?=
 =?us-ascii?Q?IJ46X9XdtBWUTzEDvl0POcesomeVeUf8tzHtJWA3P9rmmjDSCfpojE6VloqJ?=
 =?us-ascii?Q?dBva0mGRlc23PJvG974Vyx7GnSruA1QwsT7u6kBj7g1YsvX4Zyf1MxoIigoF?=
 =?us-ascii?Q?BgJ+9K7+gZze3KnvtT/uudAp3Blc+nly+FDNf04Ig7xLwz8SjX0Xy0Ec2IYu?=
 =?us-ascii?Q?e7SA2erQg/J6TPjFOZJnye19hfSt1hSSGM10FR9lFspSZvi/R/ktdZArT2V+?=
 =?us-ascii?Q?rHPQt3M+GrBbh22Gw4m3YJZGjpKV9cXuuPPxdiL5CPGrn8GTYWhiQj6SSU6h?=
 =?us-ascii?Q?UW9deGFgYuOj8opiGP6aAWadtBSrMsK9zXJpPDdb6CN8bMFHQtF5BHBkb3XK?=
 =?us-ascii?Q?T728v4XLVtvUK18ytKrk0tP+s1UeWeOMAqt8MK4AOphnbDa1q3T1Wa1NjL5y?=
 =?us-ascii?Q?tRqXeUVcxB6RGHhxyQ4xLSH6bj8gftZb30FITHFKOMMGSptM47TxpVion5N3?=
 =?us-ascii?Q?8lrz6y/D9hm4nmEBzC5tFONrzI/ezUv2ayZMvipTor/McTDmNAXc/6/LLm19?=
 =?us-ascii?Q?fis85Mg44i46wpEHwDOC4YN3TqTSf3MVE5kLps9lLDYAI+t2Oy4c/8KCuEzF?=
 =?us-ascii?Q?Wt1HI2n9aESw6xczIq/8bFh4QspIYE8dbdUS2bdTvZtdzwI/lvCFgTO6Yjjg?=
 =?us-ascii?Q?06c6tlBez0xSzKU/KbXBftCnjhROuFjPe/bkuyKYjZCcaXtzoIfhfiFKzOH7?=
 =?us-ascii?Q?E2SCZxiVsW2OZH3dYzkw4/tAUangWVYXDtOfQOFcXwGuZB8mvPlw+4eJQtLr?=
 =?us-ascii?Q?ANqv1p9BqOsuYxtiCtTT9dETKEnI8644TUKRMgMA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a77a42-0a46-452a-1436-08db4c7491f3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 07:52:55.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FG1WzuF+F5BwcRk66idM6qMAfBV7TSpunkd5LkVdgisyurFstR1Zfl9VTEf8XIO9m5ubnagqAqPYp4eu7lHFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patch introduces devm_kstrndup API so that the
device's driver can allocate memory and copy string.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/devres.c  | 28 ++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 5c998cfac335..87e2965e5bab 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -963,6 +963,34 @@ char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devm_kstrdup);
 
+/**
+ * devm_kstrndup - Allocate resource managed space and
+ *                copy an existing string into that.
+ * @dev: Device to allocate memory for
+ * @s: the string to duplicate
+ * @max: max length to duplicate
+ * @gfp: the GFP mask used in the devm_kmalloc() call when allocating memory
+ * RETURNS:
+ * Pointer to allocated string on success, NULL on failure.
+ */
+char *devm_kstrndup(struct device *dev, const char *s, size_t max, gfp_t gfp)
+{
+	size_t len;
+	char *buf;
+
+	if (!s)
+		return NULL;
+
+	len = strnlen(s, max);
+	buf = devm_kmalloc(dev, len + 1, gfp);
+	if (buf) {
+		memcpy(buf, s, len);
+		buf[len] = '\0';
+	}
+	return buf;
+}
+EXPORT_SYMBOL_GPL(devm_kstrndup);
+
 /**
  * devm_kstrdup_const - resource managed conditional string duplication
  * @dev: device for which to duplicate the string
diff --git a/include/linux/device.h b/include/linux/device.h
index 472dd24d4823..56b092883c64 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -226,6 +226,7 @@ static inline void *devm_kcalloc(struct device *dev,
 void devm_kfree(struct device *dev, const void *p);
 char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
 const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
+char *devm_kstrndup(struct device *dev, const char *s, size_t max, gfp_t gfp) __malloc;
 void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
 	__realloc_size(3);
 
-- 
2.37.1

