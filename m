Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1287D628303
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiKNOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiKNOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:42:19 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2112.outbound.protection.outlook.com [40.107.10.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC928E3A;
        Mon, 14 Nov 2022 06:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jum7Pj5J37FZnkcJ2e33LwPN98UX+53IdeDNiqCWKr/mf5+z3ubwQSLlQxd2OhxQ07eZKYqaQLklkvFl4W6DYx1N4t6J5iYivnGZbDRuF5/Wq7lYh7MajHkgeZ5iU4drxh2jYZLNCIFQSAWPVXO0ilxA/rwfl1G7M+gMZXr5fO8S3p1Svyw0k5fweb7GApf29vhtv2LTUJdvzqRZPdVLrIpUXVx6gTBLU/c5HacbHldCD1sQmI1F+prYWiiB4y65opT/P0T1W5mLD6ICjlW84GIIIZsbfdvSLkQOAsolwjaXGSn2r1NFF3Yo+5jIke3UVplHIA1HXk60d5Y8TNCO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmjSK5pda+flr0bcwysw75kAtEOpu7Gxt/UHCSSQqWc=;
 b=HBsjF18ZkhmHWJ7r6ThTrXZ0gQ+rity8K00zdFU1Tc/m/k/4DoKW5urIPjJuQ8vHxjQDAWCfDkYG9mFDNAWj4tL4hlVapIgIIYNbUQHUIrgk23UCVkKzMeHFdiP21tp/FDs4nMoX2V8xcJ6AcVe/VdkZE/WBYeiWaZyUsp+AJGkmVQt7qgR6vEAiOtrGTsKPNZWfAykjBoduxMQt+DLkMuW6CegJ1DZQvAi9wWsMGc0bBoh8Uzft33cM+34qe2Z9j0pnLlhZ5iNBBqmqXl6r9CrrV3ARZI3+dS2H8lIgJ/IzyWwiSkDolfsdCPEuoptUqCbgk6oF6tzFVZIEDFYX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmjSK5pda+flr0bcwysw75kAtEOpu7Gxt/UHCSSQqWc=;
 b=Xf+0F2ERc8mmaWaGVX5v9HHe6lyxfqGQ2CWRYz2RUczKg09hMPpslDWV1HGDn2/7Fu+xwwWNtv0c5LlfZdCdd4avTWQV/v76zL+G8H9OHBmbcTuuXF68iOrmAZINQkPMsQHJQbcLFmeSZ6ZVAySBynV1iSJ976Ez/cZmN3e8ajk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5541.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:42:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:42:14 +0000
Date:   Mon, 14 Nov 2022 14:42:13 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH v1 20/28] rust: str: add `Formatter` type
Message-ID: <20221114144213.26be09d1@GaryWorkstation>
In-Reply-To: <20221110164152.26136-21-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-21-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0386.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: e1660e10-9e73-4ca0-de7c-08dac64e6bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBCvCEKOE2u5z3mhZqkhG+5Rm7F88VOnGzPPTbkjN4w4M9sJO3UV139dqhjU6of3jqD8DBxOOibTeYbS+Mumq0zeTplixwooS75BQtarVmXi5LLHu7TCff6uUoODLFpO/iwRoltYcoum++65BjyfbuhxKG1s5XlJdOFgoJLn0JHl2PUoeKpzL0vSadb7uVyl4ZsMTrchlUv67mz6WwVNyTUFw8awSBio9utP60FAtxVzh9YCXMuAocn3d6sZPskzL+3d0F4oqAqKOHYCgpvZXmuU6ahS/LC8Q6t6xlpGzEw/kX5EdD5VuOruf46l8/SmMaZZzmZ6ZHWobPAyUCftawmw7J1smGxZbKLFCj/E7OXTHNIDMAriDdjKBbaa2O/WgBSsy5SEMNnA6Gi7pTvf0XMJP6S1gxYAHHuosbV7L/OM6CUk64gyQC0XswyGXFUfIZrP+4KNRzb425DL1gAQHqVxty5FhKZBifR6txhqZgTCfqAEd26uE6uBOVHwyPNQscpavk33Sgz0RWsow+VJajaZceQKVOkVCAqm9Ifr08jZRXlFJeaGmaQRL4J5ZyQaUulzZoR+jzlzeLn/PhBBdX54tHdyCMyOlDD9uIsQAXl5JaZJO+Tl1p646hNBzSU0nRMH0N8393V2L0fg2zELIQ3xWtl4e3IxMWXnaBO1CsaPBPk4wj5oH9Ehyk9bq1M76Kr8Ocg0eXFpoytT0Cq0XhL549EbH/yZlMd2x90z11ETmOKSJlp0lpF/Yn12AzSD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39830400003)(376002)(396003)(346002)(366004)(451199015)(8936002)(1076003)(186003)(5660300002)(41300700001)(33716001)(6512007)(9686003)(4326008)(478600001)(6486002)(83380400001)(38100700002)(8676002)(6506007)(6916009)(54906003)(86362001)(316002)(2906002)(66946007)(66556008)(66476007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sEaFKAX6BQB2uUH1UzK5T0JBfYMzh29OFU80ePZhqDUqo2IAK9+DIhcDcNhv?=
 =?us-ascii?Q?Qyfxde2EbOw0quZ3h4Df/7nqb4B2D2EQ0NHKjdQ61U7IIuLzNaMNxxsgclRY?=
 =?us-ascii?Q?EH/IQQqjGG80hu8PD8NdMjlgS6uapHPe5q5rU0pEtHhXTftpex9+vfPekvNU?=
 =?us-ascii?Q?O+qN8iAz6qWF1X4hBp/H97bJK4LdKV1ffe2MOPDg00CPv97mHQ9I0O3hfTlx?=
 =?us-ascii?Q?99d7ZzHHSQZGRdya1Pf0lQpRzWr7/lfUp70LTWDXSTwYp/HsPb7ycjTjgq+y?=
 =?us-ascii?Q?5J7bRLahzyHmlQgNaFQEXhOMRq4fHkG6YzacxJvPDd0kyUOjHcyixOB5MmZy?=
 =?us-ascii?Q?lcIYjL7Va0d18VO93/m42wx3Pziz3O9Q/m40GcDFt5tYpKRZqNnovdZ0BEQW?=
 =?us-ascii?Q?r3i2luRDSyGzzifVxyk9FjyZtBm7WZ7jid8tb+xtq4jOYaohhnye6fTCcQ/v?=
 =?us-ascii?Q?x0Q2d4oWDLMQgQFrqkb47ZmxKbnFrJfHpRroDxsupFB++T5FYXvU7dCRn1ZT?=
 =?us-ascii?Q?tjOzowxypgm/Yk1uLSz0+/cqg2iJFkrDY1tHY3CewckuXm2uvdZvcdm9K/p1?=
 =?us-ascii?Q?jUMU1ZjdQOOpv2VGbRvcD05k3Iz9STTNpaiEaqic06b00RH2Ffovy7cx+vae?=
 =?us-ascii?Q?CWFBb62rHHPHjzqvTk5SZOgExkaIM9Leq9l01jU/JjKNFm6m/caiKap3esO0?=
 =?us-ascii?Q?Z3lOcriK0li3tegRZudJCWjKIplx25fKLqa98RLoFE+j8+LcCJaztowRId03?=
 =?us-ascii?Q?Cp/EeEZAeTbuVZFaY3bJugftf1wN6gpJ5jfcJV7CqdBCF+31sjbwACTbwIDY?=
 =?us-ascii?Q?5oMxJbq/NXqghOsfhppRdYkgWQamR0U5Cda4BynfD3nOsykm8lk5+07h+GDS?=
 =?us-ascii?Q?rfb6jdojadZailDQ3y5KMtwRrSzC4ThgaB1BaYO5yhBTAr3FDg79NWzpDCyI?=
 =?us-ascii?Q?uAdXCtCvU61DOm8qjdTOzFLIaES4p7clYB6qA50bWb2TXNc6Cw+GDLtBvkU8?=
 =?us-ascii?Q?bEmVf3lW/RdTm6/OQR+wbvOE0kF2ys0ZYizFHyAHCGwp8BtTBjQ+fjuFvdQc?=
 =?us-ascii?Q?oC2AtzRSjMjKFokYrfzuryk/NElonlyHa5C/5WuwonYAWYpv/Ve1YJTpcrSS?=
 =?us-ascii?Q?IjB9c7357C5KsatP2k70SYdiIm5c8ZgZ+lJ5V5uRfQm5mR+ZGxHluIyNNyGB?=
 =?us-ascii?Q?rYQ7p+DgykFJtG4o2pBsiWLZrZ586pCaH7npRqJOUTiiNzAiuglTzElZ4+vd?=
 =?us-ascii?Q?rpS9JxA2Kfj377f4yuc1YVkG/0FhWzjrooV//C+JVu3o0birWUGI048jWyVd?=
 =?us-ascii?Q?GqJI/n8KOmCaBK186Pg8Bev5Nkoy6n2mVD1ZMvK95Qj75soJXVf4M022YfdE?=
 =?us-ascii?Q?sqkZtCuJiHDUYUmg4sayuDGf+xepytIS7v9QM7+3+RvbIhUWUssj+U4O1dt/?=
 =?us-ascii?Q?dbLktMPXeuV7H2MNLOe9D10ZdM8ZtBypMZN19je1eD9fELF8ryMwJdebSUlG?=
 =?us-ascii?Q?xSn42l6xD1+K5YKM0zoL4ZecwFKNI1ID+ZcpinNmQdbhYs9JQi/R7SZqNI9z?=
 =?us-ascii?Q?ZMqE94pHVFhULFGg7uY85TL1dU/qa/J8YDCcHM3GroRooDeht8iRO9zpcH02?=
 =?us-ascii?Q?bBEx1CBKH5gS4BQP7V8RT0Jb4yj53zyWJafhKH+6oQR+?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e1660e10-9e73-4ca0-de7c-08dac64e6bfa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:42:14.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDauzU1aMiUmxEb3WQ9/dQ9sNN78WcAy/Wx+ShD6rZnJNka0W4utCPup4bbU+4R8q1pJ2zvloIZCt76JxI7txQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:32 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add the `Formatter` type, which leverages `RawFormatter`,
> but fails if callers attempt to write more than will fit
> in the buffer.
> 
> In order to so, implement the `RawFormatter::from_buffer()`
> constructor as well.
> 
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/str.rs | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 3fb73b888dce..db6473db31c6 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -415,6 +415,23 @@ impl RawFormatter {
>          }
>      }
>  
> +    /// Creates a new instance of [`RawFormatter`] with the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> +    /// for the lifetime of the returned [`RawFormatter`].
> +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> +        let pos = buf as usize;
> +        // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
> +        // guarantees that the memory region is valid for writes.
> +        Self {
> +            pos,
> +            beg: pos,
> +            end: pos.saturating_add(len),
> +        }
> +    }
> +
>      /// Returns the current insert position.
>      ///
>      /// N.B. It may point to invalid memory.
> @@ -448,3 +465,43 @@ impl fmt::Write for RawFormatter {
>          Ok(())
>      }
>  }
> +
> +/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
> +///
> +/// Fails if callers attempt to write more than will fit in the buffer.
> +pub(crate) struct Formatter(RawFormatter);
> +
> +impl Formatter {
> +    /// Creates a new instance of [`Formatter`] with the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> +    /// for the lifetime of the returned [`Formatter`].
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> +        // SAFETY: The safety requirements of this function satisfy those of the callee.
> +        Self(unsafe { RawFormatter::from_buffer(buf, len) })
> +    }
> +}
> +
> +impl Deref for Formatter {
> +    type Target = RawFormatter;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0
> +    }
> +}
> +
> +impl fmt::Write for Formatter {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        self.0.write_str(s)?;
> +
> +        // Fail the request if we go past the end of the buffer.
> +        if self.0.pos > self.0.end {
> +            Err(fmt::Error)
> +        } else {
> +            Ok(())
> +        }
> +    }
> +}

