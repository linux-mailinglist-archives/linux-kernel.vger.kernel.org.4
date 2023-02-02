Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C988687FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjBBOWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjBBOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:22:00 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2119.outbound.protection.outlook.com [40.107.104.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ADF9038F;
        Thu,  2 Feb 2023 06:21:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXDViy3Ybr8isvLhfMX27kN3266GBrDQawpJWdZkGhnLJQfxACUOfJoEteo99ytV6p6d1IXokW523bm7xfUtSLDhe+vH+KebGGk8G/WcmFYf7bF9Kt806/4g/J7u0tizXp0vWC4/w/zJKa/QBsS3Gfpw+JCGjlYjvG49kERfE3kMp0A1Yd7v1SodcfSlF8XYQE6oux515EwK3Ix9vsxCbQxgIFlZmeCiQhr5Mvgf+onP9Aj7QQ4WxPK3UgZWlucCWyUqeE3ZNKyj2/UHTMtp/knGf7rfq7lZjSkGd/GIJ4vWOnGyCSaXxnb1FvH+tZ3Z4girVm+Si6lJ8uIOPCGiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oBCOgwthjjz3w4DbWAUsLmfcfu0rQQv/j04MvwuW8Q=;
 b=HOTTzHmhjdcMB97OE3Mp2IKd4W4ZUtLbzQteGf8afGCIK25belY9fDTF/Qghu4gROane5vOBQGTv1H/MVtuFpBgH7Qr65NTJg+OSUAJ2eeoU14Yzv5v89kb0JzLBXz7nouvGOfPu4skO5H0JTUi9jjG7zcxaxx3YJAZMXiWaW7Wsvb0I/rGF4hhLDrgfIT2vfkSvzbccdJ+aNgVSbFo67Uii1+0zQF0CKRpQfNBRN+4yeR9ivQ1ox2JzIfVGh0cIGrxaCojYBfSzi3p5BclILUuoC9/FJ/DAQQeVkeLXtMfBeq4FkCuNm+fagkd1WNpp7gQ+wznvhD+81Bnv2lTN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oBCOgwthjjz3w4DbWAUsLmfcfu0rQQv/j04MvwuW8Q=;
 b=I6iv+rVbS1C2oFfblzvOMnSUoY+6PxUPxHiKQPsdRNJvirMzFtusDr4hHg0XjyXRDPHCGOcM95+zuOUNjobgCTnkxkLf7q6u4UMHHG2G8NeVQEfnrnkqHm6tpjEp2pbrzpK2l7zg6LZMlofa/puLCyHdtwrY4QITWNlzcvumK1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6514.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 14:21:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 14:21:55 +0000
Date:   Thu, 2 Feb 2023 14:21:53 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <20230202142153.352ba479.gary@garyguo.net>
In-Reply-To: <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
        <20230201232244.212908-3-boqun.feng@gmail.com>
        <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6490bbc5-de16-41eb-d9cf-08db0528d5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2f3YhDqogs73xC3bLUlAnc51DIuFYqPRmqD/pWxBXCryjYvfaO8vBiJWXvy179eo8ErROSTSawWXaApR3Qwg2XwsyekRDOFgiufNHdkGD2qaLL24HPpTlVPEaYACs2OU0FrwzkGTzpUOPr9suyB2PMt0IyXmHdhh7yNpU1LaATR4/wku5gC/h/PXAjgX541++eTVcwae7MmI7PYZSfvfKI3TdsUz9d+GMiI27pAYSF2nS2j5STP9l40846tb0cOTdxN3DPvx5lKwz45ZbWLtCvO+6YYwkJlKyFHOcQB3NrTiafCcav2ymZ6OQuWOKDtooECtWLG9LgpFI5uSSZvSBic9zQlE1llSr1pwus1g86sGDFCsUzXdX2cT7T5A2tfnOPKDmjTnzKKh4As030Y/JTTgav4B0tZ4bZqAo67rC0kwdD5UF6WizFKqbuAG/PVHGTHkG3uHir+K7AOeexZQNgDTdz4hLZD6/sPdhpcW5VMZf/5gXd2zs0E8lBH9jkfZsRdqIyRzDZJDXad7VlR7FJLEeReFvEV61l6eQ33NXOWeQixeT4o0e7O+HxlQI+gcqkwPPCxkxen3E3Kf/s4P3z4ZCbeCEPEr/VLEC47VeE9W3ux3OZZfSZGJGLaLRtedgE3oex1xBdzm0gj5lAcHFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(366004)(346002)(396003)(136003)(376002)(451199018)(66946007)(66476007)(6916009)(66556008)(6486002)(8676002)(38100700002)(86362001)(36756003)(83380400001)(186003)(26005)(6512007)(1076003)(6506007)(2616005)(41300700001)(8936002)(5660300002)(54906003)(4326008)(316002)(7416002)(478600001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIdCuoPQ8bEIMHOdB5j+tJXIX/W63l6t8g/1KW07CZuNs0uUR6Ctw6mfok2a?=
 =?us-ascii?Q?tB5SusUFnkyK2oxDk8JQnEfHRniSAj2zD2iJW9EeE8o6J9cMaS7ArrkyK7vb?=
 =?us-ascii?Q?b2S4RyIAHvOCXnlJJ05Lhr27VwCYRQza+zqnDsRFIMwm/sWUL1Q45g4pZzO8?=
 =?us-ascii?Q?b5PE/Bx0w+SOYa2GPqhZaI/W51LlkgSFFtrRnojcE9e55ZeQlcyOvo2BYQ8Z?=
 =?us-ascii?Q?EISgJDckLY3AOC/FqcQ0SD0yCRbCIbkXso3/jR1gYveUYojTBX9ccG3VLNpk?=
 =?us-ascii?Q?b6d0GwnkqGI8q1qdjrwxM2vOPngYowbdekipUXAIX3tTYoKcfaVva3VNgivm?=
 =?us-ascii?Q?VjsoU1pQzcRgUhQ2vvD4ktvUaVDcjDrQ+Wiic6yzHSojBooOC+J/SckzjTvC?=
 =?us-ascii?Q?2E9fsK4MPLbMErkjllkk1QvBjpuC/cN1SaMZjXc56V9bmNZ9KcjzsrOOsRso?=
 =?us-ascii?Q?lJkxFwYh29qtzjQa+VbJyXaBjTlb80gO7xVmAGa1iift+ofKqC4seCiEIM3F?=
 =?us-ascii?Q?Cz81ZBEW15EgFP3zu0LhzpSUJ3CNGapvSqqApo66ofjhG5ImtTGJUeZ/Vy0g?=
 =?us-ascii?Q?kHA6jH5G4XVUHJ2E9VHJyCvCwMAtfmQHE0F6ABf11Mda39Ce/htWH8kXbnIy?=
 =?us-ascii?Q?rNC6WiRBnIl4Gbf0IcgzUGd6XfJt//7sVWU+V4ZOjIdXlwzziO5EUGeLhp+R?=
 =?us-ascii?Q?1JAB3+Qi3FnVFGB+ylbEsBzFV/svfgGfiiGX5sjdetjiBVur6vhwBlmapz7C?=
 =?us-ascii?Q?CXUzojFp7DonCI3mHvwQgFGou75T1/UxyNXl0PgKKpN3pe+qysPdDO1NIRcs?=
 =?us-ascii?Q?JaEMnATLIw1leQJ4qndEXV79h45euCOWoYlJ3bufal2eIYK/VrmZyKx/2U5D?=
 =?us-ascii?Q?ypTc1kCpfUMFnK/W7IVCimUUkr44tz5JBht0OyxwLUHUk839MamrsJx04m25?=
 =?us-ascii?Q?NhAwQtQ5QbrG8Msd03TlqyPB6Cn5yAYuzqlIh5VOVGx9xFHcoxKHQqmcU7D4?=
 =?us-ascii?Q?RCEqtd/TgTfXVGTssxFpFYUaq+OPf2zquGNvVj6FzG0MQrzIr6In7ejFQZ9X?=
 =?us-ascii?Q?dyHiiEQtBIGNDaLwSbD6CeSTi0K3IO+A7lseDpuI2kGADbAWbd40Tr5EEvIx?=
 =?us-ascii?Q?Hq7I7TVVXkQrLcUM+e2nReSImnzsmj2OW2uquBXccP6lNINqYbBA23aXfMHO?=
 =?us-ascii?Q?qY/yPD42zEeIFA0RVb6jjTyERqrixIspwurtoFQFukpUkA9HHOPOKZcRD/Pn?=
 =?us-ascii?Q?XQpnQ5R6YGfV4bU/W0kWR4F3QRK2KgOzIIlITYWMOZgYEwPxp8XnHX54wo4j?=
 =?us-ascii?Q?OlsA3LTwZw0G2YfZ6V1Mqp1aEtwBjFedVBx9r4vv9bS2Qsd9yp7wMZqnCM7k?=
 =?us-ascii?Q?m17U/93nCIKvhA9G+LLmgxg6+0p+rN+RLlWr40H6jonmMt63kxYeqGDC3vLn?=
 =?us-ascii?Q?iyx3EqLJKHke7s7b/QhCoHk4iwiUMPqRK/gNE5kw+umR1CjN0kmJ9mioJYsR?=
 =?us-ascii?Q?WbAfPKlhwk2iOlW5pa3+fFeeCE2kc0EXd6exQUCg2Aeo9FAoz+FjEudlb/6N?=
 =?us-ascii?Q?id0FcJ9g6CPGShgeZ8wb+JG6Wxzs70j8sj+lMdDT?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6490bbc5-de16-41eb-d9cf-08db0528d5f9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 14:21:55.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DYTZPa2WTkBaRIp+Uw0JHQJf8Udr2qCKDYcI8Amxs7CCKeNcWHnNRlyMcxYsDcKo7i8Dp1xTSa9wwd0cp4K0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 10:14:06 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 01, 2023 at 03:22:41PM -0800, Boqun Feng wrote:
> > This allows reading the current count of a refcount in an `ArcInner`.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/helpers.c          | 6 ++++++
> >  rust/kernel/sync/arc.rs | 9 +++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 09a4d93f9d62..afc5f1a39fef 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> >  
> > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > +{
> > +	return refcount_read(r);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> > +
> >  /*
> >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index fc680a4a795c..fbfceaa3096e 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
> >      data: T,
> >  }
> >  
> > +impl<T: ?Sized> ArcInner<T> {
> > +    /// Returns the current reference count of [`ArcInner`].
> > +    fn count(&self) -> u32 {
> > +        // SAFETY: `self.refcount.get()` is always a valid pointer, and `refcount_read()` is a
> > +        // normal atomic read (i.e. no data race) only requiring on the address is valid.
> > +        unsafe { bindings::refcount_read(self.refcount.get()) }
> > +    }
> > +}  
> 
> This is completely unsafe vs concurrency. In order to enable correct
> tracing of refcount manipulations we have the __refcount_*(.oldp) API.

Retrieving the reference count is safe. It's just that in many
scenarios it's very hard to use the retrieved reference count
correctly, because it might be concurrently changed.

But there are correct ways to use a refcount, e.g. if you own
`Arc` and `.count()` returns 1, then you know that you are the
exclusive owner of the `Arc` and nobody else is going to touch it.
In this case we could get a `&mut` of the data (Rust standard library's
`Arc` provides such an API, although we don't have it yet).

The Rust standard library's `Arc` also expose a `strong_count`
function, with this doc:

```
Gets the number of strong (Arc) pointers to this allocation.

# Safety
This method by itself is safe, but using it correctly requires extra
care. Another thread can change the strong count at any time, including
potentially between calling this method and acting on the result.
```

Best,
Gary
