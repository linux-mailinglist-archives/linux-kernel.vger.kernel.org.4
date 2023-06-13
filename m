Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082D672D824
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbjFMD16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjFMD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:27:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C46513A;
        Mon, 12 Jun 2023 20:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLDuqdJdcLdiGwaYmf1vjW/+iJtjdUBToTxIZ3Zi/9YWMO+fFVpWDwYJYbqfGcfTcOcjYE30nTsr/eTmoJ/DzW9AgR9gXVBbaZuPSYIzrK2lbAlz6w/dJChWAfcRa24iIB0rTELsFgsp/JFbslJoCg0CE8UfxRJ+Om4aRTsJ697QNOkToYzNkKxz1hBgXQ+N6QuHgemOXBnpA2Yw78YV2gzo3FCCDhsxHouwsjt7uoxZ1JvEEXhgvskift4o21Vf9xgEoPlV1lJ7WdyKbjft2Ki52BdI8pThAXdXe3m3w9asLQwcDWuCgca7GOUdZsk2exgSWLfTg6UXGWI/mAPtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDGOtjFWBz1dVSI7dnBDRMXYhJXY9qa1SyBIuu34imQ=;
 b=IvCh7hdNy3cveacjzvGxMX2rQABeYqe+4/Orr97eavh73f/wtDiURf5b77bGcdZemGsdayCnSG8CBNbEZSsWSno2Ye38ZRyGDx1iojMS4B53Zr20d696x/t438lAjQX4XqFxeuBgMr+o3IfZ1a+2iMDxNOzR3ANnN1l5kS9EgE05z7q4aJQg1BeY9XTjn7OiizqnRBeYJrAOVgH3F9A2OKb+1O14ensxrPzLaiXG9JPI9fRL+jAhdIug9hcnTVmRlmkq2ltFuu1wri5cu+FgYv8mSb3CAfGUXxFxSrApr/MPWDybXQfU+1t83HRP7CgY2N23YI2Beegdro5LmM2kiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDGOtjFWBz1dVSI7dnBDRMXYhJXY9qa1SyBIuu34imQ=;
 b=pukUosgnNeZbDV5va+ipoQIC6nguvkcsj8sG0yD1hc9QvhrlnuRj6ki5vhgcAUuLERJObJy4HDZknxycmD0gTIci761BmQUh6Sc//RRtsTyhTN/uk6TjwLb/qMN+G1Lg6jv7cgr4g209K5f4tGWBiWUfy3BjC9NyilnmxsbDFbVvNEnPDTifAg60mQajtkfePt2KI9rAduRdkZC3WkofFaEdACUmR6bZLv3YEntF114FT0/QO8dVBgS6qvC6PekfcPWklZFpPbQNm04xH4wrRsTtA42ib6clkgVb5rbEJ03H8s2JwHxczdYgkuX6UBZlwGsutsfDLSFb7E9sQU708g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEZPR06MB5966.apcprd06.prod.outlook.com (2603:1096:101:ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 03:27:45 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 03:27:45 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Lu Hongfei <luhongfei@vivo.com>,
        Sun Ke <sunke32@huawei.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3] media: platform: mtk-mdp3: Fix resource leak in mdp_get_subsys_id() and mdp_comp_config()
Date:   Tue, 13 Jun 2023 11:27:27 +0800
Message-Id: <20230613032734.34099-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0138.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::30) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEZPR06MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a1b838-2e80-47a4-47df-08db6bbe2751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARwZ+AmRwz34Fg0mDgcQjsk/Idhm380ey3pQirMvyZpNf5wPH+r9OsisJOLycEMrQUXzDR+Fvpd+Yikw6WahyvwmJYkuTwVH5k9yo8yKmb+v7atTdp+aJMJYrp+0BlS5JO9O+g1FdBUYmalBhZLUl5WrYE1bXfQue3uiToZ+xVv7xpC95Lg6+VXUht805cUnD9I0WIhZvueR+ugMTv1W7EaDb8+d0y9z2bIOBlvvtAFSNZJJ57Q1Pk+ANmYNp7fyocmPi/keR9IgmhNq6kYZ5jtfp2Ft2u1nq1FgJZK/NyCQVARF/e6pztbffSELp7jLt2bYSUwdZAVRgwUQIT07q0WNDm1uEBllcoKizguOEAJQjkQsH+o77Koq1cxlDKWM822OKAQzWiWjsviKwANj8eNvVTy9DXBUbvbyPvWcX/XhGcbBz35iezxxwgQf3DEB2vF12kVi//fC8UjOF3qWPBTkAjIzTZXNU5xtphlMjmoOR6R7udDqsCk74TbIWYek1+v+gI+OTUiQ6J9as2t5o8OWkNW2MQTQJgM5RyZtFrotn9quzK2m4jk6yJCfWYqSpNEtQs6/Sa39f47JaCwNJURiF2u/2FkTIvNPq9++obE6T/0HfQ9O5nsl6Yt0eStr+bRDGosayZYNnZnmrCBFIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(7416002)(4326008)(66946007)(66476007)(66556008)(316002)(110136005)(2906002)(41300700001)(6666004)(478600001)(6486002)(52116002)(921005)(107886003)(6512007)(1076003)(36756003)(83380400001)(186003)(2616005)(26005)(6506007)(38100700002)(86362001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZDVXB1cWZVZmEzWFdaMlEvSXdCb3VZdmYvUWFOak9pRzBTcksrKy94eDdj?=
 =?utf-8?B?T3BvQnRRYTdkU1N0ZFNPd3diNkR2VDUxY05uSHVwaXdkNG4ybXBwd2xBYVBM?=
 =?utf-8?B?V0d2Zy9IcUhFc1p5WmI3eHBGeklQS1FNQ2psL3lLbUt1eGdndEFXdk81SERW?=
 =?utf-8?B?OGxRaHN5KzVyZlU5eGNOYmlBU0EvYXNSNUM0Zk9ONFRkSm1mK0M3dmlxZUo3?=
 =?utf-8?B?dndjajVsU2graDFSVzlKRlpESDc0Z0x5K1NNMit0WC9KaDA5K0lKbzRZZExl?=
 =?utf-8?B?YmRYR1BLYzUxb29xMXVneXB0RTBWMy9udE9kMFpUNzJySHJjTEdwbTYxcHhK?=
 =?utf-8?B?alBCQ3lOVVdCckVHQ2hZcWhCejZTeDdZT2t1cVpJU1RqNlgxN1FTZEsweXBS?=
 =?utf-8?B?c3JKd254bFYzMnhWOG5zR3o5OGFzMW9KYWh6SXIreTdGaUsrTHhkalA4QTVD?=
 =?utf-8?B?a3lhdXVpZzlOQXh2eFBmSUl3aDR6ZERaTTBZcHFwbC9ZNHA2cjRDRGo2VEZ1?=
 =?utf-8?B?aVRramxDQnA3RWxCWHYyaWszeGtRQjJvdE1SYlFhVjRqZVd2cUpGKzByWVIr?=
 =?utf-8?B?enFzNHJjQzJFRENRRFVUTzJselB2U3V6SE5LQXFKZ1FvRUZtbUFUaGlFRGJ0?=
 =?utf-8?B?Z25WVzN1b0xFM1BrK3NtOThqZEpSME1adXRFNWNvZU96UmN2ZnJXdTEyajVv?=
 =?utf-8?B?U290eTVzL0hUM0t0cDFWQU9nbE45MXk5MjV1TklRM3pkZFdPTDJuY1dwY0wv?=
 =?utf-8?B?bWk5dVltck41Q1NkYUdSUHYzVHljMmNSbE1IbCtGQUFiOW1OdE13OTVTMWZW?=
 =?utf-8?B?Q2x5eVJ2T2hKR3Q3UXFCZzk2YURoOUtjL0tMUFhBeHNteFA5R3FzL2JhSEdJ?=
 =?utf-8?B?N2wxRGJHQk5wQ0dDMUZsSVBuR0gxU0dWUzYzelE0NjVHcytYbjl3OUxsSGJM?=
 =?utf-8?B?djRtb2FLQkpicGRmWWErS2F5bmx4Q0Q0L1FLOUY1UFYrTjhzQmtEMDRERlQv?=
 =?utf-8?B?M3BNN0hCdktaazlJUksyMklTeWlYSUgweEF0SWY2TXFnVlVwZ2owMGZWbkdy?=
 =?utf-8?B?VmUxMkNETnQyKzdWMGR3RWk0aWxNVllhK1B5MkVIWTBHN0FZODNSK3dxSWo2?=
 =?utf-8?B?VXBrRXpaV2srelJIb3NlVmdmNlI1aU5IL3A4S0ltQWlrR2VZb2t5YnR0MkVq?=
 =?utf-8?B?UEo2d2NJT2owaG9aNnZzakVCQUJCTkN0STlkVitvdGVDVHhZY05SNHE4TkVV?=
 =?utf-8?B?NzVKczJsdHdqdU5iaWtPQmtqVHJvUitpWitjZmRPMDdySTMyK2NSVll4ZW9O?=
 =?utf-8?B?d1FveUhQbmhoekEydEVCYmYzZHp4eGZRcnl4WWNPYko3cWx4M0dvUU04Y2NB?=
 =?utf-8?B?MkFFcmhCN2JVY0I1bWZtb3dLMXg1SXliZUdCQWRCY3ArK2xvcXBTZ2JvWmRU?=
 =?utf-8?B?LzNWd29xUjVMOEtRM1ZEeTRpL0dPMk96MHhwZHhBKzU0TmV0azJ4cHhVSkVT?=
 =?utf-8?B?VHFCckJZMFo5RVVHSVpCczdKWGhndWVERG1GOE9XQmVVZldZTTZ2dENtNTQz?=
 =?utf-8?B?eFFXYUdkZnE0ZG9WK1VxYU9iZWtzd1Y4dzBGL2J6aDBWZmg4T0w0WXF5ZFRX?=
 =?utf-8?B?T05Ba2RsQ0VEM0lNNHcwN0NyUXVTWTR5NDU1UmhMbXllazlSbXRseFNZMHM1?=
 =?utf-8?B?czEwRTNhY3RjMG15QkRVTkh2K2hxUFM5bExpSkREZkdDWlhaeHRLRnBPeVB0?=
 =?utf-8?B?bk96d1NKcS9DOFhLbkpOOEh5TXV6UXdLN2wxMFBUMXFlZWcrVzMyb3ZXMktT?=
 =?utf-8?B?ZFcwWXBVL2ZOcGVqVXRKRG5Xa1FPR3ZJY1BMUERHbUJPbzFhcEthcmxsOGgy?=
 =?utf-8?B?V2l1UDkzajVsaUViOXp2U0Fsc29UcjZwVmJhMTVNMGVwYUdpUS9LSWlzRE4r?=
 =?utf-8?B?ditseGd2WmNUcWJwWVZrMmNZVTlXTTRYaUtIbklCQmlPWjlpdm1JY3hJekZ4?=
 =?utf-8?B?TzBERGw0UUVORGQvRkZyYkZXU0tpTGx5bHFJZHBwdWNmZ3pjVnNsSmdLcTVI?=
 =?utf-8?B?eUhyUS9Wd1Y3aVZ4Y0xrdFpETDJlaWlPeXRYaHQ0emttODZxdDhwSjNjQ01p?=
 =?utf-8?Q?eeCFNntvsNg0aXeolNOsZg6aY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a1b838-2e80-47a4-47df-08db6bbe2751
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 03:27:45.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJrAr029fggGnG9K5YWhoIUoIoTZLmewBBiflsALQi950ADr7H9i3WKhAZwek1HkhRJeTiw2kILFz7UD1dsXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a put_device() call for the release of the object
which was determined by a of_find_device_by_node() call
in mdp_get_subsys_id().

Add of_node_put() call for the release of the object
which was determined by a for_each_child_of_node() call
in mdp_comp_config().

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
The previous version’s Subject was:
[PATCH v2] media: platform: mtk-mdp3: Fix resource leaks in mdp_get_subsys_id()

The modifications made compared to the previous version are as follows:
1. Modified the patch subject
2. Fix resource leak issue in mdp_comp_config()

 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index a605e80c7dc3..85c5f89f2ed2
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -892,13 +892,16 @@ static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
 	ret = cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
 	if (ret != 0) {
 		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_device;
 	}
 
 	comp->subsys_id = cmdq_reg.subsys;
 	dev_dbg(&comp_pdev->dev, "subsys id=%d\n", cmdq_reg.subsys);
 
-	return 0;
+put_device:
+	put_device(&comp_pdev->dev);
+	return ret;
 }
 
 static void __mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
@@ -1135,6 +1138,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
 		comp = mdp_comp_create(mdp, node, id);
 		if (IS_ERR(comp)) {
 			ret = PTR_ERR(comp);
+			of_node_put(node);
 			goto err_init_comps;
 		}
 
@@ -1144,6 +1148,8 @@ int mdp_comp_config(struct mdp_dev *mdp)
 		pm_runtime_enable(comp->comp_dev);
 	}
 
+	of_node_put(node);
+
 	ret = mdp_comp_sub_create(mdp);
 	if (ret)
 		goto err_init_comps;
-- 
2.39.0

