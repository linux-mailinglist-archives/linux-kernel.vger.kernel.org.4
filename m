Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCC8628284
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiKNO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiKNO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:29:34 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2122.outbound.protection.outlook.com [40.107.10.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E0C2791F;
        Mon, 14 Nov 2022 06:29:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfGGGMZR60DgUHR19sQyFgC6xvHTaCEGacIVk9EiG7wO19zFNfz070vxwbbiS7At0EUkJrVvHWeU4utXCTEJkKFN2GnNAPrrKSrTXLuIr4p91FtExm3It1r3nCDA0Nq15INGXaHjuc6lBgDmGr5qJlb2QWqgKmV70LFeeTA4C4ac4EJzD+ErdUJKs88oMAkBdJWfXIeanER+niRExqf62mGYqqXEMwTLREWDL0Gy2QVFwjtmMJp86GVGhPdx9xurZ4c9HA1uq215Z6XGADgwyrDGdx26yO+Nq8yFGPKQUvcSTvIheOs1vNGkhIP8/sTpYl31HqlThjZtPzw/0QdfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqOd8lBTSz7RfMEzWocGeK32oeQMwyckoLE6n5anBtM=;
 b=gVRal1+5wYvmThdSS9Or7wp4mdSfbL0hTVp501M1qTrP4YB9fVHp8aEKP0oivOehCeKDmqmUA/aspU7A6Q6wTHNPmPvUnwukG9rULr6SXaF+enlUl2U5qxaRwB57Ab0e9nmN0eed3f4yw6Bejri9l3yACJnLNUkJRAUyjmMdBUSDBEORTHKDM+Dfm5mCwWHC8utzKVq5Y6cOfr8cZ/nSM1oHW6+UvPJD6m31NKZm3ynI5IUUX9ZD1upcJQgn6+zylKUHgHO+v3RiteLuoY3s9einLPvUCBd+yfG1kOZ9o98BqV3Uez/Qm5Fr7wPXs/BSkgmTntAC9MUyiUQnYQK1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqOd8lBTSz7RfMEzWocGeK32oeQMwyckoLE6n5anBtM=;
 b=AenOEJBtYchWDPTpXyw6NlJBDMLRsOT/uX/Tkwrias455Hdt1mvQ5hqB3op1AcI7JzncF0aPOi2RrmQ1I0xIxzDqDX6sW4ceEsM3DlPf02VB5BjMYLJpDiquI4qvJmjSmbLPXq1EA+oBtdng/DtsHQEV9V4PHzhI4QorO4rhaH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6873.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:327::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:29:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:29:31 +0000
Date:   Mon, 14 Nov 2022 14:29:30 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>, Viktor Garske <viktor@v-gar.de>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 09/28] rust: error: add codes from `errno-base.h`
Message-ID: <20221114142930.3a5a2157@GaryWorkstation>
In-Reply-To: <20221110164152.26136-10-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-10-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb96af6-ab50-4e4b-f92a-08dac64ca4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzTrnnJBYFzsA0fYCbuU/NSEh6VxogbPa+vLCP6haF/E1dNdwwzVvZwbChJFxH1YEO7d44OcTSSzGf7s4baPrSK7AHHcTgbSL0QOIWcf30tcre/tsURQw2yZhmitTSScAfqn1Nl267feNSdGutF1IOh1kUWPovrfe3HjootW3MSqi9BbniLGKLQtKsL2qGljznKAb5vpc3dsItf3M+7ih7/UcFRi2LRX0NTggHZWBhtcjDdDdUEfg7zW/EDqBYsHk+IhM6gjB0f4usw51ZrILwMBSS6+wKG36vOPLs1g8LJ9hP9PN4qHHyD2B8q1x8sIEd7mbNwhDMECzZXX6vrKeFTNhiLXfu0/pLvlFEw2AcTFkpqa1MxcVfpFeZup3e8lAAsNbovSoB96ZdJOta3ZiowApgDHg/SCivfbIXfp/QLWbWnRrKgIRNTfQmbnf9NxfWFSl0DcoMRAU7XSju2DL2DkIVRWAS3TeF7BHeDQ6CJsTPjeYh4rCHjn49VAScm1WLSD3oVCh9WKkAZZ2xLnd9Lwp3+jTEWXWGvwhbXxQvaNvudNJZowi7LutQnEtn3kwvaks4FKRMvfloaNp+UbilKPcq7MOu1x4UGHqKuRsugBK00nmTAo5KlSC+PQr/XNneEKjN3P+h5i0ZgjTzirnVHj1pq1l9umQxHYzj60XrqFb7213naCk5ob6km6We1TBAOfFwuT1iDS+Yi1dXa7jlfkJXlfZQn6vWIdiAGcVt5ft5F58lY3IN+S6pjRrmI/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39830400003)(346002)(136003)(396003)(366004)(451199015)(478600001)(33716001)(110136005)(54906003)(6486002)(6506007)(86362001)(9686003)(6512007)(316002)(66946007)(8936002)(8676002)(41300700001)(66476007)(66556008)(38100700002)(4326008)(1076003)(186003)(5660300002)(83380400001)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PIm7zOPM8yenkMcXDhGcx67YaHK9Rbx1Hmfn8dDvA1PF1oMIexiHxjIwMX9A?=
 =?us-ascii?Q?aaQCNcv9TrOK0jw2nf8tAM4qGzx5DzI4F/SGFAfnnkqtPZ7OCLWYQg/AJDC6?=
 =?us-ascii?Q?MVeT1k/euqVg4cHhhVqwOhRyXehlL1QVqYotkV/RdR/lX6xLjdofI0dd+GxV?=
 =?us-ascii?Q?pFeUYDgZAJju/eKb8D8JM1oXhNpUo+TWxZjj5hnbHgXaLwtLlFE4qA98/WWn?=
 =?us-ascii?Q?muycOhd9nJXH2lJdS1LYYQ1WGQLLd3cPecLY2hAvXszWDs8xhp8GSmT76UJN?=
 =?us-ascii?Q?MKDbCCJNeDB03i8mvcbcnoViCw6yAjZ9DYwYsXmvbKwfPVfAaxBAIwvr5hlN?=
 =?us-ascii?Q?SUSMXDXTrpfHOxqIYQTz6ee+8Au4tHcD7N/sDZd6v5NklytdchxmBMi/zMhy?=
 =?us-ascii?Q?c/wxIjVmCng7JElBd39n/NwbQc35hHYx9Maf38o8UF38ubbAYyhO6myG5U51?=
 =?us-ascii?Q?0QG/b8gDOEyVevmuaLYYvMqTP5cF0LH2SUApLtCUpCcOso9qKpDaGueR/dnE?=
 =?us-ascii?Q?Lkcc/0M336JIcDZYqL7wyg6WQFcGE2EB7KYHYo89ONCVyRmm3/GKK5n1AHDu?=
 =?us-ascii?Q?0yVUj/Luxelq2K3y6DzkENrNYsRRyeGi3DDqjidzFZip3Qb9/A+MRB+CEpYe?=
 =?us-ascii?Q?ZeEA+hrbUNMPBbvYnfCvch3pWqDK30xJEdgpTAXPxN80ULihfod8Erpg3PVX?=
 =?us-ascii?Q?28+ZH/5sKPgPWTb9OjyrzTWyDNB2Q4xokDUbTIt5pqr2JQaYdoULO/uhzCuG?=
 =?us-ascii?Q?CR7/kYMnQpzf94BxMAVQQM+omI6prJAJ07BJgqe12ge814RUuBXW46clyT44?=
 =?us-ascii?Q?537+e6O2FCNmFts8Zl37rJobbUGt+m4So5OgmFN4rWS8pEv61vUxaBzR9kPf?=
 =?us-ascii?Q?VlzuzJF5MhvVGxi4pcTieIKD0LEcEUEEanGPv2jSDnKEdjlM1bDxFvCITY0O?=
 =?us-ascii?Q?GRRzxLleHrI3/ELkqWPjLjw8dKVYlDpyQq1Ob4433avyv/V35h+lrUTUvDt5?=
 =?us-ascii?Q?BOEWsIOmpp4H96lx1RCTcTCSnrf9ARS8VeLtd4FKCmCI1MmA5QAgrgDP4cNY?=
 =?us-ascii?Q?T93FhQTarE8X7hHC7IjAaWkwIYrRL5JGn+rZYciPWyzP57l3qLqKdQ+w1Pv4?=
 =?us-ascii?Q?PlCAGoJ5PB67goQhHHOEp9+g+EE/iOqrT8Q6hpDX5dB0kLvzt+gb8qw/TKlT?=
 =?us-ascii?Q?A2VlAUktE6FGwgy+vym7jxCkVO3qJz91dgYp+Cdg0kXh1nb87JFQttCQBmb1?=
 =?us-ascii?Q?th37K8EMDULf2yNxLxgfAemCEq4tpDmfMjgCq8ytfQ4k0uWsvJnLoFXb+KFa?=
 =?us-ascii?Q?sOaR1SQfp5zWR0TnoQ6lbD4uW3CUvTKs+ZPEOvhmuAC9RHJJamC9Ygr51c1L?=
 =?us-ascii?Q?q8BNtBw41/yHq47m9BlppDe77gS/bGCGX9+tw4romS/iRtSP+iLyiBvLxElS?=
 =?us-ascii?Q?Tg8AT0DiV8jqXBsGz5W0IrSuYxO4glZhrB2rLhVkOvknNuaV0ybXPXPVRA4T?=
 =?us-ascii?Q?LkY2cEsem7MeHD1iZgny1P+C0LI1IwV9ltcPm/1GCge4W0tvjA3RU5tsCHu3?=
 =?us-ascii?Q?qjzS9zvAft5q7apdRIckFcBUNm5uW528VNqgDoLXjAs4wMDX5YWcCieJx4k7?=
 =?us-ascii?Q?yKx+2MtGYGad6Vzqm02/5piceUwH06Ra+arpzwSPfLDG?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb96af6-ab50-4e4b-f92a-08dac64ca4ed
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:29:31.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOX4TpEdzG0MBgoMzY+8JZApz/8WFy7Ctfxxi4xFj0VLg1SV3N6gwxRVCcKJpGYooVz5qObJcYJofF0KptGusQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:21 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Viktor Garske <viktor@v-gar.de>
> 
> Only a few codes were added so far. With the `declare_err!`
> macro in place, add the remaining ones (which is most of them)
> from `include/uapi/asm-generic/errno-base.h`.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Viktor Garske <viktor@v-gar.de>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/error.rs | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index b843f3445483..861746f2422d 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -17,7 +17,40 @@ pub mod code {
>          };
>      }
>  
> +    declare_err!(EPERM, "Operation not permitted.");
> +    declare_err!(ENOENT, "No such file or directory.");
> +    declare_err!(ESRCH, "No such process.");
> +    declare_err!(EINTR, "Interrupted system call.");
> +    declare_err!(EIO, "I/O error.");
> +    declare_err!(ENXIO, "No such device or address.");
> +    declare_err!(E2BIG, "Argument list too long.");
> +    declare_err!(ENOEXEC, "Exec format error.");
> +    declare_err!(EBADF, "Bad file number.");
> +    declare_err!(ECHILD, "Exec format error.");
> +    declare_err!(EAGAIN, "Try again.");
>      declare_err!(ENOMEM, "Out of memory.");
> +    declare_err!(EACCES, "Permission denied.");
> +    declare_err!(EFAULT, "Bad address.");
> +    declare_err!(ENOTBLK, "Block device required.");
> +    declare_err!(EBUSY, "Device or resource busy.");
> +    declare_err!(EEXIST, "File exists.");
> +    declare_err!(EXDEV, "Cross-device link.");
> +    declare_err!(ENODEV, "No such device.");
> +    declare_err!(ENOTDIR, "Not a directory.");
> +    declare_err!(EISDIR, "Is a directory.");
> +    declare_err!(EINVAL, "Invalid argument.");
> +    declare_err!(ENFILE, "File table overflow.");
> +    declare_err!(EMFILE, "Too many open files.");
> +    declare_err!(ENOTTY, "Not a typewriter.");
> +    declare_err!(ETXTBSY, "Text file busy.");
> +    declare_err!(EFBIG, "File too large.");
> +    declare_err!(ENOSPC, "No space left on device.");
> +    declare_err!(ESPIPE, "Illegal seek.");
> +    declare_err!(EROFS, "Read-only file system.");
> +    declare_err!(EMLINK, "Too many links.");
> +    declare_err!(EPIPE, "Broken pipe.");
> +    declare_err!(EDOM, "Math argument out of domain of func.");
> +    declare_err!(ERANGE, "Math result not representable.");
>  }
>  
>  /// Generic integer kernel error.

