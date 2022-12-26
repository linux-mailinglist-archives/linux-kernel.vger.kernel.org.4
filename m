Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92D3655F60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiLZDNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiLZDNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:13:10 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2EE5588
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 19:13:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBpD9dsg8v0Xm0RkpvWAel/FdF6OQADfRv+7ORJOyrowekAHwXw5kWvQO06NibdKpZ3vqCsA6eZvZM56Hd9CgHFfpJcmKaMkFfS6GoxAYlcCuf8CyfCQoH+Nt+emYz49IXRnJ+qWo1OJXPEvvwavh0VWR7+JI1XSt7cllphFp0+0CytZNrwtyGzNrDOt8En8i5HAXbiIbjvmb1CfH5Sghtkp7jHAourLgUuwnUJh5CLgJl9YS7+SCeUDtS1Nt5A8YvM2aB4Yv26clwVJGgKSfb19URIw0vWak+fE+9cMtxPXn7S+wvWeFwcGoyT0CQcxqvv/4i0ZwADhSjio7Oby+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki2HtHVNon9yZ89Utc7jbt8cyNwRrcVXqAFxjcNYdgY=;
 b=MTH5LSZieonrIx7XuAi21iYQWnS66LsY3nJ4JQHh8i7EYxt3v1OHfJg9RhxHGkX/8GQQvTixeuH4Oai1yqiDVjz2pR/eszNMA4Z66xBKU+a+Y2/cpgOo3vykoirgRawWZLOakZ7e8/mPDxwvizIOL5SmYLgEcr0ac0ebEkUOX8oXICmI39+Wnn4/ZJQktQMmQIvlA+ciWmk4gJtrGsxBuVwSeJjRgf/KQuLU1fDtXt7edjsIWrKLlWnsAlC0Lv8kG95Ed3F3UV0pkd3wIo5GH/zGN9w07JThlc/92g1/rtB4L3fnjKyAK78p49Me/12+u3TDgSO8kdrU9e57w00J4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki2HtHVNon9yZ89Utc7jbt8cyNwRrcVXqAFxjcNYdgY=;
 b=oKsyRhZR+8YUFHVgiurnsmwjJmZ8LlTSDE6JE8UhES8TNWWLp5rA4Rsw6QsMRH5wDIcn9cpexvGSoMPeSZKzkvQZ1k+ONESlUSK9B90ewWUrNbXZ8YlTCePygixNPrQWBs4r+YB3BZEjtnffj/7NNRv6dDzZlHvrjivvch6j8MU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9500.eurprd04.prod.outlook.com (2603:10a6:10:361::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Mon, 26 Dec
 2022 03:13:06 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5098:b45:626e:a5c1]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5098:b45:626e:a5c1%5]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 03:13:06 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, geert+renesas@glider.be,
        saravanak@google.com, linux-imx@nxp.com, greg@kroah.com,
        arnd@arndb.de
Subject: [PATCH v5 RESEND] drivers: bus: simple-pm-bus: Use clocks
Date:   Mon, 26 Dec 2022 11:14:17 +0800
Message-Id: <20221226031417.1056745-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d0d7c8-130e-4128-db5a-08dae6ef1baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rltdyypBnZ9QyniyZ4m5i4/T+LmZ+Milxz/pOcAqm+TR1CzASt0snwJnTAIBjSX3fwYTvS721SInWUlEHsz4lmPFCngQfYcFAVFrBYWNE+rUcru9mdcNsDf5yeohkMOHTM85E+gfXJ24GH5USViLQJi4DJKbv03YzH2B9x0L1d63y9tkRE5lw17tqSKr2P4fYRitx94HTnXt+lUNqLc3Lf9FW9hmwucewRpkzUqzG+DbCm6QdDdNjTi8tm4tJp512D9Tc2+ZJ1IwaTBZrxbmuXwydfWYv0TZH1chtTOJ9zTz4+lvPj4SBXUHsYUC9hNLDg8eYwrQtqhFZRmTYlfCfZfRNl5qUE/n1L/sKO72U5+hYBNpx4FNKIV/UfTnCDlVlcsM3NV92EJAmrsq6YNKlQ0E3r1CEldPKMxtdvhszk1fP+KkoZZONnzBTfghBV1oKaRgmBi6WgaAfTAf7Xv3KpjxqozQuCzHzU0u7b7xO1xKovtVC8KvHW3sWEn/rkxEXbRczPmDFl2bV2qWyxUFDdPPM7ZI4JIkaGBntWmlhZFxKcJ0i0o2GIUlKqsIBKwFKv8HUe9Rj/JFAfS7Av0Wl3igUigGRccfkQJrGMq0vZ1Ffp2HizHtzfJs1g0OOn9TSpRg3/KPEqf4uSiW9QeyY19fDSnQPdJcOO3SVzoqLJ4YBQlPkCMPbEBPrN9XvK7tP1+UvPIB+96ZzIQ0fmNX/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199015)(4326008)(8676002)(41300700001)(66946007)(86362001)(66556008)(8936002)(66476007)(5660300002)(6666004)(36756003)(316002)(2906002)(83380400001)(6916009)(52116002)(478600001)(1076003)(6486002)(2616005)(6506007)(186003)(26005)(38350700002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5M2wi5udouD9Rqfe8ujTQRCkft8KagKAhf3ta7axYhFJX5oo94b7iUFs9oR?=
 =?us-ascii?Q?rgAN8W3/uAiFD8tODnpGPy5UgtUOydvhJCJCSu1LgqzzxAyuGLhgSomQIVTu?=
 =?us-ascii?Q?Oi3tV3E3Af5bpb4fAuA10eYJtP0Veyq2ythMoHJ8dU3V4hP1vQRVgV8GlrrO?=
 =?us-ascii?Q?gyopDm8g8UGTIlMDkH+ZE8/cV084Iu6JhL3jsN8NFMRqP721aQQhuSZVdnk8?=
 =?us-ascii?Q?YQNx4l3MGtCcVCLtAywuonVRMB0kvUzdaEsKNhtpUnPvEAOauc+EH4WsRHUf?=
 =?us-ascii?Q?XwlQ0mNw1c+sw+l4coWKizKxvjSGUUUxesOJ3+UBk2Mb35q7Ceidg9h3hblQ?=
 =?us-ascii?Q?wRwHYLyupvLCGBptb8WhpFbKKZ2guymsTqV796bR3V/NRHiIBOZGmMWkrT2k?=
 =?us-ascii?Q?xdvPj7Z7WlXeedZgl3eTJgzQKCWl82s9XXhZzxSEpkvzkpedvcf3GgTOKUae?=
 =?us-ascii?Q?FOuGobWeSOn8gslwv8FB4m3gs+0iipa0jLSZXlcLxKIRqGK6lvVPNgj29Nn/?=
 =?us-ascii?Q?Es+vFWMHWhIX1e0VQg/KiKo3EQIn0XZpbwoky5sNKbGUo3l6erJnsT5pcAu+?=
 =?us-ascii?Q?yWaGW/MjhnrqnAVXZsLG0JQ1QN8PZUPHQlwUJUwANM/8LRYIX3XSQ+h1ifc8?=
 =?us-ascii?Q?ghIxgOYZGz4EPZD2v0aGSMwAkq55wGQh7DMel20tYa1JrVbxnANn4sxJhZPT?=
 =?us-ascii?Q?B3nldBrPq7RKr+b8FWTK+ggAUtpmDnTnJ5MG7zvdXXB2bAjGOdbNSrhE2FUR?=
 =?us-ascii?Q?EfLm6Ni+dGz0+jWTNs0ZbZu6SbRgKfg3cwqwXmJfGNVoTF7zmilVkQ4BfhNW?=
 =?us-ascii?Q?uWY8ks7qJaZLocueVrxSWBeyF5raGOlZCo6ldBp521f/9WTqsbmWqcnkMKwj?=
 =?us-ascii?Q?o/N9K7U6Be5VuZhCTZsXDWhI23qXd8U9CkPQsBSNQfzrenqbzDBxVpF7H2s3?=
 =?us-ascii?Q?/PwXf2BCj2mg7To4RTU34PScFrYWxez2lmOv575TlUwy+6wLESE9SbTMavyu?=
 =?us-ascii?Q?ZrvsOJxt6khts+OU9ZZBf3R/bGeU6WkG/ln2ZqvqSUDikDPBpTtuirlCRb7d?=
 =?us-ascii?Q?HdLvZpuX0boKRAVj2OWSMBqqfqGntcDE3ZIOzocI3U+8/ar8X1AhuDKaYsy8?=
 =?us-ascii?Q?mnfAaqgvTQQoTmj3KPx9vSPPvbC43nQRWm44jif4nmAR//yXnN0WMny9+HQQ?=
 =?us-ascii?Q?d1JyOTYkoV5VmuHJIxb5mayl5nP5kRte81FeVn/7VLUd/QqfGCezHU63uJzH?=
 =?us-ascii?Q?Zne6z5hBYNs671VC5H0ovjrfRZ76nr2ORQXUxy/eoYR8q/qIyQDLCQEqzxWD?=
 =?us-ascii?Q?1uDwGAlqe5/Up/dLbQg+9q0jvX3O9sovAOq+foXjZEAg5AHP5YydfQldmOQW?=
 =?us-ascii?Q?DjDHPe1eT9gCENp81jSC3yGsjV2XnMYRpo/wSWui0ZrhHTgU7Jw9zEpup+sB?=
 =?us-ascii?Q?GHC7k7RLBolT+YFJr7p7ASKx+J1boVXEZukMqhSPysEMpJtIb7pnvm7QQ2En?=
 =?us-ascii?Q?oskIZQSvlfzk3Lrb8UqtPPTlzlJYxg5pZE8plMNZbNe8n6eTFz+TEDZQzFpC?=
 =?us-ascii?Q?ih0LXdG2eZ5P/b37oaVkr1pKRniWckr2JFS0gkLP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d0d7c8-130e-4128-db5a-08dae6ef1baf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 03:13:06.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9pBJmsgHxkNeUoqdCplxd9ubY8pkt2weFgUSXK24hSikil04N0Y85KKnlcwgiZGr4qIbdv5ANrlwLRmdEsLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple Power-Managed bus controller may need functional clock(s)
to be enabled before child devices connected to the bus can be
accessed.  Get the clock(s) as a bulk and enable/disable the
clock(s) when the bus is being power managed.

One example is that Freescale i.MX8qxp pixel link MSI bus controller
needs MSI clock and AHB clock to be enabled before accessing child
devices.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4->v5:
* Fix build warnings when CONFIG_PM=n by using RUNTIME_PM_OPS,
  NOIRQ_SYSTEM_SLEEP_PM_OPS and pm_ptr macros.
* Drop Geert's R-b tag due to the fix.
* Resend based on v6.2-rc1.

v3->v4:
* Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
  (Geert)
* Add Geert's R-b tag.

v1->v3:
* No change.

 drivers/bus/simple-pm-bus.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..7afe1947e1c0 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -8,17 +8,24 @@
  * for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+struct simple_pm_bus {
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
 	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
+	struct simple_pm_bus *bus;
 
 	/*
 	 * Allow user to use driver_override to bind this driver to a
@@ -44,6 +51,16 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 			return -ENODEV;
 	}
 
+	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
+	if (bus->num_clks < 0)
+		return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
+
+	dev_set_drvdata(&pdev->dev, bus);
+
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_enable(&pdev->dev);
@@ -67,6 +84,34 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int simple_pm_bus_runtime_suspend(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
+
+	return 0;
+}
+
+static int simple_pm_bus_runtime_resume(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(bus->num_clks, bus->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops simple_pm_bus_pm_ops = {
+	RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runtime_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
 #define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */
 
 static const struct of_device_id simple_pm_bus_of_match[] = {
@@ -85,6 +130,7 @@ static struct platform_driver simple_pm_bus_driver = {
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
+		.pm = pm_ptr(&simple_pm_bus_pm_ops),
 	},
 };
 
-- 
2.37.1

