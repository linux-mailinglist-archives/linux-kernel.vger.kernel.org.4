Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A76D4BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjDCP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:26:16 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2119.outbound.protection.outlook.com [40.107.11.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B641B9;
        Mon,  3 Apr 2023 08:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9e1jvad2Pb1kypZEvHfpQ/UOk9Ce6Md3pWqG+sMYoc2jrMUm3+zvrC/Q4qvpGaZ6mg/TQ14zfdnTH6w64WzRAdyZ090VaylUdNqsJH35At2YXNMx6EpKCdjPfXUo+UTeugwhcdVmcSosRDvCVKPnLRbSEUzatpp+OfN5Mn1769O0Gwwiu1Bwd3F28+LjuNo8lDh7ue2cSexFMloeAOOaQ4vu4fNVhcYXCEHoIly70hsC2Y252Y6eVTTQI5SpERFmriXVBbYnTacKn0oRie2yL76/PwSbkXoRwGiUZo4G93jiTAmQdSL32Kk6SU5Bd1fNrJLlAfvbod599bwydXJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6q9hNQ/sDy1kt7vP3YeRs2LfI9ZaQX4oAAYG4ifw8E=;
 b=k9Wq1JLvO8mTf2T9lqg49GctSykmP52hm8OoWyoP1u/YrSW9ci69kvLS/2coTAGrMHV20MZ3u/gj8q412OOUcqMAknvn1sXP21w4g8c1L1a2bPI/cpekpnNOPWHjWHWdsdXA+5fOHgAuTyUXL4QI2ygz18Ekeo0BnWEbX16MW8K4f3WiNboDpvc+BJPsiksL2DvkqZ5fe6yswqdM0C5V7XRAzu8jacT9FCl1QLaa2RFl4FeuIkue3+ftwuRDIoZu2sNUj+nEhkO11uMXP+uyqWkY6MBJsQyzRyf+xd1MAd4/qN8aOn1xrDPea3mCbc4+Ama9BDhJ5Ao5U59ZLC/+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6q9hNQ/sDy1kt7vP3YeRs2LfI9ZaQX4oAAYG4ifw8E=;
 b=dCWo/Pr1b+9WhjF1OUCdVGBs7iElwe8QrvmKkPJBk/n0Lj93lkw3FpUg3FV9LQ2R4kY6hFbVjP7ryiLVkBayxrZE2eRPbCgY7a+P6Qxlqy8RRR+GyMcqqJjj697irNaYxV2ExhPKL5f1URwcuS1/8w4JcFrfuTduvpmMtjYlop0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6327.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 15:26:12 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e1a3:5e38:b483:8161%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 15:26:10 +0000
Date:   Mon, 3 Apr 2023 16:26:09 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Benno Lossin <y86-dev@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH v2 2/2] rust: sync: arc: Add
 UniqueArc<MaybeUninit<T>::assume_init()
Message-ID: <20230403162609.286db824.gary@garyguo.net>
In-Reply-To: <20230224-rust-arc-v2-2-5c97a865b276@asahilina.net>
References: <20230224-rust-arc-v2-0-5c97a865b276@asahilina.net>
        <20230224-rust-arc-v2-2-5c97a865b276@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe8589d-d944-48ed-84b5-08db3457c0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dh9egI2k4N4koHodIwsdxGA7D//HLUicisulDpbUwZxPEPCP6O6mf3aZAV1aLdBQpg9nmXXWO3PXLfmJqW5gefX1bfwnnnVJAzClPBs4zPxJGu8URyykzEBGtd4gTWREW1pkObsFdk9r5xcskmt4SCWpBiYAlmBEmkGrb/MnbOLtPKdl/dpMJTkffllyTYbuQZtWGtQHABizofmikfpe7WdUd/Hk0xGzqjuZtdO1UrOlmUSnXY2tKlvRqfJz9lcKPgDB7TLMrZGqjsMIknrQbtWhLMNMECW4w+FPkNd4Q7Fc/eTN3EhvgXa/kyYU5wsPwAlr3/Kdxn0Ix2ccrr3Xir5Dgb7nkWvzSheSl6t8Q3KffkWUEhn4WpoQJMHj2BlMco0vuNvsv3h0suOQnWldasQIEDV2R+titIe2QeZMSZKLbjhzDS+mSnEy7EXgnbUfeB67TFgegkdHHHLWU8VfEvEH91aQztwq81iYlNZ+z/qiIBuU7uIuXcTD/y39YzHCn2WQ9n4AHbNPaAvZO9feyW4speAjczEi8yeaa8HTewXHtr6/Cjw2l3zcgqHIK0t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39830400003)(346002)(451199021)(8676002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(478600001)(4326008)(8936002)(7416002)(41300700001)(5660300002)(38100700002)(6486002)(186003)(83380400001)(2616005)(6506007)(26005)(1076003)(6512007)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0Z2Ct0SYy0N26ADnYhgxUO+Upkva7SgwXcw4RpuwOWfJ3IBeFU4i5ivupZ0?=
 =?us-ascii?Q?pP6L2dViuwC3FVeT+b6A/qJlqsoFXv4jCUNWf6GJDYWF4mdk5z4eb0vrXwRV?=
 =?us-ascii?Q?B6009WeUVN5oXW1vMuFE07d25xQoA0V+5+9A4+ObgPg1jpX/JVIesc6geTyT?=
 =?us-ascii?Q?BJmCdkh/F7k143CUQineqwd+g5wvyCNxFAneCrdiC+SDd/VQ+NyQnUiwuzdg?=
 =?us-ascii?Q?7J+xpZwRrBcrW3lMA/He4FP9iW6EYwgYgLxuu37kPVVQCsQNIvMtjsGZZyQP?=
 =?us-ascii?Q?ASyma6bCmE/pXKN7oPMfNbSRUelcncPscddwCrzo9I6SLIL1jDfTr8Rb3i9l?=
 =?us-ascii?Q?NdUws0w4msOytRQCepmTY4yMZa0mbVNEuIit9hN+XDDdWx+vxd6RzVy1gYY1?=
 =?us-ascii?Q?FZ6JXpwWeB+hhgmsBH3Fu1rXQ+hah0zUk24Rmf0oBhsX/T3cTkglsYW8IzQ6?=
 =?us-ascii?Q?otDx6h3XwJMCJUENl2Eg8QbsG/bN9k1psM8/zzx79CheFuNreZD+HQj/qeXb?=
 =?us-ascii?Q?Farka0ly+2gw9KbKiothfy3+WcyCRswXdn6xMizjEd4H70z8yCSkOkSdKXkq?=
 =?us-ascii?Q?CTv7QWUk4IfGpiwIsmzLqSM4YaZZcZrcgeNLnJqiXJJs/nFw8YjocexpuOXF?=
 =?us-ascii?Q?hUenwYBu+NqdZBLofVjv3IGpQ2IKufwsxZxVW5NM4UxYoVrTIZfLPGVT7WX9?=
 =?us-ascii?Q?OK4ePuv4vT1jIsRlBT6uBwKS0mkKkxDPrfSUqDX8OU0rVpaHnGFL3gghq4j9?=
 =?us-ascii?Q?/K/nDoWgNW6AL9cHICYRI0lI7WPAE+RJ6OriJ+psPfWl1v2WOZNW2AcsAkYC?=
 =?us-ascii?Q?K7lBSlEq2aL357D4wTiNMaBGLtX3OgeRtmWhjdgrBxnyhrVV5ZBV8WUeHXNz?=
 =?us-ascii?Q?EaFyJv7oy/4gWY46TbDX17PlMLBOWIOBJ+58bRa/NMsz0S31AO8KgN9rVzUP?=
 =?us-ascii?Q?eossgZfrNktHX13Bd+aOC0IQ/4rnGAqGAJrUPmiAMs04V74JtnOoJVLOakjl?=
 =?us-ascii?Q?Jpjf3BI3DJE4naVZ4mdsGULVa6hLu8IOVSb2OMIUjcQNAPfsnhn70loclfJQ?=
 =?us-ascii?Q?7QTozTXSb2o/BTJxBwzjqF70kWaZa5Qeb6b1JkqtkA3T4E1M/oqX3vaiKqnz?=
 =?us-ascii?Q?aycGXo4DUQNs3mCFlCgetOz1xRyMKea0jBpQEhd+dFobq9p13xXw1r0IX7XQ?=
 =?us-ascii?Q?Yn5RP9Ms/uojNvsezp3o3U1uJ05x1AiNId0akg2vpV0f6AbWjgpjocwq9h+a?=
 =?us-ascii?Q?lmoG5GzZK33pGN0v+XEQ53F+2HR1Da3d1hKMvN3linHCIjs8mTwZcmM9KFo2?=
 =?us-ascii?Q?cWrWSBp/ArHPVzcNpClm3816SNhpXimH6b+L7vZkwCXCBQXKm7NvE2dFLe8l?=
 =?us-ascii?Q?ihBGhRKQut5tkYw+wjrPKw/MZKc7tBJNkcL1Lhm4lFqr0MIN4mjytHF5NF0s?=
 =?us-ascii?Q?Mfr3OMnC39y0gzT6R+rez6NErfCrtOT49XK8S0HKn6u7NyokP9SAjHGRSj4U?=
 =?us-ascii?Q?5iu9BS2EdGHP1R3BJ7QeRC6Nm3V7RreqcmewtjkcoYLWTWHf979ZE3JmfcCf?=
 =?us-ascii?Q?n0FNTK+3/6xtP6JhmbZm5R+Pd11qNnhB0UaUuYoH?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe8589d-d944-48ed-84b5-08db3457c0dd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:26:10.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: On8ziUw1agqY63zr8SjLHaGbRt8cwWcDbESOVSFGS0KegLJy1flOsJ/zQl7fHPGODJYUX2IuthDzX1EeQwzReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6327
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 19:01:12 +0900
Asahi Lina <lina@asahilina.net> wrote:

> We can already create `UniqueArc<MaybeUninit<T>>` instances with
> `UniqueArc::try_new_uninit()` and write to them with `write()`. Add
> the missing unsafe `assume_init()` function to promote it to
> `UniqueArc<T>`, so users can do piece-wise initialization of the
> contents instead of doing it all at once as long as they keep the
> invariants (the same requirements as `MaybeUninit::assume_init()`).
> 
> This mirrors the std `Arc::assume_init()` function. In the kernel,
> since we have `UniqueArc`, arguably this only belongs there since most
> use cases will initialize it immediately after creating it, before
> demoting it to `Arc` to share it.
> 
> Co-authored-by: Benno Lossin <y86-dev@protonmail.com>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index b904ed898d3a..b664b41e473d 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -489,6 +489,17 @@ impl<T> UniqueArc<MaybeUninit<T>> {
>      /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
>      pub fn write(mut self, value: T) -> UniqueArc<T> {
>          self.deref_mut().write(value);
> +        // SAFETY: We have just written the contents fully.
> +        unsafe { self.assume_init() }
> +    }
> +
> +    /// Unsafely assume that `self` is initialized.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller guarantees that the value behind this pointer has been initialized. It is
> +    /// *immediate* UB to call this when the value is not initialized.
> +    pub unsafe fn assume_init(self) -> UniqueArc<T> {
>          let inner = ManuallyDrop::new(self).inner.ptr;
>          UniqueArc {
>              // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be
> 

