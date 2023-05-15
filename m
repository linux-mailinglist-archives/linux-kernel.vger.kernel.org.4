Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674470272D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbjEOIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbjEOIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:31:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE03010F4;
        Mon, 15 May 2023 01:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQqG5clz7FyXM7rioDQ8U2R+SYI5q3GZGBXaGlLIH5sLPUY0ERAgQ+Jp0Of/VtW/9JCxREw1+DRrRozJUh5IlDytlJZpX2ZcORJ+DNkVH2GstGPrup0NcvzazY7eFzTUoAeloHMRz+l54HV0R3nuZ5eKqeuRfYwPtn2gg/yv/WB+LPeBGTtGnUWPrkowucv1xJtj8IenKIc2TV16UjZiU67+nDJfmvKxZQtmaplFHZKA1md9hcAlFl7FMDMzBSgXelnf00Tp4qZIKFquzUbOvZ4b3YM9OP+anlnQzuBvwj/9z7efIJUcZnN5o/o4JjCc09AaxP9mBbwOAx1rpfb9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtY8q+oe/IBcLLEryTwOAWNzXUryPqXOGzA8cEpCmeU=;
 b=kPq2SfV+pCSTm0DfMuwZqWAU3lk/5h4GSRGGyyM3XafMhGBYh3W37XibIgGSwYHMUkwc71Gkm8/B+yWDMPednkUda2Ra6aH6AqF4Z/9MhyZNCwdIUDN5YbkgGnSJc2lkB/gLCZdAwXb1Hp4JKVejoLC50UktOU626mYeutWn+p4eflCeP6daR39n/vh+1DUUKN6MVFhRytjh6U36upMUfkYWSrNVnlFS1TYxZmvaqFYJHAjWe6FOrCRKvZG7UNY65DXXMVISjFc3rsEPqksHbqkyKzksqIYUeUJ4aIKNmNcD+pQ6ViYhXE8zBdWMC9MZT1SSyjGtKgcxQNNWtF/Yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtY8q+oe/IBcLLEryTwOAWNzXUryPqXOGzA8cEpCmeU=;
 b=bHHfBisQV/Mqw5rZ3XigD8tK79BbOtCOhak1UR9iDHA6iyOP/8tzWAFkClRHfhxYmCcRV5qx6KqH4jjeE8JL7hdo6/y6XrUzuOUIFSLXxfIFULU7VD3py57kniq5tflkd7ZpdPW0lvmCHhIe40Pwcn0mnpnblc+xRkzBXCeY3ukf77i3zI7fEGnbMzoCPvn8XYdHzfRCOoE+V9mycW3tDi4zarCpk3r8rCbJKnWbdnEm9YBVYBY8q/aZGzbxF3ed84Yt/7I8G8Grl5lt3BB7wo5qy9teFchz3l6rXoJpfQu6FeKiVWDVAewJorlRkowzu1ow5n5wrsbDLQawE9vwMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB2169.apcprd06.prod.outlook.com (2603:1096:4:7::21) by
 PUZPR06MB5617.apcprd06.prod.outlook.com (2603:1096:301:e9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 08:26:43 +0000
Received: from SG2PR06MB2169.apcprd06.prod.outlook.com
 ([fe80::51d5:9a57:618e:bb10]) by SG2PR06MB2169.apcprd06.prod.outlook.com
 ([fe80::51d5:9a57:618e:bb10%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 08:26:43 +0000
From:   luhongfei <luhongfei@vivo.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        luhongfei <11117923@bbktel.com>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] led: qcom-lpg: Fix bugs in lpg_add_led & lpg_probe
Date:   Mon, 15 May 2023 16:26:20 +0800
Message-Id: <20230515082622.24551-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:820:f::15) To SG2PR06MB2169.apcprd06.prod.outlook.com
 (2603:1096:4:7::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB2169:EE_|PUZPR06MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a405c7-ab47-416a-bd3a-08db551e1d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqeqgAhxuTGufEt+rzzhgm7x++1OhAzxaxKKz3cLO1U5O8wqXJpZNNUiuFhTUSK0aZkur5GUrxXa3FoRm9h7dJPbnKMHTycreBvQKdZBcerYL6alUWW/Xx8iEECYC5JzXuDrVd6FYXZlTcORCrLCQggG6Kxz/LII5ayPNmLig3oSSF1QFEvOjvr6UxRe1d5R3GQPeffwBrlsS4alT65HnNWNgPSJAw7oIrrfcMX4xRINM/Z3iFFz13dtodgOjYAzbA0c/aEwYrHrhtwVsD/ipV8egQSUWaQPvrWpYc0edLoCvGL59+aTSuncz8rX6w2UwIjDQN8FUimbzKcj/oEhZe+BzMAnXyW1ihYzrPDUzFCyOr78lvLe2X9SfMkd+IFBhbLujSOQpEZ/35yNtyG8ifyaC7uU8V9OWnYDqeL/hD+dAeTNc9ftatib0l7nBD/hyzz9SIpwteT6FBgj0n30Yy6ZmZRDk/Bk4NDsK3b7NMuIOiE4J7MmoQilLmxP3aScxF4BIxAD5JtuYuTWx5DdYggB+m6xiBcEQ/y/l3VbkTCV6cli5BH6TOqpQ8t7toU8Capw6clceyYyPA8TjBEeiTqPpeM1i8AS97CLZJp0gzccARY7qwzKnr7tFtH1XjlzyyFxKkFjFnsCMnYeGRANIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2169.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(36756003)(86362001)(110136005)(316002)(66556008)(66946007)(66476007)(4326008)(52116002)(6486002)(478600001)(8936002)(8676002)(5660300002)(6666004)(2906002)(7416002)(38350700002)(38100700002)(921005)(41300700001)(6512007)(2616005)(26005)(107886003)(1076003)(186003)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cBUF58lu7oWiGOSCj6Otd/YwXAjpteL/N0jic9aMA5PcwfNMF6Bk4N1vxQ+z?=
 =?us-ascii?Q?dcedFy/a2GIhqbIbESZmV93rhgXbSbZylOTpRmPYw85e2KuMsMmLy0mCpjML?=
 =?us-ascii?Q?ZZqMvTKLZIF6eI+NVLtGg2QXex/dhU5e4Iy+fFb8edYnnBJByLknVsmot4Sh?=
 =?us-ascii?Q?X7XH/QOpWtcPw1qD30DkJaDPgs24s7MKrN9YNF1bM/O9kjBmblVzzNUQFjM8?=
 =?us-ascii?Q?cEIuODfMyBKiu1+6wYZgr+7A1fGLWXp2tbBjwwH6GQJCwmNaO/G6uNF20K5n?=
 =?us-ascii?Q?YIVxSKapkTSLzvBghIKNmB+sS/wOPBRfqA7yScaCdwypDy21KNpAP/Bk0a+s?=
 =?us-ascii?Q?6plVC0lLKQEMMgunS+5l55mq3UVJxKDJ7xgZfpkLOPF7xJwRYLUxEG/WU2yZ?=
 =?us-ascii?Q?Vm4JHAhVSzOjNGsJqfKlbLgXBTFFVlGbq+rhlo/qi/nQA9ZrBN5MeWMT2iHd?=
 =?us-ascii?Q?nuOfCTGH6LkuL1ITovm6DHHagN0tjiNtrlI3Ac24LTKuFmP/KBPmHS2aCgau?=
 =?us-ascii?Q?nTyYbz0nrA6XgyNfH9P3k5U2JWGi4Xk3u0DSwSUttyC3+DyVdbG3MBcVSIjC?=
 =?us-ascii?Q?LHRSksBZ1mZxpP6IbFkgei1/oroUghOhzWzzavgiU5CmmCVXEJmF5WBZbvoG?=
 =?us-ascii?Q?5nCawEWAixsB9RN3snH2ubNTF+YGqP3mn0+7dbyFIXaiNVG2WBFYb5Z02sGN?=
 =?us-ascii?Q?KXeLc67VhEAy0TOMpICVJcDKzOzNLHAGPcaKmgnAX5O5kICjg3baVpXfoL+k?=
 =?us-ascii?Q?wEPIj/Q78EWkMi172yEzJb5OTlI14iWs2QhDGQ2gE1AegRd7gpa4by2NxfMq?=
 =?us-ascii?Q?NXb6XRwMx1+rUnhdvXjykMRbwemoSUw/ankMQmlwjJhs2AmimdLBKmLSodvK?=
 =?us-ascii?Q?fw42nWFe5OLeLr4jX71k1PCwdw49N0MXq5i5NCErNIRG9skyDQ6IY27zEAO4?=
 =?us-ascii?Q?t/MO4bdN3r65Re+2oQy+1uQpgSn9BEgNo/0BsqKll3BQnb8gU5Yn2Ok1j/zy?=
 =?us-ascii?Q?scV+qPnWJtoEU+CQt1y4W/QfzvKHEU2DoLQqk3trVqXd/8WlRwk+fId2xlj8?=
 =?us-ascii?Q?l+5cmgFcD6g74jK7gC9U2r//YK9/64n8xCFHTyq/f0Jo59sKrrbKO1St3tJl?=
 =?us-ascii?Q?dYWNc23Wo69VUmoiNz+gMg/rT2yiuPcQBVCzRhNHdbjwvcCWoL0H1/Uq3FET?=
 =?us-ascii?Q?lsLBUSC0i7/6aJplHlWpwpN8FPoa8tk4NXU/3+vxCwcetw7mTzbFn76tzozT?=
 =?us-ascii?Q?Nm34Pkt+GUMyN10UIUXdCVTLLMUxoqimIZ+0eC1F5VMxWShNuFaerdI5qJde?=
 =?us-ascii?Q?1J9Nhm3Z7mqYAoQQ76HV9UVrKy9zh/bFoBngobsroMA5Cx7wftepehBWAOAz?=
 =?us-ascii?Q?qO/LaYj/IWcG1K4dQI3yo05k9opLALtOJE1E8QfWtDR7KHYvJ2Io1vm3Yf2w?=
 =?us-ascii?Q?HUokvyYSHfvN4GYZtxNG/tUNJzkuT54xTk6mZovqw+55lYLoY2wjv/4zr3ys?=
 =?us-ascii?Q?SHXCRIDqx8l63HieEb57dgH59RqW2MtibMLFdw/DPF/VuURRVmVVMivscE/4?=
 =?us-ascii?Q?Jngp5+5FWVoJdg2jtGJgDBJf4v+TpHRykXcpfj+8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a405c7-ab47-416a-bd3a-08db551e1d6c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2169.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 08:26:43.6462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/u3ZKcOevXK1PteDhF9ZlIU2CzlbypTW3+mVz3bMuvf9bLcAg4C4q/pd5khhES8w8+XBMqXXY+F8tcvxuwXUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5617
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_available_child_of_node in lpg_probe and lpg_add_led need
to execute of_node_put before return. this patch could fix this bug.

Signed-off-by: luhongfei <luhongfei@vivo.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 drivers/leds/rgb/leds-qcom-lpg.c

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 55a037234df1..0e8ff36c4bf7
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1173,8 +1173,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		i = 0;
 		for_each_available_child_of_node(np, child) {
 			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child);
 				return ret;
+			}
 
 			info[i].color_index = led->channels[i]->color;
 			info[i].intensity = 0;
@@ -1352,8 +1354,10 @@ static int lpg_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		ret = lpg_add_led(lpg, np);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	for (i = 0; i < lpg->num_channels; i++)
-- 
2.39.0

