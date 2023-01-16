Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC066D172
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjAPWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjAPWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:07:58 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2112.outbound.protection.outlook.com [40.107.10.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EF27D54;
        Mon, 16 Jan 2023 14:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBKo+i999ws5ave//1TkispazpcHpA83uzKphf8SFeMuwpIm9msMnqR6ovLU+kdF+MOTebKEIB5xRqDCX5UZhnjB2Uyy2A4DOugHyfsJcnx+AxeL3hxWkEjrlHIODVPfy/OwG+xg2bmSRJ7BEC7xSnfXYh1ybtMg59HDS+dq2Zipuav2WAfBcw+Q/bbHmWHw/RBQxTejWGXhRIZK8WTOymG/zQkHCh2IfuT45sEQXUIQ8cDv3LJ2/U1c0qOmYYX1NKpv02POPOeraEpCZE6UEUuX8S87K9Jxq62q5PvBrVMaphVx7RJir7GrSDASNaxUEnhX8s+CnpVIN3jj01xGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhmMFTWSMPNvAV4qG0G6UDTnQ+bf39NFlZKO7AZ4g9A=;
 b=X4FRs63cBK+qW64h2cA9qxaHoFpRTueQrOjj7qkdrBQeb39bKtWfQe8y7qpdDshaLj/Fq8C48YzbbGsxj1MUM8q/FBAoDv6/4aiG05qrRKYyJxmVKDuesPXNBoSnTQq5N76bL027pSowFo7pzm/SnaRHHUjTVWtND8odVyvH9oj+7MjRgyYyppzKRA3CDT/0U3z8atUMR1QAQGG1HYzUwLZkED1nMr7NOWLDe+z2nTar9RUS9OziH75fD9x+gMM2fcHrRQmdb3JzCArpWuVFhIzrfkeCUhGCSMte2LGgHa1BlcTTF3vmxdDa5LO8P6cUuZ+a1oGqvZTNkzrB14sbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhmMFTWSMPNvAV4qG0G6UDTnQ+bf39NFlZKO7AZ4g9A=;
 b=a+x6KduSMBS5UDIvJ4swC6DGt7Fva5AXb0MROpriwxtIExaQfyhAvwpqr37Fe1Bk+xFiIPhj6zJ3DJqI8p+4jkQ/221Y8seWkdq+VvgFoXkrZzkb4Du737XfYCnkwKqaIWc/mgUFXZQv7V8TLOyVc9VTOebzM1bsdaECOyti91U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6502.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 22:07:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f24:8099:5588:8ba8%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 22:07:55 +0000
Date:   Mon, 16 Jan 2023 22:07:36 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Emilio Cobos =?UTF-8?B?w4FsdmFyZXo=?= <emilio@crisal.io>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
Message-ID: <20230116220736.6d5c8ea3.gary@garyguo.net>
In-Reply-To: <df2f6c0b-fb4c-97e5-b607-7df626ea5933@crisal.io>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
        <20221228060346.352362-4-wedsonaf@gmail.com>
        <20221231194352.55cf0a26.gary@garyguo.net>
        <CANeycqrVsbNJ+A+A26LXkBezBNUHvnZU2Q3_whexCwwG5ZcgPQ@mail.gmail.com>
        <df2f6c0b-fb4c-97e5-b607-7df626ea5933@crisal.io>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0408.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::36) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 54894cdb-9c41-4845-682e-08daf80e1e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdW1awGAdxACmC7xHzFY8GwNxBJUUWyYoiauaORGntrtzhDeGcDRz42TkIuj+/NgBYf3zK9tGGd/0cG3X2Nkha5Wg4QJchPt7w+AyCxfx43cDymKaD0Oc8Xz6d7tI8lF7F/CYefm0M5dCX4+kl8TZfhRrod/Ftu0q8BI0zAfcmMKtkWREcZ3ijEZmjzU06QOFSE1+FKDzxRMB90BKsQvRvq2opmS1PIcIDmN4sWJ1LmxZ5wum6o6+11z0uk4+PQpPtrp+8TgG3A7oC7jF2uMg3SL96bC89VRxhhL2WoRAntJg4c+T+lp54Jvh4bT37u70wMFkMmPJ52l/52akEZgmdq91hFUCwxiXisnrf3W3zIlJJixFWklUm7YFyiNTxUnDiPgS3+lGpp8w9AuK92c11ssNgALoa2Fh51n5Jztbc0DJh4c45MtwpiLTWOYlrfNZuV10djAzMK01+H1uzbx5kuEi/ADrRBfIbOZAjm3oD3Nbgzw39Ot6YSv8Ek47KghyCXy9VBoFFFX8KocjAcY+NKeImphYjXQGXYHd3HUmIUCYpPoLaccJISP7LQUrrWZfp/3FBOTYKHkBf8YYt3v5sXMe2zLkghReXeYfR+W4ceLJppnE2v+OHxqDmmTmIstxHfmJcjIGPJFK5hFaz4THyVzQZgwAoVRvUZs5EnMaAr10+xVVjMkoWBK5gMjw6n/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(39830400003)(136003)(396003)(346002)(366004)(451199015)(53546011)(66556008)(66946007)(186003)(66574015)(66476007)(41300700001)(6512007)(4326008)(8676002)(26005)(6916009)(2616005)(36756003)(86362001)(5660300002)(38100700002)(8936002)(54906003)(478600001)(6506007)(316002)(1076003)(6666004)(2906002)(6486002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpzM0Qzc2xLeEQzTTR4ME9DTmJHSU1xa3F2Wlg5TWZGWTBnYUNNdGw2aVQr?=
 =?utf-8?B?MnU5U0MzR215cFJNYUxSN0ltZlIvOUx6d25WSDQ2QzREUkkvcG52QzVia29F?=
 =?utf-8?B?UytxelAzYmdZMEtvQ3pKek1TeHpTeklwcC9uWU1aS1g5Um1SQXRJeU9BQnh3?=
 =?utf-8?B?cGx4Z1I4bXQvNUR3MGozRlhCTElNdTNVK0N6eGNxbllmRFlkU2RsSU4vd2tj?=
 =?utf-8?B?d1F4aFRzbW40bElUUkhVQmlOSHRYSFA0eVhHNy82Wk44a216MU5HUm1OdTJU?=
 =?utf-8?B?aFV0QUxSRExMazFCMHNGc1BDd2dlMjBLcjM1T2xWdzIrVmRtcFl6TE9RbFRW?=
 =?utf-8?B?YTBkdjFjcG14OExTK1VDR21FMnVvbjV1VzQ4ODJGWE5uSmFTVlBFUitWcEZG?=
 =?utf-8?B?RFFQN0IxbkdDaGthS2dGb1FVTTJVaVFsWG5tNk10VU9QVlhxOVBGdkFscEVB?=
 =?utf-8?B?U2ovdmMxZ2FVNFpjU2E5U2s2UGVIaWp5eDV0Wit3S095YzZjR3VmejQ5bU14?=
 =?utf-8?B?TXBHOWtZTVBhRitRVkJjK3VPeUEwdmRqTmlSNGxnVzBncVlUNkJ3RzFoSlcy?=
 =?utf-8?B?MEVselJsakxNb0RZSXA2bllHQUJzZXlJRUhkdm1sbU9MKzA3Q3QwNmlmaU85?=
 =?utf-8?B?d2F0QUZSaTVGdkEvaC9xeEtzNGExOEorWVNoQjFGRFdIemRKS1RQQzR0VHNJ?=
 =?utf-8?B?bnZRamNCYWFpVUU2MGdwYnBSV0EvK1lETjMyR1pUY2k0MC9tdWFIWG1zMFpP?=
 =?utf-8?B?WndUUngva2RpbHVsRitqTjd1SmFodkZCWU8rK3MzTjNRZU5ld1NiaWlkbW45?=
 =?utf-8?B?MTlrbDI5cmdSOU1TQVZIQk1lam1zamNpNHh0QlA0dGRudnZqTEpEU3VzUUtp?=
 =?utf-8?B?TDc3a2V0WkNJdHJqUXRIRTc2dE1iZlpjZUJHNnA4UldCZytreS95MG92S2RJ?=
 =?utf-8?B?Vyt6Qnh6YmZPTHlMUEdlL2F3OVN0MkxyOHNiSTFIUGxHdmd0amlOQmV3MTFF?=
 =?utf-8?B?TGNTdEYrbytZdkE3NWpLZUZqcWFxcnhOUG9MdUVod1oxeTFBVkZXYXVZMWNa?=
 =?utf-8?B?WWdwUDhQamZJdVQvcWt4a1hzLzZ1Nlltdm4zeGJTM0pqNWpaYnV4N2RZdmRk?=
 =?utf-8?B?SGRNVm9Ndko4RnhQZHhFV2FGVmNNQTY4WE5NZlNvU2xxelNValZmeG5RRTkz?=
 =?utf-8?B?NzdMaE12UWc3aDNkSWRDZnUzc3BQWW4vUjRYSWlYRFU5RXYzT2VBMTMwZGhp?=
 =?utf-8?B?N3dtZEMzVXBIa1BEQkVXdmlKZkxFK0d4OFQ2MEJxaDkzYmRiT3FaUWFJNVFm?=
 =?utf-8?B?WTNpSGQwbzA3bVlMK0ZrNGxGaHA5cjRKS2xKeEhCbGRpdGN1LyttV21PY1ZW?=
 =?utf-8?B?VzZSdU5JSm40a01SbGJuY29TTmtJSXhtd29pdzg1dml4UGVoTE9VRHRxTkdn?=
 =?utf-8?B?bXQwUmlOc3l0K3AxSFpYOEVjVEZ0V0xhRUJjL29naUsyZ3d0bFVteUY3eEtr?=
 =?utf-8?B?Z0FUcHQ3L3JHRVFIc0JFYzErZTlOYTgyQ0lhdnRUTzkxbGxZcUdsRGJwNkJC?=
 =?utf-8?B?cGw1SXJmQUlQRVJrS05GamVjLzB0aHg2SS9KWEp2bGt2Nkl5WnJ3TmlPTjZN?=
 =?utf-8?B?dUhaK1p5OXBWR3ArQ0tQNDZod0NpWW1DNWhBVlo1VEJQc2twbWpVMVNZVFRR?=
 =?utf-8?B?ajNLTEpHaXVUcWwwbGVISDRNZTBkMUhHNjN1azVGd0JMRGZxbTZyblZueUd3?=
 =?utf-8?B?YytIVGNXVnlDSTNMQXlhYnZZSkd6cmwvTVB2ZWk4aHMwd0NBb3FLNGFtQ1hx?=
 =?utf-8?B?MDlrZWZhSzhUMTUrc09MZ2tMR3k1eXE2S2RYbE9QemxmWHJUUzA2eGRGZmVm?=
 =?utf-8?B?ZTk4RFZXNTYrS1d0a2xwSE1iV3MwWVFTc0hSdlF0QW01VkpCRVNBMEYxdEdx?=
 =?utf-8?B?U2xtV05tenpFVEI3V0VVcldzMTJWRFh2RVo3YnpwMHFXY3NpSDJZL0MxMFZt?=
 =?utf-8?B?b0FQN1NGUmNtUUQ5NWsxNnluSmFrcjkyTjdadHR0MU54UkpNYU4vQzFwakY2?=
 =?utf-8?B?RVVWU2Z1bHRRTVh2Rkh4SXlYMERsUVRzSThkZmZqdDdGY3IydmQ1TWJ5TlRL?=
 =?utf-8?Q?4sgG/uZHmwrUHVAr+Jb9qRF7s?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 54894cdb-9c41-4845-682e-08daf80e1e53
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 22:07:55.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0LN7/AJYPdgFXARomqzalkEEEGXj0mU43fscTpNdSt4IzYAtuekg33gKqvjI/f4aBRhYj3O9HNuAC4+4yO+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2023 17:06:50 +0100
Emilio Cobos =C3=81lvarez <emilio@crisal.io> wrote:

> Sorry for the drive-by comment, but maybe it saves some work.
>=20
> On 1/4/23 16:29, Wedson Almeida Filho wrote:
> > On Sat, 31 Dec 2022 at 19:43, Gary Guo <gary@garyguo.net> wrote: =20
> >>
> >> On Wed, 28 Dec 2022 06:03:43 +0000
> >> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> >>> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> >>> +    inner: NonNull<ArcInner<T>>,
> >>> +    _p: PhantomData<&'a ()>,
> >>> +}
> >>> +
> >>> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> >>> +    fn clone(&self) -> Self {
> >>> +        *self
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {} =20
> >>
> >> Couldn't this just be derived `Clone` and `Copy`? =20
> >=20
> > Indeed. I'll send a v2 with this. =20
>=20
> I'm not sure this is true. Deriving will add the T: Copy and T: Clone=20
> bound, which I think is not what you want here.
>=20
> i.e., I assume you want an ArcBorrow to be Copy even if the underlying T=
=20
> is not.

Thanks for pointing out, I neglected that.

In this case:

Reviewed-by: Gary Guo <gary@garyguo.net>
