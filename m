Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9871F0B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjFAR1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFAR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:27:00 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2100.outbound.protection.outlook.com [40.107.11.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D5E4;
        Thu,  1 Jun 2023 10:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swca3zwnUc30fiJOnqN6e8tWneCOVkYS1wrNIB1gSpjhbk9vF5jLkHFG6abqByUTiCMr2k12tN1eo/zBZ2AqntCMRgkxXLZvmvAcqMmqI0MX844efy0RDyGk8Qr6Nk8V/B4W5mR7zoBh7NTxg5lyoa4bfusS1JvoF5Pww88lqV5nmVgdX4/TuydnennV7+Dv+PpmnNjQN6y/O0wNgOhlcuvOu74L7xr5fO8CqRxFbyiPiVucBQPuICXoYbSuDuPcI4gwArfGOo/xdeDR+HS6UGKP0V4Xnw9U99gpdH+cX2C7AIHPd5cp0eEMkH+0x7mbq2DTeDsm6FIo48+O18+O3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XsoiyrIBHulGroG+YyhiG1f7xYLiy1e9Msg7SOOL/k=;
 b=Tc7ibneS2PTORtTEftLroqwK5ptXXrAkBSeldgQloNvBE0QVhfJIuNbUNjd/V1BEktmVnUWvFLnIIDcd/HKjOB2iHZ+PveUr0HmL7sFBTO7MKGf/iBQDgK3j0G7D/fp0YtmNnpcV7NoeGAS0F8yGwSlQQXBdP/8T8p+ZsgKnm769v6ndU+k2q//+8Xcm8AkpFfO2eV0Kge9r7A58GUJVfOA0B+nPpcytThmCfl72xUM9wIsaohJpC5Osows9QM1fqJ6qX6n79ywIrtD0RPB//WXDh74t8BJFuz843ooGmE3aUU7DRASFj3lM5KtSitXC3gMfJk9bW6NiVaHVwrxKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XsoiyrIBHulGroG+YyhiG1f7xYLiy1e9Msg7SOOL/k=;
 b=zu2eE6jDQeYCFhU7SbEEMz/YbA4+Vujtz0BMTa57/svKxSEIQ57tN1f6y90ZH9tZw1EBe6Qd8cfHiWWctX1+jGqigdejnqO+GOXn8DOdSB/K6i0U2G4u2JeOgru2Tx7FBzC8e8CEjnFHJSDUWO7SGMt85TbFbzEaG3LDt2Ueq3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6725.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9; Thu, 1 Jun
 2023 17:26:56 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013%5]) with mapi id 15.20.6477.008; Thu, 1 Jun 2023
 17:26:56 +0000
Date:   Thu, 1 Jun 2023 18:26:28 +0100
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
Subject: Re: [PATCH v2 3/8] rust: sync: add `Arc::{from_raw, into_raw}`
Message-ID: <20230601182628.13765998.gary@garyguo.net>
In-Reply-To: <20230601134946.3887870-4-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-4-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ef05ff-785d-4dcd-cbdc-08db62c565fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMcfgNFbVGGB3O5J2u5RHydS907trUq1yKqE06OZJrebEuqGhD5TmRmNQp8rhSQJCnOvBrxEvr17ZIck1Xhwv7qKmKl9aefE/s0dKTYTCU7MOCZ70YsxoKqLKqxxJrgA8YOwCqfeoKjAtbraO1yvY2dYtNwhxkTeNZZQCUTfLdEJVHfMsr6C4VlRWIuF02864NOWkHavjmMJ+die8u/sqsloGoBoJMAf7Gpa9DcHd4vyVIt4BNcfyp8L+LD9ugCgcTR/oZQx6A3UP+4x4SCSUBvOa8H80VVIp/k4itsN+qAOPYx85lPUqEaIoF4OY6fWSokOs1/EuCMo6EVIdc2fDVwTwTnZbP4fWrrq4X42qO02/N8Rm3X3HgyY2gu+CjeO3v7/i/ed3taf+KrVHNQ+GG5q61Ut+jRmrb2QH/Wnx1WF01FQgvGBztxQIq7SSvRhZbh112GIfQ1/NfvAnAFrwWosorvOc77lrzgG2Yhy7SAK9XH664hdxxxA3oaJ9DM5eV501knIdBlvrYVchnIjRqrU2xPBKhfXdCU3eAj+IWpjjR8W4ZdBqBJn6TjZnJaBvAm2Vv3y4qBYbW/MxRaMFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(366004)(396003)(376002)(346002)(451199021)(36756003)(38100700002)(86362001)(8676002)(41300700001)(5660300002)(966005)(7416002)(45080400002)(1076003)(6506007)(6512007)(26005)(66556008)(2906002)(186003)(2616005)(83380400001)(6666004)(316002)(66946007)(6486002)(478600001)(66476007)(8936002)(54906003)(6916009)(4326008)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QIGrAkE7e6yQlGGLCwLgXS+rkf8xxCh4zhGrSoeNZp+T7SPgmeEKrMarfSbi?=
 =?us-ascii?Q?x5Hi6hX3ll9/sjtQfK0UYX4pRWKPkMjf9/0Y6unr0G+vp89yUZFkVsCe79Zj?=
 =?us-ascii?Q?VbrI+vUHn0wc6taUW4UYJxrJ1D06bsyR6DzdfP8/vejOSPqAhK+Koxg0LDk1?=
 =?us-ascii?Q?0mzVeR0RPO1dmwtpq0+ec9M0tpCeQSkOEYKd5cnSfYA9+DArRzPB1uWz26OV?=
 =?us-ascii?Q?GBbe/v6aAIRuAdgBc/gZFxkkMCz36dL3q1fmCW2YnC4JUxf9HQj3votRwr40?=
 =?us-ascii?Q?SDOIGmKxXXsVlgsAtJQcv0XRpOx2Hohz3xSOKjGINH4z2imJlNAHaWJ2Pf6m?=
 =?us-ascii?Q?dhmdXo+jmVFrFle/8Fsx51YPpc8oAcipDXk/Z5Vg8sDivZCnNASuF9esTG3s?=
 =?us-ascii?Q?owOZhZ6N1rBMdfxX9MnMuJ0UxTU9nP809RXjpR/rs/vxkzKPxrVk9As2UDAo?=
 =?us-ascii?Q?/3QNxXMJtYYW9YQmZDtJycexNORG4Wy66T/gHyxLkOkOyXY6Onl7EH/8Vma4?=
 =?us-ascii?Q?Xhp66qw03R3Ig7td1GjSRBRM2rmijFdtAOZQHtL4aJMGQQ7KQfvZa8zN5aM3?=
 =?us-ascii?Q?1RVLq4kwBRtn1vwqFvA8Rac8MUBD2aoRFulZLhoB4QpYrnS4XKexbychBmKC?=
 =?us-ascii?Q?J39mNDJytp60Yu7/RHn7xpp3fLVe/4mdRQ6VDz7IMVeV4qrN25FgFnY8LI1A?=
 =?us-ascii?Q?5HpOfWpO5Addv7b9cKX1zxPY6acb/A8Ykq6s1DrIsDJyVojmuHN/XnCef2sF?=
 =?us-ascii?Q?xLq6kj7COka2LetxbIVTlio3qTlY1+t6tihmCayPTNZ75ixuRfn/bE2Hb16h?=
 =?us-ascii?Q?O/qoqbBT9kTVWUU0AsAEbvvvG+QR/Qzt6PPlJ24ag3eyxpTjmyfa3VluO642?=
 =?us-ascii?Q?6n/GH9qK7HIdvaLTJMP7rx8mqCVUYiNdtxo+nWmXYIfZf+M1yJ4OwY56Nr4u?=
 =?us-ascii?Q?qOmVHI5zbUrtlwSJgopRU13ext2t2Ey5w7pr1BqGr43vtr18yAszJzAv7NVX?=
 =?us-ascii?Q?VZW6IuHrAn5qoKjZu8D2T98cFk5wMN2MR6dOMOdLV5ERi4qSBKlSV2ujZGIZ?=
 =?us-ascii?Q?M5Yap2rZpGCxhtq0+KdNUSl7g7Oa3i2SahnGm8H96eKyLqkmQYrLgDAGcOPL?=
 =?us-ascii?Q?7iNkzqJZNCB7k9a66wcXAdt3DynMBYcZqOzku6EkG4rEUwPrzXWvljkLFRjk?=
 =?us-ascii?Q?eVtPLIAzAspq5Oi9BCuVWdEkU5cO0oKE56gIP7I5qb+lh+yhyB0v/kGigAK+?=
 =?us-ascii?Q?NCvNRbuq+pobClks06lpzfmRfF1v6wDD4WL2U4ogMb0B11zb18bAyK0zMYTc?=
 =?us-ascii?Q?DFbj+xlkDMG4MmVRCd3C1YdGk0bbKfmBft0M1zEteMrqsqU+5Gey++ZPBVCk?=
 =?us-ascii?Q?ixIfhxrUKmmsydh5Cd42tQHCPhCwmTQ9E8CyteRk9aXgu3SGtm1S7NgAJmnT?=
 =?us-ascii?Q?Ged6CyLwkW0vg8jEoE+liprDz2akldmTCIm8corQ8dZrvsiBWUO4ukmCIfl4?=
 =?us-ascii?Q?vpfa7YkMt0ICrKMFZG6NlC2/2HEBLlaGVbmLvDGgFB8EXztRvHRrV6niqeDT?=
 =?us-ascii?Q?sAk0idqeyiNYLFGdxkTFKwkGlULg69bFHb7rJEww?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ef05ff-785d-4dcd-cbdc-08db62c565fb
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:26:56.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqa3WASdaH5qcg8Eq11mkAt7NbEdRHEuHSp+PCgaKjdTP8/xvAg0ZQDXXv45gxoy+uh6iBajDC1m8MzsO40W5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 13:49:41 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> These methods can be used to turn an `Arc` into a raw pointer and back,
> in a way that preserves the metadata for fat pointers.
> 
> This is done using the unstable ptr_metadata feature [1]. However, it
> could also be done using the unstable pointer_byte_offsets feature [2],
> which is likely to have a shorter path to stabilization than
> ptr_metadata.
> 
> Link: https://github.com/rust-lang/rust/issues/81513 [1]
> Link: https://github.com/rust-lang/rust/issues/96283 [2]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/sync/arc.rs | 42 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
