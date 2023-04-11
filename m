Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448E6DE5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjDKUfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDKUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:35:34 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2109.outbound.protection.outlook.com [40.107.10.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24553C11;
        Tue, 11 Apr 2023 13:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7TWr5FDKIJ1sFz62B9Qs5EdSdiRcbVGpjmbDErc7oL5bqbYz7WX7rsEieapZS5uFDrpgJn6pO9S8+eQN1uJz323S9nucsEZoAtHicjDGjkNMxlC4X2wKc1JzGnXcEenzg7Pa9nfmsG2Hy+MF6/leRw5NUDdBAP+eUM9gKBXwkVEHjG8VEXzaLqAQWe74vF608CR7oT4DmirQcF8e+muXvASruxzFnp6MR8WSQyoaoDlazqw+QCU3xfLO7iZF6FIRN1EFCDc1+8Nk1Or8U9XhYzKYRrlXX99tUuf9xbq882vjwqQYbJNzFDhIkMu9JGYXeJNke31Bo0l7JABFvnUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kObTa3O3bueeGvz1NELBZOG7LufP+ef3ACguEjZdiys=;
 b=crsGilJ1B+sulJkoKm3tMs6uKUdfY7agks3+jC0xU30rpSgLWzVXDuf0HI+HbSEUoJCYQXsl9u8A4s4loIBpx1Q685vWZIsMWa3UY25VbHzdBXa1bbNhd7IUSYIbHxSJi5X3yskrhGRfI/FZ2xjzNUzAd7JzK9f7DzJI7tVQQF/tUxz9U45JluvSqbDDlzJpRuZ0wHpc7s3aePMc2cBpi2nRaRnyeVQIB05sYhuIS2C7pjH5fMx4Jjpt3cxSonuAyVV5zMuqcEPGFQtmrDT9syb5toWTlIL6ltBqUI51d4XQLsyo0uJ/JpzG9dVFpK/LhsxvslmzcIgH+7XxS0nbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kObTa3O3bueeGvz1NELBZOG7LufP+ef3ACguEjZdiys=;
 b=kgBLe1Er25I1OVscEcwl3821K0xK4WJdNq/U+dEqvRTzvXmGdpTY/Bv/aH3e4Dvxl+0e4XXOMT0EFwr7zOt/esYEM59j6A83qByRM2JmoxAX9lpwxPrdr3OBemJ0DkMfk1BusuDU+lgOVzIX3WFpYGcxe6sDAe75sUlI1TZKQ14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB7376.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 20:35:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 20:35:31 +0000
Date:   Tue, 11 Apr 2023 21:35:27 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 01/13] rust: sync: introduce `LockClassKey`
Message-ID: <20230411213527.6e4a5f75.gary@garyguo.net>
In-Reply-To: <20230411054543.21278-1-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5d556f-e725-4576-2032-08db3acc4b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYODltTprtuKS11NzSU4FuQ2lZIQR+bJ89RYuTelfFoz56zGqQGPyjyvIdAfrL8p60ITEEDYZdlJ4tsTLJy1c5IUgQat7gKCN0/Y/2vzB1F9VGSF+eJ8/zBgKfS+eNY0mIDlAvmAfQxiU/aV9CdkPMERMOXZ4OTM7xMhImN795VYMVjRVVRoGvfwls8tcywHxQSmrhx4o6ujZ83TcAsMpZMEXgQ733nWu91cqKsCYvJcegEYAqpWF6VLMf0fE5nSRe6Y6Muvl9SQQJ+4XbXem/U8eIDWSvQipAACNZn3OAy9bg1kiQbi6mAYVApLbyyZ5r1L3QP2LY3iCve+uR+PPLYwgRBQVr5fF7LOC8hVt4feYBG2aLohTYGs6gfwKRKdnJJkILJ1VZlUWXFtelQN1bhxhh0LlMZ2FY1hDv4HuIDv/ysKLaXmSuiLP/ah7sdm9hBd/N8IET3qabvKlYDyionYdrazZ27eG7yt0rHCAMxtrZtmG1VBSn7quPgE553plSVtlPX3JI9I6FbeGimkrt9XalwIibZvuXz7w/71Z/Ocex3keGcT5oXYnc8e+4rUPcuSXAN1Wxuqtvg5GCIBoKViN9gtoyl6ojhUNNCosrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199021)(478600001)(45080400002)(1076003)(26005)(316002)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6916009)(6666004)(66476007)(6486002)(7416002)(41300700001)(8936002)(66556008)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3XR9qeYgIclOvDLONZGbhBwXDVGnmgS4FrXTGYLwLuuHi+RNZVcMiWKMw5xx?=
 =?us-ascii?Q?Xrl8y/qYcYU6doSMNxfbz9Zo+C2uj92nZvQ5nzSBoinbXDOnJB6ciNP2GAJb?=
 =?us-ascii?Q?QwKuwcGJIMYXJY2Y/kPZYy1plxfxQrJs8546j0izQpeoCrNAQCtUV9AKHj+u?=
 =?us-ascii?Q?Omb5BL2fDx6w7A1cPJoYKjMfEfdaqKu9NQ7hAlMYsZWZzfouzNU2fr1r3qmP?=
 =?us-ascii?Q?IbYI2HzVtGPuiBBdv3bw/MBTEVHsKDI6f4nyQev4i7+pksSYei0HA1G8+gj5?=
 =?us-ascii?Q?3plZ35dWvsTIu9qHbCGMW0AhLbOeBnb06wpCuLPHFoy1H03EbYDJD6TGzcKW?=
 =?us-ascii?Q?68qQ43E2DJTCy0J1QWO1Q5B+YNCNyKcBfWyNfsgdC/3VGBEZ5lxSmOah7H/U?=
 =?us-ascii?Q?Okj8JfOfFB670y1PCJYDzLdDzSCvRvrxbJZHYntVc3jEi3As7vKPRSEVE4cr?=
 =?us-ascii?Q?Xwc+eQrTaEE9tGHjtKo30j7Y7A+tSgUQnZhAO7EBVw671xchPCSkoY+MqhHZ?=
 =?us-ascii?Q?I//FV94FA5rdZS5Ta5dPExrQuxL0SFu9K5RyUPuBqKJL+SGv0K8FfcJmb9PR?=
 =?us-ascii?Q?CeYp1AJkvW/hje0uaOh490RyxVf0+pIk9z5Nt0qteYAC1l4GQvwRtqWxRVfF?=
 =?us-ascii?Q?8Gj6CDaYqqqWzu+3QLWbi9b0BuodLv7dEvUZ0/AIT4w9xZCDs+Ro4zSQrru5?=
 =?us-ascii?Q?zP6Xba7O9KTV737QBDtS7AnraCMJ19t1bQiB7B6wqGvQEFt0IdvzkX96kS7x?=
 =?us-ascii?Q?CO4S3TKA3Y39zH8ekpg6pBQJ2ZDc5DUOLtzit70wQ62gdErHDhWGsrYYhQHr?=
 =?us-ascii?Q?Ap0btg5MYN+Yqji9Sk2aM4bcx7z9i0IXX/N/EFTw2fZTPieQYJbNoep6h7E0?=
 =?us-ascii?Q?Im1FTLsSaBORE6ZmJSalVNT+jnSSlqfvx2I27s35ToHnlKeQ9bi5FvoqLqyi?=
 =?us-ascii?Q?Jsi6k2aHF35Gg323qhzifLIC0nhNntdGpgf3OD/9znJL2oMj8PxvIDP9C5TR?=
 =?us-ascii?Q?guhEQOKUTKNFt2Nwdfo2N/gxOe74wR32ZUl984ghBx4KJ6ZEFiNick8P6qKq?=
 =?us-ascii?Q?ymg4iDVqrNhZ6RDq9nJR8B5xbMi9lb6B/X7X8BV2WQfaZZIsCjPkyIQmFazT?=
 =?us-ascii?Q?Ua5phx39jPnIZFzOkMyDClKczcOiCI+xoQMF1g4+mLsQipjX27nZzyF2f0hM?=
 =?us-ascii?Q?TOgd1frlCriXkKkaSlMLWkVTDEppXQJLKnLviH5JthWyY5UNWXQrXB8uSyLz?=
 =?us-ascii?Q?qqQ2r7vy8ghOlrjOCDgrdq0WIxCeaHMuoBFi7JOk88rP7t5a/BWCriTTghlp?=
 =?us-ascii?Q?EEmQlMwk5p2jKft9lwCsEk9o097MmoPZRylutZGselXhixfGyvvjtXSkq2/3?=
 =?us-ascii?Q?AWl2INgLjzRkMQhD+TtuFg7KOwQ8P8SWTJgZUJk00HJZV3vzO0qKLS9fb1bw?=
 =?us-ascii?Q?Pjy/sYrhcy7bhDrCcvKGmIS0nM44hxL4tbkzDFsgntrrFx/JrrRN7SN/CSJw?=
 =?us-ascii?Q?1Vl8XucF0YiEmUxxMe+eDlkcLRnCZZ95o9yIEL6zehGUdmuQkFfaauymZLTK?=
 =?us-ascii?Q?ex+XgHfMolAp1zn6RX3CJKkX52mW5AvVNc9Fv16z?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5d556f-e725-4576-2032-08db3acc4b41
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:35:31.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcpgXb+qMWNtYzFRnhgfNxyBGXTsWQwdW3zwOpE0q5FfzqnpRt+uMUtyGQOTMfC4Yjjkb0MBnkZSwf9eLtQpTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 02:45:31 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It is a wrapper around C's `lock_class_key`, which is used by the
> synchronisation primitives that are checked with lockdep. This is in
> preparation for introducing Rust abstractions for these primitives.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2: Fixed a typo in comment
> v2 -> v3: Replaced `core` with `::core` in macro
> v3 -> v4:
> - Rebased on top of rust-next now that all dependencies are applied
> 
>  rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 33da23e3076d..541d235ffbeb 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,6 +5,51 @@
>  //! This module contains the kernel APIs related to synchronisation that have been ported or
>  //! wrapped for usage by Rust code in the kernel.
>  
> +use crate::types::Opaque;
> +
>  mod arc;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
> +
> +/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> +#[repr(transparent)]
> +pub struct LockClassKey(Opaque<bindings::lock_class_key>);
> +
> +// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
> +// provides its own synchronization.
> +unsafe impl Sync for LockClassKey {}
> +
> +impl LockClassKey {
> +    /// Creates a new lock class key.
> +    pub const fn new() -> Self {
> +        Self(Opaque::uninit())
> +    }
> +
> +    #[allow(dead_code)]
> +    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> +        self.0.get()
> +    }
> +}
> +
> +/// Defines a new static lock class and returns a pointer to it.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! static_lock_class {
> +    () => {{
> +        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
> +        &CLASS
> +    }};
> +}
> +
> +/// Returns the given string, if one is provided, otherwise generates one based on the source code
> +/// location.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! optional_name {
> +    () => {
> +        $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
> +    };
> +    ($name:literal) => {
> +        $crate::c_str!($name)
> +    };
> +}
> 
> base-commit: 2d0dec625d872a41632a68fce2e69453ed87df91

