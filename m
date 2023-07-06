Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F174991F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjGFKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjGFKLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF411FC2;
        Thu,  6 Jul 2023 03:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAuFxNqPFT+/OnQObBvdr8JPgchCDUP6E+eMGS4YnYnRftpvkrizuaAS9B2ykxeBSgZD8KXgavj91Lr5G8ljaAb4+3/0MrMJwZUNKenw+ZlCkOD2/fy5r146Z9ZiQ/r0oMk6MMbVXw8S8PoE87nqelt49sm9objygFsQOYzkti1vwfe++RrZJ5PJGmqJ+XgWrsN5nE8FDcPJ6+xpSUvwzSX7ouXDamgPfrCkAn5i0ILUxlrtxdUSNVx5f1t4TX802DybmruK5hz4mIjx6SImaflgQt2FdVTQ1Jgl8nTm0eXMVKaBnVK7arsIvWaNT3PQoJpA19zO2R6ids3WlPzQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMGHCUSP9i/hQaL7wQucQmUgHp7qf+NEj02kOBer8ac=;
 b=DXrPCgCtY4oM+t7KdWl+Fv8WiH+/ZH1Q4VtzTuXGzM5i68EKtDyQyptAyVX6BdNe5uTBn3tfevpjgPBFYvS8sJrY/En0FlU61KJIo+TtKOgigz1dqqnR3n37n1o7wrrrkfHxte9L38bCDS1AS+KFXRIirGhq99Y9qhhEAcEiFGVvT8gBX+K3NMBEUATCkaeuvJ1o5TBRzg/pUF4xNHSki5kX0e+NvJHpEdnDlQ+5DR2f96zhbDPx8ofygM+ycietQ+SqmHSk+x2T6xhZTp7wKklQ7DgnbOITqICcSYtxUfEK3f3ewRAHFCctNNr470j5/C4+3DRvZ/gtD2ykepXZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMGHCUSP9i/hQaL7wQucQmUgHp7qf+NEj02kOBer8ac=;
 b=JdyCyO+r0+8B0oDzo3vuJxEDUE/jznIetUiHNaUZf+akf1T1g+NxMx7QxD74qQMakoi8gzK7svhmnKXN9eRlLHR3RrZpR8o30BhKI2aMD459lEhBhRfAn5vMKVcH9Z/k0vc/6cvaeyKPMp/PUMAzc+ez8A8FL4vqlFwoQ+nKLShMD9waquteRtd2iugMY9ce8hyuYqcrazz4xkvOBOStfknV0Z8+98X/RFQ1ticoqZJ2cPqIfpnP1J+tZnNSjaRisF0EItA2/aJ2u5Y01VnK43X3CF6+7rTa83jPFa3O6+f3+fJaFbpqy3g9LnAjnJ/8SdKhTRaD4jRBwJnq1G2mJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] media: stm32-dcmi: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:56 +0800
Message-Id: <20230706101100.75654-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 96eaa846-28e2-4534-8743-08db7e095a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uG2ORbFMWM53GWL+JKoTgvrzCU+ICOS8WkC+d7Up/AnwuvmOyhDkwhJ9rebiyv5zkh/JCrEGSUsedzRnaqz73bpgEUZVTwh92t8WJOUwZ6G3KmzidJoJcEOs6NT6Ab7kHarNggxxFhHcBi51y1B3m47e0Wkf6PLOWqFEWLWOCfOUONAnuUxmg423NeL48DQZK414IM/MuEPdc/5dHph2FFJZP3dk8YkRpEaC4bkVfE+VyN0UEy7s0ZV3uwaaisskEehXTqwaGbOS1iF8up/DRmHKe7Gs4rmbf6Gol7+lFV5d1UcptaAvP31ExkmK4bnGuUV8e5cKxHv5NGFZFz+1Y1FUnr+AwSpZIfSDxZAyzP9WSyipMT+8iR8+C4QbpPnA3XcZwpvtqeRgQNdAXTJ2fweXyE9h1jA7uR3anohs9FLWf42RARaAXLtZJSkPXhs3Jwx00zL2eqI1vkruqzbOsCd9yHkyXf+jdSJB3V7FDRhKTKtTuzA/bYgqeB0R4loxZmskrXYjWJC6iYH++eSvHxJ4X/l4gSNxS3nXiCnMjQc73+YocAgPjXcVxKg0SPosjyqUoxRBZuUgrIWSaidJGjeFF144b20Sp4BV0cS05V+wpmLq1l9rzrM0npZaCehS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(2906002)(86362001)(8936002)(66556008)(8676002)(2616005)(6512007)(6506007)(110136005)(478600001)(6486002)(1076003)(6666004)(52116002)(186003)(5660300002)(38100700002)(26005)(83380400001)(316002)(38350700002)(4326008)(66476007)(66946007)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aOC14+dvJZSKnzl9k3SOhZoc58DBoOX+jkvUF1c7KHZrMNzYY7RESW6obX1M?=
 =?us-ascii?Q?RiUHdh/WEB+0I023Is0NN0rDQPwoxg8Of987jX7TcYxhQZTvx9Z1TSqPcDAq?=
 =?us-ascii?Q?UKopG9Y45Ou3JxzTNJDCYSnZ4kmYgFyMrwbNK9gcxekM1OVCXADiq5FwmSKb?=
 =?us-ascii?Q?Jhk3lzfXseT7P4iLfGDW7wk5i2UIF3UiwH5hv0pi3s0D+q3cBdPjIX579tVs?=
 =?us-ascii?Q?r7FpexZOtOx76sEjB6Hw205MJC1Z9l+4dWbJYippvHgDfTqmoiSMZVK25egC?=
 =?us-ascii?Q?9qpgactMXC4Vd4U35oyHWxh6MgcDVHLU+yvCo/1NqoY82ANgzx05Qg5K8b0+?=
 =?us-ascii?Q?2AwdI7mq3tRG1zQ6jL+N1XQd9K2p9rENgNq5S3VgtX6Nkn2Kyi3mYoNq4BhS?=
 =?us-ascii?Q?HWrp9i8OE/uLFFFC7htgKs5S2IvEzzjhzrdZ/9BiEVKjH1wqZxC8uktokiqt?=
 =?us-ascii?Q?uPtdJ+eZUKmKtdnf3iTlo9S9Nyusjc4rfO/fIm2lzm/m5U53yQLebrBNFVje?=
 =?us-ascii?Q?0As7EID+UStVf2fQXaer+xCXxeBz+2BIhIQ9slMBaiYQzmUlAHgZqEHFYEJc?=
 =?us-ascii?Q?Oc0K5MZQyKFw+0uWy6FT/5xqbb7+ko15aDPJ5nskmMVnfwu2vrTImoLuMfD7?=
 =?us-ascii?Q?WCv8YCXZW7Qogh1jf/M4SLFfvUdiy1DVz9bzSfICVyHGPLW8/X6sCIpKM4iV?=
 =?us-ascii?Q?kXN/lH7DeImFisNdjOiWv/ojeYcufU0ulfUy1vtWmlcGKg3k0d89u7Jdai+6?=
 =?us-ascii?Q?ZcW8XDdjgwgjGN73CnaBT2+ESpS+TyTuO90+sL6LsMXCF6WPvunOK87TLCSr?=
 =?us-ascii?Q?EnEvFqTe4aEiZO33M5NPza2zAAZI7WFloBgwDcLYnQUbveZpmOHsaI4lgCEE?=
 =?us-ascii?Q?+DUlEh6sNwXR6wpSB8QAuDiHTAWAH7v0EdTixXV4em0ge0VQ3FrC8396y9zo?=
 =?us-ascii?Q?ySeFZtNjR2/pIbLXYBuvDropk43yUySW6H9mkP+dCLMoVrkBhgUlipU+A0QJ?=
 =?us-ascii?Q?b3IHDv9Z8z92n6uUml4r8M8gfr0T+sycHdq/isK5c4VKWL3P4j5bs7tw7+vF?=
 =?us-ascii?Q?MGfCvmxiEiOhuTIMvAHeTcrtzUQDdfViJ+jsRXz95JLuMebr7xHFrYLtWQ0g?=
 =?us-ascii?Q?Ab5oYaangMcw6ps7Q15vvcdW5fwUztjW7avHQdnvM/LYR2ZRTj02asbmhWV5?=
 =?us-ascii?Q?WinUA+a8kyv4xJj2wtxKGwy6CoSRGS4xRK0HdOqZHh+UDNWMtB33VIpZraxt?=
 =?us-ascii?Q?PzfEOoiTFxZfZG4zIIKDgy6jQRDKiTWuVl7/7EQhbYnUmrMkNmR8VKsV/vuX?=
 =?us-ascii?Q?67YI0DfwOSfjXBkQlrWb11OeFkn0uZqyXK590CMohTMvw8fJnrYTKGxVR6gZ?=
 =?us-ascii?Q?U3PyUtfL7F5GKtlddUWqeaPFb0ZkBqsMf1iF3zzwHOTJZQINMF3TQ3roG/RV?=
 =?us-ascii?Q?zf+A/PlIH4Oy+tye65DfF6uF8h6uYzrfct/UJwGzvu6llPu5YHsHUI+nY1jR?=
 =?us-ascii?Q?H8hqFdeJ8Ma6UNGPAvvF6PdLHmXVfY/dc52ipfgip8wOjliF4bFbdoASFCdX?=
 =?us-ascii?Q?JkJjTkfTLz7Q2QZYIcL0dIvQD3OZ89xBHuMaqWm9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96eaa846-28e2-4534-8743-08db7e095a66
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:24.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkzOzAH1R5ozcpIRBmpZKoM1rrlBOipntZvVzDunv3sbGmPRUUMKDq2aX21nckcxZ7vw/+WjdByhIJm1QF0m4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/st/stm32/stm32-dcmi.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index dad6e22e4ce4..b2e2af593291 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -1932,7 +1932,6 @@ static int dcmi_probe(struct platform_device *pdev)
 	struct dma_chan *chan;
 	struct dma_slave_caps caps;
 	struct clk *mclk;
-	int irq;
 	int ret = 0;
 
 	match = of_match_device(of_match_ptr(stm32_dcmi_of_match), &pdev->dev);
@@ -1981,19 +1980,11 @@ static int dcmi_probe(struct platform_device *pdev)
 	dcmi->bus.data_shift = ep.bus.parallel.data_shift;
 	dcmi->bus_type = ep.bus_type;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return irq ? irq : -ENXIO;
+	dcmi->irq = platform_get_irq(pdev, 0);
+	if (dcmi->irq < 0)
+		return dcmi->irq;
 
-	dcmi->irq = irq;
-
-	dcmi->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!dcmi->res) {
-		dev_err(&pdev->dev, "Could not get resource\n");
-		return -ENODEV;
-	}
-
-	dcmi->regs = devm_ioremap_resource(&pdev->dev, dcmi->res);
+	dcmi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &dcmi->res);
 	if (IS_ERR(dcmi->regs))
 		return PTR_ERR(dcmi->regs);
 
-- 
2.39.0

