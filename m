Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27E745C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGCMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGCMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:38:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20714.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983D0E64;
        Mon,  3 Jul 2023 05:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMeyS4ZqlZ0WWth6bXh0H1a9x6Fcr39bHHO/2jkhKwYiATxrHoOFN6jTp+6l92boXyd101/xOEK+AcMjWyNN2vZ5LC/5o6eYHsC4XvqDMipuk1ZKKj5rNIOvikdky41Iz8e5B1HdlDghZWlJgNz98uV4/ATsZLLxHrjb+3X6CoQuuECZCvcI/bTMvUcS0rfV8rFDn/MrolQNPSm+6qRuh+s8+U4Xz+rMA1UuLHHmhEGRSO7od5A+5E8wc5QGFBoZSuWRycP58da/+Z7yVI2Bqxz1tuVP6xkk+2dXFbpJT94vp9AeZCi53OU+8449JppVcadGFCinbx762S1czDP0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97JgUE1ee9ZI22Y7+K3PhKKffjouZgXB0IYDD0F1gD0=;
 b=OCL2caXNEljZqRsIiDh2iuJa1vEyrb5Nu7w9UmWzXDPgPi02o543BNoOkghAYZn/hIGq33UIrTTYIIgL/4apcJhN9Cw9Pjw1aJbw+TrsjBP/x0IA0XmCybRteOkqYrDnItvxwwSLh++eOjRpJr+kTgRVNyU5fxzdUl5Cg28a/Wsgjc92/Naq0QH0RMeCTtEp2MhkBFzToEj+nwlcSJZN8bnuVKkn6GE+czh7TAYBX6h003xyiH6gJK/0S6Hp8uwBO12KCCvwkmN2vMSohB9eUO78HzfaZs2sB18pe6q3oZCLLn3hR60AN98Bw9glQyzNdo1IYml1W+G8zVcTgEdYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97JgUE1ee9ZI22Y7+K3PhKKffjouZgXB0IYDD0F1gD0=;
 b=CDsieaqgr+2SxesoksRn24nu4K8GMx1OizuNjarNrTKTgRL244m4VzJfCKdXDlye+KrcnhoP5qWvG+qFx+4VdQTzSEBEa8WFbB9x2Juc2xRkVlusNxij4syUpYKHkpBBTSyv0roFt9lEL1Juo4hxvzXBk4EH5nnfUgcY4Cj5a5Be9Q5GVmem+51cZTJUe0j6oQhMRpn3rxt3m6OV4BXx+a1hFrJlHbUefa7E2xgc3sOVpu6riWmA8ln1EX5PbIYB8IgjK9Jk8se8aiGsFHr/HWpB/X/WaMMG9iChr/5Y5XdtysOaayafxRNVgd90K1aiN1ekuGxqa2D7hLTt6wfCZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SI2PR06MB4443.apcprd06.prod.outlook.com (2603:1096:4:158::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 12:37:45 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:37:45 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        You Kangren <youkangren@vivo.com>,
        qat-linux@intel.com (open list:QAT DRIVER),
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3] crypto: qat - Replace the if statement with min()
Date:   Mon,  3 Jul 2023 20:37:36 +0800
Message-Id: <20230703123739.28142-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SI2PR06MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d41431b-e7c2-4271-5889-08db7bc24cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKO3VPphyVW2x7/gRwuORYOJtN21nu+WQnQcKEAlyXPe1v9nNzW7XEwjS2IW2GK/a+yhfDzfoXOoFSW+9OfJtcl7liVEFQY6HvHUM+YBsKGtd5ZtqjV4Kko6efzdl2fkdwmrxdQJBJNhl+soc8d6IEXV+jNvrrX2qi2dvQ1CAwhQa68DN6w9ubvmiqlccMfoSLWfyl7hFHE/mO3oiApYaFdmCW6YkyiQSr3X7XPMtTLmFavdROzQUozwJSHg+i/lgH3k/ZPIyTsqYEOYQdtD0JJBiSCl0AvXm/8r9QPJaAGS5NRZ6cWi813ezhi3vkOTpNqVboIHVrIlVlPEPEBYUJ0F9OqA52tJABPc35WcIzdSzsmmjSI/qSDDKj3phrUZ8KKaFuABOY8W3grhCdQBzDAPcQa1awRv8kF2l26PN3DjOqNHAZYyp14fct0I8YnjqhoXe2fF1bszqe1hNkHxDFz9InP4hL7/ItwYNJLpUCnb06f9Sqm2ZrLJ8VSizdBsoHMckVB0hRE5N35Osyp7HpqC6BvjknUt9VcBgZH34fbzs9TTQk4SJoQ4iJwqFS6cchwiLw5o/3vH1Ox4TwMVDgUC+n950lGS0LvmLqJpeuYAiUeXiI9qSxeZXP9GDFwNgLYPsP+XtXaLTjBEyFgwXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(921005)(26005)(107886003)(478600001)(1076003)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38350700002)(38100700002)(66556008)(66946007)(4326008)(66476007)(83380400001)(110136005)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(7416002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c10So6RQbCw59tCrDBeyIiQMSCHGtcVQG2vp1Lvy3XR76wLASFcmP51QGNwA?=
 =?us-ascii?Q?nCiEEDEzXdro8AIOviSjzTNgVNisM4eRWcwBdoxauGohRgt374XGK7ZNmWNb?=
 =?us-ascii?Q?BTCDMXKBDsGIKC2J4Xz7hZCUX5KjwZvlZv2JAaJQWwffQtKHY1cw+GDlejn+?=
 =?us-ascii?Q?UTQSMtLkCsUCTGmXmmLnG6ghv++vf2kqr+EoUNi8hKRxWXBTfl1pJwXxg2Ij?=
 =?us-ascii?Q?coSLEWSSdf5JdJpeqjTox3/qTTun8feA9UKy4UpfnnKj9p6SBU3oalP6KWgu?=
 =?us-ascii?Q?+SD5++DXMQxfX8FHsAEL3LsbqPJcD6Sg8qACFS0gKyRRXppjFC2mHwDlIeYb?=
 =?us-ascii?Q?QUNRFCVMUh2OOBiObRUUwpioWc/8kRo8V1hJ+X11eKwABXyy4AmIfiV7Zemr?=
 =?us-ascii?Q?/IRUo0Xp7bb9ilxGUHFBdvesqkzkRT2wuMawrsJIDGY1GHk2rtlVRBknudfd?=
 =?us-ascii?Q?CTwhKESr3dcSkJtCqjtryDbWDn92itmctLbWVV0iVGdLxcs3yLV3bQoo3Lay?=
 =?us-ascii?Q?GV8B8R4vtSbFqCQrDmrFRgLEoOd36A9XrX7I6QdzAifhHEwh/+Pw8NyVYUZI?=
 =?us-ascii?Q?S4owzgskBMCGnfvPcCMeiHFcaX1hC4Q/s12SfbiQTNrUpVB4CjLdl22lgsP5?=
 =?us-ascii?Q?CEHlAbYLWcxk/6r6PZMb9jNT8pgnifif+cw7S0BPDGXgY9iRz48wJHh9iKE3?=
 =?us-ascii?Q?SX7tCYfqhJcWWmB/ITjDwtm+HPcz8BYk+M6lXr3bQ5hxyF1BC14tXt5gKTdc?=
 =?us-ascii?Q?09Al7HLewnIJRL6KitKx6h1zw2fFuLeMwMFAEcztusEBvzGmM2cj0razB1mr?=
 =?us-ascii?Q?STmEtiIr79cjFr7ns8mJBdXx9oCMyob8E8cftFn6DziukmcJwSjt4hohj2By?=
 =?us-ascii?Q?5IVVLo5stOVeRf7WEDZqGVv1AzAtjFzlL4wHyBnYC1yJBvuKnjSQV6wDkw+b?=
 =?us-ascii?Q?UXe+MrOvs88ur/STD20mDRF5/SSp6dMQB2ew+86bLYry6VHIO4W6UwLJdZTm?=
 =?us-ascii?Q?qj18ScZgiZb5/uZ6+n9BGKUWnmRcpeb97qTCzNyAewOzxpSXFaW5wkCDR5kO?=
 =?us-ascii?Q?8JpZq/ivWG8z58jKVxDwZ6zev+2EXpbqwN1ke8Dlo3EKNCHMkj6jUGzUypt8?=
 =?us-ascii?Q?Y3w6SUz6UEJWJ3rTlW2fRVIJNkk03c6MaamWb+xoTVHLA6rZIza74w+Tlw5f?=
 =?us-ascii?Q?9DRginO2oYfQ5uc+A/FQAn8nA4Sp+W31BRxG0ZQO69AnIHswEwMNPs/O/R8R?=
 =?us-ascii?Q?uFkPLt49n13vbhXTpZRRQShgKZwargp6DooRWG0vqUjWeKGsr4ngKo4p6lTF?=
 =?us-ascii?Q?5HG+DboUN9kjwicMRE3Z6e4IdOUqxxK4n+potrPNkVekzuotkTH2ct61VIOn?=
 =?us-ascii?Q?WCn+k73sZatNWWWJKgeUQD/RSSaotaBSFkcoxhthwZlEmkGuuO7UC/PUZE6v?=
 =?us-ascii?Q?Nib96oy8plLT2pi9N0Bj9vXeYtwr9GkDqKIrcAE9HBS93QJ/u4qzrwYi8iDm?=
 =?us-ascii?Q?FDCnOCVZts+2mZ1sxbc6+HJqOCjNYss2Qv6A/E/2RkjH0kQi17UZjw9a70Vz?=
 =?us-ascii?Q?GNiT65HaFmxTmuwjKW/bYCu/jK5+ObYPV7kOGiDn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d41431b-e7c2-4271-5889-08db7bc24cc6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 12:37:44.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8nfwyR8rGUX9yywjzQ36WqtkG9Y8BJnziiFLrqvPsRZ+nFm6X74dlbarcp7PPoue74BcBDtQOzScMd641HKhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark UWORD_CPYBUF_SIZE with U suffix to make the type the same with 
words_num and replace the if statement with min()

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/crypto/intel/qat/qat_common/qat_uclo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index ce837bcc1cab..bad65f154777 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -5,13 +5,14 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/pci_ids.h>
+#include <linux/minmax.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "icp_qat_uclo.h"
 #include "icp_qat_hal.h"
 #include "icp_qat_fw_loader_handle.h"
 
-#define UWORD_CPYBUF_SIZE 1024
+#define UWORD_CPYBUF_SIZE 1024U
 #define INVLD_UWORD 0xffffffffffull
 #define PID_MINOR_REV 0xf
 #define PID_MAJOR_REV (0xf << 4)
@@ -1986,10 +1987,7 @@ static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
 	uw_relative_addr = 0;
 	words_num = encap_page->micro_words_num;
 	while (words_num) {
-		if (words_num < UWORD_CPYBUF_SIZE)
-			cpylen = words_num;
-		else
-			cpylen = UWORD_CPYBUF_SIZE;
+		cpylen = min(words_num, UWORD_CPYBUF_SIZE);
 
 		/* load the buffer */
 		for (i = 0; i < cpylen; i++)
-- 
2.39.0

