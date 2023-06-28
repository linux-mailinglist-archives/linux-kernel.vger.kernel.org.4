Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280174169E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjF1QmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:42:13 -0400
Received: from mail-cwlgbr01on2122.outbound.protection.outlook.com ([40.107.11.122]:63598
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbjF1QmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:42:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8heQGdIzoKTQn/iTap7304d/27HzA4dW2L6EqQ4AeU54EyTDvonnsgWV/ofYyi27C7ly7tVDeq+vRBfcrK1pT+/Ce8B7uQIKGoA8yKMlbYTZZg6zduIAJ4kSa3mS9BEA3Tlleor3ygV587RFopzmiVI9Wxj/juG0OYSKoq3Ed5IrY7mlwI6Dk+qzHLDjvmDmsUUsZhhhLsepno7Q9psig6Ulmf3j9BqY2Tfib7djOl9WD+ZCmxqNI5NdxMZPYwfP6JpFYSLZOBrjI3UB6ePJM+kzUvUveSMylwsUqygmbixcwyXqzQgiu4WrsGtsA6HS9zIKkkxajqTepq8preaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q37Wt9qqH9KvrltQuID1MfM6ZS2y4/GRXrSi41PkqJU=;
 b=Tsq3mdSQT0epRW2I+cLdcptOqdtVf7h47hJpDr323VH0t+Z+O8IelHW1kDcefvNLIg5Ggx/8thwjq5i5NOrtjEYnYo+zOOESDDRk4LgpT9eV7jf4PPRyANsN2G2/+OhT5kjJXKfosezyoHdxeGpSL57u9Y9mfdH6z6FPHcMXt0Mn9OH14ZkDuBg5ztmg25LIE6DBXN2sjANkB8dbdfoQacG37AHt9FuIieMwZL9Cvl+stwKPwLHPNiwbT6o+/OtLt8XPIwnpQ6Rw8wwZmR0Rj0SRgAzdlahY2DygnGMUbWw8a8vpM737S1s2t0mESHhkNQJ6CbvhZXsKXMNcW0yCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q37Wt9qqH9KvrltQuID1MfM6ZS2y4/GRXrSi41PkqJU=;
 b=erh6A/Hu1YIc3OdHCRHf+42UCFH+uthk8x+ZNokvxVLdUOJdjNjq5q8QJI3blN7gmmOzHrua2xPoF5U2fLLQFPF3NwV0yQIpVaLuUxURiT5u0oN0PGNhwUGWLB0mJwq9zlVvwZrYtAxmt4Ir2Hp/VAr4EWmlEK2P21rsZ9KXet8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5570.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:287::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 16:42:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 16:42:08 +0000
Date:   Wed, 28 Jun 2023 17:42:06 +0100
From:   Gary Guo <gary@garyguo.net>
To:     "Qingsong Chen" <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Sergio =?UTF-8?B?R29uesOhbGV6?= Collado" <sergio.collado@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
Message-ID: <20230628174206.1e820326.gary@garyguo.net>
In-Reply-To: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
References: <20230626074242.3945398-1-changxian.cqs@antgroup.com>
        <20230626074242.3945398-2-changxian.cqs@antgroup.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fb44ab-7066-46f5-0139-08db77f69d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ge7wFx+ZHStrbQYR/4kNOq3XnwLPAD1OBH3d7oPK0ifyNpYEjPmsLxewtZtqkWqjgQo6WuuAQnR1JGcE0MYJW+VsiUFpQpp5tDjrkgXZzZjN8uCeV2w7r/bVr6OxXdcqtKGYXLC9ER/a0PPncohtVOctOtjPWwyUTq/Z7pzCEftOv2Ozl9TfmURUfU9gcblvJ+VKJ1PrAlnBk0thFuwfkXqfOqiDFTfF/4q4IurybGRjqD7p2Zu0pmkhAocqVVA42M/z2/uGd5ZPeU0BIj/5tPEVHmON0R7dgs5ZAJiDuwFprk8Jz64Y6fH26Oshqsqbow0xPL8hPgDWcboSM25CL7ibiyAodosQZziBkPLGqehRkdnLli4wDkj7n2wK3GeqTxuiG+RxkQ7z7Hb1dKAmXKLbSuW/UwEAi68CNwaWtKuuGhsjLwufgByEaFobqKhC2JvAHHD+woR4L+7pdx3u1PftoUwx4yBbDcwGPCUr+hX1q6jogbX6BxWL7GkcoJd/WIldNWdb0By/14QhPpt7rsCfHo5j7LLlkLfazyR9LfMSi1CUAq/EXi3RnGgO3QFXMwPyKWNTNlZFEApnS1pmN+TXa8k/OPaaLB1LjkPJPNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(366004)(136003)(346002)(376002)(451199021)(2906002)(6486002)(83380400001)(38100700002)(186003)(6512007)(2616005)(6506007)(1076003)(86362001)(41300700001)(54906003)(478600001)(316002)(4326008)(36756003)(66476007)(66946007)(6916009)(66556008)(26005)(7416002)(5660300002)(8936002)(8676002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XKtluwzqqOBbbhs6HTSPSHGT886opHFkRp25vFd44xXa3dvj0guLY9JU+a3c?=
 =?us-ascii?Q?Uwz3neQUV8JdFkOfUtTrWdEiZ6GAvj4B/aMcv+47l1/CqvKFu3VA05YxTmqA?=
 =?us-ascii?Q?Wa15FBRU8d1JUyT8/EHC+uz1C3qM5po6VqHGk07H5CEKtV+lIwQ6JiueSsLG?=
 =?us-ascii?Q?o1b0osIvse6Tg4Ky6+9OZJNpgSjCWAuzfIF/Zd2Z6eHz1BzHHZLLC5cJnt8R?=
 =?us-ascii?Q?/v1olA6yPp7XdEc6i4zpyYlFQ142baaPnoWZZiI27Os0ZCMcz7IMAtOPX5sW?=
 =?us-ascii?Q?ZIFo5l9NA8lU/umrEastpkWjxvnljrhLKfOGEgfr/5Y+xQNGJKn5NMTJg2Z2?=
 =?us-ascii?Q?CdusHa6fmLhpsD/1VjQ5tbP7VMgwrLWOlIYdiKamMH5tYGT886Gu790frCVW?=
 =?us-ascii?Q?KlOOpWcURCKLQNN/YpaFqupzTd5uok/MhUozjwZWED/6/59F7MnAbrg4coAj?=
 =?us-ascii?Q?9tY0RJZrbWtB8drx/kTuzFwhl+jvVvTAGLkHAbWA4UUd/j3IMjZ3WvdWuXJ6?=
 =?us-ascii?Q?X7fffdFzYzBqQsHttXPw4LfqNviml4CHGZB8+Ed1qmvRPA6nOS1uPJZXtQyv?=
 =?us-ascii?Q?ZTkthVFX3Eiz40rQuF4dTplqaiQOu18DR/KH6k1pdF4l2S/KA3ZDuqJUOERN?=
 =?us-ascii?Q?quUfTh3/pGLFNj6M1eBNrurFqjOFrtA4UpItcWkRe75y+zSJVHBGCwWCDnO5?=
 =?us-ascii?Q?53sCe7FUzA8J8l7BwpacXQCL4Ws70EKvnBmIq4VEKBU65doW3z4oB0uWt0yY?=
 =?us-ascii?Q?AAexDuZ08uvxvnv5sG8Qofdov2IGZzxQ3IuEPICaF0cJ5VJ1umyCSGeIUooY?=
 =?us-ascii?Q?EPiHV7AxP9bZokqqIQLw8PDygkb9NsyFjtHYQ1Z9qEN9EForVeQyyeFsqgum?=
 =?us-ascii?Q?+ots4pLoo8LIqdejC0pQI/Z2Wk/l8ioxuFBSscHutWg3siDvp8bbuOFkR58b?=
 =?us-ascii?Q?qvYp+fwW3TyY9agO1pTggQXNqZ+mDa0ij+GYjusWa05yEEpvwpRj+9fOqvuE?=
 =?us-ascii?Q?PKq9HC2NT6StSmOyFxgZL9ZuhLPcpg9kuWgLhll25CbOlgEYDn71IFOS+Usi?=
 =?us-ascii?Q?erijYlqJz9m6gyeu+mY2w25vQOozLqpsfI3HTryMYV4ybHThpgqGGHs8ngYT?=
 =?us-ascii?Q?8oyQY51RT2yStvj3/8W2lktrT+vWFB3BrObhVtWmYdO4/q6GAg4JjDZvInz1?=
 =?us-ascii?Q?a1Gn3shyzE2kURoMfGvjp6ZSssMWUdmmn/W+CxfjXgDB526OAlsuJtjQMwTs?=
 =?us-ascii?Q?u5HzYzsUHdACpn/Z6a1oqb4X1v+Gcare5Pp0bZFmNw/HXC3vKOq5Mkt92OQF?=
 =?us-ascii?Q?pmkBMVBn87eBNR/EeAFvV6UZpmYcDPPsibo1den3xROkR3ZBr1bC32rc0DeU?=
 =?us-ascii?Q?wH88kQcNjeANGKk5bWVXH5mnztTh4/JMIsAC4ZS3QY8aD8EHZSC01g6BOHXZ?=
 =?us-ascii?Q?pa6O6ti1qCS9R93AgAjF5pMYG1gMJLPleO5o5KwA1keQ4WDyXCSQCHBkhFLh?=
 =?us-ascii?Q?5/dHoDuUGs6iwtWM0n2RLwETzSBocA+muMKDeruit+FgN51Pnd6qDRkJ80sb?=
 =?us-ascii?Q?jIuwH0BblxUnSxzNn0o+qQPWS2hzffSIDlj8BegY?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fb44ab-7066-46f5-0139-08db77f69d09
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 16:42:08.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO816HKvCCODZoOYQNbk2B0nptZdsyrrVO65F5q/pu7xKway6aJXsJDjhWCpWF3lviJCjc7e3+qyazAY8IMnYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5570
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 15:42:42 +0800
"Qingsong Chen" <changxian.cqs@antgroup.com> wrote:

> If the trait has same function name, the `vtable` macro
> will redefine its `gen_const_name`, e.g.:
> ```rust
>     #[vtable]
>     pub trait Foo {
>         #[cfg(CONFIG_X)]
>         fn bar();
> 
>         #[cfg(not(CONFIG_X))]
>         fn bar(x: usize);
>     }
> ```
> Use `HashSet` to avoid this.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/macros/vtable.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> index 34d5e7fb5768..08eb0355f99b 100644
> --- a/rust/macros/vtable.rs
> +++ b/rust/macros/vtable.rs
> @@ -27,7 +27,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
>      };
>  
>      let mut body_it = body.stream().into_iter();
> -    let mut functions = Vec::new();
> +    let mut functions = HashSet::new();
>      let mut consts = HashSet::new();
>      while let Some(token) = body_it.next() {
>          match token {
> @@ -37,7 +37,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
>                      // Possibly we've encountered a fn pointer type instead.
>                      _ => continue,
>                  };
> -                functions.push(fn_name);
> +                functions.insert(fn_name);
>              }
>              TokenTree::Ident(ident) if ident.to_string() == "const" => {
>                  let const_name = match body_it.next() {

