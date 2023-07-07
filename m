Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9B74B9C5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjGGXAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGGXAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:00:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968791999;
        Fri,  7 Jul 2023 16:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G02zxqQVak+CMbwDqS4TWtkNHEzi3zjZ3nD7UXVAjZmKGWVfMMB/lycNxcrnDhUDR0D+Oxjstsd6W3qDOTxuXurC00SIHy4eRCLp9bNXxf9HwLxYQ68tFra3lz89IlL2b/D3jjPZTovdkdWtdgcNpDTb6cUDpwkiqcyh8bjyFjDUwPqm9LE+KyqArMUcLUv55Y29hd2uZx/sSC/qM1KNoJzVqQrEie634wpBgM5bu12R5KHIKfRwMD7bTuV76I1KfjuvdPm8Y48dRZo9ZDZYPNw+PV3DQBTeAzgvvU3outTMHWYotL4qRlVrThC6OOERPksbNVXYJAN1fP6Fh7Lb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1xaghyF4uVbDNLXugxeL0vl/6ekE40Im93VVeTP0gU=;
 b=gSDerZs1D7GsikLVekNIb3i9bBl4sJvhe4UDN/IAhUwzloaxUbQIYp7LZQDwXeK7G4GYwIoWwAIKh5QDO1cvoDzCfE3bO3zjSfWDPc6n1lDWu4ofwmcfnfeXh/Svi0p0voDte0UV6MOxszmmIt0AzkPqWIFdbHsV6gUiBGiYBats/0WpOQ+2Q2gg5gsKjqRKnB7J02Osi8LZkhBgdb6dgqQktRuZkD9kWkA5RRwyAIPHgy1be4pHFeqdSIR8Co6eZwit9PdxYoqzcig6IKMvA1e/V8//2m5g1KR739IKRWxQNuQmTYQvniQprXHFb6+e+LoTlTrqsgaJ+Pjgxsi3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1xaghyF4uVbDNLXugxeL0vl/6ekE40Im93VVeTP0gU=;
 b=nOYuiBMwZH7fcETkTChz6cpxDb/9LttwpwhoPuKdfVz7cOqmBPwizKawXMMQ1Ui7gwIQtOWTrBhOg/Gou+mq+lxpicMDrn+CKq2FAnvPVIPWLbJRxMwK1Z5DMmw4nN2lHZa9hY/ynabxB3fzin9sabGoVCZcQaSipvFH+t6QyTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB7173.eurprd04.prod.outlook.com (2603:10a6:20b:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 23:00:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 23:00:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     Thinh.Nguyen@synopsys.com, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, imx@lists.linux.dev, jgilab@gmail.com,
        jun.li@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, peter.chen@kernel.org,
        quic_eserrao@quicinc.com, quic_prashk@quicinc.com,
        r-gunasekaran@ti.com, rogerq@kernel.org
Subject: [PATCH v2 2/2] usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config
Date:   Fri,  7 Jul 2023 19:00:15 -0400
Message-Id: <20230707230015.494999-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707230015.494999-1-Frank.Li@nxp.com>
References: <20230707230015.494999-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b88d035-4264-47cc-e012-08db7f3dfb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVb45aXJA1G9NPiEDptHKGixUiiWRFPKwZYYNPVKz0iV5NXQ6qSNDKNkReyfsDLvYdfWoh4q9R3BP+AmYXzRcq7+hAJOBYmIODsCkru+sio2/jzzM4RfiJ7iozLlMxG0uM1ETBtTlDEx2TeYBbUOFpGDrMO69bv5hAEvvllSWvrjjwwr7Tt/M+Ff7EiNzhhrCOR8S59U7amU9PllkxAVX+KoysApjbvsnMaYP16HRoToMCve8b8q1ugY+bT9Twgrp8FcGCzqs4U1N9Nn++QCT858DjUmNfWw4snmrMQdaJ0Hsqbs9lLQo8Y7VMJ2vpyIHQLv+GaL4C4A3LAgKsUMBx8I+NkkFhnoznO9Kuu6H132K39itXuX4E3rIyxU7UitQyWu2ZAkTVQdelBNDU/JZackA0cqJrlYjyl0XxGHuF5YtHJIYCheLVb1SIGV9Ut6UggrCW2Gqd2JOZ+IPXTOcQMMcdla1gQFmE2Cwvz8vzYhDfH3roy3KWqIxJFHCKwRXuH17PZC56QKGuv7dy0JiUSUweOaVhoNrhxw+vThvALeTPSp4dPZTeJsZu32b4mXZ5R7dmurZM1VjFKoR8rf8PIS5VUEOMkWB/OgmfbjoXlkOakukQflvlULdG4t/Fd7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(52116002)(6486002)(6666004)(478600001)(37006003)(83380400001)(36756003)(86362001)(2616005)(2906002)(1076003)(26005)(6506007)(186003)(6512007)(38350700002)(66946007)(38100700002)(4326008)(66556008)(41300700001)(316002)(8676002)(5660300002)(66476007)(34206002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzRlKeAntdy3NnAnwx9Qvh+KrCpz35imrmzjFi8fjswNMLnVJNnhhNsFHahz?=
 =?us-ascii?Q?njiqJltICawclZ3goDscsyGq7PKcTKZxLQTDmIXXZqS9MnHB58tb+XtkqeTe?=
 =?us-ascii?Q?biEE6+VHGTMIHaNqN7LSBX0p9ezOrf+6ZsnKZMTSkkf0L6HCm45cpBI3gtfX?=
 =?us-ascii?Q?NjSvr9753/LMWC7QKhRx2Yt2GzGVhWFFgsErUOcPMjqVva94s731vsVneHG8?=
 =?us-ascii?Q?hVepgPYU1p8fEe9F2M7vKV2XdWzJgaXnmKdeHfHMeBgAvpQLPf4MKYOv+PRz?=
 =?us-ascii?Q?DWp9aArVbgtzsfJ4pY9L9SuYfqwDr6TMI+7hYQJ1CYLpiudYz2xcu4T9lgpk?=
 =?us-ascii?Q?MwS/px+UYukCRP2+Pc2UiGk+HskY1IuBwpIZMR9SqIPZAJAtXUhRbZegbrOM?=
 =?us-ascii?Q?BrdBtJ06TDz9U2b0ajcY5NoEJi9Ha2NUNxMtHQp2ALGJn1DEine/VcUUEueq?=
 =?us-ascii?Q?GJDVMLNIvPKuOYdBirnjofyyv1xghwQybpQaMJ+vmDLbxYTm04hf3PnHmjQ8?=
 =?us-ascii?Q?Efud1RGLEBNJMrk7ZOD59r/0r9hczyNSqRdfOsA0g5F9Dj83NMQ8rsM+3xQF?=
 =?us-ascii?Q?RQuXHLNom8uIeUUKmfn37iaNgOo1YlMYX8wrnc5P7cRde9aRkia66+fcmsWj?=
 =?us-ascii?Q?uc/ty5kLkkGLlzCQiqnXdCokh0kWNGN4hu09VzZ6A8azImwMAjZUV+HPnCdi?=
 =?us-ascii?Q?YoY1+/plSdZYZmbF9BTx/vFB2lnoN/ICFl6FyDYsA0BmFKfuJ1nxQQXIh3sC?=
 =?us-ascii?Q?D3tXkcb8tt7dmE9G4X4rNL0g76MmTO/S6iq56cMNmi6X0CcF79yk4R+hu72m?=
 =?us-ascii?Q?KyzIpz5AKgyIdld5/iMfFCtser6BHUgHZZwEN3nS+o1penQImiLjI55dzlHJ?=
 =?us-ascii?Q?y8GWBYDh9+s8rxIxJzx1ZlB2BAdqFj25hKTNeN4XsVhBte9HeKy68qEi1i2l?=
 =?us-ascii?Q?KRVkC3C1DldEWumcbXVNAGQp+I3yN2v8CEVT5lx+eYAc0P51rlHr0cvBGtK0?=
 =?us-ascii?Q?S5HtFSQVqGhZxB0VxXxHsmb0m3PICUZ35jAkswA1ra1IGrblxe8RROxxswTx?=
 =?us-ascii?Q?WZ3mgCl5AAVlaO0cMugBNzK5as3SQlrn1UqimN5p4ncTbazCkXRw9IqJHcSh?=
 =?us-ascii?Q?OKeB2obHslCFzEMwDf/P1UOvg++Le7NmTlJ4iezRPeDKyCb2p/jh+qXzpeSh?=
 =?us-ascii?Q?s7NX/eTCL7YpvagB++T7uTchgMJJNqxicwr7UhLI6qfW8TQsgyYnkbWdkp0W?=
 =?us-ascii?Q?4UoMt9Ll0CGF80Z0nyEDhyYTq/h9wHMAjuWF0ZhRdF34hCGaMH73piRuHguL?=
 =?us-ascii?Q?aVjADYInLO//2uoovxwymS/slLKLFpYYUMW7ZlO4hNfTUsJIk2wHvgAzqTwo?=
 =?us-ascii?Q?VkWWS2Yecah9Zg9oBJ8bH5zLkKlATjMvW+lRE/rw12kXtuXb+VS9QhZyoZlp?=
 =?us-ascii?Q?Ju0nXEhEvZfH3bdKu4q9E1NIEwJvp7lqFMIVr2PYJks+oScS+d4lC1YmcBRc?=
 =?us-ascii?Q?C2Bf2kM8A5kmzxUqILAer5b8sXGF8r6hc540EbvesAGpvcSyQH3h0ByN7etK?=
 =?us-ascii?Q?JKBvu8oOhCsIk8Pl1PUA8FZO3DldVsEsV6Ki5nO1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b88d035-4264-47cc-e012-08db7f3dfb62
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 23:00:39.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y1CQvd1W/OACRDmZnx0RlD5CRMgyyWC1RD2aE3eTibMoZLxOSdsJUQ3gPPntzq5yoLMKrDj1ctsJx9OMD0/+g==
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

Previously, the cdns3_gadget_check_config() function in the cdns3 driver
mistakenly calculated the ep_buf_size by considering only one
configuration's endpoint information because "claimed" will be clear after
call usb_gadget_check_config().

The fix involves checking the private flags EP_CLAIMED instead of relying
on the "claimed" flag.

Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index ccfaebca6faa..3326955f6991 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2999,12 +2999,14 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 {
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep;
 	struct usb_ep *ep;
 	int n_in = 0;
 	int total;
 
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep->claimed && (ep->address & USB_DIR_IN))
+		priv_ep = ep_to_cdns3_ep(ep);
+		if ((priv_ep->flags & EP_CLAIMED) && (ep->address & USB_DIR_IN))
 			n_in++;
 	}
 
-- 
2.34.1

