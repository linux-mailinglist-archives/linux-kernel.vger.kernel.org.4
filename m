Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95371710AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbjEYLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbjEYLRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:17:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753113A;
        Thu, 25 May 2023 04:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNBbwIgSq/ybmJwi+fWkSftRmMvcQA3oh4EdigwsV8/slkdlweMEKNzEV2p/tuwI75s0LLDRj8jfISC8I+u+Ihzl7j8zAKCZHTrgHqNPN+HHOYSj/u+a9rtImLxEpzmtFyVBuR+x0G/QJ6p62s2GP40gTTLpzWzrOwtmD3EOylg9QEs7AiNdSsSA5kPEHiO+Qy7LxWeBNvdjWbd5jMajaagEJ8Kpmwgf8JruRqja77+k+FY9kts9gqHhbvuH3Dnsch/IU+C/rdJ0Pqnz2txzGzSqcL4qAd+L6Z1hhPvZ8XYW+lXEbe7cxkXK4uI8FAebPZ5qVxlS7704JdDGZaUSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q281zBsc1yykypkcYvhdkHyt0pNtI5Z/UAe1TdFoq1w=;
 b=QMKqRIWmIT5wsGyY2CCnKF9FYTjA7eFimagGNUVuvH9UfgXDcgLserWSuG1Qb+KNoxV6y+moJpCcvuMdi2YgkNHyrJbEJPkRzBYJCT9XATSe7/vcSlZ98qlstwbY1U+Mm5y4DnwO4Kmd0E7FjYEScKieHUnuJIfnt3U5vIKCTW9bB5XzjdPoeIffEd29X1YbfIihVZB1KCiFh7/Q8C6lvUpZ8nlNRVlPlxNGaOjnIs2QJtE8jX2IQiWi2Xj7QUrwWH1+yu5Wu3kPjOFEgQeCwGQrbI/bHmd4uqWaP7QKWVD8ETDiAyWt0OHCWLyK1wmBrP3jZonR69DTbzEsaN5bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q281zBsc1yykypkcYvhdkHyt0pNtI5Z/UAe1TdFoq1w=;
 b=R11emTzXgR6DsITY3F/JVWImZyCM5MT1Chi/a+HKkepHs/7XFhDeKnFBM9XeCc8oP4mJen6DrE4eeRSUiMpbKqutyCxcvwyF3ei0OoxTvs7KcVu3bWpEPKZnuC3YnAFcQj8C5i7Jb8cUcaHe6C71Ft++iISFv7dsi3VLdLbOoMdxvCaz16YABKZFzHZbYjzr4aePK/FZBKrrj08l8rO7V1LM3UJjQXvQuSs1nXmfYy0gdRoECj0Lm4HBUGeBFx1Tdqb2efS88g7PdNgCwsOvik4iaev+A7EEXyA2wDGJ9T6dPKGGzZhPvqhxv9rEAFRZ9nTbk8LlQbHBlSg8xf0TQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB4447.apcprd06.prod.outlook.com (2603:1096:400:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 11:17:23 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%6]) with mapi id 15.20.6411.021; Thu, 25 May 2023
 11:17:23 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Lu Hongfei <11117923@bbktel.com>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops
Date:   Thu, 25 May 2023 19:17:03 +0800
Message-Id: <20230525111705.3055-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:2::29) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab77395-31c2-44b9-76c9-08db5d119c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6J2H4GfE8bN3G148SEbeDD0tsxa26prUqdEgs+KleRgvaDHlnr/Qtifpup49P8O4IUtPeMJspuVuDmjNbIFP4D/DA6o3ps+gy/k/340Oc4gmZd+udvpbi8ZzyiFlA513il9UFsdefYI1gODwldUyMZgV1WbUvrJITASGN3Z4DFDyYSknXb1wfWgYV81esrQnfXSOTjhPmcO61CHWTZ+EcACmddBxcnpgMHOvh1V4qmJjPnbpECeqXdqQcAy/3o8+7qhemky70ZaNuLFLZGCOWHWCUr/w1kbEhSz2S0NdP2G0SQTlrHLU+8Qest5iD38oWrtOioQ4r7nDbUbzkr4ttD03OkFLC4wb69jrKHp3XX9ns3Squnh4PA2Yzaka3RIoz3V3DwmL6jDBI/Unw4vA3zMrPdML6eeBiIEhVH1WQEY6dO/oEepUfCKPRtk8o8TJwrVQq1ANoLVOIAI6lsKhtY2K5MepzxE/0vZNI/Cln6PKrOykKnfLDrqNtkL7F+8fMczI8nOctULdKbc2rmInFHI7U16xSBnEGbJBEHQPmJX11Fc55TALREprgGxzmH+zoTAr53f2tzvMNgEBGdLp/FCLRJRox/AwCNl9BY2J3ZZSl9YoXg3u+dFcT1n76m7UsnXOLjanOJnlRYGHK/New==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(36756003)(86362001)(52116002)(4326008)(110136005)(316002)(66946007)(66476007)(66556008)(478600001)(6666004)(6486002)(41300700001)(8676002)(8936002)(2906002)(7416002)(5660300002)(38350700002)(38100700002)(921005)(1076003)(26005)(2616005)(107886003)(6506007)(186003)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OlT+9ik5qU1Iz9iXTT3v9UFYCvFihFi7uMyp+SPU3n9jE7r4iPF0T7WykwVH?=
 =?us-ascii?Q?NpktQcIQIZqYbFsQZPKhDg2PormTmKFbLAEVBROyO3r1Mwopwbt+Cm5x0FKK?=
 =?us-ascii?Q?OGXgugtFAnKIaHH9wGAixbs1oRCvFcpj7tfxyTaFA1AdTU+nn65riPnQHYpc?=
 =?us-ascii?Q?ESsvRswpNs//AvksiSUVrdPbjTXwmsHNA/LHm4pN+S5EMO6jbW7Vy28f74ac?=
 =?us-ascii?Q?pIywVQwPtC/Vfx+YrBBxrAwU3++8rLbWEPqTMZF4pNcKHlOecN39D58hrkqS?=
 =?us-ascii?Q?sf89+IM7DTxLdXQa1pXTFOhxDl4dXU9gTTBLwBJTqGb2EL0rDLJpKr9Z6D5E?=
 =?us-ascii?Q?U+jFYii8d27WHSHf67KAjkxZPPBVBkXtTrOlH+Z5U1BSGljzL+rcQfgcqJTN?=
 =?us-ascii?Q?Ttic0HzQ68BRjPpAlCmbjaLQFTJGLrKwwBN20SB0HgVkhihw88p6SnZMYtnQ?=
 =?us-ascii?Q?julHmkm1xCYxXeR+HTDuEz8rf2acGdlpqPkfNnnM4wrN3pUrqPZ/pUM21rbv?=
 =?us-ascii?Q?bWy0B/PVe56v/G7wByzlu5jru/cC/ytlnro7e/3mWfVVSlCZFk7ZI+qfTXAj?=
 =?us-ascii?Q?90/L1rkdnokuQvdY6E3o6d7rcakfYTx88EVCyMWngqlPGgkBjSSLDgW35OEH?=
 =?us-ascii?Q?FB0YUJCwalXVpD2bv/x5KuFxShPZRci3qgnwYirgISE0ZRIMPz3dzMX1kp0/?=
 =?us-ascii?Q?RvcVYRMX90grtLmeBVI+0T9UeD3LsVzDWTCCzBP/IaXIcFakObYxdMANCE/a?=
 =?us-ascii?Q?QJeMFyfP0uIplWZ8ushId/URvrQNr9HHMDYnMnKNzp44ejdulkFSgEw0ZclA?=
 =?us-ascii?Q?BhYDpwcGj/DK3+NxPJkRZOsieonRLoz4niCSuXzmnnyWyqPAtm0B6YT2MpDN?=
 =?us-ascii?Q?Ia2qlDffDL4AhEtnPBnEG1M7Qp3XZ8tNCeZUzBX/LWU/ufSZk/U0jnehLiLv?=
 =?us-ascii?Q?OSWdqKeYm4zqy7sqRliAa438WY6UVF+qhMlUBtRnToAk5j4q6Wev7D7AeZya?=
 =?us-ascii?Q?O/vE2QmqpAbvpj/r0ykRs7Zb68sJvrQ7y2uXxP7vSwtsRD6XppE/ZNbumFi2?=
 =?us-ascii?Q?dc/8V09nTKdwiWZ7nfVM9TFy+7k6+JhVYgYolA9b+9bMt69KQeyD1hnxr/aG?=
 =?us-ascii?Q?vkFy854fX+Jdzcft8tZMk7RD5mO+drTmbuUGM/2gtPwvC7fwiFdxephD/s0e?=
 =?us-ascii?Q?MJzVNxmLo5m/Oke8pdg8lV3lbAAOEdVlmtq6trhfDoBtfjph/DAOW0mEELQF?=
 =?us-ascii?Q?xSoQR6f21wGi+TIdIC9GRh8Sf9DF68W5qNmHEoMlwgH2djvsulFV/0GSFeMM?=
 =?us-ascii?Q?xs3VIr1jAe0lBQ7MDTPGhaZ+3pLIYYdexaCuy5w8YBDb+vq33jQP2Fr5l+vw?=
 =?us-ascii?Q?mSZw7N8WTbYSI/ODkQPefpi+KrWg7BRnG5GVhZOgaQBp0+WU09ZQ2uPPdVq8?=
 =?us-ascii?Q?0+A9AJ/BQfDwXNDtlXeiiA1E6/tLsM1b2hBDQPIEA3yL23sDo3cGM07UZvhA?=
 =?us-ascii?Q?EynaN2gB9xxN9BMAoBzjgdZ4GRMMSOeqXUnglN+drEaRJQ7qxtf56MEn2RAZ?=
 =?us-ascii?Q?qLl/X8kqvr9jHwWhwNGBGHAfuKWca/jR4lKBPlUq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab77395-31c2-44b9-76c9-08db5d119c6e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 11:17:22.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys48pXGKuwdlhNyTo6QEiqHYkd1o264t7TMsxJoUnfcHhzVUHmSFW/istHujw+2cZ79ktygA0yQehCpkdkjGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_available_child_of_node in lpg_probe and lpg_add_led need
to execute of_node_put before return. this patch could fix this bug.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
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

