Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3E7505DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjGLLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjGLLSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:18:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2601736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpBeSBYgpWWf0mFQucYkLejweR1wlHYUi6Aw38U7t/zKvqj0UpGYILSMiTiscTypORuZjtugxQO9UeSTmDk88K10vVS6MzT7/I5kTdO57N3cHqKYktmrNblkxIAtHS7ajjTNstUEG9cebRZhn/IAYpngyCOqD2SpRvjNIPunAd+9lAgyTJwtUUJ3JcMe1wRSxTDMCxjQEIPRS1DFJJIbMoMxMA9QW0G/Eikd9exgLdtITRB6SgUDIEhN2kDGJL9KvDSMzWs5Ws1uMa2YnU7a0J3jZR3jiD/PoZzVTXBtl1qCcsrBSK/lVN4E+fjysdkNTkX+UgD9xvfRioItHirakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDKCicLULOso587BMmlw43A5fl+CvMB3t3AJlMmFiyI=;
 b=JMq6vD1t1Sxew2FXlbX+3PihecKubPJVPdLe5SsOAl7lUtH6x3GnzbPftoJvDgEeTEbIvDFKEz2oilhuHVoLDQjZDgpXnbkDdBMQq4ZafcMQ/sDPBCEcRPeeA+83CbslM4fcMDlsRqCRjdhWJAIWhmGTjUVU8LaP3wLbghCDvlok4WvN7/XdcBfaHeWQiwgNeIAzQXLPSEBpT5J/sseUv6RQpU3U7Zgjahp5Oauf5A531HuVZCpdtzpOPkpL0eGHT05QwRCrSNRDxJ/XOy1qeq9G15B2V8Rkh5rWQFavKfqgg+MEZIRMFmtEzxY/uKE6Vtck8i9IYlmUayQusw5Xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDKCicLULOso587BMmlw43A5fl+CvMB3t3AJlMmFiyI=;
 b=YEfsLyV05FAf5aBmJ13Zo0t4az3tcyoPOajBcLFapbMIyJl/LI2gQLNFpE9ELb/yYXLEnqqQmRUhdYY5h/V96pK3GJttrEibb+G9yyIT0wCuNiU3+ds1sNa+wYQ1yTFPmusurURi22hlIN1xYh8jqpKeqo1bHroZbdGbs1cCs5mKHYIzmdv6oFKOfZjZzOxU5I5a4bUbnsrr6SDfAlZgllzJGunDWizZlfbtD8iTPg3khSrfaBpm9XKhA2czjnSfMIfjiE8n1pwxE9CqgkmuFboIRs+P6UFAnVeha1Evt3hFfbg7fopMDQnFlW7W3QJKvnZs928bvS9Lfwr1vmJ5TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYSPR06MB6544.apcprd06.prod.outlook.com (2603:1096:400:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 11:18:47 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:18:47 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: host: fix parameter check in nvme_fault_inject_init()
Date:   Wed, 12 Jul 2023 19:18:37 +0800
Message-Id: <20230712111838.11923-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYSPR06MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f364131-5524-4cc9-c724-08db82c9c265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xa6Nb1iQRAdGZad3wAVNXqfW8a1UrM4jVu1zvx9m/qV1hlIJ1/+9nywBUILaWNHa4fRHtAxZHNmvgTHli0KXg2XRT8xHJ8GUpXfkMnZny1oXNWga+7p0sGF4sGL3gQKfisEBsRAzSMTHKw68b08DMi4XdNClS+KAvE9OWvceBbJoKqkGxMCXj5E6aBLD+ieE0U8ngkp4drwU6Y82OurTcvYeQa9fVRYdR+bIbHCr3vbH75Yauf7gMEDlzPqQqgdqI+gxArgQyIY/tqt2tleOp+V5b29XBANx8FqtQSXMc7bUtfryQE0p7R56w2JIB/hJsuHhczAMyE2oxzgtry0Pa5WAPYdFEFr2bsU33uoLJvBKYL51Jg6qAL3WHe5lEkfIW38lwrfu30hTFaGPprNTKFSjdqHDGL8DLnv87OQ5AkacbvXhn+6mbUIyl8WKWvyscAk9QXKtN7s0trO0xItE8Spw1FQvi7NvaCG5f3YgTVBnbaWIraXlKBl3e/Gc3JkaiBtH6XiZB1sG89BKBghVq/OxQaFsA3S7RwvG0iaGmjMrHeT5C7jICR0lZjVm7fIaKwEI/g5pizxxnzNTmsmn687Z35320Aphvi6XSCz5+h4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(38100700002)(2616005)(38350700002)(4744005)(41300700001)(316002)(2906002)(8676002)(8936002)(5660300002)(66476007)(4326008)(66556008)(66946007)(6666004)(6486002)(52116002)(6512007)(83380400001)(478600001)(36756003)(110136005)(1076003)(6506007)(107886003)(186003)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xmgZhZsHlPTlwlxtnEzpsQKnichNpbWqolWyGcT6k5oPc8sODE0jewcJlkTo?=
 =?us-ascii?Q?GSkXhAfBsfpnxoqpeND4tZQbKj2PkN6p/Zgb+wubDkfjD9zTgkIIqIhRJe6Z?=
 =?us-ascii?Q?1eHESGvTZS+Ffl6cZuUnvnShL/26DmE3dtePKK4rht/MRB8RXCsH66HFucHT?=
 =?us-ascii?Q?iwALhEjWpGhbRgjhKdPeQTc2EQ5N0k3erD128aKN6tgWjTNQMxg3FHhEPRan?=
 =?us-ascii?Q?9BnY9a43M33x9D4g1M1d+P3ft4UiMt/e0e3ndCrOcADLQRa7AuMSeWachDvD?=
 =?us-ascii?Q?T8+YzDUT4RIKMlSiHmPoEL48qHRLgFcO5RQzj9y6gpgukBQdc2zqb4/eVuBI?=
 =?us-ascii?Q?wQuXclSvQAhTkUKUnkRWPlAuofs/WCVoZrRJzPautQ9gmx7HGkUs/OF3gD87?=
 =?us-ascii?Q?IHS9RfB9/IvBtrjyDk2pBVb6zW4IvzM7vX85+VkRBP2bcVOgHkBtoW1Dyfk/?=
 =?us-ascii?Q?CP11sl2KscmnzbqhlK337WyROx/9Zm7+uCj4JA7L3459mNVF9mHpT8q4JRio?=
 =?us-ascii?Q?HJUJQGO6QOlMvkDdgfOc+s2pB23dtFCq2m9PtbWwAUUQ4pjNk64M/lDRyR/7?=
 =?us-ascii?Q?vw/wVGZ4H4KUaJik55r9J8WNV7i4bSch+stqm1p1fknGABHHYZXP91p4KNEr?=
 =?us-ascii?Q?McWJQ8zJmstrpThavyeoosnJLU8gD6hZ0F+UsIQzHwsVjmMjZOtlTT6HoqyI?=
 =?us-ascii?Q?+FFjlDfEaxNpetDvfa7zgUyY02Oaw8bO6SC2Btea+8LmG00xUUdEhnEzjRWx?=
 =?us-ascii?Q?+pSCoAVlijXS9V1tdWoy7Tc74QZh41qYAlVKEqQtib1HuWzkIfoSuBi5M+X4?=
 =?us-ascii?Q?AnfgunobcivtPJ+rFhFSks7i04EMHBIImklmwPhi1eEwU8HQLld4E8HzvMpl?=
 =?us-ascii?Q?v248VryFNp0qcvpnuZg68nDT4318xhu5nLywzq6G952zGH5+QEDuY2oVvHNV?=
 =?us-ascii?Q?JW4zLbhxlZG5V/vIVw6tQfnrJQzVbInegsEwaQq1BcyGYo2BcOniF3uG8k1z?=
 =?us-ascii?Q?ECb8Z62jciL54mBxgFDkUjsuOE8W88uPBJUqGZNG8yKp2md6Y6aWJOhJeTes?=
 =?us-ascii?Q?gomAqZpT6n/vMAHU7YOg6i/7cu+xtFMSWi1ZyOGgEDg9qJoB3HGksFKd7N6S?=
 =?us-ascii?Q?CiHx2kGQiXiM58y9XbgH3rFGZtnjvosxI6cU4KWV+AJwnhg6ke+usGBAoiY8?=
 =?us-ascii?Q?rGY9akTFiDdHJ987zHbmFbZfPx+ZRL4AAMO6M+VVO3w29wRzitgD3PqrFv3i?=
 =?us-ascii?Q?0ex2UZa91kXDA6pHCaMu6uxu1D80juriO6cDu0H6rLBAxefjIhF/2y8HZYRY?=
 =?us-ascii?Q?EgWnDJoOkFM5+q5zmp/0OZeq7wW3fC6R4AysBtxMzkh++Zh4Arwn0j0ndQ91?=
 =?us-ascii?Q?qdxqcD5X48kxM1MrCZJ5gb0wDb9o8Fm10nMLx41qUF4xSDH+tbnF+yaVSPHo?=
 =?us-ascii?Q?5DBvKoMaS96MDm4EDu29BBTSVfKcmugSXBzzk0v36OeigqZ69SG19vt4IKi4?=
 =?us-ascii?Q?xuKQc9uIWnn0d+Ifsq21BUWGGRSrFSwRMZOtjnjkh97YHj80QlYqtUU/ZFZD?=
 =?us-ascii?Q?bKmr7hTXTlMj+8ludiNgLmrXl4JpHssZoGZpME77?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f364131-5524-4cc9-c724-08db82c9c265
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:18:46.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZN97aoClfK41Rq5XrlBkqGypVPHE8v35GzCU3TSxCqySY+5hobKjnp6WcSkMSEi/WIJha+OzHbbm/1e65UOlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6544
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/nvme/host/fault_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 83d2e6860..1ba10a5c6 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -27,7 +27,7 @@ void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 
 	/* create debugfs directory and attribute */
 	parent = debugfs_create_dir(dev_name, NULL);
-	if (!parent) {
+	if (IS_ERR(parent)) {
 		pr_warn("%s: failed to create debugfs directory\n", dev_name);
 		return;
 	}
-- 
2.39.0

