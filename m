Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF86C8009
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCXOik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjCXOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:38:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F810261;
        Fri, 24 Mar 2023 07:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnnH3n6wse9a88iyFFi/dpcxJubKs0EjNiExw9mUHbArmqjaHllkiYmC9go0CL3ovkit/dbdl/seIcj0reannRMFmFQxVe6Tu6Vy+rMyTKCKHxkE5+6PvjLfr+lpaBDGRhMxY4fpecf5SGosXioqA5GEUVSI/GR5HxRfhNjlk5wJFhlOBSgnzqiVBeWjE2OsaABExF0BxDJ8y8mCyZAjUDxqJ0s80kE1EWZ7qiC9X82LIu3txiHl05/Pf1mF3GCTptp8Nj6HT5cdX7F1qiVAkX1oCW4D4gFuDO5lGvTzKStkh7qqJ2MxqTW9a4u+sF08SKWgmtd3l6JuhZjm/hTPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZbbeGlXq8UVl23v7QdPvF2RjzZHx2LPO53+RbV34S0=;
 b=F0spOvpJt5vH92KgMCXdDMyW4jTyDzZdVgtiqexVZJdy9abGL4lZaAJ8VQN75URSyYL5uBEK0PdVzQDjI/H+icvW6ETu+amH2eT9SYe0xyfHt2MeXaU+I+WQvHjx8GrRiq9I+7gybszxmryonAdTyfCdV05TFqaNoi12M5yTJ7ekJyO86DTv+trJbWmSwR5ymo8mmfJ33ypkGcIEPcwlG7OkZ+KWWOoTO3z5TEVi7JBOitJk4BBI38iQwdYk/+UtsigWhR/rmCl4Kxk5W3Cs3GiP99RJDRlnDueRT1tj7qnWqvM8csiKQRbaubTjGqqUvMHPEdCvvDXEFCKv5m65/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZbbeGlXq8UVl23v7QdPvF2RjzZHx2LPO53+RbV34S0=;
 b=eqmuPUrZU5Dh0ypQTNzcpzHt0TXFfZV+TUzlbM9jHLJp6OFWCWBbZsG8zopYtq44oS5AuYS6/quBJO0mG+HOPFKhplN/Fa2vt+pkTUCRElTmoVDohcXobuyuXEDKwHbQzIjI8vhFbWL/nxtDk5K2s7vJVPYB7m0rRgDBm2D8YltUHSO8U91RotazdoIznh5Sf5y+UVQmOTwDRwwwlVihRuZnossz1GvIfdmPrZ0W/dool7nlNCn0CGCKgT7CgzrACB90Hji+SDNzMohl+dL0OFcVEpMnbgQ5GhTp4K8QX7Twbfe/OyxcaVh5J4P0lijosMkyZL3nbTyk3WYKa7NIFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:38:00 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 14:38:00 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4 5/5] pinctrl: s32: separate const device data from struct s32_pinctrl_soc_info
Date:   Fri, 24 Mar 2023 22:36:26 +0800
Message-Id: <20230324143626.16336-6-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230324143626.16336-1-clin@suse.com>
References: <20230324143626.16336-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::34) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB8623:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec323a2-8062-426d-8bad-08db2c755def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDHPgVVOPnkvpeX+P6wGgX060o3YLJgbDyrh4WPaFIgNWEHby5Eg/Rz8Y5+t8D1qmGVC1ZAVDA5GihXN+TlfM5IXQfe7QSFd9FdJRF7LLPaN94yYqxK2IDHMLA2nMeUkeh1iKyU8+h/QzoIaPKrApENOawgy+Zl/hzj3wbHofadVaSwpQLmBh+1WFy+YJ3ubc6+JH5ZBNI6ofZ9DYjNjy9qxTgkJaTymy6xaf/QXyw3QRkY4w8m5jqDcsWmM+5EurMD5tYQUimdU/5GTZc3xA16fp2PYSI1xb3FcbEFfXY+Kp9MD8XnG2bwm0PebFqeWakiStejNJ38ZteykqOsMjSpI2sgaR2TO7zVN8nDNSC1xsZIcHtpW8yaOQ4ieRDuqWYnV6LavGW9dHXGRivK5hqpsf/ogNFXQj0PuisAqeinp+37fE5QOf8eHnc7ELauFKxKpYUTFOHlQrAxEx6vPqkxIVKQf3y6ZW/xcKsIHhEJ+TRRkB4LUO0RHfMjKG5ZBsNdIXW/9W+rMii0IYzBGEOGzbFf/pU4CPjW4Jcn09enAT7nb4wWWbrWZ1p6qEbDSKsQa10z4K6VXPC8NR0iVENi5vXi9YLGqtHElWrUvTZtH5mt8pjtSXeqy2pcpfh7/zF+ciYFCcuFDeWwMQuS8xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(38100700002)(2906002)(83380400001)(6486002)(478600001)(186003)(2616005)(86362001)(36756003)(110136005)(54906003)(66556008)(8676002)(4326008)(5660300002)(1076003)(66946007)(66476007)(8936002)(107886003)(6506007)(26005)(6512007)(6666004)(316002)(41300700001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h2JjuliZJNHRFqCh5uEnsfIuLpDSFBzHiuXsIWWTgG7Yhj2bgsPziAyoNlyU?=
 =?us-ascii?Q?D3ccNLztyGvog+nXjyTrXIAYzKfH8kPMF2huCFJGvq4FyYM11qLWNrnmq4wT?=
 =?us-ascii?Q?LNNMv5lhWyyHpwPJbqPbwePjMB7ORtsxGIPfFPq5g0mRyXxAEhiVNGsAqhRA?=
 =?us-ascii?Q?Sy4fYSHlNafoTm8rs8h73iI3yqq2hWpYiSjpWouSmMe+Ww4oFOWiC9nq56CD?=
 =?us-ascii?Q?RIypmImfNnkXTEySEBj2+4Ier9DUnZVf1BXNpkpRtZWZ2HW4QEcKnU66YleT?=
 =?us-ascii?Q?Jn+RDn5egXQurllqBBJkJ4l1XHIeuA2jfzcLcUuX2SYgMxnQOqSmos1gNQQA?=
 =?us-ascii?Q?gS3VPcv1GTxm+I+3TXytD3BtARJ5elQph7UtBp4cOgXAnPjYjScwxfqBfNon?=
 =?us-ascii?Q?46YPJSMzkMLnam03rtH/HZ0xO++VI28/AE+TDrUPVQYW2yFSbNaLx68a+ia6?=
 =?us-ascii?Q?03ep2OsH8PIIinxT5G3QprbK+iTo2+rClDGxNqipQOuf9F46xKzC0e9CNETJ?=
 =?us-ascii?Q?dlmDBDrYFt8kr49tAChmAegExgBXQ7eiBBwbBfcsmlc8K3bNEu1UZOO+Tm6I?=
 =?us-ascii?Q?5DNZDh2iJGIFtw9lLm/60QjbehZqvtMZwa/AUXFV2Bt0LQt8ht74CgtQ1yvh?=
 =?us-ascii?Q?CRTpzpp7dLM12KS/UcZx769I2fV2FK1l/FLW1j4evG5kkiCliWCUvL/FqINr?=
 =?us-ascii?Q?PvqKi4qxaTHGxiHHYiOc29SeqEWTCyPuc0jrcB7CryRu58ozGf8vwwJuVoYN?=
 =?us-ascii?Q?bnD+cFhSv0qn8zYuUvqme6rBnwILUl1iKLuDGNRVJmlNB6JXXZ+dNx6kcp4v?=
 =?us-ascii?Q?RzIhk6wBnSst/S41QwSqyUwURAEofnNTZOY8Wu1zOPk2dwKQrHiXmGVF/cKw?=
 =?us-ascii?Q?BIkutpZHve6urrKWRs8uweXPoUm4Jn5zU5LhfIjBaDGy0qJGLgoyUzW8ZwIW?=
 =?us-ascii?Q?pho2Lcx0jyVuC5INg2GFKpthId6t8JjsxoSxHH5IGg48CPCBjyVv9x+yPJ3U?=
 =?us-ascii?Q?BU6C9+OwDAWdV1b3X8G7sady0Ys3cvXbNSP8aGE2ywNDL9/tyynjDg+aYxHk?=
 =?us-ascii?Q?38LuzhLBb5waPX4zY/K0J1g2GpzOm824QBdVXPw6ZwfdyEX94+NNfXTWQITy?=
 =?us-ascii?Q?oOULBA8FW81IpELzzXR/qgv3+8HglndQvhZkJOxKE8exc+K9Vg0Wz44vdsAA?=
 =?us-ascii?Q?8orOfPQ+xQoL3WEcwQCaU7R2LXwW0uUG9Wq0VpSAKScIaFB5073Hhy3hg/mI?=
 =?us-ascii?Q?DF9cs0ro+AreoPvtqnl75B2YFROJvO1wNGHyu2ZrvyWaGUV3DJ5IVkTv7C/f?=
 =?us-ascii?Q?suWIbqIGLXnmJ7tvmvK+ffxJrA/Mqt2ypN8caNDI4CXmigfZzx5PS5AbiwTQ?=
 =?us-ascii?Q?r6QqBciZluzuF4Njh9UelNGnaVQkhUHhcJxLS6tbQZALD2Eaj6za+ru3Cc40?=
 =?us-ascii?Q?lr2o1Ye+b6LQyx7pKRhQaPc8HVds7Iug3C0/U4+wuwd7Z6D7G9/uU5zMyd0a?=
 =?us-ascii?Q?t+atSgznZ+IzS0W9sWStovAn5rfx6Sv6cNgjpYW+L8qDEgJaqBJJM0Iu1iDq?=
 =?us-ascii?Q?YJxCmlY6weN1Iw4DC84=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec323a2-8062-426d-8bad-08db2c755def
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:38:00.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwatRvlSDAO9ZTZ+MBvqy1raOv53Z/Z0faSu+f0eRrCA2HzhblMOoNZ0NtXe6ZRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .data field in struct of_device_id is used as a const member so it's
inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
because some members in s32_pinctrl_soc_info need to be filled by
pinctrl-s32cc at runtime.

For this reason, struct s32_pinctrl_soc_info must be allocated in
pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
to represent const .data in of_device_id. To combine these two structures,
a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.

Besides, use of_device_get_match_data() instead of of_match_device() since
the driver only needs to retrieve the .data from of_device_id.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v4:
- Retrieve the matched device data by calling of_device_get_match_data()
  and remove unnecessary type casting. (Merged from the previous v3 series
  [PATCH v3 1/6])

 drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +++++++++-----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 30 +++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c | 13 +++++--------
 3 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index 2f7aecd462e4..add3c77ddfed 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -34,24 +34,28 @@ struct s32_pin_range {
 	unsigned int end;
 };
 
-struct s32_pinctrl_soc_info {
-	struct device *dev;
+struct s32_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
 	unsigned int npins;
+	const struct s32_pin_range *mem_pin_ranges;
+	unsigned int mem_regions;
+};
+
+struct s32_pinctrl_soc_info {
+	struct device *dev;
+	const struct s32_pinctrl_soc_data *soc_data;
 	struct s32_pin_group *groups;
 	unsigned int ngroups;
 	struct pinfunction *functions;
 	unsigned int nfunctions;
 	unsigned int grp_index;
-	const struct s32_pin_range *mem_pin_ranges;
-	unsigned int mem_regions;
 };
 
 #define S32_PINCTRL_PIN(pin)	PINCTRL_PIN(pin, #pin)
 #define S32_PIN_RANGE(_start, _end) { .start = _start, .end = _end }
 
 int s32_pinctrl_probe(struct platform_device *pdev,
-			struct s32_pinctrl_soc_info *info);
+		      const struct s32_pinctrl_soc_data *soc_data);
 int s32_pinctrl_resume(struct device *dev);
 int s32_pinctrl_suspend(struct device *dev);
 #endif /* __DRIVERS_PINCTRL_S32_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 8373468719b6..41e024160f36 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -106,7 +106,7 @@ s32_get_region(struct pinctrl_dev *pctldev, unsigned int pin)
 {
 	struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct s32_pin_range *pin_range;
-	unsigned int mem_regions = ipctl->info->mem_regions;
+	unsigned int mem_regions = ipctl->info->soc_data->mem_regions;
 	unsigned int i;
 
 	for (i = 0; i < mem_regions; i++) {
@@ -688,8 +688,8 @@ int s32_pinctrl_suspend(struct device *dev)
 	int ret;
 	unsigned int config;
 
-	for (i = 0; i < info->npins; i++) {
-		pin = &info->pins[i];
+	for (i = 0; i < info->soc_data->npins; i++) {
+		pin = &info->soc_data->pins[i];
 
 		if (!s32_pinctrl_should_save(ipctl, pin->number))
 			continue;
@@ -713,8 +713,8 @@ int s32_pinctrl_resume(struct device *dev)
 	struct s32_pinctrl_context *saved_context = &ipctl->saved_context;
 	int ret, i;
 
-	for (i = 0; i < info->npins; i++) {
-		pin = &info->pins[i];
+	for (i = 0; i < info->soc_data->npins; i++) {
+		pin = &info->soc_data->pins[i];
 
 		if (!s32_pinctrl_should_save(ipctl, pin->number))
 			continue;
@@ -831,7 +831,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	struct resource *res;
 	struct regmap *map;
 	void __iomem *base;
-	int mem_regions = info->mem_regions;
+	unsigned int mem_regions = info->soc_data->mem_regions;
 	int ret;
 	u32 nfuncs = 0;
 	u32 i = 0;
@@ -869,7 +869,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		}
 
 		ipctl->regions[i].map = map;
-		ipctl->regions[i].pin_range = &info->mem_pin_ranges[i];
+		ipctl->regions[i].pin_range = &info->soc_data->mem_pin_ranges[i];
 	}
 
 	nfuncs = of_get_child_count(np);
@@ -904,20 +904,26 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 }
 
 int s32_pinctrl_probe(struct platform_device *pdev,
-		      struct s32_pinctrl_soc_info *info)
+		      const struct s32_pinctrl_soc_data *soc_data)
 {
 	struct s32_pinctrl *ipctl;
 	int ret;
 	struct pinctrl_desc *s32_pinctrl_desc;
+	struct s32_pinctrl_soc_info *info;
 #ifdef CONFIG_PM_SLEEP
 	struct s32_pinctrl_context *saved_context;
 #endif
 
-	if (!info || !info->pins || !info->npins) {
+	if (!soc_data || !soc_data->pins || !soc_data->npins) {
 		dev_err(&pdev->dev, "wrong pinctrl info\n");
 		return -EINVAL;
 	}
 
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->soc_data = soc_data;
 	info->dev = &pdev->dev;
 
 	/* Create state holders etc for this driver */
@@ -938,8 +944,8 @@ int s32_pinctrl_probe(struct platform_device *pdev,
 		return -ENOMEM;
 
 	s32_pinctrl_desc->name = dev_name(&pdev->dev);
-	s32_pinctrl_desc->pins = info->pins;
-	s32_pinctrl_desc->npins = info->npins;
+	s32_pinctrl_desc->pins = info->soc_data->pins;
+	s32_pinctrl_desc->npins = info->soc_data->npins;
 	s32_pinctrl_desc->pctlops = &s32_pctrl_ops;
 	s32_pinctrl_desc->pmxops = &s32_pmx_ops;
 	s32_pinctrl_desc->confops = &s32_pinconf_ops;
@@ -960,7 +966,7 @@ int s32_pinctrl_probe(struct platform_device *pdev,
 #ifdef CONFIG_PM_SLEEP
 	saved_context = &ipctl->saved_context;
 	saved_context->pads =
-		devm_kcalloc(&pdev->dev, info->npins,
+		devm_kcalloc(&pdev->dev, info->soc_data->npins,
 			     sizeof(*saved_context->pads),
 			     GFP_KERNEL);
 	if (!saved_context->pads)
diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index d9f3ff6794ea..e0944c071c8c 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -721,7 +721,7 @@ static const struct s32_pin_range s32_pin_ranges_siul2[] = {
 	S32_PIN_RANGE(942, 1007),
 };
 
-static struct s32_pinctrl_soc_info s32_pinctrl_info = {
+static struct s32_pinctrl_soc_data s32_pinctrl_data = {
 	.pins = s32_pinctrl_pads_siul2,
 	.npins = ARRAY_SIZE(s32_pinctrl_pads_siul2),
 	.mem_pin_ranges = s32_pin_ranges_siul2,
@@ -732,7 +732,7 @@ static const struct of_device_id s32_pinctrl_of_match[] = {
 	{
 
 		.compatible = "nxp,s32g2-siul2-pinctrl",
-		.data = (void *) &s32_pinctrl_info,
+		.data = (void *) &s32_pinctrl_data,
 	},
 	{ /* sentinel */ }
 };
@@ -740,14 +740,11 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
 
 static int s32g_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(s32_pinctrl_of_match, &pdev->dev);
+	const struct s32_pinctrl_soc_data *soc_data;
 
-	if (!of_id)
-		return -ENODEV;
+	soc_data = of_device_get_match_data(&pdev->dev);
 
-	return s32_pinctrl_probe
-			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
+	return s32_pinctrl_probe(pdev, soc_data);
 }
 
 static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
-- 
2.37.3

