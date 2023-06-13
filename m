Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4C72E6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbjFMPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbjFMPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:08:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DAF1734
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kegOWezTAxZ+8Ks49G+vsqG89L1tyIjRYvU6vYyUgczeftWSbhLcOLk2h1FSXqgvHpiS+eMULVWME3AIHnNLMiGsCcBuriVe74/tXvNUaIIy7ubiTdaZB0HEfZuP0ei7bo3npz61roHtW82sOu8pshh15qNPHViI2n4VY0x0FC/2Xc6lES/nyknfPGs9ChWKL7pK+9yzyfUIoHFheh/aKd7863sBXqGSlp8SelslyAfuHzaRn8+Zb5tZ0LHvAws3co4yHNRARUw8iWidHiGZAIRUteFg7Mz27+TDM9EaWEcrI0fln+Kzuha1K+FKNdm9VekxdaVyGwNVkPnwX2/7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPNhDRH3sweYiFPB78b47wYR51769PM4fRCTHFoMDMo=;
 b=E69QVF973k0o3Y7/LhyqvOYlU+d+vOUwUi+pmy201ckdI78zr4ViNrF5zK7R9kV3n2z+rV1Tb0N+wc7KdRps1JDWrhm2uj1rfpIw5Z+9KGkxdDk97RbqLZI1YlFDUE0L3MxZLDdomuykzwX9rYAc8JCDlwNxeRzCZzwqje7sgkH9u6VkLMBnZSuIUDbZpTpzx2mNQhF96tEv/MDfUuBl03ppM2kewQHPhaTa3oHhJDuaZ+myNlKVxaExEGj1NPoXzU2FFXoD7YASbR2hSe1oCRSE+lw1Qs8DsVpIR6XMEqUy1wSSl3Kytrrsiocl2rOpKMAbYfJFC/H9T9cIgOcr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPNhDRH3sweYiFPB78b47wYR51769PM4fRCTHFoMDMo=;
 b=j79bkkaWJes2K5fBuIehgIsJPw/em6rr3O6OlhT06nPywrASek8xkTsviJhWoMfk98y0QZisMai3Drs7RvQWiLFrry5QyJIn910jsmDsXkwvGEOguRifnF6sHokAdegUXeViRc7du7gv64tE0+fG1v0A0LWaWyvuM95Ed0wDvsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35; Tue, 13 Jun
 2023 15:08:17 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::1f2:6f48:8741:cc32]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::1f2:6f48:8741:cc32%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 15:08:17 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH 1/3] virt/vgic: Increase number of DeviceIDs to 17
Date:   Tue, 13 Jun 2023 18:08:01 +0300
Message-Id: <20230613150804.20595-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3405:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 40751287-21ff-4541-4c0e-08db6c200449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8LfKf1ZqcuGJAaTvE4vQWXS0716eOJu0yzEeSXvwt+DOoTUFo/0tZyB7rVsFIALCqbwhSH3vru9m8lL273I8AFM1lPZWGjJ+UQefQRfdhew4mL9+05PxzCn6xoripRBNtgqVif40Wy64QgOtWD93nzVkoB2TkgiKiQEWrSZsxThzCLMr9uVzL4RxY0p2Kbv1NFUL1MvsXKVOZmzR95j3c4nFEk8lNLfrR43PmJapVc5796SsmyUnPskJgSLj95tkwn4vnSTcQ+BgYrY8vr2HBph/kkFGTp72gEQofDCpIhBH8nJO5qeh7AvTRy8BW8+WlKzKDY1z/S4e2Gk75RQHLLflZp7F9aujmxdPtnXN68Yl805znl19Qd524lpqhJIIE4IJ2wxASqlFiWkAKGpGzcE/IaW8JptaPbQaJNfWy9g0A316VbhI0MpEg5TFypTap9wx/6MQpG2edQylyFEVbdqTT4tB+c1xXtAihqcRP8Velw7UR3ze1a5MaMmC/xOy6+xmd9ULqyk+ZyjX49Ve6V6IqJ7J3RZ0OdWK7Ewb06opatYeoe0eLOzBvNTUlRqxa3JBV0orga7J0SfS4r87fwDOdBENWdkpKAVfV4Yi8YfjL1CPmlzKRhXjBsG31Ar
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(52116002)(6486002)(6666004)(36756003)(83380400001)(2616005)(38100700002)(38350700002)(86362001)(6512007)(1076003)(6506007)(26005)(9686003)(186003)(4744005)(2906002)(5660300002)(8676002)(41300700001)(316002)(8936002)(4326008)(66946007)(66556008)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8rgibiyxNb+B14uoZfueNEpgxgcjSOx4CDO7QIKqzrJbHOgkkxNVaOvQjoV?=
 =?us-ascii?Q?RmvyPb4/UAtL70oW5PsRJzOcPN8A2y4zziGFug+IfB3zrFt8Hlzp4fdvnfNd?=
 =?us-ascii?Q?N/5yqioY4lWErd7onUvRO+zY6oJpcCW/z5IqLUYKXYc6KgxFWeKRyjc4rXI6?=
 =?us-ascii?Q?vLxxRuIDnd8I8eMpdlv6+HdOxWG5ceyCla70VU07EwuAoNkiS1kJfAHyeWV0?=
 =?us-ascii?Q?K2g6xO18M73osmDtDEBFI0UPH3YMmblWpjjMND+UGpFpGq8SD+2yrTdudBbE?=
 =?us-ascii?Q?BVp3Tvwy1ujArrHe0D2W9YodgDWMMgcZfliGniAPmMzREVbhRtmDTeaIwgMf?=
 =?us-ascii?Q?DGhDsiuIlG7L+zLFYZvo3AtLEuAmotBVwYDygHUIZdSFNzJxAxRzlpky07OA?=
 =?us-ascii?Q?jXob7fSxt3dD4ygA0/O6EEr3hj3QY2wzA9AfKwG/Kvpo5tRli43aEcSVtRbs?=
 =?us-ascii?Q?L754T3gjMplIu0Ax3D1qnu6H9PnGlYxzKcywC8zdKJTSlw8SJAtwDO7FWd1z?=
 =?us-ascii?Q?hIymtgKHb78Y+VrGf657upDqxaPmNhd1EE6eORwovgWsT+1KflzgjKnuJH4B?=
 =?us-ascii?Q?cx/r8Tdib9YCkVRL4TewRo2rz6/FbbE6DQOBqw57dpkfMm8OoAue5BNPnb0v?=
 =?us-ascii?Q?CrbIUpaiEwlvH+LZpXhmP/AQMR4a1sIRxK0aVg+d/2VFQHyXg5xntFB6MMN0?=
 =?us-ascii?Q?VtppxgIIcNmo33D9rLVMc3qKR3XeqtDavo4WKGivlOLf+ZFTmyuKg2yTtBrC?=
 =?us-ascii?Q?tMD0h5P0nSSENhxAPqxDkEMEyV7Le7XlZuziLfKwAGY24IhZIzP4btGAvMSQ?=
 =?us-ascii?Q?i3Y6Y86V4E4sXlp6VfIVQkTZJUsBHFBkSk70mP8LVKKV5eJkpSbafSV6y6p7?=
 =?us-ascii?Q?f+OcQJ3jV7ZRxnzvcCO8jXLFR1jF22FusC3S4A/02YLMvWuJZmSm9LYep3Gh?=
 =?us-ascii?Q?FnJZd4EAaO2ZBl3wuICdjiH8ocSXI7qo5WSvovPBxe6FjSoE78toQ71Buykw?=
 =?us-ascii?Q?Ma8WmkwxFW0TEQxipW3QiYpeNkuSx4pth+1/bGTq6wKZIgK+T/m+rlPvJVU7?=
 =?us-ascii?Q?Yahjnl0aoyL5byfFedHtD2vBTlYDeYrM1WmupudU67TeVp7FC9ZLSoXmMF/W?=
 =?us-ascii?Q?TGOfnpjjq/wqf8YFhQILrPiS3/PS6W74LZqIvdo6xIyddyM9hU42qG3jFg9O?=
 =?us-ascii?Q?7vgREp8SDn1FUzAVP59nKooGN50SZ+UQchEXA2K1BygR9GZfkyIo5VQndD4J?=
 =?us-ascii?Q?uuwfreWinBraqkLCTX+QlJWZATfMHxLPoSZKHNLtvrxS2ij7Eo5VejOlBWTP?=
 =?us-ascii?Q?ShFTmMk/Rs/KHWq7bSuI/lnRPZKzZ4aav0ftl3WUUwFMY/0gSIX4MMtTHYVD?=
 =?us-ascii?Q?DJCtWLAwkmyBq4WX6AfhBT1svnTeEBIf/QScb0gGRxSZ8xwliP6d0JYq2whG?=
 =?us-ascii?Q?GJeYn9+BROD9Kwc0MI+/9uvOhg9sVZnnwzq8YctZdPlPkdRGWKiNI2S/uTca?=
 =?us-ascii?Q?2S5rDa0d4RaKr+0K27SGv7Bp0gQysSGvozVubK+ceQcMFPCBOiUWAoEyABeO?=
 =?us-ascii?Q?LzfSg5HrsGnWxdak1r3qtOZ9g8JT6G9iY/uS1cxg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40751287-21ff-4541-4c0e-08db6c200449
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:08:17.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3INr48AvA3xCrKDlaX85VA33zDzzWV2R0pydigH3a7DxFXI5BgO1G/+kMyOZL3WbHv/tvZEPQj5QnLlO18hrkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Bhushan <Bharat.Bhushan@nxp.com>

FSL-MC bus devices uses device-ids from 0x10000 to 0x20000.
So to support MSI interrupts for mc-bus devices we need
vgi-ITS device-id table of size 2^17 to support deviceid
range from 0x10000 to 0x20000.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/arm64/kvm/vgic/vgic-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 750e51e3779a..cddb54ba6e13 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -248,7 +248,7 @@ static struct its_ite *find_ite(struct vgic_its *its, u32 device_id,
 #define GIC_LPI_OFFSET 8192
 
 #define VITS_TYPER_IDBITS 16
-#define VITS_TYPER_DEVBITS 16
+#define VITS_TYPER_DEVBITS 17
 #define VITS_DTE_MAX_DEVID_OFFSET	(BIT(14) - 1)
 #define VITS_ITE_MAX_EVENTID_OFFSET	(BIT(16) - 1)
 
-- 
2.17.1

