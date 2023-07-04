Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2EA746ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGDHiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjGDHiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:38:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D7E6D;
        Tue,  4 Jul 2023 00:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqjinU0ZElAVtMDURMjEHA9fsR6wsEua8szcjjcX1uS7OYNyU0AUI/jE9nTkgEMeeutSb+Gn0WcTIMtNuP1UL9dKhIS0Tk0UadtJIF4mc6lvlwu5AdP6F4+pJzkXomKa6eEhET3KQDVfTvrOvSUzd5QVS8eM2q/pN+YAjQmiW+tjFX7zZng35xGQM+ugAVQqL8U7IhedzS2th8slNWvKJpJckt+gqHdsXDopGFTQzZqy4c5nJ2Zp2Ks/WtNSljwy/pDjKtvvbkT62B0u9Vdi14yyPH0Zgxb+WOiym+WCsL/cYdYtgFBokpVDgUeWWU3d/g/IXRUCJgBbEL6QSXJRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9HQhMaqLSxXxWmEJbmsr47DN1QfOytmGvpGS6uwDjA=;
 b=bwzVljOCkdK2aZfYXjui8TgiCOles/+4QemaBQVk/+LZdWushqBk3F8NjKwI/QSYUyuJRtPP5Id8pthQ6P9lzoQE3rIArJZBYzycWKgFw1CvlmLKFbzk616YRC0/QewO482HLgm9MEZ5KblBOlZDC0RhwOVhh6w6lpyv+I0p+++8X+GUS2doYnGle2HSJyoJDhqO2dDejmyruPac7oVyh6Q8iR/Z6a6ukhUiMcjJBK00Fup56gW+H5bhfoYPT4F0StoaDkDsaOtGkn6K0HDN4TBskhFLaxX64lnETNW7Cx/8VxFlH0ztZNpud1OHcMklkeCVx9ptjx3J8zWhs7Gg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9HQhMaqLSxXxWmEJbmsr47DN1QfOytmGvpGS6uwDjA=;
 b=SLZHjfiwbYvVBdTdKkf92VcpRFx8mmWrgrJzmX1f/k1DGmckJLhMwR0oMNWcANeZ8jlL7+He1We3SZ9wSg8k5VBhUBaXNM7Mj0o+/TUnC17Q9TVTodvcG0M54C11l/lR/GQaFoQc/3/JJ/GKysQKs+DLe8a++84HYfuJ5XT/TPXmmZMjYMpzBao1zg6mzaL8lTx80v766kYDU7+NpE1Tm3F4YhzNNAaxk1kqsPkQEX7319dkPUEa99OmsIqQ8Y5banzlmZybJZ2Ll2jUX08Pe50bzftUPAQ+pdpIzV7z434NSLRmnvsLna9/ZCuXeQC/l9vgtITWGc84bmRJoh6dGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PUZPR06MB4574.apcprd06.prod.outlook.com (2603:1096:301:a5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 07:38:01 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:38:01 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: scsi: remove duplicate logical judgments
Date:   Tue,  4 Jul 2023 15:37:52 +0800
Message-Id: <20230704073752.5498-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PUZPR06MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf12ad9-9c7f-4839-01f3-08db7c619829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8xO80o4G66dloHp3bSRS61zkKPEimkVzxOgTKpWaYG3OhTaL5dzvH2iLGAUp3Z3AnLPa9tANHA663v9s5MFNjc97mtlLe0nMs4VgKVUK9IJ7BiCPW8nl/0DiODkYvSENjQHOdLvUURfTMfi8qZCQHJdGS23gyP3guEhbW6bZdpPSUInDYn/QljmaJuMb1a0FRSM443MEPq2vkNUo7aUaqa1C4IXvoWnaGfF+NWTu54fDNOv7kNfrAUif7xKZSd6EDgAmREcmGRDpgR76yCiV8ee7+tlLBszH7nuJJHDOgpA1y6Y1nVb6q6UEfdLdp3bdSPaBif+o1rJ/WNNCwq+ilC3wCvwbSq2hbP7CZQXQcElk/iyAfISGDumICe6Lbscap1ISibvZPshiZ+geS+0OXCchKrJrs6CulXUJIpBBx+3ci9A/5gH3Bo4bvMjkDtg1RRo81dNPZ1zrH81riWNd3khpB5J9VEC9Hi9Ut/vtfos8hj5K0QvhFGw7/GdsEqXMdnQovYqp00evWacPNhtzNjph9pGX5xpBMIm/AGaX3aGZywEdO+BJssSsFvJo7a5zTXlzYCj5+br5PdLuyCkA4lhobHOOcVSarUr781f/oEpSvvG5aGxmKQkGfA2O0CE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(107886003)(38100700002)(66946007)(66556008)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(4744005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NAv8d6om2L1tzKV89VN9+lLYLOUFPQ6dqcV1zJoMBD1/Udry7+El9RWQczV?=
 =?us-ascii?Q?yFQjDKNd9DcLf9FkK+GMPe6K1Emuuf8sF26Ina/mogronUZr9k5jaZBWnDbJ?=
 =?us-ascii?Q?f89Ajdmu/nFFU7gX+DWQ4xRd0q8NeX7Z7aaYG/ywC/2qntFXmaIpuvn00BUH?=
 =?us-ascii?Q?UPVRyV3SgrxfaI2iAad2S3LP2kNdr+a3gVCjHhbLezVluCnfKIldfvGpNJkl?=
 =?us-ascii?Q?0dWJ3JiTVgKAj9ITQSPISOzuGsckqlBshPFNn4SQTv3g9+c7uSVdvU1MHvMR?=
 =?us-ascii?Q?iAttRBY3zRmarxWMU0NSmOwrEzgsBVLQAzEjJJO3fMeoRd20DvYHQGmJLD+5?=
 =?us-ascii?Q?7vNfs94u1MPfEKSFjoux+nTjdEETnd/h1eTdUqB2uA6wL1KQHHzQ3ASpx0ap?=
 =?us-ascii?Q?vc9gdE88fRqGel22sBGAHfXIlxT9UoBGCdZ5ExlO/xjmL0nk5ZwjTjarLc/X?=
 =?us-ascii?Q?E9mwrINsl5auSaEAGX9R1WLKYqXawKIpCaxyKHE26Sr1pTKJRC42qcXcEZ/H?=
 =?us-ascii?Q?TV+0Uc5DHOZdVr6dYvzc/werRnBavA+q/UX7u9Y8LAj3uN9F2gDLZuJthEAF?=
 =?us-ascii?Q?+WrwYQgDHkgXQv7JZl0OfzQwI/UVWaCJgkg8f1Ln8KnPg6WclWna4iUM1bKs?=
 =?us-ascii?Q?ra2OD7LSwh4Jl3wtvHMRrMTDFni7CCii/QD9eax+ImtNRl8pbv1n6bFaCtFg?=
 =?us-ascii?Q?8yBX7JL/aKlys/Sw5zfgFiXD92l1BiYs3PI0OctlhSwipiyQ7vmVKHxEQDr/?=
 =?us-ascii?Q?Zb8VrbtU9qk1TFkuB3ROBpg7knO35yhG6bGSE31rcOSuHiutoBcT/DbCorTQ?=
 =?us-ascii?Q?DHF83MSZ27QTLHgnbg9e2fG64OhOzkfHjTEIrlz+qVG2ahnOoNhN2aqP4XeU?=
 =?us-ascii?Q?skGeHZ2lE58Ox6WCUXAXyeznFXv7wVkri1jG4fbEJSGCYbUd1guf36HugIJ2?=
 =?us-ascii?Q?crLzBy0MozGW5XsCcIBFqA6UAfS9NvfARQRNZCnIf8b+asNJMjZUE4a4BSrV?=
 =?us-ascii?Q?f1GkovUC6gEkJduaxvAyMXXGCzFroc0gbhfMw5dtgy5Pgb0EYI6hBmOzilH9?=
 =?us-ascii?Q?cGogm9fAbRoFuXEMTHJagx3RoWPJWMlMDCcE55mgnJEJh/Z4MzV+c86G/K+a?=
 =?us-ascii?Q?R/QWQQBcM64/H0CUd+y++0yXKNFbrAWKGPUkUPmqMz4/WaUP/DZ8eH+yAw0h?=
 =?us-ascii?Q?VDO/p5WV9jsNQMFtNWKv6Hc5vL3Ybdi6VltgGkwPAg4uHT5LemeiKBVl5Sp2?=
 =?us-ascii?Q?LMeVbnIpSrQvjs9GkenwOZpnmgITcCRreqGE8c3Kh4P04+BVfBS7LSuWM4+V?=
 =?us-ascii?Q?epsCHITIR9j3Z5FpatNMrOce+K9INxn1K9V379C+9+FwHmdbn7IdYqilT/US?=
 =?us-ascii?Q?skzKyru5sI/SAoiJLUBxKvWIcZqA5qIF4fmqKX0BMYATEY799wcdV5nygbSs?=
 =?us-ascii?Q?uRkB9ByGhF5a3730GXsxee+outdw97/KTZCMDJd61roXKvZFjN5cyAIjZ5YF?=
 =?us-ascii?Q?hk/0Ryg2Jwd32T1rHmOtu1T0cAKv9s4Rf38USRuCcgUBB6hwQS7zGJ6slLq5?=
 =?us-ascii?Q?RJp/FRG3q64il23lkeNKa1Z5RH/RIQpS2Uv20Ngx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf12ad9-9c7f-4839-01f3-08db7c619829
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 07:38:01.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFzuYdI+pULvU8b17kSpFhSTBePPrft+OQEBcZTpoof+v+k5qO6svxoT2LkhtawJwgPiMyv/u6gEM6qBetcX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4574
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

Fix: delate duplicate logical judgments.
Please check this. Thank you!

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/scsi/qlogicfas408.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
index 3e065d5fc..d2f92672b 100644
--- a/drivers/scsi/qlogicfas408.c
+++ b/drivers/scsi/qlogicfas408.c
@@ -594,8 +594,7 @@ void qlogicfas408_setup(int qbase, int id, int int_type)
 int qlogicfas408_detect(int qbase, int int_type)
 {
 	REG1;
-	return (((inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7) &&
-		((inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7));
+	return ((inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7);
 }
 
 /*
-- 
2.39.0

