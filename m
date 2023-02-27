Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE66A4F85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjB0XH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjB0XH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:07:56 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AC6E8A;
        Mon, 27 Feb 2023 15:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzYKQcpMQQEnQtQiTdv8Jkb2b1JG7L+bC/K9AN/xaP1za9/7aUr+/mOI2Z8aXiHptcUAxR/79TGbOTX3TjjvKo8O6kKFZSqmxPC0CdJbaNgoq/0L65QnQvHHJuMh6g/IAdVZz1LjINcOD3GOTooNWmRLSV5fQfXKx4zDBz3Wa1yDhOXuTTkgLOtgMvkp4iOs67zJNoSctytHfvVgBRFVFTE+KOHlceoBTqUQ+msGQK8j73wqVKyZe1cX8fAdHaBejIYEMZmvdnPCimlvAOkwj74qbdcZaEal5dw6jl0NSe8rGxqQbE0eWJSWuqXHqVzvj8CnQinERhTxA5BlWu5M9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKl46ujYbCneQjIsc5BBDZyzkRdGlt7hN5mGpdoQ3wM=;
 b=SrWCni09Uk9wfHpekgQq/QrPcKEl5IS6k2R16ZErSeC6a/d7vZa2CDxyQdRvmtF+UEjnK8UAdsKv2gtjR7U/oemJnQflqH3rLRdGjmqT3PDAguMnmcSbTx30rIvw4o22fydktLynMXaFX7eEhXoZww3qvzpOR0dXwrSbtuu9v8z+fg7JcX55ytYLj/TMd5IqfS9hwF5vHidadxxE73n63tb1bY2xsmVBJG1B1V5zcbgppx+oBBG+PiSZOYPDF2bsHfURdDfRn52ZtUc+EHO2QR9Nef4D0K9My/D96Da5ehNoACvc2D2RAo9aeVW963QH90J4DkJpl0izXUp8V05xAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKl46ujYbCneQjIsc5BBDZyzkRdGlt7hN5mGpdoQ3wM=;
 b=Z4q6tOE9Fx3Moh33cEtKDxOxzA/NVoV/fc6nJA7G2xNwHw0h3fFGmVzMKR2Lx4h+DQl1vjHEUALw7WWiYGErN51O6bqlHlNFTlSYT0mU2s7J5hAG60HkVEK+Rgh7B3Y0BfSEDy+CkIcuqcHZhH8NuYgb19ZWEGVZV3AMCogpjQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com (2603:10a6:10:103::19)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 23:07:51 +0000
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::e555:cc9e:b278:15d9]) by DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::e555:cc9e:b278:15d9%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 23:07:50 +0000
Date:   Tue, 28 Feb 2023 01:07:47 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <20230227230747.zzthvwb7vsg5sq7e@skbuf>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/yfs3Zo70gV/V9b@kuha.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/yfs3Zo70gV/V9b@kuha.fi.intel.com>
X-ClientProxiedBy: AM0PR04CA0124.eurprd04.prod.outlook.com
 (2603:10a6:208:55::29) To DB8PR04MB6459.eurprd04.prod.outlook.com
 (2603:10a6:10:103::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6459:EE_|DU0PR04MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 5660036d-ab43-4873-8385-08db191772fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8TJlcP/fK31CaZ0bPomb5IbM4nDpVOzWc3lmUy03fj/j7htKI5lWzxm0iiUUzTSglEawmX12Rw4TRuaajjnKBk+l4kxIkH+hj5DYULY4E1LG2ViuKJShjhTCUsbyNuFcQUv/aO1yamzYTcXB8I0DdPkIKn7QnmXGZuXeV1hh7IQuGVNDVGHN8b/tOQqJ23GmmrbCjPk8AkKCx8/nM8/zVd94dt38KH1dC/2tXgbMNedBvdEyfnxPyus6L2Xh4qTbmL9r8fuHsoY85S1+gtwApIZ297fX//jUGQg+MgZPmoRMqr4xo4TTR5r2GpwwnsdeuXF5HG5L/StP6k/ijcIU31PSfTS7zcLh6rave3JuCS0y0n9hblAR7QaqRc2DGurhlmer/eIWidqYYRn5KbhvG1hE9Lr02rgvcAJL/mDpAoEO0cfIecfNz6kO2K7tQYUsalvUzFWkzBeT4llTzH2PMqL/Sg4AV6wd9UL6YIUjkLsO6ZVO0X7MK+gGEJR6EPsAt7TIeQdTNSYqVW+G/emwRzcU+7+/3D/0v7IlE6OfcuhFtdWjRbiM906+Sru4ctBFUGXTtpCQy0+MoZux8zmBV7Z/uvw+VaYi/5KxRjQK3iYe6CZ9Zi8Wnzf1Oj97IhHFg3QdmfnAfBsjxxTXl9bfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(9686003)(186003)(2906002)(66476007)(38100700002)(83380400001)(6916009)(66556008)(41300700001)(4326008)(66946007)(6666004)(8676002)(4744005)(44832011)(5660300002)(1076003)(6512007)(26005)(8936002)(6506007)(478600001)(6486002)(316002)(33716001)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wv/1CrtwSL33JGptiiKRZE8VDGcyawjyQMPX34Zw0ubUbKtytBIcdAOwuM5Y?=
 =?us-ascii?Q?n+/AoaSPQ1cJ52qlcLh/Iv5dVaoijk+sArtsYi86/VC+jC/ml7HNkkrzGTFj?=
 =?us-ascii?Q?bO7TVoK9t2s0pn0jKneKXxPnFMsPUTTEPTaH7K3rTNHUikTOCFgnGeu+iMLa?=
 =?us-ascii?Q?jvrZr/5xI+UBn/i2qv+zmABnj3y32XiXAX+5oWos12dlAv/8dA+av0nuLqfW?=
 =?us-ascii?Q?WDA7PC0rAqQgJ7FQOkxtuvCgPu3WJW2y4mt0Qrc/CnumQM20v17Js6yIF10z?=
 =?us-ascii?Q?Cj24vXwG1ja7Us5WcE7WTXIiMLUtFAqDNj/xwztxBOsJXde/BMhS9oMW1dJV?=
 =?us-ascii?Q?sm+bLtmb81nRat0ez5qSv6U4dL4FOmdhp+GOjsRmbzxz0umpvbSy1VlnLnPp?=
 =?us-ascii?Q?lC8H54LVNRPPTnc+yKJSdXiGV8qmYzihQNvLMZ3nM+8Etsq93p0UIoLFMZZC?=
 =?us-ascii?Q?SwSmiRJt5BO880FMs4X+5OOw6wMQ/psoM2sxNW55JVMrOrc5LEE1G8hCuz7U?=
 =?us-ascii?Q?m6GqWrwaNl07fOOGsDqqjPo4+WoBapnbhlrVEAm5xFbW3HMaQfWm/gzurYhe?=
 =?us-ascii?Q?SyzeVGzbDiIEnb2R5zBZ2XOAE8WdmUaTd2gTGDuIGMA7NNuHw1OkI7eNXf9x?=
 =?us-ascii?Q?sINh22s9Gp3iNd2vBRQw7vDOsua4cZcpmMgOVQ13nE1+gJUR8XJDwbb4IQDS?=
 =?us-ascii?Q?0cjkMLzu4Id8HgRnLQMAmnnfmyUm4CivZ1OFt0CGSJfA/CyliThUag4S+I+Q?=
 =?us-ascii?Q?J+0yKr+uCTO8lagX7WSkNJJZg6iz6uHrH9JqX2PXBC0fFy1DoH313L7TOu6B?=
 =?us-ascii?Q?r3MMWC+gJ6cqlwtoGnXTnnGfoA8GaTCFGtmXEN5ZPjmuc4a1688/5mebYOis?=
 =?us-ascii?Q?+v6e4YGQbXsSd0+05KRC8R4JhAmkyXWExmnvKtFuVKEbJwus6lI0Zdc4BTR9?=
 =?us-ascii?Q?zixEcXx6/FOcMpzKb56xauOzP27/gpWHo+9sOqC/m2nhHKYZT4TzTKFOP/77?=
 =?us-ascii?Q?Js0dBgSNFM03uDf7J3chEGwB7Tvo4PXxl/3KGmlIz7rYRLQxnAn7j8bHTAgl?=
 =?us-ascii?Q?S3fbX50FHiX64sceRFnDefC4goLWuxLukrFiGttYTOAIC82JfRC0L5a+aBtX?=
 =?us-ascii?Q?MpphZYJqN+IK88QYkeeCoQhoeFcojFzL8zrN/rP8Vo+idA30DK6vfoxkJTla?=
 =?us-ascii?Q?P7C94MEhKtOMGGu6YDK+AHC0SSVX0P2wpblJtG5Rdzs7oYs0TId4JWjpWDN+?=
 =?us-ascii?Q?j+rU+xHvb7tOfRP0hlrUfrAAEicfx6HuRFPvblvDaGx9IxwJxKozQFAByWwW?=
 =?us-ascii?Q?9VqRoXx7fUFLslmkL0YXM5ek0uxko3mF5sSwMx9wvQvvL+TM6pE1owbgRnV/?=
 =?us-ascii?Q?3yA/quiVL3gJOc98MFK0A6PMHuTIUQFibPU3DtTX9/vmxcUNd6ol7hwQayv4?=
 =?us-ascii?Q?EddX1vd6h1kwp0tcrItDtUhjSL/itCXNW9vfQi9T8RTeTR9pCkUpGbkHj68Q?=
 =?us-ascii?Q?h1q1UdrWnKXOw3ca7o0IBySc7yPvIvWv6fi97PCyqZzFiataOCfzrzbPke7T?=
 =?us-ascii?Q?oOXnyR0xkGgf1+492af45pvzn3/8ttL7MSRiqJI22cMeqOsqpShpFBOiC3Aw?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5660036d-ab43-4873-8385-08db191772fa
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 23:07:50.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC37V2KlMd0maxgiDf4Qc40r2EFmw8qDrGFcvCQ/ZeuT5tEJogREmRcZoc/dSmIvUTDD3p9m5mQF776tYLY80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Mon, Feb 27, 2023 at 02:18:59PM +0200, Heikki Krogerus wrote:
> Try this - I'm sorry, I don't know does it actually work:

Thanks for the patch. I'm not able to tell you right now if it works or
not, because my PowerPC board on which I needed this started developing
this issue in U-Boot over the weekend:

DRAM:  Initializing....using SPD
Detected UDIMM i-DIMM
Waiting for D_INIT timeout. Memory may not work.
2 GiB left unmapped

and now I'm in the process of resoldering the DDR slot, process of which
I've had enough for today and I'll continue tomorrow.
