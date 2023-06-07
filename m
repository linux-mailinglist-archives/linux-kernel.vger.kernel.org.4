Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F8726912
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjFGSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjFGSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:42:17 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on072c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe15::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C21712;
        Wed,  7 Jun 2023 11:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTFk361zutf40VAbXKqfgoedcZA5QCL44+PFnRW87fo0rlw/WAC3Bn9emOCqSw7wcS9pe0fWRAWCucQKoosZICLkAN1VcuCZOR2xrvLCyAzcdiHmoc8NTI7oTWQJqsdciHjmvr4CWLRhUXbxqeZmFMcAeYW4Q/xvoBjNMkA2skH5ig3S8qDoNGiYFu1vi0D6CimeuxRFU8BichHrA3vtGbHt5aGlQkzwR8HxO+NL9kXvpMWRO/8qsxaG7aY6HjxvTo4X3p3ANy/FE670hbsEN65HrNIVQK6okMAQrISOKBmdslL0aUZUfSC22qRV94GyyqXoyoZG7vV0G5TNzRG7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzEieb2X/ZJYvG9nTBkldGZmyPCv6FKB37MD9a6NxwM=;
 b=YChbtvD5DMHJGiVcUTsvStPb9um7Z3HgE8HO/YtF8uoneqVZ5C4d9eFqy80fJHmrgjE1QsZUGY+uxPk/mISO5bZ+TsXI1Og0oottZDX76/H6N779l86UHj1v0TZZZxwJFKsKGnsUaXTXfjxZRygmmzyTb7prhzS6UvIxtnL1eyGAgfwNNKNyFn62NcbECFp/oWnDcNS7sBFLqzv15PUCuUFTlrCQ8fxvUYwxwbyxt6qDpnPXjZfBERqsWyhhGENAe+14hs52+1GUO/T4QZuga+AHIcy1IKZLBUncStEf2SsNOUzjqs/zTQ8xY5DsrZhrICGNYL1b87yv4LPaHCuuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzEieb2X/ZJYvG9nTBkldGZmyPCv6FKB37MD9a6NxwM=;
 b=OqC1diY9fByVgPeNGQ/dwCNWIwRVjZBsFMxwIGk6q/gc/ZYFbgg3I1b/7dx6Q5xvUxbBTXZ6/PEDe+mpINx4NgXpidLGn1VdzgiI2EVj6UHJ5mWLABg+2c0wibYllV5cxU0z57uiSsD2Sf21PSGtRfyJo6CE8GhYcZrTzvJtNqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7005.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 18:42:12 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013%5]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 18:42:12 +0000
Date:   Wed, 7 Jun 2023 19:42:10 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
Message-ID: <20230607194210.380d195f.gary@garyguo.net>
In-Reply-To: <ZH3+jARBbn2iG1dW@Boquns-Mac-mini.local>
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
        <20230602101819.2134194-2-changxian.cqs@antgroup.com>
        <ZH3+jARBbn2iG1dW@Boquns-Mac-mini.local>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0043.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::31)
 To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: b2abeb39-cbe9-4194-7b9d-08db6786e83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsbTzEKZl5VpflsCIF545zbv7a2ThFBKlHm9ThWKBnDa9GHGrS7XmtMNSkmrsNylTmiKjWH4xjk97X/nWyT+uCcUherXVItEvRA2ovkVNKnRkRJFDTLK5JwLyhcGLB5sN/42atlyKqaQsF/9ASEO18ejP5GRe0ZDiV3M14btxJSaxy2wdDFgwy48qXB3AGKUDWFlZ2fYhiON38tT7YW0nsTAJTW0OFIxP/bBUTV1eLnj93LOYXmm22Ak06eTVWPKirWVe08Mz7SwcnWhCxlWzaKNDUnCS4w7BXWiYB1ZKrFxsXbUBhIJdWbzxe6Ly/FnzjvSCGrbnooL4DOTEHL1gLW1V6oKVJsiKX2ALr3Vx6ZjI9h2KbbfSVukHvQtDZ7m+7RSY9lUwOwHhezRK+evNl2G1jJ7aAIH9wp62ymI6b9gVu9qcxb7gm7UlLBHzohdyxQj9/X6Q+XE4VtQWBe9HEQnyDrKR8TX7HWC3C+lE/tUymMvDWnSNITxxA6kv//jqPnaTmg1bU2shZrhI8qPHfD1TBSuWynLeozBrW2r1vI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39830400003)(376002)(451199021)(36756003)(1076003)(41300700001)(26005)(6512007)(186003)(6506007)(5660300002)(2616005)(83380400001)(8676002)(8936002)(54906003)(478600001)(66476007)(66946007)(66556008)(316002)(6486002)(4326008)(38100700002)(2906002)(966005)(86362001)(6916009)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBsAPFnDC7/XKZ/IofwvvOH8hItvK21MlM9ZHWJ7B8VapcvAqPmiltmapDhe?=
 =?us-ascii?Q?wHLE4pXgmaK1/Depj5J3EKkU8g34+njEmeebAxTAgKkxhU641WbmHbVXpbDx?=
 =?us-ascii?Q?yehu5eB/uAngTFX1zdA96NIAVS/Xoa5v3au4uiZi7WNyT5sUXCnMEACve7tS?=
 =?us-ascii?Q?rx7wgrwG2YHE1rGP0wSuWizzB7NJqQfgLNsbJUIkUr+6zH6D0lzLOJ4/+sot?=
 =?us-ascii?Q?/MbLHMriKar1GPEXsHLdQ3rju+yWQGQopvtqfPpXie1vfuYqZXedgNagjToh?=
 =?us-ascii?Q?3RdpdER0Bp02grZulBmdWWsSHz6qSTz9vqqDbYOmXjzNyPQaUKyUheqMjA6w?=
 =?us-ascii?Q?lVdOHcYr3VDqkGR9O4uAKFo3b8/82Pmb4GPUZwlQbFX9c7ASuMmxHIqU08SA?=
 =?us-ascii?Q?hS6gOyJJRYApbH7oqC5QQJxsxaOabCr7c+/6nNXClIQIjt29xUdb28VK7kPg?=
 =?us-ascii?Q?UVYeN1eI5yxzGk5WzrOnPqpMlnAvoWu7yDRySUEpbvIgttMg/sUKaNkUr5dL?=
 =?us-ascii?Q?lMR9cNs7+gaMtUI0ubvpmGk/0OOMxD8CLr+Yut0h2tB9bwJTF8xOy7vL/dCU?=
 =?us-ascii?Q?uWuBWpJQyD/9pQu+zimBU0CY/U8j8NYnGvnyHjIAcaAGsrAlijhCVtZzYmtD?=
 =?us-ascii?Q?Wp7+AAvMniAmyKY0ynW7adIKvMmXOuPn+xUWsf7ZKV0m1gS4JE2B/dEx6vkn?=
 =?us-ascii?Q?bDNKjN+Oh7S6THG88ctuA7iS3sK18wUmrf5QfcISxzQdYl93eI7N4CtcIMhQ?=
 =?us-ascii?Q?1P9MNScgQtBXouar6T2ltl4KZLvv6MYXyRkOBPSVH9AEOBPgEXiZj8Up42Fo?=
 =?us-ascii?Q?U4idyqqaYYnAW8WTwPhpDdw5vGNVO5hG8koGxxyiwuyXGN3A2OHAq9pgN2u7?=
 =?us-ascii?Q?u7/ekmF8gpcRYh0T6XiKg9NsLT+20NeMyVxjEfLj/I4AG55NKuUmpQ8ovj+H?=
 =?us-ascii?Q?waxtorP9h5ORpfXUatqsItrljgMz6slxn/Ww4/q1VYiL7PkUK5rvBD7dG4Xj?=
 =?us-ascii?Q?/J20l8J4EDWB7g/xl4EfgQeTVEMBv+FpSrVL/MuwtcBZ8pVQmYb5GfyQIkyz?=
 =?us-ascii?Q?pu64qBnAptGK0FdoGG/twDg3t8/0jqancf8e5yzxcQ+0S+lr5ys3RQIcwQLy?=
 =?us-ascii?Q?oXX/vMnVZiIq3SIr+sK3SWMEHI051CRAlmJXAHI/UFYhxxy6F6l6OF7NcXgv?=
 =?us-ascii?Q?5C57hqizEf6FRoY4csI0dKKGnZZL1BMrLzvQ1ri6MntM7CN2COBwuh4TBKLF?=
 =?us-ascii?Q?V5iBL4925MFB84DwjnL6daMOcmL2LQCXPvzfvghgS4lIPlS6uWg9Wtxyv9DK?=
 =?us-ascii?Q?3DydVGmVeOtLvyqDzRN8u50LdtkUdtRw6oybRdbrYU1nhxEr5TIigX6vi0Fk?=
 =?us-ascii?Q?uErSE8hw8Xtc/PxS7zUjTC1/lB31THe11QIS+2yYzf87T8+B1UmpoxzyHdzT?=
 =?us-ascii?Q?OnDeEYGIF3KXw/Z7KKE4gcQJ8oy2O7suimqHs9+JyjD2F+Trr/6HEbrB4xvR?=
 =?us-ascii?Q?M8lLuF/9FrQE5ZHAZ8p0qWfGeO3kM3zcKNXxdRSLeRXMqC1S+43oQikMF0kE?=
 =?us-ascii?Q?u19TZxPrJuzRbITtI9IfXtcsBLWyxHKcNR2BxctA?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b2abeb39-cbe9-4194-7b9d-08db6786e83b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 18:42:12.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FH2AMLJ4zFbCvTM6WiPOGY84NchLumrpT5Ma4UfhkI+2STKPBPdQjyIdDJCw1HGrHAwgu6YRAGeE4rtZUFnLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 08:26:04 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Fri, Jun 02, 2023 at 06:18:17PM +0800, Qingsong Chen wrote:
> [...]
> > +impl<'a> ScatterList<'a> {
> > +    /// Construct a new initializer.
> > +    pub fn new(buf: &'a Pin<&mut [u8]>) -> impl PinInit<ScatterList<'a>> {
> > +        // SAFETY: `slot` is valid while the closure is called, the memory
> > +        // buffer is pinned and valid.
> > +        unsafe {
> > +            init::pin_init_from_closure(move |slot: *mut Self| {
> > +                (*slot).set_buf(buf);
> > +                (*slot).mark_end();  
> 
> Benno can provide more information, but you cannot dereference or create
> a reference to `*slot`, since `slot` points to an uninitialized object
> (see `try_pin_init` implementations), and referencing uninitialized
> objects is UB (or may cause UB).

This is fine for `Self`, because the only non-ZST field in there is
`Opaque`, which can be uninitialised.

> 
> Note that you could do the following for `set_buf`:
> 
> 	// `addr_of!`[1] is special since it won't create references
> 	// (even temporary onces).
> 	let opaque = addr_of!((*slot).opaque); // <- *const Opaque<bindings::scatterlist>
> 
> 	let ptr = Opaque::raw_get(opaque); // <- *mut bindings::scatterlist
> 
> 	// Maybe this can be wrapped as a Rust function with a
> 	// parameter: *mut bindings::scatterlist.
> 	unsafe {
> 		bindings::sg_set_buf(ptr, buf.as_ptr(), buf.len());
> 	}
> 
> [1]: https://doc.rust-lang.org/core/ptr/macro.addr_of.html
> 
> Regards,
> Boqun
> 
> > +                Ok(())
> > +            })
> > +        }
> > +    }
> > +  
> [...]

