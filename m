Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5127500EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGLIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjGLINx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:13:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A51981;
        Wed, 12 Jul 2023 01:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMq9JekGXvDoSmVOx56UkbGy8wx/W+le4mSAHkt+6VB4eNmLi/HITFaDGTzAk6G88U6aKz77BKAohZECbdJG0v6tQgvjEFvnk9cyavvxTdk/e3R/DN/69Cv3TFO9DMw4JE+1NCKTcL8KcJoP6XZH6hIxcM80Pm88asOInIHkmAHnGsbGp+2Yw0OUsv1zq6wFP3g0oEJAF5PJOBEG5v2wVmolAv7EY1Gj3xHUPZxOlFp2lq/tZt+skOtocjpGh1Octbhp9RNneT5n742A5iFVXhU7bkVrO2zyogw2cOFiISoGg+gr0HvjAAecG8vwc6afjvEfs/uQy4G7tWTmbfp70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpZMshgUnhl1a1NRIEAw9FoWwWlGONyeujolIieNF5s=;
 b=fKxN9NncDeyHewf2r4+VcvnlMqjNA12/wNPqZnnuhy24G8JBpql6SP/O0GCwsZ0I1cwXMiB0/fsWEKj5s03RVSJL7tbVqojmdgeUbBAIMh/Dr78LNMlzQvJ7HXjRLQ9J5nxZR5GhZ5h285mzCSVyNMToJukFI2BvvnjDzktFiZNU1VN6rZoRt6iUfyQ3AFXt50aI4FP71/bQO1YfoG9K7jahWbtkbZtKWQrjKsIWDt+2Cazl3/F4b+siVtQ68TisbxIiYihMHmyff7b7f7+F/LTl6TXoNTc3oyjdW1JJ+WzLA6irHsgIQi/S5/3GJZpkQaA2qwNAUGrSCuqbxhJ0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpZMshgUnhl1a1NRIEAw9FoWwWlGONyeujolIieNF5s=;
 b=YouXT0nfwyIPN63x5wCih/7tP/H+0Rt1DDqER1dX/Th8eZAtxwJbm6N528VhnmTEFC/6EipCRWBT08/6LIdnljzK+Q30LfSFzwX8PI7ugnPD6PhVNYwOuhs1DE7BK7uNU3wMZC4NFMNOo4uFafR6MJcNFmx3HouEuwmYxMNUjvA2lVPrO7vX8N4+t1OjEa+ouCOJPFIeQUe7YieAhK6KWcze8mvpCf5XZ8JW/Y2XgJO5Y6sR+i1CDgwQ98lMdoPoAO3vQt5as5nif/GS3Oml1D6067PFNLASvRaginj5DCb5YxWGPsqJKlnGr5iiSdbQa2ld0YgKE3kJ8CysL9tjJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 08:13:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:13:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/27] thermal/drivers/armada: Convert to platform remove callback returning void
Date:   Wed, 12 Jul 2023 16:12:33 +0800
Message-Id: <20230712081258.29254-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712081258.29254-1-frank.li@vivo.com>
References: <20230712081258.29254-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 061e9397-d4c6-4c5a-7eff-08db82afeaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TU+mu0z4wCrDRKxcHWfmczo0DABagI5/nANMCyAGUVlTBVuWIXSdYFpakU957C1Utx8RGVbBaIXp/im2yo5xr/ukKY4YavW/n0qXOcxxQpRKIEvWBaR/5Nl8AWbYJHDUgjv5zCXfvaSVxPEpCIutTyDpZ3WfoahLu/Yg2cIbreOiid65NkpxZadoxdBZKmnyfJM/AIDmUOos1+iGSV4GHoq569umcezpVbcooBvic49BtmHXvU9eQiB+w27nIoVGcJVyQWjkuhksWLp7bCv/OZTYYw8zQUdN/DDOtS/VhcwKbLq9rdYB7AJMgIZO3dp8QUTLdtetIexSySMJslVxYftwz/yWmQLFYROaEZea+9wSttrHS688LYJUZdObhLgRNzlIRqrxHhSVKjf00WvyTPFAvosy9tCXqso5L5qAExeqObP3nuAwpS5D2WG0eIK9pVu8Ps89LDILggtKcXStwO/VMb6Cuid4T+pocfZGepYjy02mG8AziJmykLGNjSaZ0R7Ke3P4NeHNcR9B6eIpbepb/jGR1tUZ3A/Naz0nbmd8z6GIry2ZBTOXEWIm8lQLBl9JXeI4MmR+gtFQh/ph0eJUEf/lC2voIMjt4Jl8X9aLPU/cJeGdmUrolCcneUny
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(6666004)(52116002)(6486002)(478600001)(54906003)(110136005)(6506007)(1076003)(26005)(186003)(6512007)(2906002)(66946007)(41300700001)(66476007)(316002)(8936002)(66556008)(4326008)(5660300002)(38100700002)(38350700002)(8676002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cit3SGZSWmNFR0tsQjJDdmcyZDRnb0luQ2piQnZvb2xuTlN1QWlRQjRKR1g3?=
 =?utf-8?B?dTBPTFZKVUxCSXZiZFlySVFGSTVGd0ExVUhOd25TQTBycXRKS3BrZHZHQWRQ?=
 =?utf-8?B?TDRubjJERjVuU3NvQktGZG1ZMHdzZ0VWTkpuVytvbTdKOXRmLzZyTU1OQ3Zn?=
 =?utf-8?B?cWhIWVlhOFI1QVk2TEQzb05rUWFpaXhxTVo1VW5JSVR4a1FNeXY0TkJqTnpi?=
 =?utf-8?B?Z1dyOUVyT0l5VjFSY2x1cmJQNTlqNGM3UVNuZ2VxdkQxYjlRTTFYMjhJSmxW?=
 =?utf-8?B?Q29vTWRZQ1ZqNEEyaWp2UXUvWmQ2cDJ6S0VidTZ4NTlaL0JlQWowQU1HSUlw?=
 =?utf-8?B?Z3JFTVdLN3ZkTWl0NmpSTDlDOUVsNlI2c1JhNXZTL3E2cStTUm5pTDZsRVlQ?=
 =?utf-8?B?ZWo1ZmVIS3BFazJIem9NeExacEt5d283VEYzV3hHR25XdmlYUGdqNzBwQ201?=
 =?utf-8?B?b255a0xDa2xtM2xJS01XSjdKOW9kQ092N2M2VFhnbHdUUm40bXR1NGRDT0Rv?=
 =?utf-8?B?eDBmOG9MdUNrZVlLQ25aVUxWMy9QWnpPaG1PYloweWxMV2VCNjMzd0p3L2ky?=
 =?utf-8?B?L1dZZGhWeFEwU0lTamFybXV6RnJ3VjRSOWpGQ1Q5cktTUGZ0dTdoK2hZWE9C?=
 =?utf-8?B?QlRIamZwdW40RVlpSHdtQWEzZHpVNDNZZDFOKzhoYk5aVlYybXcwVHR2REtW?=
 =?utf-8?B?ZFIyZ1BTbmNiYjdKUDNFRzBtcWdQd1A1aGJseTBpOE5qdjlVMWc1OTNlWmF0?=
 =?utf-8?B?QkI2c3JWZmNhMzFCQ0pwdW9oQTErUUlnM1NYaVcrYlFzdy8xNzQwVG9LdnQ4?=
 =?utf-8?B?QTVLM2pPNzQ0NW01LzRyWGVYWVgxaGpwNlIwbFFYeFRYOXV6ZEtoOUJJYTN1?=
 =?utf-8?B?aitKbGZDbHpKMUNhV3RZRWVpdDROajFmb2JhRWJKSWNXUHAxalNBTzFOaTln?=
 =?utf-8?B?K2M3YXc2OE9UVDF3MGhrRzRXdE5aMDJtT3cwSm9mZFhGWUp0QjdTVzZzekZn?=
 =?utf-8?B?aEpzeHo4M0JucDJQK2p4aUtyK0tSSGJ5SStydDdkN2Q2QmdHZEp0cGFwQlg1?=
 =?utf-8?B?L0U4S2prUWtHYm9LTW10TTM1VUVnMUVHbWhmR3RYcU0wbVVvemtUUHhNV0JE?=
 =?utf-8?B?Ym1kMXBRNnhvNncrdExmakVaTnpyQ3BtY3lzZXREc2FEVGRTdTc4NS9rV3My?=
 =?utf-8?B?ZGc4ZzUrZ0xmQjZCWXlhcWl3THlqTXN0bE8xYkFjOU5mc243QklOK2dQTG5K?=
 =?utf-8?B?eTNuZStNRDhEYUdPSysrWmVqbEE4MVRONnE5SnNwMzRiK1NySEc4ck4xVzFo?=
 =?utf-8?B?bmV1dDNZNHpVRG9rNUtkZnJmWS9IREV0UXRvd1E4RDBrTFB3QnprbU1iUW5G?=
 =?utf-8?B?aHhVMUE4Qm1ZTy9KQW1pUE9DaWdHOGtibUNUcitxR2NjekQ4S3I1NDl6Y1FB?=
 =?utf-8?B?am1nVHRuQllObVZMRHVvOCsyUmZhNTRDSEwxdDJsU2hDZml4WlFCWmFSdDVS?=
 =?utf-8?B?UjFEQVc2czAzcktubVc1a21XVFhBV25HNEFGblE2ck9PWVhSVkpDcysvdVBP?=
 =?utf-8?B?aElvZ3ZMbGs5eEZyQVBCQktKa2tEN3U0OTFZR1BoejQ0djlLWnRlaHNqMEI4?=
 =?utf-8?B?YTV4TENJM3lwS0JkdnA2WkdmT29veFBtZm9HTXhOOHRKblhzTjNjbTM1UUFH?=
 =?utf-8?B?R3lxMlpyZ0JQbTFsWE9HLzRIczFLdTNCSXpma0pnZTF1T29xUnR6d1p2bmc0?=
 =?utf-8?B?QkRXUjNOUzdJZnZ3cGhJcHVpNlZmK1hPN0FlcnFPeXpjOTl6b3dCZzhla2Ni?=
 =?utf-8?B?VUZpSUdnVlRLaW1NM2UxUG9hNm45UDBRcWY1c0liYXRVME5wQ09ZOUwwSTdz?=
 =?utf-8?B?Y3hNOWp3QmJ1bkR1dHlDbkNscVZvOExpMWFpL2pYOGJvRE9JckpxTENySEda?=
 =?utf-8?B?b0pqdDZkMEFZQmtRc1k3U083eUJLMjJ0Q1d4eC9rUDRwU0k3RlBYakczRFFh?=
 =?utf-8?B?SnpDaVBZalpKTVBxcEhuZHBpWnNGaCtDNHk3TW11WXpkQzhnUE1NZi83WWtS?=
 =?utf-8?B?K24wQVFYRFJDUkcraXdVQTM2UnRMM0dOaDRHUVlHY1RGRTgxYVJ3S25YaHdC?=
 =?utf-8?Q?0QLrvC1gIrX2H4yY3o9GqRBv/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061e9397-d4c6-4c5a-7eff-08db82afeaaf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:13:47.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiTTdfSaBFHk+pg7qQZUKYsNbYI7DXEF3vw8hzDD1/6Gvrqtj2I+nzzh58nP0/l929CQ3Yo4X0YnDIAAf6SzUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/armada_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9f6dc4fc9112..94783e374d37 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -964,19 +964,17 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int armada_thermal_exit(struct platform_device *pdev)
+static void armada_thermal_exit(struct platform_device *pdev)
 {
 	struct armada_drvdata *drvdata = platform_get_drvdata(pdev);
 
 	if (drvdata->type == LEGACY)
 		thermal_zone_device_unregister(drvdata->data.tz);
-
-	return 0;
 }
 
 static struct platform_driver armada_thermal_driver = {
 	.probe = armada_thermal_probe,
-	.remove = armada_thermal_exit,
+	.remove_new = armada_thermal_exit,
 	.driver = {
 		.name = "armada_thermal",
 		.of_match_table = armada_thermal_id_table,
-- 
2.39.0

