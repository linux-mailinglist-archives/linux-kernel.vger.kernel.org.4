Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5573F9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjF0KN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjF0KND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:13:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA32691;
        Tue, 27 Jun 2023 03:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5NAj/3gqwxcsEgAz3uw3kOFa2AVSitDqZDFGjEF6FdHdw+wRmItzIy/TUCRoC421sF88kml/D2PgliHrwvOsaEG4wEE80TUDx1HKan93RtOOZQdOHRQ+iF6ApgS9ElF2jJ2NMbUl3StraatCN/F+jTY04/ETJx9WkyLFYSi7xGRljlxQwZhTrcqTXEbmohhQcMsFa8O5S0LyKuYI8ziTcI+v3IUEJWdIpdDArxoCokmDxyqTlTN/nlgm0bVXGUTRfgJLiGDkXe6SKBaJ5MoLY9aWRXT3tWWSeEEiwfrig3JOE7mwUFGo4v7RJq+PeTw9MrulegUhd2dFmBca4E+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQbIovam8poEdzbOC51eoj1NJOwgU87qmaluY1QmjFo=;
 b=BOtHxilBHu+d1oo/ssd9Jf3JGY4i5nqfhCcdSFX19nsqIizKhWidQQAfSmmE7GSNz6q1JxccCUM1gbUv3RmCKBwv0nOiRGYEVGfuzVk1KmCddZH02g7BJECeCiDuJkHOnP7qwRmrQmmQB0Q7MIZEeX5eZhDknWoyUmKofDOHS5rugw+VFJ4LRyWUk9t7uBBveMJ8Z07ruqyZ5cG3sASr0r6PFJ6ifHdJoOU6oc1NkorEN2Mc+4NWYXNF6CHr4VCYWuspIcJXaGNQAZKmIWb5jh7cxksAFzfVnvKT+bU8kPMxtsIEY2AfpXMFbTwa69C480wAv0HjZTKWy0RYZ349Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQbIovam8poEdzbOC51eoj1NJOwgU87qmaluY1QmjFo=;
 b=J7802a1LzSwYKs/EIUKozlk+rvp56L9TLVbbRRwuLRzZTYgc2hApt9prLFgpkUyp033QMa9IuK+rM5SefHAGXjBYH8D/AnwVmggLCQMi8MyCO08VPAb+wnWIXtpioOoYScnsrRbTuU4K6ZdfhY7/Ilh0OH4xFzAVagX+Kr44k0hIaaaPxojT9lHpWha9v4fLBkRbN+m4lD0FsPHbvupi9Voc8mI3APSUCiSVhvnLgJlovqCBvDj3qzk2MP23HZf/IZkiVuYGorB8jSf0avW+ZRgnYIRcx1f48+JQWUhEeaahtspCid5yDUE65N+ST3koMl5L4ZtdX+Av+NpOSmCsEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6325.apcprd06.prod.outlook.com (2603:1096:400:419::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 10:12:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:12:57 +0000
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
Subject: [PATCH v2 05/15] thermal/drivers/hisi: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:05 +0800
Message-Id: <20230627101215.58798-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627101215.58798-1-frank.li@vivo.com>
References: <20230627101215.58798-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6bf913-4050-47f1-9f0c-08db76f7146e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcI2H8tr3L81LHCYEWnQm34FplEm7NvrmZOMcL1lJGToSGqLflF1qbSWXumhjoD8d+sOvCAWA7n2V50uu6tUmNtSOKfvzifjeBUBLCpHcbUJ91rF+DdV9lanvhiKjh2vAs5D5vXlmtehuhTfKhFBckUcYDz3+XjcaBA+QCsNYBajgP5ozrP5hJCyCL9Ik91+9R+LJhmUhREHX5SRFeUl41h37vAV6R05Vrf8MEnrztd7S5+aYMBxAM5n9CAeLF9m0m1OA64G0SPMMf+4oAsbQj0AqRkzYfxJcZgc3/GLPi7sAJXyVetfD121YSLP9AacNGHKBQcWdVEv+GBQo36gpFsbaLGJcAo0d15gNv1O3/dp0+rwURkgrxiUKuN6QS3POYxJU41E9QiGWjg6IuSMPNfwHA92pU73ng4yUifLoNE4hRjty2MnD9RiFUgy9hMBC5WmJEkl3viP991NDZQ17hFW8mnrwUPT+a7bgb06dm5NPDIHabIo2nKlT9mt4HoSI1jsl9lb1Gg0wcjJg+oDt3I5yg4CniCbvUNTE0l4ycWvAHMLEu7xxqcLzeBlBeSwicwhZfurhjAFIcAT/upVfO7ddfM8cqzeJRUD2osv9DfL9utOJpvWXI0Qo5mLzJtdFApLb6iS0/QAQmhwyDk8Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(451199021)(6512007)(5660300002)(8936002)(6506007)(8676002)(7416002)(36756003)(66946007)(66476007)(316002)(4326008)(66556008)(7406005)(478600001)(86362001)(41300700001)(6486002)(2906002)(186003)(26005)(1076003)(6666004)(4744005)(38100700002)(2616005)(38350700002)(52116002)(83380400001)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FzQQDlBK/K5oK+tBx/6WruhkBr4ejhW4kj9/1/2X4UuBihebxLQprylSoHo?=
 =?us-ascii?Q?S+7tWAZ8B8SZvOAaDVwOZVBp7kduWhIwiEIZDEQc7UAuQ+sCY7Lzkvq8BgrE?=
 =?us-ascii?Q?4qa7+gWt9LdByb/IG1KWFuO8LCX+4RFiE5pfOCOHNQyC0SgE79x8DjBZWO64?=
 =?us-ascii?Q?/XZceJWIy4Mx9BqaGT4I32+yL0HARSgVEm2QTYfLnHVWPYnEx8aZfqNceytf?=
 =?us-ascii?Q?z33jAjGRj7ZOaq2OfRc+ZuUUDVHEStUFroIBetbnogdx3HMna5aiip9V1Kdi?=
 =?us-ascii?Q?E87qzyhjYprS9XPzmw0HjcXaJHD4Cyxm84/VgzLhKnKYZfyhpcPNmfF0PdKs?=
 =?us-ascii?Q?OcocB3GkE6Ax6LjSkv97cnhnQz/9e97nOskjs2RsC08fZNBEqdcmRkCpIF/5?=
 =?us-ascii?Q?s2FjMtOiHU8n1lOiTflgJqKh7TN9DNgdOuU2iUnOIB0ALUrjh7ArX8xFTWBG?=
 =?us-ascii?Q?FsJqpXJ8fDuZa9VbsFbI9+XvrjISjlpz7vAq8g+tfdFpT98+SjHtRcaEPj9C?=
 =?us-ascii?Q?QGfMDFJajw+IzaJNXcsAkrqBakMUijKk9cKPwufBGU81M0h2wSpn6hkpQ/Cv?=
 =?us-ascii?Q?HMxXtQ0sBtwUBd++3ti15ZvidMKyqayVumTtqoBXFXAefyCcidBLXSLXtWDK?=
 =?us-ascii?Q?Y6t8FlXg811AZH9F1PMYUIMWpCyJtrleqDSGa115BXA+qwwSTaIdE9h/mb6k?=
 =?us-ascii?Q?/HHsZ5NzLKU/DZxghoc1dLSVdYWZeRfkmyUhGKtCYfbu5wa8w3x1/wObyQwe?=
 =?us-ascii?Q?xfJe1V2deJYSj4X78+ds7D6V+G5VD2xeaL5IXO9fkO7A/L7uMRTQGQWVVsgr?=
 =?us-ascii?Q?p3Zjtz6CLiU0kCcOxAPDooDPsBfqVpIKjVFFXxiNUNQAQi5n+Ivj2hU85ctu?=
 =?us-ascii?Q?9+3e44U0xeRM1D7KB8RsbeK8nGrOq/VLJ4LQU6Gk0Ffc36T5FrbjQFuOFbUm?=
 =?us-ascii?Q?XU5hZfI0X9EbxGDncPkevQUKWy1KtiQmOhbTwir34XBFA2NKuCbh+A0/M5Rb?=
 =?us-ascii?Q?xDzwdNx7ov2ed9QD+voXXndczJ31rnY5qhHBC29+26Tz6h4jbWqgtDi70q7b?=
 =?us-ascii?Q?7DSaycAsCsOdme+n7MorQ5UMNRA6g27XiP0DNwdIs5s5bdPlO/CvVVfegDv8?=
 =?us-ascii?Q?gbjqraZa/t2k1lXSV7jsX8n5nnNoKZCXrO702Xie9zWXhvTowz6iXW3c7nfw?=
 =?us-ascii?Q?EyI+yvZMbKqw9Yd4UNKaPKVs3d17iul6LAfR7GYlOlM6as/vrUXKqgB02/Xx?=
 =?us-ascii?Q?VLIu35S76ed5jY+xhn7sbOzOiV5HhyFv6WOVTR6E+KYFqnetee5VEWe3Pnuj?=
 =?us-ascii?Q?rEbywL1O4xEV6eiq/8xHykTyWsDErYDlEmCALXkGEsU1eva2XsHXCzwaGs5g?=
 =?us-ascii?Q?OvUioANKlDKzMRBy3tXpXkS/L6Hn+3fDK4GR3ZRg3a37YyrDobD7DBLMmjWv?=
 =?us-ascii?Q?xj7Dt9WGRDQvsJcM+T0NZPJxW0SBJVqNTpWQoHRwIX6RuXdUnD0b8uyFOdkQ?=
 =?us-ascii?Q?WyuSMO3PuDMW1OREK4pdz1CS+df+eOWXzQGvtG9/y3B3gaSAIcd1mEQLMpI5?=
 =?us-ascii?Q?TaIJ2x7hq3QDiAxXbQUwkfihGAkyFl0wJ9UwDBHJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6bf913-4050-47f1-9f0c-08db76f7146e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:12:57.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6YZFv3on6dJpQ02Aj8cu7vB8XxasFX+bkhswzHLVCoN1yldZ1Yxt/J6Xq/1vmULhGLrA9rj9ug5S3i2qThXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper devm_request_threaded_irq() function prints directly
error message.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/hisi_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 3f09ef8be41a..5f20f07a7566 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -580,10 +580,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 						hisi_thermal_alarm_irq_thread,
 						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
-		if (ret < 0) {
-			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = data->ops->enable_sensor(sensor);
 		if (ret) {
-- 
2.39.0

