Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A76A25DD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBYAlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBYAlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:41:08 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2101.outbound.protection.outlook.com [40.107.11.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852768298;
        Fri, 24 Feb 2023 16:41:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoHNRAQNbuhwrIvRv6k/4+P2nZd6WUNt36pSJuhzX3J15NR2XbDgYrLD7EHzRx0PeuR4dwuDLWrSO2I1cggZokg0KEo0Y7O8Ke9m7dC/R8xr868rWrohDOPDNAicZIX/jkMEV17pF6KrQ8d9Sz5KMJR1CSG7G+Yxz6X30WDWspDViBkN/AxDtAqcCmO3vW+I8cg66LqExxv3hdFLKA2eGKyIHLYdljlv1m1AmShFogqdSj5VVUU8rqkIOPjkzSd6Z7pHotyILnQ8FrvSNerrNPKjsfyIwRGzwfGZA4F/HDRW7ujjiiRARTX+RKm/glIBvjschRDZiB6ySd8g0QzBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgW6RmOEtfAiIVNeNNMbKc2atv8EZyLEU8hkHGPIkVU=;
 b=odHR6azB1fP2hxSDwQQLPPHVh8vXKskaKCsuVqNlYLpkFPBdGXep02mIfReWVOFYtGsW56/HlcTUbJm/4cGvre+Cu/bdLdp43sdoInPA9ttlFhwizFTsCUTHr2MkkBOwjuRJocSoXUGX7wkWVXylxpJjucZsJnT/2YS9muwBMlzg+gCpV+E+FK98mB9IXKSuOt028yxMoMX+hg6ZfUofNRBXVJET3o5p2h8yTwnX+3X7ahx+d8W2sQfMKUQoTQRpWLE8DZz8JGLrCV4s4dYGVjFeUcoqQgeDJZ9A2Sev9kOfJdEH+K5RDmukL7SFf8mOSNC1eOlNxmGUW/IDOWov5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgW6RmOEtfAiIVNeNNMbKc2atv8EZyLEU8hkHGPIkVU=;
 b=gzcm0yC+d224c0+M2vKphdnJjrjzN/DUZ9PWL5Viq6z1RT80cKH0ljhzcQCe3eI2A2AHysyYyyGPSYJbfPCsc3xCigo/y1/k3Oz+Jc023x/mBGE4PYE0GfpbIi6IAV0fvr/XTT3K10YJymvNO+THQg/se4lLIiEtKjLDE+mU1Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:41:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:41:05 +0000
Date:   Sat, 25 Feb 2023 00:41:03 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 2/2] rust: sync: arc: Add
 UniqueArc<MaybeUninit<T>::assume_init()
Message-ID: <20230225004103.5f50c10a.gary@garyguo.net>
In-Reply-To: <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
        <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::31) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bf3398-7ec8-4e35-67ab-08db16c8fa37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Im5EIiM9XZwI3C9kJsASNnKSORowYbnhiBZcX10NUJ/vVEqtvGAocEvcbDHRrib0S3+pzLBIQi0+rdOQ+PyQbyogvHv2b5A9iNRkWt2JEM8GmIOCKB9PuM7LxBIp+6ew7CT2kHuK7XOU6oyP7ZTdU2MwPj06fYbv8vk4BgynhrSMBoM69UZt70zNRsSqzMpAckXWv/wyir8VhIGGFK/bn8bb9Ap4z8IlnWX661rcL3KbARxibcw14jNctzzbi/n02ZgFyGnHM5YCjl6sI5oHQleuNCnmx0nlk3iz3JlCa9jVNLDepxqAJrgSZliAfvuyahlyfRGp8jZBFcMEwhBfrLOC4jnx4ml0WaGfroC8zHqnRpg3EnGP4jdhAnZPZbNxQs1TyR8hOayOKeJAUvcWJyOBbV8Swl0r8NE3syX57Uq0wPC1+J/U0Ie/TWsM0BLEoYi9iTxUW+/hY9ttWqdZkWCo72MVNmuEGtNNG1dmm6MlZzubTZNrNr7uzueYapbUkKqWs6frAheRwP30C9GHnpWQwPjPiIydd+lnHsQNolG54UaJKo6Zm/Exst/pYdKJtEf010JEu55HLJsxlihHF8Js3iDBTVoGgZkLOjIrFxvnlyHlqjZmko25BEDIbtLUJrmbk6wcG6tnM9v2l45Lng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(376002)(136003)(346002)(396003)(451199018)(5660300002)(54906003)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(6916009)(8676002)(2906002)(41300700001)(4326008)(6486002)(6512007)(1076003)(6506007)(38100700002)(186003)(26005)(2616005)(36756003)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ro7IKiUckoqhLNl+pUi4de34efkoY55jU9KDLqBU9dTwuGGEVUBF7s4yqILG?=
 =?us-ascii?Q?1sEWysIBb5+g+Te2NFAEdRwVXJTqiO+7MK2HMOZQFw5W5pcoTtistDBqcbos?=
 =?us-ascii?Q?N8UK1lrHl52yy/2JFJb+3Cxo6XDFfGsO9oU5ZedmRQ75qhlFlnmvwYd6LPey?=
 =?us-ascii?Q?0dcegrX6ua10tOFfdNiYWv3uUphVNcyNh/6qu5IHJwSO197hHytS9rWW/5U/?=
 =?us-ascii?Q?nBwtxeETlAu8pc8zaittyYumF8/WNI/0HgfDA/h0XX2LdG4rSwX3aXlfIomJ?=
 =?us-ascii?Q?Lm1sLPtBHDCNLZ19Mjrk4iqczoZ5IAPwg2FiRUvn+P1lGpr2M79kC3itLrel?=
 =?us-ascii?Q?69ToEGW3oOFbYmPtctWljWWnnpy6C0FL8AcMH0eg2Ao2CIX2la5Qv+EbO6IN?=
 =?us-ascii?Q?Vzv0janKJ8l5y4hCP8u63SA9V76hhqgu73evzkwYNfUu3p5NQES+uCnCFVes?=
 =?us-ascii?Q?jxnmgs7jVFm35aegQf/8W1lGjDD08y4RHpwFumQnAk9s+3ITL+oSw25gZb7n?=
 =?us-ascii?Q?yWZ/UlYfvHBk+4/+zjPYE7D5UGOysx9qY4zOsTpJLsDTHudtbwjEG+rn7B0Q?=
 =?us-ascii?Q?dqnCI003u32m9Ka5hR+F1VkeejVT5+DCwGWmiaTuLhdlrrvnhG5uZPQroaNc?=
 =?us-ascii?Q?ANo4SmrqQ5l1ImFBY0i5spFpkripuViyQMCr5IjQ1t+IxcZmqU2YMjPYNZmD?=
 =?us-ascii?Q?bfHrMgtzbiBQqZpoFkB+e4OzXCbqTfReQKCWaR8bPSCmj2ATAVkJmaO63tP5?=
 =?us-ascii?Q?BkW6WuCyAYWaT/l6g2IIWsrxThaO/4yIxQeXMmGk2n//qOjF6yRxIyZoHghc?=
 =?us-ascii?Q?YM6Vl0iMEpq3nzMAYlBcGPDMmSWJ4xshJM5pmKI8RgUpKxjEYqIyzA2PcdVM?=
 =?us-ascii?Q?6yjUr5GEiO33Fp1hQGeRVbkxhcK8dFzZur519FmUvYuCqAiT2c8DkOJ4IzT2?=
 =?us-ascii?Q?awlhsPqPQy8ge2XmEQnJUfCSRmEE60yZVcesM0TAjL6IT4bKn1QCrcUfbwnJ?=
 =?us-ascii?Q?P5pGo00Dvv9X0hO2cjul85yp1AATbvDCgAC6f0VnHeJuBHCdM9Ut9kngeamm?=
 =?us-ascii?Q?gJM/HBS7ZXIYlbLIITP8jmw6KYjDqGIXvi2YiC5e8Yim3ZH0dNPszKGVJdmy?=
 =?us-ascii?Q?0AdOHVPvLLPSzcn11l0fyvm1IP+vThbNlwVqFfAT7iGZsU1T5sAMB10/y2r7?=
 =?us-ascii?Q?EEz7nxzzLOXWCJIWE7Ie5ZVCuPD8oWUh1hOK418NK2cgFD24woskMEvj3zjX?=
 =?us-ascii?Q?+VVnQ0RNk83mZL7/incQ16BetTCOhNOP/YTORjd5Ue8zVcoLD4rQBxfWdkKI?=
 =?us-ascii?Q?0/KRkBhxl3Y0FSSpCzt4iJB5BEkVMxB1/0LnuPguW7fhtQZM0M0WES9mAbbM?=
 =?us-ascii?Q?79HUzZK1XcGUMbaxvJGO5YCYur8zI+uhK/Re03MfVYwvabKLjukkX5MdwyVu?=
 =?us-ascii?Q?ThDQo5PHl7aMdCNzZJV/+m+gP2dKq8NavURSZvJ7hy1ZmYVWWPG9T+IDx8ca?=
 =?us-ascii?Q?xZFAMjXVPiuIfBGq8qoymMeR2fK0xvVKhSxNrrh4SJ/ks8wOZSEnG1eye+VO?=
 =?us-ascii?Q?8jy/khZ1pazItugId5Ytjv6JrOe33xqQDp+kYclH?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bf3398-7ec8-4e35-67ab-08db16c8fa37
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:41:05.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLi3+4as7P19lK3F70mKrN3gloviO9nSO3VstQncRUz0qUXsvqLJpKcJU6jhjYEOu/hDWJhRMM/GqhFxeNfzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 16:59:34 +0900
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
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/sync/arc.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 752bd7c4699e..b8e9477fe865 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -512,6 +512,15 @@ impl<T> UniqueArc<MaybeUninit<T>> {
>      /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
>      pub fn write(mut self, value: T) -> UniqueArc<T> {
>          self.deref_mut().write(value);
> +        // SAFETY: We have just written the contents fully.
> +        unsafe { self.assume_init() }
> +    }
> +
> +    /// Returns a UniqueArc<T>, assuming the MaybeUninit<T> has already been initialized.
> +    ///
> +    /// # Safety
> +    /// The contents of the UniqueArc must have already been fully initialized.

The types in doc comments should be surrounded by backticks.

Best,
Gary
