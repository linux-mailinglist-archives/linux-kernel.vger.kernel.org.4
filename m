Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB40669CF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjBTOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjBTOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:25:04 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D9144A5;
        Mon, 20 Feb 2023 06:25:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqEXK6lBL0qlm2rXwRfzYC1sERgJj2wshrytsC4jYHG2OsahD0xJidzQyWgWcgZ+yMqq7PFJhFkYi6LR5osVSJx9ugWK32gD7lrrfa3AzGtQ/oW0PVAqQk126tRiiZ+1bFeStbksVMk4/Gyj7OI8tUHrh9xtmsfU1HVW80OShwUdJGbh6NK0BW2Y7nW0LmnbPX/a4AKZJYbiYuWd0MbRln9aZvQ/LMjSjwinN6Au/3ccp/2x6Cbjo8wn5B/p95ZBtDwO0jlPG9IMUZij0BhSgBQqsJmZYJZ2T0PdzqzecHmKs2txDk9RrivdCnr+CHs+v3n1VGEwGhBXNelehiJYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMm+4kMPqN1vNRhI+RLIaw/gyK2NObDkBdmFSGuaPZc=;
 b=axBOHN4lEqMHEVbRDUrgAM2f7MeBWtK9cYvtpsZESye35PgVS0rLGqUR+5Bjqgi9W4hFyUl/0kC3p/LqNfFrsyer1advKcKlfaEc6OZr4gBdgxralt8OpWBcN0yFdAzKW0TJpMaUvevr2ZGdIaMVMg0+3a71bDLitRTcpiXcx5IXvmN3tuY7/M7zCC5tAucNMTvTTTC3wns1mUKIrH/t30WFUNkPh6qa4rFbDSbAxlNp6tMrwYMeOTGEd23CoHYwaG2sC0ZrRth0z2Z43LMULIMFGRa1Xtsq9+VpIO+I4BijYAitZMF5wcjwxuZr/xGAAFimZRDJHL0cfWoE9NgMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMm+4kMPqN1vNRhI+RLIaw/gyK2NObDkBdmFSGuaPZc=;
 b=pZuaIgGEehIBitvNN1NWzOz6u4/5HcA/JfBfB9B49UFFdkRUs+3lndTGJSZpUBz4BCjZMD9R/zsJL7eCFcTF6DXsukJ6cG6GEaScCidOKb3mccD2CPzpro9PUmvO45/h0StGDrcnqlNrjnea3A06SJK88oa3Z1mQI+S03+MOUlMbLnok18MK9Vv0ILkn5xk1XNF7Ldh8wfPx7E+6TaRIs3SaM025Phl+yfG6/Qz7Z2WbRgxeV3yQbnltrhWq4sk5GZzrbIZO3rqMB5ZOZ8loqlt+yv8zRuVaSxf213XI9p4hqqnK5gwjq1PlUbz9lUK935TJ7JhMdgfAfSZuvbI0jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by KL1PR0601MB3955.apcprd06.prod.outlook.com (2603:1096:820:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.14; Mon, 20 Feb
 2023 14:24:54 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%3]) with mapi id 15.20.6111.009; Mon, 20 Feb 2023
 14:24:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     stanley.chu@mediatek.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, zhangshida@kylinos.cn,
        Yangtao Li <frank.li@vivo.com>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] scsi: ufs: ufs-mediatek: guard ufs_mtk_runtime_suspend() and ufs_mtk_runtime_resume() w/ CONFIG_PM
Date:   Mon, 20 Feb 2023 22:24:31 +0800
Message-Id: <20230220142431.54589-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|KL1PR0601MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: a189ddb2-9084-49e5-41cd-08db134e3bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBw6zEXZ7BpPTZKZAkryk3RHxO/aXobKs/9m0X722fGNhrhTqp7NXn4PmgFXmlLoyJDGzdUsUfoTGtNMCQ5zqATFuNjs3XQSd91fwhLzUQ8P3oJmQvFsvC/YkrKLAdULX1pzPS5ncTNgnvd5JMh6znan2+CGKd1/q/FBOjZKjgOm1CY79VvlEkZyW3eass8KHZ9RUJJpSHVxpn/fUfuuZZrIPrsiw2oquWf9xg3OxJPezOMee1DtQZ9GTecmge3Zbb8KwhRMzxd21BBWJGbQaOLZ28b0iQ870nw7N8Y8Ums1CXGoLdEgH/vdveqW5fDoZuwmAECfsK8IYAi1PmR7JLcpq1e6ihW/jpNjT/O1wKO+z4UC9vx9zX6W7egnqA3GqkI3barSRMncgQ1k7bHur+i8csrSuI5s+MBdNgwmZDkTJDpig8xQxaiz6oDj4HxwL/dlMhBoM6njc/PeYhUL/YgpzQ41yyQ55Ve4rTkCaPlCSjNZxSuyGlEL/U6cPwpXHxRGPsar7aQuf180lM8ATP+MxJSISocwjG4Iq5xbczqJkf09e2nDbzDnUM5nFYW05vELB5APJfPanYT11nu0PWGbpOVkaN9iY7RUpXD7bj/nVoH7a0icgUQYKauP8dyQDNZd3kTP4LliFwkmVxLsFo9ElKwZ2ZpIb8aaF8w9sCaGmmsQgSrZYkDWj7NW8gv3pSNOwLCLEP3rrttZOMzW3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199018)(54906003)(26005)(186003)(6506007)(2616005)(38100700002)(1076003)(6512007)(6666004)(8936002)(478600001)(52116002)(38350700002)(83380400001)(6486002)(66946007)(316002)(66476007)(66556008)(4326008)(8676002)(5660300002)(41300700001)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UxZVAriWjsR3v8BPtfVnVyGuyF3ImYsscUyC7MAdloZfR4ddvy+5DTght60?=
 =?us-ascii?Q?Bz9svCP8XGnv/7uSNgjtY3zfHHpV2uU2InnRLEHCdIYQgp7X0+70xQGpnTen?=
 =?us-ascii?Q?KoIWg91AQgJvBYNbKkP821Q0BwevenWXX8ymE6NYExbnDaWhJg9qVYDiqRNs?=
 =?us-ascii?Q?Bfs3wzW4sORlbAExqkHH9Z/sj0kMLTAgHF6pqKAuYK+qnowQ2tx96g4h+vlo?=
 =?us-ascii?Q?j3bcsU8W4jKqgpYClInMwvuOkkUw380YT6mg2rzWgnn3N/HA3WbGe+kYBBij?=
 =?us-ascii?Q?pYNQRemYyLbFNfQOMPTIaS+3Zg2HLI7qKyMyjJjisiaeOCddlcIVfRhoree+?=
 =?us-ascii?Q?oK4KTWlmSrmeMzE5MnHRYnY6w0/90rw9OjJT82CjoRGo5JnsTvBO8jVUU5jH?=
 =?us-ascii?Q?tBmB3S5CWTVqY6lPxRbr2F5PmNh1RsejdgcT1/j0JvQwBpBdvwgL21ptSByc?=
 =?us-ascii?Q?PWqDmoNNwDBlaXS5X2saMaZ9OaSKm+ytpMBDelSKQuOCrNWali7Vm1G3eVCZ?=
 =?us-ascii?Q?EKXn+os503NF/Zeiu4BuPKtSEETYw+tOF8C7CYsGU0jYQhwBWkiVrvpYCDIT?=
 =?us-ascii?Q?ZmNBf2BXHi0jzv/wqZBdDe/9D6bpJbDl/8ouFJvcwH7bYtiZwdxG04o6t7dH?=
 =?us-ascii?Q?GVOpqsmfZGGPaOGWKejOsSnnDJELJbgijxvn9UGFjeVxbHa4cLaUr0y2SU/z?=
 =?us-ascii?Q?N+l1cPGa1cz3219bUIqwe4/YCnXGSLq4skwnIfXPdFylOpVmLEHr5/yI/rVn?=
 =?us-ascii?Q?aMoNMgzvs8KIluUhF4Zf5LtQrQ2eghot28De9HA1CtijV+3v7ttVmHdcC75i?=
 =?us-ascii?Q?V6QYTQOzZF02qIWWvELnkvZhb7OVZ3Mu1qTQsDvu1cXHAjaOzqQmE+BNmwoX?=
 =?us-ascii?Q?8lhwBuNFiAdz3RA/q30RzjpOUPlE6G2+R915MWk4xMImr3xJQSEijTBj3+Uq?=
 =?us-ascii?Q?ZxBCA3WJtrTuc1dpsnW7KzUTkquLXyoaLH3Nrct/mxjO2uwebuq8rjWvpvrl?=
 =?us-ascii?Q?q9JhaCpSlVGiXtuChHcffRt2onkl8DYIxwJ1yh3Tjhs8dqrGAe/QjpIgM1M/?=
 =?us-ascii?Q?iRims12HIMXV5vFihCt5vHf0zzv+F2T3pm4SEQLXdMdTfDgdP319GENQJ+3U?=
 =?us-ascii?Q?HZ4Sp6s8c3a+Q71kxXKQ0TqoQrNjNpo+bF893nmLlKaFA06R7EEIf+j70pco?=
 =?us-ascii?Q?gUisNLFHcqWQfKABnrN1rlZFgv9kDGveM0Bqbf5BZdrsDvlpQcs1v7KTXssX?=
 =?us-ascii?Q?o0FPYlFpe0X4RCKwRLTwchWQZ9kusKCHXVA/Q/2Tk9pk3L/DcKdjS0uZYFiF?=
 =?us-ascii?Q?qcuPLofWJGoAAc0CMqXqxAy0CjCG1lvjoAk4B0wp8pU8alN3oQnDChCp/fwi?=
 =?us-ascii?Q?W9/B5e38ScHD5MFuki+BKAw3TquDMqxNmpfC+YCz+hFZ7OMc1A0HFc99Rupe?=
 =?us-ascii?Q?ikegHo9ogzo1R6xjvJtVBybXruw1p39sXQ6QJLPw8KTuUH2Bm700VW5G6aIA?=
 =?us-ascii?Q?yrk9NvhyuLsER4jMNUdVA2DiNnY7mEiGML8Jkh8HHCSQgwOFWkSbVUyVvaCN?=
 =?us-ascii?Q?u1oVzqNJY2L1DQI5Dt7dEes56oBqzch/3Ms5SSwW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a189ddb2-9084-49e5-41cd-08db134e3bf6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:24:53.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs7qTrp8Gt3uGP5m6bEEQqfqv57FS8beS7QnXGQzCDGdk6z3IhUu8wZASuw5Y/c75S9/pjgQjnk4QMI5NArqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix below compile error(CONFIG_PM set to 'n'):

drivers/ufs/host/ufs-mediatek.c: In function `ufs_mtk_runtime_suspend`:
drivers/ufs/host/ufs-mediatek.c:1623:8: error: implicit declaration of
	function `ufshcd_runtime_suspend`; did you mean `ufs_mtk_runtime_suspend`?
	[-Werror=implicit-function-declaration]
 1623 |  ret = ufshcd_runtime_suspend(dev);
      |        ^~~~~~~~~~~~~~~~~~~~~~
      |        ufs_mtk_runtime_suspend
drivers/ufs/host/ufs-mediatek.c: In function `ufs_mtk_runtime_resume`:
drivers/ufs/host/ufs-mediatek.c:1638:9: error: implicit declaration of function
	`ufshcd_runtime_resume`; did you mean `ufs_mtk_runtime_resume`?
	[-Werror=implicit-function-declaration]
 1638 |  return ufshcd_runtime_resume(dev);
      |         ^~~~~~~~~~~~~~~~~~~~~
      |         ufs_mtk_runtime_resume
At top level:
drivers/ufs/host/ufs-mediatek.c:1632:12: error: `ufs_mtk_runtime_resume`
	defined but not used [-Werror=unused-function]
 1632 | static int ufs_mtk_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/ufs/host/ufs-mediatek.c:1618:12: error: `ufs_mtk_runtime_suspend`
	defined but not used [-Werror=unused-function]
 1618 | static int ufs_mtk_runtime_suspend(struct device *dev)

Reported-by: k2ci <kernel-bot@kylinos.cn>
Reported-by: Shida Zhang <zhangshida@kylinos.cn>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ufs/host/ufs-mediatek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 21d9b047539f..73e217260390 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1613,6 +1613,7 @@ static int ufs_mtk_system_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM
 static int ufs_mtk_runtime_suspend(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -1635,6 +1636,7 @@ static int ufs_mtk_runtime_resume(struct device *dev)
 
 	return ufshcd_runtime_resume(dev);
 }
+#endif
 
 static const struct dev_pm_ops ufs_mtk_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,
-- 
2.25.1

