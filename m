Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756876A25AB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBYAcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBYAcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:32:02 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2113.outbound.protection.outlook.com [40.107.10.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5A1A96A;
        Fri, 24 Feb 2023 16:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aomnpTA/tgp59DcN9lsmsjQVa1YU1HBX8HdU2gtWF2/Jb2lTcrIG1MDf145j9FroqcpwlZtIo2OOosRcMLx9mFF+aFvKhndDLcLnkIRzbZCJ5gD8cQP00xm+AcCOkqpXwsfiPnmmH3WbosvEDrvbUAnaZHbBaRyJ1m6HMIBeAP94gV7mJrkQ1+ZeIjoE9dBhnKiph8nIy7NgTupKJQI+R+p3wGdKFDZ5egR22eiwNp7auhLSvK6Ij3OQFhVOX9qKYkcrp5RHQgqV0pNw8iaK9po87sjYXxeP0bgBcFuKzuBtmAfzqYRZZGBg2aWQqJBrcQdyuDsDiSSSJeeD9VVMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xBXut21jLU5MX4AAeVPe0Q/ku0/advdKknJqKrE1Xs=;
 b=ejmhyYnSWx6RVE3ZdUzyNhTTRb286SzekKRrqUk+nfypMRrOUMFHjXiaIfbWQMphqoxYB3V2jkhOIdpFMA2l3nyxnQKQFqzGCdzNEa/Zp4101cRQ9Brvb1bPIkwv0wHxiNTXHslV9BYy0oGjdG4aJcdw4ZMzhoYkWf0vmyrQFFnoXidjE8ekQEOn+npjuMc5aFBkwfck3SkuK5wH6rF8s24KLHbBeB1zRJN40EiqB8k9o2vBvfN2PEDv+bGMljd3MiAr9giyI3j39HCliMHH+TwF05ExU6fdurt60LPnU2qlADMa1cYP9wUPzRfZx4VgCpql8qTrC3w0rSvJ3kdUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xBXut21jLU5MX4AAeVPe0Q/ku0/advdKknJqKrE1Xs=;
 b=Uz8ylV55Ov3vh5Ij3MUFdmQ84GO+wAdt6DPmqDu5zKW9RutGlYSnvABVrd+CakEoSUw+UuN+Cn9mxycvgX9LxOsgn69Txk3DM6sfMG9A7bdGOgZu/w2ETp+NtIz/76EAXylOAK7f4vurqbAruovdeLWa1p6CsfZHaRXjLqIdLPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6222.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sat, 25 Feb
 2023 00:31:58 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:31:57 +0000
Date:   Sat, 25 Feb 2023 00:31:56 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 2/3] rust: macros: concat_idents: Allow :: paths in the
 first argument
Message-ID: <20230225003156.4858d79e.gary@garyguo.net>
In-Reply-To: <20230224-rust-macros-v1-2-b39fae46e102@asahilina.net>
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
        <20230224-rust-macros-v1-2-b39fae46e102@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0144.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::23) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3510fdee-5617-4c4c-2c7f-08db16c7b413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVZMz+iMFqd/i30dzrOfPT2cDSby6U36pnkTz3xJ2ncRVapaBhBWhKWy3LGn3WT65iUCQi3F/P32Ps96zKbMLpEDy330ZqDeikQYAFGB6Pq1uVujXWTXMeRQ7MBJz1vVoNmZFLXqtSwnZ2qNrtJUG1ghGY5LmrcqdJMHrEiVgz9BkPOaPkJXDY87XQbazFzwXvEtKpIbYKvas0Kf9vbYeoujf32i0aMhXzQkpDU4wKbhQHEWjSqB5+F79Nj8RufhKQdjINwYdSu2Etk+LG5HPIhv2KQlOycLvk9uG3H8UrvRADs7qfetZflqG6jf7np0KUpIOfBMTHIkXIFCZAI5tq3gaVZ9hAbUQQ2aQvhnRgHojEY48TRxFTp5dOvuYjno51lHqLxOT8AkfwQS5JovZhLKR5yuy8g71+ggmXy/O45zV0s/4gBntNbAPt7ofNL4d5k9oEWfmn/PyyE4ykxvemrZ1XdErDvc4XfyD5tvcUyU4tkUw6GHme8M077X4dtUVzTJAjldtm6UolQyR72k4edawN4cWvUSjBDAlBKxmUTPNKz9ib1NIMsNF1i7+DVEaBWGP6ZeQcuFkjYWmzoshHbcE0gJAVuuaaMQAdjCQ2s0GZ7h2fvNXUXMTn6nSS/dNyYOktxnEPWqJqzOs4q1qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(39830400003)(346002)(136003)(451199018)(83380400001)(36756003)(2906002)(1076003)(6506007)(6512007)(86362001)(54906003)(478600001)(41300700001)(8936002)(6486002)(186003)(26005)(2616005)(316002)(6916009)(8676002)(4326008)(66476007)(5660300002)(66946007)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKfTlJNfwH7KS7/NrgmcTfAqmgiBOLS25l2x6T9/vKOCRuiHcZZaQBrg6/CT?=
 =?us-ascii?Q?LGfds62iE/W3v3qENotMHDrBQkaT00KJ9EgCCkLWvrwuexpstCpBNGCiphUl?=
 =?us-ascii?Q?iWUILL+s5TVfwPdsZ01clYtrdvjaMRiSp8vTHRwcd/KLGxVK6wegST/URU8b?=
 =?us-ascii?Q?S0kVV8s9oIlCCULrmcx3FGDZZpF+2/dguqua91vDqpuTl174Hvfd8i5K3twr?=
 =?us-ascii?Q?t7f4KF6iB8YupNGWQy6w6QajH1E0iMArP/MMUKQp8+0+9blTblGbAvPKu3P/?=
 =?us-ascii?Q?iFhAIVfzjzeFgfAIfWt5n9JOjLdxtSf2ntWEA+HwHuih2tpfkKsHIyAOLPLJ?=
 =?us-ascii?Q?ZSsHv0LXfjjWD3t2DdcFdFt95XoGtaBGxyCuabvFSyKSTRgrs38XMPTphBu7?=
 =?us-ascii?Q?d5sh6eYl79hcd18aOUbaOasO423sFpzJXKxZ7BIn6jK+GMt8r9G1WbfZR6oy?=
 =?us-ascii?Q?eliCgZF4IE4kgbW7lrMs9Hah4/rq4CA1B1SilXMDR7KtVy6rsMi3EL6KjczI?=
 =?us-ascii?Q?wJ+J5kRJkB0FLHf0Em1x4/TjOCrwFAFU/hdS55rJnt2Vd2K+20osK50zIJwr?=
 =?us-ascii?Q?wbMkIIKlDx7BKUuAjRoZjrQmF+5NLrjkMwet1V2+6cn/FW/VDOBiHsxwVi54?=
 =?us-ascii?Q?75JL/DG2AyP8x/CHTIqXg5WVMzO2EWHxsbKn5UeMuiPY41y9ocfBxYYWv44c?=
 =?us-ascii?Q?90g0KXcwtlsGARTe/mheZjNBf0AIkF9aAaoPaFzoTV8OpRPhSaHwJCHpNzQ9?=
 =?us-ascii?Q?TpmBIlosNdu2T9AM3dcJ2953rdx6sgLZWs3JeoECVuEbDIjhTGMuuRs+YFZX?=
 =?us-ascii?Q?l+/UmhQnXh0sflY+V19IaZaRY503/ilclTxlv06vJJ6gNNbcw5eZnhxhuWj0?=
 =?us-ascii?Q?qbxjXO1NvtzTHcPMD1ch4FUiH7BA8oPnvJlWT4xR5yFBLIQJs8iHAv7297U2?=
 =?us-ascii?Q?Me9nu3NPyhyx2vU+7alu7F+RQhf5Q4G0Mlt7YnJb8rk6aZd2qKYcvstNpxCX?=
 =?us-ascii?Q?IVoSWUpYy5d/oVsZkJTUk7mwt52oEpkxAzCbgGAwT15JoRFyBYuCy5LWFfZB?=
 =?us-ascii?Q?iLxPeELfCKsSefzUOykw4vMRezXJXVmW7QnfHkko27v8P5l/YeeibUET5jsB?=
 =?us-ascii?Q?a6eZOIjrSLJt5kwGQq0oOZelpo4V31UPSlCwYAILEK59VvawfvnXGC+DuA3J?=
 =?us-ascii?Q?cRQ0BQZSNn3UFR4rTfse//3FY+k1C5PoQTw+gcttDWYnQGxlHWAdO3sPewap?=
 =?us-ascii?Q?d86RiOB/qyisSLo35iuWa2vx7L827/W7fppLVI3jup3WFvEUfE/czB2cEfEa?=
 =?us-ascii?Q?V2JMWdbBnUTZzgG03oXgkuesjZJK72fiwrDYxItU4v4DJCH1843n58Em1HGc?=
 =?us-ascii?Q?KpxCSJi0r5DL3sOPStl0M8jaXIw+LlZ5HEk7Stk8uw2PdeGjxfS54Fth5Hm5?=
 =?us-ascii?Q?XvMbgyUTFWv6na0vy1kdN3FqWswI/YuxOKJ96VDvqqDRKlWrCtEnIpLy0ixB?=
 =?us-ascii?Q?3IdbZXss3GPDSB4eKxk6G30wyTeKVYiBNiAidDhhZ050BWQqe1SClr4pzq8z?=
 =?us-ascii?Q?TVlzFvjP+VfeoUjnPfD1T8USXst6pn5ZXy12DOoQ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3510fdee-5617-4c4c-2c7f-08db16c7b413
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:31:57.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwj0HxrlhiaDXo8rA6P/qxIHM1pu3y+VXSkwu3bjZfFQmBoYM7wCid8ft3oq5vWwuyzcN8nVJm+GXaZg1fEvNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 16:25:56 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This makes things like concat_idents!(bindings::foo, bar) work.
> Otherwise, there is no way to concatenate two idents and then use the
> result as part of a type path.

It seems weird to me that this is called `concat_idents` despite
working for more things than just idents.

How about just implement a simple version of the `paste` macro instead?

Best,
Gary

> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/macros/concat_idents.rs | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
> index 6d955d65016e..d6614b900aa2 100644
> --- a/rust/macros/concat_idents.rs
> +++ b/rust/macros/concat_idents.rs
> @@ -14,10 +14,28 @@ fn expect_ident(it: &mut token_stream::IntoIter) -> Ident {
>  
>  pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
>      let mut it = ts.into_iter();
> -    let a = expect_ident(&mut it);
> -    assert_eq!(expect_punct(&mut it).as_char(), ',');
> +    let mut out = TokenStream::new();
> +    let a = loop {
> +        let ident = expect_ident(&mut it);
> +        let punct = expect_punct(&mut it);
> +        match punct.as_char() {
> +            ',' => break ident,
> +            ':' => {
> +                let punct2 = expect_punct(&mut it);
> +                assert_eq!(punct2.as_char(), ':');
> +                out.extend([
> +                    TokenTree::Ident(ident),
> +                    TokenTree::Punct(punct),
> +                    TokenTree::Punct(punct2),
> +                ]);
> +            }
> +            _ => panic!("Expected , or ::"),
> +        }
> +    };
> +
>      let b = expect_ident(&mut it);
>      assert!(it.next().is_none(), "only two idents can be concatenated");
>      let res = Ident::new(&format!("{a}{b}"), b.span());
> -    TokenStream::from_iter([TokenTree::Ident(res)])
> +    out.extend([TokenTree::Ident(res)]);
> +    out
>  }
> 

