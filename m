Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27846CF491
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjC2Uc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Uc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:32:26 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2112.outbound.protection.outlook.com [40.107.11.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D14EF2;
        Wed, 29 Mar 2023 13:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/qMuZQqhjZBlFoLj6pcKx52cszSdIW81V+aGicv9PDZMJXmm7IwE9nR7jKDdnMSP9i2/bmS/WvfhBWaMDsj6j3WcuKf5MOETMrmkAC/gsTEeq+fuEmA46J0cXNOQjNty4yRyBuS0Q1JYq0rfy2VjZSjTtgiqZzGgUMywiuEWP5fLpFV+vK5xo2wLtugX9DDrtT2dMEOFGJTcj3ARPZ/wseyrzN0UJMXaaQsQ6oJNa8oV7PFKa+chTLuxwS8gamCY0fElo3AFda+j3rzV4vnacAKTPVYIlXHSM07MqBAlRQoqd2Kvchp1em7YWD141Oro7IOON/EBSac7Z7sHfC2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lloiZbO/Vq7bLhXd4POn0fK2jze3RkG8d2zGKK/g4Vo=;
 b=R6iwcYzIHfTp+x4qv/NIPInVjnrR+a2GJ/obJpDu6uZ+snQ6CjPRUkIjbq32HEiM8jujJNicf7yzpUNahpycz8XX5Z+67whwq1h9MhBPE4Jm1rQ85eO/c0bI8qdd/aIhfSOuNh1a83flr3l2aRRtonMFYVNtuVM8AzalzVN7olq59K4PN/k96WFfqZnfsKqWbuZkwkFYhkd2BEfv1n4+iqtT4YVoZc2Y5SwYoetcZadegbGiWGIfQT0KzuhVSDu2gUUTy+SkFNFx192EO0AGvmB6lLvzG2pl+97kM/kwJNMV9k7lTf+nzkAtKGdeQxT7NdmbN4cHyLnQAqtFYKFPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lloiZbO/Vq7bLhXd4POn0fK2jze3RkG8d2zGKK/g4Vo=;
 b=Esnpih9zDUGY39PfCRusoK4cHnRoPAKDUMCQnr8+CPYXC15NDY69YZrhFUBnWJ2Hd5bB0P/5MRb/N7ZXEOxfJuCw7t3TnF4hhmQ7kwlYLxvaOIBsRp2h+kq53rI9/YGp0faJUAaclp2IgBwmnWePkNtTpSdd1Iro0ODBoH9qAY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB5984.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:32:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 20:32:21 +0000
Date:   Wed, 29 Mar 2023 21:32:20 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH v2 1/6] rust: error: Rename to_kernel_errno() ->
 to_errno()
Message-ID: <20230329213220.37d9ce85.gary@garyguo.net>
In-Reply-To: <20230224-rust-error-v2-1-3900319812da@asahilina.net>
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
        <20230224-rust-error-v2-1-3900319812da@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a28f34-79a2-474c-a6e4-08db3094b2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQz88spiqJEIHvn2BMGxnpihG7F0ekEb3WeSnrsah26kTtaNgLF4iXo6uXWemj3PT3BNGyZgHNHF7PIY31SPANSerfT+VSWxW3ktUBmbtO1cLurIugJjo1DHmEGJC46wfNG0InBtl2LB5lwUBZzMbdS6DSpn5rLs6oh1Lee59ajVNRLaAA8WC77oYOykTHeTz9x1R9ANZyW+MyRQvQfTgqCwAsEPBUQQCLF6A6bEnggtz8cr/HaUemg5/3/zLPh6fXvCrVdlDaV2Qgoq+69CLLcVv3UD0YlVxk2xV6cRPOcLnnYt+LovF1l2/8Sy11I1YCvKMlhEIiROKF8r3vOnDrGzjgabYz8YKm/ZXIMtffnla78COhIGDIOq8OvY35aAie5b9MXGF8DS3515Ht5IpffLRtxV6bI4ny/DwvbTcCQOxVjaoKYL/RZ0c0L3wkEOpCWFARrY0lGUN4uI0NQOgxfSKn3Au3MiASuL/V1Y8d0jL3rtRi1AC2FOh7rr6c93mog+vqwCWZa/qpImuDnbzXoCO3hWjX3w6kx5JmbIpnyI4cizeRaXHMOWOc2UtPZp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(6486002)(478600001)(6506007)(6512007)(54906003)(186003)(83380400001)(4326008)(5660300002)(41300700001)(2616005)(8936002)(7416002)(2906002)(1076003)(26005)(316002)(38100700002)(66946007)(66556008)(36756003)(8676002)(66476007)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zrb3MzaAgi57UhVScQGe8yK/d4HgM3qufw7fIXHjJYLQ5z6AGxIW+8AnueFG?=
 =?us-ascii?Q?1cXE2aX3R5eoS7llh91eap1cQPk5BO3iLAKkZIfQE+QcNI/OhyV4gxM4LIzK?=
 =?us-ascii?Q?bvHlzX0JHJmi1xsoRMB0C/OejSbM/L5V8XO1iOsiskPrY338QAtaNGq97M53?=
 =?us-ascii?Q?j3TltCOIFwBNHsc9tHWJbvuACQC47UN9A+hM3g9tW2V+eff0KsnBnScE/Bd3?=
 =?us-ascii?Q?byQdJ70YvpfDcY88IzrgfElEgDSe5dlsNpN9vfAhveCc4F65+sxPevE7a/6e?=
 =?us-ascii?Q?q81zH+ZKpM+KCnS1UpDzNNoSpwxLxXVK3FXS3j2vud2UdWSMW8nRlD4u2kan?=
 =?us-ascii?Q?Mumiy0+1nTUMpoHZCqjy5NB8V6SoJyJeZDU/2GpNbIBZxM5UfkAOjWAIAGvm?=
 =?us-ascii?Q?JJU8D6diUwWNaNOk/ZJbKGTdVYqp9k8zmUR8PQPa0lQm4sbuvrfZF4bNJIxI?=
 =?us-ascii?Q?Ig/YhFw8jlCheLPiJrkMcFNf5VDKR9DZ7ljGvBJS94yIZBlgabXKeKk5mlke?=
 =?us-ascii?Q?x8rOtsvKFfgQsEV8Z8fcD13xBp1Zopq05srtgZZPBHFj1mLuOC+guXGXVxGr?=
 =?us-ascii?Q?y4Fu398Ywhbbd7BteQLXh8nG+jhvs4CbMdVjLKZzzK6QwuXEexbXo87gqwS+?=
 =?us-ascii?Q?FnSbdMoLEV43Nz8xbP+aWX7001HcGbltS1pN/kB2VfqLnRjxBHKgOT4hCJKK?=
 =?us-ascii?Q?rqUyfCLSTIHfrPDkmqvFC1VJfBetf91ptiOzRm1+CdDXVdIE+1pI8CWm28R4?=
 =?us-ascii?Q?G2gY2a6XxxYj6lqD41gcRPzD6za1z8umxtNIBEZbE6p9vQciuq4r6P5v1y2h?=
 =?us-ascii?Q?l6gkb3eWVLdpiFVQ8ycFCkvoxJ5mmp7r9vSKMNHTZmu7yWeJhPZ4kfDmsfH/?=
 =?us-ascii?Q?CFPYC9hrzTh4AlL07nwFB9rGOx8GS9Gwkwe34KNc+u58XapA2EaVulu5S7HC?=
 =?us-ascii?Q?4dRNlhayIXXxu3Te1vdc+oxiIJfyrunwG+t8NRR1AArYvGIE8CFQS8trB4ch?=
 =?us-ascii?Q?hga3owuEkGr8GjEJr3S/Xn0Y3HfV1ibz3rn4vbuGxW63VvLcdaGS87U8tacH?=
 =?us-ascii?Q?4C8agZ5FWijQTukE+pvsDjhkr/YHvTTEV+UsIRd9V4dFbhD91PvJcyP8/3wo?=
 =?us-ascii?Q?vEmC1UCJi8IqTPph//S5g/Fxlg0a1MscG2ol2H+F9qnZbDKITDUe9DL4OH3A?=
 =?us-ascii?Q?KskyOpl2P1MHWDnq0Fradi10/nQ23eS3n1o7yXOWi+zFCS+3QW2bmOF2ewcN?=
 =?us-ascii?Q?2++ZUyzWGoWJ3JbNDpX++dc00+2dQsHlEO/K8RPYt7E74mxxWnyxpYzECi1J?=
 =?us-ascii?Q?9zYSrj5OklFmmUTx04kfosNPTBlNEVQXQSiAcoLra0MchKQYrT5uRmctkv3/?=
 =?us-ascii?Q?0ivZC5m924pPp/Q9+18atLLoOiVB1buDHRHyXJxQJCW1qqToVaFZgXopD2LO?=
 =?us-ascii?Q?5aYjucmr2QVutmOkd7gHXCrsx/ANI9Mil3RJ9sKWZh0pNKfEPwH1eWYtfmW0?=
 =?us-ascii?Q?rpQbww/rXj6lFmF0UParXmPnleaMCg9Nj0dAZskTiTtCz6I7gNejIx8Ot7WU?=
 =?us-ascii?Q?2R+waE3RbhuBoeHb8JaLV3dvCpt8y4Tm79SKJJ/h?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a28f34-79a2-474c-a6e4-08db3094b2aa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:32:21.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqj8jf1uN6fhHsHCVp1n2dNi4aKO7LPfERXZIBYiOpnYj6fAed6ZzHg4EYIbgplBvpwhp9rj59oRS0MNwRLwbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB5984
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 21:04:33 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This is kernel code, so specifying "kernel" is redundant. Let's simplify
> things and just call it to_errno().
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Thanks Lina for implementing my suggestion.

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/error.rs  | 2 +-
>  rust/macros/module.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 5b9751d7ff1d..35894fa35efe 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -73,7 +73,7 @@ pub struct Error(core::ffi::c_int);
>  
>  impl Error {
>      /// Returns the kernel error code.
> -    pub fn to_kernel_errno(self) -> core::ffi::c_int {
> +    pub fn to_errno(self) -> core::ffi::c_int {
>          self.0
>      }
>  }
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a7e363c2b044..143336543866 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -258,7 +258,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>                          return 0;
>                      }}
>                      Err(e) => {{
> -                        return e.to_kernel_errno();
> +                        return e.to_errno();
>                      }}
>                  }}
>              }}
> 

