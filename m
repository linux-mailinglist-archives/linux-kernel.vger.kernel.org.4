Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED3E6D0222
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjC3Kud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjC3KuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:50:19 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2112.outbound.protection.outlook.com [40.107.10.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC483FC;
        Thu, 30 Mar 2023 03:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+gurpft2CdOyovfMpQIwZRKWN3IgFaq8guS7L/QHP6AVQeL+VaTCh4gV43ZqEBZTSWc5HhNi40o4K7m9HRMDTc9LHOPIl1CtGe+o7DdhCaYY0cUfqfQgn8ynoTpJdOs2RSUvskL/Dk0oVPwiT8A24RaLPg8pXX/z4acPRL4qoF25EbXgWCX2Pqk9S2LsWzO/mYc9jzoDznPTEjhQNpqJmMIDbQlxlciwhmhaWF7rBrftFzfeW9QBT550snFap7DzMz3nCyuCeDdoX9BZCedZ2bbLrTYPm9iJ6iNRTsAubES/7Qexywllt8mKUmrnNz6MA66P3ZfV/DCW7JrXN3Y2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0CVLuvF2A2VdXUY0USK22+H4CCtevhGrlRNMDIWAqY=;
 b=mgNbq1cEtKaWcWCqvjVjd/li9WJE18CiuwrTnT3WyYALu8EhlF9SyL9sZiwh1FPWv/+bbrBZQD3CNacvqqSy/NO1kWfHOnMumdUv6/lK1/G5PcZX8JH65fW1PS05zw8P6FvAnhB9rAAcoplrbY1DgxPmMW81ea0n33eheb1ObmDLISakCHtv1V1yHjzITiVrAMmsO1impQ4V2eLsmQJxdXvhnfNxmrfMmJjtuwM4/ePYlcbF7cShPyPswPNY8GYBdmVN6zSTi4h470TOZAGrky19ekzjQv5wsfY/VlvSAjKbKKqDxBMWXqrzTOJfpfRx3xA15/F7+OP6XMarzKrprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0CVLuvF2A2VdXUY0USK22+H4CCtevhGrlRNMDIWAqY=;
 b=jt4AhCkRdjH4Afb+VzbE7Ir+qWonVUbro2+ivUe0Dp9fiUlgILuDB4tP1yZyuLW3AVrlFYSGLq268VPCZHmNNT4iOdZfiDdIsRNpoHJ+k55YztYBolPFAh4mV6F+iB0+0arerLAsJFyNpw/KzOClYxvd4kinCdlDnbmviLcJVuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6601.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 10:50:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 10:50:14 +0000
Date:   Thu, 30 Mar 2023 11:49:46 +0100
From:   Gary Guo <gary@garyguo.net>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 03/13] rust: types: add `Opaque::raw_get`
Message-ID: <20230330114946.696c8e72.gary@garyguo.net>
In-Reply-To: <20230329223239.138757-4-y86-dev@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
        <20230329223239.138757-4-y86-dev@protonmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d36b12-299b-42fd-b3a7-08db310c8acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwW7DcfavzrfhLXimV4rfOKtqqOTPWjqfwbhrdQndz/ImEnSF/1BBpwWeW6CVE+srV0sSziOKjvM3Oy4nOMjmTv0drND017PAW5X+Y3HUKXwcpjgzkGwLL3JzJvhOwmrCpBT/mbNQedJf4AG8OiyxOyW5EXCwWUIvweIjwCCbS0jaVYoqfagEx1kMj4X5XzVVC1tkqz8P94g4rWheERoF3fqUEn0R/zJT6Xge8rfoJFqe6ACBvAlKFWzpfPvPjcIFLzJPLGvbuTrSpTRT84rKrFkp3IK9ryYkQklDuv7ZjaNEfQ46NA3BRCKyle+lZk7q6rtK8YhC3FVzVCK0q818gmqzMu23109Q2faoaxP/PN+mGkc9ahJdbAU44f/tHS4y9mJwdSn2qmhnEAgZAxeICZh0ynWI2DrhQjv2mCnddSOXa+Opz+fPTaa2D5Ig7jmDqqP0/HV6yaIiBGydeNMgE9kfRyf0bNETpd4LK0yomgEZ5QmqeHeai99izKOUMeE7Jt7dImW7rdK6xaLVxZcWzy4JG610I9Zli31uH3j/9UwiEzqCKgCnB0+hapT+Z4B5cHyJKbsr0gxTgM5F6OxVuu05FrPIx9O66KizMsx6G0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39830400003)(376002)(366004)(396003)(136003)(451199021)(83380400001)(1076003)(6666004)(26005)(66556008)(54906003)(6512007)(316002)(6506007)(36756003)(4326008)(66946007)(8676002)(66476007)(41300700001)(86362001)(6916009)(478600001)(6486002)(38100700002)(2616005)(5660300002)(8936002)(7416002)(186003)(2906002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g/j+Eh9ieQ6wKCn3+QlL56JMVQKwix63XdScrbBw845Ti+WzlG5vUTUwXO9N?=
 =?us-ascii?Q?8zSOYXvHRXrSantbIlIv4E5ha/My+/xkQ6HE+jk6fvAZtLqY6gzJfJEMQwQO?=
 =?us-ascii?Q?b5KxsbvfeKC8HIoDyqVGAdqVlsumYvvE46MYFwpC7ug8oVJrj5gqDEnLHWJH?=
 =?us-ascii?Q?lISMMJgiBwCEFHpMDPOy1lK0iAp8XWBs1FqiGQ+17FYPPhrTHSw3foRRMmCL?=
 =?us-ascii?Q?Mhv5gU1CQhNpM/PvRyTPHvZcPp7INQ693o0NcHUwfzTu0cwcMZ4Cx1rghT2g?=
 =?us-ascii?Q?QzWaz+0VS5M90lwu3CPRTRWAyYFQfKYIlLx1YugZqJawisRKgelx8dt49bwQ?=
 =?us-ascii?Q?aMMDyGncCZDqPiBhSw2IHp6Gq2t4wtvy2787jODhw7Ae7D76VvegvKku5zTx?=
 =?us-ascii?Q?TmHx73TwWMK1NoqCAR2iqIPZqCZPYLX+7UnWQbjol7sT1Vb765fg/Hyjb4PX?=
 =?us-ascii?Q?mbM/Dse23OWbrmJO8jNvdGpXIdMcFnEKNG/DnkXHctWFm9GVIEdoZtYjAjVP?=
 =?us-ascii?Q?JeI2vIE8RrqHkKMP1a2ZNJvVoaWOxIzfa9vwUrKUnVPRk3eG3+BoPBAO4vUU?=
 =?us-ascii?Q?PKCq8N/rJXjWX2+/L0joG1xv8MqcgIcuBGIpHAvP+l2KVv05SslGonJHvN9e?=
 =?us-ascii?Q?VtxlOigk5LtZNaaPmmYBX/L2bCDbmKYfODll3vWJX1TfCeh2we326WfrLB/R?=
 =?us-ascii?Q?Ad/CY/uYuNqzlp17aPL8WEXUEYfaWMttn18MKbtr3CmH19jdCItlMsRotEWH?=
 =?us-ascii?Q?LpwM5/sB9cZI4ZNV2DXXfvVMX1v2jXbhC/s90OTObzsjzCFY0EhU5Lg+By2h?=
 =?us-ascii?Q?AQAIUap6Jqy6B5HksMQPG3VVGVOws4uP/wvV0BW9rZR7nyEKfwabyFWX+FDl?=
 =?us-ascii?Q?XQGEF6Ccu1VpnTS3MRUaefD1mFyzZhWY1EU9cSpUltC3UeVP6JCTT61UkJbz?=
 =?us-ascii?Q?2qjRU2LPbFVlaZaAOAmwOypuHWiggZq0TbDwAYD8kCBiDQAbzsDVpCdc9Qah?=
 =?us-ascii?Q?f7bvL7EbNnczdpaAS6SLaWBE3bLRVRNySzc/toDrHFLh33eFuVg0KtMgcVEJ?=
 =?us-ascii?Q?geL45hMtYqj/B7xPlFyPinDbjlPESDGd0WQ49OSGfdYNRotdl3zCmtfDLWSr?=
 =?us-ascii?Q?s9Shu2u2YNuiH/LUJmpTpEmCrgYg+uUNv2IHdNpBks4+9t2idwHp+79/qICc?=
 =?us-ascii?Q?fF3883n4Ad+ejg/NieBErJHLximcctEFXQSRz/gJiv2KT00TbPxdi8+UCseP?=
 =?us-ascii?Q?Ne2IZAf5b3GqBdP5BRmxuLH/2OFXCNSplo+hLuGfFeiO9O9QDBLh8dipUSsU?=
 =?us-ascii?Q?1jSGGzCqctU9qNA88iq3wTq2NhYnBoRzD4UA2esauOmoa2RpAVyU8YcJtic5?=
 =?us-ascii?Q?MdNP99DYzDMee6DcXVnrzK2SPnwC6pEjvTU1JuHkdwaoAfqgf74FzmbG+fLf?=
 =?us-ascii?Q?Q7Tqh+Tt3VDfCOOtzpeELolUJK4TMfKKPEahpm0hKsiankZCjQfJe+ahq/lN?=
 =?us-ascii?Q?9XB2qZntY7XpyjuAatb6i0/73RXF+ykL5jVezq+atE/u2jljSMP5yIDULays?=
 =?us-ascii?Q?lhNR7WGnQZwh+x/MZZwOlBOdKijGNAYrewLmzYVx?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d36b12-299b-42fd-b3a7-08db310c8acd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:50:14.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0jmTXnTNOMZV81IHKBOXAc3wMPpWzyhdPo5ThiR6S442cZV/ZA4W440o27zWf0frTpoYpp+bpq0gxwkuNZWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6601
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 22:33:03 +0000
y86-dev@protonmail.com wrote:

> From: Benno Lossin <y86-dev@protonmail.com>
> 
> This function mirrors `UnsafeCell::raw_get`. It avoids creating a
> reference and allows solely using raw pointers.
> The `pin-init` API will be using this, since uninitialized memory
> requires raw pointers.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/types.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9d0fdbc55843..ff2b2fac951d 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -238,6 +238,14 @@ impl<T> Opaque<T> {
>      pub fn get(&self) -> *mut T {
>          UnsafeCell::raw_get(self.0.as_ptr())
>      }
> +
> +    /// Gets the value behind `this`.
> +    ///
> +    /// This function is useful to get access to the value without creating intermediate
> +    /// references.
> +    pub const fn raw_get(this: *const Self) -> *mut T {
> +        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
> +    }
>  }
> 
>  /// A sum type that always holds either a value of type `L` or `R`.
> --
> 2.39.2
> 
> 

