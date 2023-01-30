Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17186819A7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbjA3SuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3SuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:50:23 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2092.outbound.protection.outlook.com [40.107.6.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F3929157;
        Mon, 30 Jan 2023 10:50:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejo5q0d7KW6BKNQdV/7mHOcu+xLAR0MH2JMPS6sU5sitHofoTp9pURIrgn3vdl7D0dCM4+TRnGd9WYGZlzsAhsek8lOR56eo6RiaoENrRxZxvZ3xTIbDfmbQWI/kHlp8qg2PVC9i1N9AYVq7i+0AN0QJpAcmvUr5ouE73vHzjzTaMLHr7//LAbPj01/EYu4Tl94C0tn67KDlAbM4ub3BseB/n13ZSiF4RUP3wnFwE+Ph/I3vUjh6snTOlpe1bFvP1WOHUDDf3xwl/wngqNP+yGGlo5yFvLA8gbQwPXqwQHDJHvGBdnhU0qAVgdJNOaxKF3U0sGECojXDQKMfrEQyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKH6zNKz1sllYoqSbjarn5I0M+Mc0kx6842Y/gVRjvE=;
 b=CubrL2vPuYsd76oDyeR2kdA1WeppuuH6IF91YIrQCilf9cWwCGiGc826hOxS+zoEuMSmOgKkdAgw5ei2DUvTJALwG5v2KwFs3GTSgE4+AGPX4dcNhoPijYJmoMDt9USR1ESoc5Z5jamWr/h5G1f/gEvl+QshHxkwZm8QuxCxN2VAnp2rwCf5YWgTw45s6/I2Yw0mdT+hXCXkhyYX4TWwnidvDxKtYzfoo9hD9zHiB4wejjyDdcFOe/hYn4lVXL1RzByZeTnRFttdFfk8Vzzuj4rGsa8tcNKtooD6ZyXA1gDLQjL+Xc1hoHTS0R3N+h61AcPJ6o10vjbN/vX9Mk0irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKH6zNKz1sllYoqSbjarn5I0M+Mc0kx6842Y/gVRjvE=;
 b=JzxuwCNaHGNihvm1ncXj0MXUzn04m1/qu5rXxoGXVQaXvZy3ZeRJxMU95q3ZV5SHFm9o83fk0ciCaOcPjW0iF37X8fkJOgU5YvD6sjQmzX9D0lZmZx2aoLHkETTV6SAiat92lgmWeTSoBIgBwbyNya2VvOJXEgiS/3pO46eXRKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6727.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 18:50:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 18:50:20 +0000
Date:   Mon, 30 Jan 2023 18:50:18 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [PATCH v2 1/5] rust: types: introduce `ScopeGuard`
Message-ID: <20230130185018.0b90dcde.gary@garyguo.net>
In-Reply-To: <20230130064404.744600-1-wedsonaf@gmail.com>
References: <20230130064404.744600-1-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5222fad3-5984-42ae-7db6-08db02f2d623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9HEIcmkB4EcQVFgRCfEig9kWc/ca8RmxIwZVj/T+vyUF38+cWME5wcf+UnPPzEEcQvzxsCw26elSHD2MSOjPP+MbID2HQb7EAVSPLHlYN1fzn4/YerVvm5Apaq+YfB++ELVt4hF+joktOFBp6Wb1Vb+dAfuJ83wqoymAzOAelWnXW6rLAH6mvxnjSzTRYr1w+qTds9Tjl9GfsJnoxBYnyDT8SxWhxpNWKDHwqWvBG84albI2E7Z/ztFdJQ6cJ2bkRWsq/B4akQdz74Sm/xP03aYiuV3kFKHhyKCgN87aiZufRL3qTj7PQc9TWvGEeGTzImfTMXTXqLzHzhThctpmIWTHRhUvlTnHfXyVKS2S90Xc7YrBdjs+/PepfaEPXGRjXIfrD8j6kVOeS6it2k7YzjmExuP3S0kvF2S6q04CIe28wtyviqlu478v5xPdAiaAJhKUgARJO1uGM4po1d3J4ngZLQCnThmrNROgH7NNZMYrMtMkWQmbg4lCvxVCQcp+XQp4Sd6OW92R47XL1/gxjXAfrLECtW9LnYpl6ViX6sziv7BprW5UNyd1Ptq+XwM76cZXarTHEAvjcq6FpiSUMmnEvkKdpPizwGbrzPDkN0r6m6gSDE0CCWEzJw30A+Cwbm/gOtblAm5TucMadIY2OR/U0/ATiYas1Jlp29XdxaHNC1BoUw7FFEq4fY5Z6ga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(39830400003)(366004)(451199018)(4326008)(66946007)(41300700001)(6916009)(66476007)(66556008)(8676002)(8936002)(316002)(5660300002)(54906003)(6486002)(83380400001)(36756003)(2906002)(6512007)(186003)(26005)(478600001)(6506007)(1076003)(86362001)(2616005)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vVvTKinX4J4reEsgEm12aQ5bLFv9ugC40n5O36eC5fMlVFObRsVOlcVYZ5V?=
 =?us-ascii?Q?o9UtDVSwxoGZ3ik/7/6WwM0uwQYXFlBb4urP2piZlZ6n33ZESRd7ysk7zzex?=
 =?us-ascii?Q?jNdWyllxc5aE5YJX2rfOtg4/D42OkhPJFKREEDFyP7ui8Zy/uT0Kc3CRSiiG?=
 =?us-ascii?Q?YFSrNsPmH7EUrxaoOJ8d53Deul3ihBaYLQL1XunrAyRAh1KotsX7ffiotsIh?=
 =?us-ascii?Q?Vle7gBHaEXarbeND3I3X8Nje/B9FX7/jX2Dyvaj/1Y8v4E57hq9u3/Ao59/m?=
 =?us-ascii?Q?WyIRfWqIhs1cPoN9WZEm+5hk5fcKQxub3tYColsA131lMBzq562P9ToTtWIE?=
 =?us-ascii?Q?tVpMkF+PBXA+8MZdcaCxiF0BypXsi5eTHURZ+5IQy6F/L7HLULUlH0wpp801?=
 =?us-ascii?Q?KAx1hQgkAdtXpHki9BGcVEeaSfZzTGu2Jl1pEVJ/gUVqqocFZ1KCNDnTwcrH?=
 =?us-ascii?Q?jUC6bIUobR9kVIdJnVULuBYj8DSweQdQKwn6EIl5jMsgCfZDZygop3z7IBh+?=
 =?us-ascii?Q?53g6sISTYjGYpVgzpi4H06Izmh79LzVcA4vvFfPQn6lXLguNHmllgTjnUfY5?=
 =?us-ascii?Q?/otPPuOUTZ61hk/lhRhoms4naeTlihgZbGOkcL+nRRxzv6IDc5FFkxfPiwlg?=
 =?us-ascii?Q?RRAJrmrqIwDouWYzS1MSvBs7H8WasvBHeEsp9D4gfAHSXLYNQ1kfCquK4c15?=
 =?us-ascii?Q?tDt1FJQQyU1lq7xVlfK5nNBD6v0DdsbG8+hTVA27xj519tuq4tu1lXUZlKrl?=
 =?us-ascii?Q?INcGkd6+pn3gN9QnbVc6BiuQN7d8iCFDNntvH0XNjKKSLsgbpniED1/Cq9ON?=
 =?us-ascii?Q?jWMGm9qxolTqi2nnpeEBRscEmkY1HlscE1RybD8Z711nrMOiyiId1Ks8RM8Y?=
 =?us-ascii?Q?ZnH8UUGdKcsRPVO+113kHKSg0khgncE+T3Lh5T9IBLjuSKC0UQ7Xql2Hw839?=
 =?us-ascii?Q?o6QnU4gO2j95MpYChn+PMrGwokVDpXsYRYjZ7/PD3dbRZWhmxcdzFw9bxqVV?=
 =?us-ascii?Q?p2tlY9QgU4Hl9Xh89W8b3zeYgQBacpCP99wJTubxMmM6I3R2ZM9iSJ8O6wjk?=
 =?us-ascii?Q?/FYxHE5OxeEHUhsArUxKu8JEcVgkQu52kM6v1vX0tpVK1WsQpDFsE7onbCJi?=
 =?us-ascii?Q?LAfeci4RSMNv6Cm1h++orQFWYHbkSA/RuK56cjErS/1lrYmxKoC7t4DetjnD?=
 =?us-ascii?Q?3JdJuELUe36TZvxj6q7U2GjePzLMlJA9gWb5RV06vg9uzEaxGBOI+gp8iTr1?=
 =?us-ascii?Q?avY5wPRMzZcWOI1z4ENHlRg1zefYACAY5S+yas+Y/YzBGkBWWULc4xliMBlI?=
 =?us-ascii?Q?lWlSsIKh2SrLXwKieHB5oguSgtlzFZPFtjSzM1d/ZRl8MUGwY32xYVHLOQcL?=
 =?us-ascii?Q?BEB/z2ofAQHxLeqMriTG/OtaJ3dswbF7ePK+F+Q5U4LbDcRjzkjS3wE9lriG?=
 =?us-ascii?Q?p3C6ivez5dVc11ScUSZ4Bj2dMzVbBdro7umv2xNNPFCGMRj6UvzjCNyvm599?=
 =?us-ascii?Q?FP2TgxY6OPhA5TH6skFBLLzIKRel1oy7vUOjeUuj2U2rxTe+MGx9fWR//iFL?=
 =?us-ascii?Q?1LtlUDBYhZAbzU1SV3B3skNwIr5C0WXQm1xY+AdM?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5222fad3-5984-42ae-7db6-08db02f2d623
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 18:50:20.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kml0B/kWJhZ1tT/sxhUtPgn15nTVKfHE0uwOTD6lSuT5GgVfjuz53m4A1rhRMGs8Rk6ZmMpkFoCoPG2ru30cjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 03:44:00 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows us to run some code when the guard is dropped (e.g.,
> implicitly when it goes out of scope). We can also prevent the
> guard from running by calling its `dismiss()` method.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2: Simpler type for `ScopeGuard::new()` impl block
> 
>  rust/kernel/types.rs | 126 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e84e51ec9716..dd834bfcb57b 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,7 +2,131 @@
>  
>  //! Kernel types.
>  
> -use core::{cell::UnsafeCell, mem::MaybeUninit};
> +use core::{
> +    cell::UnsafeCell,
> +    mem::MaybeUninit,
> +    ops::{Deref, DerefMut},
> +};
> +
> +/// Runs a cleanup function/closure when dropped.
> +///
> +/// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> +///
> +/// # Examples
> +///
> +/// In the example below, we have multiple exit paths and we want to log regardless of which one is
> +/// taken:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example1(arg: bool) {
> +///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
> +///
> +///     if arg {
> +///         return;
> +///     }
> +///
> +///     pr_info!("Do something...\n");
> +/// }
> +///
> +/// # example1(false);
> +/// # example1(true);
> +/// ```
> +///
> +/// In the example below, we want to log the same message on all early exits but a different one on
> +/// the main exit path:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example2(arg: bool) {
> +///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
> +///
> +///     if arg {
> +///         return;
> +///     }
> +///
> +///     // (Other early returns...)
> +///
> +///     log.dismiss();
> +///     pr_info!("example2 no early return\n");
> +/// }
> +///
> +/// # example2(false);
> +/// # example2(true);
> +/// ```
> +///
> +/// In the example below, we need a mutable object (the vector) to be accessible within the log
> +/// function, so we wrap it in the [`ScopeGuard`]:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example3(arg: bool) -> Result {
> +///     let mut vec =
> +///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
> +///
> +///     vec.try_push(10u8)?;
> +///     if arg {
> +///         return Ok(());
> +///     }
> +///     vec.try_push(20u8)?;
> +///     Ok(())
> +/// }
> +///
> +/// # assert_eq!(example3(false), Ok(()));
> +/// # assert_eq!(example3(true), Ok(()));
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// The value stored in the struct is nearly always `Some(_)`, except between
> +/// [`ScopeGuard::dismiss`] and [`ScopeGuard::drop`]: in this case, it will be `None` as the value
> +/// will have been returned to the caller. Since  [`ScopeGuard::dismiss`] consumes the guard,
> +/// callers won't be able to use it anymore.
> +pub struct ScopeGuard<T, F: FnOnce(T)>(Option<(T, F)>);
> +
> +impl<T, F: FnOnce(T)> ScopeGuard<T, F> {
> +    /// Creates a new guarded object wrapping the given data and with the given cleanup function.
> +    pub fn new_with_data(data: T, cleanup_func: F) -> Self {
> +        // INVARIANT: The struct is being initialised with `Some(_)`.
> +        Self(Some((data, cleanup_func)))
> +    }
> +
> +    /// Prevents the cleanup function from running and returns the guarded data.
> +    pub fn dismiss(mut self) -> T {
> +        // INVARIANT: This is the exception case in the invariant; it is not visible to callers
> +        // because this function consumes `self`.
> +        self.0.take().unwrap().0
> +    }
> +}
> +
> +impl ScopeGuard<(), fn(())> {
> +    /// Creates a new guarded object with the given cleanup function.
> +    pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())> {
> +        ScopeGuard::new_with_data((), move |_| cleanup())
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> Deref for ScopeGuard<T, F> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &T {
> +        // The type invariants guarantee that `unwrap` will succeed.
> +        &self.0.as_ref().unwrap().0
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> DerefMut for ScopeGuard<T, F> {
> +    fn deref_mut(&mut self) -> &mut T {
> +        // The type invariants guarantee that `unwrap` will succeed.
> +        &mut self.0.as_mut().unwrap().0
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> Drop for ScopeGuard<T, F> {
> +    fn drop(&mut self) {
> +        // Run the cleanup function if one is still present.
> +        if let Some((data, cleanup)) = self.0.take() {
> +            cleanup(data)
> +        }
> +    }
> +}
>  
>  /// Stores an opaque value.
>  ///

