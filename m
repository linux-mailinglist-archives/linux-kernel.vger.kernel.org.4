Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE966DAEC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbjDGOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbjDGOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:19:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2055.outbound.protection.outlook.com [40.92.98.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DB8684;
        Fri,  7 Apr 2023 07:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrhiyU+0RWWTVZlsAy9srKTqLdNvlmh6mc103qDsowt9MySIsabn70Uk5Ku1AD2NiQMIk3QTNnG5k3Jz1oobqrvhsK5UwcdDqWO+bbzwJvE7k0K+3OEEftohY9Hfmn5A/QszQojrDaK/cnhH69mZ67XT/xxN+xA3sSi0oqo5dBsREDxEaTCSRoxVk0gLH+oRJmwG7ZHjfTEA5/ezOfOX7NagAs37EzCa19LJoOf3VUR3UxGaxGM6VN2UCnT2/YKv2eSNyCXDQ1NAQ8Nf0QhOulVFrVBQGvpobBqc/iF/3F1x2CLcAgKaK0ZLCXFQw1kV6Hr5Lm1RqUNPswECzgfbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY4jFFNw0M7yIh4a0N5pllOYfkbx7ClJRAnYHXblrLw=;
 b=aBJCyY1/xwzIe++sfnCzZabGhebdCw6bxG+Tip3DtU7WrPMkFF72MctKPa6z0XPDFYBaYCEBcGtJN3yHM04JbCU+kR+61QVAW45FAJovbWiYlJa6y8++B/WXdcvjZ7q+dyRuypEwBsObOnPpfTIa29gDlyBkct/WvjjS/UyelJgGTc0gphJhuEicvWhUQMfEHCw3jC2NVxrBBYh5yVqaXVLOaHfigJyjd+Y6hZpwcC+bR05n4hjIYyuUwTLP0Cacu7la8ZJ5B2ZAD0HHWjlC2R9rYAkIBMI5rFW+Jne8sU855lobJYI22ba64WH9B/5spitd/+63FlXPe8Yliz8M4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY4jFFNw0M7yIh4a0N5pllOYfkbx7ClJRAnYHXblrLw=;
 b=swnVA5n6UkaxUrhrqcxqfcnrAnWscKclOkVxaE23NARq/BMu/wdtScMklsHQ4YwN8q4jZcwUIEg4/boC3NNH5smU4dukq7PYgMf6xAJWZz2n+/EJGCiSGj5Sxfgb06mNTkfRdYKryC4ukE7UJP9NwVZk7DoAM2kqw7wWn7WW0nmHLjUHgWdS9TDJDL9sZ8gmmk5rJ+dKuf7Z4n92DDBeE+VHfIOkMIlPwbql91qapS+d5EUW4McHO7Ra0C+c73hmA+v3o0zxGKUmPdYgIvETdSxqCibapmVhhC/4vn7L6iY+hBpiQN9ZCCCk8oLgW2dU53UFm11X6+PgDJ0ux1+TaQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 14:19:05 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 14:19:05 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 4/4] regulator: axp20x: Set DCDC frequency only when property exists
Date:   Fri,  7 Apr 2023 22:18:13 +0800
Message-ID: <TY3P286MB26111D00F42888C71EF0877698969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407141813.89-1-wiagn233@outlook.com>
References: <20230407141813.89-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [c6G5peonix4uxtw3DsCWGfD+BkRlDAUP]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407141813.89-5-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2638:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ed14ab-e316-486b-cb6b-08db37730b15
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJaeu8ZRRwqj0GQ5dXBxGN9mcLrponhjHeYr+TYtZ2ot/qk4sSnwLZGTdiZNKftPjPla4epF+RgrCPqh1PvHSad3+C6YC0C7QBaJJxoDCp4cJnR7PwtLcgfTFP+b4sHf9ybsBtArh6CIQY0A63utuhzKB/bMuKmcUs0AVdvXGV41loE/mbSmfhYMuvvuzWa3+95wvSKpSSzueAaceAD9bteNf5vQKiFDeEJOX1ubNRwq35PaNdzgW3q2out9WFwogbOrjoPj6cx47I87TptCM3wbuMURZFRufoJbCFs4gixCCUXxRWYLX5NvFJNUVMCDvcSfM6avBv+u9JK0U5djTMqQ2X+08tBJapPKW/omAopGRvn/SC8RhKQtkBVARWelRmmXdFj7nb+LZRiyFzwUT7NL1PHCzflxaot1EXcw4l/zGnFBkvt5EWhRGLKwUor/SvIK+OJRAC9OISKOdfrbr35Ad/a7CfbH4D92/kNlkNl3z6Lf4W546sxFvmnHnM3yY9vSUqO3Fgco3ZCoM5kljO6Q91or9veDH2hFUHXL5Qb+6DU8PINyVGGol5rykIwXabwk8bkOduUpVfzUKZHGpd8m6NqWW7jh/wyDLVGa972PyX5yYsK1+X3yWJPspcLQEfF12y+K65w6jEUMTP6MBX17+Ov2lrBK56emi54sVKl+CO/rpNowZzcO9MNponhlmVrkaMfsj+ZC5LU1tcf7eru9NzQwtnJp0JlfPb9V72NeNfA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APYtoOLrpqr9EIpj1hBzlgzGjP10LHa1XbzOT6DC4oCvmbxO5K+TR/KY7YUKclQKrOrrussrb9oFZvRf/INfqI/rEE1fLCbn8GtXYprckF1TB1mLKsReNQtFM8KqYHTs+NhBYwzTb0RIWEBnOYUY+bosGna36AJTn+xegKnC1pKmuOT0tO2Uv+1EM5L8oiGuBpNgbxLQfsFaJ5dFtTDUEUKg3Pcl1cP5e9Wg9pU51wnkO9+VBVFmUp4qc+vO2o4Cheb//2G/vb1pPVwg3LeBgVEdYfSQX3kNkEQ/aN0yMYU+VAIdu0prpZucD/Smf9Wt5LifQN2WRuEvb7EMO6DUSSnLv1PCnR3p5pN1SpwEKHehyLoN/p1K4gHMP/kpH+bWHJDbAuGZqyx1fbc0S0nenFo6cRgh9ucU29yx9E7F8MugkedzU6/2V4kUjKI0Wuvh1YokXfNhI2/d4GfZ3MrK5PnoXH0KSr8eWdekkNxTw99XurD+TJ37DvPigFvUrDOxtZUEAruuivAhVXcYIwYRIxQ7HSvkey1hkA7pXDsY+IKyDopqLqDImvLa+h2uyQjm+98IV0EcZoCs9mEb1bPVcdL7CggmINa2J2K/jeDY/gM0jesDO4iQWtc/Kd0jURZQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z3GGlqX7NsdsbbwtXzhJoHupgFiweurwRo9cytmuEFcMuXpZ0drW1DtIetxy?=
 =?us-ascii?Q?bERr+TfXpt7EgIyTmoyJe06TjTc+0mkJTooIRY6RNidTMD/e9JvF8585Iaw9?=
 =?us-ascii?Q?wrtlC16Q0jZI1+xMDQkK+ynRGZsxeZJJ103ko18KKfzE8MchlRLVchnlJdTY?=
 =?us-ascii?Q?L3+mq0OJcrC19wYVrcZQ8r/0End92KBLsDUlgOTXUF/ZehkxQWHyWr2gWxhk?=
 =?us-ascii?Q?R9fDQ5Ig/qv1zMbqZNEeaBts64EWCKOJUDPNJ7MWuiIkMS13AR0b0eyD6WqW?=
 =?us-ascii?Q?dI2Eh88QTAn4xzHxNmkvKA4bL6nDEkqxJ6EuPNJiEMsQKeHJMGNRby+yxGTk?=
 =?us-ascii?Q?Jsf2PnIkd6F8PUwwYRd73qwIM/1shSNPx9vWVX5rnvoJN3eciT7MaH+upHbu?=
 =?us-ascii?Q?TDkEsz2wQRzDaxdv3Ic0LuBQpJwlcDNVgfpW0EOO5b2gCE9Fqv3Ewf/9xUDU?=
 =?us-ascii?Q?4WPhPcW39t4Ha4dJYabcdEwyZMfo+8Tgv/YR0k14GJW35QsmcQHpflgu+llC?=
 =?us-ascii?Q?+wXOX8mZmGb1wO0ynL544i1yYexzjGvnGfPC1ip7AjJClfMBFLF0SqQfcJJE?=
 =?us-ascii?Q?6hVFoN3L3QhEQcDUya4Ut1RCM2kV5cx+3AkIKN2u+urSJ/MV7hxmwCjhqw3q?=
 =?us-ascii?Q?tYF7MrZdJI9yvtMcULRSootir6L7Arw1jJcohm3FBch4Iv6lvJc5nIhLVFl+?=
 =?us-ascii?Q?ayvayh0zghRKS6z27TklEzGYXCz0dJgi70u7zm0BAdvPR6fZx1SYFdsC9wnm?=
 =?us-ascii?Q?n66Zi4ygi2DuREcR7mka3gNVRhnvfO8bBLLrDAdI4nxkEpYekcxxdzHvUrH+?=
 =?us-ascii?Q?1f2mQohFqmzO6HCQmCocYEKjUvRfFkfh0rdx3rMtvCEOR2bqn4dhJA0aSGXm?=
 =?us-ascii?Q?pLWltJSO4WQne71oQX+PXS0dS4Hp3TW03k99g5xBS2EEo5p6poiQ2lJIBkD3?=
 =?us-ascii?Q?GSGnyUQual7yVtcVKUXF1PjCY9l6gQpNUkrpEfE2vgJpdCPG4p5MiYeEJVDH?=
 =?us-ascii?Q?q2sskk0cLMulcZxWzmTwPFd9T/PcAkg/lQ4IsUyeO3DC8V698HDVBi2US/3n?=
 =?us-ascii?Q?UWCEyo9MJDh9hIUXoR4bMWDNIu1cLZbdnZgrqnqYsJU5abBvD/sxb+0Pq0FD?=
 =?us-ascii?Q?Zr3z4JJeyeE7aKW4vPNcrYwuYE4SdDGf5dh9GKZqUfjvU3C2T7pvHXy/61Iq?=
 =?us-ascii?Q?JSRSfU0zqohxInsKx42Uj4BG4WxvFv4eUO/GKw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ed14ab-e316-486b-cb6b-08db37730b15
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 14:19:05.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2638
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current axp20x regulator driver would always set DCDC frequency even if
there is no x-powers,dcdc-freq in device tree data. Causing meaningless
warning info output on variants that do not support DCDC frequency
modification. So only try to set DCDC frequency when there is frequency
property.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/regulator/axp20x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index ece4af93df7b..12a12923bc7b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1247,10 +1247,10 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 	if (!regulators) {
 		dev_warn(&pdev->dev, "regulators node not found\n");
 	} else {
-		of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq);
-		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
+		if (of_property_read_u32(regulators, "x-powers,dcdc-freq", &dcdcfreq) != -EINVAL) {
+			ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
+			if (ret < 0)
+				dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
 		}
 		of_node_put(regulators);
 	}
-- 
2.25.1

