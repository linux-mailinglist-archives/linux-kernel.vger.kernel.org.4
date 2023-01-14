Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4B66A89C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 03:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjANCTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 21:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjANCTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:19:08 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2101.outbound.protection.outlook.com [40.107.11.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BCA8BAAE;
        Fri, 13 Jan 2023 18:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ1iqtaEZN6jsl3wYer8m9st4sahc2vTdrVafm8Wg8EWnF1etCeVrx/kHUh2p7EdKNxpnl5rWW3KAyuIFnR0O5AE2alq5kjARxPL+oP/76R9pvENTlkpr2sVN3MDRRraw5+Xl/AKZCsXdsbEcJ2LUUxXHOP5AitTvBhFAhScqt25SqLnehIweJYqr9JmQDlplsbe/9YTPUyPAH4ouglw1wZU9YmEFUvQpbtVhZGLq76RxHvp+bu6BEil1mZgOikYO4/W+JKeVk9D97jbzxnkJ+Kff8ibiY8u0gxkGUrcGbel0K5gMwQQA5TD2+MG+9GgOxmfJS9RvuKuG1mrHPyYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVqLMiFQIizMX1AKy+fHpC0M4Ogc77vl7nGkBfTtFn8=;
 b=H/WoxvzmJJbpHLnx0LpQASEI+UzOqWKL+/bUTwJNNUf9EFlE46/B6Hg6hMM0BoOBJwR4W33XlYdDitTK6ci2fDZJO+MX0WPfY0hPyOxfWaT67ftxdxR9tqudqQ1LcazFj0cNn7THZrjbMtA2RLxCvxUbkZ3dmVUDJNCm3hRV/wd51t4xLz9vQYbPEJPvHHyxwWzlWAbST6Mg2sVkyqHvKIFVcarw43sQ9CMQH2iVSTY9g0588UdVHonRJgmpZ2mA6aVS9zL82Av4ps0rw24j2uzZuZpeW6l9oHyymbH5RjyAzFYL6rmzHVwqcc83TEijXEr06xxNaXcLiJNOHz9JIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVqLMiFQIizMX1AKy+fHpC0M4Ogc77vl7nGkBfTtFn8=;
 b=0AyTk32twrZA4XeRn986WPqv9O0Mld17cC5JRG3N3xJMdIDiqPitchBGFLX9BATUWf3DfjNmQdfRwBmhyGHtCFk1XvadXyCI9J0dInUZFT3mD4IZ1vNLU9ZL5hCTUbT98NUZOc4zOPF2xMUs7cNKmIXgoYJ3fFuaELCiNJY+9dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6372.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sat, 14 Jan
 2023 02:19:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%7]) with mapi id 15.20.5986.019; Sat, 14 Jan 2023
 02:19:04 +0000
Date:   Sat, 14 Jan 2023 02:18:35 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yujie Liu <yujie.liu@intel.com>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
Message-ID: <20230114021835.06749ef7.gary@garyguo.net>
In-Reply-To: <Y8Ax/I5qOcVDZljG@zn.tnic>
References: <202212272003.rgQDX8DQ-lkp@intel.com>
        <Y6r4mXz5NS0+HVXo@zn.tnic>
        <CANiq72kc60aPcx5LwFhOGL4AXOhZsZj32iOg75K5ZxLaaRaYkg@mail.gmail.com>
        <Y7i1h3lCMKfxB532@zn.tnic>
        <CANiq72khMLU6tF8vGD9fs7mLNAAQu8wJ2n1SLM3th2QMMfGPPA@mail.gmail.com>
        <Y8Ax/I5qOcVDZljG@zn.tnic>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: f527b85a-e48c-491b-e388-08daf5d5b564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25XHHdy7B5oPz66FnSnoYgE69rdWCXtGiobe4srpbnOy92YlflrcBNdaZxpBgDtJ+rCHcluhiF5XM2U3zamExkj7ZqcLry5/iXNVDRm0yYmF3QaZGuqwpLQbGFhVMHB7IVXg7I4n/zsFyaefTia/8ofW5GSqmHgTMlK15QGStjLmZgVSWf4cn/6zcay8bJbqVERiibIS3m6+XB46UT2v5gQjeNigDZnr2i6pdBPxrl08EgJZVzEV+JP/+n2lk7xo9zr7BwrQpjtNvHxneaEmN6yR42hHUWjDUs2zTPEWqcnLtGGzhvST6meXkaV4IekUvTRJpxQdCFjzTC0G3FZ0ohljFqiC9vsjV8DlG3JvuFwTyRw+DyDzcUndsGmkITnvhb/Ro567otPiJjL4DFbWxaFMqBNKHU9asbkVxrhufJ0+qPeSwMQ+Eg5On+X9VDSVe7ZZYf3peNRDkompkuT1uTXnhtl60smeEj7gEePHQ6r1PRo+qfEHiUozyGVaKzB1yh8ADOjBgNZZKQqXQiIn4FGdWKRK841augr2rpEETyfHXr1VmNQIuVZQV/yffgXtukHtlaN92Bgtro+yhR3GvPCd7uKDDBB3L9aaD2+wiwBIGRJ/RQLsTFGblqBHBQ6OBg/7YOIQ1kmS+N1VKYbuxclc+VqOrbpC6msBVjC5KAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(39830400003)(396003)(451199015)(2906002)(83380400001)(316002)(1076003)(186003)(5660300002)(66946007)(66476007)(66556008)(8936002)(6916009)(6666004)(36756003)(26005)(6512007)(6506007)(6486002)(2616005)(41300700001)(38100700002)(478600001)(8676002)(86362001)(54906003)(966005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnmQO7eSV4Azlb5KgnRTuXF+4IyVe5FYcwXQdL5DxwMeJRLROxXeYSIkPltc?=
 =?us-ascii?Q?1du727x4CAreUyE12vpSjOmAYNKinPY9tocjGsjXK7YDx8tzBmL3URpljUto?=
 =?us-ascii?Q?donsUOzHKoMZxwrlCaXM+oTIXaqOuyA7YO7bNLo2/YKf4oPpU7peD1SOkUx3?=
 =?us-ascii?Q?pV1gFBdXNUkflK4jzXIJVDVoO3IWmCOiFSZMwR9AMgcqBYik/g8R+Hf6pmpC?=
 =?us-ascii?Q?UENgU+/vwN9JRNvQoUwU3Vs8kfpjhX3DXkqDHIU40JPPdeIEu+hGHbUVrqdK?=
 =?us-ascii?Q?epxGwpkWgZOPnjxzaBvYX+SJrXCF49+EkbEQ+BqDTl9Yz1wNdGEFl4XAdY1Z?=
 =?us-ascii?Q?Exisrpj48RFrJqEtaFBr/k1a9JWz+ACERfu+zCamZSDVxUy81jFKLxE12Nse?=
 =?us-ascii?Q?5o1hZ/+Jx6NP6zd4Gq/IKIqnFHZ4knwMeGQak2BgjMufuAot/mQBabrIvrkp?=
 =?us-ascii?Q?4yhYwldNSZCFQ5Wvm1X7deuzObfvffbfuCdYuIJgeb/GtPW5tOSpGCh7Cj9K?=
 =?us-ascii?Q?7cIql2hEEPbjT5FOPU+RmLCOJxjrkVLRNCxIc1ebVJqIkMj72LLbKtdZ0Z9V?=
 =?us-ascii?Q?l4DYwjKcsCcr7URxVnUwv2hchWFevQ7RW30DUh/PXrfFsXEPrRvzOO2EtkCk?=
 =?us-ascii?Q?VwKbr7NfOhfYRD8yE7a1fYFjxoom4pJn5pyoKKh7roqdx/RcjhEJH0+bMD/7?=
 =?us-ascii?Q?6IiJrhD5VgQwSXoEV6DAj/0fslrYQScUJuD0tnCrvXvOg97Rac3fw7WfwdyE?=
 =?us-ascii?Q?IZ6JhqO2/OvfBDS4p6vgh9VsGIRasLLXb1ObSunCJJfVkVp9tKGU+1DRb98R?=
 =?us-ascii?Q?0Fd5uCU9TZxWt2Ow4cWc90xIjsh8mskPoM+3Q5WfuE80jY847fRzX9MzsCxd?=
 =?us-ascii?Q?ygd06CGY9EYVpSPKCkaY3XhAAnbgx0NJBwjPgATzXhG5gVWmyU2lCz6B6byG?=
 =?us-ascii?Q?0cE+KgIG5zmK9IPfTuNhxnovPHy3QCdrImsFp6r8Uq8SJhtRmiHdEIyz45Rv?=
 =?us-ascii?Q?pff3jSkEmJL0ZTgsHyW11OFVmZAm+9bwKXWMp5NdH74OtnGXbAh7GHuVwKfN?=
 =?us-ascii?Q?fVQbkPIQbFIWI5dkvFj7ap/7FkFKQ/F/NMjyCyU6SSezrSw2fVgDoIMlvWB8?=
 =?us-ascii?Q?Az2jxoDq57u9ycFU0b8xjOXi3f7gdaTyoKDrA0/urTBz+WelEwFDfbtlEE3S?=
 =?us-ascii?Q?u7XP0M04Q2S2uF5N5VBnK2pbMAB0FZ2QYHNGTldajmpob1ryGL2YI25AeHky?=
 =?us-ascii?Q?svHbyJvsLnbquUEXHDQRy4EcQ2IUnHRJDaqwB/4ebWI+CE3MULuBa7WpTmPO?=
 =?us-ascii?Q?ZUk1ZJ3AdIouMC43OTKKq2g8Yc6hi4AjUD3fZNAMhav/jyRNiZBVX5FeaNqD?=
 =?us-ascii?Q?whuQvlq9DCBnC2ndQuIfYLpTt4riM+ioV9OuAfoNKONCp/2CVgDtEAJ5cqci?=
 =?us-ascii?Q?3A0f/dp5PpPjDdxNrYQQzyNhA0s5IVHbOFbjplwmSzW9hWjoP5LxN/JPcoXw?=
 =?us-ascii?Q?uTd/NSAyeRWNM7UeXIbCTeOwVrEHtJLaUwIGdHwqyhhIr0C2atYzhkOag6EV?=
 =?us-ascii?Q?KrREbFXyekLp4oDR4UhyzPN8g3Gd7oV86uWlZ981?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f527b85a-e48c-491b-e388-08daf5d5b564
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 02:19:04.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwBHtsH6gJetk+UjPIIbmSHbHmLpdApgT32Jd5kcj90isy0lwtHChgVTpOkifCCWEPM87Wo2oIpZzEmr2Km3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6372
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 17:14:52 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Jan 07, 2023 at 01:38:42AM +0100, Miguel Ojeda wrote:
> > You are of course right that the instructions are not complete, I just
> > meant to add a bit of context, i.e. that Rust got enabled due to the
> > config, but as far as I understand, it shouldn't be getting enabled in
> > the other ones for the moment.  
> 
> Right, or at least the repro instructions should state it clear.
> 
> Btw, this is part of a long-running feedback process we're giving to the 0day
> bot in order to make their reports as user friendly as possible.
> 
> > My point was that the script expects some variables set by `Makefile`,
> > similar to `$CC` etc., so that output does not imply you have (or not)
> > a suitable Rust toolchain installed (i.e. it will currently also fail
> > if you have it installed).  
> 
> Aha.
> 
> > Meanwhile (of course it is not the same as proper reproduction
> > instructions since the LKP team may do something different), the
> > documentation on how to set it up for a normal developer is at:
> > https://www.kernel.org/doc/html/latest/rust/quick-start.html, in case
> > it helps (if you are up for it... :)  
> 
> Probably that link should be part of those reproduction instructions.
> 
> > > And while we're reporting bugs: the error message from the compiler itself could
> > > use some "humanization" - I have zero clue what it is trying to tell me.  
> > 
> > What would you want to see? We can ask the relevant Rust team to see
> > if they can improve it.
> > 
> > In general, note that you can ask `rustc` to further explain an error
> > giving it the code with `--explain`. The compiler suggests this
> > itself, but sadly the robot cut it out :(  
> 
> Well, I find having an --explain option too much. But there are perhaps reasons
> for it.
> 
> One improvement could be, IMHO, they could turn on --explain automatically when
> it results in a build error. So that you don't have to do it yourself.
> 
> What would be better, tho, is if there were no --explain option at all and the
> warnings are as human readable as possible.
> 
> >     For more information about this error, try `rustc --explain E0588`
> > 
> > In this case, it gives:
> > 
> >     A type with `packed` representation hint has a field with `align`
> >     representation hint.
> > ...  
> 
> so the struct is:
> 
> struct alt_instr {
>         s32 instr_offset;       /* original instruction */
>         s32 repl_offset;        /* offset to replacement instruction */
> 
>         union {
>                 struct {
>                         u32 cpuid: 16;  /* CPUID bit set for replacement */
>                         u32 flags: 16;  /* patching control flags */
>                 };
>                 u32 ft_flags;
>         };
> 
>         u8  instrlen;           /* length of original instruction */
>         u8  replacementlen;     /* length of new instruction */
> } __packed;
> 
> and everything is naturally aligned.
> 
> So I'm guessing this is a rust bindings glue shortcoming or so...
> 
> Thx.
> 

Hi Borislav,

Thanks for the MCVE. I'm able to figure out what exactly went
wrong.

In the struct you shown, `alt_instr.cpuid` and `alt_instr.flags` are
16-bit aligned (TIL bitfields alignments are related to their bit width
only, *NOT* the declared type), while the whole anonymous struct
containing them is 32-bit aligned (because u32 is used as type of
bitfields).

When generating bindings, bindgen decides to put a `#[repr(align(4))]`
when generating the anonymous struct to raise its alignment from 16 to
32 so that the struct is ABI compatible with C again. As a result, it
generates a `#[repr(align(...))` struct nested within `#[repr(packed)]`
struct, which is in turn rejected by rustc.

This isn't the only issue however, it seems that bindgen doesn't
consider alignment of bitfields when deciding if an explicit
`#[repr(align)]` is needed anyway, so it will stick such an attribute
to all struct containing only bitfields. So it doesn't help if `u32` is
changed to `u16` here.

This is a definitely a bindgen bug. I'll have a think about how to fix
it...

Best,
Gary
