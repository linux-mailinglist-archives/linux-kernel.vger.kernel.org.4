Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103A871F0C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjFARaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFARaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:30:08 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2110.outbound.protection.outlook.com [40.107.10.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B36E4;
        Thu,  1 Jun 2023 10:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY/nGeFm9rXYoDwQMxUOYSjXa0drO/s9qXCwdaB8kz7NI+tJzX4owRE4/562x54xwsn8RVsvNmsFUS8c962EwMfwqkp+uEFqGaG8QSVU1oQ7ge1aBI0S02AnFgrBS2bfRrxVMP6SgBMiBK9zXry27JV2r/xuM3IoqFmNmQAyRDrRXOyD+zKOM1fbddZw53nMyvhcoNcLjo8RQm1bLv2iGhFQwHOhqhtcGVxC37l/ODmazXqB3OzeW82pEb/IfZFoNWnRG7a7zYcPgwuH4Aucl2GiGv5XJ5WXyGTJ68TtywbJxBuEqyIHR1RXj5XggBcgLIkQjj8aLoew8eDpzUO4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9mcdGaREydp49ZO5SXEluSw2J9rKS1aZ9g+/1UOKow=;
 b=cXtDTOkCGTSVQMdKWpaByUHnWQF0/xYZUoFIcp1ihp8M1jVsjy4mxiWt+Gm60Mqlt3fcfYchSzqtvue0Lf+J0ZJ+WJBCZ1Y/nKLq8OSggwkGlMv3+6/qTokrl+bIal8TB2rrfzVxsTO+EZFzcJiWRA8SPgp+ihRKNwTmSHB0CqYv0wORmeZlQvDXEZeyGbt1XwLKOw5fCxhAGz2B1Pawnp/91r5Xy3K+UWxL4Ke3b6BI4BtgA6juay1IRdoxnqCjPlFRz4EbmMZ88RJJ22o1J11zIlccbXhzdBO/mSwdnSFFYh3P1KT8sXc/zHzvh/gsn6O/EC7HBgShejMfwqIhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9mcdGaREydp49ZO5SXEluSw2J9rKS1aZ9g+/1UOKow=;
 b=cBK+oDWIi0OdvTQEPDH7BluazmC2Lg7v5r0f5TLlS4oVpg08nupLcDjLhuv4hi9w7VHQG5vkrED0Csiq2OS1hyezk0UzuqptYywit7vtW0A6Ss6Lak7stAFtb+L6OvZdoeNo5Q9ZK2GzXfYhu/lHSAPpuXWnjPOiZlcydnzQc94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6987.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:321::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9; Thu, 1 Jun
 2023 17:30:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013%5]) with mapi id 15.20.6477.008; Thu, 1 Jun 2023
 17:30:04 +0000
Date:   Thu, 1 Jun 2023 18:30:02 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 4/8] rust: workqueue: define built-in queues
Message-ID: <20230601183002.237a31fa.gary@garyguo.net>
In-Reply-To: <20230601134946.3887870-5-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com>
        <20230601134946.3887870-5-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: bb36c1b3-440f-49c2-7472-08db62c5d640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLbLdkoTCQj81nVljyDfG4Zjq+qzYCK90MNBc0QBFMhMPW40O5ZPhPTIV3/hp7QmZWafZRmTAn0E6Ge5tQbgmN2nBsyBTImX0GfKcTSF1q3s/fVpEn/AhWSDRkPu7sZnHOaDQ/PvQ2nQIIz8P/n2C+XCrWNMlQUTqgFKcHXE+VNsHTKDCbiu6rFOTemsfXytrX7Caa1jnrcggt5n1lrniw/rJjZTX2RslKHoapue2pGOSBJ3UDFqbYhDmnedFKzbq67Hry2tZyl9N33p5RxaiUqsCRchrCtmMAIM0w+WtdL8VNVCOoQgLAII+w07ze0QvJuGDAmPuEnL70O3U1cSiwxG26GCdMqaFJys5kzQy/W7ISfOVDVX/a1INbZ944/EvrA3bRKk41Mvx75+/wqEfpp4VGTGQ7PKHPor+XATEty06g+OLGyJ+pzcocFEV/VtbZECqtGb06D2rDpoxmyp0ajJrAa6Mo2C5LVx0fYiH/OjRt1cyqToqId2cAgjiohYkiGI3Wm0tZG2X1sAChbAisjWo1iAbxfWiUDAq6D0uA2aaHSXmTtlp2HLEFmD9xT5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39830400003)(376002)(366004)(136003)(396003)(451199021)(38100700002)(7416002)(2906002)(41300700001)(316002)(8676002)(8936002)(83380400001)(5660300002)(6486002)(6916009)(66946007)(66556008)(4326008)(66476007)(2616005)(36756003)(86362001)(186003)(1076003)(54906003)(26005)(6512007)(478600001)(6506007)(45080400002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0qSQWwDvPjBEPTm1/qYCNmIYSegYC6GARnfZZUUVjhf/Z82mZ2XwjlMPDBf?=
 =?us-ascii?Q?j2xzzG7r2Ke8rT4qaIAWvpdauGPsLnint5nQrunRRqiqF5wucvtuJ+kiD3wo?=
 =?us-ascii?Q?jm+JS8vuUVBRI8P44unHEsthDTZcQpsrRVFuWLLh0SYNfaqWpPa+U4+tspZN?=
 =?us-ascii?Q?yNs3cM0kL+foTPgOI+TKkPMRExIjkq5qivtcap1fVJUikGqAna+Q0Juu1+nR?=
 =?us-ascii?Q?9ucAppHWUdOXNe8UW7LowUpz88fl6p0wweK82whyKpDzrhlp90cH4OYrUaoq?=
 =?us-ascii?Q?k7qbT9FyfyGpzlyy5rDh8ZpJvWN3H7RnVUqThlkX16e9H4i5OHVC2V00g1M6?=
 =?us-ascii?Q?+wzHbhegM3/ER+XuZIJzdbFzlApwGw66DrPTOeWlVzC/25QGLm0YiccPFJuY?=
 =?us-ascii?Q?bTHP/2Puzd11ZKQLzOlfI68NO3wlelc0LdG0A6geZAiBKm7sHyb8lEpfonCq?=
 =?us-ascii?Q?3AlAnIvo45JTmF5eew+W/UZmKiTJuNFUcaIuN1SdfsUWudfTR10PtshaNUHm?=
 =?us-ascii?Q?nrvpOhwS8KRXZyUPtAkTCFG+NFbyr68QFsw7/gazyeO1Z0ZGyHcarDZUGnUC?=
 =?us-ascii?Q?s0MBw/ZuklSWQk37f1sJog78BQkF9kbtuo7Hg6fy673H5wnzm1hAx2+HDhDm?=
 =?us-ascii?Q?OPN6v8ioU3JGlylOyBykSbSXfKPHBVON2pNZHNru8DTfRapHQorOodVE/sIs?=
 =?us-ascii?Q?IxFDbht6mlgnOYmcnuZN3jXGu4v5+0oUOiNVKAd+D7dctJX1mKxld+S1zSmO?=
 =?us-ascii?Q?9xVGdGlysrYSeKUJGGeHsWfKuZQuhEQ2JWJ+I/FxeFOHGyRbsRI8EFJhaZ3L?=
 =?us-ascii?Q?a4qBfURoe+51VaVqy6Uxn+l6AhCBBkfc55oiNoPUV8LFYy97kyzT/FtGEBnj?=
 =?us-ascii?Q?w1mknLI5ZRdpALR1nmkviZOglNVLmlOA2ZbUCo/gNwU7oMJdC5dfxoIFp0SH?=
 =?us-ascii?Q?i+GN3355Go3oInJCwk/PPjF3GqN/sHmhWrbNs0N4We0KcuGkKVXHNCDCAJY2?=
 =?us-ascii?Q?ohCOcVkdgD18GwIQPcEciPaI7BnuXBIuJ5BkbcfYhm3C8kmOf5FRk27RnYSf?=
 =?us-ascii?Q?qawzyJlAtwaeKNFrpunCfRz43TYveH66dZCtrFu/jsTCTvZxQFhInq2lN7Dm?=
 =?us-ascii?Q?Vvsxa1XczOgp2ZLM99hj/MvPppF9WVFLvrJHGfICBpvSMlrYt9ibq1JvtGOr?=
 =?us-ascii?Q?nmGUz9G/5JmMwN605XW4onhCfQprZ9OSAhZeN9Q0drEPxgqcp/2HMkoFXhel?=
 =?us-ascii?Q?BwBxo+aTFiRvMKIk0LjEhCIDHIaDMdxyE0r5DxaL67DVR4W1wR1R91ifTAbv?=
 =?us-ascii?Q?FOc17pasOfDst5vn1GWMBKjEuevu1qpmXo5LiKVM4+J9rGAWbvSKuCf+qnnp?=
 =?us-ascii?Q?EwaFz3iIdyMRDT7NBbROWPqYvQmLn1O6M346dCxmW2qdXkzZcadu0ic3QcFQ?=
 =?us-ascii?Q?nzj4W+SEaWIapzD6q3j1Ot65Ss5XDX05rWB1XAgpNVcTnlM7sd9NqKG9+5Nf?=
 =?us-ascii?Q?vjUZVp01+bjQgLgPG15cLTocrVZTvL61GSqrYpZvqBLXKiFZAplMoqLsM/ig?=
 =?us-ascii?Q?A47OWAszJoQUNva0TnMhMDSxoGZjyZz47BrRSnxH?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bb36c1b3-440f-49c2-7472-08db62c5d640
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:30:04.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik5EdyK1HO04EnVWrdYI65WZjwc/xJdmIq3pmt7kXWwUp7qDwJl8Grvm7NgThbO0VsZNabzoZJ40c9CtRHi1fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 13:49:42 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> We provide these methods because it lets us access these queues from
> Rust without using unsafe code.
> 
> These methods return `&'static Queue`. References annotated with the
> 'static lifetime are used when the referent will stay alive forever.
> That is ok for these queues because they are global variables and cannot
> be destroyed.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

This looks fine to me, so:

Reviewed-by: Gary Guo <gary@garyguo.net>

Just one question about style: would people prefer:

	kernel::workqueue::system().enqueue(...)

or

	use kernel::workqueue::Queue;
	Queue::system().enqueue(...)

?

> ---
>  rust/kernel/workqueue.rs | 65 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 9c630840039b..e37820f253f6 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -105,3 +105,68 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
>      where
>          F: FnOnce(*mut bindings::work_struct) -> bool;
>  }
> +
> +/// Returns the system work queue (`system_wq`).
> +///
> +/// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
> +/// users which expect relatively short queue flush time.
> +///
> +/// Callers shouldn't queue work items which can run for too long.
> +pub fn system() -> &'static Queue {
> +    // SAFETY: `system_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_wq) }
> +}
> +
> +/// Returns the system high-priority work queue (`system_highpri_wq`).
> +///
> +/// It is similar to the one returned by [`system`] but for work items which require higher
> +/// scheduling priority.
> +pub fn system_highpri() -> &'static Queue {
> +    // SAFETY: `system_highpri_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_highpri_wq) }
> +}
> +
> +/// Returns the system work queue for potentially long-running work items (`system_long_wq`).
> +///
> +/// It is similar to the one returned by [`system`] but may host long running work items. Queue
> +/// flushing might take relatively long.
> +pub fn system_long() -> &'static Queue {
> +    // SAFETY: `system_long_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_long_wq) }
> +}
> +
> +/// Returns the system unbound work queue (`system_unbound_wq`).
> +///
> +/// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
> +/// are executed immediately as long as `max_active` limit is not reached and resources are
> +/// available.
> +pub fn system_unbound() -> &'static Queue {
> +    // SAFETY: `system_unbound_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
> +}
> +
> +/// Returns the system freezable work queue (`system_freezable_wq`).
> +///
> +/// It is equivalent to the one returned by [`system`] except that it's freezable.
> +pub fn system_freezable() -> &'static Queue {
> +    // SAFETY: `system_freezable_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_freezable_wq) }
> +}
> +
> +/// Returns the system power-efficient work queue (`system_power_efficient_wq`).
> +///
> +/// It is inclined towards saving power and is converted to "unbound" variants if the
> +/// `workqueue.power_efficient` kernel parameter is specified; otherwise, it is similar to the one
> +/// returned by [`system`].
> +pub fn system_power_efficient() -> &'static Queue {
> +    // SAFETY: `system_power_efficient_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_power_efficient_wq) }
> +}
> +
> +/// Returns the system freezable power-efficient work queue (`system_freezable_power_efficient_wq`).
> +///
> +/// It is similar to the one returned by [`system_power_efficient`] except that is freezable.
> +pub fn system_freezable_power_efficient() -> &'static Queue {
> +    // SAFETY: `system_freezable_power_efficient_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_freezable_power_efficient_wq) }
> +}

