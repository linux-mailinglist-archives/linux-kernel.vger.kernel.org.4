Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090776887DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjBBT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:57:12 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F337B43B;
        Thu,  2 Feb 2023 11:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyTFKpLTB65iaSwC8M6kWt+vl6B5Q3MhXgkHMLdbX0ztvA5+FFQdB8rgdoWBLGA6lPo+pHTmbS6GVTHv6k7MTQd4zOupe4UMloMCgzDGhXUNlU/qdYLh1lQDx9pq3mwqcIoFOnnADtRtDAHC1WANrF63Pj+3GLrbcjYkWXSI8ZSdWKUK/FmAEU5UHe6LmOQ7/p7mCgUhm7gXRuLqKBOJsrQssuC+8qZQPkxK4Nd6IAfCZO/Gb+iylxFU6QntvUHsHnKoN0ZuhENwylX3ymY2GqjH68bTrEy0TwNCGhLCkfIUOXZt5CuMLlutRUh4r1mk8myiMDCYak4vj83RRbh/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgGg6+yfRLA++qkTj+tbFiARxZI5JF/QPzJAOdqpzxk=;
 b=AxBnCkpYDTGASupSJd6jrAE5TSjjvvpcF31dUvPKLmobs+29JNWZ1ZM9Gh0G7+SiAmbFnevEGz+pW9V0Jpvnoopj5+EWRXmU9cvrdS6hZqOnQrsCyaLMzBTBteaqgcwfdhq1Bdx6OqfaD4ekQvs8WnM1z10vT+kuHGuPyg2SIalnn97Idla8ziHb8YOadSGqBnuZJcJ0gP8Bzp1OJPSPPLZp2sxgIkiGULMGTsuHVUP/ziiQnU1HtpjcuaZrFyCtFVU5gj1ddUvobocf8d8ti25hyX+ZPmxYa4C0mucOIfsSGixppX9KGHDfmI9yPyfUE++QVd3Efv3deBDj1NxlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgGg6+yfRLA++qkTj+tbFiARxZI5JF/QPzJAOdqpzxk=;
 b=N97ipzjXFL+5nuAZ9ThrXFJQv13Q//aPN5Aq6/15exlwVtFWWSTtUzvPaOuWgwIOtomP8GxrEo8kYF4RJ+uaQTHOzDMgblXzJBwVHk32sbEcmx/oGDS34tybiF48mhRhp3cC1Q61ffj5gNr8bQOjCfJ11L6vmUb7jC+9//p2FLdqPODUvbEByNP4re4EFAp5zeBeDEaSzjfmgIvuD0Gggs5QjdVt71TRskXPBZxmeiqKyE7YTCCY7PSgqXZ7bLJYg39x+H884vl48jn0VjFT6mUuhowuYtzVb7llFIX7ffvY43VqlQG9U0GHBlL7C8A8x7UAczj8QjKcIfc9bwssrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB7523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 19:57:08 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%4]) with mapi id 15.20.6064.028; Thu, 2 Feb 2023
 19:57:08 +0000
Date:   Thu, 2 Feb 2023 20:57:04 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230202205704.12a5fbff@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y8mv8PzL1UsP9gNh@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y8mv8PzL1UsP9gNh@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f522b03-13f6-44a1-1740-08db0557aa00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bAIpnzD/3bBsJleLVFbg8K+KTbcNCqSsVvmFa0WSAj0qhKddIxfSh62EqIzmrg+UkDvf46z9gG4qRn2zdvM3U2dayvYlZmBXGlDsVGrx/5KxRRn2m+CoYxX6VaOfEP47/9IiIhUPMttdpVvNa4RKVMzbiNkV+h455toENC/i69RQluJCGh3u6XYeJSNwmZa/4+tPkND5LoeBkh0ynqxhXVz4sRJOjvH56KgCDLPq7dCC6ruLcX18egnbe9fukS65gHoUi9ghkMrpxLKNIZGi45AKwGato9LAQW67pZbSf3w7lHmnavfNoPESZ4+sRDryCTjq4pK4/hhhvH/Lz2gLr92+V4derKBucbV15zCBH1feISvlvOh2Hy0os4dymTqq9fhvRqXeLzw6GSLwqawxSS2N0neyelt5aPM4F5lF+xB5WIzc2bT8xw3hOhlw/jGj0LbTwbI1RdhrILBShfNH/N60AvC1ueiMkwVvCz4ScEpNbKQEB6lJxevmr63Hc+QHo4M1wQbiOvr6Cr6CsP62pz1d6moYvdcXRdclSacv52bIjhTUx+MJCK2gvfJO5dqrbBZmyNDg95Ozf/+gjwLZzNhQD+W/mk1UD/mG71D0TeAiR407zJiXIa0CGdoPjMu/AUH7u/0HYVt8vel/iaalw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199018)(82960400001)(5660300002)(54906003)(316002)(83380400001)(86362001)(66556008)(186003)(6512007)(2906002)(6486002)(9686003)(478600001)(38100700002)(6666004)(4326008)(6916009)(44832011)(66476007)(1076003)(8936002)(66946007)(8676002)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xME9zAGaYoQGWuzE21S3RHAQTmgWnev6UiB+A7jol94bJoIw20JXVenGNpZq?=
 =?us-ascii?Q?islHdzOlf/X76M/PU0e4IKpIxaZK/IGGtcTJ4nZJCBtOC1Uz3vnx2CxMUmNt?=
 =?us-ascii?Q?fq2ljWUn4eCGgSTPrJ3CodMt08AAhiFO9Ih9ehBY5e0f/7tv3cemDuXdEuDC?=
 =?us-ascii?Q?TTzwgyEq8QfioIzqC6d5n6fUs1+FlgsgyFSyPhjq9GWFByyJqpazJ89R0UAB?=
 =?us-ascii?Q?AqJB3cX8iqgJf5jDbqfezPrOKhui70CELRqzFwcvxmlEYFd1/vIaA1QZZ2eS?=
 =?us-ascii?Q?k4nEg0jBITsMtH6PvVna9bA5ikE8BEy7cEGgfSaY3TsSJRIJwxSb2XIgSDY+?=
 =?us-ascii?Q?JJtPL4QVY2CLxVBz05QpJOLR43plkyThucEUtzsLfeEOXVEyfuCXD/jck/n0?=
 =?us-ascii?Q?IngopLJFrCJ6izqmz2eCCKKx8YsDTa8SOczLxaFqLq2oHdts+2RbNrAtEiqs?=
 =?us-ascii?Q?kbaM0gpSdxNoJ+2L67mppaBpFWQmlZ+yy/LJJS3AeXLRbYN63dDuHjbEkytt?=
 =?us-ascii?Q?B2sCCgPdGoceSPCES6G6+a/kLOZvm+aVY2PkUpLS/g5EIADFVTkcEBXyR/m5?=
 =?us-ascii?Q?kJa+9QJ/LQYSLjFDI2xaOXAp7OH5CK/sU0gj+5jQypiLA+urpdriz8isu3/i?=
 =?us-ascii?Q?MWEmAPHi+8IU1ocbNYfVviXjhaJpTzRxLWg9ZE/SC7Iyktry4V2jEkswCoPb?=
 =?us-ascii?Q?VfEvhmhR/zLeaMuuLZMzM4jjDqb4DMf+A2Zg5vmO3QqjKdzlpjF2YRHgkwNq?=
 =?us-ascii?Q?516vWrMs8x/PWXhJXiGd1qYoef7scEDc4Cn5zVIV30hKhU2S1icyiYwlCoGY?=
 =?us-ascii?Q?y+dxhjs6eH5fQBnkJDvg39Eto1UnUl/VVvzjBHjIRpDVCF0tWKPxr1b0nL9B?=
 =?us-ascii?Q?NYi12w7pUZqEz3aDoc7fmF0LU4JKUGVDUYclQuO++Xya9hLt8g7MuhKHqFxr?=
 =?us-ascii?Q?b+fwF94QsOpaUZ40QNOAg4QpgvYj0WnVG+wMvfMQTm794jczv0KU3PPnkV1w?=
 =?us-ascii?Q?b4yZCQvNvbNw6wC4RlmpXwq/1Uk8MoX4s/vUAIVOIUfFknwyBhVPjMtkfiBF?=
 =?us-ascii?Q?4PHDRFQ05vFtPH1aNOV61Hm+bkQUTqWm6/IrwNfDf5WTTsv1sSKYNUXkLQ6y?=
 =?us-ascii?Q?+qf31dcA+0+onm1gll6IO5tYcN7oukw7fOP+dIn+9rkJM5MMrtkX1Ka8UfK7?=
 =?us-ascii?Q?d25xcYOE+dfdaBHAJZd8VvBQNjeaGweJY0Klby9m2JFAmHKOwS6LwaRRvG14?=
 =?us-ascii?Q?U2HFYbGUKbGpodtrptbKXffARXQRI+VigIiEtQ1TSW+GJFrF06y96kyLyqrN?=
 =?us-ascii?Q?pZvqH6TJZIeP8RSbi7+FFzjTqUQUf/OQQqCE9J6b3vYOPPne4g6HBQAw9Usa?=
 =?us-ascii?Q?A7RPfTFAdMx3fIXzdy+Mf0Z5mQFE1yZcYGIKnZ8dQFI/d3vCeCL6f0YDFywx?=
 =?us-ascii?Q?a6KMPQQwfeHdqhd2kdWWlOSqhhAnFwFcDWqqK6YwR3EmbppFLuQZLsUV809F?=
 =?us-ascii?Q?KJH+hUrmjqD6azrZ7yN5yAv0IxpcLBdifqt3pbRAW1bdo+ZQXhVsfu93isyJ?=
 =?us-ascii?Q?2ZgZu12t+cJn63MqEJJYSSBzloBVdbwOjuv4XwXVNxK8/dm+tsdS0GASTekF?=
 =?us-ascii?Q?e5pXy9u9C1eJah1Y8TEy3hPT5xMNKXm9MEoO/axCne1TCjnoGqKdSdtTnZ0W?=
 =?us-ascii?Q?vYEYyA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f522b03-13f6-44a1-1740-08db0557aa00
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 19:57:07.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm6wFUuDqaHM9BWn3EN43JgOzGaWLvpuS6UJuvAdIt1kwEBrg+7vRz9sdR/tQX96ZcHQr/6ki6DPdnXneyJwtF1rQswE/tr/CWveNXg/Sc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7523
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 19 Jan 2023 21:02:40 +0000
schrieb Lee Jones <lee@kernel.org>:

> On Fri, 07 Oct 2022, Henning Schild wrote:
> 
> > If we register a "leds-gpio" platform device for GPIO pins that do
> > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > later. If there is no driver to provide that pin we will poll
> > forever and also create a lot of log messages.
> > 
> > So check if that GPIO driver is configured, if so it will come up
> > eventually. If not, we exit our probe function early and do not even
> > bother registering the "leds-gpio". This method was chosen over
> > "Kconfig depends" since this way we can add support for more
> > devices and GPIO backends more easily without "depends":ing on all
> > GPIO backends.
> > 
> > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> > of Siemens driver") Reviewed-by: Andy Shevchenko
> > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > <henning.schild@siemens.com> ---
> >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> >  1 file changed, 2 insertions(+)  
> 
> FYI: I'm going to try my best not to take another one like this.

You will not have to. I now understood how to improve on that as i am
adding more variants needing more gpio controller drivers.

> Please try to improve the whole situation for you next submission.
> 
> Applied, thanks.

I hope this is still in the branches for a merge. It should be applied.
It does fix a problem but using a wrong pattern, but a pattern that is
already in use.

So this will fix 6.1 and above in the short term.

In the long term i will restructure to individual drivers which have a
clear dependency chain in Kconfig. I will use inheritance to arrive at
minimal code duplication and will use Kconfig switch default
inheritance to ease configuration.

Such restructuring patches will have to be written first, but they will
come. Either stand-alone or together with the next machine.

regards,
Henning



