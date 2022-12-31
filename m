Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495765A659
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiLaToV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiLaToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:44:18 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2107.outbound.protection.outlook.com [40.107.11.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADFC5581;
        Sat, 31 Dec 2022 11:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iercTrTs/e94+oCNe5Y9XZyq07Ry0vO8Hm0Y4qaw6iEFvOKp+pqDuOcntj1Ps/Vyt9ZOEtadkPgh2utWVyetWEJ7KoIOQbmDM8Qd8AOBm+dU/N1CzyTtQGMFhz4fU2WWOJWlBX97dJLjaXVWg4OGE9SnzP75DkngXlUdsYaHiBOyNE0h55DOTy0/RYSiHYn/5cT+mjzcNjw88ifCHd8FSSwTnDcowGhYxObNxk0wBqYYNsZY6IAqyPSfsEGAH4T9Oh6Ubo9y/K7nv1aUJA3vf2Eb5CTGQmbpx3laQkFZ25PeFIVC3s32dlcQT3h5wEDPDZf5qApOfOLzec1ucB4ARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naNmoFFCnHryiWah+9xPm7ecd2I5OBm81O4dYwxmo+s=;
 b=T94pC/ulD/WJ+Ffh1erLyCt7d1oc0pH81U847U2Oqrag/+QeUA+wEihbl8981ehLft7osuuXfcNshzM6JyMCuToDmI2kCBj+0zekUCdm444f90Dg+BlNOtkBpvQ9IE1TDa83OclQTMG9JHqAU6/3ODG3nk/yVhs5JODAKXjtxhUsYP0GiP1BfReKqvp08AhUX+8KKtOqjW2jwnhScEosna4nNwTs5qV+DvK/eZNyJp+FRCUA11AG8NC9xxyWHRA2ZoqsHsrOlGvrurroH6KHOQWsumZxml3OOha8VWzQABHTLv1Ad11RQ3MWQnF9MBLryL9iAxhJxSZAa1lWjOWf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naNmoFFCnHryiWah+9xPm7ecd2I5OBm81O4dYwxmo+s=;
 b=Xad4kA9ngkOlqWr0cE6m9spij8HjeovhYrKWrUjieH73xIX6qOT1IKjbKx003OR0eLruWxSoCx7pJwz3/cfjeFX2/mzvzM5EoJrkMd5nFKpatPBWVg2zcfn0clzPFnQ2G1XSPwpnADcuJW7SLZi73+yqkR6BBy6Wrlm4CREriBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6473.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Sat, 31 Dec
 2022 19:44:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%8]) with mapi id 15.20.5944.018; Sat, 31 Dec 2022
 19:44:15 +0000
Date:   Sat, 31 Dec 2022 19:44:14 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: sync: allow type of `self` to be
 `ArcBorrow<T>`
Message-ID: <20221231194414.3f66d8af.gary@garyguo.net>
In-Reply-To: <20221228060346.352362-5-wedsonaf@gmail.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-5-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0045.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::33)
 To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 6187456e-47bc-46df-39aa-08daeb6765e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ExK5cm0dM9X6Sfb8zSFKOZgxmBTgI6yyDhVjiy/eyVAWvG/KxjTYCSerZvyPamE/tBfXvcBbI0XdEA7OAKPakOxY5Z+jrlWOaHTOCYEgenxsiYpcinBd7a4bae5+bR/yGhQfZr9RkUIVuyyUc9QYAZ8BXW+YorWFZd6EU0OrRqDDvM4eusGH2sSzma66PYrLIIKva//ZnYTXhWXIvp/PbUNZb6GkYNu1dm7iBmtEgQEIinx92vPSw/b+ZGbIFeirQ/7YK8buv2wg2ZH5NoVMc2O+wHy40BtE6D2Q4q5fr1ehGr+LWNcxaaQLt2nNLm9JaEjrAxtR5iZ/RSHUbQ09qMMks/1u3MR/kasbHtmvz9iVVTbkpU+6o0AsJ7p8mxFSGyOOc/QWA65qJV2MkA+9kH7EkWC9A+a8gByf93uK25RzZaWuPgmeCy56hBS2Ia6cb+nHNHV8CPRRala3AOGvjlYjf9CnTsRZSS/LWO1n+v9M2CA4j4cgVjXSVsRJWuhhqXF9i7d2aUZsRzaUOQ8XQ6loLdCebmsMGrvFpyLRxbpW+1MicROHik+3Iek7yp4ypa8DDP1pPm7SQfJ+7zT4PbEkzZKR0oQ041zGvlV7A5i0HHbuc4tC94xjSudI14GyQlLezUncuxiHbrq/3ztbSW3H7+jhyv8aZueJRj4LDwUqXm5g6VTrnwaU3qKyqpd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39830400003)(451199015)(26005)(186003)(6512007)(2616005)(1076003)(55236004)(6506007)(86362001)(36756003)(38100700002)(8936002)(4326008)(8676002)(41300700001)(2906002)(5660300002)(6486002)(478600001)(66946007)(316002)(66476007)(66556008)(54906003)(6916009)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HN2tZEM7soJAPmgBoMyhoQkzoilYpe88//3VMYVUYFu0CUcYwnpL+isb63Bn?=
 =?us-ascii?Q?5oosSYAvtvALAfvNB/D65GCFKswbXm1PiDoW+yPbVuU5wdd9Q6MQrVwiEQnO?=
 =?us-ascii?Q?kEL2Te9oIO7DU5679P0p0gkP+QQW9jxjJlh/l2qvLObZMbltKHkLUnw9sjsU?=
 =?us-ascii?Q?zCMfXkxFrU9mErQnfR0xQeWxZ5I9yHFZuL1weNt9BdTWT+gPhNBqFerUlg8O?=
 =?us-ascii?Q?RRIgPwQKMLyJ0Eb9E4zUtA1BmxbxSWbdDmyE25vw6Jbwsswjj+EEY5m7WK22?=
 =?us-ascii?Q?AnUVydqESVBCmus2jl6aAcdx2I6cny5QlzDGphczZPcT5J1m6yQde1JPpSF6?=
 =?us-ascii?Q?ZJeSL+lmODZcdjCLKlDv0SdweHp1JmanSfaI26oUZUhatgDdM+BnqsezY6Qs?=
 =?us-ascii?Q?eNkveufnvYqua2+syIEwzoXBvuUW4sa4K2jctrbrJNERx/AoR0elQ9+GowVE?=
 =?us-ascii?Q?vVVdOMJ7LAG/PXYadfp/9rdiltsjysCwi9yRr9OEEduVAQyIl1UBr1HykIsw?=
 =?us-ascii?Q?UMrEbCUHXpqNNd03/jOqAVQZ9MEksOAKaUaxIoV3xPzKxugZS89qkWlpat2M?=
 =?us-ascii?Q?/161fLB8SaQY1nCKbwcK4nNvn1lQMWMbV5xcuAoAfedwtlVhN0yZzSV8xMYT?=
 =?us-ascii?Q?cgnDGBKl8oxHk71lyQo+5WoHEKWfw9tmAQ8PaIQ6VkLf67uIYKGGyZ189Ddp?=
 =?us-ascii?Q?Xu8SY0mVaI7OXABqDZ9DpFtyvIaASsejlCM0aVSTad+k7MKu81Ip67K7wYtX?=
 =?us-ascii?Q?30f/pp3shJJ8n596SYgb2NLYQZRs8dWUUomNQlY3wJL+lFMySH7tTSkRt2H2?=
 =?us-ascii?Q?q/SNlEcLiiK3GQtMar42Nm5SsX9N13cs6xVfToDO1/FWiWsvBV+O1ZIg0z9Z?=
 =?us-ascii?Q?5286kGZxaouIKmEqKLb2x8kZSoC6LI0gOcZNaBoJJeMAmJAhi7jRNcBRxdd4?=
 =?us-ascii?Q?aYX1oCO9H5Ib5wVdfnPIR0gJeSDoLfyNH9eOPib2GvBzFUDR2ZqJQlqsj6J9?=
 =?us-ascii?Q?qQvgZqV7P1YzC+I/mpu5JUIjYSKEq9aDzZNRFkWfuDnarUQe4BrdWAnZndri?=
 =?us-ascii?Q?j6G1ToI8i31ZGcY+BsU5Db7uyp6ld6ckbS2oJwZgkU2V/OOS5AtKaZfgSmYf?=
 =?us-ascii?Q?4WbjAEVoHyVypzRRou0UBuux7q/LjJdTu3F9b1XjfBsCHEDMe+4kPtLUwQlc?=
 =?us-ascii?Q?aQuUjaA33zb/K4rBsSw9zQthYa5VSgpL0HSXqB0WLE4YKEYGPJaFFXRMuEjc?=
 =?us-ascii?Q?IR6kc6whXe4CIqwzHYa4ZwCzYbcselclMlDhNqvkkZTvpLFnjm6mQHeGrzez?=
 =?us-ascii?Q?cilKCX8THRsFjVTHS8z1nj/mC2yzjqSNpdAZFjzaSJ0kyEMVNfZevGDbiph+?=
 =?us-ascii?Q?7Niq4h8QKXFI1Nj+G7ETCJ8DqrRKexeEKd884SdQ0xgKl8rTHfaps9Km4LCg?=
 =?us-ascii?Q?z8XimJx6muF/seZlLxDLPwEp6oLtmzM1WKr71/LxUnVgRTk7AXAVuyOENIa4?=
 =?us-ascii?Q?sIDzVpIE7z/DcY4gPnsKl79lAqiNwltC+7vk/tPt4rzJsk2iiYc3ZU21FlAk?=
 =?us-ascii?Q?4McbMOoy/l06HwPiG0U=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6187456e-47bc-46df-39aa-08daeb6765e2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2022 19:44:15.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTgtFbIeR+r2r6sgsT0/Y+IzKvxwuji6+N2t7gEByWpsEh5yegiWQRT5fIdzxbxPzicOWzF2z/b4jBiAkk5tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6473
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 06:03:44 +0000
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> This allows associated functions whose `self` argument has
> `ArcBorrow<T>` as their type. This, in turn, allows callers to use the
> dot syntax to make calls.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index f68bfc02c81a..84f31c85a513 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -255,11 +255,34 @@ impl<T: ?Sized> Drop for Arc<T> {
>  /// // Assert that both `obj` and `cloned` point to the same underlying object.
>  /// assert!(core::ptr::eq(&*obj, &*cloned));
>  /// ```
> +///
> +/// Using `ArcBorrow<T>` as the type of `self`:
> +///
> +/// ```
> +/// use crate::sync::{Arc, ArcBorrow};
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// impl Example {
> +///     fn use_reference(self: ArcBorrow<'_, Self>) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> +/// obj.as_arc_borrow().use_reference();
> +/// ```
>  pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>      inner: NonNull<ArcInner<T>>,
>      _p: PhantomData<&'a ()>,
>  }
>  
> +// This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
> +impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
> +
>  impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>      fn clone(&self) -> Self {
>          *self

