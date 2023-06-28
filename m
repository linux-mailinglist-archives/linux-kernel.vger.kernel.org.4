Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA252741BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjF1WZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:25:00 -0400
Received: from mail-db5eur02on2071.outbound.protection.outlook.com ([40.107.249.71]:3265
        "EHLO EUR02-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231300AbjF1WY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:24:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpwnuLpMD0v3APyu5jzeBFW4z9wFlw1HXLusPrtL+u34Omhi3J7EF6cZISBmMVTt9yF/pFTDe8Q7N4ksIrgZhxo7H+Lb3p+tBseYCY4ChRDB+3jVrUkf3TDiNZQRBXFR/zyzttt6q4F/RbbWyHUG4ok4CdEdPEg5B4x0x8IO7opaLOIUeBm5JiElojw1ihQfHeknJhzqYQmPGePKqiC5Jf3twNjlucVTqE6toYC4B69Q/jfhFChe91WzX3MwoMuxr1O0+WlTor7XuFcfvjBABoRfBSo23O+o2Ad04HxfKQfbMwPUf9mVRdR7Uf4AkLVGXrlwjoyFXJkGIrvV6CIslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9MJqgXQBKH9p6GXj7nxHl/BRBNIsFl4yA15DxmnC7Q=;
 b=Eah04OFZXS7t+7SzgSyi/WNkELY/dKWywVJ8ryNQSSIth8+qtOqTsj4UHeB+W1O5maHiiP2TjjMDZV/XpeGH7IyXPeUf7ZzYz+KtMol6iG+Bj6aObvFh2HLVEv3Oe5WBg/M3M69g88wmfX4ssraj9Q3j3AMN9LX5eibDGc5tXN9rqcHcq8gbr30fnt0xMRHspaUi00tZ6NXXasDLxhdrMuvVcUNVmcjLEOFibcGbedb45a7ugHKYe/f+sJJvhdWb4Lp0cRnqOKGWNvJu3FKK9WP4oP4l4UO2DEQgKbfE4Qf647OTFcgHflRAO0IOl71L4mjo6fzhPSHBLimlYUrHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9MJqgXQBKH9p6GXj7nxHl/BRBNIsFl4yA15DxmnC7Q=;
 b=EpYEd/azGYEoOeOAT4yp3nB62n6XaiX44eAh3Q5j5cH3tTpPhXMUUsEb37lk1H0byptjb3D83Y5Ng+yg4bKLdAHo/QIpNxiwMCqKGS3a+U4KQXiBxCS8IUBLghCxmqn2rhDo/rvPV9wLiQrP33rBwDj6nLrjZbOYrJxcRdgetb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9978.eurprd04.prod.outlook.com (2603:10a6:800:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 22:24:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 22:24:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     rogerq@kernel.org, r-gunasekaran@ti.com, imx@lists.linux.dev,
        jun.li@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] usb: gadget: call usb_gadget_check_config() to verify UDC capability
Date:   Wed, 28 Jun 2023 18:24:36 -0400
Message-Id: <20230628222437.3188441-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: 86813297-e0c0-4536-4c10-08db78267ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0XUWOr+MXgUFfX0TvTs5FsOl3TUVevWSTFef5zZPsjL5fZZwruDitAA8iI3BOvbCVu1+sNHigCxtzmZyFGt+iB5bo/ltzWg0kw2snEeJOqhqZoHtbPX9OhJEsp0m+BtZpWK3pUMFUiPTTMP0JlqIDVGWkK7IirV/wrfLjVARgCYSiUjeLfUNL0mei0liELxNXob7MvIV0mwDE+X4tr/SLS9JQW4+FemQdvMRoN8G/K0+qg5iAxaQ+lvMbuDbc70R/SpHLIbPvhom3eij62HxWIKodLGG5oQlZFmSxAGI1S+4rtQ9IQxNNW+058b9SdMkbtqavF3c6132UnPGqJjjWoblVjws+TzHQkVPeE2au8F6dRA0azSuufPwyt/0HyeBKVHZVdkdabBb7R7juEJCWZLqT+K/x+EUwfKYnuh112J7OOkus2EEP5A6RA9wG5ajTZSUSLnErQ0xZ4izChknVOwbsBV73Q9VsK1gDnWyL6OgwBaTN/w06OqrCog7O3dpod/viq3PszIB0V4eJ5AxfHp1TV+DnOyCXDlisazjdNo974GNNFAt3oMsU8q4vqOWF3CmRDrK34jtHq1K8H7NdjHxsH0VYW5TmP7lRSQ6b3iypmbopRWsc8RRCyrfuYgSC3BASzqUctZhbNL9lo6RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(6512007)(26005)(2906002)(86362001)(6666004)(6486002)(52116002)(38100700002)(38350700002)(2616005)(921005)(186003)(110136005)(41300700001)(478600001)(36756003)(66946007)(66556008)(316002)(66476007)(1076003)(7416002)(6506007)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CjRP3YKvVtgHap+HKFnHf54MYC8YXKstCa8na02Kvl/g7OhiqKtgMhUawCUN?=
 =?us-ascii?Q?1OtXG1yjNnvZfHt5IpM+C4hLH5XxotAkeNpWEHsU09zFB7ybMFjVvOctGfXs?=
 =?us-ascii?Q?yoCkgIVjG5UIXuDg/7Y0s0MoWeJD+yAxhYD5k4Lq+NQ0+fEOkW3pjC5C0J2U?=
 =?us-ascii?Q?NZ6Gz+gCK1nrW4wibXMrgfXD2QUD+nqPU4UgjROqxQd2/GBWTYZ+tzDhcYHx?=
 =?us-ascii?Q?1A0RDVx+bUlmLi1e+6wgTABSk1EgHT9uX663nHIeBzgrSPoRLfqKBA8xaVY1?=
 =?us-ascii?Q?Rby6akJ/29tTbSPf2Bzcb8V3N7KQVPWKiPT6JtC3xteQIPhvzWG4Nbk2ITHH?=
 =?us-ascii?Q?KvJXfrPV3aCtNoNQUefKzoygMOG5EBB3g55Dr3l1uR/P3XllS1+uswT8IqVF?=
 =?us-ascii?Q?FMrGVw1Q+qFbTN3RGf+qhCMoZTrP5nMPcesiianmdoh3f+aj4+npp8WdYksB?=
 =?us-ascii?Q?PC13OpqcEkydo0mizvUUpQGE1aEydgeY8JX6l0LorrJo7FLXquGtON3I+LPA?=
 =?us-ascii?Q?29PDwLAs+Nb6q1TWf9BPhWIt00nB+fHv83c/Tvqy/MQKUY0MAUFo6YlZacOD?=
 =?us-ascii?Q?h9vnI9NmlvwahHSrrL8JE0NpeafPhwegwtd2CMpQ8y1So5BH6SFp+LzyOuil?=
 =?us-ascii?Q?pJyOS0xzY4baA5V+BkH6vU8KGzfxssqZRARhtnHTZuHBxeH9SNHlPNQSOikS?=
 =?us-ascii?Q?rIjILTa8gQ72Z3UIQn0aXFPqWweBkA3EnK5+ip4Kq2BKFPo8htzuTdr9PupH?=
 =?us-ascii?Q?oJFt3GBJyljfD1v5X+VYdyg4E8+mn2yRMVWtn3qIBQv77q7ta4ioevLpzYW6?=
 =?us-ascii?Q?APGqbA5AdXwodKpp1T6V2hcuhUnT2spx5k+cqBJ3o9B0gRyjDucfaGBMLSXG?=
 =?us-ascii?Q?lJYev9nDuuWPWelGkifLObEvXAU5UBjHdWc3INljsUmTkv9Q+NVY+hkXFJEv?=
 =?us-ascii?Q?5M/W+f3+VydhUnZpTc3H2KtjSuRmNsRMWhVvOCJcuBxJc173kcuMF3KxMF/1?=
 =?us-ascii?Q?3JNwCtJc+AZLZAkcuUjtm06W4v6HmtxauWAoTyeuXQxxxJFE1FXs2WGBN/ol?=
 =?us-ascii?Q?uVv+hjApCccbi1hslXLNlqSg78x+eaTNO8vX+VMo5rYKQY/XkuU01wTqzq/t?=
 =?us-ascii?Q?YQK7A2ybAzzi8YpnBqm7tuGpNYHv5nAau3I3L6P5ElRT35nkITM7W4FOI/Ok?=
 =?us-ascii?Q?cjc0cVO6pC3HN+xXjqCOBLGO7eqfTP4HcLoaY6nyFkaR8aOO8LxzjRg7PyhU?=
 =?us-ascii?Q?Ep35Bn3ti8qI1Pbj7gJi+9QgWu/+lPg7XOL/UIVpmjs2TvTmVEMPcBCUDeTR?=
 =?us-ascii?Q?TtG/N7N6v7dOH9KZs83Wl2DRA22jugeAk42Zhn5frDV7WMkhYdg5FOs6PMrO?=
 =?us-ascii?Q?Pujtrf2VajQdf8Vj3bNpY53MddifJIXun7Jwom2E8I1WtKfu9QTNj8YVW7z5?=
 =?us-ascii?Q?Z2ln8enbYwlw3GsFFRzgFWzJ+U43X5ZPURlsR+PQf1vgvvK31oUqTVZHJkN7?=
 =?us-ascii?Q?yg4ZUKUi+i33VZABIznovo2oXa53nHUH6ZKgmRAFdJsQQGWFXsgyM5nSKObz?=
 =?us-ascii?Q?Wfc6QEhLYVUsO/56Vurp2of9sCSIqZO/H/KcEQMJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86813297-e0c0-4536-4c10-08db78267ee9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 22:24:53.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFZY3ZKtdaU2SuRmQSalrtmXFH5AqBaHJBUbS3BW65AtuecJfTmP0ghNXsWtdu7K7TdxxLQDIQ+YB/yRuB99LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9978
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
 drivers/usb/gadget/composite.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 1b3489149e5e..dd9b90481b4c 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1125,6 +1125,10 @@ int usb_add_config(struct usb_composite_dev *cdev,
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

