Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE64687FEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjBBOYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBBOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:24:28 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2128.outbound.protection.outlook.com [40.107.104.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE58984FA8;
        Thu,  2 Feb 2023 06:24:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0gwKloeEnmQXCUZC5u3QK/AtMKQAR+wjVhLPoErmKrHc97Bk+eL40TVjqqSSV4xRy0u4DODwU6B/qWMc9siJ5k6L/jgpZUzTYWlleof60Aj8qve9deu/VV56NXVZ12urXMLO3AQtrHj1jgoYsPwvIvTbbEhGSRWeHSF/2LARZMfzFCopZSw3ieCHpUypceRk/GKD3T08NiX2lsWCEDyTgnP3jAuyyNUljUzwEy3hlrSFfI/O6C4ix9s7Os+zlSPnBzoF/Fnfyk/EWolOBMuPU+xr6hZxJA2YFSUu09UX6UGu773HsI+gvaSbQDxrs46HcWwNuaAksuba6IsftFoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnJMfMfyhYG5uKi7Ic+/eD+hvvhyJnEFB7TYCF9bgAA=;
 b=mkEsTWOCv+qlOtOE9uD1u4LEtXar5AGdktaOgkIH/zmOLsQUj6SISKjs6qARLtF7/l6Qz3zPEjMVVx/SRKFJKGJJetChe726v3xjN93ltX/fYJ3s45neLgIuB+9Aujr/oTJEiEt/vNxRwPABlW8hZqfn2kjiYLpOhIfy5A8FspSiE6KCm6QRcSbJVsYqai4nsUfWt+ZIGtsErUZiV8U8AfbpE/c1CEHjFJhZ6/ci+F+UOLIQeUEoob3CpX8jms0RHDme90T3bEgnf0eor1guAIsnvAWuXzPCevjb5mTR79KoVLDqozojAVcRLE/9gHuqNs8CV0dcwKLO91uI38pyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnJMfMfyhYG5uKi7Ic+/eD+hvvhyJnEFB7TYCF9bgAA=;
 b=tHu4GQKLoado6L6fG57iFeRjI9qmZYPXIbuPsf1RZs5ypUMWoT2QfHVFx59KP4/TmAZcQYqGjT0DG38cfvWSIlfFf2VYBFsuV5c9Dy0FvfE4mk3D6+AyqZfjOKFGcx3wkGf58nHQTWlX+RQViUrUYSdf5MLYxEpZDaHKsrLF03I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6029.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 14:24:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 14:24:22 +0000
Date:   Thu, 2 Feb 2023 14:24:21 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 3/5] rust: sync: Arc: Introduces Arc::get_inner() helper
Message-ID: <20230202142421.7ab724dc.gary@garyguo.net>
In-Reply-To: <20230201232244.212908-4-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
        <20230201232244.212908-4-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b6e48f-44ea-4c60-23e2-08db05292e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RneECqwyUcp2iyQSzhUC+FuMb7d+yBuXjF/rJbBEyD9lNsq98+42NBKZtlNjScaj5HdcA/pWqe6i8EUubxP3GZ/ODoO1e4dHJ+iWUWdd8R1vCA6zdjLL8azWy1eqs189z81RqS3VelxxlKnMk6ezBHm9HJrKh+Xm/juzH06+VFZ9EU8peMJKztDG2gybYp6UkEc2Y4Mv+7CY4E8MyFwOunAnR2+mevd2VacnSApBGHpP/r90tKY74u4p56nlACZe8Bw0cPMZWOVpFMQHzVs3mg8E9YnvPaker3N+mHJVd52SBkadikFS4XFJAUn4h+2DjSdjCv/+5JrPI0mzQ9/6nMGwlh/nG++vIAcDQDuriOVfuEzJcDdY+E4cHp8YAZnH1dWYsuzXdSlCs4C1aqaJ7DVyoDozh+FWOaAZ72ap+cSuMXs4q0Nbk4CuRcJY6teY59fQedJ+Aa7mjldCk28H6gAR7L3PyJHaN4mUbde8egGIWoy8nQdCDJVHkYSeYVbGFAC30JS3cwu3CBGbq5eIZWGi+mkk9ERnqK6dy2Y7FPHB3KayhfqxtDymR3DdUX0CEFpr4WxmCAw1lkODDTIbbXmtad2BubT5/w6CojFBoZHPtz+bfL/3xXB/AojwLQYpJOJ7HHKo4gqwY3JpUhKs6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39830400003)(396003)(376002)(346002)(451199018)(6486002)(86362001)(66946007)(2906002)(41300700001)(316002)(38100700002)(478600001)(8936002)(6506007)(1076003)(26005)(186003)(6512007)(8676002)(66476007)(66556008)(54906003)(7416002)(5660300002)(2616005)(4326008)(36756003)(6916009)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/EfPZFtswdk7b17Zubp4jwhaNIfpJRm9w5f7En7EGhOfE/JShDqlowmTArI?=
 =?us-ascii?Q?iGpyjHGg3+Mvx7xmNvdrst2iZ4uZwM8b+MsY2iR15n/WQISYrERU1aGgy7BJ?=
 =?us-ascii?Q?UffKzU5pYcUP6Qco26LOqXkhhA6ci5JFY5hzLOaH9S3LaEByKmisorhrMn8+?=
 =?us-ascii?Q?pa89+ZkaWdXJRTFu8LXuqXKbB/nuiOuD8I1PI+bH2s9roIJYu6HlBXeW2ZMU?=
 =?us-ascii?Q?VBaw7nuCQ/LrfmEb6YD28xJ9he2Ai+tF8Oa/fPDA6D5sNznnEbJjglHobzPj?=
 =?us-ascii?Q?vhDw/fCnBlIFxMhQIzhZVTdAkq9x37Yi/8QfYxmGxohm5qj8855XnbaEtYke?=
 =?us-ascii?Q?N/t9PFinGyB4+tN+5yU2VL9076qrS8XJs8lmjvSQIz/wVnFu4YeJFGiUxFtv?=
 =?us-ascii?Q?1V3htfl4XGnSQ9S+UBBx6i1xiBMUDxCZWANeYsIl/jXoMwuZnXbzappuAOmB?=
 =?us-ascii?Q?w3EiEeiAVI9uGemmNvMosCEQ7z9v5I2yAkdgmdmGdZ92pJDDXBvHcPPod022?=
 =?us-ascii?Q?TGu2/bwyAnGcwBFf00l15L5k0Gz3GKPq91q2lQvyXpPOJw+15TyI1dFKj80T?=
 =?us-ascii?Q?i6aMZrbCRLRp2orvMTLeWKuLrZYkte5fum0zf+S5zifk/GOIc8opAePXWNX+?=
 =?us-ascii?Q?LleDoFi19m57vutYL9YT0CZK/EYvr0SPA78FYwcLx5pbKXdOsnD+7BhRN3dI?=
 =?us-ascii?Q?8Tr/aG7A7Pkxukl4w2VljwZ73UowG4jazlszHvwKP9tbFcUlI9BCvU2o/nXO?=
 =?us-ascii?Q?l/dDlhlC9oSq4/pIVhEh3Izsu+YCEyZ8yz+/v8OXPTreS5YHbTSEgOoHULO5?=
 =?us-ascii?Q?hRdL65MyVvJqtmEnXfxBXVvFRcvzoiB3gImtZEAdBmeXWl0duYL0d1HrVMWY?=
 =?us-ascii?Q?ZFbYbgDWa0/7Ol1GJATaeqYlkOIhpxOFpHc+iba4xDBLngXBoT0jvC6jxMHJ?=
 =?us-ascii?Q?+RZOYKBWCoLYS4cFdywY4IiozD8fhpsAAUxIbTNdX3UCxTo+vHB6Yo/byHP5?=
 =?us-ascii?Q?/kyjeSUAyydjIoGxVsSpqr8EVyCf9p8LA5YwA7Nxt2P07LDGKAKo97luZXic?=
 =?us-ascii?Q?iFmYBw1V+LSSckB49MwK++VczN0MeKak7pNlAnfSrX4TYyQyfoGfLW8UukE9?=
 =?us-ascii?Q?Fs4sxmqzXyseAadwqQJsJjgyyUCIN7+sZ/GB7K+z/DYd60mh+5Tk+JZMoSKF?=
 =?us-ascii?Q?jUuLK2tdlebythg2pcSNZVQLzxWnXfKuDSpqU3hPdGkMkTRIifU3QYl6ZlXC?=
 =?us-ascii?Q?UCN5b4j4/6dPcr+y3Fd+LHaHtrov+6+sVBslGAdSNjFigsOeb2C5pSUmX9ZG?=
 =?us-ascii?Q?0FB1RmjOOrOBhwdCKEpBQ3CiMt2l5jE7GJ+490jURbp06+I+DauCp4SvjoNP?=
 =?us-ascii?Q?/NoujmJpw5IF2xQvrgnlTfcS3ck15qprLgpm6pjvzaFVVwbuROrkLaiuIaPL?=
 =?us-ascii?Q?KYE27pgOn6er0gqbatLVvs503og8tO5yaCdhkZsqxk61yZbuuGBVRPKlsRDm?=
 =?us-ascii?Q?PP7kDHEE1bHSxL39Jh+x+RVqmS48E4YVnPhoucdBLZrpVuPfJk9bw4H1DAux?=
 =?us-ascii?Q?padk+qomwqpp5jEgjaJY1RQ5O5lVbgHmvlMoXy+E?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b6e48f-44ea-4c60-23e2-08db05292e01
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 14:24:22.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l9TfancJghKHTI0us81qRi19haK0BZXSzENbMGfatClSdhtogHCPrZ8bSvAbyKhJqKcvspGRFPXlFYVWrBpEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Feb 2023 15:22:42 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> Getting a `&ArcInner<T>` should always be safe from a `Arc<T>`,
> therefore add this helper function to avoid duplicate unsafe
> `ptr.as_ref()`.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index fbfceaa3096e..4d8de20c996f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -201,6 +201,13 @@ impl<T: ?Sized> Arc<T> {
>          // reference can be created.
>          unsafe { ArcBorrow::new(self.ptr) }
>      }
> +
> +    /// Returns a reference to the internal [`ArcInner`].
> +    fn get_inner(&self) -> &ArcInner<T> {
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> +        // safe to dereference it.
> +        unsafe { self.ptr.as_ref() }
> +    }
>  }
>  
>  impl<T: 'static> ForeignOwnable for Arc<T> {
> @@ -233,9 +240,7 @@ impl<T: ?Sized> Deref for Arc<T> {
>      type Target = T;
>  
>      fn deref(&self) -> &Self::Target {
> -        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> -        // safe to dereference it.
> -        unsafe { &self.ptr.as_ref().data }
> +        &self.get_inner().data
>      }
>  }
>  
> @@ -244,7 +249,7 @@ impl<T: ?Sized> Clone for Arc<T> {
>          // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
>          // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
>          // safe to increment the refcount.
> -        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
> +        unsafe { bindings::refcount_inc(self.get_inner().refcount.get()) };
>  
>          // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
>          unsafe { Self::from_inner(self.ptr) }
> @@ -253,11 +258,7 @@ impl<T: ?Sized> Clone for Arc<T> {
>  
>  impl<T: ?Sized> Drop for Arc<T> {
>      fn drop(&mut self) {
> -        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
> -        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
> -        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
> -        // freed/invalid memory as long as it is never dereferenced.
> -        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
> +        let refcount = self.get_inner().refcount.get();
>  
>          // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
>          // this instance is being dropped, so the broken invariant is not observable.

