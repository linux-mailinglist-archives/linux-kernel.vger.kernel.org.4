Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC96C9B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjC0G30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjC0G3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:29:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2474C32;
        Sun, 26 Mar 2023 23:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA/7qBbr7h7emEUOYGkaf7gmG78FOU+GsiHAM7/kHS1CLslTZ38aBWOUM+GNv/wbar7YgViBRx/TvVE+lExwGUIUOdi9ELWv5pTb/pvtwskPIKCYFSfPJdE993v9D+VrpPF/C08O7NH/Cy6IDpQpUMhLIXFthkT7Uo2VyxQjSBC0/Xri1rpeRpyXlC1o1dI/3u30B7v2NjmmSzw2FN8xrMlhbCGytBksJx2hAQ6caA+huHwMytWnu8HNHQ9qmMYYZirDkJ5UM78K5qhl84regq2o4D/7p0BoX4KjYbzNVn8oBZWhUrWXAHUODSFM6ydmX4XhviZVz7DPARPA+eDlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpCrTRKeIxUTc7SqgtAcE2DoOoAkUxF6EhYVABTXIo0=;
 b=KW4VHfi0H0gwP40I7tmKuWD0c9SFo/NG7B4XQKgC4ysnQRkiDA2Su6BcYWe9KISDjFHgl5WFR+oze5SWJkD2QU48BZoGh4M2H1fZohHa0W6FSZV+a55B5HVRvHR5IMOUrqYfIA+k/4rPZtc6t5UEjqjJYqPymKbv+d6AyCReIq77vQhMP0LIZEIsLeOt1DuY0amxjQEdUJY3B/cYyVX+CBxR1zU7IdH7ZODFT7Sz6/W22l5NkRDERu6GvZnkjxNTtA4bw6/liHlbSTbOuXtPCuc7VW5zSioL6z+M0kd77Da/l4c41nxnKIyAaLjybWeE5FrJfMPrz1bQjj+7wjI0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpCrTRKeIxUTc7SqgtAcE2DoOoAkUxF6EhYVABTXIo0=;
 b=KCDB1z2KdLo+AfUDDqgh9OZItUrSvJQeY7oMY+da/Z/ZoSZ2hU4VF2K28d2Rj4buo3iEUmaPWDjUHHRrN4DlCOBiTpKuQUrKbxXmONm1togFniWHtvckSJCpT/+ubQ2U4tMp+SIAwW0eeRE0a7I+seouPZ58zEY/qqlzTLqfLdddUFsHyuhe0OZ0Z5vPYVPBeIluGRIWM2W77X6QjmkX7JAJtzgTQagN2sMCzj8dyJRb53jUE9k7V/C+PbaODdSXtvnOFq3jtXaCLCXC3YQjvW1nr2mZJR6ikYcghkStkNgdwqwi9wh/m+owoyabNchqHnUEXbTCjFt4p8gyThIuFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:28:57 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 06:28:56 +0000
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
Subject: [PATCH v5 5/5] pinctrl: s32: separate const device data from struct s32_pinctrl_soc_info
Date:   Mon, 27 Mar 2023 14:27:54 +0800
Message-Id: <20230327062754.3326-6-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230327062754.3326-1-clin@suse.com>
References: <20230327062754.3326-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:404:42::20) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU2PR04MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fadcd5-25a7-4353-d142-08db2e8c8b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7wEADk2ck0PtKoTEjlo/7HbOqSuXuTOJGgFNRXrjvNZJfJm4RJC9yjnIRSVt6BLacXWmEJP1ItorbgiEFKXUBzLfB4oPHc9gwwdcvEJ7wn2Z4iyquxK/Z5dKoSXgbouSafLg10kt83Up0yTcuTiWbP+6M74SjA0NqMK2G8aK5tlf/ykAxp82hLaML/Y4+9G4RJcU85knWh247GUn1sG+OehgpXUhjgN9QKQh1vRcIjQFcKfX42WUROhnUhvXedLqHH9UN0A+V97M70BLgPDFljhTtF5q3dtO31s+p51zVVEhlJuM+wcQjsVxsbJFNV5qEZLgF1+ESGeg2GgPuzMh0NcA4tRlU9CX32B8an7nV13FV+aaEHcuc5Ule7PDvcqr6u9o4Ek8aLYWhF/aGpM7KSCVtVH/BxtWjFLEz30/3uvJAk2aUHPnkoQG0RDh09V8IIw8CP0q88u7z2Cyf/cH1GnCY7YjrA+8j6c5fL3YeFgaICtSUaPQApclR2TWPrErGLFnLixL2lAnObknFRX/rGoBKA7CSaKZ+8pvnPH+gFBVga4rSGFVltmbjqWUDxA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(316002)(110136005)(54906003)(478600001)(5660300002)(8936002)(36756003)(86362001)(38100700002)(7416002)(2906002)(4326008)(66556008)(66476007)(8676002)(66946007)(41300700001)(107886003)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lyEXe2g40nGxfXsx5l2olvu5rowNCmMOvbgBRdN5R3k5iF1f+M3zOdjtMbSV?=
 =?us-ascii?Q?Dr/OsY34P8lsofqp/ur8iUnipM8ET+e4AXChHknSIe1UTWnW+wjN4UG8N0Fb?=
 =?us-ascii?Q?B1HCc8frvbI09SqFn64XHsNB7eVnR9z27PpH2fMwbkkELX1xijxszUGQEWCR?=
 =?us-ascii?Q?JOXKXm8vrs33NgKHgQqNHu7CJBqhQ+96DNXvoFedVtGvmdZxMKGQkX10YPql?=
 =?us-ascii?Q?TDwTHPalVS3B31eaeJkWjTYX9BTDHzCBqIiYSqt3fKaxSRcbKTvUh41t9+Sa?=
 =?us-ascii?Q?nIakxsQl45YFHasw6EH5rmimdrMnnNGjIS3pgPWmXih9GI16Si/vW05smY5m?=
 =?us-ascii?Q?5oEzX2uk5HGn5p6oK7vHaDlDxD/7/TLXNVK2ycxtSsuBS7wShR1+3ziekPKH?=
 =?us-ascii?Q?3XGsjmVYNuyiFLdgXHAoWRrdNQ8OABikJGqQT2UHF15JmhCg29J4e2YaTB5b?=
 =?us-ascii?Q?tgbvDn2+K1l20oD5vO3Un0XVgXfpTUzNpgAEv/OhKAsRa7694t/u3DbsuaB/?=
 =?us-ascii?Q?A4Rauon1dTspVsUNR1EuliQqYvWMnrgZrZmZrCzNhOXZ5PuqRK0bPzdgNoDH?=
 =?us-ascii?Q?V17VVf8tz2xDkQ+Z5xgnfhRd0D4hXzjfPkClBT53vZmRXv2YAzpPFj6UCQJf?=
 =?us-ascii?Q?KMm1sd6bhPvyL66TM0PrxmjZANhZIhmxe9RCnCoS2aCi6OUbvep7mnjBGu1S?=
 =?us-ascii?Q?NnFjPpaWJGyqPc0mn0/Zr17d5SY4dsOhgkG80fhXirJq/R7nP/jbjTZlWSP5?=
 =?us-ascii?Q?4riziL7tQV2XthfEjTXVx1aCwoddJ3YT/egCyeSHQonH+JzzwSsvVq/9m3pn?=
 =?us-ascii?Q?BPFtfXvfapmwz1f7C5YDBAd0NQjd2BOPGUXWw9cUymnmi94Pd14Fen0gMp0W?=
 =?us-ascii?Q?vxyHZI+e/sJ922nMZHLh0vQiFhoj7WQoe92kW65kKOuwVSGjjk7kznR0BBB4?=
 =?us-ascii?Q?PRv3dGeYJEQrp4tC9B8tr9O0tgq2/V812Xn+LAyeKEmQZdB34TlpuMl/vIvF?=
 =?us-ascii?Q?m454pBOqpl7lTI4Cgqvc30RMwlCnznOtkX848eQ856/YJufBu1Sb+aHmJp3e?=
 =?us-ascii?Q?BaQUzluH+gkOQCPN1lElftWDAP009CA8q4GkcLz93A+Bzzu583quagqWIvP+?=
 =?us-ascii?Q?dhknzEqml22e/Tfi+RCCmswaq/UE9c09AST3I1E1dvxDhgvtN9IhcUrX0Q6O?=
 =?us-ascii?Q?JhiIHy9+4PbssO+TGBp8aOlR0DewuujrAv6nMFNYpYiYPCBJKBGVxFkWtuP0?=
 =?us-ascii?Q?Su1OaZF1nVEasa/IDWiBYxms96Ncj5whg00PqR5DevtR43315KTNicZvRTgn?=
 =?us-ascii?Q?C3KFpGCRF3cixaVlUddpusDfGyFSvfNWdbLNAuv4QRtlddjaePHQu4CJ9yNJ?=
 =?us-ascii?Q?Ypw8RAYooB7Le3zyrgLLhoC87O44fLl9UaO7/ZxXVwnKCHrJ/Ph1onuCW2dr?=
 =?us-ascii?Q?kcRBZPAsuXbeooy4hrRF/xvUlHh5zaoaIN3UPkpmAl04cb1Na57SeDvKgmSV?=
 =?us-ascii?Q?kC9agn1OBJz9NPSYGx0ub5g9v2p9xXUAObU3QUqTJ2282KSUtGBfLyIVF5oF?=
 =?us-ascii?Q?2B0FVUUyt9KY/I45EiA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fadcd5-25a7-4353-d142-08db2e8c8b07
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:28:56.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fCJgXvtS2CwO/YXpJSb7fo2/kWf0Z6QnAp6RzEhSIU6ksyTLMoFp2+oHCJQH56N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v5:
- Remove unnecessary (void *) type casting found in pinctrl-s32g2.

Changes in v4:
- Retrieve the matched device data by calling of_device_get_match_data()
  and remove unnecessary type casting. (Merged from the previous v3 series
  [PATCH v3 1/6])

 drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +++++++++-----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 30 +++++++++++++++++------------
 drivers/pinctrl/nxp/pinctrl-s32g2.c | 14 +++++---------
 3 files changed, 32 insertions(+), 26 deletions(-)

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
index d9f3ff6794ea..4d01e9a2a23e 100644
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
@@ -730,9 +730,8 @@ static struct s32_pinctrl_soc_info s32_pinctrl_info = {
 
 static const struct of_device_id s32_pinctrl_of_match[] = {
 	{
-
 		.compatible = "nxp,s32g2-siul2-pinctrl",
-		.data = (void *) &s32_pinctrl_info,
+		.data = &s32_pinctrl_data,
 	},
 	{ /* sentinel */ }
 };
@@ -740,14 +739,11 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
 
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

