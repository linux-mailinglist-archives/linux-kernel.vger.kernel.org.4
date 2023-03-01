Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF156A65D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCACza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCACz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:55:27 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B049421A26
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:54:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PINoQoEMWqGN38gGYUkrnoBZPEHUYwhfpZKmt4zra7qGkqbMA9UpMFO5qBZqc+UtrE8YB2dcCUdMrGr++aFGr65jsQMX+Pp5L4QksRdHWv/9LwNNfcz2rh9HWh1IvwDldDXHmgUqYOlhLGX/MiHDMYl3enP9I85+asL+7KdzjbEIwahkRGdsZB84KpU3kgYnSHl+rYq8TO/Wb4iUNdbwVFFAohE95/yEmUBMSDL0EwLs+OsZhx/8fwlOndfQ8jFPfeiY4fubkqD47EXbOyRgkx03YBXA41oZhjPbI5/mT8AgOYdssR6COeea8PpvRUIo54uAqZumvcQTkdiBb4DrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJtx4IerzcTyFW+T5Q2PQfzsta97Cr+IXa9xAGnO4Y8=;
 b=CY2jsnr5ytJlYzNm+iRCg+ZhZaozISvaUyhnNOa3lcakHCglJ5CWXYQT7R6Tm6tEwhJFUBLGoImsaQV95NeEc4dy+dINJKwWWUdCu56zut8Emr/X1Ab83CHxH0Ens5gkkzOf3Nat/hCCNtzj0dZNQFmVA0p3pSMSREeDveOLe7WWQG3yJalTtPb42Mcrd6oN4Wty6EPZvf0/TcoYtTXYr5Sy0X8M4gq/rBhhGM3T9Padt9IEqdDrwK0XhZcKatykaJQJQN5ujd0VoVyksmXsRZk/Tw5PZKTJ/g5pvmI5nbRuMZntWVpicbgYg/hsTUjACRhv0UfQKd43LxNgjPhwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJtx4IerzcTyFW+T5Q2PQfzsta97Cr+IXa9xAGnO4Y8=;
 b=TCMuaxGOCXFgPp5wnlN6Rh2jPd62BPlGCQ460hFc0Oc4kpVu61w+OElW36qfX6pen1z12Y6CVjYO4/OC7E1LtNvz0fOZ+S1iQwq8DJvZRAtt8ggIPo6ZydvmfxDKLr0uQ05IMybALfKoMNNHhs+MKae0NABQgDnNxNX74hZWbIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:34 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:34 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 6/7] soc: imx8m: Add MODULE_LICENSE
Date:   Wed,  1 Mar 2023 11:00:41 +0800
Message-Id: <20230301030042.2357706-7-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301030042.2357706-1-jindong.yue@nxp.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: f3750d4c-92f6-4567-7625-08db1a00495a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lFvv0z4yLIRUGb1PrhYhqfSJ6KcoLRRvuyKfUJFv9CIyy8gD0fjx2hdNYSM5RjPmwmP47oBV2WwVzny5vaqBkdrChyv4Q9Ad5CVirajzXOraOwkUyQgY8fuH8rvnWjmnPXPxK3PMrBPc6adhJaJvVg71H6AP5CACf/sgCqj5WBoEJ0wM+UmU0v6v87TiWqo7179CM3pjf3jiO3YNQTW4oELN/5RCFvjDImTztxXwetGK5ISf71d/xYrRY8GdQc0cisgFQFIrHjs/gzp93GTzZtXtUjCkMmXEP+m18h4eyQJ/CwCpefidqL0D2cKdqC/oFGmVSZFzLuSLkUNmleazZLUeJXfiwinruWow+mLG/25gnhkmdbEIjJJFn9m5ROog8xGXdhSheZ6MAkipBgdttYJGsRdoxNsohqOL0zahrV/Qb4UgdG9r+k6gcGIpdWMFuUbGJNSUtM1gDkByoK/c2ClXBCzYNFdu3H6p5HbyE+Uj/bsdXvNU4JLR+CmNuv+6gtZM8QJlugqYcJgJeBUUZKH5ivaOfXHElWMagg8nbz862CghfXLGRQGLKD9aaKI4aqsXoiBufbUrPG5Hjghq9AzPGIAI9fEBPaUHVq8LEizzjXxYmKh6zosLsE+HchyIU238YlqsqOoIMKE8v2P9CcSjOhRneCZcCrqi9169lGHAXQWPxxrlOXuGOGLlt5G2UNs/XkLPVSDz7k1ycx2wAyXgKuZMfjwkrXy4BCnRDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(36756003)(478600001)(316002)(4326008)(38350700002)(8676002)(38100700002)(66476007)(6506007)(1076003)(6512007)(2616005)(186003)(26005)(52116002)(6666004)(6486002)(5660300002)(66946007)(66556008)(44832011)(4744005)(8936002)(86362001)(2906002)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rps+PH2g8A4LNupOP8tklvsagmCyyFmVRzJEi4Gbk63yzDj/4ZM2N/TdgdNJ?=
 =?us-ascii?Q?enYP1TgXdmo5m73LHWx3e99ov5FD9+cosz1xIx89hBDfyNTRy2tJRHd37Pgl?=
 =?us-ascii?Q?eC7bIssph8+gzzh+Oh7v0MMXS2yFuUKnzySjI8CkYtdQYNWvtb4JVLKNSG8z?=
 =?us-ascii?Q?E1P2Zt8sGgwBtSptsTtJ3/y4izpGv+WebZczqEsHm2pOI0+bSgbfdMhmaut4?=
 =?us-ascii?Q?1Q5XUvUasm+YtMFwOE7yQLIXLlQ70StI/mgvuIbRFU1Bs3o2mpnOlWd6at6W?=
 =?us-ascii?Q?HOPK05ixQ3yLVQXdgzhMuaJFJ6EuuhHsq/63vzRfemQNLJjB9MLyEvEWVMLm?=
 =?us-ascii?Q?qgFi8DcjBefxbv0UNAMfBWWMVIhSrYl7ZqT80WlvaqqdX1O6jytXVaJoxsMY?=
 =?us-ascii?Q?wZfhRwAiOCAwRXtnBmeJDz/wsuWyjO3UZVdQ4XqthL2iiecTcynyL8l9cvVA?=
 =?us-ascii?Q?TFZO3GcIruNEhXSBbEXAvUUUG+4IC+oFoTICh4OAkBbxAcC4C1gOuVpn3OI4?=
 =?us-ascii?Q?OyFtC3dQnaTR+EpB3NTdmtePR2WAJPYnddSG95xSOFsVeFJo3wXIfiXhmlyv?=
 =?us-ascii?Q?TjjicdK9ZbTUhM3eeIGb9rXgFslmUhpFjJ8gcZzRiIbtZ3L4Znzwj9EQwMU+?=
 =?us-ascii?Q?VOYE2wsFR40GAFUilrXDsa65SRVm5WOJOkJJfR0fOxLD9G9FdIX7PWVZA1va?=
 =?us-ascii?Q?B7VpUmOoJaT2kLtL1i3PwekSmHThHVoi2WO2G5nSUJWzJEzQxmLBZjcuOkQ/?=
 =?us-ascii?Q?OX6l0KZOamW+2DldoiFdKwurvU6kGnBV05tYyLTvmG57EZhz6uGsY/ttz/sK?=
 =?us-ascii?Q?8dUQL6bHymn1DguZtErB+zwu0+bEvU/8sZYJUIiFLAZAO6/507vFCoEO0Yef?=
 =?us-ascii?Q?ehMrU/5serltphm0pxio7NWVxu9tD7gre7ReIRSOnL8yH+arLGQZgtmXBiDN?=
 =?us-ascii?Q?cj2c1L8GAvFrY6ba//fhHb7gfCb2gwe7iA9PffSj7AAtq4dqfzQvRcl7tvY6?=
 =?us-ascii?Q?cueozlc+FeTy0Q3q8tAR6MSxXqbEPEk1fH6m0nvbCpwoTcCFdc6Od8xUkNP5?=
 =?us-ascii?Q?Fu/1m+HXugT/GfRBlQK6wZOCdszQw3sQwl/rUeTYRYl0wwFqq7FmnTuMFwLI?=
 =?us-ascii?Q?zx2DyReJvzxNfbfbFsSKlphdYV9ojJ1Rrd0n8Im7OT1vhZYi1ulaB2IDI2rh?=
 =?us-ascii?Q?4cZ9koA0fmyzLDA/vg0RzmpEQX72FDNbQJUSAN8ucc9KuRNoKbMjLCN8cQga?=
 =?us-ascii?Q?B4B967HuuN2ipoJsfENeLJ0HQ3BJjlZuTWQyxnF5A1CbCElm2UvC/9ESkIHf?=
 =?us-ascii?Q?d2MpMH00a8/Sxdsk+700ypHyseu54c/azv2mU6m8OmBqNobYhc9gPksWpkC3?=
 =?us-ascii?Q?FhNfmrFZ6YHcsVlrWTrxRdqNEFLExP2IOcZ0a0zXXn4LtkWOGHoErIBBJb9T?=
 =?us-ascii?Q?iWAEbhM4si6OWylaZ8+MfGrzEgujkmgPzsjX5ZLB3woLpiLqIUtZGmMF+u6A?=
 =?us-ascii?Q?rvrmaf9ah+d3o2XOGRPnqCpb5xYYZ/LemLCzJXV8RaLLK9kP0BBavZdvpemI?=
 =?us-ascii?Q?Z5c7qQ+w0PcyukgfuV8UlYfHfj51PuoX8ql0RzS2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3750d4c-92f6-4567-7625-08db1a00495a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:33.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Im2qqgvMSWRWpUIsbndsi2JMVQKOB5jfxH1mVNdiZzuHGC039jjJ1GliL3fncA9ARmvT0KhJ4we7hIJ244OzYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 32ed9dc88e45..1dcd243df567 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -242,3 +242,4 @@ static int __init imx8_soc_init(void)
 	return ret;
 }
 device_initcall(imx8_soc_init);
+MODULE_LICENSE("GPL");
-- 
2.36.0

