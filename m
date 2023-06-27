Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64E073F545
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjF0HTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjF0HSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:18:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5731FC7;
        Tue, 27 Jun 2023 00:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7kLW7UXfNulr2B0Ds5YJTJiYVSope4bkxdLG4+9XREnoxHEZ+AooZJ9HVhrLBlDwiETGSiSR+stRgfQiA0YtDGClevg2BrMEuOLOMN98LvbNwk4ABvFWTYc+OyY8FI2VcENdKZn99FmIGdKPzUJ5WHt1l0pu019SBxyJXMIlEl3yWaQeCX2gpbDElf92TufY5eOPxAxTEijwsMDnIr5JK3VBrvzLmlDL/wMbr9rbRN9GzZws+I7MAa9Lp7WiW9KgGXbc3pX4pNhorU5eu3eOfIOtjogZR1XT6riMfXWYlFABdHa2AjnMKvIp0S62k8r/g8ZzLmp6+6kK/K6hTqU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UQE0AEZW65NsiV/uGAbT3rdeapcj3tNcNmQMa72/UQ=;
 b=f1exNuxTusMuOgydFqRp8qFZ5AkYMDdAKO/JxiqW4g4U9k3Wz3W94Td/Bp5SBQt+y+gSPzo/L6qNGqCSaP/PlWf0sBR5zLxvPYsXpZ7xybati/KWlR21iTnzpRSuKaXYWbD/jBsNhKo4AmfIMd0nbkbbbkCYGVVRBjzJbvr4mGTLIemmPmojczeQjIdWHs4d2SJDRl+oXfgWuYa/nhPYUAKNNiLlFM3+0dIYmHQRv5w351BPsmujEGaGsoGIWHSGTTsforA7NvpbDJSrbfLUp32/hDManxzSlKV8CrZiAhhNmEwZerUS0gmyYaIH229U8dYzBv1UkmtEfWh/ovopBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UQE0AEZW65NsiV/uGAbT3rdeapcj3tNcNmQMa72/UQ=;
 b=AAsvYOmJwScj3mqydd9YQhFJ5qSbpqO894QCeNZFlhDpDVATliPhsSiy5gtV6G6PU+YhgTQiy3MFbZz/TswNb+gd1/GgEdJ8PdCJrByp4XSCcxDGsZKEqNrGXasuTYIQS4DYGO+sBQ/urMG/6nLqd9tP3ycls0VPBtCZq+MqKIHIP3RwSxHTkeMQIEmgnWTRBF9MGUmt0ERqrV0xDyMeZZIibFVCHxOkFg1E+J7ECGvpkm4BCMKgUgN2PknkuErqdIL3uXGxtl99N/XcvuvxWlZVFiE+5JYHgZqDYgUiX53ZJLh4Peg9wMUKCCdr0YsKdmltSGGj19JbDC2yGgqTbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4205.apcprd06.prod.outlook.com (2603:1096:400:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:18:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:18:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 04/15] thermal/drivers/db8500: remove redundant msg
Date:   Tue, 27 Jun 2023 15:16:55 +0800
Message-Id: <20230627071707.77659-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627071707.77659-1-frank.li@vivo.com>
References: <20230627071707.77659-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: fc486a99-0481-4a63-5076-08db76debc59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WluFfQi2WYlUQ/YfjSjRzxIZK8ZAkPJqGH492xl3B2xRt7zf+jYexh1ktsX668vj9569EH1MfiLWWPuXjctDmu3BpxdT+xczXnI/kPwFfnhggli8YI/Jm7js2clm1rt9L7/pE8FIdas+kADT0sCYfA1rUhk6c7gTbS+C4JWpWbPXn2RpsPZl0aP/+GQumcpWbQrOIev1Sa7iqE6qBOlFHYZ/CQRsryXOl9AeQy2Vc0plrkkZqWnYPh2wsDNjLxDPLvkMyGFLDuOSUUwSTq6/FczaNPVC3FaMxn5p7I1ZdYJXcUX5UwxaQBprR72TuhM95RQ8CRN9TBUe19nB3zDaUZAwYf8o+YDVoDRNXpTdZFSqagj2vI+vmJKK5skVt5sFXnJW45BM5I1WRuZzDssQQEDVNj88Yz5xlaBY3okbjmVWSXRKnFcIXpk5/StQRy16Y59STd3kZdPzQ5eZyFbe49h9z/Eb0gvbH4R97wyhhTF5QON2+1bNMiNc37mqXQEzEePFlOLvgLQGay+H887PVrfnvIV97Om0CW/NV8TNIuPlldQqiARvzyJnTbjKa3VnsNM06a4NmFGC7To+kOgjpl5972L1gthFHVYCiWxdk4mm68wEwtJLot5o0itlveTc2EZfdwjsjxKtMh65jkcufA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(451199021)(2906002)(2616005)(38350700002)(38100700002)(921005)(83380400001)(86362001)(66476007)(6506007)(4326008)(316002)(1076003)(6512007)(66556008)(5660300002)(26005)(478600001)(66946007)(41300700001)(186003)(36756003)(52116002)(6486002)(6666004)(8936002)(8676002)(7406005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rRS49Ydsdqtvt7Q+UQWT6QSxUDmYs3WY/BEGsLfx+J67joxwqJhHd7Xe8cQx?=
 =?us-ascii?Q?Dp3WQuHFGwiZbXkJ1G9g0rBNvhHfPcr9lB8tEv9gT2BLmol8MNuS8PrA/f4c?=
 =?us-ascii?Q?jC1KQFYWh5kXwDCJIO9Go6bZZ9CutIoBZtepytZV8mmADjk63vAabn2Lj8VB?=
 =?us-ascii?Q?2IHQ+BPyFBUroCLeJdNTTlIgYNIA3vRwLX8X3D+cW1c4LQWu07HSKqXdWM7H?=
 =?us-ascii?Q?1Iw03yFWYyhSZLAXGpGic/S+MIOLVsvO2mrzRfShBTRZXWkuJ+r+O4UC3W6q?=
 =?us-ascii?Q?bXlHYOXYGRV4+IqaPt5G8xkeoiD8YbW7LkPzNoZ4wuYgXcXcPHPvYJB2Uy6o?=
 =?us-ascii?Q?1ai5Wc5ma4LGMty9mQz2ztq+kyiGJNWfBd+fna0+wOhdpSLQLRjye9vrnF3q?=
 =?us-ascii?Q?E2yGCVt/OsTFFQZbDvXI+2OI/g66HfmmHhK9cvZDxdR2VlP8FtIYkv6wumSR?=
 =?us-ascii?Q?yeJ2vGVZRSUzw3RbZoGmVM39I82LhFgpw7sihC3/Hgdq7ZvTb5tMw7XWoddH?=
 =?us-ascii?Q?ig5UyM2Tm2TMqLB/tu6Iw39ml13omS+o6ZckGsinZsCvj6Q/bX7lNjRDxfli?=
 =?us-ascii?Q?IZlzg8JWoys18PZB/3LFtBIFrMNrcL1rYH15R2Q7yF3XaaqA0eE6blZL4Xqn?=
 =?us-ascii?Q?kmvJBMyG9F48XXLy1xY3vHhTDR/ApdS4vujRgQQfgaCdTA52ncXkt7GRMnmr?=
 =?us-ascii?Q?1rVjzRQpPgPpJMqYrjHpk7+F0BEbwr470weR5D26J52KLHlDuoIaSaio4Mkg?=
 =?us-ascii?Q?fn7U1ptXRcBR/ffuGGjA5R3rvruInY7DfESXve2ppz1OMQ+1nrisI67+JN9z?=
 =?us-ascii?Q?Zxkht6gs0a2IzEnzkBJBrRwFnJchaIVwjF07X6Zzrp4Qk2tYfkPINSkMHCsy?=
 =?us-ascii?Q?owIMSj8bkCTg8Kv0ClZGudCPiBmRcXD/uvNvjJS8DE6CSfUNty4nd7Cz9oZU?=
 =?us-ascii?Q?wrVe67FWjrT0eCqJcX/riKtJuahM+Z3tPpaXe7fBTqCYwoxa2MFqmlHqc5yO?=
 =?us-ascii?Q?PcSFPfarsAAG3yw1/g7my6JBp4iYrndeoZK8cmIrwJush7Eh9am1DcryzBCk?=
 =?us-ascii?Q?/S/Kesr4ySE7exrHmzOQyorn+wmZBCDi6adC0CDZGHlTpYyAufU2mKgWV3Hp?=
 =?us-ascii?Q?OJyZrQrasd8gcuG5I82ljgnXGD23QEvi5Ek/UrS0pX3Pjno+PgSMFFvmurSB?=
 =?us-ascii?Q?xuVVHvtL3WjwmH/+5xkVx7hfbzxp13F1ZjchUVzEghht2wA5D1bIS71nlDv/?=
 =?us-ascii?Q?7nttN4xKBaIgGwqeJpVegLsF/lH5LfN93xs4QI0FjgaM5or9CxpZIsnI+cY5?=
 =?us-ascii?Q?cPW9ix2bNbquEQAef3cgVV8UpakeeptGOAHuj68E17Z2cxbl2Xzh7gXaqj4W?=
 =?us-ascii?Q?NS0w/bbz/uqB2Jwz5kUwROWd42Ipjy/lYmKIIJyKxwkPr3q+fqy9NwnviQ+r?=
 =?us-ascii?Q?R655EmyxQh81diFOKCyuBDGIkwy6LNevyszeLGiRMUBXEkEaQTtJBViIUpj+?=
 =?us-ascii?Q?mDpxo9lnXQz09xMz/5agnuiTz9f5pAqtHOSflw/YX2kYq0LGSxrXnWO7CKEe?=
 =?us-ascii?Q?XAK7IvzWCxNIk8V0XmtlFPWI3idmyRJe17GlaoRX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc486a99-0481-4a63-5076-08db76debc59
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:18:41.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHSnfDsdRVpSXx/PKVtQO4C+8q8RvyMfodmdauwinn5n6rVv/PybZy9cRUxSJB9zCuA7TIT6EBJwTgn99Z/YCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_request_threaded_irq() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/db8500_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index fca5c2c93bf9..0a890d1338cf 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -167,10 +167,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_low", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp low irq\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0)
@@ -179,10 +177,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_high", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp high irq\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-- 
2.39.0

