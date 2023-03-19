Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185986C0018
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCSImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCSImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:42:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1142016AC7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 01:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns3wRcz8cEI5wnaDzTAX1C3dzVCEc4AEXOBKKceYO+f5btY+U9CRrt9F1lKQZvni0zoFGW/8aNUicS/z1wRO1aZF5fhaasMnHCOOsmeR+YNiS7lKPLOu26Nu4LlMvU7w4MpCssrauRzrXOYI/mFUsiLBESr1Z9AzRHW16A25+PZ68jvbJpZp0M3VxdcZGDxu8bte7RT7qaVZPJA5oaCM+2+uMpB67/YgagIXSjpmd7RibUbT3JYXDuv+sUwh7J+F3xScoKXthChYMqYyzscf8OWmP3GUDi5eSBRLOkyjKkkgJ8Or8xJlsFkGpS2yO76Krn+40obBoahpMuCqB87NWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfzLJyGg2pPv0YkDWXwHhHcFZsGUeeX9EwBVvu3ePyA=;
 b=bkXTIlkxDyxsCP29MK44GLleHGdRvd1y/qKEOp3yE8hYQQDGID1apcfMC6h3EuUTVuPBfxSpcf7hixr0zPTkS5RMfTGUW/uvUSjPmskU2egwxCVY9HhRG0kIych89WcYFtBXgolm7dl1+BYslO01EZyCmTGKs5pw9elv2qk/XCOaoFiV6GkrE2vX8TLA6Q8LAmpAhZT4e7mXnLYEf7rK6puZ7W/3eA9ERD3wOnUfbbX7c1k9/S2HRCuHQVcPfqYKcKSWoNABiIkt4pDwLkNA6NhMil775Df0YLj+VRQ3oWJdJMJ6eqVP0GkpxNSzYGRjRWvDrzxyAV4pVyo35JKdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfzLJyGg2pPv0YkDWXwHhHcFZsGUeeX9EwBVvu3ePyA=;
 b=i+FBK8dZ6ax7t14r9fEz9+epcR42PDI1rYM3WR/qBM+EVwedEzMeD+2JmYVf84J3KakRVGuFr9AP1pD9PtUcXusge3Ay/HUHCOwetiIhiOg7Ja80DV9+bSKByAi9URdphmKaG3FAGHFFkWubfBYPJjw6D1/m/GrN7Pbayb4zibkgHwnxTNqMRT6nGtZ0V3kHdbK1YQxaR9FR5HU7H9KfVMqvdn/fSk2+fGq0beeFyQ/yzIh4UgTjV+8S09Oa+ZZEBqFjN1ncnoE+m3lvUzFpWlsgEGa+8TTuFJ5hyyrOmwwFj4YIj4Fwb12Jn4+hsGgU8DwF1pzsLR8aTfkwj5yVBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:41:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:41:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] ubifs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:28 +0800
Message-Id: <20230319084134.11804-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 40eb91a2-5180-4e37-52b9-08db2855cdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fa5vZQtT9fsUkB/5Ka2knB6z9O5EVHDIoSjlUxIcYMWU2Q+01ZYi5nKkr7HFMt97R7SLy+aaXP06HipEsDA+FnmJGtIcgNFcZLQ8vn2kC2YtSrC8OkYtTghz+kbb3AHdyQQj3RIY982jbEM3MfqFgYePZu+qBWnJieLtHp0bevrlv1hHrNaE7PWo1nZEjLBm2SsEsKipkHh7s7M/FElxC/0AXlE/GqjNqY23evk18DKtRmKaA2sFI75f/JarSXK9TOwsNVh9qg5l3K6hfMjTYf5tuR+Pp1l3Udjbu6pCml6jD2M1KX0v3NLPP3x9fFVbqJTNaGnVxUXH96NzX07O9slkX4lVh9sZ+RzSr9DQO+e7pC5dSP9Nu3vbG6jbQfmscGBbCeBz9pgoQN5Tr62uFrWJR+AltCnTLwPGJGQbNnVs+5SisgF9Ivke4baEN3wEDTR4cFeYxZtGSvJ0dbfvXKgcyvD20O15o20ZqmGIcDIJJX0nwQGT4Dqv7uz59K5/WBMkUX5KOU8hUUeujUfv9HwdnSv0ofT92GaBRiI/SfWZlOtU2JugkOOx54G+F1cxqWzFa+dW2Gwkwxc/DuKU5WR2lbIJirK2OpXDxmIUu2ziMp7T7nxQCPUsicePDrmZZ5aUEgFMoFhVtHjw6ym7WYURS9cQyWC2goJg+eQlAIJINsoyy5yzW8Buew/hFaxr2fwRm1hluYI8vlh+9Y4Pmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(6916009)(4326008)(66476007)(66946007)(66556008)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LK2O1aLvIlDcgoGQDOTKmz5T0dHo3CioSF//Euoaql2E7dTUIPw5tWHXq77y?=
 =?us-ascii?Q?jV+73mQrTls68OWZ8PqSDr0pNu1DOjyMjvSFvoJv8nVGFm2jzgRkqm+sHkmP?=
 =?us-ascii?Q?9RZ2e1JKJtbMfTaEl4duxI+Pd4HGo71wDTT2Dl/9bxy7f8B5zPMcK461GYG2?=
 =?us-ascii?Q?ti7PkZ5HzEkFB6BNGTk5tmRayJa81ZaFlXlsmjGJakk5wy1H3+WaIT8AskAM?=
 =?us-ascii?Q?6CMtQcZhijOf96nN3PnOUW3kP+mT7s2ZeBsGXO5BqPumWc0rAEaH24d7bW+U?=
 =?us-ascii?Q?zKBjgOLk6R3aYt2C2kIYbU0iembkBVMIv+pAr+VyKGwpb8Uu4BhD43J9WeIa?=
 =?us-ascii?Q?r9HBEJZrKPEDPf6aFhwfVY/U/IjXzfQxORZDrSMyynNNcoByacOs1pdE2IDP?=
 =?us-ascii?Q?feNrxIomCiwx03HzDN6AlQeITweFyZCmTjJoZCKibhcWFhjRWAs+J2RfYcfl?=
 =?us-ascii?Q?Fo0KMEgp8LYRASIGV4CBaxZpnrurDjoD1Qnt0ZTTRgs81WgJ7zM0eLj9g4gy?=
 =?us-ascii?Q?WOJfokMUlCzDM1AyR1x7TYCdwi241gpb44/Md2P6PajXAvfUWnAbw1pzKyd4?=
 =?us-ascii?Q?0YyGI8WDZoLLQaAKjSTp9KMBJKzliqXUrrdM1Wojv5O2KGj6vKc/jkWgH8Kt?=
 =?us-ascii?Q?A9wirJSZmdgJchNvZ51cO6Sg8iHPcciQXCADH6T6dbjlgkOaCOcIHwRPFBqs?=
 =?us-ascii?Q?Ijp/dq660Gkf6ByJGYk6o8+lq2paHo03Na5UwTfSyh+RocUF/Vfry71+7TEZ?=
 =?us-ascii?Q?E35BOFR0q9NHdWZ8+ZaKvkvVQLlhcdzhC/BND09eERbaP7q2AFj7YEYCwU6B?=
 =?us-ascii?Q?ydsMDslkCASNpYXf19omJiwukr5oztGUvF3bmB2G8vDTozAR4bIyhsdR0Vtp?=
 =?us-ascii?Q?A432SwHmuIIo9RAMr5ZhnKQsbAZysxpH20R8rWmLqQ2m7fqAuUK4qCxxnfRz?=
 =?us-ascii?Q?vi6WZWXxT+/InFPS9bAflG5JpPejEN0q21Ft0xvKaoFKY+Au2I9Kwc5BMMH3?=
 =?us-ascii?Q?DKx7l+BlIeSr8yBfCh9nhZvcUhh5sysKRQqupkYU5gSqupdGUM00uGhAQ+5j?=
 =?us-ascii?Q?cOT95cvWjov0muXp7IzwnFkvqrgDRJm2ZG9Mw7xd1utKkqCrv26okZcBrhP4?=
 =?us-ascii?Q?sDZIKHGXacNDAMaztV0URegmR6OuG7EsdXeKebQ/vWJHPGzPUywlxQ5G84Jf?=
 =?us-ascii?Q?EPjh4EKPuBTsATuOfCqe4PvVfeY5VKxKa45laKQlx+p3Mr71qSGTHBoaHbH7?=
 =?us-ascii?Q?/GCogC9/6tAfzK2W50tZ4uqJTppyzmgMsk5H5t+7eNMB1q12KDGiVl/DykU9?=
 =?us-ascii?Q?usV+elIiprRP8HS9x8eycIKDR3+LqY1r1tJasWqZbIuEtDRZ/vM0Yr2+mlxj?=
 =?us-ascii?Q?ayA23MO/8iSuqmf+0K61odQR8bWfr7YiqBEOUmZUzUu7PYyVEk7kDCRugGA3?=
 =?us-ascii?Q?1tluEPApQcIrpkoXUpE+8MxhptpHG1wgJmRJ1BNGiUwWlHEssWMOPnYIe2FQ?=
 =?us-ascii?Q?bBNuZjF1hNQTKFBNwzbEcG6J0dzQm/rfinhkMKW9dpDPcySFq27/ktjwuhnK?=
 =?us-ascii?Q?pv1rmhigtKjV6fUYkRUisnycMp/jy5rn+VJatax0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40eb91a2-5180-4e37-52b9-08db2855cdbe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:41:59.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3zC/wjrsicP5XZkozj4984nDvsbEAXGJ4T04JUHapJA7widCdJGfZkTfIt4x1v7WWuNFycArupKMKPjiDYQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ubifs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 1c958148bb87..9571718e61a9 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -130,8 +130,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 
 void ubifs_sysfs_unregister(struct ubifs_info *c)
 {
-	kobject_del(&c->kobj);
-	kobject_put(&c->kobj);
+	kobject_del_and_put(&c->kobj);
 	wait_for_completion(&c->kobj_unregister);
 
 	kfree(c->stats);
-- 
2.35.1

