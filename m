Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EE7416BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjF1Qsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:48:36 -0400
Received: from mail-lo2gbr01on2091.outbound.protection.outlook.com ([40.107.10.91]:45661
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230425AbjF1QsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSwYUavF4Hk6MS8SK2AVfd3qPMZpRhjpC4mPoGW7skrUfIgt7fNiv0ky+jInQVmvthyi8f/xEur4PBbeBj070u9IbH+omz2np6OMTo82z2+ojredJ90FB3hffC2SiB20iT80bKrrk7VX1AWm9hxVDLgUVqwsT1+I675SU1n+kMuDGi25q6APwBOpXGLXu4vn32CG9Jw2jSl3jHtrW20ozBqNknF8AE9qjgSS57viyryag0ZPGX6aRVII8tQ8krELzuerI0mf04+pGKLN3pWowklx8emDlu9eo6PGMeVJhGFO6O+DB/zZf+Ga3X9KFZhbZS+nv6jH76JOBdvYr2L4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEi4K2QCaUHAazkJLv4svf0VlHj8+5T4vSwDWYvoAQ4=;
 b=YVOCs65cO5dFSw0soXaigT53zSukKkniRfz/bQxjmtdMuRf1zNfswYjv/M5pKA1aWc1/LLodsgRDHTI4H2GRha7rkYoNzhapjN+Np4IPWSDhxXnEQZY6uEFoATLl7EGHPgWn++JDRdvA73TuUXqyHSzPhQ818I6ecLhoOzAc+TchhjVJY5I2cFNerRTM+lFcO8RHUbCHVjnL3IkRFQo4TQr5kZ3EjawQAxKUe8MsMML0LHEWhiEvshYw6awJIBS/emyo0RN0WotIsEvtl/N0J2oDMPAGVOB5ZbMIZFnXAUhQdB6K6lTCzc+Qg8cLbtYXYgMYYGTCCtEyfAeB4Ea0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEi4K2QCaUHAazkJLv4svf0VlHj8+5T4vSwDWYvoAQ4=;
 b=dTqHBF71CetZVy9RslWjXBK5AXUWLYQEqv2EpcxhBE5tHlTVo7ekszEpu9xAxp90eOyH7LKBQQB2/x87e5jtGJ65BRBstCyvnNJRIjf42gbe1gFQ9KNx9irDz47MnBvF/q580fYsnczCemuz2IqJ7zVckMWYCEG0/Xu5ni/iWMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5404.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 16:48:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 16:48:10 +0000
Date:   Wed, 28 Jun 2023 17:48:07 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 3/7] rust: init: make guards in the init macros hygienic
Message-ID: <20230628174807.5eabf3bd.gary@garyguo.net>
In-Reply-To: <w4kyaXwWZEyoBoCCFmVtRmkUS6d0m_DJYTs7OVWLkbBX7PFwjj_wemi1mtvSemjUyhZwSDCA2l-5fXn4sxO4C3DT_8wGyZebpea-wQseOmA=@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
        <20230624092330.157338-3-benno.lossin@proton.me>
        <20230625215453.25aa38a0.gary@garyguo.net>
        <w4kyaXwWZEyoBoCCFmVtRmkUS6d0m_DJYTs7OVWLkbBX7PFwjj_wemi1mtvSemjUyhZwSDCA2l-5fXn4sxO4C3DT_8wGyZebpea-wQseOmA=@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::33) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ae3721-c6c3-4d67-4187-08db77f77483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGH/ZPsuMS3RmpoGA16TCKfJsw+P8LP6aDmVhPNAYWPcUml79KkIRmJt2MYDF6HJ9yjo0OyK+POfYItyZZSPr1yvxz3ZguRUIJ1T9j6vs+u9GfYlJ1re+1Qpmo/8o6DrrOFt8fFDPQwqfu4NQDmDcid//rgPc5aECu/pUKltyuve1h0yjDUmv5F1+vjnEPMW5rAc+L57M+i9U62ZYMlXz1lGIA6VpEDi6E7NYXOnAA+Nnc6vUFg9XNOMAcWYnSTeqZzhw82L6YHf9Wd75p1Til+tiuCftcs3M0mekRPnedutqSpJCsmqyepTSftPAwuZ7GDI/Q1IHWYu5JuWqY3GeucvjGMcYAelCm6rx2KbDY4YL9ICXifcdZRMW6QTbESzHO4sWnnrUAh0KYV12U1lyfTFcDPOClIToQnDzjdL5cH2mX6WGEJwWD/3zYyYS0KUp6MmqbVhBeXujZZ1LqUd0iUFjQxF6rnLQ0h53tqtBYeT8fs84jKMCRglad2lv5+G8r4Ej/VdoWV4efm4dEbeC8KTrylVYj7j0dmBQp3OtAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(39830400003)(346002)(451199021)(6506007)(86362001)(53546011)(478600001)(966005)(2616005)(6486002)(6512007)(6666004)(83380400001)(1076003)(186003)(54906003)(26005)(5660300002)(2906002)(36756003)(7416002)(66946007)(66476007)(6916009)(4326008)(38100700002)(41300700001)(316002)(8676002)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4W+DiNMEzf0N2Gx4Zzk6L9eNMU1irUSpholttpaXZ6VlGYpIHOHf6++87K/?=
 =?us-ascii?Q?lFfup1dy5TQHCJzvIrjOpv0bYxta+vgoUjszVN3n/7jpgy2scRv6K5Lf3fak?=
 =?us-ascii?Q?kyWFI9mMEG1Ni28DknUJOQoGwnDrVxWw8isdFCIVA1osscjVpiw39dl/wDcK?=
 =?us-ascii?Q?xBLhzgks+lOX3/NnqPtW2PhFbwA0Qwe6W4A8ymQPzk0anpmZiOgKrZ41Hyaj?=
 =?us-ascii?Q?9yLuuoVtDK/cOT12pcy9SuuGLXRgsVqAYKJbGYmjTTIkDpYI+fHHou96CGob?=
 =?us-ascii?Q?OgenFxf8cTaqx83QIxyJCv95hKYLjV4NaUb37WlANwauQX9FGQlwO/srs/wt?=
 =?us-ascii?Q?mZquUutl253vBsghkp1PXfo0mSzx3ZhHqHiUSx4YFlYiqHguPm8m+zziIV31?=
 =?us-ascii?Q?iQbom86foPebsoKA2meMCCc5ZYggWEIW9ReZV7jZeJuQNLFf2W0xKL23KMT0?=
 =?us-ascii?Q?CENTpbP18hS9qzaD/Sjx6tNMlOjmsYKFl4cpp/LIbmiSBIF76evSv4GaNHMe?=
 =?us-ascii?Q?ouTBb6MFqRiwyc5rnLkG7Z9CxjWXRuBiXyPaHNgcShhL2tCcYi+zIFoPEU4o?=
 =?us-ascii?Q?8vFt8vT1Ts8nf7yZlzrC0Mh+ZKB4UvxI2N53a52+xtSCkP0gAllt7gScwroJ?=
 =?us-ascii?Q?1gn226w29mLmPzoWbheXJSzVdvcE3EaRUuGz4R/W9LgYI9YK5khL1vCM6ZyL?=
 =?us-ascii?Q?O7wY4EIwmfJOWsPGSKLcUbejO6ruKsE6OG0vpYDpBcVwJ5H0JoDeMYNC87GS?=
 =?us-ascii?Q?Lgtpn75aT2qLOF5am0HHWMcdy+twzspoD9G+QZFViaOE1vXrtE1XCzboUuaJ?=
 =?us-ascii?Q?vkb/31K+CfQzd19wUZ2WUeKvKLg9yFpbpN68M1Wru/wZ56FpF2dr98YalZfJ?=
 =?us-ascii?Q?WywSuOFy5w8U4CkdaN6t3zdXZZUef7bmdLFKhmMbxEj3WTwDwD8JIBru9sJ5?=
 =?us-ascii?Q?Jnhx+Xxk9UisY01n6H0tPLppISBZYAXOTKDD0fjLdZ/lJm6dLzDEkjof1h7n?=
 =?us-ascii?Q?dSLgBRcpFDzrIoL/YFY1HAQoZsrw/lQGJCZhCgKD8RB6XykqduKQd4JtbRkc?=
 =?us-ascii?Q?2ScO4BfxwKQP/3sddvfoTpmS4ZmE3SlHjtmPpFO95YQFM5KZ/5ifMtJ+Sg8K?=
 =?us-ascii?Q?TlZEVeNcRxT5anTO4pefxxgXHzxPZH1boHq3nOjAuMpw5V3WOim+oX9OJH4D?=
 =?us-ascii?Q?/9qHDL+6Pj7e5e0tgJuKCq0lxrEboRQemHsOtWI2ANWwpdpR+ryb4bFXFHrL?=
 =?us-ascii?Q?kCBQwDm0YQS/Xd+hYdkMf96WyYFVU8HQRlTU4ai9DcRG7U1Xd6TzEvlmjZ0x?=
 =?us-ascii?Q?cufCyJ9110gAfHnLGQMZRIbVWZwQN9Xgc0EIOjEhklvbuqkpRPg7tMRklXeT?=
 =?us-ascii?Q?yUD7RmVFRKvHWQdlt5/I0LdtEXvZjKfcbtIfoI/f361DUONBWcI+4ilidT7u?=
 =?us-ascii?Q?a7sWmclvfm3okSE072uhGgSbvN+3cyPGmgmEx8RVRUxHK8vP7pUN+fGJ6R9u?=
 =?us-ascii?Q?Nctji6ClIGhdJn1z9eNm0nLa0O86w+JQHSvBcbHl+nGwoysF8NAkZbnGLvg0?=
 =?us-ascii?Q?82xH8kUDW6yxRXNzlwFQWKKFcIjSRVohJaWtW2uq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ae3721-c6c3-4d67-4187-08db77f77483
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 16:48:09.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82XRRMvJiOfOF1JAn90ln4BojWhjDfojOlzlPHkiUVqTlFiG6J64yHqg7Lg/b7d0UPSoIX7/NprEfq7+JBo+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5404
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 11:41:59 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 25.06.23 22:54, Gary Guo wrote:
> > On Sat, 24 Jun 2023 09:25:10 +0000
> > Benno Lossin <benno.lossin@proton.me> wrote:
> >   
> >> Use hygienic identifiers for the guards instead of the field names. This
> >> makes the init macros feel more like normal struct initializers, since
> >> assigning identifiers with the name of a field does not create
> >> conflicts.
> >> Also change the internals of the guards, no need to make the `forget`
> >> function `unsafe`, since users cannot access the guards anyways. Now the
> >> guards are carried directly on the stack and have no extra `Cell<bool>`
> >> field that marks if they have been forgotten or not, instead they are
> >> just forgotten via `mem::forget`.  
> > 
> > The code LGTM, so:
> > 
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > 
> > Although this will cause the new expansion we have to be no longer
> > compatible with a totally-proc-macro impl, if we want to do everything
> > in proc macro in the future.
> > 
> > If we have the paste macro upstream (
> > https://github.com/nbdd0121/linux/commit/fff00461b0be7fd3ec218dcc428f25886b5ec04a
> > ) then we can replace the `guard` with `paste!([<$field>])` and keep
> > the expansion identical.
> >   
> 
> I tried it and it seems to work, but I am not sure why the hygiene is
> set correctly. Could you maybe explain why this works?
> ```
>         $crate::__internal::paste!{
>             let [<$field>] = unsafe {
>                 $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
>             };
>             $crate::__init_internal!(init_slot($use_data):
>                 @data($data),
>                 @slot($slot),
>                 @guards([<$field>], $($guards,)*),
>                 @munch_fields($($rest)*),
>             );
>         }
> ```
> 
> i.e. why can't a user access the guard? I think it is because the hygiene of the `[<>]`
> is used, but not sure why that works.

Yes, by default the hygiene of pasted macro is that of the group,
unless explicitly overriden.

Best,
Gary
