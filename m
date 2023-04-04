Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D04E6D6267
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjDDNLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjDDNLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:11:53 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2107.outbound.protection.outlook.com [40.107.10.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F62706;
        Tue,  4 Apr 2023 06:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM6fICzASTDWOgPoZ7PnX7kr7ZiriYiXtcg2Sf6yCNakYJk4joriDm3kU0HX70+7JSgsNQ333jngvvTKOGVFOpS3WUJ77u3CsmJGOYJLUnQ8FIs9Tt6ugaljwoDWNmoCUUj2NvtzdNkEBs+PFtq0nl1AMUckwBTpgT2q/X5/XVXLyqrb0JJfDaXW3+5NqxbweIifBwQxYB+R/1OwD9zL/JCnIHo/iKJvFrZSceWj6L5ERvUjvnsdhv/Ae/19I6HbbR0uUhRpdE0YvCC2bCOcrEW3nypGye35EjgETC6UsclcmButEdhxpwnUEYAOHe71EkKft14DGSFEWZm9rC/Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYMoayCRy/AljWWe9ENPi8KbBeTrGIWUgcL4h42J0Hc=;
 b=UCZtzk3nJtNPUmXUDLTNnGWZ9/j4uqgBhTnBmE8Kl+S/7BmH4u94TahMKgDV6ZHpEh7xXKl8fxdFaD4AOwEKgZZFNQ6LkxYJdZXVnKU8ed5CvMxT0qlbPN0fCD4sqaVUGNNbkbJdgglHkcG3qw3bRmLEWAmSwYgWDptHwwTf6As4lT9/31MDmr4UH5XHQXVC3t7pLnW/oW8YVa7xIyjx1cqKllON8n5H1qkNBtnHde5ClchhLwrM2x5n2dsSASmmcEL/M2yOoNgXx3VotXM6ECo89MXMpu0FfypkO4rP9C6Y1G9dJdOFyD2AjgpdNTPhrlF07JZxgTcJ/l+N5lqrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYMoayCRy/AljWWe9ENPi8KbBeTrGIWUgcL4h42J0Hc=;
 b=HmQ7sdqcw1moSrM4X3kWAKD1z0wwmWm2ly/wZqelKXp7tVPY0NapZS3fwukwuTaU6u8Rpbf+xBD9JINjWZMwLgvu2bEHV+e5DU/2nl5iuSy5rqk1+8DVmU+VMUEjovQpLa6SpLaQCMwZ5jipVgP4EF/jZBxV5Ke7Mvp2e60iq34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5086.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 13:11:49 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 13:11:49 +0000
Date:   Tue, 4 Apr 2023 14:11:48 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v5 03/15] rust: sync: change error type of constructor
 functions
Message-ID: <20230404141148.334782eb.gary@garyguo.net>
In-Reply-To: <20230403154422.168633-4-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
        <20230403154422.168633-4-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0673.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6b7fc9-f398-4b2f-ba42-08db350e269b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uw+z/uFjU90RpWw41xKku5k9k+WHjt1jsIFByBacdYPgX5s5zmILLsrQSW19Hkc0R01A/rcvAp6lzQIS8TzG77gHt6ekOMyd/LmnXSVYo89gA3oi+rrJNDkbLqtg3pMfwuXXWPpJ0EoYTfAfQexuTu/mQvjAMYMiwNR5K72yeJcB2FmaB96i61Ll4Fa+R9NAlHCO22z4fFC+eads+5Z3QX5ttmU3dO25pWxB+zSLw+pj4yj+UCjCMflajLyWEm0b5wOG8PFlz/pHK3TBWqbmbC9v9an12TkPfr1H70GwV3xY0Dpg+uZJh5wrn1Sox7jCko2nwDo2O6Jmz9bBTyXTGoO63/L7rWtACjRw1KcLxlVQYKnkKJjhbGyN3Av2AwPTeckBPm/ksb4FevKjsXo/NxhNJsuyIZdJsaKOFKNn9zu9LZadJPCmneRRPqq5GGjHtwBrh+lTdwYkATB318kvCnj99rQ7/RfQ9f5uJp0NV/g3KdgM+Yd4mykjJXDyTl8p5l6EmB6TLjsVIEGLUnFjX0KbR87pCqU1JJSSzXJRdCv+qkdv+zFdd9HGkXwC1UXt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(396003)(39830400003)(451199021)(66946007)(66556008)(66476007)(41300700001)(8676002)(6916009)(4326008)(7416002)(5660300002)(8936002)(54906003)(478600001)(6506007)(6486002)(1076003)(6512007)(26005)(186003)(2616005)(83380400001)(316002)(86362001)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+9r78Jm4ZnrMMlp8ouhrqxRHlwoQm4KBV+ITqxU9TpYqbOd+3oYtfsjBrXJI?=
 =?us-ascii?Q?qWYSOUhyuA4FLcPOP3gc77OcO7KKcFxKPbO9NZ+Oe7/4eQvlCGq8KvGFSJBW?=
 =?us-ascii?Q?XPdRHv81dB5sVnVMQkgc6i7UY5nxJlFotaaHZCAa4Hi10ni2H6GM3XhKblJi?=
 =?us-ascii?Q?pexcG9A39gAdM7o1JpOrm6c24+sVV1Mr8rYYzolvMRxuIEDQEjCNx1TmUr0Q?=
 =?us-ascii?Q?8Vws9dGrAAq6QfZsEWuXlsc/GQJSXGfybJg4jj6kFJeYCzuUjVCgaQbLuXYM?=
 =?us-ascii?Q?n2zwUYgkeN+IwCYg5I+mo8SxH0e9IJWyK3geWdcVu9hPMZ47dt6kkoccwi8W?=
 =?us-ascii?Q?kingpHipnQ1OBsf5oZYI+EjzPDoCAtDcVchiouced63K596pcNxCIiZahuAu?=
 =?us-ascii?Q?wWwhRPRZTCuM8+cc/yAfcEurUAUwtOFi4U62vuy/suHmsluz7BF6mmHGKPZo?=
 =?us-ascii?Q?jGWr0A/rD8umYFJU91QlFEfexWxHY3BO49rwDD9daYDAUO5hCz21c5dzgyeZ?=
 =?us-ascii?Q?nVk74hwgD5OSJKzCXc4aH9ZmEeWTY5F/CDlkjGIjSwyXjWo6Rq8PhDe0JKoW?=
 =?us-ascii?Q?21hyIMdq/IXxbI5gsZx5POCYIkTHfNFdoKQta37PBCn+fTB5KaHfh9lpdwO6?=
 =?us-ascii?Q?8ftZVTBDeyXnjxmOjwtHVz7frt6fL3YwPMqKRmskm6XFhUBVaaggQE1/zcjh?=
 =?us-ascii?Q?ILqPtUmxFsP2JV8LVwgRx+x+o8zEp5H7r+8PJsGVmbG1klc0IN3qsahfJlwZ?=
 =?us-ascii?Q?dkcmsH4JJwsSXj6sn0eUoZ6OdqpZHa7Ca+nWlGM/0KA2jQ5WcX6nBLfUndtf?=
 =?us-ascii?Q?y+HSlXHLwnaVFvNVxwEH/KlmXzTUDk3ZhMRTtZRzxEZZduu0FdOV4CydAfk9?=
 =?us-ascii?Q?QR7tDr6BiDqxMwImw8RxAQL35hBXjcIRY9DxsIRjcBUonQ/33HZNY7xsp94e?=
 =?us-ascii?Q?Jdfai53yPfTj2XeVbx2E+BMO+ERBINXINxtXmM2cIVgU+qyMZZeD/o7yQGMe?=
 =?us-ascii?Q?lXFbp5VFBQMIN0tnUAHwnCawHXCY8kMrLY61yZ1PtYpYfSG1F/DZJcUCkfbw?=
 =?us-ascii?Q?YV/b7EOZfxEsxhRzb7hnaZa9r1ocPTmQcHQj5Eh3SP02rS0dqvZElQuh+Oem?=
 =?us-ascii?Q?xaLVj0LC04jns0jxIA3UNfUDAidjgBuZb5NpyZs7pO2rzoJrgaLhaQAqUzdD?=
 =?us-ascii?Q?CtcXjeothFLzrJOIYIlH4VMb3vdU/wHkl5cFxyiY33UyGNQQ/JIfKqjv4gat?=
 =?us-ascii?Q?LtEF7XqP93Z/k5wUlHdPF4evvfvEqQ8vzF+sYbhoD7swRM4iXk8zI5N9QUAv?=
 =?us-ascii?Q?lUD7r9xIWn6PmIXtU2PcGAteqIeEEnKfzN3TKP0538lj2OVqVuPAfCPh3pyt?=
 =?us-ascii?Q?IM7msuX+dVoOYQHKouQ3q0u2CFz2UIHc9IDNd9RJDbUsJGF0sFFdRQqyze6w?=
 =?us-ascii?Q?ipWjPJFP6jcLSYM6C8qbgGFwAYfq7bac9+Jcp0Wf7+Ke++9ba3cfH2nIezdU?=
 =?us-ascii?Q?VYsyvm9vL/+6c57lMl1DhbvjojDHZPz91BD29QqWt+Qy/Uw+qybdQysun+QA?=
 =?us-ascii?Q?0WCeqRM7YDSqrqaXkH7OlJhq6adRtJNGXb3EYmg/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6b7fc9-f398-4b2f-ba42-08db350e269b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:11:49.7899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfIS4rLqxWYI6sb12bxjMnXeMpCqt3l/wnRQUpIPjL7nwlgsvl7Vaqc3HPGzcjxCIEZ0ovbYWSFdUmZV/RNhMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5086
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 15:44:58 +0000
Benno Lossin <y86-dev@protonmail.com> wrote:

> Change the error type of the constructors of `Arc` and `UniqueArc` to be
> `AllocError` instead of `Error`. This makes the API more clear as to
> what can go wrong when calling `try_new` or its variants.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index f2f1c83d72ba..aa7135f0f238 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,11 +17,11 @@
> 
>  use crate::{
>      bindings,
> -    error::Result,
>      types::{ForeignOwnable, Opaque},
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    alloc::AllocError,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
> @@ -149,7 +149,7 @@ unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
> 
>  impl<T> Arc<T> {
>      /// Constructs a new reference counted instance of `T`.
> -    pub fn try_new(contents: T) -> Result<Self> {
> +    pub fn try_new(contents: T) -> Result<Self, AllocError> {
>          // INVARIANT: The refcount is initialised to a non-zero value.
>          let value = ArcInner {
>              // SAFETY: There are no safety requirements for this FFI call.
> @@ -469,7 +469,7 @@ pub struct UniqueArc<T: ?Sized> {
> 
>  impl<T> UniqueArc<T> {
>      /// Tries to allocate a new [`UniqueArc`] instance.
> -    pub fn try_new(value: T) -> Result<Self> {
> +    pub fn try_new(value: T) -> Result<Self, AllocError> {
>          Ok(Self {
>              // INVARIANT: The newly-created object has a ref-count of 1.
>              inner: Arc::try_new(value)?,
> @@ -477,7 +477,7 @@ impl<T> UniqueArc<T> {
>      }
> 
>      /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
> -    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
> +    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
>          Ok(UniqueArc::<MaybeUninit<T>> {
>              // INVARIANT: The newly-created object has a ref-count of 1.
>              inner: Arc::try_new(MaybeUninit::uninit())?,
> --
> 2.39.2
> 
> 

