Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735B6701601
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjEMKI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEMKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:08:26 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A73C2B;
        Sat, 13 May 2023 03:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcMsA/iFjK+qLzS/2s++uZcOh0+9vBwJqhryX/LiZIr+rrtmccwLZulHts25c08ng71LZe5QxgW109eY1ppw3Fxrwr1xWSWLlI76+gzKSQirG26ku1QGbj2xbTHEn7N3Pa31ZIZVylvpTZT0IqbXK700zOKvfA5nv1fUyfy7NzxbCL2OkbXGSehy1x0Hh7j2/rmc52W5kwZ3hAfR/V01PIVx3svVnnT/FiI4kIveIK3gtIsP+I5x74bOdZmfApwZ96Muj2cHr4Z2nM6VK/ExOZYTAJu6VQCtxb4iW1TnvlSLUiQyZ7WNblqzVV3SWmNejncPSpDuzSwAkamMR8p01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjqyCQ4dyVoXKGpkCWPAW2xsdBEEXHHyv+ABrw1F8PM=;
 b=FzItWOPwKv06Y9JH6MzygSrYXi9RxVJSq7AYDb2HiNOMD/HUV5gUthDDxw963RYilwaNafwrz4mfDAmoDnmJbYeOWRVgBvqhqnxm0I014Z/kLn2Y9Xf+LNQ6EVcRhHua6LAvHmu4pQTatYGXz11a7H45DMV07BAwdufHxubuQrY20QG28+0hMnj7hV5IjeJdnHZYcAhV+PwaMdS+FqRoVQVmRw6/DPzXsaS7S+vgYRtDqoKGibXy//HelOmxkYWCsbBCnyIkn+tmkkEUcI4uqAIEwqjLp8Y88JEd5oQYY3pjkYZ/OjxyrmsaICMere1JV1MeF0QASDnv7H2JQNdfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjqyCQ4dyVoXKGpkCWPAW2xsdBEEXHHyv+ABrw1F8PM=;
 b=bwSzpliEquSFbTOJTeym2OOCruj68UKsQm3UVVvWDmBo2e27rwZ6TuFOYCqf9fCwKK03648jJQ3XKId/5r783PA9rpjdNtyNoFjwFR3rNBQOOpI395fFv3YMvL/1AaZUgKIvx7qfyx+Zz99+q06uqqOi8Pd3/I/bI23FnfDdACwGFHioj1J5zOZ5JHzgcRQqI+c+Pk9V0H3zOU1vKTMRq/kTWelks90bJld6MYWbtj95y5z9ePq2IDpQhRwSEcaXDZqWN0mkKnabzCIkaLpLQjowPxDLAGmfMkrXMWDN63OkFtMsmPHEzztjSUoG+TB7fABkT3lUqBJffSPJ35MmAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB5PR10MB7704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Sat, 13 May
 2023 10:08:22 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958%4]) with mapi id 15.20.6387.024; Sat, 13 May 2023
 10:08:22 +0000
Date:   Sat, 13 May 2023 12:08:18 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Message-ID: <20230513120818.21b99596@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230301170215.23382-1-henning.schild@siemens.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB5PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: de7320d8-8cc4-44bd-f3a0-08db5399fbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AJWAeRkOV3NB7S7+jtuExDglQ2wBoN1gfVkbkpF19VAx32VcuztuUsHIBhdA24o0rOlUIyffUJOTlO9xD5Rif3Ek3Zb/hTBOLd2cDCPpZFujOOjVmO0tyjWU8rjpyuM3YtbDoni/CrSpvzT1t6YTRLQdc0VF36sK8sdc/WcenXSg3NaNtW38QmfvTh5HarbQbecm/2OKEuUl9JJwXuUSVn32aWm+KF6KKBVliSVYvM+CiROWyt+enYgLC6xDj4fjuQVauz7H1jdIfqFn0uUUA/Qp49S6aSkPN1h5dFhtSjtTVmp9m8Tfry51ftPpwYwvvGt9qTYtx+S44EaC7c9nvlSBMb4wp1NpR6rjo4whu/Z+mzbkmEuZ6MJj+w3YPUreavECIOJaB6okMvI9kSSTJxQAWJMKpl0uOxHuAVYGWr2oUwh0CqewKM49kin2kwtJ8t9NRGZUh/yo92i2GazWzpIE6ugiv0zqyQjyAubA2jL3mHAbUyUVYe/dpRebiJ78+8txQ12r+uE/UV172mebF+GuQBRDQoU/K5pIjeJUcn+qvR1bvm2gQ+JywOa8uMZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(5660300002)(2906002)(6506007)(1076003)(83380400001)(9686003)(6512007)(44832011)(8676002)(8936002)(38100700002)(41300700001)(82960400001)(66476007)(66556008)(66946007)(66899021)(316002)(186003)(86362001)(478600001)(6666004)(110136005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GH2IFkAKLundT6rweB4aLstBNxGBx07NyF1/n3t1bEso3KWZO9NKsPol9y3r?=
 =?us-ascii?Q?XMHVLYouIEq+ibzy1yTi1T7uAgJXKa+ILwJkoXSwQfAkVfB4hYf7MUWcDLzJ?=
 =?us-ascii?Q?oVgxuKrq5QFvqwDlnTleSrczTBMxmLWtnl7pg8fGEN17r35P/Unhn+y6CMVc?=
 =?us-ascii?Q?RBdnMj2GXQMOa178gDjQu4PtJ0Ua29b8HDAUr9Z1lVtfbqDOIy4dzL4DSU7O?=
 =?us-ascii?Q?GgHXcqhxpsvL+YZA5+fBeV1/SpxpC5X3OZfE6LpEXJ8llkmfc4G8dVm9KZBn?=
 =?us-ascii?Q?y6bP1asX+nkYVRsPw5+Nc9tOr7pc0vKzFxKUlse9j+S6VOZZZ2mxqH1ihSXw?=
 =?us-ascii?Q?t+ttUpbk0FXNJ/Iuo8AHECUt/hXVxrRTHo8AYBRBnUcpkw/t7HgfkjuECkal?=
 =?us-ascii?Q?fF0MwlM92cnm4JZXoObF+uAOWV0o+s3uEF9yE9lQXskNwkiwTlbmQ51R5g2a?=
 =?us-ascii?Q?u9jnO1HZ5CPcwLcxqXtnu1eT7SEig8Gw+WTtj+HpCYCNwG6Vq+PRoroxLt5T?=
 =?us-ascii?Q?FF6At9nR2kG3FjUEjO5H2ApLPYkkaTtBuZq6HfziDtgNjdlPGFhH3YsU7kc3?=
 =?us-ascii?Q?qhwZDc5+jAleYV2c5+X+FE4/sVG3TzkYkWQp8AeXSKfddAwqOtRnJRcRZu6h?=
 =?us-ascii?Q?46tEncYGfr2nw9XSXJpucsALx1IpvzMxQpO2UxYHzLTlYnM0ReQR66SPKE/q?=
 =?us-ascii?Q?sv8VX8yVIwlHP8v0YU5t+q4q9YcH5Hy0DjOuise1wKBr0AJTuAEGhsvhX2Sv?=
 =?us-ascii?Q?7/zIurbRxK99/Mq6zQUFKA0Lp/vxcz5TJ51KawlGa6wxTfntc67PIEafwGag?=
 =?us-ascii?Q?iiJjhUocpwYBDdeK1xWQVmEPloWVAzABaN36wz2F6BBjs4GuJbpr+dvu2VRf?=
 =?us-ascii?Q?mPKpvEw7ejW3OLxACPyZ+6HdsPqZbg3p9xoI7HsWfgq2UonR9Rklpg6t05p9?=
 =?us-ascii?Q?PBb3ws9+wrsAmzBGGR+MY8rRDUXFRX422Hntx4ApH7rvW6t6shnLOjN0CCcb?=
 =?us-ascii?Q?dyNOE0dnegXWYKs9DY5VYTAKu/Xs57YM/GkhFyQ5CoFFx72n1qM8UOXp4J2S?=
 =?us-ascii?Q?5j74OphL9ooR2rVUORYAXKQuXaOzJiD+AghEWkOV2hoJd/P6Icxy7uxXA4PL?=
 =?us-ascii?Q?RTA+Ykb5hS08yxUNbC2OJOuZbZRFgpptfJYhw3VXwiRtiR0nzICpDAnooHfR?=
 =?us-ascii?Q?QbO+I3kVZV2wLI9ETAjKDOMvU237HIUXLSp8JZG8tXdsWYG1BCBo9HVeKGYf?=
 =?us-ascii?Q?F8CK7Dz7YKaZzQqzildW4bBuI5kOXbsqCApschHWfeKaIoxp8YB351PFLxEu?=
 =?us-ascii?Q?pS0avd6CpNbSzBds8YPIgYserMgL/P602R9UquVcKuw2WlXFThQOp9I8cexE?=
 =?us-ascii?Q?oUELBEc3CZiQyBw2F/r26tCw5uMYkVQ0wgDu4YJhoDQpMc2f+Sn+KWcQ7Knk?=
 =?us-ascii?Q?QnoR2dx97nIWmmpJNwyDCYO3dLtKHb3lndQ2oc09Cl5HP/+0Evuzk8138gJL?=
 =?us-ascii?Q?QDluWNl27COp8PbFNwy8/OlOaXpJHILqfE+WnfTdQHA70jCb6tad0ejEeELm?=
 =?us-ascii?Q?wJIOujrHXJxZqLncMvvxLT3bCT9j6swGvIf98H1BIFz2GT2vK3qvWq9LBAaI?=
 =?us-ascii?Q?Ayc8yVC/ZOcZCgJSvobXIX9IqWNq8VCUzLKpTYn3EV96nl8q2t8uxb0nEJeK?=
 =?us-ascii?Q?HRy3gw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7320d8-8cc4-44bd-f3a0-08db5399fbc9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 10:08:22.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0+BxVfOW0gRGcgCcpICbwavzsWT/gJFbi+/+9sqph0fBryEkzCiqfXHKFvyf/4QWgZN5z/ca1bVKGor2qieJxmagOhD6l3OPjlS9QsThQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7704
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

As far as i remember this one should be ready to merge.

ACKed by Hans, and Andy had no objections given the maintainers would
accept the patches.

So i think it is the maintainers turn now, Pavel and/or Lee i guess.

Henning

Am Wed, 1 Mar 2023 18:02:12 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> changes since v1:
>  - move from header- to -core.c-based implementation
>  - style changes from review
> 
> This series mainly splits the one GPIO driver into two. The split
> allows to clearly model runtime and compile time dependencies on the
> GPIO chip drivers.
> 
> p1 is kind of not too related to that split but also prepares for more
> GPIO based drivers to come.
> 
> p2 takes the driver we had and puts some of its content into a -core,
> to be used by the two drivers.
> 
> p3 deals with more fine-grained configuration posibilities and compile
> time dependencies.
> 
> It is based on
> [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
> providing driver
> 
> Henning Schild (3):
>   leds: simatic-ipc-leds-gpio: move two extra gpio pins into another
>     table
>   leds: simatic-ipc-leds-gpio: split up into multiple drivers
>   leds: simatic-ipc-leds-gpio: introduce more Kconfig switches
> 
>  drivers/leds/simple/Kconfig                   |  31 +++-
>  drivers/leds/simple/Makefile                  |   5 +-
>  .../simple/simatic-ipc-leds-gpio-apollolake.c |  64 ++++++++
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  | 103 +++++++++++++
>  .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 ++++++++
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 139
> ------------------ drivers/leds/simple/simatic-ipc-leds-gpio.h   |
> 22 +++ drivers/platform/x86/simatic-ipc.c            |   7 +-
>  8 files changed, 288 insertions(+), 147 deletions(-)
>  create mode 100644
> drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c create mode
> 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c create mode
> 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c delete mode
> 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c create mode 100644
> drivers/leds/simple/simatic-ipc-leds-gpio.h
> 

