Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EAE65A685
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiLaTzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLaTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:55:12 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2106.outbound.protection.outlook.com [40.107.11.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A41165DF;
        Sat, 31 Dec 2022 11:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djCXOl5skfXuyHVEuI70sjTwSfLqo33R87d381Ir6swO/eO9Iwe+HVlTKhN7cLl6iFCwa0tYpNXZlTo++IynWYoCHWiqLzJSaYIfWqOEoGvXaE/T7R96sLpwpJCixqSGfHkXupeAc6D9iSKyBnaxYplZH5lS+IjmG664mh9PzUaV3yLj00KqJsNEgmPr3vVJuJ9xsIjmQHeLkc+Cn80Hk82L8IwUI8Za1xwEf7AnKpAF55o/nDDaWgwHYcr9bWxyJj9t4jtISRiDa+udBXSmXJJfsoiD6uUcYyyzcok5FJHF7LW2/vNYoEDcToCtwAQxLn8ryHtsiwnEM/l/RdwUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8YGLgYdqnGY0K0WsQj9r7RhrnVjZRcRSJczOSS7Eq4=;
 b=XoneJ3mj4kWvh672foIvqyA4fJERXheQwRkAf3Ytr7r9kaM3ocPnZyIAXuXTI0GSikd0grkgB6KyZIqgTE4Wk6PzP2cLLFjO5bYxPHrDx4H4BMbw7jkZ6nP6ChBAgmy3ns/azYFGcC0vpFREc//CuszxjKun+xEllp1odbXOf1RFgqgZi2SAtV76643TH+5TVESD7TGNBwh+aV+sxglzwzz4+pp00oPUjbX0Wzb/SX+/fAre2j/2Pgwoo3AgNppXTasXL/N/S27kSlpXue2PwWRSzh8XrUQ4SzkaNSfkyeeWaihQb/nu7HxkA4WuQ8b77sVAqbSJkLpY+6A12OpFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8YGLgYdqnGY0K0WsQj9r7RhrnVjZRcRSJczOSS7Eq4=;
 b=iiiY/DifjGqZG8PtFWTITfk9dL0LyJnmVzuXkh+OA7Hub9hPlWoWJzvMBWbhdNyMNiUJhKWtw4dQVATJc7m4uGoVq1OTvh/6lJ85wbG/SdHLINj5lzOfYlhhlAzmYYx4+3z4aP0+ucvdcjr5oDRFw1CsUtD9rIHOUm1pcBMc1aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2096.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:55:09 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:55:09 +0000
Date:   Sat, 31 Dec 2022 19:55:08 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
Message-ID: <20221231195508.7783a774.gary@garyguo.net>
In-Reply-To: <20221228060346.352362-1-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ea7cba-8f15-4346-3a4e-08daeb68ebd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unsr72jI2kgUvmocqMKkSgqADT2d5rMmdBdoZ1uasOi64Zb+Md5SVspiFc+zlll71Yya58hG9KDu0fnDtwbT857MnKY3F/UHDhZ/V9KlrVU55VGxPvAf8m2EdJAxOnytySVZ4Pu6rEWtzS8upBbHsy2m6RYvkPduOwq5+7Zi3h/soU4ej5+3uISIrqEBAMgi4Yx7uRWnPAzlkaevphyVug0/tdxsX0jmUs+d0BBytOkfqqTIU78v14A13YayDUowEoLB8b87RJeDmTbTd2+hv4w/7hB4xV/I4l1XbsEOHWJADOV5zm7CG7kJYiYcLvruNDK4HNYXDYILmtYI73Ka3Y7iwC1DWYxmMs6XnzsT2JdR2BxmiMrNRZhMLL8jM2blSnTEEOK4WEB+x4oV8tJuW15qAWA/Muh6iaxo0+3ThGVFYyz7LxA9bbJxNPLpTuC6q1u+PUsbCNI37nZFsOti77tbylVvF22BnRk4NoaNX2m1gq6e6pA/5Lt0voQa5/7CgLuf3rwhZeI/4AP5mfNKwLq3mKxTKq7kPNZgjl2o2vWMHGsFMs75DpkoTIe+27XhE8qmChYRqjSNPp4X48OZQJ5XTzU6eDNMUrGEawtvZB2B4yx+JJNPnMPe09AHBbACcKHsD6tZbPya32t9uVOtF463032YBgiKlzip+lYBmCXxEkL/OFTsVMeAh2VS3tIe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(39830400003)(346002)(376002)(451199015)(2616005)(54906003)(6916009)(478600001)(316002)(36756003)(86362001)(38100700002)(26005)(1076003)(186003)(6512007)(6506007)(55236004)(4744005)(7416002)(2906002)(5660300002)(6486002)(41300700001)(66476007)(66556008)(8676002)(4326008)(8936002)(66946007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vxa4fWq2cZumHsa7oRR0p3eB4F+I0naGx2NI4keIQ3aI7ckkHexSTtPVWnwe?=
 =?us-ascii?Q?QlmADWe62M7WfvN6SLYYhjlK+wSyuo7ipPMPhXyI9dxxfe3TlXa1GDq90u9G?=
 =?us-ascii?Q?gEhyOcgLD2NZL+bDzNBvZpJuAxW2Wc3JtOhs7ju+KXblRT5t4k8o4wil8qxs?=
 =?us-ascii?Q?VPPwdT3lVNwl8uyiRvXzkXpP1/XsupPu/VWA5klOmnfR4M2H+9C+sdGNknit?=
 =?us-ascii?Q?pI4ti8KEfBBb9s6Dh7x0xhAfP9hugJLYquxj5iec7xn2cHRUQ9Eq3Hmwe0Mu?=
 =?us-ascii?Q?zI3HYzGe86ht1pMs5WNiKYHAihkOpyAo3/iaJYHIdBU+dTBVshO9lmWTglN7?=
 =?us-ascii?Q?+cFdl1a3aQctKFpw+uuBBMUTDYxvTmpKk6HzAU8hNCebKocIlIlQodoPdNjG?=
 =?us-ascii?Q?mZd8sdHPzJYOKz8pir5+jPjg10tXoJJprfG8F0xirb2lvLkYpffGYp7ybqr7?=
 =?us-ascii?Q?YthleJuuyzaHr40fjfbAPmPJRpOQa3g2BhU9Y9Ud49AkezPLxs6ccTNLVB5X?=
 =?us-ascii?Q?wPtqfYdNDxX0KhVeJi9TynQ4X3lVMHc5rEHcINwY6Ud/tmyRhKjP7ky2Rx7w?=
 =?us-ascii?Q?Nv8ksfTmfS0O2NIP4U2KXWvt7Txi/Usoa1dHA+wJ5+sy89RNG7WsRPK+Lnmw?=
 =?us-ascii?Q?YXCU7HVq9dDMsVCVg8Dm1prqQ8f8HKwo+tPDbwrrqaWOhjgBrKFj67UUexji?=
 =?us-ascii?Q?hmXvynlNqgGRrojvHIR5VDSsUirI4SnJBeKC0QxF2q8g5aBDeqej+A3SwFgU?=
 =?us-ascii?Q?7O0kB60R1E/GewtnrT+pQC8pIf5Bc4Npl0Hhw5hNKhpD0pxMNfjetHVcKH8i?=
 =?us-ascii?Q?2bXkrVme/qTeueHeydSd3XnZynuBBa7KCs9piUw+f0URdFRxTeJOVdUWptxC?=
 =?us-ascii?Q?x28+f0Y2q528qqHaPSqHvoKmQgwkWW8TbL0LempUnuCmFf5BDBEwBEJ81+HK?=
 =?us-ascii?Q?LTX6fzVx6QNxY95vh3Nizz4HP8vviUtjwfRHBkcc+GPtzBH/DH4R6lmtGW6e?=
 =?us-ascii?Q?tzsLA0y+31OZAu05Qulz//SWxSmtD6y8MpEiSAtbbFaM70zs3cnVsjy1NqHk?=
 =?us-ascii?Q?7FSqozHW4CqB1L5ZYZJ/8IQHZWVxvsRV8XTc6aLe7J/smZZeF+kCi1iblKhL?=
 =?us-ascii?Q?2IwQ9XVejFxUp4ZybiYmq/4vkEUKXwaWMQNguhrtKXXqs38uvJgG0BYMGLmW?=
 =?us-ascii?Q?UzRk8yXZAXZRPWPF9CT18uJo5k9KPcdCYckkeR+OmaL/a4E9h7+dzMpyj00d?=
 =?us-ascii?Q?qHls1CfYYw19kOtzpOW6Ib73W4gmKpkhhyihGQgpW4/enDL95rC+UwSlrDS4?=
 =?us-ascii?Q?7BAYsV0gNEMKmCokCjsxc2wBDvQ1J6DdtUTy8j89isZF2eSaXDdnP4GFjYso?=
 =?us-ascii?Q?kjUjNd9B5f3na8R6VhadOlZmByXtcrxNFxcqOmHb3Bq84kpTfzw6I1OQTE/I?=
 =?us-ascii?Q?31MPP/GuX5fCTxvuoXR4wrTuSkiuVy28CNBoRHXlE/ODqOuN79XdOGApaZUL?=
 =?us-ascii?Q?CTJg8viNRJekOStn+WuCxCRpV5uFuRDD6w7Ing7eXIb1rlHs9JEC9uyshL8z?=
 =?us-ascii?Q?YdSW0YxcQHVqkbOy9tI=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ea7cba-8f15-4346-3a4e-08daeb68ebd7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:55:09.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHuURqk9XXeS2NJYgq8kbbeekx62SR8NMKcbyzyBuKC5e9HVmdc79i1+0dDu4f4M4O1iKoJjdt6Ck36Rnz2SKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 06:03:40 +0000
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This is a basic implementation of `Arc` backed by C's `refcount_t`. It
> allows Rust code to idiomatically allocate memory that is ref-counted.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/bindings/lib.rs            |   1 +
>  rust/helpers.c                  |  19 ++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/sync.rs             |  10 ++
>  rust/kernel/sync/arc.rs         | 157 ++++++++++++++++++++++++++++++++
>  6 files changed, 189 insertions(+)
>  create mode 100644 rust/kernel/sync.rs
>  create mode 100644 rust/kernel/sync/arc.rs
