Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46DA6F3229
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjEAOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEAOh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:37:56 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5910E0;
        Mon,  1 May 2023 07:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAkK1VMQT9N3E8RKmYMhLANdK9w16ByYkrsSDgho6e/XzB+6xGHzmlDAZjMRprOG+G1dtISsgMjpSILW+REJQkZScHPlegSEfCdUD9e4d96kB6q4IZIFeep5eiY295etphnw3GIS36ZwLjj7B+E64tEFTZrjBoJHJBK+xb4Wr/tM6rZt2Q/EMtC/rIpd2F7toNsTVgbFMUeRU43JiJZq+UbmOovn7FLzB8hL0chH+JzReHv2XDcbOqkQN6Gel9vLtyjZ7oLUkuUqi2GJ+s+/BcbFBEMTq9e2jRrj3twOXEZcAdwDQWW00U1WAS+RCufmqcONI4BAIxw4TL5DMw0ccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRzkFSLryx6vxLET7OjXgM6ktwPxSLiDRICD2qGoCc0=;
 b=YevlzZyT0jp319Y58FdFTzxglO9K4lYmA4cApC0coDfe+A9nGj7f0wN4jS2Lsmk5K3HnecxkGAcp3GiWGPQfd52YasfbIDNARkJFsDYQDak8zIY2BVfrWeAe3UjmOPxIU1twhiqnigp+Lmxkk3dXmW9hx0D/oHvqBmv4KHAMEdFKkyt/leeNghKv44jbx04G2+BfkAo24kMXz+KdksGmxBRSIv33WAKK3hVvybLNn10DtSCPB1h6cvxJYpPzzWVQ3Jel0c/O7EzspeRVMgp5bkpwyHTn5xCVpYfpMreI3MSGERnUGzM/cYBJi3Fstgp1J82e+TehbXU5FT2ge/k2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRzkFSLryx6vxLET7OjXgM6ktwPxSLiDRICD2qGoCc0=;
 b=K+b7v4vqO/TSI2E721qsvKuJjmL5pZVhCnfWyiB1iYrS0ab85L2A8iDc8U0t7FeYPYOznmshmWpy1cvygYeUhpj0Cbpp3Xf+ntOtJv/HIiNdLETCIpUABZ+tgeZ2pg3Q/uRz5pMM5HdKBA8EAubX/CWasyLNsUIUNySnru+08U8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 14:36:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6340.027; Mon, 1 May 2023
 14:36:24 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ajay Gupta <ajayg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 1/1] iio: light: vcnl4035: fixed chip ID check
Date:   Mon,  1 May 2023 10:36:04 -0400
Message-Id: <20230501143605.1615549-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:40::39) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 8763d4ec-05dd-44b6-450b-08db4a51705d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fu9KYLva3krkAO0TWPvcxMwvMhh90VZ484J+uQGPuuJKTb29LzMA6zAsWiOyZTxrsOwRZXa/is734WytfwMsborDXeWHphbAlgpsIOgFtC2RqG9U8HQMxZgYjKhS0jBzYLK27gawg0GM6Mku8tZ8f+BY7w60jxMSGlngJsbQk8TB0bSOcHujt8h37ShaziqPdr2w9ItrwuCZLv9v+JjPSxk/M3bKPbYB7FGboyOXCMRu05sERdzYOGLDCOL1hcYSaFU3nKSh2ZEw+pdvqlD8tZ7Rub928NFKIUFqz9v25Ro+UUEveAeHfeM+qptiKqhJqsc7D/Ba7AORNanlYi2AV13FMz16XMIlj9p0qSbO5P+EMi7ICYDYjhQnawbp/RTEhPwf6oTGIsze1o74M0YipG4WnYD4MdSQdZV/l3spmpv9IwBPFONVD7U8AGoNQJRY4KjZXujmwTg7+j5vV0bmcUcxA6pFq7LzQfAqLrDypuweugjY78EIccdolj5dfjW1raZ/2q6HzJ4bsf4QKwuHPTWWfiPmbUs7A0OXCwWlgm3UQUQ3YFA8MVlWx9CwBIFOYfiQGY/T8JmH2cyo8c/VFD141gQr3D6X+sYIZgZQJm2ym/BAnBMSNOr5P/y0CmEvI8XlftJeXqQS6cM7sh7+Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(2616005)(316002)(6512007)(6506007)(4326008)(8936002)(7416002)(8676002)(86362001)(5660300002)(66946007)(478600001)(26005)(110136005)(41300700001)(83380400001)(186003)(1076003)(2906002)(38350700002)(38100700002)(36756003)(921005)(52116002)(6486002)(66476007)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHvuJwuHiIiUxbERoMySvN7Ml2wBd3EfOd7KENqONyOkHerkBa1dq0p6Bslo?=
 =?us-ascii?Q?bZlTx/6j3XURNK2ARw9EGayzGxfTHYDMP8XuBve0CgpXUcxhaqMCQ4hX6iQv?=
 =?us-ascii?Q?gBWsndn4wSJY1kMG2PYVV+oBoMSMLINvgCWBtewcZttYeiIFjAo9mEnDS/Uq?=
 =?us-ascii?Q?U8VtJ+oZCbX0bPjjPLrXRK8ovRC2aIq+ZPu6gMIrzq8WDQ8eSC51BEYr2Kzc?=
 =?us-ascii?Q?MoGXorxTfhROc7V1vVewscxWCQUSokqu0TawPNHG+LUFJkboB68I7QaP2Yry?=
 =?us-ascii?Q?oD4q7hzjmRe6KpohFrKaAku8zYIxB1yg4fNPqqQpUwJzIyLhw4Mx/mt15m+7?=
 =?us-ascii?Q?wmyI5utojrs7cEhav7N6zDflUExi//c84MzZTIWk4AddBb1RgJAD0JWFQjTV?=
 =?us-ascii?Q?ZAM1J9znKL0di9Q90787ihJI2FlF/1DToATgl1TjXx9Rh4JBZFYP8CQzMVn9?=
 =?us-ascii?Q?OT41cFmabXM2QaTCqCqtAy0JMjYI0oLX56FKZAkOwkgO7mFbflKChbNcSHa8?=
 =?us-ascii?Q?lyk9sQIQ3AoeaP8450DhoXNjI0XQRSx6AeNNiCAaVLdSSXgvpxUeXFwzMlz3?=
 =?us-ascii?Q?c+SXhZw9KVnQf/B0Gvy3sfq/q8KbKhiZkT9aJ8Hvxe6d0Og4P+FawBpPzqXI?=
 =?us-ascii?Q?4VspjhAdM7a3Gh8LESq43IyQnIA/5rh5YCyqIqCNwLhv3CLRiLFsoBWsSm8d?=
 =?us-ascii?Q?cjtoRF//ZZWpza690rm+xJmL10cikFK+71UHUXwe9uiGADCaMDntN3f+6iPM?=
 =?us-ascii?Q?7zXIU2WvcSo8h4ArVWOA7s5f7OgBCxOaEc4LPDny4ZD2qnr9JqaVQvDZFXJ3?=
 =?us-ascii?Q?jYpnZMuns/vB9Ypg6/IO2qVA6XLU/18K030Owf7V0IWQPnITm0wSY7QF64Fa?=
 =?us-ascii?Q?nPK+hyLt3u6+L7eAt3cvNEAfo5MLnRwQoDMxoXCrKL/ozPJhqeqou+ZlRQyr?=
 =?us-ascii?Q?i/2hCPTYkTAwC8A4yOkq74qvNmAV4V/z2Vjngy9SYaGY7Kl59ss7D8npJilt?=
 =?us-ascii?Q?Yme5MoY0/p3PPpnyX1is3HeApChpZONpNBP+FSrKDZq2CEfLipqtff0bEgS1?=
 =?us-ascii?Q?6pkaXtK6JxtUp3keFVTyR/K7vXPVaetiD2Xm1MdY+Xm7Ca/EGTA2dIYaveTs?=
 =?us-ascii?Q?/V7Dg9RngZEG4sM9bPYuaV1UBAhg8r/CT5Bn0rU+T28ThTL/H/n8TydGpnqg?=
 =?us-ascii?Q?FRstiCL7hFMcPLLxNqy9nA4MonNVCG9/OdTAJfgExEoV7YLtIz821rRrXA0J?=
 =?us-ascii?Q?YCzz1RFkm9/cxC0vG5c2Q7tynqroxEYiiTffwG82OjimkffaSjNNRr3fd8Ui?=
 =?us-ascii?Q?0HjLSxFtLUcjlMlgZ5xUk92ht/ZGfY22ARXY52wEwjUh2nbhOR8c6/ta/Hot?=
 =?us-ascii?Q?2sW4QO+vMQeOQ66d57I0QJEXSaZq/RpE6v5/pNkjhwmiErMZEJX834iG0ad1?=
 =?us-ascii?Q?M4y2iYVRd78AFOFRWHP6xHPj+cqwyOZhWUvcO1nxcnNUCjQJwOZXomCCSw9T?=
 =?us-ascii?Q?K0L11kP8R4c2G7ldnMHq4abck42UcW4FN0sF//aUvWwBnUXwbKAXcHPVw0t/?=
 =?us-ascii?Q?JA73o8QSCxQamMUXZQM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8763d4ec-05dd-44b6-450b-08db4a51705d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 14:36:24.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8EIUmvVQfJQpj0IzQlCC//pjkKdYfjybTOB/jDJWwUgHdwhkD835FI1FOR0PmpgnjGe4Z+7YmrKs6jRIO0q+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCNL4035 register(0xE) ID_L and ID_M define as:

 ID_L: 0x80
 ID_H: 7:6 (0:0)
       5:4 (0:0) slave address = 0x60 (7-bit)
           (0:1) slave address = 0x51 (7-bit)
           (1:0) slave address = 0x40 (7-bit)
           (1:0) slave address = 0x41 (7-bit)
       3:0 Version code default	(0:0:0:0)

So just check ID_L.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to V2: 
-define VCNL4035_DEV_ID_MASK instead hardcode 0xff
-using FIELD_GET
-update commit message, remove a space line between fixes and signed-off

 drivers/iio/light/vcnl4035.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 3ed37f6057fb..a23c415fcb7a 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -8,6 +8,7 @@
  * TODO: Proximity
  */
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -42,6 +43,7 @@
 #define VCNL4035_ALS_PERS_MASK		GENMASK(3, 2)
 #define VCNL4035_INT_ALS_IF_H_MASK	BIT(12)
 #define VCNL4035_INT_ALS_IF_L_MASK	BIT(13)
+#define VCNL4035_DEV_ID_MASK		GENMASK(7, 0)
 
 /* Default values */
 #define VCNL4035_MODE_ALS_ENABLE	BIT(0)
@@ -413,6 +415,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
 		return ret;
 	}
 
+	id = FIELD_GET(VCNL4035_DEV_ID_MASK, id);
 	if (id != VCNL4035_DEV_ID_VAL) {
 		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
 			id, VCNL4035_DEV_ID_VAL);
-- 
2.34.1

