Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3EA6D15C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCaDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaDBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:01:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199231204D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ussl+yC6BbQe7qMpzfMdEExlx3+uuhq2Mi8YjzFeROa/DfGhZiLVpFc/hGzs38/NHftRe98qfbIgZVSQoXeoIIQH+07M8g3pFNrPf4T57LCoOXXAkbLeR4oGFABlejnc3bd550BHLY81SLW6gkFdIJMS9lVWr9zJeeKFjgPUJ/m0sV9DxbvNi031Z2UjvYokyYfg65BFyIIHvwF6d2Wl6dZInBP7W12/oPwxFtpImH68gLar6zlETpsYg2wsVwWu57XSWFPN7nDZaF+eYzmP8CPMCuKaNcvIMg15I0h6eLRJyYGg4V8nNEoQSSLv8DyAogMWQ1ht3gMcEKXYy4ecWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzo5V7TmG5uVONj8ZEcDhDKjIl/nCCPTHODWovRywKg=;
 b=H3SKPzaVebxqha8hToQNd+Ji4RP7YLJ3vgHmkzURbQHkstTNbCsyRKOCYW7i5/AuStWRejuV8mg+19B9nNTWwPtVTi3skdtQXh3eAfMZLKukfLiqHZnHOWh6kVrNhQ4Hq7ZdpWmZyZaA4efH/OtftBwc51Wd9xVbnN8MuZs7GXEIUPqQ1bPdtR578QEaj8icfVo70BhtHFkAXyEDuO2C7j6ag+HcB60oQNhepr+cr8Rk20l37p4at7v66oMHlxxwUtkR9OTQL8nZG/5rNbIqfTdzTxcdWqDi3OjKmkSAXlhreaz2qZEExVy408Je+IwNOK7o9/2QawVVSCo9oahDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzo5V7TmG5uVONj8ZEcDhDKjIl/nCCPTHODWovRywKg=;
 b=i7vZiZ0bXLcrarsX3WjXFnQ3LJcRn3heDN0eXIAzp5ji1OapjAO8ktxsuxkrLSo4sGcYIN3D5+FUvH38MPa2k4IuzJ+drMZ/pYCj0CKOFnhvqbLOXminYnK3EumHdDzbUy8n4V5ipP1JHKmo1N18RtCccOkZU7eT9sr7UdGGyMvTMC6YNo+tEOicyosAv/oAr48x5VflTH6nknI08vPTbV0lPEFBEkj7ljoe334zFI44tFbedaZMKUqt0RLoXEVS6SAceS+xJnKmwdRvl1zuqM9AnVTJXagboaj3Z4ZSz61zqvKrlzjfHPIIjSl17FulweXzb0QVS2k60CzFRw3YeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5024.apcprd06.prod.outlook.com (2603:1096:101:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Fri, 31 Mar
 2023 03:01:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6222.033; Fri, 31 Mar 2023
 03:01:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ban Tao <fengzheng923@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sunxi: handle reset_control_deassert() error
Date:   Fri, 31 Mar 2023 11:01:16 +0800
Message-Id: <20230331030116.54136-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 134b0caf-c4ea-446a-fe07-08db31943cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09yhGg5BWSREIVGcq1H+eiTBKRq+eK9uGy0t7J385ZR7cBJx991vGopaAIPC14pqliGq5kLqYblDOKb24l97+9GkhNxhno0DfZ6spZq0+nEetzYZHYpQ7yQw67bDZ0AK97tRdnCmsAEMqgatsUVCg04o5TDEVjwZAc+int11DCYbNzD7Yk47tNJVc4WfeSUo/Qq3uzgZkIDERZhL9herOg2aGlLdmu2sr08pWOrOZ5WbT7ET+19WdK0yvA/Pxa4lQMVOU/zJ+N6RVU6AfHkM7b2cLAnFkwViL4c/XeYi0knCw5vXyKXpysVThOiBhcr+kODE8fZPhapkV5XVKkAFFnOHrVzvm3If7bBBGP/7M0eGPrgV1ju8yn60O6gvmF0E/BSbo/hl2Nea1OwKMJ5ZmFDiwY46O5z7nNFEFlT6bdK+6I+nqdUbEgowAZY7ImeqvoLibDMDOgmcxvAzsPIyifpMo2O9cYkZOZiR1aZWWf403molY8wD63URlEOHzj3N5O01p210Ce7hwtBDr2g+1Qjo4q+prxvpkVVN6ZoEYdjpNmmUDvjLCHZ/hEw7OM1sn/zEGJWlQXtK4GKxTNo1HJcIXgnlNX2srTodxMFsBlwWX37sAUHsRkanZyAtuy0/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(6512007)(26005)(41300700001)(6506007)(1076003)(186003)(6666004)(6486002)(52116002)(83380400001)(2616005)(478600001)(316002)(110136005)(38350700002)(38100700002)(66476007)(4326008)(66556008)(7416002)(66946007)(4744005)(5660300002)(2906002)(8676002)(86362001)(36756003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79/eNeFLuRpAXRHbv2xUixe+2+qub3x+ml3uuAyZuxmXNPMKUId+FhvfnWyc?=
 =?us-ascii?Q?Xv1sBaaxYxzSYFOb7M+A/feTKOA9F6p0tsYtHEvQYu0Ur1iQtH58jOaAFfCY?=
 =?us-ascii?Q?IX/6/d7DTnCrrYx8/ziaPFPnEmcR2oC/sEQ1dYRCNU8X1EpCxSDy9zoysV8s?=
 =?us-ascii?Q?rgYTBkvUll9z36nJ/ghP+erfPZjN1ML+J/r7vC2PaQUPxx3BiP9LIh8S/hPG?=
 =?us-ascii?Q?WGgFR2Xq2kXjZQD8E9qr4uOP4cz6Zy9glM8bvDKWR6U5xd6TIV/dip5ZUuUL?=
 =?us-ascii?Q?rvB0G4gB18ND3KbT7oqExuZIzyXEds7mKjs0BnSYbelWJP+n2jSrrmW6K51v?=
 =?us-ascii?Q?zqBEaXqW//YBn0LKng2HgCofklw5BPGkd4W66A5uhe2Yo3NYibzsl0dJzLHa?=
 =?us-ascii?Q?NrgNKtWaqpOl/o37aKdEROYhMqBFb4VSraxW2A784/w8gMpwrav+9vy0WYxH?=
 =?us-ascii?Q?Ag0ogsmI6/y7WRlqwgjx/WMeAnH1fRqdlWDSgI1t/ymRPXUf3sCPb5ofEkvR?=
 =?us-ascii?Q?7YtdZH0HBpGteF5gwjeUpA21H1lwdPDxz9Ph71Z4maVJJBBdYmmSBjboqOAD?=
 =?us-ascii?Q?2ft9qdYx29ikpdoUDXXXBIibJ00uRLQKZD8hPn1um+L+94Yywg3MDWmAS81U?=
 =?us-ascii?Q?NgY+WyFvAbbpG5lg87+ZReEHvnLEtsjm0kab+bm+9x25S7+JMzGxI4u7jmsJ?=
 =?us-ascii?Q?dBPiJ/ny1TBSkaHM7RMS9vl7lfvBPxwM2BouBW4S4Qi3aKhbLhzMW0QJ7M6y?=
 =?us-ascii?Q?X0PdjQwGk2xxGtM/hoPSYkKBDz+oxXPDluIWyRuAEzjKiQAGSqJbI6bDiSwv?=
 =?us-ascii?Q?3kUeTwZymEhaSHI/BQ7mmpEG0NgFekm9V9Ej3Eqi+2dbKVx8W4SZ6qVeYhTW?=
 =?us-ascii?Q?aEXlpiXY5qahpir63P0uF0cxPVFg2AofiBWA+fjSc+Elqs9HZOCLbB2VwYOk?=
 =?us-ascii?Q?5yN9GIl5MTO6JVDjWxcKICDySQjcbMPYDpmQ/LqXVT/nJHgy0itiInaUlmMy?=
 =?us-ascii?Q?kEen8UoKqa8BY+tTnmTFtIOnbFHDz3xishrRu0JDZwNfqWUfskUquSTEvA8W?=
 =?us-ascii?Q?Xkp2W/iyP3HJTrWMD2mfd8h4wyKF6Zno324pFHVSP1lOnaHr+U32fh2eLLqR?=
 =?us-ascii?Q?n7QchxCwTqI8PXUxR6oMdhyGe4Zz1qtFLcQcNfewX8qiisFoapnIdpp/wl+u?=
 =?us-ascii?Q?fPbqU19pcITvKrQTrigRyyy7qXd/XNvTYk8TKlwxN6UtZzyJQ6D9Fg+jWMeK?=
 =?us-ascii?Q?7jjnL9NYdpT7lBwVybgDfp9oe6o4/MtNpY86MwRQVGOe2EYG3ZqxEBEx+8Tj?=
 =?us-ascii?Q?9KoHHyIiydolUCrNtzscxQK8ZZ5DRmMvu4fhFzz5jEak+n+xTYnf6Z9dFfrF?=
 =?us-ascii?Q?3v3Wu0jJrEaR/9JI1WW+2nleKBvwl55r0uPXN5fTiwSBpqKn/TPUjn3UKAhX?=
 =?us-ascii?Q?kWpBTZN9qwKfP4Z3mzbwyoBLf3ZTZP7okeW9A3UCmddwrLBa149oy67eE58V?=
 =?us-ascii?Q?ha5entrrR2DKm2Jp7LyytrXKlc/ZcCTHWxu6rMDoEPmncqMuUHnAKyJhvJ+w?=
 =?us-ascii?Q?agkuAuCIO9Xf6gBar/3o6H2bDY2MlBoJlNZSD3Gm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134b0caf-c4ea-446a-fe07-08db31943cb9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 03:01:35.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bR4OZpt+3vFhMY95LLeMg1DY+AIY8X7x73gbhhWuEBz8pT5131IJdjuAF4ambU651rARLdJ6lgA5rqnzc8cMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5024
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error check for reset_control_deassert().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 sound/soc/sunxi/sun50i-dmic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
index 069c993acb31..7f0e63130d95 100644
--- a/sound/soc/sunxi/sun50i-dmic.c
+++ b/sound/soc/sunxi/sun50i-dmic.c
@@ -345,7 +345,11 @@ static int sun50i_dmic_probe(struct platform_device *pdev)
 	if (IS_ERR(host->rst))
 		return dev_err_probe(&pdev->dev, PTR_ERR(host->rst),
 				     "Failed to get reset.\n");
-	reset_control_deassert(host->rst);
+	ret = reset_control_deassert(host->rst);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert reset: %d\n", ret);
+		return ret;
+	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &sun50i_dmic_component,
 					      &sun50i_dmic_dai, 1);
-- 
2.35.1

