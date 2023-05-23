Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5047770E11F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjEWP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjEWP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:56:35 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2137.outbound.protection.outlook.com [40.107.10.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4898DD;
        Tue, 23 May 2023 08:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4NmIVmeUvWhzH7FjDVEJBTU593XS8x8r7H+Sj9cuFDf3BdBhokPmoRKbQLoBBsAryj8mnKcGp3AksFeup+PkWHO2kdPCsof2AAyiXrWTNmcoUWxsuF3QaVxGsbexUbpZiPJsCAjPpUOseW9j5aqJfKPu986z8mpsFhvTsciYmebhcoGMuZtEWyiShaqYcyGNJfSkYpp9umCykytD5dPNTKObDP/N3Df5xcSJhif4EPtHDmmDQzG/lGd7M7sO8iOOCzcPVbCM+Eg5w0w4DPjkD4tIlIJru/IlZ2N3YWB29qtejniKgd4Hwoznd8Uzjc0qVAr3whHIGfYB0zsCTXO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTy2E6iayPsGuZQw4h2Ilv81k8Fnsx/36G4adnjITy8=;
 b=f8JNcmTFwjbSy77N5JCCYqEnZh6W1yXAU6ialSq+xNyjXDpsxKg2Qz6FVpRpFFuBIifJnUXzsztAk9s0yoQvW8+agiqA0c8Ca+2Ipnztdbe1z247hoajbX0bNXZeXZacQbEMucqi/U3mJ1IWSC7hWy3Pq1CutZ4aCIwbVtrPYkZpJHBtwedv+Tcsw4Ag/E+EiFBlsa2pTkur4t1Bsv/D0W/8ZesenmutdaTbjezo+oMUwzcLc7pMgKbl1uC4qA3A6R82ueYtlQHCmFZW/SU6rCb3G4qo470qN1pa9ROvrPCPpoHrAcd5WcaFIo9PtORNfBFL6XcSVtOlvHvyHL4y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTy2E6iayPsGuZQw4h2Ilv81k8Fnsx/36G4adnjITy8=;
 b=F/8UwaPpc5DPBOTHaCtEeYwPD5bIW6NbF4LReNFKyjuCXxVemx6++5+lijPMw/O5L77AkDZDUNGKHlry0SPmF1KgxmkpZiG+c288TUDJ66bhqQMBdiKS2C9bKeNisV0JbHPPuUeFjrR4H3IMQ4oeshEip7xhINP0rjPRFYWIPNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2096.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 15:56:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 15:56:31 +0000
Date:   Tue, 23 May 2023 16:56:29 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 4/4] rust: task: add `Send` marker to `Task`
Message-ID: <20230523165629.0b092b08.gary@garyguo.net>
In-Reply-To: <20230523144418.1250547-5-aliceryhl@google.com>
References: <20230523144418.1250547-1-aliceryhl@google.com>
        <20230523144418.1250547-5-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 069747aa-427e-4ed2-e437-08db5ba646d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMD+onxjflx9WLf5HUVbK61MAf6ZzSfN0mv5iKTLxMS8KVH/SXEvGjUWYSUSVVbKOtnhRkXCEltXg3OyFLA/jsvN+qGG5MZJbWUdtBxP84X2JHyz/SULbm9L+fbSx+TVZxjtDWlEuKLeTCUslIU/rxwisFuNV0OkNPxerYm59bt7Goz8iM89Pg932muPbDmnz8dtFvC8FlxoGZobF0aEV5Z0FKDxtK2Qg0P9d6W0tyW8ks4xnEiFcxdIbb0bK3oWrw81Z8tujEAvsQJOaidNCI9lQxCohBZ6CC0+gEUjh6WZWNUUdj1fO/VFtS/FeqDKpdcvmFlgpniqCkEvE7FMb+hslKGbUAdQZDIpsjBsDv4oLcuyvW5HX+QeqMuxb+7letWULBTEU1Huz135flfZC3BkWFNae2qYXl3JnjA1PxxCM5/3YvYhfMxH+9GgBHFYljFgcqpUPxkynjWSLRi/fLwAIU0tDwMYBfBD58fPnQDAjS9cKao1GyTtaxuKMoKAnK2WvYmgxNgtpgO3vqsT4/7RTpf4XxSa/CWb7FqPPDeEp4DuhzhxEimnefwfVVAQNnlGEqdXAbEBnrLI7RjnGKgna1PGZ0pBEnZ5ynOjf6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(346002)(136003)(396003)(366004)(376002)(451199021)(4326008)(66476007)(6916009)(66556008)(83380400001)(66946007)(86362001)(38100700002)(36756003)(54906003)(7416002)(478600001)(2906002)(6486002)(8936002)(8676002)(186003)(6512007)(41300700001)(6506007)(26005)(1076003)(2616005)(316002)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IskT1XD8FyiWaHe95zQiRDJZ+O6jCf2ST/93zzh2N7zWuzshZpUZZmGF+RRt?=
 =?us-ascii?Q?9BdBfEhBAhLzZuEpDtlhGAxVFTNrermHKCy0lETxTjfIPOeFSASF108XxH6S?=
 =?us-ascii?Q?zPGBLb4ObEJCd9OMFoqGf3oTLJPlQY/qx0gGz/joNDBOZd+t9Hsjn0K76tiT?=
 =?us-ascii?Q?fg6F0s2U20y9uvGseIeMwRBRe+RjP9cAtZ74TFNYzMqW05PhaJSW8e2A/YkN?=
 =?us-ascii?Q?vAcYxTj99pqbnUcETtpifeRZO+HKcY4Gs5fQ+IIpfRq3ttD+byN7O/+hknNt?=
 =?us-ascii?Q?wNVPLoXa1659bDFUmueZehhcXiFb2B5etOSRvi9q/qC+VXSqXlracpWDGyIU?=
 =?us-ascii?Q?yQNsLNsPYPenfMgkOwAHKxyws+P3OvLFz/yl2A66RJzY0Qv49EUQBglOAVrl?=
 =?us-ascii?Q?FVSFgyzJV1ygIj8hkqQkqgbK6wHXBp8SmBeqQGezj+uly+9ISOepHbcmHgN4?=
 =?us-ascii?Q?MF+aEdJ0QoTByMIWZkwKVnQ+O7r539oRamL16gsJpHRRwd7SKybLlsjay3NH?=
 =?us-ascii?Q?ewZNzDM3jeKMFCrz1zKE5jmlVM8HXqo046IyZkRbojFS0TNjR6O1sx5EDmGb?=
 =?us-ascii?Q?5R8Fgb817nsnkJqPI/bGSXPNNzk1mQ99InEGmu51WE+DZoPE1Iyoiy98aQdS?=
 =?us-ascii?Q?Pm+ogeZhn8vqnR5h32Iudh69ydxto5vgRvMoQepVcwOfCg7DmM8A26a3H/fd?=
 =?us-ascii?Q?nXdnsv4UrMuvGLHv7sIq4MDTbb6v7cMZvAdsTL5hom0fKgquY396pmtqqy3f?=
 =?us-ascii?Q?2J8n1E6unBqo/FvbDPcT+PODelaorMTVqRHlhtSWC/Ri2Xt3jm8C8dbiX9ZO?=
 =?us-ascii?Q?+8Rw3gGJ+8ki8lLYQPxklBI9i1hBItybmUS9YUy1N+iSOrX6sEUwp2V1+htF?=
 =?us-ascii?Q?v0jv5ywW2HLMIBJBB+ImGXq+eYb7v8DmbTPIsX0mN15SGyj/WBM3ktDg4UNl?=
 =?us-ascii?Q?+hT/5EjkM3aSuykc4atqGub4ZdjSqoWTdOFnApL4y1yE/X/UfULuG3Et2XY4?=
 =?us-ascii?Q?7JJu0Uo1WYu3qrRua0H5cdNAOizFFFmqDKdjaNgL63v2/OPCDVe8CeNj0Jec?=
 =?us-ascii?Q?UWqJxebF9LfjqgWdOa+7z+BRRAL2Fb6bDVaoFpqRXWcTFcgJRkRmMy4Bm6EX?=
 =?us-ascii?Q?S6kQpYqRlhzRkQqgR8kprgW3vJzhW1CZGIJuhsm4jUImN5gSm7XuBXJ9T35U?=
 =?us-ascii?Q?g/H6Cn4G9UlJE40f1eV1TNKf4KJQoN9ZQLzFmkcrLD0pq+52bBqqPnVAzbVd?=
 =?us-ascii?Q?xYcwnADzq+d14gwy/QM0Mp9pisn3tMmBxMkkqDeNXrjK9g0yEc48FB2UZVCa?=
 =?us-ascii?Q?h6QL9ZpM2/mrrVbcYm2RbYNPih4dC7dd1PN32kfHd3apQMuENpGhFLX6DgxY?=
 =?us-ascii?Q?4z2JxhdGmPxQK7KTJxnuXub7r0UFNKT2V/tEAjou6jQphLbUCU+aWQmiPwQE?=
 =?us-ascii?Q?abRg9UOKmi0tzFCZanFIt36FkmjY0aOmzgd1DPmU1YCuFHYNjnTzzWgAKopZ?=
 =?us-ascii?Q?BVEqY+s0buqFQ7xJE0KmpIbiNTyQ8Pt/xKm/0+guCgR9pPbV1AVq8iRsoJb/?=
 =?us-ascii?Q?y6mRRIyKuPttiXzA0/AIwnW3ggMcey9WgXv+juck?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 069747aa-427e-4ed2-e437-08db5ba646d8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:56:31.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OO8NmRQ0zVRUWxv2Ii/AZjWZJ1v490xvUjrcggj3Ines8db9MXNyOnssfP59nmkXZslRShh5wGmxXwMjoAcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 14:44:18 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> When a type also implements `Sync`, the meaning of `Send` is just "this
> type may be accessed mutably from threads other than the one it is
> created on". That's ok for this type.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/task.rs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 526d29a0ae27..7eda15e5f1b3 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -64,8 +64,14 @@ macro_rules! current {
>  #[repr(transparent)]
>  pub struct Task(pub(crate) Opaque<bindings::task_struct>);
>  
> -// SAFETY: It's OK to access `Task` through references from other threads because we're either
> -// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
> +// SAFETY: By design, the only way to access a `Task` is via the `current` function or via an
> +// `ARef<Task>` obtained through the `AlwaysRefCounted` impl. This means that the only situation in
> +// which a `Task` can be accessed mutably is when the refcount drops to zero and the destructor
> +// runs. It is safe for that to happen on any thread, so it is ok for this type to be `Send`.
> +unsafe impl Send for Task {}
> +
> +// SAFETY: It's OK to access `Task` through shared references from other threads because we're
> +// either accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
>  // synchronised by C code (e.g., `signal_pending`).
>  unsafe impl Sync for Task {}
>  

