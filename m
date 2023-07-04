Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0726574729C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGDNUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjGDNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:20:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597AB1709;
        Tue,  4 Jul 2023 06:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+LhukpZxmCDWvZPO7pU0Vgq3AB3juJSbml+mEhIbbjmKfwUKBwOImmDJ0SllFhEKOBrGaQ5WWGJ8fu//8D/ZZYYgJ0dcah9PTHjuaCjHOLMNxjXbFLE49aXtK9ULYZGahqaKkdtpQ6UANM1PFNLi45+do3kttLtlsB1QCTFYCdUzyerms9h+H7x1WHjA4BCgonULAYVE7VgecbXY8XmMn7sAvSaMT/n3eqZJS9XQI+DP8iOK/fMZUDz2Goz6NFV2xce+IA2q6TzTD+K/ueMFLcrJZd02hOKqtGj7m8AqZjdhJQnK00b2kIBQpmPHE/9UzNKKyxyJZDxdpYYzV12AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g1XTdEPp8mJ3bo4su4CztmxAG7yPIlNxcVzXixs/70=;
 b=byKiCty5EDvtBbBA+zfHWQqVJaJJr03OaTderNbFTDO/Bv3iO+7y34jx0zPInnhnNezc7guqpqyQA8tHAmovKeGnmP8uZ6BhIQTwKErLtlA9aBHPhceP71lxlcqI1l9Cb4OZxZvZpzuJjniFm2Rs6Uepezn0F6/Qq8ODSFO9sHantGVHv9PLfTwvZzwXhIJyOaNGpNBORKJLqL9dyr3zOeQjw+3ukFDtl2A/nBr0KE6jmQOBwk4wXsfqt+ev9mDTvfvhHne7Va2yz7nMLMRT2U/w+fvyQydfopHxgWdP6ZWAngIcybdNl6jp7/C/uLgqWH0xWcsGHN4ubdkmLp02Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g1XTdEPp8mJ3bo4su4CztmxAG7yPIlNxcVzXixs/70=;
 b=gpSNA/hrW3W/KalRtl//hNL6fPj4EseW2r87hD1fwrr169MRppob9vkcSXkNiFeuUDrdIsBylnfiJ+Bdqs8j58oGdYxRvGvVk6ReHE7pWTQI1v4fAYKH30cgFaK8Tix15GHFGGPUbM7xfa12SIxP9/XMHY+hC3o2STcskL/f5RNC3hWpYvymHbzf6/uFH9gfqeSoHn7u6VP3EPxdacTSVf0pGwlmo4f1B6PuAWirmU+JWIDY9oJOLhNJer2ZJnU/fsc2/e93t1rkLh4CQQNzq2cKYe0Z3zSoJFhBG1KA84Q5GoU7aSOz7KqB9ci1Oocg3+6X8kwI0CjLmnPwmU20pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:19:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:19:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: pxamci: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:19:38 +0800
Message-Id: <20230704131939.22562-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704131939.22562-1-frank.li@vivo.com>
References: <20230704131939.22562-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5179c578-b05e-4f11-dc36-08db7c9158e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNzQ1HiPS+G44fokEb0eJ88UcGo4wk7LSMyiouzg3w89qy0ysXoi4Lfy8VpgqbG/j/yqZ9L1M9/anuqEk83QdO4yPGmfIZN/Wf1SDXFnDtaUrOzIpslaH3wh067ow2SRp+sRvgT0ns/K//cph6qWAOcvCijzDXjtdO2aOBFXrILprJi4sAZ2D8fUa03zMx/ZeeCOrYfywhWuDE9Nt8+3+Fg3D0z+xsUGBPUeRyUboKymvczRQlo+uAlwFN+6SmRC6JgOvzAKiemgJQByzktP8gsdLr28r/0jdM6BPQeiY43c4PHd2WmsrjNpL8J4wW3GVSEqZlLHLbuoVW572GKIGapm57HcjQK1BIuXEVu7nhRwU3LfhFcCXfHuQPj78LurQ52dIMpbaQjmqrmtDQEyJSYRjcJ5ZpkIrghT3WwUhFUsaTvidzyEdIc/LFOUYxydFl49le4OGN37jOm8KBqwHDfG1lXcJbl6W3tkoloDlxU9ImvpRCSSK9fDcKMpCCL4brfBIcskBbKZvwRxQsfSrutLxPeqtJ0e9QtaDMM1bMF5b4FxiMcMeiUgjmxOd3/XU1gve3ivaXY/rinvWqrBFHFbVys6zMO/Y0v18nOx90j1RbJ4/Eev4qaXdpM09TCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39850400004)(451199021)(2906002)(478600001)(26005)(41300700001)(6666004)(6486002)(86362001)(36756003)(52116002)(8936002)(8676002)(5660300002)(316002)(6512007)(66556008)(66476007)(66946007)(4326008)(38100700002)(6916009)(38350700002)(6506007)(1076003)(2616005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aD9MouYGws4I/NU++iPbmUSqEMiO/Bu6shfvNYEblslMgMFWUX6HU8Qcqen3?=
 =?us-ascii?Q?E1lno8HNzdYCVaUWoo29SEGgHImR2nYEpnvxpcXHho/mVyouqgM1mavBYFg0?=
 =?us-ascii?Q?eEvyH/q4filv/PwLQXfBIW6BBuIFstv4TcJsFmLtqULL97vS3GyyZBqyL3rn?=
 =?us-ascii?Q?baOpA2u9iDGobO0K3W1zp9z6aihguwtkAGqQSmpUUi2kwZuqfAx33OiQ86/e?=
 =?us-ascii?Q?Db2PORyRnQcWQJ1Fkl6tVZYPSDln+FVVosxIrd8pakZXTVtddMc64W35pH8+?=
 =?us-ascii?Q?cnpufP+cCVSZ9EW+g+gmwZJgOMLN42sd/ZlmQmsDTGGoR36mlTGTYoPv47hG?=
 =?us-ascii?Q?mpeTxoNnYtrpTIWb+aU2QP4V7VPabQZcvF7s9aK4Xvey9/UobKOYCEakQRIl?=
 =?us-ascii?Q?FvHO6r31nkuiQKIhv60Q5+60wP4gNzaEbpGbeX4IGJw78qxjKF3cbSPWnr5P?=
 =?us-ascii?Q?tywUhSXmBwhrLM7Fw8MEXPB8Be2Q2RD6enS2jSKG4X4wgWUxQYsy/e5H34zT?=
 =?us-ascii?Q?uca0v8ifW6EcnT1DXOSVqryYQxlTAwkh2Kh0awB4vgt1xPLNJoyR7D/sN1k5?=
 =?us-ascii?Q?8wGQUwVQcRckRRxF4ECwIez6ZMDya3RKvZ/C9vIcOgB1JUw1HkzH04eN9nyb?=
 =?us-ascii?Q?ERGrsjYVmJX8pos2n6sHKhDvJRqG6/AkgEB8o96Nzo855PxEge5V08k9qhwG?=
 =?us-ascii?Q?SfWlkjXk3ZcRl9WYtTNEhOetgjFX7Y7lt96q84DBXNuOTR7vulltjvsJDlqn?=
 =?us-ascii?Q?NL1GmUi6QzdjxG62w7rzbPHxUsc4AkVyl0NAB/jDErLryHZHCvWbHQ8xGKHf?=
 =?us-ascii?Q?ZH+zUxKtF6IQf5QA2LPZwla5d7sZ0RL8UCZl5mDorF/rexFf+3Zg/LDc8QgV?=
 =?us-ascii?Q?FVfar+zJQjtLm3mPIM9T7ffQdKIz3YEybIVYyDF8OxKVzhHrzBHvRQziMnRk?=
 =?us-ascii?Q?A3ZbyMf9HN9o7VEcpli3NiQw2JW7JWQkiNP21/DivALYfzoDHC7iYiWF9vcK?=
 =?us-ascii?Q?t5eXjK4B35J05ZPbnOcEGOMWbH6bI1Sw4KIhx05SzIDi0zu4EfJNaTxAZWsm?=
 =?us-ascii?Q?3UHnkHfg7Qg0Vy+SvbJwXlTW7mUJO9f5/u6naZcRiwocPW12gCo+H/ucUlHe?=
 =?us-ascii?Q?7I4ArofXeDTXO/a3RLsEhANtyEXT5CKmHE3MaaWpnnBYFdlr6/74ob/JNCTZ?=
 =?us-ascii?Q?1Lf5ka90VZLn8GMng6CSLdtJ2ioqJ2bDhm3r8mfseNow8XiuSp22EwYS56c5?=
 =?us-ascii?Q?JR+q/1s7Bchw4MQOjCIAwOPNPhqDYrkEBvvkRXvdTNzk4jqluWi6mgOi6Zjo?=
 =?us-ascii?Q?LY37yCKgu+e8R0+guAcLcOpkdhGljBtGNCLBaGGliFPO6XaATRaqpSFhiDL0?=
 =?us-ascii?Q?kdDNtfqvDL5g6W3GBTUshjpPuCMvW1eRzTKDuLM8aM0f05ZAR++9FLx2wh5h?=
 =?us-ascii?Q?i3+m6o/dxhP/widoBULV5Ptu9o9mojVIPTBaC4boGg6r0x0m6ODfymORZrJz?=
 =?us-ascii?Q?K4zvCDwi6TmEoIpacVXoQhGoPX64taloF1VvJ/nt0gLwGSGz/FPvv8LkAthy?=
 =?us-ascii?Q?ZpUnaG9sIbWmY/IvJVBQwEPhFFuQFhnNkHQrmgDM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5179c578-b05e-4f11-dc36-08db7c9158e3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:19:50.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+QNLUe+0NR3V+cwoZ5eHx83y1vVqfFnMebHJPF++iSd+jvhd3Gqj/wKOC4KGcsFZwK6H4F77jg7Srx8y6X0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/mmc/host/pxamci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 2a988f942b6c..1142cd2368f6 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -612,7 +612,6 @@ static int pxamci_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret, irq;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -685,14 +684,14 @@ static int pxamci_probe(struct platform_device *pdev)
 	}
 
 	spin_lock_init(&host->lock);
-	host->res = r;
 	host->imask = MMC_I_MASK_ALL;
 
-	host->base = devm_ioremap_resource(dev, r);
+	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(host->base)) {
 		ret = PTR_ERR(host->base);
 		goto out;
 	}
+	host->res = r;
 
 	/*
 	 * Ensure that the host controller is shut down, and setup
-- 
2.39.0

