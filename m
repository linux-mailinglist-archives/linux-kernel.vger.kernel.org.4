Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC35691C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBJKNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjBJKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:13:49 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AAB6CC5F;
        Fri, 10 Feb 2023 02:13:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIUC503vfVaPp8gVpE3gC2dA5eLr1/oWnZiTxIEEN+63YxEL/paY78ue24yTp+uBSBLF/811UJyWs4A8+sO8YMWcrwX24n3QvOG9EmAFtq580u/w3MK9+NkErCXrj6ShH3JUqrI2G6wxZVf0FAaGkDn22Ts8fWi+RLSLtP4pMk8hcbQ5uWOewCED4kJAtZJGWP6aMq8+3vjDKJ3GlW2eZMFawU/dSJyS8TytlPgFGq0D+bpMnVCEQgGzxwFD9uo1cfvU/vbZO3vB5bSkGxVFdU+7bUG/CTVK+izoR8dE1Sm39T77jwskQYTMNEht/pNxYqgawvecoJzXBTcB0Y8Txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S51Q9tG1sy6KHgKMZY2sEo4iB9AoEpw++WLwYShnChM=;
 b=m9+C1Q26iwt8VPSJbc/41iKPiP+apPdX6MMg68VM1RjAyrH5QAEDbXLJoPGpoJ3UqoOy4OBCtfUB9n+mK4WRBkV2NmJC3nEl16mve6kqE7RBohxQQrdZ+1KdatoWRiXFslDp2F3bOaa6wlCVDCybD7STAKm3NN9DbQLARqCIbfw60yhmZYuEpyOEkAlUQiPRUgIux4dPSFQy6QEKJBF8MhvsFMgRfWymDnF/q42GMWJawtkUayLnJ84S49LduN7QRrfxOccEe5D35LuHfMge879PV/r9Xp1DnOtWYOimX1jRMc+YanZE5bI7QXKxLx9sWA5X8azjUrNfVv0oTWuRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S51Q9tG1sy6KHgKMZY2sEo4iB9AoEpw++WLwYShnChM=;
 b=ILDjZ/zZOja/87T+KOiBc5v3mmG1RvTrzi/jBwJxXU4niTVwxt3t/zYN3UwmgAhr9CXd3jS0T14ZaDakJySkNhBfM+XcGmH7m8QSG5ChKmDuLWSBWCMEdwCWvmw/HnaY6hbnF0sQ6nBrPuVClyaHMYt5HS2ub1oj4BhMFJhmREA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 10:13:41 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 10:13:41 +0000
Date:   Fri, 10 Feb 2023 12:13:33 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
Message-ID: <20230210101333.h2e7hcl3ylsoh6fy@skbuf>
References: <20230207014207.1678715-1-saravanak@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
X-ClientProxiedBy: AM0PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:208:be::30) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: c807fb3f-7904-472d-c30c-08db0b4f7b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfkfbTRn0ebZs/0Sh8kQhz+RMGkhheZnsxMNBckrktOdFqM2gDDz92pSTWRK7h/5hc7dGBigFc/WJArR9TiGiT9qmNdLjvEyL0TYi43Nl7rjgFnpyDHViTJy4Y0vU4cw2gkL00hz70RKyYqL3hj3yPbSvCzPxd6Bp2jaiXM9TukbITLtPWnQjVblxURxuCgc3R6u29guoQ8Ry9e2+v9ENHnZSPTJhaw3CHxLQlaoerZuRIBYWCtw83LKtwurgHo/IrTzcgS00CkBDhxt1zPWGCdWukU7RQZ87crcWac5gc4oRMJXE2ZGuTrtfEvUD0SYmjt4u6ytfhhPhnx9DYuD7YNZIS3xru8AJeXANmT/r2SvFGUD/m3RFrvLWzGTtUZQIf8wTWKYhA6YvcsZIdcm8r3Ud+G5ZuABn6IiiQsKDFOgk66kBtHj+rfiyvMlnD8dgwKC3AxIl9bp1vPbyy9e2dJoRbaO294hU3Eg1DWEpNiVNUUhsJga98/XM8b3D9VP1Ll4zI27lwKZQ//e02GWnHdg1jZ3GSshS1M7h+RexirLCjOQnmtbXHxbL+5gv2s/gw88jgX56H0kFudiFEGaAwv5g6Hf1EAbn8qOzZOvYGs6S/YWowg4/N3yOslLHgfMoRdJlaDfw10YyIubbtPlcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(7416002)(8936002)(316002)(9686003)(6506007)(86362001)(1076003)(26005)(186003)(6512007)(478600001)(6666004)(38100700002)(83380400001)(7406005)(5660300002)(54906003)(33716001)(44832011)(6486002)(66946007)(2906002)(8676002)(66476007)(66556008)(41300700001)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YA+RO1TBwF9kROubBL6n5nvBCtTxWhbzwaxRMEcmb4D+8NEptJuMEAAGR/qE?=
 =?us-ascii?Q?IE9SJFV5PwoaxVWf4MmCv4sR2iLUoD6edrg8F/B48QgAEVegKVRhv1Lkr0Fh?=
 =?us-ascii?Q?SUhH90wbEdNcai0oZ7pEfTursHG9O+CKUUM7l50O5mQ2HmVYY/vyf65AESqy?=
 =?us-ascii?Q?2Ts01VmDNPgy1Ykeaa7/PHOcyv+VzueMmwdSDZ2QSUfcpK9OQosOFAZATxcS?=
 =?us-ascii?Q?41oRGuoqPaVvyb+L/zMM+hnbWX1Lk1LkdbcEcBEpmY99uF3xCThi/gm2BzPC?=
 =?us-ascii?Q?tW3uyPmHkxqvq3loop1mIsXA7v5EsvJ5/VVMgN36fosONamfEyazv5QMTpJ7?=
 =?us-ascii?Q?CxHgpVsUfdHO8EQk/WNdZsrysArHs0tM62xuPmJzBR6f2yfCEpQwiMniUucV?=
 =?us-ascii?Q?ohiW9ZlTHQjsQhzP/z0ytfWz+/C0H2yx4Up9YGZZsKPIrMB5+2Gt3hMqaFmw?=
 =?us-ascii?Q?0O/7B4DqWyv/8siy7u346RMju3MvB04RQTSH1WaBhezmUn1C4IsVp5ei/1on?=
 =?us-ascii?Q?vabLKiVTK8pLQW4vxPUVQjjFht/ICuRFUmKsybie3X+17Rb9gnydkAnn0g5d?=
 =?us-ascii?Q?bEAIJa7VE3Buno5qC0EPD6Htv6Q1qV8OPsaD0tZlCz9mAL1KBaU9gthJ/S3m?=
 =?us-ascii?Q?phf5hi3MimZPBMDjAxkXlN3AD5/ctSnbSe3oB5mFjatsoyl7hUcnpBAId3fE?=
 =?us-ascii?Q?C6dM7wDY51/yKX0Cug+yuht0qkRnY2D0z08ExyF/4zGMA6wqHwAtPcUL9LhC?=
 =?us-ascii?Q?UuA4fanjfdM+1CwjFqtq6I2DJSIyqtNxXYuuTDFwb375y9gArZj37Vno506A?=
 =?us-ascii?Q?S7eKjRHh4vXxzEIvDC+F1ki5eVe3W/f07DALPv3Hqwb9DRRGfD+u6s5Yhetf?=
 =?us-ascii?Q?LwlWnluAbQfKtNSKstMpDVjlYb9/D3bDop5mR+fLIdwoNSqyZcRK4EQ295v9?=
 =?us-ascii?Q?EhKRb0YiNnOfN4tl4R+/6P6JdzJ4ZYuzjEmFAWGAsXGfbxVhoAI64rEgO72L?=
 =?us-ascii?Q?1rmLWrnnoia6kQxcu6awCKmNeebTfuRe0at1XiL5o7/3JRRbb4u4ZVBGoOjH?=
 =?us-ascii?Q?6yHyJV3vf6tWE++/tUOrzyDSkuWuTcuBt3IaRJaFOoLOSeSXLBf+yv6h6atj?=
 =?us-ascii?Q?fhw59NWJdU8clg52bcLtwFJ4NB7y0P1CqYLqys+9x2Puq4/dhVMyGan6U7a9?=
 =?us-ascii?Q?zafVEZIi8S528+byLY4Fp1+fPdmPU0HfPFgtl40FMR+KfLSmgWY7jfo7cHtf?=
 =?us-ascii?Q?E+Y1od3syh5X05qp4SY8oAMm6aKKWeOElg4x01j7nFkoe1YG7tpOGVVm6RpV?=
 =?us-ascii?Q?FftYbdi+ICmVVkHBX2yBmWXJKjs4aBTi5NrcsM1C0VMLUssH5/zoA7JD/pt1?=
 =?us-ascii?Q?7momlrPtaLin1jdBcGBaFbW7HRlCNeaL7wxMZfEGECDJbn3IcTQPH9rOI6td?=
 =?us-ascii?Q?lJaWecnL0P4GhoLgEVlP6rua1Pn/AUMKHzUW/ZVqrewdDD7TjgaN9Bno/h5C?=
 =?us-ascii?Q?6oY7ZsGcbElQ1BGl6MYGN5qUbfa6q3Af5PDAejJyqBMJtwgkV47skKRS8QVH?=
 =?us-ascii?Q?a8z1MqcmaolZIJWpAS4zegJtTSmgz5uHr7Lc8AdYrdwNxH+eSUgjPl4Ta3Qj?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c807fb3f-7904-472d-c30c-08db0b4f7b74
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 10:13:40.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If2CAHjBEWdxEWJPoKGg5MwXV4LXazOEB3m9kqTSOzhE9STLwILMD1czbFilSCkd8OR6PE+iApWKMtzn8aHMrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Mon, Feb 06, 2023 at 05:41:52PM -0800, Saravana Kannan wrote:
> Vladimir,
> 
> Ccing you because DSA's and fw_devlink have known/existing problems
> (still in my TODOs to fix). But I want to make sure this series doesn't
> cause additional problems for DSA.
> 
> All,
> 
> This patch series improves fw_devlink in the following ways:
> 
> 1. It no longer cares about a fwnode having a "compatible" property. It
>    figures this out more dynamically. The only expectation is that
>    fwnodes that are converted to devices actually get probed by a driver
>    for the dependencies to be enforced correctly.
> 
> 2. Finer grained dependency tracking. fw_devlink will now create device
>    links from the consumer to the actual resource's device (if it has one,
>    Eg: gpio_device) instead of the parent supplier device. This improves
>    things like async suspend/resume ordering, potentially remove the need
>    for frameworks to create device links, more parallelized async probing,
>    and better sync_state() tracking.
> 
> 3. Handle hardware/software quirks where a child firmware node gets
>    populated as a device before its parent firmware node AND actually
>    supplies a non-optional resource to the parent firmware node's
>    device.
> 
> 4. Way more robust at cycle handling (see patch for the insane cases).
> 
> 5. Stops depending on OF_POPULATED to figure out some corner cases.
> 
> 6. Simplifies the work that needs to be done by the firmware specific
>    code.
> 
> The v3 series has gone through my usual testing on my end and looks good
> to me.

Booted on an NXP LS1028A (arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts)
and a Turris MOX (arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts)
with no observed regressions. Is there something specific you would like
me to test?
