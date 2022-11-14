Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE1628342
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiKNOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiKNOxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:53:34 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2135.outbound.protection.outlook.com [40.107.10.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA9C741;
        Mon, 14 Nov 2022 06:53:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOm1Rv2puy8vgcPIRZYGjH0CJaNIjQLbktQn/0tKRK1vH4igmmNczaryxagsTUhTOeo5TT6knxSjMkU4B0mRHSMdsTKGxW3vhRlgw7tIcD5c5TxPHzeK1Um3fEm7kejByC9lUPLZKVF35RYzTFOenNwCjP3p7anXe5QEaMIG5RWBaoVkX+SeLGwVpbOFMCtrdsLaE6p6VYeJQLnBDN3LoSSZo+Oe0edA7joQFQLqkfHrJbSQQ7d+Dl75Lo/tasGzUi1RjVO2x/7vn45MFWY9L5yjrbKvbxkZCegpffpkmrjMF54cukl3s7lsaIZOljQ7+5rBpzxWbX6TeHQA1MJSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5otCPvOkxje5o6EUr4kp2rUYcO+9Pt4/ZBeNXx7DZ0=;
 b=Gn9vX+kKFptqgJlDT4GHP+/u/75M+Jtvx7InqourW52qiYYR7QJ0DwX4z1xH30ZAxYWG9LU2flk59GgaoeCNQh3uWswGwaKOwiDF0/ZxxrJ6qDrzi5wKGmJw43VniJfMItLUaMmU/AwFqNkaRKTBIR30guZuwquwzcDL+sgZ5TnSTqsq56zttOc95fslOV6wnmfasnPmcL/dZub4CBF/dbSSCluutTORSuB1raSliGg1pk6+UK3BIrTrv5NhJuh+bNfM5VY8Sh81GsqUL4e5Ke8xUDcOrkN3Gd3ew2Z/DTEl03hG0B+1/y/yPw40BozXhew6J1wBKJq/Sd3kb/qaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5otCPvOkxje5o6EUr4kp2rUYcO+9Pt4/ZBeNXx7DZ0=;
 b=nZCRpNxHotO0U6PL/UmfXafSM2ILLk4xuga3P/Su4L76iabqFUDXfb6VUKh4eijMxVVmXdM6j4KBF6uYQfD7DBvxaf/npGgvJjgSaMLV0zE3ICBs/C5T6b3ACXJYElpto/O7/DFUOs9M/mfVyVD5TkhLc3p4lHgkQgrGB0QxknE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5378.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:53:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c07:e2da:3210:3fd7%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:53:31 +0000
Date:   Mon, 14 Nov 2022 14:53:29 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 21/28] rust: str: add `CString` type
Message-ID: <20221114145329.0f47a3ab@GaryWorkstation>
In-Reply-To: <20221110164152.26136-22-ojeda@kernel.org>
References: <20221110164152.26136-1-ojeda@kernel.org>
        <20221110164152.26136-22-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 229be5d0-64f3-4eb6-a138-08dac64fff1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9b5ZmPrniQVnv4nEJC6KQHBM7nbB/jmdqWwPszjmDmmsoePFs3X+HqUVDMn7tMbf0Qf9qjKO7hI8k/zRLW4kc4X1Er2+E5TpqcUc2iYhgCsf1+/6lvaxBiA4LBrOQdg+VRSfOeI1dCKMuNj4EjgBXGgsgcTeV+1/kPDi35bzygRJW38+K38t+IWA+R4uHtbCV0IpDEvXZ78YXPNprY1qnrjQk2jwxRVc/Aj0U1rBTVr4hzQ6YVT6vfLgE2SwiishQDuZxGiHRLIPpCEDiHiQGZE+c7wFSUNwhS60YDFuAP4adTuHfL3OwjaFYs4g/MQYWIkEZK26A1XFZ+6IgI5Z3mKnfI5LM1uP3hhL7qvZY3cgFMINf61V/zC54R1ZJcq+RFd65cAVc+r5AuuN6ZjRDix6T8BZbL6ehnlddWV0q9Lv73FyXu9IGZhPEwp+v+cuL3irVqZ9mpbBGfqoVI6mTOAZ5mJGGMA77dpz0BhEyfz3ldKMG0SJ29aVFr3OQqbhHiIqsyMf5oLSAXCy04hpGMqbFoaNLfOyHVj2i2vVgfI/y7cBX8GojGFShdqNL9B90h0rcfNG78FTOQyywyg2PYnkW6o6ioz2qEFAzoKBI4/jOUtJ+uA7HVh/uHVlsJkSOeFE+29yXG6R3p5H1oRiSloyLxfjcH/9NHMVhmGy2q2g+0+G95cmob5TaA8uGyDpabbe/vEX4eZBC94bll5/9XjEqnSdkqWjHO+6p+ZIPUkrMFEwlh4F3PSHKIAY+nw1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(346002)(366004)(39830400003)(136003)(451199015)(66946007)(2906002)(38100700002)(54906003)(6916009)(66476007)(66556008)(4326008)(8676002)(1076003)(186003)(316002)(6512007)(9686003)(83380400001)(478600001)(6506007)(33716001)(86362001)(6486002)(8936002)(5660300002)(41300700001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BI4NIlMXjsBXUZFmEn9z0NLMiL33ACh1lS4rqwcGcLdbYBolPhS57xxwEcXu?=
 =?us-ascii?Q?0CMyI9BN7SPLmlTMME8QNSmN3k0TJRiEV3uJ/2V8NtuqL2bQrox+hNNFpZEm?=
 =?us-ascii?Q?iTxZTU3HVJ4ivBb6wfA0si/zO5aQn00zYR/gASiz8ySm6EU5vLqTebnI1jaJ?=
 =?us-ascii?Q?JhkYiuCIKaRF62LtIDP5ZGQrgu76Aesmcrkj18OP/jelaauIfbvFULW4eF0O?=
 =?us-ascii?Q?NTbl0elur18HWXrnffkJEj4KrSiHPpOj2oJHFFc/D3yAo1fQwEYi8VJ7u3cY?=
 =?us-ascii?Q?KiEq7uK4KpRq3hj0KRmlWVwHxP1Jp77cizIk+w+evQr0LShWQ2tv40PxsLYr?=
 =?us-ascii?Q?zjvVdJFeQ9Wy0LPiAhnz7B438Fmmpoy+aVfN1icdIHkwG+TJgSsQP26pksW3?=
 =?us-ascii?Q?Ri1xPjGW45g/l9p9I84pLKnYPfWgfaUXfS5OvQ9e4Mo/y//tjdTRU2YYkbwr?=
 =?us-ascii?Q?HtWUzk9KaZlkJa8puARE9JMTB7HxrQ7LBvj/lZUJ/UJd4q/eT7VipzcsobYP?=
 =?us-ascii?Q?G2D+9z825QOMuvhEfaRONi8nuiAfgFbWP56DJYOPajp5geuGyJReadIVJI0r?=
 =?us-ascii?Q?lC0NjAWM6Dp93pmS0WOXqk0II5yOa29RgPTHB110MPdhTv7rFY3fpICr8gX/?=
 =?us-ascii?Q?1MZobmOZ4d1YRMoVPGvYPJxuDAW9tVJVndZ+lWsL+LEXElCktQ7F75pwPT3o?=
 =?us-ascii?Q?DFrvd/u9UKRWVlgYNsrpA5kMUZ4/TiDKPUUIUyTyJQQQjCg9HJNx+wxuwNgU?=
 =?us-ascii?Q?faP9RdNtOYXSe6xNtvd7rEtvWW2Zv5ijrh03by2RrmmkXmokbMG/qJEgvhbA?=
 =?us-ascii?Q?oFBfUa43VMk/VyFhe1CMr/hEbvCJc2gcqXILTkTeT4sRrrWd+D9V9aMdPMXL?=
 =?us-ascii?Q?7lj+Vr4VCkwxwd7CXPTnhfTmfasNS/EAVSj01qnTE+bzZfZ0eM6sjGywb+7b?=
 =?us-ascii?Q?cGFuRyvSTFUfz+LC3aC+4tAzQtiz3G+A7okeSebWjxHJNiZy458gUS1tWGxY?=
 =?us-ascii?Q?vyNPcm4oLSH82JhssMseFO+SYT5OR57saQCDhSwo5JV5YFi8xnl46rfXT8nW?=
 =?us-ascii?Q?BiO3jDMux8Gv+X9qKrbWHGdsXH7TtKZk3ClHXes6fvFF47mvrZ26bUOEZM+C?=
 =?us-ascii?Q?fRECoK3C2ne1MS2fQ/KqLsBoutMPn8ag4kZiThKVgrp9BVY26l4SShJyq/Qe?=
 =?us-ascii?Q?MseGMFyFCiel6p3OFuaE9kg7sWRGHnbgocvt9qbn+aMbA7E0grMjYsHQv9Kj?=
 =?us-ascii?Q?F/rfO+Qi/CdYyrsdCPSjWx/T6sym9T31kPxvEm1pcKm5O81X+689YwkkGLSO?=
 =?us-ascii?Q?r1v+aLtTtmB3mVLW4bJAFTEHGpfQ2LVo1DbGEdktC54LyoxLe7IyInyZ2XNO?=
 =?us-ascii?Q?YSoJobiLJP01OMQ3JelwShmhZ7XsjtLz2+5MNUisxUpZULRP3iOJwBuSC1uV?=
 =?us-ascii?Q?7guV2TVM7qebE7t3ymG0QgXdWwI3pekTdPjys3b97w9xcMmOk7ULjzB0Ljnq?=
 =?us-ascii?Q?n3p5xSRCDXoPbijY8ZRWCEA1LLmJoCNIkxaVtgj1gwr/7fGBhkPP3Yzio9Dj?=
 =?us-ascii?Q?KVyHVcLh8GTCr/xsT86q1nFdA1G7mSZs3+H547wVAmTxI0HMvnPLNRxNaanQ?=
 =?us-ascii?Q?w10ZcOAu+TD79T3VkOX8ICseItEeTiPS/anro8QlYykJ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 229be5d0-64f3-4eb6-a138-08dac64fff1f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:53:31.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GzBpNclJS6RY45VGjn2w/wCfBUDdBBjqZHmxdTBV2NZvlL8IJHwWo1TRLHeFYmwe6HDXvO69hQfs25S9shFLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:41:33 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add the `CString` type, which is an owned string that is guaranteed
> to have exactly one `NUL` byte at the end, i.e. the owned equivalent
> to `CStr` introduced earlier.
> 
> It is used for interoperability with kernel APIs that take C strings.
> 
> In order to do so, implement the `RawFormatter::new()` constructor
> and the `RawFormatter::bytes_written()` method as well.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/str.rs | 91 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index db6473db31c6..877148b77e71 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,6 +2,7 @@
>  
>  //! String representations.
>  
> +use alloc::vec::Vec;
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, Index};
>  
> @@ -393,13 +394,22 @@ mod tests {
>  /// is less than `end`.
>  pub(crate) struct RawFormatter {
>      // Use `usize` to use `saturating_*` functions.
> -    #[allow(dead_code)]
>      beg: usize,
>      pos: usize,
>      end: usize,
>  }
>  
>  impl RawFormatter {
> +    /// Creates a new instance of [`RawFormatter`] with an empty buffer.
> +    fn new() -> Self {
> +        // INVARIANT: The buffer is empty, so the region that needs to be writable is empty.
> +        Self {
> +            beg: 0,
> +            pos: 0,
> +            end: 0,
> +        }
> +    }
> +
>      /// Creates a new instance of [`RawFormatter`] with the given buffer pointers.
>      ///
>      /// # Safety
> @@ -438,6 +448,11 @@ impl RawFormatter {
>      pub(crate) fn pos(&self) -> *mut u8 {
>          self.pos as _
>      }
> +
> +    /// Return the number of bytes written to the formatter.
> +    pub(crate) fn bytes_written(&self) -> usize {
> +        self.pos - self.beg
> +    }
>  }
>  
>  impl fmt::Write for RawFormatter {
> @@ -478,7 +493,6 @@ impl Formatter {
>      ///
>      /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
>      /// for the lifetime of the returned [`Formatter`].
> -    #[allow(dead_code)]
>      pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
>          // SAFETY: The safety requirements of this function satisfy those of the callee.
>          Self(unsafe { RawFormatter::from_buffer(buf, len) })
> @@ -505,3 +519,76 @@ impl fmt::Write for Formatter {
>          }
>      }
>  }
> +
> +/// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
> +///
> +/// Used for interoperability with kernel APIs that take C strings.
> +///
> +/// # Invariants
> +///
> +/// The string is always `NUL`-terminated and contains no other `NUL` bytes.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::str::CString;
> +///
> +/// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20)).unwrap();
> +/// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
> +///
> +/// let tmp = "testing";
> +/// let s = CString::try_from_fmt(fmt!("{tmp}{}", 123)).unwrap();
> +/// assert_eq!(s.as_bytes_with_nul(), "testing123\0".as_bytes());
> +///
> +/// // This fails because it has an embedded `NUL` byte.
> +/// let s = CString::try_from_fmt(fmt!("a\0b{}", 123));
> +/// assert_eq!(s.is_ok(), false);
> +/// ```
> +pub struct CString {
> +    buf: Vec<u8>,
> +}
> +
> +impl CString {
> +    /// Creates an instance of [`CString`] from the given formatted arguments.
> +    pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
> +        // Calculate the size needed (formatted string plus `NUL` terminator).
> +        let mut f = RawFormatter::new();
> +        f.write_fmt(args)?;
> +        f.write_str("\0")?;

I haven't checked the assembly, so this is possibly optimized out
already, but I feel that this line could be removed and we just use
`f.bytes_written() + 1` instead on the following line.

> +        let size = f.bytes_written();
> +
> +        // Allocate a vector with the required number of bytes, and write to it.
> +        let mut buf = Vec::try_with_capacity(size)?;
> +        // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
> +        let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
> +        f.write_fmt(args)?;
> +        f.write_str("\0")?;
> +
> +        // SAFETY: The number of bytes that can be written to `f` is bounded by `size`, which is
> +        // `buf`'s capacity. The contents of the buffer have been initialised by writes to `f`.
> +        unsafe { buf.set_len(f.bytes_written()) };

`f.bytes_written() <= size` does not always hold. It holds here because
otherwise the `?` operator above would return an error early
(guaranteed by `impl Write for Formatter`). I feel that this fact is
not clearly stated in the safety comment but I don't have a good way to
rephrase this either.

> +
> +        // Check that there are no `NUL` bytes before the end.
> +        // SAFETY: The buffer is valid for read because `f.bytes_written()` is bounded by `size`
> +        // (which the minimum buffer size) and is non-zero (we wrote at least the `NUL` terminator)
> +        // so `f.bytes_written() - 1` doesn't underflow.
> +        let ptr = unsafe { bindings::memchr(buf.as_ptr().cast(), 0, (f.bytes_written() - 1) as _) };

How about just use `if buf[..(f.bytes_written() - 1)].contains(&0) {`
here? libcore specialises `<[u8]>::contains` to use a faster search
than `.iter().any(...)`.

> +        if !ptr.is_null() {
> +            return Err(EINVAL);
> +        }
> +
> +        // INVARIANT: We wrote the `NUL` terminator and checked above that no other `NUL` bytes
> +        // exist in the buffer.
> +        Ok(Self { buf })
> +    }
> +}
> +
> +impl Deref for CString {
> +    type Target = CStr;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the string is `NUL`-terminated and that no
> +        // other `NUL` bytes exist.
> +        unsafe { CStr::from_bytes_with_nul_unchecked(self.buf.as_slice()) }
> +    }
> +}

