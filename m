Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC16A5406
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjB1IA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjB1H7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:59:54 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8922BF02;
        Mon, 27 Feb 2023 23:59:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDFVkym7s/DmZ46nYPqhv9P8mZTYd4k4wpUdfzQ4vvjFJcDIgbw/3m1BN2BPsSA44YxSJNnVjvgiHQ1TV9OlFAXfof/b4gAQZt2eSzNNr0eoT4MJ2T2QD9rIOO1oHbYjYd2RXKNeRRvGDgd31tVfZPyGzK8BGR1i6LDiSscNIK33aKqIMm/rHsuwkwLhb1jX8s/AJTH5eCBCyfgUfNgqjUOiAHW4EnCNei3bV5W1cEP8C+kOk+cwmiEqW+ttddBP26i8tXn6FWSxjM8wGR6bjuBgDM4/lMZlx2UaHx+cNyd3gG8mMLegMEN75z2cZ+XlAf2b/SP5J9M3lZa4St3DcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioQNTaONFci2m9d1gUVvGUAn6zVcGk45Nue7cxBicIw=;
 b=DF8X1u62b+rUPvkk8JE5tKVbsCEsXCMhvnw97Kb/M6p9YpbzTv8g7ttdCeLUgitAqkOiUjWvFESOeJLJbFBAOz+u3b4BgGnoR1io8Q/9XgsZmyU/h9oC7SICO+rZQk2FWOG1hSPPL+QblQ8p7EJqLuquzf2QSSzfY5LcxEC+IZPGVeN9oYEz2e83/BbGV230cmKpTdVbw7xSSNW/rc65URr+y/sqbkrBoJJoH9Oq79UeEtVSxl67BTfnieyK4N79qAtbYIzNAQR9HGbxudfSPqTkCtHRbCL4SlUoRGEgIeSTKIc/vLlMDBqvnh6KUNP479vBlRPxFvhNqnxmjFQFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioQNTaONFci2m9d1gUVvGUAn6zVcGk45Nue7cxBicIw=;
 b=rgD1tUQ4Ww7Sk7PxPqyHvUrOCV2BqtFls16qwtieTl9XKC8ifzCjXYcxZJeZSETDKr2gyLCDMfD+TeYKnnfTnIPRxQWBoZnrED+Bwx2BO2cU2gjyplrgLKSMWW/7F73ww3khg4/vdkVXG2zS2+6vO73LVSEZWt8t17aJfH7G5h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS8PR04MB7685.eurprd04.prod.outlook.com (2603:10a6:20b:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 07:59:36 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 07:59:36 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     peng.fan@nxp.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jindong.yue@nxp.com
Subject: [PATCH 4/6] PM: domains: Export genpd_dev_pm_attach_by_name()
Date:   Tue, 28 Feb 2023 16:06:19 +0800
Message-Id: <20230228080619.412820-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS8PR04MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b56eb7-616b-4d0c-2eb9-08db1961bc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8UCJYTrqjz1QRIek9F66mHLnQej+8sicavayo5Sosq2dDxJRIPKkwBcrh5Ts47mqZPqPW+RYsITVo+mJfXlPzJ8q+omCx82RlcPcmPlZ6PJ3/rb9ZTKFxPfXQhCTqzUWvHBNSfTwmjIEtIpFNIc2Zu6v05QiZLvt6Dqn2ugO1weQLKfD9195OTvlVJ/LI+BfDhgFznv63DhI0UB+AwsSOuKLDX84dK3NvlMmJbyNdU/LeIGgx84/N42t0KIDSum8Sxdk24lUHwR3w7FO5jdhKMjq37Md/8Bpj68O2VM+ITBW+GKew4QCAAc87VBLLzyqOarcMoYLjYPL3VYXCsZ34wmIWN8ww6CF3AWEHtCbMO41OHuDN3t/rkVoYi3HOzps+Pqz5bOmecb+mgA/XSdwvBb+EPQZuKq5TG8Y4qr91yCpQ7kWE9nXQoVmvwOWotX+AWIeOaBH51M0oa3mW4/X7iJQgTx6VX5ybQIYFhY1+w4WewwyfRXVW1jeVJ3/D/2CbMXIOcTbnY3niODzYutcjSeSbtcBacXAEW0NMY8cF1TtJ/hrjwsnzwP0tELKPWRAvjiOYfN/T1YdUsBbKn8qICfnT1Pmk1cZm5lZeWRlnfr9mIbIdEr2oCYfSpB24BkIkJTXu1PrzODPtrWoyr/FiW2siDXW4/lv2fbsgZZd6Q8GeEWZp77drcd8JRyfHejenppXVD3CQ5tVkUHj+Fctg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(316002)(36756003)(4326008)(8676002)(38100700002)(38350700002)(2906002)(6512007)(6506007)(1076003)(2616005)(478600001)(186003)(26005)(52116002)(6486002)(6666004)(5660300002)(7416002)(66476007)(44832011)(66946007)(66556008)(4744005)(8936002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KuorIt9ndfPoa097vP3RAycWFJ3KiESx+i3quDq2efKD+rQXGltHPGi0YSqr?=
 =?us-ascii?Q?L3i+N7RaHKEG47eZTHq5lFjubaHlmQr1NPMrNSYQnv7yEXzG7r2qGfAajQ6X?=
 =?us-ascii?Q?af3kaw6+cjcvJbCQqf9bDoUo228NtP+n68DC2ie+WCpEH1SvIqvR/3xBAT13?=
 =?us-ascii?Q?ksUj+J6UBMt5R5QdlF3pjI3jtvS1CU3uiAR+FT1wc6R7Bn1P2118eyX+OzFn?=
 =?us-ascii?Q?g7tbBAYXbWhQXGwojm5LhMeZ6LjkSBdnb7JxdFr4N9LVD6oXz7ah6VOzJ3zV?=
 =?us-ascii?Q?G8KFPIOz98OLptPHloEtVvb+f8XHSFgE2/QxJ3QnNIojMJaP4jfAEeLabJBK?=
 =?us-ascii?Q?5SttdeQfsyG0TVAtGjjOkKtxQ2Wneju8UfqZSnUg6nB3xi7+OacEfbUQadXz?=
 =?us-ascii?Q?Og10v1/i7zPZBvUfr5lULg9810w8NW3ssIS87N2VSqkJfh+RWGBDT8fowKOz?=
 =?us-ascii?Q?Ghh19cWq25ylIG+RoJIfX9ayztHKUigp7CUnAMVebbMYeC2t2pWXbq10ZmY4?=
 =?us-ascii?Q?Ez1qis2iHdYCamnfte2WfKJxhFSui43JWxKusLnCXUiV+v4bUvF5wJsR2GFZ?=
 =?us-ascii?Q?hH6AoDQC59YDo6u8x3UDfbvR53yGc/5Ln2c3RoXEhgDdpzFW8vASWo6jDaqP?=
 =?us-ascii?Q?HrZ+sNMX2MU49/nmHEL/VD0uyPEpggUy1nxhsTbVvmTgnYFhlE2dAaMNl0JY?=
 =?us-ascii?Q?DXs6JZhwlqMWrn4VUi3Fi2aTo+1Gr1EqunDMkFBkZPVW3iGLiP7OjjM4iJLy?=
 =?us-ascii?Q?dJO4mLTfQI6XI4lLGRllqm6aYq0rSSBYUDH1K6J1sKoYzKMaVAIoTjxnSZqj?=
 =?us-ascii?Q?rxpntkCQYhPwTHz9MWXjKm63OiKRGn+pJeioWGOnod9V21Bgiud8TZGNxsOR?=
 =?us-ascii?Q?tjcXtxzo/+ODv+otXViKTSw5CJPbe14sg/j+dC88N+SLVwrcwJ+lE7D3URT1?=
 =?us-ascii?Q?FzVV/p/sBCYIkJbJtPc/7uZLlrqwfopjPuOOBSOZrEtgKSEsUoubCzL8IlGs?=
 =?us-ascii?Q?55GA4L535VfVB0umARWyiZqbRe85Vu1iS76H4b+IfHZbfYT5ZNnCzKbXZyQl?=
 =?us-ascii?Q?/WnKb947NW9lCqKdEQC756aJDTUxYvwdAg9Tmrq9gw+uzggCegXNIAk867ng?=
 =?us-ascii?Q?GhEZWM2gd1mJhV3cKoOsfoj/l1a0gcC9jt2P/JS3OkDJl3JW6kLz6mLVW10O?=
 =?us-ascii?Q?WwHh8SSKlscE01xEB0rtpn19BU/NH4K82dqKxFVzFaudlblX2Y6TjWCpwF0K?=
 =?us-ascii?Q?bfbO2tSl/UtZSbPrsupw0mK67joomy7A13DmjLeqZ7RfxS6reYbs6852B0oO?=
 =?us-ascii?Q?HZjX+qSCIYWKw4RY/9W0bcehn2+C3qqH/m60lD52kyEh/sfsLhhtD5inBHkg?=
 =?us-ascii?Q?hIHb9T3APWGasSc8rykUEsECYopwzPywwmmEFGGRhpn/xe5nmtQ9A1rnixiZ?=
 =?us-ascii?Q?WS/Udh71zCBu/AEU553ogjQvnBg4aBc7NWFVrNL+MKkpmdriP0f9j01n5TSV?=
 =?us-ascii?Q?+ribx4XjvFvgXpD/so4JVVALIU86YxYG3rlhxdc9hAaQJ3fbX0L6U3PAFUD+?=
 =?us-ascii?Q?AeX11jso2DJ4paGtDS5lVcIrNqU+7u/5rb6RbvBu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b56eb7-616b-4d0c-2eb9-08db1961bc3d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 07:59:36.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzlvY5XYrIRe8uWzEbkaM1MwfXVRfDzL+FPK1ryt2+/lbQXmhHagoGIzAYoduXVVNHaT+33bngOx6bpPrZHTfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd_dev_pm_attach_by_name() allows a device to be associated with
its PM domain by name.

Export it for use by kernel modules, such as the i.MX8M blk-ctrl drivers:
imx8m-blk-ctrl and imx8mp-blk-ctrl.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 32084e38b73d..6d66b6b14863 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2908,6 +2908,7 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
 
 	return genpd_dev_pm_attach_by_id(dev, index);
 }
+EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_name);
 
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
-- 
2.36.0

