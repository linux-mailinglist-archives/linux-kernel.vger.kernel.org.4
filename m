Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1A70E144
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbjEWQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjEWQBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:01:02 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2126.outbound.protection.outlook.com [40.107.10.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B891;
        Tue, 23 May 2023 09:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dREu3HGkkSd7WoH5FlQRyReDv2zVTgB4N0pPLPDW4xZFix86hyTiFoMwb4QuqUyYLoZSRj+yEi1aTItLNttnz+qyBaP8nIV5E6dwDstwKNZQGWDaFD24MJzbXLS0fJvZzSvAAhwwXV+gVKmcX+Enb8jDBt9yacZEJ9gxG4p9VZeNvTzpZSAAsjK+3GeUNSNVpKTr2hbwrTEuh9YplEzcTwI3oj8JAch8eBs0bpDBadSgfSu3175Hk9J0KF3cxY4KTWDPA97QCQDcbcaZi2Zv6/bgbkqFXoO+6yfCZR0LBYed6dviz0+w1ASPLPlgljLa7DQgd3TrouA/89jnP5XqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLsNmBFfgnWSrFs7rn9vs8QEMGMAFowRJTJ8l43bCS4=;
 b=MHfPYqgqTkkwzNFAvTbXQk2EnAkcgAn7MRJlrgeKw/RQ2UpRTdBrA6kE7KH7UlKAwsiMiCW/3drTtvwUA7CzBdDC43HjXsVoJ4iEUOVWeEr121id4D+KjjAWBI1/3QBPewP0Dzu8GuvUiryPXQaNRXXLxsEN1jh7UE6j5TvXBTTW7FRbILHvogqyj4ZtGmvs72UT1H4aSvqSM9UChlwXWGzkHic/+TqnwXuF/xwZbQSdGEIX0UNnYBeIFUDNaOgsyOXfm7u1HYlmU0r0r+EUJ9VLufONiCI1Ztg3ac/x0bsSlerBYS1eIvEmksG4RFE5so14jpZ6sHSRMzf4ZCSI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLsNmBFfgnWSrFs7rn9vs8QEMGMAFowRJTJ8l43bCS4=;
 b=FTB/cFVHqfM+L+LGksh/9JH1TInZufCRXkilOT4dh2GzPmP+WZeGhLjfqoIuilRENpbxOcQW2wVEG0IZFcPiVMa3/wkBAgJLEmBbMXTqFyq3MLWqR1IQyZNnxMWkr67xKvBilBvxNs6hIeKjgOTvYWlUluh2/mYGNeHG0y1SQSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB7219.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:329::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 16:00:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1d51:d482:270c:7daf%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 16:00:57 +0000
Date:   Tue, 23 May 2023 17:00:55 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v1 1/2] rust: sync: add `Arc::ptr_eq`
Message-ID: <20230523170055.4e2ef9a9.gary@garyguo.net>
In-Reply-To: <20230517200814.3157916-1-aliceryhl@google.com>
References: <20230517200814.3157916-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: c55cd37d-1d35-4d59-f149-08db5ba6e52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JigKJf4505bFnB/d1EUPALtK0lhnFswxj2aatJcbul1ZdFvLK+HTov9hVK2G34AYG6DukyeKB41iUVFkXvRqIttGeLYq8wPT3om7CdTvP4QQHD+oi5aGO18QQWcgo3XfE+lCRD8aJbGlcF2AKxBiRmb7EpekYvgcqn9lxRyYfTPDs+4h7EuklOjxWHozeRO5trCABbkpCt5qJVsw0sBOc3LqXl/+Hf2yVDrfGqIJl7F1sdGhb32Hd87mR4DNtrqGBgf1B+L4PhbWvv9O2jYnhaUgvHWcTwFe1z2zlkyOpBBCRP70av6/myY8pe4AbcI/5jOIxRRBcFpypTUxhzGRmVwDMJORR/isqcMHd9ez4Jk4PLyER4qgaZXKG3aXSmSuIbstk4FHBGysC44RV3yPhFtJqbxdKlyFM5KkghviDrSeyZAVHXorXAv0HNTKOGNmML8yfso6Pxvf+auX55aR1CYcbTj/rJq/n52R42JJZvwqmAy6pIPo+lgpFJXor6ssjsnyQKAESlgkL3gDy+Nz6EezNTMRomgDd9dvzCBkA20/uGMenK6Z2YqE5ua522zSV3ZIKXXnYD0gJQjVZimd3URAJcG6vVpoXn6855a2VBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39830400003)(366004)(451199021)(1076003)(6512007)(6506007)(26005)(186003)(2616005)(36756003)(6486002)(2906002)(5660300002)(316002)(54906003)(478600001)(45080400002)(66946007)(66476007)(66556008)(86362001)(4326008)(38100700002)(6916009)(8936002)(41300700001)(8676002)(7416002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yrkG1XzBG1A536DCeLDJEjePkpd8cP+xTPABHIHnOS5udbRK35enzBzBIl7r?=
 =?us-ascii?Q?9wa+6tK878v8abh50KcagRTKdqTn9TP/CcS2iOEg99NqTaUYT/Dup8jI29U8?=
 =?us-ascii?Q?rZWTuGpiwc76Jy9cI2FUJ+rCB7L2MKfTgy0VmFGOZfhjteLX329aCh3NCfdE?=
 =?us-ascii?Q?6fgUEDGnrDCqG/V2pROEFBgVtb45iD4kw7GYX26FWNxWf3mfYc26cpoawerK?=
 =?us-ascii?Q?7qjVnPDPGr0WMPTQf51GGKTH7dPwKKXrHsbx4s7jViP/7e+oE6R2kgBCjXZ7?=
 =?us-ascii?Q?v4G9sDrJKcr86VSZqeG70LCjDWwJykYqrdjnAU8/ns30DJMWqCj/L0gXFpNz?=
 =?us-ascii?Q?PxYqoV6JC8XORmBvpFDwWBnPsVKPjLwmz8o9wsAt/Ze5MBin73vOcbPCzJuH?=
 =?us-ascii?Q?iu9HO5+G+eV5hz185ynksGvF2qW103YTxNF3wq8wR6nWgiDxqrCvfUbbtxL9?=
 =?us-ascii?Q?Hctnd8b6LqPZUpOamNecVxUXAGFCyXPm06Qny94OdFthw4qf10HHd5RJa8cH?=
 =?us-ascii?Q?2+122dAx1m7nCe3tW267S8cFugRgKSgDh25JBuYTFCde3jPh/Dv6fp9eXodz?=
 =?us-ascii?Q?pqZ1ESPESo9/yP+PgirCJaBoytirnSk8iQ2OXvuEvvCmAyP89dpXPEJ/DuVP?=
 =?us-ascii?Q?DJuUB2Y0XFmBE0EaiSzkGmuMHj8VDp5LQtSzK4w77boRYbigQnSFxF1Iqldz?=
 =?us-ascii?Q?hvtXwimgtwB3D07f+u+v/SX6AW8q7mvItbiPMsewCzLzgePaGyCxlMVvK0KH?=
 =?us-ascii?Q?XN5kuLDHezXCRuLObMswO71bjkwoEfmKQc6Hx7MEMfEDhVwtBYRdY04snEQc?=
 =?us-ascii?Q?0LGTm8hFFWvWUIh6A1T/dLREOjzKahQ6ONPgnbB/fHtYVywwvv788mESnw3J?=
 =?us-ascii?Q?Wb+HXOnfPI1gtduXW7PlvQ+QNxUZjgcGOKdc6xsxsxHVn9ntBRuA5RLnppzS?=
 =?us-ascii?Q?iTlN6cl97E7bkNUIa5ZZovsNFGy2eVyuclKVC34No9cIKg/G/2KP04nl0XnW?=
 =?us-ascii?Q?uRgQ0Cly908mFeuyTVgPlHwp2g2sN2F3KPZ1kLb3qiwW8xd2fponkhaVBRJQ?=
 =?us-ascii?Q?Svr5o8Sb1im2qY+mSMcZbPtVwysndF7uCTqdzq1mUISqCh51fB71hOZ8ADyY?=
 =?us-ascii?Q?kOL5drKeXHSZHEKHO9+mzfQwxvy8gnQHWFlAXsvMqoRyLXqpAweKH8iWbY4l?=
 =?us-ascii?Q?OwmvUXij1Sqb48D6lxp5U11fMHhpju73iZRloFQPB7zEMvVCOaWZVY7WZdms?=
 =?us-ascii?Q?ktHq8N9FD+o9MkQCH0AkfkrBz/WS1alR/9dB2ShsjfzuLFujNboPg4QFkDqo?=
 =?us-ascii?Q?rpuFrQz6Jj0YsAh1ddxP3HAp7UOhk99xLNlYa20uplb+JVvQFH2f15P8YBzS?=
 =?us-ascii?Q?fJ/C1Y3XIxQ9uqQiLx19nc7XvEedrBfHcO9K1sBMABOpC+WxF4gKa9upFkFY?=
 =?us-ascii?Q?k5GdexdH9I11M0Siqx9Nhfj5ZN0c6Puv/HjRqxdQSeV7ijpUNDAg0kUQYzXj?=
 =?us-ascii?Q?JFEKg376H+CIRpEJmf2Syv5cSifq/8Rh1ytiY/0RfsgAM9WN9ZZjLBg3mJSI?=
 =?us-ascii?Q?rXlbHWGlgi2IUlwu1+BXE33XgY+/dmLPRZxlhb4L?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c55cd37d-1d35-4d59-f149-08db5ba6e52d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:00:57.2328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElD5vN0Orx5mt3tImUgS0TVE0XOj6YhTKDNGivW/acIxvSxfuVyeY1bJOp9eWtTJapaYI8B9lVXIjmfIJMIbzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB7219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 20:08:13 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add a method for comparing whether two `Arc` pointers reference the same
> underlying object.
> 
> This comparison can already be done by getting a reference to the inner
> values and comparing whether the references have the same address.
> However, writing `Arc::ptr_eq(a, b)` is generally less error-prone than
> doing the same check on the references, since you might otherwise
> accidentally compare the two `&Arc<T>` references instead, which wont
> work because those are pointers to pointers to the inner value, when you
> just want to compare the pointers to the inner value.
> 
> Also, this method might optimize better because getting a reference to
> the inner value involves offsetting the pointer, which this method does
> not need to do.
> 
> Co-developed-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index e6d206242465..274febe3bb06 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -221,6 +221,11 @@ impl<T: ?Sized> Arc<T> {
>          // reference can be created.
>          unsafe { ArcBorrow::new(self.ptr) }
>      }
> +
> +    /// Compare whether two [`Arc`] pointers reference the same underlying object.
> +    pub fn ptr_eq(this: &Self, other: &Self) -> bool {
> +        core::ptr::eq(this.ptr.as_ptr(), other.ptr.as_ptr())
> +    }
>  }
>  
>  impl<T: 'static> ForeignOwnable for Arc<T> {
> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b

