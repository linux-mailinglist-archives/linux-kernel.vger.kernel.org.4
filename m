Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9B68E747
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjBHE6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBHE57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:57:59 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17ED42DD2;
        Tue,  7 Feb 2023 20:57:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MickoMibaD2tEfxbtO9KO7VcjKl8cjIhF/AdblIMrCoSZkFov29HutRzIFtsYVuOpTjJzsLYtStA0wgfgXLyxmwNajWCZTVAzWMAGyXaUhz0D2i1VusEX9Xm+2urKR4FXqkWCU22utf/wwvMYIGyX6jHyI8c/GNp7UtH8bvB4X8sQnj1LIlbQZ4ZhRU4x4b6F4rt/bXyTSH/1AdFOYxT7zBMdQ6GKdIesMu7hoLNxWwqmFFGYyUJsp7/vZo2NHN11J0GSE9dmH7hQ/4iV7I4OUe9SiJQ6lpZQEqx38RXOrBdDLmxvsrptJ4VAU0XhqJvcoNYLS4i5zOM1sqz7DIOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUQyAj+MVABdPpEHb3PkXOZLwcSBBJXVgiO3mpfD3+w=;
 b=B6wpjrsI2G2kAzgK8wGggx09h656ol65CaoNVgTzI/RMjM5wDeAiwCMZl3M9CpEPiTpe1SIdvU8Xvy7JEWdJBjh+w/w29P+kqRC9AHbzblrowxEi73Z5mRQyJDE/fIxW9eO0P4kGiZ7//tz/fFaLTLRuPkq7EaXNZaWf8oqiTFho2M1AXVxtI24ZM/IpMSiztp0RbkWtQdmPTzwsE17SlNwPe70kXEApUzN9BKyYJejjNOOdCPkBSBMnJUkX5si4fkYFKMWnEOcVmVoPv3YtYaOn3bqV47AqRC1fzn57qim+9SESuWut2ZdFQGcZcIwWECzLo+fWHpZ9ovnBHd5HfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUQyAj+MVABdPpEHb3PkXOZLwcSBBJXVgiO3mpfD3+w=;
 b=CmU41UZSDr3znMsbO2PyKtwN+o0t4PObaKy1jeUBLDI3IKsohxPbdti4SXjHV9QqF0nWmBd5oEF6kwea5jk8B7HdCWPkf5waqH0TNLmt94WZsrW0gfuHweNqA3Ykph0KlScT/dccm52xTiWLyaEmB84E0Oeh+pFF6XGq1A+CHjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB7287.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 04:57:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::b96e:93ad:4043:6145%9]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 04:57:57 +0000
Date:   Wed, 8 Feb 2023 04:57:55 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio =?UTF-8?B?R29uesOhbGV6?= Collado 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 2/2] sample: rust: print: Add sampe code for Arc
 printing
Message-ID: <20230208045755.6e4c1d72.gary@garyguo.net>
In-Reply-To: <20230207185216.1314638-3-boqun.feng@gmail.com>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
        <20230207185216.1314638-3-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eee874e-c493-42b0-9b88-08db09910b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EMO1eHEbGCEOh+pscZIBvo4jV4WhTYoMz0Qh5fuF5CCrbiN6LkfLdxRWofQTijZd/UZvIDUh7iY6SB1hcy/9bTZlDZp6I6oswdh/xjCfIQFEPOkeX38oH/FsUcRqpTfKpHNhu41xpcQWsbaoHBo3PEEHW5zWsUJiiqDFVJm8NWaFgtxrK/IIoWxLmvPzPuxCOVitaMxc2GrChRKCDht03Y+aJKBJRNVmpgyTXNufeheiS7MU5ZhfGwkracvVt6dt8XAmlxaDO3eYWTsKH+FCPa0+U8D5XhGGgCIhOT6n4Zt5sHyvWXVc333kLjSSuzOYC6sT1JD/Cf5iCo9eLWqXOgmhAAYF4263DGBeW/dtGHblbZty/GYtwLXOWX/4h5vp1lQbCrAuZeDSPID7PXj1uUPBc1ZQeexLuOo+LYUu0nf2ktuzZEsAtlAwE5ZHkOMmuhwSGByn4bwr+wZ7ORdET3IRdsLohK+UvGbFlOL2IhNYqlzyBAXCNseku+frEXePF8oiQ05VgeRdcsr7EtP5eN4JopZui2pSHuQaHC+nSZIxXtIUqDVhSL4ebOtJmbNEqTxkXfZ3dNfCk42YnHfMATKO5Ia1Ru5j6uRqHihe+kiVfFdskpjryMYg4Ln4cLJdyK5WH5k0N+34z1NHgTCRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39830400003)(396003)(136003)(346002)(451199018)(7416002)(8936002)(5660300002)(2616005)(66556008)(6486002)(66476007)(66946007)(6916009)(8676002)(4326008)(38100700002)(478600001)(86362001)(41300700001)(54906003)(2906002)(316002)(36756003)(6512007)(26005)(186003)(1076003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdVWUtWLzRRcWJQdlowMkpQQkhvQ2RxTEtScWJ3REx4QkVYY3lKQmlBU1lP?=
 =?utf-8?B?dnlkTm0yQjEwZGp1c2hKLzBNSTZKaHdQN0h3UDJ4NEs4RHNRN1gxY0J2THpZ?=
 =?utf-8?B?S1M0QUhCNWl0U3FXZVJTRDM0MHFvRGw0OU1FZmJRZ2RDUDVabUx4dlJydk1v?=
 =?utf-8?B?cGErclEvb0Vob0RxcHNNekVEU0w0WnBueldoRUlPL0VaZ09VM3pEdm51Z2xE?=
 =?utf-8?B?NUZRRnR5R2JRMU8xOEZUVGEvZVN2dm5Ra1RXajg5TndTVXg5cnN5MGRINGI3?=
 =?utf-8?B?VTlrTnFuUVFjdUpGeUs3eHJ0MzZxc1g5eS9QS1gycXhHZU55blplRHpvaVhS?=
 =?utf-8?B?c2gxVCtiejRYaHNXclkzcU13YUt3YWdYcjcyU2RhUkJTYnlBVE0rOEdkUlM0?=
 =?utf-8?B?c1h3YUtxdTVDTngxZCtqUHFKYXhqZm92VHNoL2dqQjg3NXhybGhROURvUkpP?=
 =?utf-8?B?NUdHejc3dU5SSEF4bFJFQXZhcHN0aitQNDNaT1lNamJOd0ZhWkE3cktIOE1h?=
 =?utf-8?B?TlVqaUd2NDlGYStra1BHck9HazdEL3RoTldvOGJoSi9pWVZpL1hNZW1BaVRT?=
 =?utf-8?B?U2dWaUpXOVl3c0QyeTcrSjdmN0VlT1RyR0FndHZ2RlRFc2pHblBpTHRRNjEv?=
 =?utf-8?B?VS9CVnNnbWpJYnhlL2QxdThOT3cyU04wdDdDTmxSY1hDeVhEaUpsYU5tbjNn?=
 =?utf-8?B?cysrNzV1aDdJUU5DYUZjQXV2RFRQMWh0c3JNM0d6b1NPNzVuS0lvTnBGTUdk?=
 =?utf-8?B?KzFYalZ5bmFEVE5hQnk0YWJxUkdpQlMzQkd5N3ZmT1RNSHpyTW5zN3F1K0NB?=
 =?utf-8?B?Rmt6WUlzQ2tiY0lhaGhMMUxzbVJDTmxHazAyNEc2QzJwcC9MQmYrSjBCRjhN?=
 =?utf-8?B?R0s4MmpXSDg4UFIveEN5Z0JRK0hCY1RadFFIUGtYUEppUGNLYVpjT3RKM24z?=
 =?utf-8?B?b0l0aWs5cTVYWmR6L2M0Z2wybUxVakR4SHBUZElzTkNYRWhQTmVQS0VMSmdX?=
 =?utf-8?B?d3ExVnZUeUdlelFsNS9jd1VHQkZPUVBzam9JY2FrU1E4VUoweURaSkczaUZX?=
 =?utf-8?B?ZElMRzU3ZkpVcEFTTE8yVHd4TnNvOC95d09YTldZbThNZFMwNTZUNDJaYW9B?=
 =?utf-8?B?eUNEN2JBdW5SL1UvQnJoMW84U1RQeHNsQytIYnlQcGRCR0FTUUpkekpiYUpq?=
 =?utf-8?B?bDBQTGZqTHVWa3AyWnkyZ3hzM09Cbk55Vms5SG9PR1oyWkZ1ZmlkcW1Ba1Jx?=
 =?utf-8?B?d2pyMUdueExaMUxzQ3U1VDFrTUpDR2JDL21Qbit6YktubkJtVGErSjZ2RWRV?=
 =?utf-8?B?aXFBZmlwRzU5Mm1TVnVnN3djZWhkMjZjZTdLRWZsMjd0bEQ5V3ozRGJTOHM3?=
 =?utf-8?B?TU9VbkFMRzVjb01idFFYbklhTGpNMDhIT1gxNm5EM3prMUNUWjBjV25hRjNx?=
 =?utf-8?B?ZXd3ZUtIdjEveXFOSVlFVGFEQlJacGFwRU40aGRFNFZiR0RRYnkxNGR4ZlJM?=
 =?utf-8?B?SGt1MWxsMmZQZjI5anFITzRHUHNBdkRPOHBaUUcyYnlsdjJlblVYM1JuN2Nr?=
 =?utf-8?B?RWtTSHV5VFZocXAvbFFtQ3daWmgzeFVGSi9HN0lMZnNZU0dPZiswc2poYTNN?=
 =?utf-8?B?L2h3Q0pDZFZHdzBMdk5WQ1M4c3MraUZXOWlVRTVWeEpTMzk3anFVaU5nM05r?=
 =?utf-8?B?ZEJ4NVVlb0c3dlFSTmZaaUpOMGRFdW5BakhWYTE0TGRHZU1HOVNLM2lobHEy?=
 =?utf-8?B?TFB6cEhsWWJFYzRCWXhpaytFYlh3U05aVVE0djYwczJEcHFkbXNQUUcvN0du?=
 =?utf-8?B?NzliUms5Z0JFVlBIZ2hkVUpqbEwzcngvd1piT3Z5YTlCemZaLytoc0VPcUdK?=
 =?utf-8?B?Q3RxK01PVkxNSFFZa0RYeFNTNWZOcnE5NVFVVGYvT0ZwOWJFUi9aT0lxZUh3?=
 =?utf-8?B?NlJlVFlLbGpETDZsQjhETVZqV2pGR29oem9hcHRwc2YrTk1rZ21kMDA2TXVj?=
 =?utf-8?B?RFRpbHh2cmZDRW1sOU16bnRHVTNabUlDWkFlWm1DS20rMFZBSTM2VVJTQzBC?=
 =?utf-8?B?UXdNV3YwRDlxNllPTVh5ZHlyamZxU2szbnQ3aUlTM0xsRGR4RlZ0a0pnbysw?=
 =?utf-8?Q?MkJJJjXsPEujk5PHO/DgjhX1J?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eee874e-c493-42b0-9b88-08db09910b57
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 04:57:56.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R19Q0uF4qiwlLRPQgWSXxKkzu242+vMH2LvTx5XivJOgKG251HwRs5y42JkWaauPT5ROHric/LNkY/P9qQ6jSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Feb 2023 10:52:16 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> This both demonstrates the usage of different print format in Rust and
> serves as a selftest for the `Display` and `Debug` implementation of
> `Arc` and its friends.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Reviewed-by: Finn Behrens <fin@nyantec.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  samples/rust/rust_print.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> index 8b39d9cef6d1..165a8d7b1c07 100644
> --- a/samples/rust/rust_print.rs
> +++ b/samples/rust/rust_print.rs
> @@ -15,6 +15,30 @@ module! {
> =20
>  struct RustPrint;
> =20
> +fn arc_print() -> Result {
> +    use kernel::sync::*;
> +
> +    let a =3D Arc::try_new(1)?;
> +    let b =3D UniqueArc::try_new("hello, world")?;
> +
> +    // Prints the value of data in `a`.
> +    pr_info!("{}", a);
> +
> +    // Uses ":?" to print debug fmt of `b`.
> +    pr_info!("{:?}", b);
> +
> +    let a: Arc<&str> =3D b.into();
> +    let c =3D a.clone();
> +
> +    // Uses `dbg` to print, will move `c`.
> +    dbg!(c);
> +
> +    // Prints debug fmt with pretty-print "#" and number-in-hex "x".
> +    pr_info!("{:#x?}", a);
> +
> +    Ok(())
> +}
> +
>  impl kernel::Module for RustPrint {
>      fn init(_module: &'static ThisModule) -> Result<Self> {
>          pr_info!("Rust printing macros sample (init)\n");
> @@ -43,6 +67,8 @@ impl kernel::Module for RustPrint {
>          pr_cont!(" is {}", "continued");
>          pr_cont!(" with {}\n", "args");
> =20
> +        arc_print()?;
> +
>          Ok(RustPrint)
>      }
>  }

