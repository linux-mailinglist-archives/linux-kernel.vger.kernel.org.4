Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1FD6D02A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjC3LK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC3LKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:10:55 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2091.outbound.protection.outlook.com [40.107.11.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDFB12F;
        Thu, 30 Mar 2023 04:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRmFh0uCtXXsHAmWhU6rszqqTvYJ0+FKwtwjOebjL3h4B4hQl9WqIlW39TaI4Ujh2fHS8MFpGuFGTwoYgI6u0b2sB8AlnYb0tBfj9c4fZFhEu7yjdt4WycmMiWFrSAopyiDxeahVdVgKSIJinp4uHYW/W0gKFFGxPVJ5HCqZxIdvQmQx54PpZZcMkF8YVUPM4pD30zDT8rxTgoG0+hY9cUOI+KkAbIS2yFpKQOPfDf2gCpJp9ZNIOaS8X8+PpI0rSXJg3W2NCIN8x/IWihf5DxbsZvsCs0foDm7JKo8fnRttPSR/5/DH9jHPmQoaZI7BCrHy+IPvjVa3kTpTuZsTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1OUSK6Oe5lE2Xyhbd6mJi1qGFm+GigqkejjqMb08vc=;
 b=lBkLkSTeRAZt+q2g7+EoobPjoMnmdQGQh4r25MS1kvedNcJT2GDzBti8/txelXmCB8KqDnKwuQ1ya+nnTq/MUt+Zoa8gqR7EOtHucoJ9/rIzhVgh1YvZlr7bt9nYsyZj1yf64lXM4qmDb9Dca0bDmovKR6kpC6q9MsX8KeUyYzlRvF23nrtf+7nKm10+pvhGLX8zJ0ifiweYUWTnsKHuoOdsR/yoOCKOLMRIVp6jqg+XdJjFd/1sgo7luHQLNQhnjmLwWM3gyqqfZp5s2N8gRtjowhOiQQ5/PL9Mcvb5A1IH9mpIuEagW5PeLqKSocIdsxUr4Nbi8d9xW354vWIwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1OUSK6Oe5lE2Xyhbd6mJi1qGFm+GigqkejjqMb08vc=;
 b=YqYpDBCk44LzitgZYE9Raa6lD3SblG7wbzjvCBNlThpWesMnm/+dv4G81SB7Zb2kds/Cfve+qe0d9TVYZDtHTzGNFHgxG7it1gPvFPXD6JSLBcCrV/lfZfUCCfU6leegH4HkMQwdtOgtOs49rb9zJlISq2pV3SXZ5ZJb6hjGH7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5991.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Thu, 30 Mar
 2023 11:10:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:10:51 +0000
Date:   Thu, 30 Mar 2023 12:10:49 +0100
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
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 01/13] rust: sync: introduce `LockClassKey`
Message-ID: <20230330121049.59f65e6f.gary@garyguo.net>
In-Reply-To: <20230330043954.562237-1-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::24) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7b9a7c-11b1-43a3-cd6f-08db310f6c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLfhPRfU8iuOGEHwfeeebxG4tMkz7hXPfOpgeVxAoGpmSfZtQCtHv68LZha4Q2AAxNKwYIleB6ERoHgZyndsBZyH3JjwqeUZERHDOm9w+G2aCHEblGaiZmItPBXYu+bnKe/z3V6W4W2OXNbf+7cXM3YrKmMh30/7dbIxqN0hrqlp3H8Toef0mN47N5JvAkQiyB7v5wPoBbCQ2ZBi3qq6/JocwIoUOQxExbTcOB9YefmVtSLnYiKGBtUUIMF19nueld8LyJH4KG3vz9Gh+/21qE/N5D+0SVHHFh2oRqtWi+I7QQo0K1NsNOGSHihogwMYHrBvmQF9ll+vwPtnKdrn8cEnSQpDt+el9Ofd0l04lpB1GiHhn6eH0Jwb2nxvzfnhnUHM0XPIhSE8lzb9tCGRpUWAqhMG5PTlnSyJbhH896i/EyTttLRXWutOtx64g95OhMdrnUp1es8Mr/59vJjzK2s04gGobu+K5VzH076PGAov2ksqDHYzZSzVkYrTRMTJ2VH3b2zqb2J7XR+PjedU1QyEOXKK0KsU0kMz7Oj+dy5g9vQbttMc9O/eAtsdfjJQF8StmRmSq3c7YZUqejVmRlN6PNkUkybaMT9NXx1ORCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(376002)(366004)(396003)(136003)(451199021)(8936002)(6512007)(2906002)(83380400001)(2616005)(6916009)(86362001)(38100700002)(36756003)(41300700001)(6486002)(5660300002)(478600001)(66556008)(66946007)(54906003)(8676002)(45080400002)(66476007)(4326008)(7416002)(186003)(316002)(1076003)(26005)(6506007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Oeq8SZ/zkIDzhXMzM6x4RIlr20rexXqpcuzzL0QEW/7qXz0JUoJWG/VxGGZ?=
 =?us-ascii?Q?k1U8tvkbcz20GTaY5TPBL2KV/KgAmwaSaUoKaFgOOZ9/COXPd82WAp8Ocnp8?=
 =?us-ascii?Q?yyWsIb6MviTbMZpOihvfKXgU1+x4VO4xcaqsKJg+ysBvtp23c/tueHlrEwgd?=
 =?us-ascii?Q?B2GAe4FS9qR26i1EV+DYNcAZppu/m0+bFzI+ol2tvtgLFOwDM3g3aafqDwgI?=
 =?us-ascii?Q?ifYzE8iCJFoKw0mXgmZINuTTL1sd9nsjm9dRx1M11KTx1mq3A5DcqiU1VqQM?=
 =?us-ascii?Q?KqVJHItRuY2+mVtpf8VIl+3UE2qA+4XyS0qCpEvQYP9bFMSMzUSHfKkh+dL5?=
 =?us-ascii?Q?q49pApeYIEQhW5k5nKjTNy2yjT6r9Z9oQrEvFdSVIYNnDRVy1mdRoaWZ7nVZ?=
 =?us-ascii?Q?MqVO9ZxC+eWP5Fsr0x/fECKKfaJ5ZRQP70bfrogepNvzud6k7K12uE4ticYp?=
 =?us-ascii?Q?jdBEIUQ3nmJwfKHvqtTnn9nxbxWCPeJm9lHpt1Am/hr1KQuHjIBaZN/KaAyY?=
 =?us-ascii?Q?hiOGOgOTPPh0jeIK7ZQVfArXt6CesJAQEScl0C503ZTxncq4F9AhQDNb8a0B?=
 =?us-ascii?Q?r/NsVgYCefDD5ejIP/U6LmkhNZahqmsJBf1BlX8+rrq40HWDdVppMqxol9RH?=
 =?us-ascii?Q?u4g5iNzcNzHjTIQrCiT9jlEs6Yoy6vc66kc45Ns78RKKCa3aTNZNcFa3jFXm?=
 =?us-ascii?Q?nwDoCN2ksyAbE26svH0c+/z21Tm3Hwal6BuDHVF1zYNhV5ih1kKtzBYAoNb6?=
 =?us-ascii?Q?x6Mo+9SIllpsVZD8nKJHR9VHttFNslfZ0X++ZjwkkQcPXvzYzUgdjLBg+q9x?=
 =?us-ascii?Q?uCXXOQwLC8IvLFPmMhsaKj3Pn4gwxLdj2xQU8X+20cnzHdXElmaFONILwAOV?=
 =?us-ascii?Q?U3zOWC0O9kufs/gy+1p5f4PgX2/oMMSk2m4pnr8zpoCUUikVfUXzZqnk6+Xt?=
 =?us-ascii?Q?YP1gbOVlK/ruBTPDhKZthxI/0Nb8oPfE41FwiQDmByAyMbPCahKJigGu14m3?=
 =?us-ascii?Q?xl9X22Yh0lRAN1D1t1DBf874DEyseL8+l4xHd7fzQcIsvYGIQ++rjPRC1XzZ?=
 =?us-ascii?Q?71n8IqCZjf0/CHrICkHVaUTwgIbUoGTqMtngMV3tK8tPCGE+/75J729oAyii?=
 =?us-ascii?Q?FSHm8G9Swtq9LuhbokiL1sieWvjt4OPnZKT3BYTpMYGQ95SwsdZ51fsn4r4G?=
 =?us-ascii?Q?zvkH2oFMn+qQBVWApbtbMYvvhlRDL80C6izRMfk2VoFzTyi5+KBF1R4vsXOO?=
 =?us-ascii?Q?Svq7DWvs9cj6kYgcuP3gj01sQ1mhF5WHAaVuSgVs6vmDlReHrLbmBb0jLhcJ?=
 =?us-ascii?Q?clP2bJVEf0Vgt+f19336AgTO0Ak8GSWBsuWNVnruaWKMpIAQgbzeIgsnq8qm?=
 =?us-ascii?Q?TizhOPaMNBMcAhwpzmpRu9DtLJWPu7CTwfCWh8MWbXTDFkb2BiV12buxHZPb?=
 =?us-ascii?Q?dxcCI65kgpwdOiRs9aDNVPi+Gu8Phn0vma1GlFk5SwtYwER9zrFx4hgpwYOt?=
 =?us-ascii?Q?iM7Ry6TCOoP/HoPz9ho2i6CwVcDuNzAk4T1aZJFyrIUsgESBcgbOfM/DOsh+?=
 =?us-ascii?Q?z3L9tVvMl9xqMg+xf5yvttr8x0gn4SXOfJDZd3FL?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7b9a7c-11b1-43a3-cd6f-08db310f6c2e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:10:51.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWH4IM+2Vq2ldfktnEZ7xfseTks7GDOLN6XklRHaAEQ8kom+TxlqxjtEv3MZg5S6kMEfylLMQxEDpE4O7MYcQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5991
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 01:39:42 -0300
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
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/sync.rs | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 33da23e3076d..84a4b560828c 100644
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
> +/// Returns the given string, if one is provided, otherwise generateis one based on the source code

Typo.

> +/// location.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! optional_name {
> +    () => {
> +        $crate::c_str!(core::concat!(core::file!(), ":", core::line!()))
> +    };
> +    ($name:literal) => {
> +        $crate::c_str!($name)
> +    };
> +}

