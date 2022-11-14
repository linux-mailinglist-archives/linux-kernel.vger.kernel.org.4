Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11334628373
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiKNPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiKNPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:03:17 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2132.outbound.protection.outlook.com [40.107.10.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8E2B622;
        Mon, 14 Nov 2022 07:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3CvZZUrm9DDUePoxBLV2nLZQZoXBtM4S9Gb+PpxqEQTijVbsrODQ18Xz1D4YNyUGeu+VkjLx/4lwFiZv8EDUiXPcWpYLQEVdjzOL3Zas+R3E2qNErwDYDgck+/pqWdMJSxNg+01m9aF+afHbzMnMK6Vnh+X8xPPTHzwv0Q2vGv37ef/kxNDVNStRxmAQf1CZ9SihBnuzgOg8dX/8GGVxGkpdw50ugDFlEdBi80BBBp/yMLgJ0L/ChHnzLcFb0kBJt2kGSstPdar70OM+ZvThtPhLK5CmalTAK4X/7LybAEMRdGjeZJeyKnGq+G7GSh7YdM8sFUlhl8d0Q40YodWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIHg3xLjBXLsFfaTAw48j22d3cXHRU/xAG3wiv8djCI=;
 b=TCAsa0Tf4oGOM7nXiPZp4qtdVP0cAXP9scm6yJPwbQW6yIUfJ1kRwnnv53ip+VXeuAYZZfvNWjoqC6nnJbtd7DMkvyDNvitZd7eqjbNoIYgF988oK+AWBrzdS3XwoBOuA6WeDTsRYBbddC/5UXVMu9lC9pVycPmvE9UrQIkqcM2JyPrl+TGp8vi+zoVoNBdgqrTYRZnDerI6smymMqw9Fjr+unAWlcZdWDnwx4HSKkQSq2qmMBxF/pKyEkMnaJc8HbJxr56Zxe2njerZ7sRSFIR/UYMD9Qcft+wcFloJNxuGe0B4ywD+N5bVpEhe7X4bDU+kLUpUSs7g4Vvo9vyZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIHg3xLjBXLsFfaTAw48j22d3cXHRU/xAG3wiv8djCI=;
 b=x2QRt0+voSYb/M9Ip9zjBbwqm4B+ZySRNqWxmn3Uzv0/s52QOCl/LoFhexLmJJihNTUB22jfutrePyK0xJrmA5K8NR1I+ZHmXLGU3AvOhKfcdeilc0oFtmHpZ/QM+JNqODHanEj5vyMXjUS1pfvZ1JH9o7EQ1EJMPWENaxZIIMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6097.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:03:13 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:03:13 +0000
Date:   Mon, 14 Nov 2022 15:03:12 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 28/28] rust: types: add `Opaque` type
Message-ID: <20221114150312.402cef22@GaryWorkstation>
In-Reply-To: <20221110164152.26136-29-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-29-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0678.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c94dd4e-1b8c-472b-05d6-08dac6515a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdEqiyzYSwOuor/tleZpLAqSDQ7LfUlpbxQVIs9t2tdmFAZA1Fqlp7XY4XPwYpciFfRB73VHuuO1sS3mOz9e9KQSQelHqQGS+0JkBQLZu2MC4f+QP/25uoB96ghV7iRA8rke2KLvPbD5yl7liLU2jGv1cbLvuBg/+tuGKGBQm5wPdSH4OIGhLJBxzu6rpbkiNa4wBTDmEeSmDj7boLb2SWZR/iT46zNjOpKOJ5dAmHlFG1COKHsMnpCJnoCycupzaKET3vIVGnmRBqrRcQM8Gzydo7KBkOgOQ1BRuDEoUFtGm0WtsbgdvLeUZmhXIQRL/v+ygT5DPBBqXr9ys7cHs0PdziGbGUNFjBp7330u3H1sWHvToBHEKYwUrn3/xGBB8cN4ThcGSy5oay2hOlb5deiNe0JSpVAtgH94caThnhMvDKUj6BU2hxXK+OOefCv799y4pl8uUTif4dq2bKfUTD1g3SVye1ZNHIPYDdfDCcjY7Hh3iHSVM8vDrrpw0acQ3pcxMjxEXnHLTMYLh7jkWxpykEyFZcBg1XVTnN2yMJ/jSUtMIlfyZfCImVKuHuC8taq3iwHfrgLDR2aV/BAP1DoqddWGCfyRZEJJK8fhZxk0m3n8qoQuhrHr8Li1ONeDnio469eTT705aSmDJVXNqkFgWbYr218YXXM1axBXwdYv4b6frWvt5FvSWcmfUetw/vSF9LxoMRGSlDrWVbV9bqkzA3rSIbef3cC1CZMNpIhx6vKkeqcbTmBMQU3qNMht
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39830400003)(396003)(136003)(346002)(451199015)(86362001)(38100700002)(33716001)(2906002)(186003)(41300700001)(66556008)(4326008)(66476007)(5660300002)(66946007)(8676002)(54906003)(6916009)(316002)(6506007)(8936002)(1076003)(83380400001)(6486002)(9686003)(478600001)(6512007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FSgOgpnD/uZlfnSh4Q6tN3eGY+X6TqswpHN6ygP9denAb1zE0EQSDGCKBfM?=
 =?us-ascii?Q?2qlcFq0qrOlOdh8uHf8nRlN+oun0zj/Bsa82TNpVzkTw9Ptg29Y/M6gMNA7x?=
 =?us-ascii?Q?tQRbVeCsDHLdE5P42JETWm8+NxxI2xeHgUvFfIn/dogz2sMp8qaB5oYioaUj?=
 =?us-ascii?Q?Kf/5/zxEMOfUSbB8C62w6thahszG1+83kvgJWgQT+gKcKBqmK+6hAtnzhK5m?=
 =?us-ascii?Q?UhkcS+Q7P1ANbaRNTNDK0HBYtrxKSemZuCB3Snc3Thd6zWf9+BUsWRWEuNmB?=
 =?us-ascii?Q?l5f4Tu6ke6y01bzTnFgTRZ2wmvT5hxhV2XbWzOhO8yhbvlCTePh+liAHzIll?=
 =?us-ascii?Q?mJPxCS2A/7GahN5AoCtuKbHGlfSGur2HtbVMcre8P8Wnk2rsNxsg+MB3FoLs?=
 =?us-ascii?Q?RAdgCSviqzc9A7HLmhjzr2akhmkPGvJFk/WLAMqAmq34PY4FToDjXezHm5BD?=
 =?us-ascii?Q?miSJYfFE3insPiby8htVfIkVDs+SbYpm0iLTPexlsAIGPCmBw/rU11b1svWK?=
 =?us-ascii?Q?T9hRRvxktahy75Nj50uq4Lz7y7RoSqyt8x4RblF7LyIstLuuIxIBNsrbx7Lh?=
 =?us-ascii?Q?8pYadz+ovR4XCYLpzXAGGCFut391bsaoEDMaoH28Pk8g5YkbwIF3TWqnynYl?=
 =?us-ascii?Q?nuuVI3Z+pYAqkXVxRBIhlz6uiHWajleqQN1eLN2vrXDLsFxoDerakzi9/3xl?=
 =?us-ascii?Q?UFJjkHcNkw+LZfFflStc7CwZ2eruUs7yB7gKjjswS53Zba41xILJB5jFTtdd?=
 =?us-ascii?Q?YFyPLkx6DKGWHtScWh6Sa9Y4gaVJ5JmUsxPjQuXaGoxptFm5TeKwQL+qOvNC?=
 =?us-ascii?Q?ZdeNgS5PYM0RQJE0htDp0dZ20itA25L7n+suIQ2eh4H7QIIDvUWtejx2wao3?=
 =?us-ascii?Q?RbbKB6TW/FDDtfY6JyOFWoWuTV/d1ne0VwRQPDIiDKm68otTpV6WTvIH0nzW?=
 =?us-ascii?Q?xhd4yIH6Vrr7yGPnqGTA2mj/XW1JS7lcTpm3m2gURpRt9xYT3AtA8b/uJKGD?=
 =?us-ascii?Q?3KkXl9x8jcfJotHGsFtLLS5KEf51NsBzH/Yh0GbQXeU9Z/R/CvwdzQMcQbth?=
 =?us-ascii?Q?MTH7PKkKDaV0F4ABE8iraj3GpXnqpn2t0Jtkxu/Qa/Ccq1kKLC4LSOeza8M5?=
 =?us-ascii?Q?6LUB0Ht0crpl5GetodLqSBOM690aG9awFDnSLt9u7ZeB02MILaFBIWvh8KoC?=
 =?us-ascii?Q?Np998vAmbMHUazj4dwyqBHMyoO4NEaZwDYcP0THoy6DUusQ6ssRBjbOMSCzR?=
 =?us-ascii?Q?fLt0Ej6BrkdpZO5pIeNd7g1cOWOySyk6oEKyc1No6QYAQjz7GxmSrR/tKiDU?=
 =?us-ascii?Q?w+rdWq2gPCl433AIPI0weLpzzuGxAVwT9/O5CcOwqeVgcYb/+Q897HYOYbs0?=
 =?us-ascii?Q?mgCpbAMM+FlFnPcRDFPfpRW5qe+fxt2eATJ/2SijLFh27kU28lJnMsNgCVuE?=
 =?us-ascii?Q?W9t2qItha51rDXXudYi5u6APW85sJNNvEEBz1/2sIqK76JaucninK9SPsrSN?=
 =?us-ascii?Q?ogFC4hK7tvr0lZx+v+JJzRYAw79i+qUwsa/0h77CRPrjeZAsXbKKMDu0vKgd?=
 =?us-ascii?Q?WN1qzK97fWG8de5YN5cMWei5LtPRseOnOyze4CenK+C1G+ebf6s7pLOP6wQ9?=
 =?us-ascii?Q?svVMgSJQl4Ye9VSAgQ+KiJRhSaZ/MJtAe72vu4yBGNcA?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c94dd4e-1b8c-472b-05d6-08dac6515a4b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:03:13.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4CVkWiqWiFx+IB42NkxTnQy2wPioDolBHZEPnEh6oo41Wz9J+lZv3ZSi+FYzyXZ0+NbQ7wjEl3QkO5kfiQ75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:40 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add the `Opaque` type, which is meant to be used with FFI objects
> that are never interpreted by Rust code, e.g.:
> 
>     struct Waiter {
>         completion: Opaque<bindings::completion>,
>         next: *mut Waiter,
>     }
> 
> It has the advantage that the objects don't have to be
> zero-initialised before calling their init functions, making
> the code performance closer to C.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/types.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 3b0c44769708..e84e51ec9716 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,6 +2,31 @@
>  
>  //! Kernel types.
>  
> +use core::{cell::UnsafeCell, mem::MaybeUninit};
> +
> +/// Stores an opaque value.
> +///
> +/// This is meant to be used with FFI objects that are never interpreted by Rust code.
> +#[repr(transparent)]
> +pub struct Opaque<T>(MaybeUninit<UnsafeCell<T>>);

Shouldn't this be `UnsafeCell<MaybeUninit<T>>`?

> +
> +impl<T> Opaque<T> {
> +    /// Creates a new opaque value.
> +    pub const fn new(value: T) -> Self {
> +        Self(MaybeUninit::new(UnsafeCell::new(value)))
> +    }
> +
> +    /// Creates an uninitialised value.
> +    pub const fn uninit() -> Self {
> +        Self(MaybeUninit::uninit())
> +    }
> +
> +    /// Returns a raw pointer to the opaque data.
> +    pub fn get(&self) -> *mut T {
> +        UnsafeCell::raw_get(self.0.as_ptr())
> +    }
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type `L`.

