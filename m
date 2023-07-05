Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B1B74841E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGEM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGEM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:27:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E97DC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZVOwBkHE7DUAZv4Q2uVnkxbGBHWOxbqN8xiwR1Fotk3E3Hjjw/805HD81bnbQ++/Q8T9an3jQMThg8wi81bHqVCMe2pR/nlw+aOwP23IoQVaoU1f8HITSxZRliOPK4WqUdf8OBtlZ99zqfTKbcCHB/FAz2MF8vMBwSuBvY8puQaodFqMLdSRcdx7fS2Jqs/MsLTXlBWiw6dLoxbMdcBR0NzNkzv4kJRHWFDSbLlydAdKs8nActhi6/kIilceUURYoR3q/FBUCJ/v0524pIzeb++smqFYBSoKMPDdNrJHk1/UucEf6r3bsh45qHtWWLGH1obtsZcsqcOhCi9dXCv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u05gyCUOW398OdPt/Q3aD3BuXhHxCsPGGMQs1qlwebQ=;
 b=JgSBwm5sxpFQCT3AVLPP6V64EGUYbYO3L9l5lTfIPMZgXaLzQg3T9/mLbZ8jUsnUkDki/UpogM/gkbwyKwdbi0lgd0dQRiIKhCZwlAo7u8rp51NTfl8y/GToAj+Z7TT8+j3cLa1WoXVb+sHFqbqmlUEZDTbw+58ojtumeRW2NKzdpnUNrBF9iRaMVBkH9XHM5SrzOf6pzK72CGy/2P054maOisiVSkIJo/Bt/cOFWzfUNueDJg/UsiwKIVTfCUe924MHdTy/e2VZ7v7jpWVvmL8cqjF6LA+/0NV3g+8xjb79RyxFHQc6tHL+ysoo8Y/m2H8p2+miwNWc5X/bPtho8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u05gyCUOW398OdPt/Q3aD3BuXhHxCsPGGMQs1qlwebQ=;
 b=KIxVBIVtNh/LZIfIzxBWtDerGUZlFvmX+IzQjcr6e2Op4larsZGRxiZqmqaPio+YX+DeMOJqmUJwbZ1qDoPJAF2tbl0Kw47hoFXIdaIUFiWJAFVOOAIGOnh7LV9nPR7+qGLK3yF7hIp/w/NmG3HEd2+cbmDCgj2C8VeQFOCwpkct/uOj64k/R6yz66IDUCq7t4Qw6F6fsYtr28xbigZBcyuImRqbumfnbiALWsZDKcEjMy07Zdtw6/h/y+lZUhADOlvfL7ngYfRQ2q0QoE49I//JbUtNZRPnCVdwMQgTCSy/iioBGJmG8LBvcQKE/zpJj65iSx6mgap5+w+C531MNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:27:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:27:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/6] soc: mediatek: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 20:26:42 +0800
Message-Id: <20230705122644.32236-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705122644.32236-1-frank.li@vivo.com>
References: <20230705122644.32236-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4d442c-0109-428c-039b-08db7d532165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtSbna9pVfAcBL1Fm8yGYCntQzKNc1rQc1L4DV4Upp3xL1/rUwQOoPQwO4mCe+NpFUvl5SSeH/LsZ3aGi+rGLBs0S8CUkqBVG/7u+wH2pglBB6kIfUi2unQiO/I9oyxlSN+DZU9Or3LUefdPJDEHS4TW3GM0MK6fSxQyKiZaowGIUEsLC3JtDTvvcZWDLS3QOVa8ngxxLlRy3mLjVYCuW8MPDbeJ/apEBOmcmJ1PVju51DLs9ltpCUfWirqyzsu5evla9q4zgwiI2UjdjIkogEESGrfBFqUq523dHuJnBLCUbzHC9s+0xw1X4g4FDQGnQ3OsGhZQ+L4J4ygKvxTjkFf2w36Pn+nMrLtV3NrPNNR+SOJOmFHfSdle0+/9s/tnPk4QFwPR+fSjDqqL7CJkUs5MfEn29nfs5Xrlw/Xi/AyCxyNwUDI7U7/fLFzWAjcKkyL6IXh3zAx7zgDFV25eHJFpN/mG12ddtXWoYy5TgXnBTItButml0DVnDm7PKwznw6lj0jdvfjqFqJ7+Vuw2vU0DIfFA76VhWcBfLVOAUR+cVdcb5AAyltvTzTS9vqc9PMWrnRKIYilKuetVWnpwJVEekCpPxTuCu2zPimXDeIU4xicLXQmKTuiR5osZjmQu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(4744005)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(83380400001)(2616005)(66476007)(66556008)(4326008)(66946007)(6506007)(38350700002)(38100700002)(86362001)(186003)(478600001)(26005)(110136005)(6666004)(1076003)(6486002)(52116002)(36756003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AqQRwkdaTB/yTMP2lR8pOmGGOEXN5fzvlKt9c3M6PJlpf5QqfZgk2u5C7Y2x?=
 =?us-ascii?Q?JfQ9Q4fTMfEapDqIR+TIFeDUhCS61ApnSLNsq3CI4z03GUD1koGzIL8IqPq7?=
 =?us-ascii?Q?EyVprZs4Xs03LB6IkvfgQ1QA7KiKddEomhHlkSzNgKOVvXiHSY0Yw8J2K3li?=
 =?us-ascii?Q?AERVxV7r1ueQFQXgTEpzSiladgxiX6EC40YQB/5uin7ySpyeeyH+T2JSyr5F?=
 =?us-ascii?Q?stHmzRQO1eJVo3BxXhmjLkKNmKMIkhU8eznLbmbbnn+RjUm14SMug20H0frO?=
 =?us-ascii?Q?+LkcXOW257YqJxzm+IvByg9RDqKQDSU7DqNqf5toZ7GeJBm5az1F9GwCiFuX?=
 =?us-ascii?Q?msyVjNLOEsMxq29ZYSPayuThcNKV+UdCF5zq+o4nOllSox0Use0HO8JV78zi?=
 =?us-ascii?Q?tBMknzEWEnLSsGJHz7KBMjcgQkjNI5y6bRt0lpL8AA+aIjf3cJISZYvFTxEE?=
 =?us-ascii?Q?CYb6rcDmc9WKV9K2zOOC+M6ahNGNXUodrXcdI7shAS4bMHai5+GnJI5UuwQA?=
 =?us-ascii?Q?AIfsvkZwT8yWacwnlMnOrmDp+rg7aRI42/q/eX2st1oTrCKSTFlTslNFlhNU?=
 =?us-ascii?Q?PpOuXzA6VwpjAG8AWQSgkWmZeDTm4D1mOeo7f6CiVKjqvRTfpkOX0Ga5wVew?=
 =?us-ascii?Q?QKkCqel+8sclv4MMfdlqq3TYc4Kc/hzy+A0UXuon8QV3XXC0lmMpzXHPqwzI?=
 =?us-ascii?Q?7wyV4oO6nO6za5tIXHLw/yvlA4ck17LqBmPjX/klyBZgCr8y2trAtCn23bnc?=
 =?us-ascii?Q?wooUi4EpGoc6/WBvJh3aoR+M8K9yQTMQPYsdZF1SMUS4ON34RiF9inUX5ogk?=
 =?us-ascii?Q?bes1LsjEgjttKd8lf8UzTJr/q48ECZrGDWIine8vOnZAHlvKGHWuuPSQx3Dz?=
 =?us-ascii?Q?UpJ1MWckCL/XD+nMUC7lQKanEL29Fx3WL6717hgwaV1BUT9ijrgogREoDoeJ?=
 =?us-ascii?Q?Bakgkyy9zC+zWQa0203hQN9yAl+9hqw9Qs+/KCC9eNoRgb9GR402Ol+eITQE?=
 =?us-ascii?Q?e0H5IMPzzjWdFhxauCSf+Z9gz6bW4Xg7Uvde/xO65nqQyIwi6rBRKdrnWdCc?=
 =?us-ascii?Q?XcLGpiTUboFqjfvzNKBC7NKrwmAzYxTC/sn3VF/scTKGBn/FXM30QUcjiTXE?=
 =?us-ascii?Q?/zF7w0zQD0yZ7YfRZ1LxgJyoZVVrG2HwZlMbKVDeGO5RKLKx/xRRT5LoFpDB?=
 =?us-ascii?Q?2v2MJkiT9lQWBA5TNzHx96DrIdl9WTNTf35j432BlasDkEIChR1T5lklMddL?=
 =?us-ascii?Q?zJ8Lxj9x92vVlY6nRb2WRphjERDU4EENl/LIUgEC63uCMa7lDyWy/9zHlAhq?=
 =?us-ascii?Q?kNhGA2U9ENisx8G4r/tMhVS2BGxcqOEDprrLtNLaTF5DK9A2dhqeFDczz/mZ?=
 =?us-ascii?Q?/3IYMKr21jfuRDnDsJcDwZ4DZjueYXPFWI2a4DGipHnD+DSpLbNr77Nsza/x?=
 =?us-ascii?Q?T97KqZDAXj5/aGVQbmhfp3V185XqCqNA+LWS1iWYlfXjRBviweCy5+VnTnzR?=
 =?us-ascii?Q?u1PSmhHVQp0HjeV6UYLq/3pOsUnZq2zUTERwLBYQa1L00vllk6iOL8HSsUgj?=
 =?us-ascii?Q?sQlpEuaa5y+u+Kg8xNl8ZI2fnxwQP7hwpFndDD0A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4d442c-0109-428c-039b-08db7d532165
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:27:00.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ivNx2W6+5qkTd2mf/R3jFbHXg4HdcDLdLa1myTHkC8DqyHB2011k1iij7mjhIuV3oyqk7YIC0OUS4F3rhWFfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 7a668888111c..4b5b972a6b5a 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -425,7 +425,6 @@ static struct scp *init_scp(struct platform_device *pdev,
 			bool bus_prot_reg_update)
 {
 	struct genpd_onecell_data *pd_data;
-	struct resource *res;
 	int i, j;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
@@ -441,8 +440,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 	scp->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	scp->base = devm_ioremap_resource(&pdev->dev, res);
+	scp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(scp->base))
 		return ERR_CAST(scp->base);
 
-- 
2.39.0

