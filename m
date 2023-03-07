Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824026AE6B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCGQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCGQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:12 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2110.outbound.protection.outlook.com [40.107.10.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87439227B;
        Tue,  7 Mar 2023 08:33:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G798BCxKLhQX6KDAvas+3xNBJ/nu2TQqsO7JpXZwtTWgNMTEiIh0k5tDiiuEHtN4I7MCT+f4lwrbqzdku+i5vJc9+xXY5vr5ndf42SmmI+AOtmxXW1wIaip0WWF2WagXjAc/xrKB4YkBs2yEc45cKmBfxibFBvXAkON2PXboOZmEKvUt4LxdvYEI6nQTJn447SvoEShI8K1woMA16GyxXUPOHhxi6eLhUt1IOT/VP7RChqH0dTZdOVivkS6lYw7whIRt7J8STdt+PbewTQ7x3rYjg6iJ7NvR0LCaWtyoey102DtZ/Y3xQnkh03WmrVb50bXJAMu+EYKU6k1+RgulXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPDcPVrL8+kJydvKJvWRNpaL7HTX0t8Q+2z5YL4jb/0=;
 b=Z6FIw5EAVqypv+MRo+EucrSyVeDrOGcMtusHnm4oflsSUG7cG3TDRdmffikoy6TbiUwh0xfHDPjTG9CeSNtXE7CpoI9FSCl3DhsAFYZ3d/sF9XBVBmRLcjUDRMKvYR8u8fYZkwQJTTBr2j+z6vXLY3a+RtmfBrZ21IFvDCgTkZhFq6MrDSYs1AgiLkXQBN9FGdZQWID+SBAsv4w8XiNNFNsYtL2I4tnEr5SCVw3noo3pOj8kVH3vmdgj+X3tmLA5ulrAHzWqgLj2Yk25xxalRhHTq2Ho/FM+S/NSMRNwsPAgXVyt/jexEAp8/sYRt3pCoUWbTzl58FrinB6HN4rHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPDcPVrL8+kJydvKJvWRNpaL7HTX0t8Q+2z5YL4jb/0=;
 b=IQXAT2aIt3e1870gFe482e4YF3QImiiCkb8SV5uq4qfTWT0W2Q1vRtQAcvNmKNM1Bwj5KyP6GbR2fFAdrbRFlSP0V+g5bZFEPaYWizFW8Yw5BTVVoxYKIiCH2KHF0p343m0/Xlt67ajwA6SZh7/A0D/dj3wncCJNrned3XRCEjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2021.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 16:32:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 16:32:08 +0000
Date:   Tue, 7 Mar 2023 16:32:04 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: rust-analyzer: Skip crate module directories
Message-ID: <20230307163204.44278987.gary@garyguo.net>
In-Reply-To: <CANiq72mvL3f-MZiZiZp-uZDQGCnYJ9yFh_QTWrTMUkUdiXdm=Q@mail.gmail.com>
References: <20230307120736.75492-1-nmi@metaspace.dk>
        <CANiq72mvL3f-MZiZiZp-uZDQGCnYJ9yFh_QTWrTMUkUdiXdm=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2021:EE_
X-MS-Office365-Filtering-Correlation-Id: 473b6a52-d60d-44a1-420a-08db1f297eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yDZ88FCp9raGKOTwmZpJwlFucXVLirAWWsl8USGVtSlQOGKvQAzNIhAM2cTfKL+/EzyfKhgiHjn5W6q70d6t8v+HewqStXR3Lki6RPPIJnubMsJ6JPXGka2v8qcUN01cAqEA+/M5Xz61JcIfNczAUgnqnfPM2bVMO8TYmFU/0kNdBpfTEKzymtmxclM3oPNeZxSw0f70a0AXLDK285j+ecG/IQA9Y48r6mqwUsM4IH+zm+VBPa+k0v/UgAE0F9B5acZpr7QYW2H8IUluaswOaYToxcEOAmGMyqWMh3dsxGjs1XYHhhfdKiU/e4zBwuI+tvFyTn/HACPtlwqeKbs5oaFxe/G6WkLgs41odvd3jN9jV3u/sDt4aCKE0KWwWUS4ZRR69gcbFToBKxZW/C7WjT8l56OwwMvBVB1LpdXUiB0epjoUqnhxVazNh8t7gaRlfkf6L4iAquXKQilq/0e1P80DmbulXH2X1AGYi+ZeQRAcar/m1zRFoAZwPYXNstUHKG+OswQXOQOWIAiB9PXQH6E1Xkzsg/KsU4liACjkdasKyvf8/cdy6is0a8py6Gv3RgLkjaUdL6Pgno1Abi0HvjlGnBQhtV9X8nGeU7TsfeGIMPyEfxzeQIUbfqQ+iMe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39830400003)(346002)(396003)(136003)(451199018)(2906002)(5660300002)(7416002)(8936002)(41300700001)(4326008)(66946007)(6916009)(66556008)(83380400001)(66476007)(8676002)(316002)(54906003)(53546011)(6666004)(478600001)(6486002)(966005)(6512007)(1076003)(6506007)(2616005)(86362001)(186003)(38100700002)(26005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5JMk54Wnd6cFo0M1h1dHNpc3c4VjZkS01TV1BJYW03ejl5Ykd6d3BJZUd2?=
 =?utf-8?B?KzRESERHN0VDUTVIdTBhbUJSVGJxaG9TTDNFT2hPOGdRZjFkWmdrQ0VsTlcv?=
 =?utf-8?B?WG1ybXBSOVA1WDV1RlNmMmFtb3hkUmFnais1SHhwNWNzM3pUNytzWmpESitl?=
 =?utf-8?B?SzI1a05zakZkQmVhVG52bWpjZzhGRWQ0Ny8reU9SWTQrNnhSTGdDdWR5c0R2?=
 =?utf-8?B?ZmF3YjA4QnZNYnBaeXVhWVcrUXpxTkJIQjdvWktWR1A0NWJldG1zTE1PUDVK?=
 =?utf-8?B?RmlMcUNrSnIrdnFmOVJVQ1lidVU2RGhDbUlRNk5jMjJvb25CSFBudTVsOGNL?=
 =?utf-8?B?d0xjY2lVdGpNTnNPVW14a0NxbElkbFlvcFREd2Z5blJUYVQrYkRVeXFMQkRh?=
 =?utf-8?B?QzJjT2xvRDZoeloxWFdITm9NcElXN1R0UFk1c21kSHpjTkZDQVhObEE1aFF2?=
 =?utf-8?B?YW40SHBzRm85RFBzV1BSQ3krRXdlMjZPbks3ZFcxS3ZTajBzNWFzVjdMTS9I?=
 =?utf-8?B?MlVyVUFHc3lVR2RiMzZvSlU0VTZybEdMWlNXYlZYK2RBRFRVOER2eCtWZHBF?=
 =?utf-8?B?VmNKYzBIeXQ1NG9LTDF5b2ZCWnN5YTJWdjhFMlJnblFYODVGOHBoWnZ6eWpT?=
 =?utf-8?B?dFYxbmQ2bW9wa2V0OUFEazQ1WC9zSjZwdUNzMzJ0Nm9ObVFUYnNZRG01UTVq?=
 =?utf-8?B?ZFR2eGJUdVY2eFI1cG1CZnlDOE56V1p1TlVtRDd3K1lESWlhalJhVFY4WGFL?=
 =?utf-8?B?Y1hRYzUzTlZ2NFA0ZVNKSUJ0Uk9ac0YxWEpjTm5DK3FmQ1Z4YzNQK2ptNk4x?=
 =?utf-8?B?cGR2cGZUYUNEUVNxcDIrUFRaL2NLSTluZkJsVnZjWmxtb3JzM0RuTU5zbHZp?=
 =?utf-8?B?Uk5YRlRaZWVMSTBLNnY1MkFLYU9MS3Q0N2YycVRVNGJyRmVwOG5wbXBIOWlp?=
 =?utf-8?B?UFNGbzBJL0RMSTlkSDJUOUlmYzNsS3I2VkMzdmF0SndmMkNVSytzTnhZdU5L?=
 =?utf-8?B?ZnFya3RFWmQzQi9UZnN3d1puTVozSC9RcEZteG1IZi9uVUNpOTBSbm5ZSWx4?=
 =?utf-8?B?dmx1WHhpTEE4Z1hLMEx1VTV4YlN2ckI5T1dCNDllTWp6ODNaNkczVTJka0F6?=
 =?utf-8?B?dC9zUWE2THhTaFl5bDkrV1BXTjNIbHRoUGZlV1Z1TkR0TmdqNUFtUUZBSXhl?=
 =?utf-8?B?M1EraTVXRDJGNDhxRHFJRHZ0c3hQRjkyOVBocnR0Q3pmSjN0N0ppT0pSMlRz?=
 =?utf-8?B?ZS9Ea3pYVm9mU0d4bnBUa3RycFREMGRML1lTYVhxTHlXbFJmZW43a2VZTlBm?=
 =?utf-8?B?Mk5FcGM5b251SnVibEk4eUFEamdDbXEwcGRuU0pKSjF0ZC9uRHdtNVc3MWht?=
 =?utf-8?B?RzhPcTV6UkZyTFNlT2RTU1BsU3FkQyt3eTB6cVlrSXljOFY4dlZ1SU1wVU94?=
 =?utf-8?B?ZjlJTldYajBGYVRRVW14V2ZsQ3lWamdOdG10OThOOWdRZjJPc0JlODd0WVRx?=
 =?utf-8?B?WnhZUFNHTjhFNTVNUlhwYkMvcTJOczB4dzY2bnZ2TkJ5WStXa0ZIODk5UDht?=
 =?utf-8?B?dTVyU2ZxeEk3aVhQbGRyRnUrVDdFN0RKUGdsc1pxMnNKOWNaVTV6R2NvL3Rs?=
 =?utf-8?B?bkJXMmR2cG5YMWZwajRMSWs4YytITm5JSzVLWVJtRm45VlIxclRpemNMNlQw?=
 =?utf-8?B?Y3RRL3A5ekNmR1pxemQrbHd5ZW1pRjJQai8vTGNKNUxYWTF1ZjE2MFhUSXFH?=
 =?utf-8?B?TkRHV0daN2dxK0dKTEZhTDQ4NEdqbEdjVHNSaVlRdUdDdFFjUUNQL09oeEVt?=
 =?utf-8?B?M3V1M015Z3R0YjlzNFgxVlFQblpHZWRxSGxQa2t5b3FjeVliWk1TcVhyZ2hB?=
 =?utf-8?B?VnJRZmo2WldPRVd4RytlTG8walZQZ09HeTdpdU5CY1hPMmlkTTJjY1owTzMw?=
 =?utf-8?B?bGFuUi90ZnJPUFhubkUvbU5Vd011ZFpmM25BUHJKUmRWM1k5Q1lTSWlIZmJ4?=
 =?utf-8?B?a01Xdmk4T1Y3Y0p0b0E0SkVjU3BpMXdWTWJzcXYzQUFEMkJ4R3B6SmZuS0tR?=
 =?utf-8?B?Z0tJOXloRzJqeldzN3czaHo1V2w4cEJsejFvTjRpRUkyWlhNOENNT0JzSlBD?=
 =?utf-8?Q?d+VqtSMEXEkcaSTZAvz/z5I4J?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 473b6a52-d60d-44a1-420a-08db1f297eef
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 16:32:08.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aUvTIGq8gDPM6uOrpexM86W0Gx+ws1gphczq6/j4p0l3rnHsqNtM8cLhL4fyqqwXkTi9pK80krOstImDRxNzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 13:38:10 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Tue, Mar 7, 2023 at 1:08=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk=
> wrote:
> >
> > When generating rust-analyzer configuration, skip module directories. =
=20
>=20
> This is https://github.com/Rust-for-Linux/linux/pull/883, also handled
> by Vinay's patch
> https://lore.kernel.org/rust-for-linux/20230118160220.776302-1-varmavinay=
m@gmail.com/.
>=20
> Lina's approach is arguably a bit more idiomatic in Python in that it
> is usually encouraged to follow the "Easier to ask for forgiveness
> than permission" approach.
>=20
> Lina, would you like to submit yours? Or do you prefer a `Link: ` /
> `Reported-by: ` / `Co-developed-by: ` here?
>=20
> > If `driver_mod` is a module of the crate `driver`, the directory `drive=
r_mod`
> > may not contain `Makefile`, and `generate_rust_analyzer.py` will fail. =
=20
>=20
> By the way, note that in the kernel crate we are avoiding `mod.rs`
> files, instead using `name.rs` in the parent folder, in other to make
> it easier to find the files. I will add a note about it in the docs.

I personally think mod.rs makes it easier for me to find files because
all related stuff are contained inside a single directory, especially
the parent modules and submodules are closed related.

That's just personal opinion though.

Best,
Gary
