Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C847574B9C3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGGXAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGGXAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:00:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065C1992;
        Fri,  7 Jul 2023 16:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf9cSaJQuCKuPux+1GWO11PdEP5u+W0j5s3SvFTh2nRg9+5AZrwBO48SdcO1Jjk6Ii3OnjecYv/jzeEKdKhbqbbCyku4xMOnZ+UBw1xazYvOaqVEUJgGTz3C8IJokhCUSIM3antXAn2w66xpeMPoCc3lNbEuGxkJT+50C8VuRyGQdoyZfrbhlxqG0+3dSGEgKPfmm98+EVqP68850+42Mg5+g0q0BQiMXqVSd3D9x6AmC4oyyZMR5Jlo99Kz6+Mw1kz4utW9Cro7L03WUMrxpJCZUdmROcBBnrEndgX5nuHkgNdt983yDR/G5u65yG3MSSW/zR9aVW7B5VjsFxPS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m/JOX9UTRsXaVIVrUg+UGCjqv4DvrmI1oBO0DcwUig=;
 b=JRaeg++hAo4iOpuakwdBAP9EubEgrohdEz0hH9Gey9RoId2rmJUv6FbAbd5xSUJtn7tzeEAYyImg3Sb3LJkhFE37Ump6eofDeAUUA96KweLN8vUZp6oun+GjwWExTa2AsWbtTiV8Dk9g6OZLZYp2B5WS7nJCUL19UbTACSETgkGn19c8l22Qqo4FYOkUMkPuEBdPuxPPJUiJItpPr5czgPWRh5SKWNWOtos1h9/C5iO6FUYQ4lxKx91dh9EFd80nuBEuua5fBJaaYrtE6+QiPqYopZvj4utx1lhm1GxjcRJSPcSeEgNEVcclIewdAFqpWd3R6iPgAp846pDPk2e0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m/JOX9UTRsXaVIVrUg+UGCjqv4DvrmI1oBO0DcwUig=;
 b=RDLVX12RF5lNX/bG1E54HVqig2Aj/dfYA+GKamohZov65c62FFkG8DrWgxMsW7Qq43DSZcqWaKndz7YMJ3Ww8aN+QUIlB7guA/k7rDPySPRE7/0F5mANHpXec87a5OdXAMQhS3uHLqyzFLzFLlCWqH32p7rAG8KGKMtqRdX25Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB7173.eurprd04.prod.outlook.com (2603:10a6:20b:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 23:00:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 23:00:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     Thinh.Nguyen@synopsys.com, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, imx@lists.linux.dev, jgilab@gmail.com,
        jun.li@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, peter.chen@kernel.org,
        quic_eserrao@quicinc.com, quic_prashk@quicinc.com,
        r-gunasekaran@ti.com, rogerq@kernel.org
Subject: [PATCH v2 1/2] usb: gadget: call usb_gadget_check_config() to verify UDC capability
Date:   Fri,  7 Jul 2023 19:00:14 -0400
Message-Id: <20230707230015.494999-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 79315378-7157-41de-f150-08db7f3df921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFG45xV3dSKzVSGvgpefeL6EmyS1eqNtDj7BhjUgsFbfDBNgi4QaSJWJrUp3fLQ2/0G0v1JDgko2dhBaZadqQNPrg7xTbUX/lSd/C7rTqg4eeT/YjhIGkpHa9hYPd2FhKSD6m1boqR8ODASqPev9y9OkL2VCnW87MJZoyJudVFmbX2pRAQpCIVDsVfT7m3OLvrx0EYa2i8P8m4l34+FZKzkxnYl/YOzBxoszL1S/kxjsx0mQeqF5+YKYqPx0iVD+h1szF4rXx7uDFmG9h3cTmzsa98LRdVmK1brBePugPpU/c2fGiHyLQppfTpGnvjnnf4VYApYITygdu0emP1Co3KxBcn0c02fvs4+ObBNj4wxcia8NfudNuvMQB/0Cq4mVhsPKVvGaoOkFTquxGZqr/zPW6wEtfSTjV8BG8pvG8EbwxQiEHCPgUuKiCHcNQUAB3FWPu1K//vjmIONCGEko7CfUgfHRZE9c+8zGN3DYYZtKxoCiS6QwWdRGux8MIDPUv2nZ9soURAR7qfrLcvuvNUJvnG6qiQfr0N1LHnYv5nN/mpLVQme5afO16Kt86Qm62x0UND/95DXT07cPW3+wIkWScn2ODBJalNsYZ59ycVOl1sW02eW8MXpDsbo7CtCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(52116002)(6486002)(6666004)(478600001)(37006003)(36756003)(86362001)(2616005)(2906002)(1076003)(26005)(6506007)(186003)(6512007)(38350700002)(66946007)(38100700002)(4326008)(66556008)(41300700001)(316002)(8676002)(5660300002)(66476007)(34206002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?semQpYiZJG6JUP+wirbT3mqZsFEtCIlJVvmqaOD1MBTyFhtVdtRkF2iHiAs+?=
 =?us-ascii?Q?+pCGjttSow76hiiarfhRDzD1XkwPqbzgqK6PGNtTAEhkGHYf0j6YE0cxpmps?=
 =?us-ascii?Q?WRGnkUrTA4rqaUvkXAwqkVZp+LpGmQB+mt2GPAkuyT/QEKtOM+CDREKSOuwP?=
 =?us-ascii?Q?AuvUj8h8cMfIkzOrZ2bG106zNBEEfyO1RlmxogU1sXPJwh3edUbw7DsKffqM?=
 =?us-ascii?Q?DCNWrEQv1uSjPAwBUUxIqannaDKLdbNMK3DmrMGDU26O34yTjiaki4Gc0kSA?=
 =?us-ascii?Q?EbqeKoky8RIiZC6GKkhFXZSkBt724TLRtcxgHf8QsCS0dbPr/GmPsOMJ8nE+?=
 =?us-ascii?Q?LIYfMDiApJbDVF35TK1cvhhapsqAKCVi4bx434zj50aSW7t1B+74XF1Kn7pO?=
 =?us-ascii?Q?gpJ4qeHPUmcyt7ai4QBT862iNuVSOzHU+zdheztc1gfyfIdLqN2aOkTqv1na?=
 =?us-ascii?Q?RYdf1/dj/nfBUsywpambkVZEci0DZ3N6tQYPeJTRc1kCqwIglyvkZxHJwccG?=
 =?us-ascii?Q?Djt3tBgueyEG35EqylcvVKQXB+I28gF/5ywJfVMlUfVBynD8uIpSsRCv3hQa?=
 =?us-ascii?Q?wucxJjZ4karJWWHKYgogoAfpImO6NxCQ98GO69Lj4hMCaksLtVvrE56JL1UA?=
 =?us-ascii?Q?Ceyl8ASFz1HyL/JUuvnqPIaq+/W6QSl82s+7yvUkqXvw9lZKlxQUMVC+bDqI?=
 =?us-ascii?Q?+nBBT31LscnaHk/fPcMNM4qYIxKFgDbu47ouQPLzd3OiDGz6JfyfBsnfWkfa?=
 =?us-ascii?Q?8Qgz5UgG458qXP2o2cPE8ICiNBetbPJq8lJdOBIev4Ac3GKsDMetP0j5NRJL?=
 =?us-ascii?Q?O6B7HmwLM65QmA2PlwuB3ZENeuRxbvpkAJlBhGQQuM+qyyx2MspetbcP9P4U?=
 =?us-ascii?Q?Xa5tK9jBPDV2IMM/xzQbL6u2mDvJQQHtfRAYEpSPx9/vvEGuKTz5unCuoG/K?=
 =?us-ascii?Q?YYvVtywEHeGf+HSAAN520axAftaTUb1X4PPNd8blMTCUCjadxwDS1IdPn1Et?=
 =?us-ascii?Q?J8tOisD/zw96m4yQlX03sXItphXP8e5pWraWJ3qtp8ohgSc68DgIm+E7keqD?=
 =?us-ascii?Q?32lvSSBolDVvw6plQ4P+vDMbbHBdsJSWZCcyMEi+ph/JLPM5mtWRKGIz/5tq?=
 =?us-ascii?Q?mU5fKrX9V1l5IoVX/m1RRkenwG42JEdpCnbqI7kajZYrr0JsdEclxw5iK4fQ?=
 =?us-ascii?Q?oPNAFyQOWp1/The/yJlqhxL6z1hGshbDdUMMAt4ibXj3XNBw5QHSBP3eI8Sg?=
 =?us-ascii?Q?58cbNLJDX1pOCemKEh5/JnqMM/rVijHH1hW92nxHKWCHTx+s828fO/Sjt4a+?=
 =?us-ascii?Q?VDKdkYh8gCDDA1UmNGDt44X/zEhMBSrA1cDU4XxcyDpsVGO40sr7pHm5Jcsy?=
 =?us-ascii?Q?QroWB9LVkq+ijWUstp6GpgAFho0BTGhIEnNNz2X3NhoHaRvtmNEyUnTDqtGY?=
 =?us-ascii?Q?fbNQwmrMsjIxv/mLR96H17uSrP+C6avVdf+M2fgGs0E+CipOs/XQBlgfDdMB?=
 =?us-ascii?Q?gz/vNjZ8SYW2mKatUj4SUbWoISnRQzoSlqiW8T8tnw/ZfHu1jrtD3Lt7RlUE?=
 =?us-ascii?Q?rHEg2Sm2rCCUv/5GwtjpN7EwxTiItAmvEzEanUkB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79315378-7157-41de-f150-08db7f3df921
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 23:00:35.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2wqiavprwfyVYSMgLG4iVXPoeLPdf0rV0DaaJyeNd+LJmekZkwOk6FilRBZ0MwPMhK13MqdigH3rlwsH7P6kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy gadget driver omitted calling usb_gadget_check_config()
to ensure that the USB device controller (UDC) has adequate resources,
including sufficient endpoint numbers and types, to support the given
configuration.

Previously, usb_add_config() was solely invoked by the legacy gadget
driver. Adds the necessary usb_gadget_check_config() after the bind()
operation to fix the issue.

Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- not change for this patch, just add new patch to fix multi-config case

 drivers/usb/gadget/composite.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 403563c06477..cb0a4e2cdbb7 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1029,6 +1029,10 @@ int usb_add_config(struct usb_composite_dev *cdev,
 		goto done;
 
 	status = bind(config);
+
+	if (status == 0)
+		status = usb_gadget_check_config(cdev->gadget);
+
 	if (status < 0) {
 		while (!list_empty(&config->functions)) {
 			struct usb_function		*f;
-- 
2.34.1

