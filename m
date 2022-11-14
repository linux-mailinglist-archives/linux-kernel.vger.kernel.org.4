Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590B2628275
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiKNO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiKNO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:26:16 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2137.outbound.protection.outlook.com [40.107.10.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F60959C;
        Mon, 14 Nov 2022 06:26:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbQJ+9a+ZinnRk+D+jk8D6IQF5MOYeRgw1uhN09TndlB2SKPpAU9fZIN/ixvchf57NN3tp5zpTSi+tVZKYnvcGDmWjYCo9fPJurn+Z/H+9r45pzUNGFiEPtsfGsHgcnXURD+iwddMIsmnpJlSnPfjtXZkGSzLszBeWu5VO2anjENSL//7T4rCq2Lv97GK6hFXwKUrsX0YtwIZOtB/YYEu94EJBUcp1tPWa+7ywVxg7R77f7qs1hfnDIsym0L02gXG2V/i6m5sZZsok7jWaZhYWqa3WYKUlzSwCGiRBhIV8ttqP51RjHQhliLPNLXdbDYqzF48ajt8m4bb6k+kBpu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/RNqhSpv7MjnYsunGjNvImwCn6ds7cqXxOG+zSdykE=;
 b=GGNoIttzP8nNJCGFkc4mtpl2z8VTVznGpLw3WgcXC1KfXjBlYCy23MKoMNGwXeCr0ot04EoVDMEXx7weZl+rFxVymx8/H1Ip/gJxI5bhWOwVPKOrYD2OWNG7afkMAzCjuu/Z0x2XT7XM25ff/0CaS9/Nm1Zup67oQ6Mq8iJGCDepMcADnr63sLgCLG/aHSXal1/DVtjBIVxcM5f0ClZjklUT2/PGGWRFjPUiv2Uyn7FtqMEwObGVDJF9a/oVo+cjc0K+r6rhLcrW9OPzIowv9RRU4w/zuG0sjrO8LV33pQaNeqx7WsJ0FhEt+pewadD7uvABiMGyhagtGVCGEEeivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/RNqhSpv7MjnYsunGjNvImwCn6ds7cqXxOG+zSdykE=;
 b=zgO3eDL6fsE4NHo09aSbrHohdW/oME4AF96KhsJ8628ZL3EQRUTWP6adscwO2hLfJB94qoOU+7/ajt4MBCUhGIDePtz8uPLr/3mYdXZH0OKuOx01dSdizrl5EOp5ceGDfeX/F2CW4IW/LVGQ3Y78v+MbyGKi2UhB8xqPQpT9sE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6025.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:292::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:26:13 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:26:12 +0000
Date:   Mon, 14 Nov 2022 14:26:11 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 05/28] rust: macros: add `concat_idents!` proc macro
Message-ID: <20221114142611.2a21d4e9@GaryWorkstation>
In-Reply-To: <20221110164152.26136-6-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-6-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0318.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: e806705d-5183-4033-27f5-08dac64c2e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDRnumTYZpgckAAaDQBLhSGtmmVb0uIs/VS7wKE8btkU3G6WApl5g9XZJtJgfk/DiwumEoAEahMJsSXE0HGBNv+CQ9TVFpPtPiStE5XWXgS9zX+qUqUKxETSjVWFhH50QwKGDsfokpyeZv8+6sjtiU06TGipHk3SK9cPdUU6Ib0wJ9jsy+C9zuMm3ZZEXUYJAAD83rB7qOnNovRfupCa4MfyYegcVPXovUvt3QtO8one7ltn3RQ3XLg1TTQTe20SJDz4F+EVk9JxdATqKBsZ0nAF3LF3FKQgUxwc76o40E7Llid8HoQEF11vMmv2yvvDj5VAnKnbDd/+r75f1AEFPkwugxrRtaXKVxO3oKo6uVsnjtJmOAZtTpXG17Nv3z1PMEE9v3S9vurrtbLh+C72IUs/8tO8rSHSiTF/wWzz8wKl05HyIt0ZqCx2oXHvs1O+r5yGQ8ohyQHnTYjA2xUVpxG6LJNthWg5OnroOfMmtM/ZwT/ro/0IxjLa/ufIGQbu4cpqQM82MGBy1+Q/9XEkhBSL/YF8DMnhGRzI0CqRfgqqQnfnuUlJkt/1u2hPJip/uhoQOwTmIC/uKXbB401rvLefFdndOkgGMT5suXCVn63sdPP6G1gJCRCZSAxMcYsGA1PyLzj5U1uv/ZJ9n4dtXrFpD74YOm32U05Tg9ixUqiW/1p5+0ipv8e1r3UIm+opNB7/YArqv7U8FC50xeXxahKlFzkX6HIZWCa5Cv3WmOTO1g2NI748rn+UAiZe9ygH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39830400003)(366004)(136003)(376002)(396003)(346002)(451199015)(6486002)(478600001)(38100700002)(5660300002)(8936002)(41300700001)(316002)(54906003)(6916009)(86362001)(66556008)(66946007)(4744005)(4326008)(66476007)(9686003)(1076003)(186003)(6512007)(6506007)(8676002)(2906002)(33716001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39nzC3q4cX2eK//NooeD++Xtx7JMk9JykTzBikLFgOz6bt0G/RruPuqlvBms?=
 =?us-ascii?Q?HnI3kCj8bmjYVdaTIYuVlrLIt5pDUcyWKeFn7TVkHgvRLzB3tVQemyBdl6Jh?=
 =?us-ascii?Q?H5DEHrxPdN2fDIG0RzPnyhiozLvgWa+tRQppmTSfAvJkFP3kkJtXgy+7VbdN?=
 =?us-ascii?Q?0KsGnAbvmO+UQRq1EGrb2ZkbZV6yf4HUo7LqlP3TCvYXDqnUGeD+DUABZQaz?=
 =?us-ascii?Q?k8ZiEZ5ZYS5h1FpYfWZe8xiuMcTxlaBfE1C7ezeWAMzFEczvTHX6KxeVFUPd?=
 =?us-ascii?Q?XmCIKBCfmORpDW84VYWw5l8gIq/3G3GMBgEAdEOgeslGDzpqtn59wSsv2Q0D?=
 =?us-ascii?Q?jHy0vd4fOWEk9ZWc/V2GgqqVaD6QeHBmo2+G52OaFXWLl/AWETS0aFNIToTP?=
 =?us-ascii?Q?WhyBo56B3Nkqh8+TN8DSAnbzcOTKJd83XBlGVXgp0RuDcJAz2sw4Znf0mcw1?=
 =?us-ascii?Q?UMFpa3ZQA+xdvBG1xrdpSfOKvOYdFftvaIa0bd1J/ufeYaRIFjVic3VcJxkS?=
 =?us-ascii?Q?wBWAnRd4AplGvbMIG2A31dJjhgPQJUIHvyF5mKY/QM/+veF483NtYyptE5lv?=
 =?us-ascii?Q?/9mtHpo0MpPa9sZKr95BBGzcZXMNdTSbCvzBh3Ay1RJgakkYuIvivjcthgNE?=
 =?us-ascii?Q?mvcwVJUr0ACDIVU1qFcFTeGhVH5u50VT3ygPPayyA2p9OBza74o4MhojCETA?=
 =?us-ascii?Q?9ePifrVdi36WmEgTteMuYQNd9eFjNFMUzGrYaZGKCzPVMOTF48dMwvsPpWCX?=
 =?us-ascii?Q?hRvcoqoZzMFMlHeuOG2f9qr+ytRmdbjSz9Rk1qT+WoazQNP7Ajg6K+6RQF1B?=
 =?us-ascii?Q?lO8NK1amHvSkeAszJvPIEz9VAnS+fanYW7MeCb5KlpbvHhKO+ibTXawtOcyO?=
 =?us-ascii?Q?JuWBrWWWkJKaaq1b0dN2ychUehqZMabcoBuRja7z2ymWz7ub4QvaE0UYex3x?=
 =?us-ascii?Q?W8xJrMsZYVER8S+DcZTEKPp1sbbhls1ykNY9dirocVM54g6tpJ/LcwyT4Eaj?=
 =?us-ascii?Q?hgab9PvZ2fmlnf9BhtKOhAfjlcYU+3txFs7arFz2GB9YwG9u8z70nUVj7dSw?=
 =?us-ascii?Q?bg1JNGiIsGCgSmcG4d8G+XYNEfGl+QdyD0Y82LrwIzU+0+EyAlx0K4QR90xE?=
 =?us-ascii?Q?FAqRxLj2CjLbzk3exX59VqnbrhAMWuuscz5A+ON0b7xwgFwHOwzOkABuX1Lf?=
 =?us-ascii?Q?sTtxGJDVAf53wl9KtR++9dH4/Ug18EvV5vIeOehi5Q37ODEvogUhpGTm0iQa?=
 =?us-ascii?Q?TTi/zl/1JoWizD+/yoMxGetdPKjdKRI5gJh1zqtH55x0u4U7GzAlfHDpeTnb?=
 =?us-ascii?Q?tteEEKBBrBMaVaX+33WgtTOtMt00H//KfnR3SojUwIwe5V4/mTcWXW7alC7G?=
 =?us-ascii?Q?+GrePu7TIS2npNXmMYr3d9UiyUFEbcnHIUTi2Rc5QBxlNpYHX9IwUt/MKBiK?=
 =?us-ascii?Q?1CSH1u72J6MHTJd5HhZcL7ymfvXxbOsdjOhtGsIrctc2vMZjd6NxyY34dkeq?=
 =?us-ascii?Q?XFzISS5nSnIYNIvoUhYyK1s0awGDgSIQlcZu+VrjAegHfubwjKj+u5jAnvG6?=
 =?us-ascii?Q?U8GjiaFgUdbLdXL1wbSj2hyzhQjUta36uN/705n12h6SvmS6/oap94SXl6hf?=
 =?us-ascii?Q?OTF81eMfRgZOMOb19xM+97JWOgCSvco2cb7jAOzrAJp1?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e806705d-5183-4033-27f5-08dac64c2e86
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:26:12.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqC9tuPT0GY43ocC/dLy4KkcExaQZ0Xv4zUZcNuJl3CGlVvWTDnEscbc2B5ZwpMoDqjWkp9mBNFXIKmNXyR0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:17 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> +pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
> +    let mut it = ts.into_iter();
> +    let a = expect_ident(&mut it);
> +    assert_eq!(expect_punct(&mut it), ',');
> +    let b = expect_ident(&mut it);
> +    assert!(it.next().is_none(), "only two idents can be concatenated");
> +    let res = Ident::new(&(a.to_string() + &b.to_string()), b.span());

Probably clearer to write `Ident::new(&format!("{a}{b}"), b.span())`
here?

Best,
Gary
