Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF38A6282A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiKNOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbiKNOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:34:09 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2095.outbound.protection.outlook.com [40.107.11.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BC2F9;
        Mon, 14 Nov 2022 06:34:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AccbWifS4TY5bYXHToy6OL6eXAYAAPaQjAv/oyhFlTQYLC4A+H9oI1Zov0Jq8kskEOPxkK8ruVJQck6cm62ZqlUPp5yBttKXj2OCzy3DUlOuCXsC5JM2ESq7iHJAkIn40sAdHOcjEoZqW+9w0GgW1zbIk9mnqVXIdWR88QaDz6doN6ltz8fNlsmO0L12/oPT4gAfwgWyj2blLwlFrSK8UNxBq/h+5FGukvJ7sRycWnIbYrW+8MK6oXsgLCjM13tMpEP2sShWJAuFM5uxUDmwVUBnQRbnNVWLY5bkGwUVUQL77qZ+Snf6ge/AT3OoDsfJys05y4z/4FwYpfaT1gSusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt1DYyqiCeKBSeRB0qJj+Z9Pd3dZQoLVgW8fUIs/Gp4=;
 b=FDaWGGHs51S7LJq3owWmsnPJbCHtb2Nzi9ouBz3Ya+rDErBFRetxhaRiMTHBiAcEUuy92U8G39fWGVgEh1zOykaNLnHJM3SSrZ7wWt1zFr+zedZX92aLzUwPBJGKC5997zX7JEkG5orkb9uu87TwWJ21FbS9SIqdB2H7li1xTPmxgWl9BCojo7H1EIuGgcudyS61YkP4yE3uoJVS8/psfQKXZZroJ9xTDKFY3oidrrXeoShYy6iZhnEWtU3ewkSZ4nHfNYSH7d3CsEdunMfTuOciyifFb7NzqpbF6IF8HyLnJFRXV/Y5+nQvQ9jAz+ChtjVDZ6yYqKVWlwDUP+Yc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt1DYyqiCeKBSeRB0qJj+Z9Pd3dZQoLVgW8fUIs/Gp4=;
 b=BQg+Jtv2y1u5nCPsohVZB2f2H3mbXUVutoXIu82wwFMd06oztaLvl8YtCcmI5l8IhL8y+6cejrH0c4nsfP7BjbNN3hbrh00sqrcaNLe8tSQlDVLPivB9eTGvTEzF04gxUIZ85MWpsxM3bQhSw3rYKMSeCWkhv10hLZpBD8FP3rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5572.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:34:06 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:34:06 +0000
Date:   Mon, 14 Nov 2022 14:34:05 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 12/28] rust: alloc: add
 `RawVec::try_with_capacity_in()` constructor
Message-ID: <20221114143405.2334ed8b@GaryWorkstation>
In-Reply-To: <20221110164152.26136-13-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-13-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0370.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1388a9c1-d94e-4e21-7898-08dac64d48f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDvcDcos+CaDFZJM2oYMcYZpjAIP6du/RL/eYaIIQuVxnsXaIQB++A9HgmGBjBTWpEjj7lKQzRnWhzIfuJL1RvqF2mBKybtB7HGoQVygwipZGObdMOZJP/AOKBbYjNIlUv5wnLE5S69MOJ3B0TSfCSBNfJTCD5aFmlutaANntB1hSbQCVxSbbS1ylJuWUk1umZqW67LyxWIv8eVvoGJ8UNZs1ByGODhmFfDEnuuLCZ6TgoywazcLu6Rpj17xtNWD/A+4fLoWaXzopfFNvp0m/tOrBPfDKn6byA6sTkhq8JXsSnFqlLKEidgL+IytfYnF2BmvyyjEgWNPn9ZUjAaEe8xqjeF8VoePzxGzD4xZQcCf1oPwhCqL5Kq2IbuhZo2L5/36+bwUO/S526TYW8SBXNUdGORRV+VNuPu0XtSjAUMwbkAF4/dqo1iRdTyIIZDw0PwPUTSFjFMiHv9jm2eGQ1Rk4c6FP2kriEkc9CMuALAraR2rF8XTU3tji+DYl/3/0O4Mm2ZeHUWTz6Hky9eFx0zoNLxRWQtuo/6y9ASBsbJ/DLczDTX0IB1mTJMtir5FbUSmwQcxb504kG6TXtZwO0obyr+yxjjkwG3N9kr0bWVflpCUZCkRdJ2ahGOI+aosVVgzb4V6UDodE62m4W7fciqnX3vqGkrEtOE7qsiZQsFhAYWkRAxMK2NUB+w+6mbqcyvS14e9+qdddAEikNrBaH4+e2xGogZgy399APdmSJMw3DwyHhSrtmoG2TgXnn0K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(396003)(39830400003)(366004)(451199015)(66476007)(66556008)(66946007)(4326008)(9686003)(6512007)(5660300002)(186003)(1076003)(41300700001)(8936002)(316002)(8676002)(38100700002)(86362001)(83380400001)(2906002)(33716001)(478600001)(6486002)(66899015)(54906003)(6506007)(6916009)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fv+Kl5DfDStcU+xNQOCGQcgjfOBfazNuCMVgX4dfyC4aCczMMgkPU6IQGEpC?=
 =?us-ascii?Q?27O3w+5EOLJgXuWDaNxFP43859+oxJ57yXbYe9DPh/MTK2p/bou5sgVic5nN?=
 =?us-ascii?Q?Q8dduBzesRzZqi/yOMHz3yEdVyDMu9qqLUSBVX/NBNj3B4ERdEPvWE0MGudq?=
 =?us-ascii?Q?ngtbyC23chyOkarI5iED3VxmIxFzhqC3AHNUnweJQNKzZj8JXM6DBn+eQ3XR?=
 =?us-ascii?Q?rQMlxCQ1oC47rdJYYUh0s0KXmFUb6ZI3RfydqWtwdvgZAkjSP0uBg69+tT6w?=
 =?us-ascii?Q?LArMOvdhXFa/ZS6AOrkayzXdarJnsLcLssYhGlea1sEBJALRlgWkY171Wr9V?=
 =?us-ascii?Q?lYlogh9jgT2ufXOMgl4w6ICddvo47LofjO+VrPSLQ1zVHUivSUPLXvAGqRA0?=
 =?us-ascii?Q?HogH5zP46yHg9utFHe4ahe6Unm27scXMD5dHdEiM9uAkMQea0bjrsiEvQCCb?=
 =?us-ascii?Q?C0VU0TPq/9MTcK/zyEOv0CqKHFeHnVJezs2i2bXhU78QUx1r4qs9gPPevo1R?=
 =?us-ascii?Q?GMUPOxKv1RHf7LTmBh/+P/kM41rbOI7fZjgNtuTZI6aqOHRMVP+doitS2C1O?=
 =?us-ascii?Q?bX8AHWm1YiECvgSteU948AtatWNNE3tLPbDqotJbIFLg52MvfmtYTojWjLS8?=
 =?us-ascii?Q?IGxv6SG8OMrkCGWyYyzYkrVYrObdN/+KPm4q+MPIa5UuC6T9MhAcEmVcJ1OL?=
 =?us-ascii?Q?1ZrrTYtyowQg1TsnbDVy/5rGOFrsHLropearBqC1FpERw0ZafcMu27JogwFL?=
 =?us-ascii?Q?XsoVfV95s5x83Cp4RdagsartTqPcpF4O9F+4RyM8MF9M0OqW7UZvDTwW9eC/?=
 =?us-ascii?Q?YLfmIHU6/QQkY9WH/jemlIYZVw6ylg0plU3fEnV2x7F4OLslK97mj4flabBb?=
 =?us-ascii?Q?OEbUzstCS9X5bFBdIIjLxbV+acISWGB0MKQIK/3QIgsMQ+GzEnyJCU2aTQyS?=
 =?us-ascii?Q?5+FXCmOXUyDWAIbw85uEU7J7COR7TBJB3YndSJsONpETFsFJJM4k8PZt/mNg?=
 =?us-ascii?Q?gwbC14TsF+4wv7XE+nU/o70mEVk+u0DDVs1NTXA4zRA0EvuSITil6NmHiwjP?=
 =?us-ascii?Q?WJ9+1/poD6XAGid5vqchMTp+s4h+4hscw1IoGUrLzGEJ5ov1Y+GGqTS4PU+H?=
 =?us-ascii?Q?EDgPCSzl6g+gr4nY3mFv1jXFoi/+5IHDeHH0y1kv4VTkiDc/jtgm9cCwKDgS?=
 =?us-ascii?Q?goS8RPSeu/DbMH1gB5H+NhycS7LKT8D60seJtXtxt1fKSt2Vm4iswMmLLcFt?=
 =?us-ascii?Q?YYnGzz0eDJtN3RCBfuNpkYuoqMZb0d2Ut/GWThearoYJHgsGkKT0wFBZAZYZ?=
 =?us-ascii?Q?R4IFlSVYY5QccgHFIFlpPqMJuJfU1zYo0CBbY9ZCaRXbPlUH5j6YAj4zEtWY?=
 =?us-ascii?Q?RgXv9lKzyNjHW5PH8mviqenNqOTC7Hnm9HJWUmN/dUbwcHhPUsYVEXgFG3b4?=
 =?us-ascii?Q?ntlKHrTyOgDaP25odBdvHo5od5vAp8eNkmHQCJenMKClZp+UQgKDOrD2vfCM?=
 =?us-ascii?Q?hrAi7+YAeqU8k4m8L7RRGwyNDyV4uYNC3zw5yi5QwU6Ki2CfFumHFXzr8VjD?=
 =?us-ascii?Q?8c86Hc3RXsEdpXMek5sN/09Eo8TNYnpZNtBo0uSjz5D4Fzz9sE3sUxlm1zYQ?=
 =?us-ascii?Q?iuxIcqMKvQulhGjucCVeoN1NpErMhyjwpysWSA8AVkkJ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1388a9c1-d94e-4e21-7898-08dac64d48f9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:34:06.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPgjk1S7GF3BpLnRa1zaqsw+nFTxC2i61txHcMn96vXIfFEtNl400qcBbDWBWxE2E20InPkQirgMnIBtgfGQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:24 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> Add the `RawVec::try_with_capacity_in()` constructor as the fallible
> version of `RawVec::with_capacity_in()`.
> 
> The implementation follows the original.
> 
> The infallible constructor is implemented in terms of the private
> `RawVec::allocate_in()` constructor, thus also add the private
> `RawVec::try_allocate_in()` constructor following the other.
> 
> It will be used to implement `Vec::try_with_capacity{,_in}()` in
> the next patch.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/alloc/raw_vec.rs | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
> index daf5f2da7168..c342f3843972 100644
> --- a/rust/alloc/raw_vec.rs
> +++ b/rust/alloc/raw_vec.rs
> @@ -20,11 +20,11 @@ use crate::collections::TryReserveErrorKind::*;
>  #[cfg(test)]
>  mod tests;
>  
> -#[cfg(not(no_global_oom_handling))]
>  enum AllocInit {
>      /// The contents of the new memory are uninitialized.
>      Uninitialized,
>      /// The new memory is guaranteed to be zeroed.
> +    #[allow(dead_code)]
>      Zeroed,
>  }
>  
> @@ -133,6 +133,14 @@ impl<T, A: Allocator> RawVec<T, A> {
>          Self::allocate_in(capacity, AllocInit::Uninitialized, alloc)
>      }
>  
> +    /// Like `try_with_capacity`, but parameterized over the choice of
> +    /// allocator for the returned `RawVec`.
> +    #[allow(dead_code)]
> +    #[inline]
> +    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
> +        Self::try_allocate_in(capacity, AllocInit::Uninitialized, alloc)
> +    }
> +
>      /// Like `with_capacity_zeroed`, but parameterized over the choice
>      /// of allocator for the returned `RawVec`.
>      #[cfg(not(no_global_oom_handling))]
> @@ -203,6 +211,30 @@ impl<T, A: Allocator> RawVec<T, A> {
>          }
>      }
>  
> +    fn try_allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Result<Self, TryReserveError> {
> +        // Don't allocate here because `Drop` will not deallocate when `capacity` is 0.
> +        if mem::size_of::<T>() == 0 || capacity == 0 {
> +            return Ok(Self::new_in(alloc));
> +        }
> +
> +        let layout = Layout::array::<T>(capacity).map_err(|_| CapacityOverflow)?;
> +        alloc_guard(layout.size())?;
> +        let result = match init {
> +            AllocInit::Uninitialized => alloc.allocate(layout),
> +            AllocInit::Zeroed => alloc.allocate_zeroed(layout),
> +        };
> +        let ptr = result.map_err(|_| AllocError { layout, non_exhaustive: () })?;
> +
> +        // Allocators currently return a `NonNull<[u8]>` whose length
> +        // matches the size requested. If that ever changes, the capacity
> +        // here should change to `ptr.len() / mem::size_of::<T>()`.
> +        Ok(Self {
> +            ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
> +            cap: capacity,
> +            alloc,
> +        })
> +    }
> +
>      /// Reconstitutes a `RawVec` from a pointer, capacity, and allocator.
>      ///
>      /// # Safety

