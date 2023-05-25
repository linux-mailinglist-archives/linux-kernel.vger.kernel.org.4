Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101A71110A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjEYQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjEYQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:32:27 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2134.outbound.protection.outlook.com [40.107.10.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF1195;
        Thu, 25 May 2023 09:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEAy+wBJZk8n0MQ01YyedoMy72elOOpzOYpXH7lVd6K48i91CUnh3mFwwvx8i2p9ThFtYTr6ucZ4cOECTHwuATGF7UaYPRQFSKSk6xOa2uZIz6K4siChPYLAIOwKg5ZJzBC/PYrrl35j1EmvCSjrNW6F2xWPX3k8fAfpstJCpxtIKIaYnQg0C4yliB7nrsg82L6Et90EqM5vybhsCIY2W39KkYsDLOHuu2NAWPtWq/Ch5/Z4uRsbwXNXrHBbTYf36nTOCjWupfNOH6+EbvuJu1uKq2jJxvKCeXSguxuNYwKY9AxKjCtpeh/1isUwibHfXvbkV3kmwk8qjTGKW4CseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfrbqb2BEnuV0sotiFkBWunKvoV7g8hkFsGAC7li+wo=;
 b=Fkf3AT99NvpVY6VL5ccOQDcaCTks/E5TS2LV8JbKGoiFycsB/B2oRi8+wRwL4q/T60/6Cdfey3wrv4brpMAUPRiwVb7Or7Xo3P/L7vdqWI7zBSzhqVF8OmmM+dACE7dMo8/HVvdxW4HN69YqEY4azbNpKYudNI98nB0+tlcuLPTSxh5H0SbPgd+A/JAH2hLyN0319yurvYQmlmuE7X3C662VAnVaSPnQAjuQ2VjQQCeTzYO+vZimh3W02mSPgYNC1UczopzMYBf7kGewno4ZtH9vei5kfA7rE9i/4aaKTnhlDUQO6CdFxA2tQjhMstyvsKYFpqt58FRv0IwozGs9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfrbqb2BEnuV0sotiFkBWunKvoV7g8hkFsGAC7li+wo=;
 b=DYDeOqT4hthaWOVHVK8qrXSMjR7YXfhElwdocgNHWd7XcQEH3fxGnBXHvXqC328xDdlFPf5v/4VQYYoWN0GfWxBhivRBv90rIRjYh+I3mqd8+vIghTvmi/dW3Xm4/uuqOem9K4ZAFMI9GXtf7c1BwkQSmvVm1MeR62SD945FTtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5044.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:13f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 16:32:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 16:32:22 +0000
Date:   Thu, 25 May 2023 17:32:17 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Alice Ryhl <aliceryhl@google.com>, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH v1 3/7] rust: sync: add `Arc::{from_raw, into_raw}`
Message-ID: <20230525173217.6eccda7b.gary@garyguo.net>
In-Reply-To: <87a5xsetq5.fsf@metaspace.dk>
References: <87edn6do1b.fsf@metaspace.dk>
        <20230524111127.2491643-1-aliceryhl@google.com>
        <87a5xsetq5.fsf@metaspace.dk>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0249.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c85f209-f67f-43c0-b591-08db5d3d9dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iF9aZcITz16kDrsyHZA6hJlw1D7PfXNVNbCKq/qyJ0nm7iGc0Vt5UZl/FG1bLS7GkchChUY0KW2F7ZYb1ZDzaSiugRXHvPMp57wsqsRr3nhFOg1/DfnNh9O+Q0k6y/4+ygn8LVItU74AzxqPZbu+qxp4KUvjD8R1sAmd2gUC1/lYc84D/xkBzOj/su6Y7sl/xTPu78K2Ptw7uiuJ2SNaslWZSoSULFLoOE4skmFm15K1+FwQrtu2muO2CwmCZZQ0MBLF+XmyyFhbRqjMhz+umPwhYW3CbovhBr/25cJLZediwKQWRMY0dYsRtx1p+abZejHkumBRBix0zJi95xoRHJlkzHs7X+Qn/YDlEkGBv+drgMhggeSveeGZrgn7TD1VUScUFtBgPqi9NaepHyvmTgVUSwgMAouGRWceoBzA+u8R29x7WUdB6A6Eafq5UpkYQhX/2j/+gDXoe55przQq+qxOfSuUjg/4WLV6uedQAw2vnMkC5xJk7EGS7lTgSugH1IzYaQ9/UcnE8rA2OQZ2saoXesiaqxTDVPuaWGwtBAwYAeD2UPjCwvN2yI805Ep8JP/KlKgJLgjFoDLaQI3vX+0yiPQjL4+10f6Qx9UZxzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(396003)(39830400003)(451199021)(66556008)(6916009)(4326008)(66476007)(41300700001)(6506007)(6512007)(316002)(66946007)(38100700002)(2906002)(86362001)(2616005)(5660300002)(966005)(8936002)(8676002)(478600001)(36756003)(186003)(1076003)(26005)(6486002)(7416002)(6666004)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iv19Y7opk4NR7FwoKaweG4EyfA5Xc+I8ygGRzpLiuaF+5y+z4TMLclIE1Oym?=
 =?us-ascii?Q?MtdXJGAieNnLEyU6bZxh/IeeksrcWOc76NgmQW2OqLczcz2qjRT+nQX/yLXM?=
 =?us-ascii?Q?Rabf6n2bZp6YfjsVAm0jt3q1GH2t75Ru9GO05vl3CXFoc2raztZdaHPb+LHt?=
 =?us-ascii?Q?NLVI8N1BL+zZ8S/WngqahgPVSjnzJPaGbgWTuaGpiSlfApM0ZsWTw/P3O9Wk?=
 =?us-ascii?Q?I/lP5woGo6erokgkj019UW2FA6DZaF4JM76FIlJPph5XjDZr3OoYfta6Wd4h?=
 =?us-ascii?Q?3kz6ZXdjGMSZ2SF4U34N5kYSNwZD8wP0GEHxFkH2IK6YWiGfISV9CU+cwNkp?=
 =?us-ascii?Q?lpLPuwwm0o/L8fE+BWB+BQ3CxDCwJmFrzNEWaJO0v7yWsbfyc4GWrC1KyMbR?=
 =?us-ascii?Q?xDS9VVxSI2HvavM1bOKsej/ecpPFcq11rDEYtkcES2ZHak0xk1tELYPFShRa?=
 =?us-ascii?Q?taRGDZ9JQQrzOVRckKr9demC0eO+2mxZ6fHH3QrD7cs3Do3eByQfg7AeMITL?=
 =?us-ascii?Q?xQ8gV43ivGEkWb2y9E4B9d1hU/AaOYSZDQRf5RewT7cbqoJMe+rkDhzC0i7i?=
 =?us-ascii?Q?An/ZMVNchKRku5gFBKJUAEnomT/n24bEhQHQg0OD1yICtniaFwMv6z3U4h1D?=
 =?us-ascii?Q?GhjxO/hVXM1gWuDAnHoA9AiFlCm4N97x51kHTxwlozhLYquryuPh8bEePjqn?=
 =?us-ascii?Q?Y3BY4U7YmT9gJMrQsy2A0PPbxUUprlGN5kdIXne9GdDqFzbCJ7JpnJ1Uzk1J?=
 =?us-ascii?Q?4YDOFVJIzIXlkberR7ohYkZfkU26gRciLjc9y3rxIyR61jVaoxu/cIzZ/k0Q?=
 =?us-ascii?Q?XL/zAzYdTDwlikNjeFFuV8N/qtbkReQcmPmKZbycIwvH6N/zWYW3xEQmlaSO?=
 =?us-ascii?Q?DU5Nf737vd7MSKFmjtp1QC5AaFeujoLbTlUWlNOmF7iBPUIP7F1w3tKnxLdc?=
 =?us-ascii?Q?BJrQFTwFJsI7bbGqoYk4GSJAhR4OZsRCIiny7xu6gRy/IjuS+uQIQdhcFzHP?=
 =?us-ascii?Q?YyZJCnf/O8AVnmTJ6rwjV/LMu6blMsP8PBSF6KiQ9J4EnVMk4PBFphqYZSYb?=
 =?us-ascii?Q?QBaKYeyS8k69s5qJzbK7S+JhnHr+jI4piI9qo9dZSf9vrrZnmZOOl+NOcIJz?=
 =?us-ascii?Q?vfkYi5PYu45gI5h/lurKTeMqZD8+117FqfKvg0L/tEtgQZpEfOyxHAhZK6I3?=
 =?us-ascii?Q?Zv6yyozsisjiRE2q9JFa8Y2gTQMbTwgv3NEwKr5Ws+nu2ehUnFyrgRt+3nir?=
 =?us-ascii?Q?x1R2rtreLW2kEgHP3XzCAZKsaBXxjIWPkNftpujatPO3GPwdcSlJWb7/feao?=
 =?us-ascii?Q?BgWu+v82FGVmoHvHXfGtjptVK3GNt3uddf2Seir1JUHflu/mTaP/6hFDktAP?=
 =?us-ascii?Q?bF2WlKaaGLfoxQvom2tjo9a0r+D7lZMhORK4/cKGBREB/HVvY4dT1ReQ4c5V?=
 =?us-ascii?Q?WdclL9uS9i1WJAkNBm1MQn3cBp5fVMjof02ZX/Fs6wFSSbSV1gxRFId1kZyT?=
 =?us-ascii?Q?uC4jk/LXnP5ruO+eipfR6FMPz3hVEJIja9ijvgnrq9AttVLZUtim3Opi0MLV?=
 =?us-ascii?Q?7/5tj7icfTuiO+6uk+Nmzk4W5P0XOEQVJqB0tcc+?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c85f209-f67f-43c0-b591-08db5d3d9dc7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:32:22.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O6A0c1LejNJEKn+U7RZtK+MrFUG3ff+7oJQ9GUL2UhwjYAlGYs19Ay2bjX0TVuY3UlCtCROhT3sDxzeGcfIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 09:45:29 +0200
Andreas Hindborg <nmi@metaspace.dk> wrote:

> Alice Ryhl <aliceryhl@google.com> writes:
> 
> > Andreas Hindborg <nmi@metaspace.dk> writes:  
> >> Alice Ryhl <aliceryhl@google.com> writes:  
> >>> +        // This preserves the metadata in the pointer, if any.
> >>> +        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);  
> >> 
> >> I can't follow this. How does this work? `ptr` was for field
> >> `inner.data: T`, but we are casting to `ArcInner<T>`.
> >>   
> >>> +        let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
> >>> +        let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);  
> >> 
> >> Metadata was obtained from a pointer pointing to `inner.data`, we then
> >> move it back to beginning of `ArcInner<T>` and then reconstruct the
> >> potentially fat pointer with metadata from the pointer to `T`? How can
> >> this be right?  
> >
> > The metadata of a struct is always the metadata of its last field, so
> > both `*mut T` and `*mut ArcInner<T>` have the same metadata. Because of
> > that, moving the metadata over from one type to the other is ok.
> >
> > The reason that I cast to an `ArcInner<T>` pointer before calling
> > `metadata` is because I get a type mismatch otherwise for the metadata,
> > since the compiler doesn't unify the metadata types when the type is
> > generic.  
> 
> OK, cool. In that case, since this is common knowledge (is it?),
> could you maybe include a link to the relevant documentation, or a
> comment indicating why this is OK?
> 
> BR Andreas

This is documented in the doc of Pointee trait:

https://doc.rust-lang.org/std/ptr/trait.Pointee.html

> For structs whose last field is a DST, metadata is the metadata for the last field

Best,
Gary
