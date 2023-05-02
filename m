Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234C66F496F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEBSDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjEBSDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 14:03:18 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDBE50
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 11:03:13 -0700 (PDT)
Date:   Tue, 02 May 2023 18:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1683050591; x=1683309791;
        bh=MbKHDVEDDmLAHzgC1P5XW5ikDauK/JRL4lyA13f78FE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=adnfOjUSCLRyGxgYEBOrKWA//Ipj4Xf2LiwvJIjRkxD5PwhqDx6Vw2RTDEB+G4IMh
         en6JN1Y1TkhrGMRwVsrTdWk1jBeaCnQ2SiYYdf0MbqnW7pgBxFA1H2xiuKwEiWkUsh
         V3zbgWqcwjFAAeUXlj2sVFpSY7XuuSkmPIVf2sq5F/U8gklCatvyN9O0N8G+lWRHpm
         DyzTBw7402FmDgScrf+sWoug1Oyvv42RD11p58CwIAr8PJyBDD7GhnCJBhB1PzrC9J
         0Kn2OwiCqNXvbwJ4D6twx6/nO5yWoLyMr007PyZE6OojpQ99+fxIRxdudMWLBFSWoX
         KnUHdL9Y02B6g==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] rust: str: add conversion from `CStr` to `CString`
Message-ID: <LUCgVpZBQNex70PxHGlNVauiTqldfXpTUbd9l0tkBl4yHBQ6qWIhIQu4eZn03UG4a3jrKqt4FyL81321CSXgdISmzYnn69DejmZ-UgXJgD0=@proton.me>
In-Reply-To: <CANeycqo+htksD_nj-eyCTOtE0TQHJR+dHZ1Hu8cL5eXNt4cd=A@mail.gmail.com>
References: <20230502125306.358283-1-aliceryhl@google.com> <CANeycqo+htksD_nj-eyCTOtE0TQHJR+dHZ1Hu8cL5eXNt4cd=A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.23 18:59, Wedson Almeida Filho wrote:
> On Tue, 2 May 2023 at 09:53, Alice Ryhl <aliceryhl@google.com> wrote:
>>
>> These methods can be used to copy the data in a temporary c string into
>> a separate allocation, so that it can be accessed later even if the
>> original is deallocated.
>>
>> The API in this file mirrors the standard library API for the `&str` and
>> `String` types. The `ToOwned` trait is not implemented because it
>> assumes that allocations are infallible.
>>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>>   rust/kernel/str.rs | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> index b771310fa4a4..54935ff3a610 100644
>> --- a/rust/kernel/str.rs
>> +++ b/rust/kernel/str.rs
>> @@ -2,6 +2,7 @@
>>
>>   //! String representations.
>>
>> +use alloc::collections::TryReserveError;
>>   use alloc::vec::Vec;
>>   use core::fmt::{self, Write};
>>   use core::ops::{self, Deref, Index};
>> @@ -199,6 +200,12 @@ impl CStr {
>>       pub unsafe fn as_str_unchecked(&self) -> &str {
>>           unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
>>       }
>> +
>> +    /// Convert this [`CStr`] into a [`CString`] by allocating memory a=
nd
>> +    /// copying over the string data.
>> +    pub fn to_cstring(&self) -> Result<CString, TryReserveError> {
>> +        CString::try_from(self)
>> +    }
>>   }
>>
>>   impl fmt::Display for CStr {
>> @@ -584,6 +591,20 @@ impl Deref for CString {
>>       }
>>   }
>>
>> +impl<'a> TryFrom<&'a CStr> for CString {
>> +    type Error =3D TryReserveError;
>=20
> Wouldn't `AllocError` make more sense? Or even Error (with ENOMEM value).
>=20
> `TryReserveError` is documented as "The error type for try_reserve
> methods." -- that fact the we use a `Vec` is an implementation detail,
> I feel it's better not to leak this fact through the public API.

I agree, it should be `AllocError`. There is a `From<AllocError> for Error`
with `ENOMEM` as the value, so `AllocError` is the most compatible, since i=
t
simply converts to `Error` via `?`.

Technically, `TryReserveError` represents two different kinds of errors:
- CapacityOverflow -- triggered when exceeding `isize::MAX` bytes of size
- AllocError -- memory allocation failed

I think it is fine to coalesce these into `AllocError`, since allocating
`isize::MAX` might as well be considered an OOM error.

With that fixed:
Reviewed-by: Benno Lossin <benno.lossin@proton.me>

>> +
>> +    fn try_from(cstr: &'a CStr) -> Result<CString, TryReserveError> {
>> +        let len =3D cstr.len_with_nul();
>> +        let mut buf =3D Vec::try_with_capacity(len)?;
>> +        buf.try_extend_from_slice(cstr.as_bytes_with_nul())?;
>> +
>> +        // INVARIANT: The CStr and CString types have the same invarian=
ts for
>> +        // the string data, and we copied it over without changes.
>> +        Ok(CString { buf })
>> +    }
>> +}
>> +
>>   /// A convenience alias for [`core::format_args`].
>>   #[macro_export]
>>   macro_rules! fmt {
>>
>> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162
>> --
>> 2.40.1.495.gc816e09b53d-goog
>>

--=20
Cheers,
Benno
