Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8C7089E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjERUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjERUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:50:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD2D173C;
        Thu, 18 May 2023 13:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSfK7f5w77bj/OORWfx8WOQnThRjMyemf8keoMzB2HG1ZB1vnTeRYN9OGM9/KLGXWjxo3JBypc3atPfm/eJWr06D9BCAFm/x8kOWjSBHDuhMeUPmi2HtSzNUeHSit2jRBZDTUZobC2Ig5CEPfiO0OBJlwkxu/Ws6E3ulXB+tdDKOp7P7bHxrGjfldxai8Z+9pchEtCLj6VOO3libjcbh960ozDcr+c/Xd+8MaRIkZHNaRVB05gr/a+5RX4V+GZ24+17BzV2t7GEkDoUPQZKRuBBi20ZDeeABsH2DMlCnx1oUIuUwcoeAkFHW2g6VVHet9w+xCitog66PiSDe9XdRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrhIzq78ka1yUj1ZVO3iy15nFQsrcVbI3RiA25rPawk=;
 b=aFypHZpuoH9XuOxUHLiwju7jmGxc+uy2IrxJBcfCF7DJNEI6dD3HkkYdIPPvUjdThozhCgqEXbjxqK87KMzfRdMkguDO9fCIk78dMKXg5WgSwdl5HHvOhs8f1ykYmGv0jwhDJTQ+8BMHf7bTEoN27ve1yrdlUVnFnrs+CWPiVzwwtk+zFYWOc4eF1KUW8ZtSYldX/FYD449hO676KyqBZyu9LrvJihVKA38Zs8I9wli3SmIFI4NgrfrGsrzxuxMduObPXxYU5GWyVXggiAOXZ6MEDU5U92IhsfIIVsFMqz3aBAxUnUqx/Ialn/lY/80CZWdWxxBFl55vl280HlaeDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrhIzq78ka1yUj1ZVO3iy15nFQsrcVbI3RiA25rPawk=;
 b=N89v9ZSHy4vH9KivK1UdTsEPoaMHwcGwrUJUpMWsaWCEZYjkqBWR1I/NXTS4j7lxEy+XTVPf18QylZoCipmJbbpkZeeGOkKTeCPZocjLQCKliaawVfWayPZek3+xI7XgvXkd8lAcbEfmI7w9c2d5Uvxzi+LyyhQPt5eqAAU+Jp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8493.eurprd04.prod.outlook.com (2603:10a6:10:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 20:50:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 20:50:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/2] usb: cdns3: improve handling of unaligned address case
Date:   Thu, 18 May 2023 16:49:45 -0400
Message-Id: <20230518204947.3770236-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6752f0cb-9086-4e3f-e0d1-08db57e175c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaoo3Z63Gxe78gN+ED9/5AqrNsw+l1LeXjyXEv0dcG557UNCs+4clxcQPh/Id+LGM2W3DffMSCV0MFz6leK3lU8pHAIjjSF6Pfq5LxpEz+HwIGTST0uHO4SAEdj7k+BerB2798zcdj2TxVqewDqnsfBoDF+M3waIlx518sfpIGrCeu2xArrIUGDlUwDd6OexgN6zQVpv1MI8+7sKLQY8gzBrKdG2hnF94mEFRFU4ZLNvPYFuGwprTk+D6z02TbsfAVByP8jUVKhdFG0NG3S0yWjQvAGoLhwVFcPnMyM4BV6xpBx3PCPgr529sFvLYbJ76/DE3m1Md4sXjp7Y8E1f2V6Hw2b4gRBcWh56dpuWu+kArAWJnl0C1Lef5YucKPFCR/X6gM1GwiIY2r+yvW9dnCg4zT8VwxDGgsm5vcbLQFiALvZdp9THaR+vXWaBgZG6xGvF09xffLxtab8kFSd83n5XHX959DfI1IY8hX1nXmFuES5Tix5RTqabliJn2QVYJ/YvL5DI1pe8//F1qARCvzl/mlheNwjm9QP3vwR6zuOzAq1M0wBCWvAZc7MISF/V1DZB3iZs7DqaGBCeTIMs+lQ/mjaUQXJXowkrvqd2aGMxihvyKxDg+yuBEwz/Cmvy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(110136005)(66476007)(4326008)(66946007)(52116002)(316002)(66556008)(478600001)(86362001)(36756003)(83380400001)(1076003)(6506007)(6512007)(186003)(26005)(2906002)(8676002)(2616005)(6666004)(8936002)(5660300002)(41300700001)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nnyw8wQL9qmFnUP4x9nn+S6yTR8r2EAx4vNU6coEbin7/yAS4KZbis27PvVq?=
 =?us-ascii?Q?H2hXhs1GQGj3R1vlmjuYH6Yc/t6VsmPm4NRrPJ5X/S6aoyiqeNvWqIYVFa2W?=
 =?us-ascii?Q?TK6HmCiMpy/cKP6Tp1/oDUDjdJiV2KhrR1zvzpTWYPcbh+COGGQFthdIB3jq?=
 =?us-ascii?Q?A1R2G1fMgvqwW0ysveBcpAYEiAp1epJk8rnVd4+eY8r5mwlW1Yfca65PFDRa?=
 =?us-ascii?Q?9n6p4W0SK23TQ1ljWDCiGo/farDsP2iYQEhb9tU+4yT4y5MSqQC2vuA5QKOy?=
 =?us-ascii?Q?F9pVqaBOK/sLzVlFHC54F2mA3WsX1BBLL1GfOk/cBX4c5ZGtDnPf/Xks/siK?=
 =?us-ascii?Q?4GhYglXwnJDkKHcn9zNL99/mndruA/vd8PZ1svnU248SRkmz5HHwxrBixs0e?=
 =?us-ascii?Q?8J6RbXpyDJMcA9PA3+5edlTL4VuziLDqsVJmFMela/CKzR/48rPW9w1fsN7p?=
 =?us-ascii?Q?ntBH0q9HyjgPHiADty2pYFAFaIxvTjwCvMAMFm7Ix0pQzLw56qwiii9yv9B9?=
 =?us-ascii?Q?gJ8nHKMhRaY7T3ABUvSSkhfHb0oGeKmimhbzDA3QDRn8tmum89of/lRoujYA?=
 =?us-ascii?Q?DSdddFXkEGNpDR6c/y8dwN8pDSXAj7xaBE6+MVHYzfd9k4680tuY0ePVuEjx?=
 =?us-ascii?Q?zlgl1dr9eoP7mfRIzIO3uWs0EJHkP+thpkwZYaym1Pwc99M5IxcC9Fl3RaMD?=
 =?us-ascii?Q?JztQFCc6g4YEFGwaNv8R6s9GncjCqXx11+p0v6yyQNPEU64xpO1PKSUlxXQI?=
 =?us-ascii?Q?pg5KN0e9LGXT9LBjGAzXuQ2sVQv8k0Vri4kMmJ5KyWFSUIBZZwUr5a6mgvBS?=
 =?us-ascii?Q?/RDvlbz7NNInN2ED/azcjna3ntwhfDkwmq1hPJZeoHYuxrezLkW4mmbXM3uc?=
 =?us-ascii?Q?+ugUSqQMvXq+YQ3VdrYS2aEMdfBpTtKQfaUK4ufUGKfkOyDdMh1eiwYm3A9b?=
 =?us-ascii?Q?8R+VV1plwUWGR08iWeEpfUI2sevLUU+NGim/Un4DZ5duf6YgGFy7mTBSOuHu?=
 =?us-ascii?Q?//kJx+TbWosCqVzNauxgDePqrxi4PqL/cDYnMMg4nOd8QnVhqbY3sqhObzON?=
 =?us-ascii?Q?ehkz5Y3LEsyH/jE1419GfPC1SZB/gMWaqdcf/uusRewHxR5HzznnBCv+Sz59?=
 =?us-ascii?Q?g4ToubQd/N+A8NsBB1N+cl3s4xEtPQ0Rq6GAO2Fh17/eBKbk/xQWOMFm5g0l?=
 =?us-ascii?Q?uGNCBmmlkxC8/9YmEQDgpp6yfltCvHmtEl8g5PrtahDW28epKMlqZrk7lVFu?=
 =?us-ascii?Q?9+dPkhCL3rvAB0yfxwuFXPkhZuF/yQ9/RD3jPIr+EFXX07cq+Cjt8KjKSEYx?=
 =?us-ascii?Q?bNtkvAlSFeBWF1iDS0HJhRqeODamBpiwec4aIU8EvYzJp79f9DxxNDxCWa8q?=
 =?us-ascii?Q?yWPWUqiGEApngNCYYDXiLnE1SzA9sPdv30qjabuQfh4ciCyApVVOzEe+Y8hp?=
 =?us-ascii?Q?D+H0jbgvu0o+F+ooyNZIhqaaORRuoYivINsHqNh3UyRCgbSa81wfgn/50Omk?=
 =?us-ascii?Q?8IPQGkVP3W/PGrLOuJ1jbrF1BZ8V9foPbMVCsx12vhs/vcOq+NRFw0GzkcMh?=
 =?us-ascii?Q?co8kjGjUYpL2QsnmWns=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6752f0cb-9086-4e3f-e0d1-08db57e175c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:50:05.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR8QLVpBZe8oPmYqBGefso2371eEmw/jzRidje+r52r6NXSch8sGLiMKLEUTTSF8CvDtim+5U/blgKMNfIEsww==
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

When the address of a request was not aligned with an 8-byte boundary, the
USB DMA was unable to process it, necessitating the use of an internal
bounce buffer.

In these cases, the request->buf had to be copied to/from this bounce
buffer. However, if this unaligned address scenario arises, it is
unnecessary to perform heavy cache maintenance operations like
usb_gadget_map(unmap)_request_by_dev() on the request->buf, as the DMA
does not utilize it at all. it can be skipped at this case.

iperf3 tests on the rndis case:

Transmit speed (TX): Improved from 299Mbps to 440Mbps
Receive speed (RX): Improved from 290Mbps to 500Mbps

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1dcadef933e3..09a0882a4e97 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -800,7 +800,8 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 	if (request->status == -EINPROGRESS)
 		request->status = status;
 
-	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
+	if (likely(!(priv_req->flags & REQUEST_UNALIGNED)))
+		usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
 					priv_ep->dir);
 
 	if ((priv_req->flags & REQUEST_UNALIGNED) &&
@@ -2543,10 +2544,12 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 	if (ret < 0)
 		return ret;
 
-	ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
+	if (likely(!(priv_req->flags & REQUEST_UNALIGNED))) {
+		ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
 					    usb_endpoint_dir_in(ep->desc));
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	list_add_tail(&request->list, &priv_ep->deferred_req_list);
 
-- 
2.34.1

