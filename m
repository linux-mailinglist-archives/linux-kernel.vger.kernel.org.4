Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA536650615
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 02:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiLSBjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 20:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLSBi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 20:38:57 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2099.outbound.protection.outlook.com [40.92.53.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B9CCE3;
        Sun, 18 Dec 2022 17:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+dhmzMw5rZKSlcP73WDiirvzB2PRod3bKz1bol0a/sm3sXjMmn9NVdPleTrXIM04bOCSt0uWos5rIUp2YhLCMD9KqC+QTjGbsY5UBfi9njMi0m127DR9B2ULGlMBDTls2hdtbBE4LimY+ApMkNTpVY3hw3qOJFPq58849dDuQ1kO6IvKvdsF2ZFMp7gFGFn9ih7ohhh20UU1PvHIqvKzmVpIjYzGzN2IiV7aYRieRMzvZ15OO0+djh14CH3aJHcKoALd3rkTWOjRA5XEnQFduFAZK9UWpfME47w/vbmciXENKkWrTlmXWS6uBhrI+Z3o4/d0BBBHzi9lxxZjjaALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=208hNVPgK1EJqdsUutYg4l6sJ8iukGbdkQNhfumwvMw=;
 b=l6KVAEVQ4pCip+KZ60vN5HDt4G8LAqUXLJKnbjTsMTL1GxNK01yUknkbECDruEsx74Yj3QIswTIb1D4I8Upjc6W4eq5c4tbq/6y6rx6swp2/py+6JiymznIKN8pknygG7RK8IW7DeC/QCospLjtvoH3scAzt3gD3eNWhFFI5jg8Lo10dyGhVbdz4UwhwaZ5GZPQTFHKQy3/sWp8/9cpM3+GoTsrsxxnC+FyOFj2ddeZC/iQTFq83KfGuaqkekbKtJh0EmozcBpBx+7rE1O0BWDD+vP3ZFPTYaYmYuhzAVturlcb5huAjue9ZeQmWfOH5GZqcrY8hGwA2ZqYG98yxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=208hNVPgK1EJqdsUutYg4l6sJ8iukGbdkQNhfumwvMw=;
 b=pghxIFdGQVlK+jgAoH+9HMsyr76exGEPMSdBoBY5ueoV5P7r9v7rcoFG9Um9BGjdUo0KUsCKtkff5PJ6HPcCQcvMPlz3ey1xm5qA4PtVpe1FfUnIXTDFo9F+tllCnHaIxUSftyYIzi5i6A9BbJAN/LXyJfvN5oM3w+PIwUwqlwQJ4nE0yBOgrqvIWDV9rMNumBA0Fuq/vICG5qeA7pfEo+cLslXwp9Xvzs49ml2LunuKWkFTq9fJxByUK3elOJzuyd7iFdEkJwNu9+zCW+hWymbwEfhPStkXb+mm8Gni9U1qlj56q25/2c/xkM85Vd001aLev24Bz/LCj4ABP/tbLQ==
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com (2603:1096:4:10c::14)
 by SI2PR02MB4604.apcprd02.prod.outlook.com (2603:1096:4:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 01:38:53 +0000
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::f2e:fde9:5455:39cd]) by SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::f2e:fde9:5455:39cd%3]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 01:38:53 +0000
From:   Gongwei Li <lifangpi@hotmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ligongwei@kylinos.cn
Subject: [PATCH V1] usb: Fix typo in comment
Date:   Mon, 19 Dec 2022 09:38:37 +0800
Message-ID: <SI2PR02MB4603295B418781879CE88751DDE59@SI2PR02MB4603.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+pyyDMqLTPNuYLlj/F+iwTlTrb4psX1UI8j6PXQ/v1k=]
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To SI2PR02MB4603.apcprd02.prod.outlook.com
 (2603:1096:4:10c::14)
X-Microsoft-Original-Message-ID: <20221219013837.241942-1-lifangpi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB4603:EE_|SI2PR02MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: a66a8cbf-12f4-445c-666a-08dae161c921
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gnZn57HIPAroG0ttQq96EOI/EDSkKV31HL3jvZzmAlmVzlSexl4JDo/Q55sNkJF4KerqirCJ0hdfZKQnAW9mbXFIEKrZBc7NoCc2oGwZHgPb1+D9pok6pnvhtMaD7sykQUmQOcxl3DBH2Ct7hDtMB1I+qch6DAFcDetRroQPDrbQeVGHXvKsRPTZ3iF+69PuUN7dewqS3mZuawe1TqG05yX+VqQIafl1vMgbaE9m8ONht11gqkclKdURstd7/4oJFgNNdVEdEhIvP9LMRFiPJltaxn2XN/MdPdCPH27BU6Utasan9m3F6gLwGBDSMU/xlERllXAP1Ag71F9uQawC0TvPUCsoKHh3e5f0QiZLbD830geW9yrTb0BT3HXzEnZXeynh+cCAO/wb+SqnJReHHVb5Kch4Ox1N2XdUl4tOMnL/pGndvxR26AEm1y1f8Q4aoJja/QxOk/wbw8dLMJHpOPCsyloukRR7cBqknvl9ObbkpAwOoozbMHjsAZfSp71Q5uO5v6bDqn3yscONU5EKa8ecnCFiXdilFO/QPSih2OGsTRTfQ/0BPW9ru1d+cgB1xlGafXoEJApfR5DKRvxaMEUfZM2fhW/7R6VnXbZ23Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0eIKsqF5MWXLKrfZYmI5dPVjEoXhk+08WB95ETxaATxXyfs//1RQHJkPZMs?=
 =?us-ascii?Q?FTZ4I+6WANJ/KvmOjWbGy6tamkWDDXVlvpBDp31ksnh982UkqiBYaO7azcuh?=
 =?us-ascii?Q?C6P6HXk2ttB+NpzkGiGxOztfMMe0pLNvDSeFu609v+MRBsGNYXZYsnT47i06?=
 =?us-ascii?Q?PkTE4T1z1dLK8S8MYZ+pwbWVTwuZ8x/9qI9uCZETBvPgo/+ReOATlvDmO+qM?=
 =?us-ascii?Q?ILMmC9hCGg3di0ypDZubGcZj11ZJw8DjZrznN5Z+9LetTF2e5itRA4WKFegi?=
 =?us-ascii?Q?1cSjSbZ2A7EgHSloRPCg8Wc1Wv9y0fsftNoFuOtGxImR/06aqO1VbUgei9Sm?=
 =?us-ascii?Q?6KE3GobJWFZEZH7ACxONY+Yhm7hRVw1k6yxpxCrUhqTuZToQjZwtlWKEwiC7?=
 =?us-ascii?Q?jYuwMxZMR7tQzAeav23b1aAMM2tyVOsSLbnsNLCnzHzmOatHpCukqh5aYDyh?=
 =?us-ascii?Q?qw9LsKLqOps7S8kVEwsvfjcq0zetGplj6doJPVUlIvs1gINf90H+7UazaEmT?=
 =?us-ascii?Q?v8Q5xDMSbnQ1qhZoq+cOdE4lOn9+APW0fE0kdJI6sbkKw+RBA4ZIo3QdnxT5?=
 =?us-ascii?Q?QU1M4PjoWl6OEpiIl3TULOYcf7h9oqlsi5ieJW605qeFl6y3FJlTqML2uZVh?=
 =?us-ascii?Q?J8cdImq2f3L/8mUDtxtFchtJd/lIJjtjOIWu3+rU4w/wVlL8T6rpuNEAmXzJ?=
 =?us-ascii?Q?AcFaYfMW50fxW2cMJgKx3rRI0fDD/fDrbeYb8MSm70+coQQZBv1MP8c2y0Im?=
 =?us-ascii?Q?+myC+eMYqxdhG+PyNNjo7QQAHxOr14sTAF+PHGsthoZY8dpmPLFgrYE1AMun?=
 =?us-ascii?Q?5NNW6pSR4g7C6gbn9qbnmcp0COXIkjFUz2mfh16bTV+bqyA8Wqbr7FdU3JUK?=
 =?us-ascii?Q?hv3cC7T8OTx1beUCfe7I48tuDFly1W/rhtsQJQmaSCyfdYEyO1KsqVTCAa1w?=
 =?us-ascii?Q?/8zJxRMggqsi5MAgxO2gofbTqQbCAFTQOXtDPXxTSYvfPElmkSBMoQOnjwFf?=
 =?us-ascii?Q?dSr4UqGuzhfEwPWD/v7PgJSe+eYcsf0NXYEtEJJa+Ftiisxi7XyLftgtfK8j?=
 =?us-ascii?Q?oPNZKsdm/mva82IbiJgXfDsOQCnfzrv2fVwowzGsYFI9QOasEf7GJoqqYUTa?=
 =?us-ascii?Q?SkHGUigV/uEG/7wd7awuQEKe8eLPAzG5olaGtpMpnf0HglUnuQdLGOmuxzk/?=
 =?us-ascii?Q?dkJ1BStj3zfvbcAibLtdcopwaGO38AZJcCoXJneFX5CoqZOoeBPM7AaDLeCn?=
 =?us-ascii?Q?falwlXiQxKa6l2+qhQGzwfmKW/frLFm29EOIoslhjw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a66a8cbf-12f4-445c-666a-08dae161c921
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB4603.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 01:38:53.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB4604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gongwei Li <ligongwei@kylinos.cn>

Spelling mistake in comment.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/usb/host/pci-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ef08d68b9714..9710425e69aa 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1103,10 +1103,10 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev)
 	pci_read_config_dword(xhci_pdev, USB_INTEL_USB2PRM,
 			&ports_available);
 
-	dev_dbg(&xhci_pdev->dev, "Configurable USB 2.0 ports to hand over to xCHI: 0x%x\n",
+	dev_dbg(&xhci_pdev->dev, "Configurable USB 2.0 ports to hand over to xHCI: 0x%x\n",
 			ports_available);
 
-	/* Write XUSB2PR, the xHC USB 2.0 Port Routing Register, to
+	/* Write XUSB2PR, the xHCI USB 2.0 Port Routing Register, to
 	 * switch the USB 2.0 power and data lines over to the xHCI
 	 * host.
 	 */
-- 
2.25.1

