Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6AF749F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGFOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjGFOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:39:32 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6031725;
        Thu,  6 Jul 2023 07:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqO8EkxNhWHBlJWztL/oP8h+cXde5cZsSSPhS5Ax1qJ69AxcUpme1fQcIKJ1JFjO7/np3lFXUQewJs61G9nAfWZZD8QacIexKGGo0ZoJQ779oZr+xHLErf6uIYriUvvdR7Fqa28CWieozNR1GWC2bldf15wRZS+QniQwjqI7ER9UVguqtXEuQjafYSYuvry7ktaPnniCyvdhsl0wG5NRaUDlqJ13wUrvBFWWsVgX4YzqT+SMynhaFRYj6R81n2Fy6WJPo8RViZSn/bSWt5dfagfcAmsepmTbiSXP76tJqeckuFVmNqa7A9jFW+A6fmy7Qh0GUV+MKmoTXb8k4aAh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Imj3XPrPDCk+Y5ROEykh9ou423JxrXt2tIJuvEmAHWQ=;
 b=ezsWe+E6ZTDD4m9fTULJIoJ0THJ0q/oVkovbN0JuMTtMcjTaORJIvN0XYqc+4L5MtKSk+CS5ilpULCWwLcqIt6/o+48ngD+ICgSDe02VlRnVGFQ+fbYt18menx/+MqoFHWfqSF1JPd4rs5UCkN/h9334N53WsFIUv5PCA9juQrlBhVUGk3TQLjWqwkTYb8nNUsXTha+WUTUu8vvLEMEWop4a8tiva6aaIIEtlfef61mjcuVaCyTI5IelNbrMcSuB7OONdRJ5Rj6JlLTjCv6pFaTduKIYcL3JCXNBsAAvqVfkpp/FDDk9lN63YqvFGN7GNDkZwHbyx0jCYfAGVoyLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imj3XPrPDCk+Y5ROEykh9ou423JxrXt2tIJuvEmAHWQ=;
 b=hb3GLk2U199Hs+TcUkEd5XQrRESGcxA4jxEboEqI81tcgLS2VOSvAzXMU5yIM2aopWHLqo3Ojm2yta5COEqU9GG0Qs4Cc1/IAaA9iMlkyJk0WRrUjqdKiE/NvHU5agrxNmIAO8GJDLWZ1EJUH+BW58KeVYbwpCrms2yImqe2hd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6791.eurprd04.prod.outlook.com (2603:10a6:20b:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:39:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:39:26 +0000
Date:   Thu, 6 Jul 2023 10:39:07 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm, primecell-periphid
 at etm nodes
Message-ID: <ZKbSC8LBjLuo3ygD@lizhi-Precision-Tower-5810>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
 <9405224.NyiUUSuA9g@steina-w>
 <0125c54fd1617f3f945bc3f4bbef5b914b701c24.camel@pengutronix.de>
 <49ef52b7-0269-898c-7cc2-096f2f1037fc@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ef52b7-0269-898c-7cc2-096f2f1037fc@arm.com>
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 053cec3b-4225-43fd-eae6-08db7e2ecc3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqGOhzjmZ+8fhYV3GsszpWOCup8HYHgscOuEj2ZIK1r5xc8Q8UFbV1AObuSv18KgX5u+pLmb3WboqKAFvnKQey/gLafxhaDtHHfZX8bEb126b1fv4yv/Q/cC3Vulsfzz4FppbHnUL7TjybwLnBD5RNkSa+U4nHMOZ+re/jSSvP+apHo4Ywd/5IGeUfEqPAdc5AFUHrT66hu3p0w6nl5vljpLdj2U902vOxgIgjtzyVNsbWTHNtS18JI6JetBkermO8iZTcN4kLt/c1q6iy2Y60WqnYtJE8QcBmzcTVWEQajPUd5Ui+a9KDEiyY3a78mxvYt8fZScaojIGSQEuVcPf8vORSumwf+mbwfaPBtJ+l59jbMHSolPGrmfp7s2SR2Yp4dqIFjsKX9ySX1KiJLSVt6RosWj0ipPE+Fe8hY3FEOYkEj7RVCLDzc8YAO519+Fvb1wFA3mDRYQjnKJR+gct24XcYvHSeqF3WqmSDcvlGH2FyMT+XyBdOV7NLR9sh/swiQSGcUij6ehJrAulKj3IFmstQqEDn+J8FaXJn8589STpkrvxKOltQu1sEPxJfHSJ/190qymahRY85Ht1MhM6SSaGfq27mYOIZcKthS228rMVnQ15Bxc5mUYxDN0xAGr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(52116002)(6666004)(478600001)(6486002)(54906003)(83380400001)(26005)(86362001)(2906002)(66946007)(33716001)(9686003)(186003)(966005)(6506007)(6512007)(38350700002)(38100700002)(4326008)(316002)(6916009)(41300700001)(66556008)(66476007)(8676002)(8936002)(7416002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F1r6/iH0SqJ81hHA/rqYMicLmo0dSdCeRwIG4meFF0aVqK1qxvy0dfXP2NMo?=
 =?us-ascii?Q?zMwrYC+4/5s0gF9T+xEZ4PSDIs2r9U5eZgOfzi5xRaplRVxqEkqlxAXYMg1k?=
 =?us-ascii?Q?ye4pnF/O1pzGhSSujZwr4MfYNkhNgP1GhsXFgzTI+JPUXp3cz4p1Z2NUvpFW?=
 =?us-ascii?Q?14n4+BxxOoPMVE6x2VDVmIPieNYKcJJGhb2SKr8Q1y73vDYxTEztHjna3B0R?=
 =?us-ascii?Q?jzjkPo7sl7O1aCtGHxqA84GRjCdXalCrnJUPA+QIDxr+HqdA1fVS7stkXRy3?=
 =?us-ascii?Q?Uj5e9Wi/cxaCq/dmrROeWf0J6EqOAo7uLTPkCs80NHpBtMVOugTF6is7DrTA?=
 =?us-ascii?Q?zBIqfxeJ6y6BLo/unFf54BoAwoSZZ1bI6+y/ClhWAbrXx1SjKUkn2MGUrPaF?=
 =?us-ascii?Q?gnylXWxf4HLmG12zZz2wNkpCUXLg+PHXZxZMgkhe8FZ/GpuVC8tWZyc/Zdr3?=
 =?us-ascii?Q?8qfq3haH1GwqWN6ZiI9VLApVpuZby7CDbLq64wglPdQwPbwye3s6kdnZChYo?=
 =?us-ascii?Q?yZRXO1ks0Ut3FXuicTt9ywC+FYbfNxG0JMFAoFljqgYRVBF7jxom547I/8b+?=
 =?us-ascii?Q?b1K0cbvdsgkA71uReB2Sei7jnytXu2EruSG2DBvUtA25Vk7QpErS/1ix8h1d?=
 =?us-ascii?Q?F7PxIJsxiSZWs1n6drkvs6YaY2COvAjZWX0JCCwgNq25eit01juOiKpQ2OIQ?=
 =?us-ascii?Q?SMXxYerEt950UIKEchL69OawpcOzufif7murN/a8XPe/+RIjCivSR+XzH7UH?=
 =?us-ascii?Q?hDXX7uGXFbsetqh/5abnurGYmuSyn7jQxYkToD+Bxf14ZPjANsyS9c+Hdkvh?=
 =?us-ascii?Q?WrzHK6kYFKpwsGP2Dk9ll4daMg8Do6PUx280lDBbUwGB2R3oZ7gW/ukuBN78?=
 =?us-ascii?Q?fewZODkMYBMPpvFiGp1IYWuPIzR5fc5cFE5zk7vo7XIVxaa1Tq8eDcYvTIio?=
 =?us-ascii?Q?z8hlXcR5waYiRNS/uJahXgj1XTw5wOZWgXifBVRZdzRPPW8k7hqR/AM9AKYZ?=
 =?us-ascii?Q?+N4q0c/e/xrrSNoHh1rToMz+IbhdBtc1nUkIMDi3FaNZ1repm0ZxBbVhS5QU?=
 =?us-ascii?Q?MlMzS69PtZrazgt3uY14+hNEmLYwo0KHXlarRnBOr0Vdrr12LT3F2PPk/jLn?=
 =?us-ascii?Q?AJzUeB9VpMVt+GARIorvQzMCvWyPCc4JtdRbMaLs5ENIMSHZX5BPbxBWUb0a?=
 =?us-ascii?Q?iiSV4eiNneFoKdX2BseopgBxYRCUvrax0Q4W5G/ZWYY0NlXs8HObZx4qW5Vj?=
 =?us-ascii?Q?L+05bO/Rbnn2tbeMhy3arpjdJSyrZ3+OpWdRxlqHzFrOcCS3e2dW1uH4ThWV?=
 =?us-ascii?Q?6WY9CwW/Mu7mKYuUthOR74rDlCksPw9J/mIY1I4zVfxC+sAXsuNtOY0MlZTS?=
 =?us-ascii?Q?tGQYm64ewTY+b2AkqKJ2R6p43FDNBiwb4IMmL17KVMKM4FTXxW9bTwdnBw/S?=
 =?us-ascii?Q?9a2k2BIFum0iNmSISxcDynJ6PgIkto4zQMCvMtA4MOojpTx8xZmfuQDyc4eN?=
 =?us-ascii?Q?EBNkdPrOatD9vXtazfQu9Hwa8depGBPIleHleiclpIgI+/FqSGD+vO+yCtWM?=
 =?us-ascii?Q?bRaxywt4MKh1jZoe4Hd2Qt4W4xq3wFee+gpHhO68?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053cec3b-4225-43fd-eae6-08db7e2ecc3c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:39:26.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9JIebvs76FUYoPMuVdysk8/n0ZAoaJnDyG5JBUGJF+xHwdmtTQTqP0jzzUmVlAoZrYkYXCl3wtXw2RTd4jIyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 12:06:19PM +0100, Robin Murphy wrote:
> > > 
> > > Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
> > > > The reg size of etm nodes is incorrectly set to 64k instead of 4k. This
> > > > leads to a crash when calling amba_read_periphid().  After corrected reg
> > > > size, amba_read_periphid() retrieve the correct periphid.
> > > > arm,primecell-periphid were removed from the etm nodes.
> > > 
> > > So this means the reference manual is wrong here? It clearly states the size
> > > is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
> > > On a side note: Is imx8mq affected by this as well? The DAP memory table lists
> > > similar sizes in the RM .
> > > 
> > Note that the 64K MMIO space per device is really an alignment thing.
> > It's a recommendation from ARM to allow individual device MMIO regions
> > to be mapped on kernels with 64K page size. Most of the time the real
> > MMIO space occupied by the device is actually much smaller than 64K.
> 
> Indeed, it's quite common for TRM memory maps to be written in terms of the
> interconnect configuration, i.e. from the point of view of the interconnect
> itself, that whole range of address space is assigned to that peripheral,
> and it may even be true that the entire range is routed to the port where
> that peripheral is connected. However what's of more interest for DT is how
> much of that range the peripheral itself actually decodes.

Yes, there are not problem by mapping bigger space in most case.

amba bus's periphal use close to end of region to show device's identical
information.

In drivers/amba/bus.c, 

amba_read_periphid()
{
	...
	size = resource_size(&dev->res);
	...
	for (pid = 0, i = 0; i < 4; i++)
		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
}

So the range in DTS for arm,primecell should be actual IP address space.

> 
> Robin.
> 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
