Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7D654803
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiLVVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:45:47 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2CD99;
        Thu, 22 Dec 2022 13:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnyo6uPXNrljfmgzsWfMoytFwUJu9vgvT0IuCTEGWgPmgUSpKmLuY79DOqd+Ont1im9JtXcGmq/SuYce1iixPmsqwar9IsfFDfLvK1HhwdiGQbb5a/pB3YA7Ih2efDX1MDCrpWoFjmyQ8jm8O3XUu/4UUFsR8qwkIY7txWYCrNzijSAxMaWklGxsEZPobRp7+2BUqi53d0KY8Ds7XacelNWd3yuNLg0OeOxc/1vUiVcpqyo13mDf1W4CXvvdUA9azWNS1tmyV4eTjcHoLzWG2NfhrPc7bIit7qfZZ/sRO1+yT5uucZX7pM8Cj0QllycdbYX2pTF4x2EI3pjJDyC0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHXXpCEuBU/ZtBxZEzGFu5uAa58dHiIP16seXVW8c0U=;
 b=ciqmJF05qzSosVDQnDAxvXEtawxXNfwQNTIJHdGRETZ/Hp6rJDmJSWpGbqMpVCpqeyupk94Ql3zS4sncDC8t0gQ8oIsO7WjSROG7Zs3fX/rtGtumi1gv57QsnjuNMS5uvck1AFVkdGCTw/Tzx4Y3JtFNtUSNuH0Fm+IJG9BVohXNkD32h9agSnIRgSkdW+MfPCTsmWQL2slKWopChh6YjkYQlfIYJorU6YAKtmngaGsSHoYdpqZVdoWEIfU0sm+3l8yQKQbne/kKzegzOGXZ3mt3W7XC/pKG47932GBZVTci3g7YvEnf7JuPy9WEbSJfNmvTIT7bo+vMaqV+RtP/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHXXpCEuBU/ZtBxZEzGFu5uAa58dHiIP16seXVW8c0U=;
 b=A+MLH+vzVcsY7SD6zUBq6Y4z2eWGJej5oKy477ma44M0U9wAKxX6Tutdc5i4nhzaEbixdvXdFYtRfmp3AV8m4v0JyRYtL1qKpiBn35E1LRAeCfc7m56BbvMSOeeluLQtrqAh3sdYqXEcUUtK25eFtEbVXDXBDFTjb7SwZW/8u4P0benNVKEs9z9WF8btf3r0MC9mdKBmm46p2JWBTePgH+y/uz9AzdDocscyFmSjCGFuED9xjcwKH2WdwIJzEsj/xa3L2pIw57hS1w5g/KZLh/pZ9mYtNPoWocsoYaLr6+wH8bJBfMDXIn31aedi1vhiKFQ2oGIG6ixP+BDDRTdHtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com (2603:10a6:20b:56e::11)
 by AM9PR03MB7575.eurprd03.prod.outlook.com (2603:10a6:20b:41a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 21:45:42 +0000
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::264c:4825:bcb5:e4ac]) by AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::264c:4825:bcb5:e4ac%9]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 21:45:42 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4] rtc: abx80x: Add nvmem support
Date:   Thu, 22 Dec 2022 16:45:31 -0500
Message-Id: <20221222214532.1873718-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB8832:EE_|AM9PR03MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c5287d-f3f3-40d5-cbf4-08dae465dfa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EerUnPAGPXFB+BGzf3vsRH0UGfzu0WPK86wdXiniy8PrdLsDIuwy56pNH42dKPLxIMFgBFEfwm4WV5jwIgzV3vmHaMH+9qm7R5s2S0KBli6dyykZAmxfCEyeCQZAiC8MdTFIIpbwzsxvxB39VNSPGQxkclu1H7/8KRjq2BFfYApVapb4pZ2eGJ7lcda8c/dKTyRYA0YMzWcho1Y8WXELmkOP6a8E14wkTdZo98SYKs+3two3TflZ5RSUpZ+UAjPagGRlifz4KKw4cb8cAYrh2ZqMg/KLsbuvmkO9Cw/vmAXPtzMuxUdwjtidG42HTjdQTAzcYHFAjNr7Ub9S8Xs97Ybzfrtc0F1GkMAxRsXnLaO4cq2gqKJm4kfa5HMl0p2pw8nNHEio2qYr7RohmgGum18zKkuFBEfa+9sPWzClqCG5FzswwWxknJne4mlmVQ0I5EbLDAmy+5iZ7uFxbxBVECRHxAKUcQJurRE1P4nuY11ezRXyFqeziPEh3rhuYJTK2UPNFCPMmE35xUORz5dhsH00jUGNidR36u5TlmfxWThaWQ6J0EoBxmSS9L83jUf3uouzaFl4kll8yEAAqOp2yAdrw01/ztG42lSgje1v4IMWDmG7KoespmVd9LNSO+SjgKWwyr4z5b+YntXeM4wc2lS4hDfWZ18DRiL2o/ATy1eyHiu2DuBzBjXkw7rXz+liNrzqj+L+3TGJwPAkimjrLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8832.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39850400004)(346002)(136003)(366004)(396003)(451199015)(41300700001)(8676002)(6506007)(66556008)(4326008)(52116002)(66476007)(110136005)(66946007)(8936002)(5660300002)(316002)(2906002)(86362001)(36756003)(44832011)(6666004)(478600001)(38100700002)(2616005)(26005)(107886003)(6512007)(186003)(38350700002)(6486002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsDLsqJT99qFRMkMXSwrYPjFmPqJXpj7N21hvwP1Bd2jZg5TdLHvFgBFf0XZ?=
 =?us-ascii?Q?pHgraF4XbmkQtpI2svfN6AX2bMMwqOoL/IFXPMThUe4V41O0Yrqt6wmxvjDm?=
 =?us-ascii?Q?7Gb0E/WOyAfzb/o0Qq/IO9c39HjfxPAPVaYNCzTDi5McLjyaMiIXO/kD4jRB?=
 =?us-ascii?Q?Let7X/UJuIlHyACrpqXQfDnDTP0b8nglnTs8PFEk5zTSlBMQJFE+Dlde5R9a?=
 =?us-ascii?Q?AAA7QfQhoaZPTm+MWq6CNEc0avBM0G5V5XO7YIpyDbiBfPFiy2kWqvc13kPL?=
 =?us-ascii?Q?iLnF6lijQVX9oWOPCll3X/Mp1H0/sSyNuzec8/DOkG+ZPPRrRFkvCzvpNnfT?=
 =?us-ascii?Q?hJo7tpVegN1iZEtN6kYCbvGrNCfS2Qr71G44Hu0dZGRiHKdNgKsytLkbvnTW?=
 =?us-ascii?Q?46LrGFKedBgnGHaQp72ahyRRUyn+WCkPSMx71byKTZgzIvp8Avb+3mgiX0//?=
 =?us-ascii?Q?sqSCzfeMey52VjroemmW9vPFomsghsXIMsDh9Yp6A/QAiPJnnKg+DfOlY/gB?=
 =?us-ascii?Q?XjbSHjktRmQtcOsaCXdWHCG2qI5UaGRzKJ9GoKWWPOywWflxF6ePSsD8cNJm?=
 =?us-ascii?Q?NwGyiQ6DhmFSlWelJDZZmyJWcjtf56AxyARWdw7T5gRmH2D6aey0DYDL3LW8?=
 =?us-ascii?Q?wSZH5+MMBWndx3+wHkDWVY5ZPPWrxrTLwubhkYX/S6v6rraWFxiwE0MGiS8m?=
 =?us-ascii?Q?diRX2iOG2g81zoYcKTQ0Vry9m3xOy3X3yVdoxlZyzskEwobdKAYfczBEJSm5?=
 =?us-ascii?Q?36ed8nsoFgzWnDJ8h4Yj2f39mq+qNFCkd9fLmW3bY3/HoQvWIQ1T1vVqyCKx?=
 =?us-ascii?Q?XsAd6H7oNFXUDHUUti2UfX5DtcndqsQBr59+51/hWFzU8AIsDO5Pka6+v5zu?=
 =?us-ascii?Q?WxBVcs4988t9h+oA2qi+8NivpbewRVRrcfxw0QaQck+km4RP+QmP3qZzxlfD?=
 =?us-ascii?Q?7O/ZGHEvk223INnO5osz6ZHF7oQKhnsI+ACSHSq47XEloUZI4iRDdmF0WnF+?=
 =?us-ascii?Q?+Udzv78jZfAg/8VqFL3fiJcJK59Yh1m9JVHGLQINNdZGNSWZxKPRUEob0Lak?=
 =?us-ascii?Q?x9ZLYeuJP1Vj5rH58hdKNY2AqAX2heugBD6VXm2dncocnmgyzoJ7zcGz4jxM?=
 =?us-ascii?Q?JBwD+JLAOiiC9m8C+lbQHWnRr50tz7yttmpep+nbOxstDxr96O+NidQk+jw8?=
 =?us-ascii?Q?phz9NdTucfOupG2dp1oAz9bLkLhK5dC19EwaASnqhyS+8e8zP9XLVF160Vrp?=
 =?us-ascii?Q?Y0SLtV43pWnbTVl/WhTdDB0WOvcfHeqRwNoqJzukFUoRMUZLrXD/jqUixb2G?=
 =?us-ascii?Q?iETT2iSTPj901cIrQapxGMo07+FKMmW4doQ2BmI7uVEI5rFzD10pBF5p+nPu?=
 =?us-ascii?Q?i6LghplBun6Bv6RHijeA1GpOibRl/YS9f9mkxz959idyzc3m11xYV57qSv6G?=
 =?us-ascii?Q?TkYJfiWMW6K7EcJtAY8VBN0hztFtT6dG4/zjQROQnCMNZuF86LNVNdJ+9yuS?=
 =?us-ascii?Q?V6fcDgkO2F40D9fcijA8XYEPw/qcH6tdvVg2eLgmlyhsgSusb0scZ7Bb1mAY?=
 =?us-ascii?Q?NGl3Xio3vjVnADSVTlQL8oY1e7MqFWfUXxIJYtuJfw5SRdrrN3cmUqRA3dAQ?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c5287d-f3f3-40d5-cbf4-08dae465dfa1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8832.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 21:45:42.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMl3mN8GujtgzFnBLzVzeYSqbtcd1KRehpOk2VhsdmtIv7DCQwiIgnVNjgZ+kpQ+WpfftGAfAp3afZ9kaUE9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7575
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the 256-byte internal RAM. There are two windows
which can be used to access this RAM: 64 bytes at 0x40 (the "standard"
address space) and 128 bytes at 0x80 (the "alternate" address space). We
use the standard address space because it is also accessible over SPI
(if such a port is ever done). We are limited to 32-byte reads for SMBus
compatibility, so there's no advantage to using the alternate address
space.

There are some reserved bits in the EXTRAM register, and the datasheet
doesn't say what to do with them. I've opted to skip a read/modify/write
and just write the whole thing. If this driver is ever converted to
regmap, this would be a good place to use regmap_update_bits.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v4:
- Remove unused variable

Changes in v3:
- Use devm_rtc_nvmem_register
- Remove ifdefs

Changes in v2:
- Fix building on non-arm platforms

 drivers/rtc/rtc-abx80x.c | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0138d07232..74ff820f5481 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -87,6 +88,16 @@
 #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
 #define ABX8XX_TRICKLE_SCHOTTKY_DIODE	0x4
 
+#define ABX8XX_REG_EXTRAM	0x3f
+#define ABX8XX_EXTRAM_XADS	GENMASK(1, 0)
+
+#define ABX8XX_SRAM_BASE	0x40
+#define ABX8XX_SRAM_WIN_SIZE	0x40
+#define ABX8XX_RAM_SIZE		256
+
+#define NVMEM_ADDR_LOWER	GENMASK(5, 0)
+#define NVMEM_ADDR_UPPER	GENMASK(7, 6)
+
 static u8 trickle_resistors[] = {0, 3, 6, 11};
 
 enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
@@ -673,6 +684,68 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 }
 #endif
 
+static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
+			     void *val, size_t bytes, bool write)
+{
+	int ret;
+
+	while (bytes) {
+		u8 extram, reg, len, lower, upper;
+
+		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
+		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
+		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
+		reg = ABX8XX_SRAM_BASE + lower;
+		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
+		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
+
+		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
+						extram);
+		if (ret)
+			return ret;
+
+		if (write)
+			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
+							     len, val);
+		else
+			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
+							    len, val);
+		if (ret)
+			return ret;
+
+		offset += len;
+		val += len;
+		bytes -= len;
+	}
+
+	return 0;
+}
+
+static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
+}
+
+static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
+}
+
+static int abx80x_setup_nvmem(struct abx80x_priv *priv)
+{
+	struct nvmem_config config = {
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.reg_read = abx80x_nvmem_read,
+		.reg_write = abx80x_nvmem_write,
+		.size = ABX8XX_RAM_SIZE,
+		.priv = priv,
+	};
+
+	return devm_rtc_nvmem_register(priv->rtc, &config);
+}
+
 static int abx80x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -824,6 +897,10 @@ static int abx80x_probe(struct i2c_client *client,
 			return err;
 	}
 
+	err = abx80x_setup_nvmem(priv);
+	if (err)
+		return err;
+
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
 		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-- 
2.35.1.1320.gc452695387.dirty

