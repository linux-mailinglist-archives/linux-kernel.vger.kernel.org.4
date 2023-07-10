Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35774CA05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGJCqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGJCqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D4E6;
        Sun,  9 Jul 2023 19:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEYckola8h9BsxjOc6fY1tek47SzCgAqO/o0jn/6d7Qh7+cN78Y8U4EWYO1mjvhWLLhRQWKwv+dye5MUmBUITqKYa4G8MY6HICJPsOJJcxbUB1638UcnWRiAg6+zl/RgVmgI9LhAN04xApxglSq3sC63xZ+qpum6lJzqDnQsVR0L6eTazsRt4HYCSgdRjqgRlrWAIwitC+fSqoy8DT5HcsnGD/fqL1MhKwu8nJMaH3wnxgaqsW83DKZZKvmTQ6CwYAj9G+7XwKHeu/y4N4tx+bfL2Y9FWCpHqwTpikAPditaFhU/UEtuld+DYC0kWlLtINk4IhdOrh80Th3eXYkPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6EOzR/dAT7xGS36MAb7FJ0H83BNPr5dOFOezSZrraI=;
 b=efjSHuNg0GmgXp/Nr+TlIQLDlnBGAfSpeDPb2f606ckav84IFDTv4Jr8xKTxCzM4iT9zbfJMRyRE2Od0W3Bs7T4Pd8m4p5yfLSMi6YCuhfi1M8HE0eyim/d4PyMUI06a2+5krHZ22XDtcumjrTJp/Q2tSRG7PPuxEkZg3bcW2WEQgKaomImIOTO2QliGsS+1RYDGL7cZdjXouD4SJ/rfhyknr5vUR1VeBkSA4B162nujnDF9fZePo84CdO/u6zjZ2S/NjY9P8xT6YihJApNr0dnbk03D1PcV0Yg7wq6r5tX4JSZAj7wbMggFWA9K9aA6B5TK/7ARxb6OXcWmG7xusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6EOzR/dAT7xGS36MAb7FJ0H83BNPr5dOFOezSZrraI=;
 b=hqild5JnM/wVkn3Hajr88Sui/EOs8wrocYg9G21xa6IU9Ae5/c5CwMtTWQ0mObmN86SKwuKhKsqozDYTZ8U7qR6fCS/QfJIMFFPLQWTjc3o5iQqvluEMnlo4jQFEJkXHw5F+m3Ht0YOOD6G8P8HmLGHqMWvMLwLW9zBv1HsgbxqtIlPjKrin8y8olqK2a+drQ3mtl9XjXhcQ7Vp6AIS3onHT9H+mZlAAPTRsVhwBH0zwkf3F5cEsxEoft29iViwzosvmnBjv0cLneEks/2btVxhVcy1gP4OMHiAK6GKbjjlze0jud07FqPIRp8e9X5dtwyU1T1wpnzWO8kyBXFGc1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] ata: sata_rcar: Remove unnecessary return value check
Date:   Mon, 10 Jul 2023 10:45:45 +0800
Message-Id: <20230710024550.59544-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710024550.59544-1-frank.li@vivo.com>
References: <20230710024550.59544-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 98048b6f-eb3a-416b-a994-08db80efd3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aWpXlMHkP5hw4EIiFAp6YaOIGKEmNj+SC1udFG/MYlPDgxDrTHsaWpDBrdEyL7BHASYf/PTJjwPUdDNplhcAXMCFVFhEaGAQXr+DNo+YnjU0yTtgcDwg+3W/MezkY2r0HqUX3g/RNu4DnZ+EsIakRpbDRBd2blXGDk8QcEffN+POUy97NJ3frPMgZ5ZkZ1axYyOR2yPm5Dl3SjW1r43wOgvShJuAEn5FRmQrpQIqyrEGfaumuqp/R5Kk44uj6h2jJRKpHqAfDAVhv2KD8eClbq0P9Yo+CB/TOOlrVpYt5p87LMS9QG43UL2P8PU3V6CR4Ro6W6Cq21VnsrOJQwKQ8LemmoZdPO4IGMk+5R9uQztlIL7t0RoLiJo1gcBU4/GX2jrObnFVEukUpW4sNad1KK2yEy5wK9A4rrOoUfFY21J8HZzPFqDC/dwUjvaQEVe2IpLmWA5295ID/SPHAvu/CjFa+NE12z1nn3s9nKh/onAku4lE/2EihjHXS/h9oMObXU/V4JD467agQg2titc7IsfTYKiImhpDC9pvgHsqLmq76JMID8jefUs756VvctQlnOxKwadEdmRTfvUkmZV4SYXe+mjlehNP3XN6kcMnYxb/orTFLgqPppvTxrxvvej
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y64ZIyi77PkLrjDP/tq5hjBKw2zGdOgjMOFlh2gQbzXVdtYzG2OUH4eQzsDE?=
 =?us-ascii?Q?XXEYm+wZNFkudjfxvbS3rht8f5+LN89H7Pbz2J2fcj73Fe7PtZKquROVS867?=
 =?us-ascii?Q?ADl4hjXrV++S0JSBSplXvLFPxglpBJ8jZqTGCUV+9elfPdXwU7gulSLI8PUG?=
 =?us-ascii?Q?nXLWo/1fQmsHrG7ub/vOWQ2zi6ilenRt5JMLAQ+vGi8twtUN8KW6ti6xGH8Z?=
 =?us-ascii?Q?ckfM2tl37wz80qRuMsEMx/JKqb6wi/EiBYHGnIO8fyQzREo86CXUFzEUsFGe?=
 =?us-ascii?Q?2FyU2E7GQeaF8BtYyo0XBBhIXTh/oER9h7YjeaXjuxrMl4o+VHfXqy3mqses?=
 =?us-ascii?Q?avvI+IkDEd4EZPcT7P5CagOBskJBczM+qtvI2CHs0+OfsxcHn18OFxl8DJmX?=
 =?us-ascii?Q?L7hYPAcwb4uI2y12slUF3TyLERonX6AKYO3pSp52+1AqmfYep52aeKRUo1/D?=
 =?us-ascii?Q?k1Q6vVLQEBjoRehi5py0nb5M/yLX7INQ4aVw6bLxOiSfGC4qDTx0x4v7kDv0?=
 =?us-ascii?Q?ofOn+kyraOVmKFb5Y2ACRlkc7VOosGSOMvUKrA1z+Gn9x5n4ZGaAZzE1rPYd?=
 =?us-ascii?Q?Tldm22MFbrf6nzH6icWTSB8TubUjQgNt6SxpnC63uLbS4EtwDdM+/3xIktJ8?=
 =?us-ascii?Q?9/yHryaDiBUStJmCrETofTEA+Wlxo4l00V6Xn4975RowThPT76oqMK6vDJmm?=
 =?us-ascii?Q?kSIZvHDl9LWU3Pci/dI25jqXnqQEqpr+cXyInESmGDS5/kaFXEVGRTCGCUmV?=
 =?us-ascii?Q?rijtCvY1zaYoT22wep7laASxWz2CPVqS2U4URaaFqAu4ao39eWDGMHpsh7+F?=
 =?us-ascii?Q?BoB0UC9pSqubF6kSZwMoy6Sg1Idlng8FhZX/QNH6sXxhfvQqAfvqH37UyU9Q?=
 =?us-ascii?Q?/qxbMMAPg+msuqOuMxefKziGs7J6P/zez/uvt4+Z+3fF4Mxrs/kVhMklV96G?=
 =?us-ascii?Q?Oxoc7pCqhLlxCqC6fkMnc4WF6oNMNW5jWItyYpeBSaskbn5I8MHLLJ67ODRu?=
 =?us-ascii?Q?4w5iH7gRSRTq5UazUVqoWr7RNWwwJDD+TacW/zuY4lUrtQt3IikBiNubAFqI?=
 =?us-ascii?Q?gcKvu4ZHUyJmloPoeTlOtRvrvLWuSTgd1wLWZW8IKk8oD6Kv8EzFDBs/XL4u?=
 =?us-ascii?Q?1OBVfpXcsrTDouA3CGZYpMC3n/PvkDfaz5jZ/87jjCykzm6eVr1Mi48xStiC?=
 =?us-ascii?Q?sJ+JcatAq9mgVDWv3BJyIZGZVgJRGAdwepUGxqH9+VqZIOjBLvlSRgGzZqTo?=
 =?us-ascii?Q?kPirWfti74wKeNqujfkV3aUUloppNhwD1x4zIIYiRuWqjvH6/yWUOBx8eI/S?=
 =?us-ascii?Q?W9hVCooyKPtkxEFiHUdCaVs300qjNf6Hu9Hzj6KvEv3iplsuvbtEEGSWVdX5?=
 =?us-ascii?Q?S3IF5ZZfGpyHZS/5MvlWOZYjWUb08iE3EZcW0fV3VCwoMFlp6zZC7CZaGNLA?=
 =?us-ascii?Q?Yw78X4dVL+zdnaLN4y51LDrXA9cvzcSbzi+n8FQRe1XpGy4+RLucL1BciCLU?=
 =?us-ascii?Q?fOe7K0rgwYBPuXdkmNOnAM8wNlCXRVSUJsKrZBtBNYnrEa9q022eq6Fs9Iep?=
 =?us-ascii?Q?KcZFI/wC1K8Oez1V3aSpMzDN8cDVtaJWuFcFYY37?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98048b6f-eb3a-416b-a994-08db80efd3b2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:14.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAMDPmDRT9tZt5EdSLUZq71I5vV2FFkWPRIYOP3g640nt2xgvDZOdGz/ClEN+OX6LMU9TssqVfjQ4XtC9ottYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit ce753ad1549c ("platform: finally disallow IRQ0 in
platform_get_irq() and its ilk") says, there is no need to
check if the platform_get_irq return value is 0. Let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/sata_rcar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index f299b41ab3e6..43c55ac89daa 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -867,8 +867,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-	if (!irq)
-		return -EINVAL;
 
 	priv = devm_kzalloc(dev, sizeof(struct sata_rcar_priv), GFP_KERNEL);
 	if (!priv)
-- 
2.39.0

