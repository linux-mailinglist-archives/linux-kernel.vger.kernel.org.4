Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D27089E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjERUvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjERUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:51:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BD7171F;
        Thu, 18 May 2023 13:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7xpvvtokkMsT9m0uStMUoMTUh33Bzop+ylsn65a4GMX04FU5oxbDjfGV+qRVehD6iANrDKhctq8cxelnK/7viGY93d/rXvuSX2c1fGHi9ilPGXgYor8duwWv9O8efnbwCro9PyKpBr29FCM5DBSQr1g+Xt1NnctbHNwPWlFcx9BgH2pozNqXwNeuNnBUyjiqD6S9lwVZb/kK9ig5vybmgOw32i1Y5euQp4cQXd4bulXInxrryl/phG12do8LkJxQSbDx8LpIy2lECvfg+3seCLQz5j6svZC3EyhAI0avGY+SQlLkjLHWnnaRy7owtRJi0ciqXFas/Gk07GeIoq0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrbGwBi3y5La9AdH8NwmvRP69reNLtNcsb/1Qy6ETwg=;
 b=V0RgNwVdutOBHbvho5jTHG7AhO89LLXMVd+ah5FFxVS84P2CJwsl0xkawj3xwkw1rh4Q8q9xhgbXmgH+BBW1UssM9aGHRVCcEJg1n/KkQavMlniPoPQZlvimBtv9E6senD+oPyKVLw0Hd6bm2/wuSTHwgY+eaCLBA5kRyqcgcCUZqU//Ntu0wSMA3rXwKwkx5c7+RgnSV4KdhdjVnkdSJBZh7s6SyBn0nvpEu3PN5pyfLt0FQEQ5gWUBWiQD5WxSoETAOI3deESXqnC76PdxD9LuZ/BanTzD9s/kU7BYdbukyVAOdFNhhZk+VJqjcknmU3KxhHBhDDMlVgNU2Y5iAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrbGwBi3y5La9AdH8NwmvRP69reNLtNcsb/1Qy6ETwg=;
 b=AcXqw5qyphZYO62oZKUSRxXAIwqknkfOFHS7QYQR053RmXh7Cc4uS3frEqECagSqylBkOwfHicJnYfR8ZxaV7joUK9Ql/7vvfZaXh8L6c2JxUPksMh7OxkSsjkGJXmvWA3Vwd0JAftibP8XgCpkPthILzsoV0RvtXKlCdb2QAbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8493.eurprd04.prod.outlook.com (2603:10a6:10:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 20:50:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 20:50:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 2/2] usb: cdns3: optimize OUT transfer by copying only actual received data
Date:   Thu, 18 May 2023 16:49:46 -0400
Message-Id: <20230518204947.3770236-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518204947.3770236-1-Frank.Li@nxp.com>
References: <20230518204947.3770236-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa8cf26-6237-4324-78d9-08db57e1774d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siGy6BHWr2g9NvMXjPApdapllweWpf9GAutGksVlLXK6OcxY30CmdPyn8kXP9MpE+1WULuXRQlRqqpU61AM+K6zyoXcB2i/CxOSdlvMVsVVur2JsjyC1MVmitdlsVjsJBM+Tsq9YX0qvekWBONJuTXZ0aSdW33eAR8Q1CjsQwPpgfBoW4q9QwCbpq/1iDNhN6O6GEZJ1eHXiTbScY/25yc74r54BzQ01rVn2O//5ZQkce+2oZNKMGIuGkjZ5oFnzzBgyCbnnW68PmgLfRdGuXsbpVp8JiSjhN6zruR7F/lObL35GFvWhheGfu1fXnUSS0zvq6wmfKlVbFvD7U2p9qx4lsc8ukz6bMOnCw80SKpv6S5FkSKIElUjCL8uhg2gFPwoNTel84MaONkOxCOrJRRLuaya386ENZHWAhSZdEajtj21djLqXwzqlDDkmr2jg+eOQ0DamKjHWlpivoxGgKM/GvvRPVkOiBnQbl9Emi0KHGdFQZ121w8pXuLSsMMUTPiL2v4G7Zm3DCQtzl/9uGJQ56GzEmhyGSbEnVGuEbF87cH6L28kvLec6qz3qM6ZhlmU7Gg+dxhYByyIOtHdmgijq/80AG/paZHWrrFhvDMZ5mA6zuEUZ/P82AlxyClIj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(110136005)(66476007)(4326008)(66946007)(52116002)(316002)(66556008)(478600001)(86362001)(36756003)(83380400001)(1076003)(6506007)(6512007)(186003)(26005)(2906002)(8676002)(2616005)(6666004)(8936002)(4744005)(5660300002)(41300700001)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgciEXco+u6x4MmN/LfqcUvXtmSnIH/+AzaRR3AcuuBoZ8mXj+g3IO4JTKq0?=
 =?us-ascii?Q?wgKQECO8RUovfYJ4DqdIsMdRSGP0FSr1tM03DvLHwJ/8FUTZoIr39CxM13u9?=
 =?us-ascii?Q?cx+RzpSwVuOwqFE4WLjQagGKplRrzD0Si61avluKWRJm7d2DDSPoFLOkyrc8?=
 =?us-ascii?Q?kzOVnioAIbuEbPPnoGTHK04Ko+K74+YMrkEU+uU2fEYQAxw8+B7LKrZ4q35X?=
 =?us-ascii?Q?OeTFE83vyYeO+hthQ1LA23eOQT6InL/K5pnL+dhg8RYiCf79D08Ad31mv20r?=
 =?us-ascii?Q?gATMWrDKYcxEj2fvo4kOG/f0ekWoR18n55vM/lkaXO9ck31CQG/wwu3Gvv7y?=
 =?us-ascii?Q?M2EW9XD3gs0DwMpR2YjsAYeLdGTN6yfHxd0L+rv7tEVB/sYcRUIkHKSpdMu6?=
 =?us-ascii?Q?Y/0pA8ppi1AjcvIKj4hzgCYxuFqaa4Fd0i19Kfo66VP22oMgF82taDJ5XmCS?=
 =?us-ascii?Q?BJZ6qb5hU5+diwC1lyJZ9Wq4fy65AnQP8jz5AeYgiNcOuZMboxG+vjTdeJJb?=
 =?us-ascii?Q?rDJXGPjcKyExnodVsSUFEzAeCWEWPFyYdL8Fki9S2jjanSjj9Wk7nxMcGfLO?=
 =?us-ascii?Q?j3u1wU/DI3y9Z3qeG1KLRn+pKdI83AKPT8IeX6lnV/kao7C3speLmbsc1PvS?=
 =?us-ascii?Q?u28QhvBpS0vd2IePqpcKbrW9wGYNl+3Amx4hDOylySaC+fEvMxnZNbjy+Qp0?=
 =?us-ascii?Q?oIaXAIJKgX5s74RKSKVxvY8TjV+Ilq4senNsk6c66x4l62TEf24jqI63M9s7?=
 =?us-ascii?Q?pkYzhZeNzp4s2V71fFab+7BgFnt7h5BO2FYIeWGLsbfx+QsSwoX0B3veXidC?=
 =?us-ascii?Q?O/tQLGAE15pha+OvmVB2vTr0Lb6QgxJJXMD5vLAUO0LjIg+gA5nI79tKEZn9?=
 =?us-ascii?Q?I2Cy9C5mccKbdNXL2hIB8n5VpaxCjkNpGy1NHED8x0TEAIRDUw5HGS7wE9Bk?=
 =?us-ascii?Q?YxCRxdEp1SxQfuKUtw+FpqJ/FnJJP1YbSMg/A4xoSKosP4jJlYhU0BvFgGxs?=
 =?us-ascii?Q?zqMtBgIXjBOJU8MGqWON8LxwQXsKOIEAmz/wDq+/Z963TlOjuHsQwlB0I6fC?=
 =?us-ascii?Q?XcnoDcmYUTycj5Tz8acLv3T4Qbp00LBItMAH5ykNjOIUvpreDgCTfZn5GmSh?=
 =?us-ascii?Q?2Rd3S9BIAii6lV2RIWMZo1kxVuI4pBTe4RdvIzvrLBFpt9AfOtIOSrcwIen1?=
 =?us-ascii?Q?W9nZoCNzfrb8Z11ksExnzOFL0186OGcponuEfUgeRNsWkJJZi9oghP07E5Us?=
 =?us-ascii?Q?PUAl5Ra/6j33PjCSAcce35PpZg1uabUx4ukGAshOfltp1iV9B8uozexNYfZM?=
 =?us-ascii?Q?nDfI0x9tYGGIsKOP5+8rlOiAnkpP/YstY2wEDYSOhHBrb4YUrq5tEl5tOoCs?=
 =?us-ascii?Q?LpYFnvm2Z9MOyiteYL/5c7nLAz8fVOBJcSoITd7W0wO0OLvaUhH0kfQqvMOx?=
 =?us-ascii?Q?I7cwq17B9fYpOTeJiowsjeH34aS9DEiVtOp+UpHonjb4tDTJ8bkR/nMaVwyR?=
 =?us-ascii?Q?AfcwV039rdMv9pG3/aQ5h4YdfDt4dlKJfvJGa1ULTlmaJqN9RkzTXZTDauJC?=
 =?us-ascii?Q?GrcTGh1ZVEbq22dtsL4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa8cf26-6237-4324-78d9-08db57e1774d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:50:08.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMwivOhbEMb1zFVNSAkowk1QSCpKRGzc/MyV/yVict+Ka/JhcK7LKMkI2CjEiN7YDY/YqdlGhpMIjf2ros49vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the entire length of the request, which is equal to or greater
than the actual data, was dma synced and memcpy when using the bounce
buffer. Actually only the actual data indicated by request->actual need be
synced and copied.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 09a0882a4e97..ea19253fd2d0 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -809,10 +809,10 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 		/* Make DMA buffer CPU accessible */
 		dma_sync_single_for_cpu(priv_dev->sysdev,
 			priv_req->aligned_buf->dma,
-			priv_req->aligned_buf->size,
+			request->actual,
 			priv_req->aligned_buf->dir);
 		memcpy(request->buf, priv_req->aligned_buf->buf,
-		       request->length);
+		       request->actual);
 	}
 
 	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
-- 
2.34.1

