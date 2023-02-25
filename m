Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD16A2C08
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBYWOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:14:12 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2097.outbound.protection.outlook.com [40.107.10.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9517415550;
        Sat, 25 Feb 2023 14:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SziCAC+6J2Cju6iIzDKuGzvyIlNGxJfyA4c9f857O+aUE1+jREIajhDjny7NZEkc5GgtkaFYiJ46v49MTh4OyQlZSsgjW80xy5F/2dJI+g0Ku0uz9Nb81w1wFEYY2KxSTU4Rdjh2E6QVSoZCkjXtc37thqZIuiagx0DLSpz5/88WtL9clk/p9qBBaNmljNRx2D0FoINXGvDOFnKD1E3UpgV4absjYMmWZWmSh6c8ZnNdR0UdidlxgpM/cWlx7YEzVGnTZXHjXnTBvw6HbzmqUv+2pkMjGP9yWHnnKJA7WVlrq0e6oRomFrF9RTdCZtZfg0p+qe4HaFm/p45MHJYmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcWkp0EN5hB6kuivO+ypPbtAvGJAP8GKySfa878AhkE=;
 b=c71t3XzliN7JLjJWhWEYJ4WFNOlTlBHGYjE3DIjqZXqErWsHc5AZ2SjSImBUM+hiLOFH5V7P3U4T1+3b8pUoIkUGnwQbeErtIsHsTHkYgF0T0kKMwtQej1XatzYIKqNhVcqkU+F/b52Up8qkyZ7sFEXCa6DVdCw1U30xUBHnW6tAk5pGU1IuEswMs8Xo786xcovcL80aT/DOnSC6mU1SMIag1/a2t8tC9AAG7qO4Q2uMqI6Xd5/+fznofvT/Zsz+EkepzQLPr2bthocjQMDDq++zmlXshBVpODlw6VrjpahifE+naQ54Ack3a0qrzemqdWu9Sum38LJl4t3CerJLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcWkp0EN5hB6kuivO+ypPbtAvGJAP8GKySfa878AhkE=;
 b=O3Guw0ggZnN5bcxKLdf9k+u36byHaQKRl3tnKt6xMwFX7oHyHBH10OtbY5mG9GbhYnYY9PvPu/2qg8n/12VwFpJNFtwwu2WIfk7Jgk8FzXe8iGNa32Y6OW7uTLrBZLDmMJnOy9Q+QE169zmt6v4a/zZKvqL2VVKisfpwlJVPETI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2104.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 22:14:07 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6134.025; Sat, 25 Feb 2023
 22:14:07 +0000
Date:   Sat, 25 Feb 2023 22:14:05 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 1/5] rust: error: Add Error::to_ptr()
Message-ID: <20230225221405.62e989c8.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v1-1-f8f9a9a87303@asahilina.net>
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
        <20230224-rust-error-v1-1-f8f9a9a87303@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0591.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2104:EE_
X-MS-Office365-Filtering-Correlation-Id: 075a8908-346f-4db8-730d-08db177d9caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CeF21aeIHwrGAp/Fcnmv8CEMNLbE3pcADf+EwZ8BsUudxIf9BbAhNdOmmNZLud3/TLhLy1WjYoutaQRYqaUdcgP/3TM24esM6UYOhbzZ62PlbFBrv75ayq3LXBNSGV8uO213UhsYtd7NHaSJxF24AOM7tCe7u2aDdJnZknOIs5uLM3eRfGq9qJB29v5HiqnJTQg3svk1V9/F929iDwPo4sUJZ8YtE7lfE16qeQWmAu5FEWyeeZhNlYn3hhxTYCEQlUP9xSLZCnkEupHWD3fRMt6tHDxKwg+iEOsK1W0ACqiUa1ym1j5Gs1GTtUgRFEfK7JEXHNe/hwR1eq/+qGwZq7XuEksil5b5P+R8HKcVsAojsXNZj+c0Sk514FA1rNQl7PhBruP80bgpmPJm2D3ORWcei1/VKBi+XCmrZf78la3OU2Xp910waG3OfWskTDSGHXxoHJtwhePmav4wnqZNITHf50wtHNGq1HSgkpVAOq31OMBNxc7m7+1k2dB9V/Ca94r8rkVEzqjoMcFJCbZzfa1KGii2iOmM23uLvOATCyupytMxm38pb/KroupdZdjipHJiDEaqrzCtRr0+rkepTq7B1P4tbFdg5U6sxXb9xKzrNkXNwUrEdOLOc8R5RC0txiC5VXhdvemmcjl708qvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(136003)(39830400003)(396003)(451199018)(7416002)(86362001)(2906002)(38100700002)(478600001)(6486002)(26005)(6512007)(186003)(36756003)(66556008)(54906003)(316002)(66946007)(8676002)(4326008)(6916009)(1076003)(6506007)(41300700001)(8936002)(2616005)(66476007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kfeSB7KkOenHujjxXfl9Rk3DUL/d5DOQRkmp+LFOg/SkrUKjuMvAu0tidLSd?=
 =?us-ascii?Q?NHZLzqLuSOFeRxH4K2yzmteY5/swoeUH02r8cyU6Bj66naOaiclU5vLH98Ky?=
 =?us-ascii?Q?ImReNMqEB3fjU5KmtdfrH40MzcadqFINBEtFbNzCHo04SU0QtwctorlQF3zT?=
 =?us-ascii?Q?QgUOgDf0ZcnJI8mP+45fYtj5yw7TWpAQLAwyRQZWr2R8vYFhHeRAIDaYYMPr?=
 =?us-ascii?Q?RqDTPLlIrWy4gNW/gwOF4dug1K25gTXHYq6GrCH6wQmhyKwl7ft+QQTaEW35?=
 =?us-ascii?Q?Zu2n9ZgopQoDjXmqBY9PasVl4uJRfRJUGOsQQcVlKIH2W9/a1QW6WRc8JIG1?=
 =?us-ascii?Q?u11JLZAzPQglBOC0jv6CZ1IUX4cML52qg6WzFPfqrZ67MW23RnIyDKkYpUm7?=
 =?us-ascii?Q?tdc9q3ZzZAJFLvBS3yrLyZlqzIbRQPvLOx0FtN+ycEvAMz7V9O/5lD91GaRX?=
 =?us-ascii?Q?wYngbnfpmi/gV06mcOU6oRoupIDhMR/K6a+hOJpYvYo67gYlWr+uJSM2nGpq?=
 =?us-ascii?Q?tqM+qkMNrGeHAPPHwIEsz0Ce5InKyw27slIZBOt00QQnZPw9cY8ME/UYOsGS?=
 =?us-ascii?Q?ObSMrciVYptht3kukSlv8lziVR+v8JpwkV/P8uq3CiW3/u2otOdqViT991Io?=
 =?us-ascii?Q?WpgKYZnHnsYf9MNF5+QNE58Gxv5OlIwnkV5l4FlQV+UMy5IGYOKo2mH2wUrV?=
 =?us-ascii?Q?V3M3zjmGhx9TeKbMApfLksMGFF4divgjPuG9kqEcPTA38DemwY0BiGEazc6R?=
 =?us-ascii?Q?wvFy367N79dqqbjLQsRnF6TL6Wtw258PYUZD9tRYJSy/yCWrOwMvea0Xz3/R?=
 =?us-ascii?Q?61nqwfH770CHUwUe3iWLuR6bfNCP2kiLhE8ha9+b/s0FD7hAx+8GQeq73Oau?=
 =?us-ascii?Q?ZxSakT29pVqOHa3D9Yk3om5FCpZ8ki+K+MJt58U0mdoZzFbVPXhlz1PsTCzF?=
 =?us-ascii?Q?Q076Hg8WdPnbzdQNp+MYcNlZZmsQ3TfXcjXqctBxN1QM5vNDElmw6tGgQmCX?=
 =?us-ascii?Q?uWyyFHe8GRAZK3HnpZr6QSoRGqdYpY/HFqXXIsuLOIUGWsOPuUS62iSfibkx?=
 =?us-ascii?Q?qzGxly8PngIDafoZ8WIOy53Dm1ttwMQYbUIbW+1uIi54IAE7rAWVHSZjKPoL?=
 =?us-ascii?Q?HfV9e8SmsAgw0Zzlp301EVwb6dA4017p6bTYaYe0ivWUYoAcvBSsf0pGsOEi?=
 =?us-ascii?Q?aQMJqHmQMBUBzY1f3A0ZaT15Xb0dC3S5C+fR+YZb7VkzMDcQiFQIBvcdyVXK?=
 =?us-ascii?Q?PbWBMVgFJBvP6h3v1LA+He2b7wfHM430Cs2147e86XfPjycJfptWmjDgCeaD?=
 =?us-ascii?Q?f7R4W4vcJfuwiBNMRzmVywT4OsQk78iCrg8+v5miAlyVg72oOiSDwCF3hDYA?=
 =?us-ascii?Q?p2IMt1g+T7ivPcVLSepPMaZqNZckVbbcUGZG0l72Me/8jxAtIRYG3h6Huk/R?=
 =?us-ascii?Q?ONTxA6XsnGImxl7uuZSvNn0AigbMeZOZ9g7dJdXex3hPdg+sJQZMDuWdja5G?=
 =?us-ascii?Q?j5JzpQrL7zt0wfrqdmNX6vRaxjMwtLPbHhK+PZLmeJm6upB9l1/YxzsfV5kN?=
 =?us-ascii?Q?BO6zrlIghiPJXlYSVNn4pZZwNJAhJhgeCF+Xo49r?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 075a8908-346f-4db8-730d-08db177d9caf
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:14:07.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL7BTDBj22UaC79LGaWyZImZRmd1JFS+fd/uwRbrF6T+t8bB12b8HbPZ3YeavR6GGgDeTnYpmRzwzqZ3FPo2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 17:50:19 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This is the Rust equivalent to ERR_PTR(), for use in C callbacks.
> Marked as #[allow(dead_code)] for now, since it does not have any
> consumers yet.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/helpers.c       | 7 +++++++
>  rust/kernel/error.rs | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 09a4d93f9d62..89f4cd1e0df3 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/err.h>
>  #include <linux/refcount.h>
>  
>  __noreturn void rust_helper_BUG(void)
> @@ -46,6 +47,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +__force void *rust_helper_ERR_PTR(long err)
> +{
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
> +

I know that we already have `IS_ERR` in helpers.c, but having to go
through FFI and helper functions for something as simple as a cast
feels awkward to me.

Given that `ERR_PTR`'s C definition is very unlike to change, would it
be problematic if we just reimplement it in Rust as

```rust
fn ERR_PTR(error: core::ffi::c_long) -> *mut core::ffi::c_void {
    error as _
    // Or `core::ptr::invalid(error as _)` with strict provenance
}
```
?

I personally think it should be fine, but I'll leave the decision to
Miguel.

Best,
Gary
