Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFE74C9F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGJCqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGJCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0326E7;
        Sun,  9 Jul 2023 19:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgsWQJypDk10DJf05oYMrNibsB3QmRpBWNQqaBHEkwjQISEmu8VSGXRUMtG1dTgNVSDiy34h0DddUQcLMM/CHE8ZVD07ODFGtrnEmGRy2ah0W0rNMDnWKdkA1XKbHGhdvmMiLZQdILxJJso1zInsiiU43JhF9TjakGtw8oqabXesCClufJ2qXQpBWP5UOuJc7pzZRGHiq7zquRTg7Pr18vD0lmINvMhnXyn7p88njMLGLE5UPObpsF0ZeR9UHMvUGxRSTYUoq+0jLmbz7B0h4zZ5NFIocqTAul6RsxgW3xApSvBqULSd/NRSxHvjpDf4710o2ouwEYCQ7jcg/Ucj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTBEk3ERPwGYe9e803WybvcvhM/4AUThNLDY/pAo4aw=;
 b=go6l9d3Z+W62Q6kNugsldN4sX1L3iysix+lT8jE1Iz7noy4/C/2Ut19f27tNJXV+omLdEDnVNPUaxfT59ZsFKtk4SYZBxvw6XRNvlnNEJWyv5NKhTUkjcn1rF8L0aKD4l9aG0z1zDB7wJ6qqCoY7lr7WI8jNJ3QVLD/rvTSZvRvz44IRs9HG1MOUv+Ucm4yzC/a9YZsF2WJs0noxWpDbmFSY+NCutgd34IdkMQAPxq8XzltndOHcliP1wtvyalTozPcn+fV2ImIvjaC6S9WPj/CXDNvaMr7osOM5xX8/1BW5oOEN7RvES1F5zetA2IRPSNZZQY00Il/RMGoJaw3Umw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTBEk3ERPwGYe9e803WybvcvhM/4AUThNLDY/pAo4aw=;
 b=TvvA0UayN8eH/INa5FgdtiB0wxodWsrMsIyv4LTCmk7ssQNY+JCLHq/B2VxKN/nz0W6+YL0el3UKj+WTfCOS2g3H2VsBENjnt8ipjS2FiDBnCPnT81j5csxya9B+Vs1AQHwqcxn+Td3qlJmkYEGzMGeQ47445YJ/OXjarDG/OEkEPSYhR8si/3OcMffW6riTiZinpCWRNjD21db6rc/JWgwqmlVbdnz6ibBTk3ZVwGis3oSNmCUQe51h7/HG7kBwwNRLlN2Xz+uNpfGKYi+/qNI5Uo2bnyfrnb2F6Lyl6CtdQatwf2zPUY5bE67Nyb0GRwcuaQNjM68ZBOyFMBambA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] ata: ahci_seattle: Convert to devm_platform_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:41 +0800
Message-Id: <20230710024550.59544-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 240e6b9a-8f2d-4685-ec17-08db80efce82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqIaNZwZEV0D8I3lDUK4aVFzE91vLDgXvdQqL26SLlegT0M0C5zXdQ/iXWczMJ/vw3e9sWKkjCx4SGIup6x/HRvEki/WjQfqmSoYk4MtKzculhV0DMUZiERdO4ySdj/JkEAHxQfVxhpaN0dVKObT311ewQACATXwuqsSFPQD2qX4B+FxSk/cmrAiasQbzqVHVX63u1FV7036FPbfFHRQ3Ml2n8FLvIGO/jaxLVCiSqkugwEv8h0gDCoF1i9I06sGrPRHod1CcMAgf3cjOj9QHRbpzsELyNXaJUAYbw3jTQ4Tc1EXIERb6XkP2Mf5tNw2XIlssgrDeObNNwFRyzha93SdBZFnsdEN/VBSOvGOq+Oq5lV+FtiG/w8HeuSjT/BzEhIScGv+kQcwFLLC0cb+dxeeTe/7Eh7c1iCd5kHZ/vChL22wi21fiWyAnM2Qzxa+ZnM/2l8rEjTi00U7baEVoWoC659AgM+2B5FXHGuyQHDoIZRHm9koEyNpLQcsAU2TotW1eicEKhckPXrCtZuPSOQ9dkZkpWFZv50re66x2TES9NpVTZSNTkXt5kA2XqltjivEMcMKM+82rsLPZoCRtlGkS5aIr23kKkhajm098ZWiDziIiN1SKsls9skC6A8F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(6916009)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D520Ox01Fub+qZCJKDYdWYrJDhQy/wCmuSqvljsuMZ/b/w194Y8zDp85VJdM?=
 =?us-ascii?Q?7NxbfQh5FK22ccP+KVyLmIfdhsffo6l33gHnALgqf1/GbMishJU1z698/xiv?=
 =?us-ascii?Q?iIvnZcCDZSY72FN/ak2z5+bh0xQjXOVhKmxC1le4tZDrjigdGV+zbk+VGE/1?=
 =?us-ascii?Q?rZu2GKSROxTK5tyBBaS6DIuhzb9ro1XLDIlfpBoimx7hAQN6vrLdrDT1sQ2q?=
 =?us-ascii?Q?XCJhxDlyBtPnJ4aBrhaS6R/vW7TCpH+CMOSKn3yPafhD442DmMDhk7zYDacA?=
 =?us-ascii?Q?SXACCTVy8ZlZ3iFwa0zjDHnbnDqKSRFCF1eghHcyYFk6oTJdm/+ftTaVckRc?=
 =?us-ascii?Q?I+RzTDzt96uSSH4HlLA6XkrqRxlade/G5TEVlAaIPQTZgP6C2a7id7WyOcFx?=
 =?us-ascii?Q?pFIWf6h0WnxjITsO+c2jJMi5F5MmwJNDR31lezc9g02iTlWgdVAuVCLsdf+2?=
 =?us-ascii?Q?Ts5d85EPOmlOknjMBPMSC7HENbyqt4K7ujB+5Zq9d0Qr1A48yt7B+yQCagzf?=
 =?us-ascii?Q?YccfNFFs8iRVxQisLiTYKUzJ3PUYtdv4u+GsAIpEn0N24AkkXxF3/+VXFPLr?=
 =?us-ascii?Q?wpCZ16Xrf06rlPwGRlDrfiRYZXsrvdYO6Xvq27JI7KvPu0uFDaliZ1/0K8YV?=
 =?us-ascii?Q?JrvZjaVTUxUrDcTia5LxAb13VWQiFxifnRMA/Wa5yJog5ZbNI/BB29o+MBtL?=
 =?us-ascii?Q?k8hXp0s6s8yV3XLly6VGBwpuivi2kaVco7IlXhtjAmDg+hby2PLvzvAcBh3E?=
 =?us-ascii?Q?4KdcTDbNJjBYjZX5i0V3H8ifYy8y85Tq4b+PrfCD8HdoXEgwgo/fXPZpoYIz?=
 =?us-ascii?Q?j3OtWFjWEbJIhBl112URi+6iqsFPQVKG3Ke9HmpXpBbaQb3iNWGJV6UuqyfD?=
 =?us-ascii?Q?Q0vV8YBRfhZIz/Tg/7QaDmARrJXwtovrgbZxPqGqTD2DcNQoj2Yvu9O1Xpvl?=
 =?us-ascii?Q?SvBmL8BEBdc7kVmCOtPK56XNeIj6jMCDgLGLN9ps3YGe1fQULCXb3FWwtdlL?=
 =?us-ascii?Q?ccSzri4eezQ/2W4zcHrC94r5478LNkYpHryiGMO5IhfD1K81xnmeAK++SBvX?=
 =?us-ascii?Q?QhcsqlNc/r3tRe6UJRQNmsNbp7rNFVuruWYzzN/uatrff86TUosV1X9zgw4g?=
 =?us-ascii?Q?wts805t/8xyS+cQNtQY+D+dm9NIoeiI5F0Wr+a5Ab8zgU+fSxcDJDvUlYRk1?=
 =?us-ascii?Q?lW/iNGCrCmSl6jjs8AuQ7vs49CtUzgMV0SizML78VXx6laB7Gxl7CTQRhl0i?=
 =?us-ascii?Q?xsKCpt1xIgPO0FZYXIVeJ+rq3Td2WTZXijwQXUCAoL+z/UO0Kcq8E3m6rn0e?=
 =?us-ascii?Q?qxGug8FP4MG96HLo1BJXaVjNcKXYLGiKQbOYqEsYSea1Xj5HaEH2T2/eA/Zr?=
 =?us-ascii?Q?EHsLJ9LZU57Aczx5vRcE7z6+Eq17f5DYPMhvRaZsoxoZW0DahVs1GuALZq0k?=
 =?us-ascii?Q?5Pk9TouuNzv42EAduzPpWlBR43zxbXPJwfzmh6j/+31Ma1eFVAQcPU3HrYh1?=
 =?us-ascii?Q?4XLg9kpbkCFEqn0+p6//INDJmiVWOyi+WwYJ6DhOjYrBWP2KcR7zJYYUF72I?=
 =?us-ascii?Q?bspG9wv3zkXMtVE1fRWmZo9SNppeSdOZYsTSNieK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240e6b9a-8f2d-4685-ec17-08db80efce82
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:05.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jumKq4Z1y9OwdpUOGHfIegofBrPUK484Buz6u94ia5f+y8Tn0+Imh5vEyVP+Hl3r93wv262UDbLrueebQvUovg==
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

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_seattle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 2c32d58c6ae7..a64c9c4704cd 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -132,8 +132,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
 	if (!plat_data)
 		return &ahci_port_info;
 
-	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 1));
+	plat_data->sgpio_ctrl = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(plat_data->sgpio_ctrl))
 		return &ahci_port_info;
 
-- 
2.39.0

