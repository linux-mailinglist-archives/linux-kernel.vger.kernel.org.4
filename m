Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6676A1EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBXPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:51:48 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9233E66970;
        Fri, 24 Feb 2023 07:51:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 32FDF3FB17;
        Fri, 24 Feb 2023 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677253905;
        bh=+KLi0NUptESnmGXbN5DL3EY0IK2dnKR7SFykR2x6pbg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qUebanJ0CMoI1uNj48ED+JrltoKSOFn/n7Ot86+60A8Mg+TFpThfDS/+dGOr4icGU
         M/OW3bwM3kaktG/wGU1NRaTWjIqsdW+EqWvRjw07tuM81O6ELt2QvIggs4ev/vzym0
         e3e2QxSWqHJ/DLhvkNkTIsyp+a2HxnNgl//Z4D0tkfl/6Ba9XDLrMyJIiP7/7ilaGZ
         Gv95EEBsmdhyRX0DJJqC/o2/8TUZa/y3TP21C3z0wKHYtDsZGZ3Bt+w8GxrT4awG/K
         FotZ93kMqfDyaoKmw4ZEWT8Skv1KdXuNvXfwoGOuLOkrRXj7GGXFrcAOulIXJahqQM
         7F2lIIc3L77GQ==
Message-ID: <bd93ed8c-b020-5883-4baa-f9743e395b97@asahilina.net>
Date:   Sat, 25 Feb 2023 00:51:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com>
 <26fc1456-0244-a379-0af4-e6adc819545c@asahilina.net>
 <Y/jZCCl4jbKoOiPX@kroah.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/jZCCl4jbKoOiPX@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 00.34, Greg Kroah-Hartman wrote:
> On Sat, Feb 25, 2023 at 12:10:47AM +0900, Asahi Lina wrote:
>>>> +impl Device {
>>>> +    /// Creates a new device instance.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
>>>> +    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
>>>> +        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
>>>> +        unsafe { bindings::get_device(ptr) };
>>>
>>> You don't check the return value of get_device()?  What if it failed
>>> (hint, it can)?
>>
>> Really? I looked at the implementation and I don't see how it can fail,
>> as long as the argument is non-NULL and valid... (which is a
>> precondition of this unsafe function). Did I miss something?
> 
> This function has changed a bit over time, but yes, it could fail if
> someone else just dropped the last reference right before you tried to
> grab a new one (look at the implementation of kobject_get()).
> 
> Yes, if you "know" you have a non-zero reference count first, it should
> never fail, but how do you know this?  We have the ability to check the
> return value of the function, shouldn't that happen?

Well, we know this because it is part of the invariant. If we don't
uphold invariants, things fall apart... that's why we create safe
abstractions that don't let you break those invariants after all!

In this particular case though, I don't see what we can usefully do
here. `device_get()` is going to be part of Clone impls and things like
that which are non-fallible. At most we can assert!() and rust-panic
(which is a BUG as far as I know) if it fails... would that be preferable?

~~ Lina
