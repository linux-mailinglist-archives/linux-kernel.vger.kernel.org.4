Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488BC6A4334
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjB0Nrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0Nrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:47:47 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1CE1CAD8;
        Mon, 27 Feb 2023 05:47:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A6CD13FA55;
        Mon, 27 Feb 2023 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677505663;
        bh=hgOvyT1rVFtsCiQaChGOxQAFckukb+KMUXXui+J7Pa4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=zNr3jSrDBT/557jd/WO+h6YWcaBqcWD3cGKLZSvuqkW1aIDN4VEavK3aTyizn5sQr
         emuDIDm7lCab1xsfk+uii4EtbR1aGTahzVtZn0afFY415twiroV2Bmg3IkFHSfoHiH
         CsPXbW9XTg0/InN8MOuBaosDJFDPQChrhlhBhoNwn9bofqHfkRGBsm6cdJReWZRrwg
         DVFf4112ixrwgyxfdAYLq5GGKPZ5/HB064lvZJj95jiYpzeTRb9KUbR3vKJjGeYxN2
         Pl8hokpnsfXnoW/06zJSCvR+kmQlZYoFWjieaAuWiqTai9/v/rdgz0SgqtHemB033b
         GHX1wO8KMYgkg==
Message-ID: <96cb824e-8251-a329-11e5-3618a4e59bc8@asahilina.net>
Date:   Mon, 27 Feb 2023 22:47:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rust: Enable the new_uninit feature for kernel and driver
 crates
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
 <87pm9v9rmg.fsf@metaspace.dk>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <87pm9v9rmg.fsf@metaspace.dk>
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

On 27/02/2023 22.09, Andreas Hindborg wrote:
> 
> Asahi Lina <lina@asahilina.net> writes:
> 
>> The unstable new_uninit feature enables various library APIs to create
>> uninitialized containers, such as `Box::assume_init()`. This is
>> necessary to build abstractions that directly initialize memory at the
>> target location, instead of doing copies through the stack.
>>
>> Will be used by the DRM scheduler abstraction in the kernel crate, and
>> by field-wise initialization (e.g. using `place!()` or a future
>> replacement macro which may itself live in `kernel`) in driver crates.
>>
>> See [1] [2] [3] for background information.
>>
>> [1] https://github.com/Rust-for-Linux/linux/issues/879
>> [2] https://github.com/Rust-for-Linux/linux/issues/2
>> [3] https://github.com/rust-lang/rust/issues/63291
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>  rust/kernel/lib.rs     | 1 +
>>  scripts/Makefile.build | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 223564f9f0cc..1118cd3e0b5f 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -17,6 +17,7 @@
>>  #![feature(core_ffi_c)]
>>  #![feature(dispatch_from_dyn)]
>>  #![feature(generic_associated_types)]
>> +#![feature(new_uninit)]
>>  #![feature(receiver_trait)]
>>  #![feature(unsize)]
>>  
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index a0d5c6cca76d..0f637e1ca8dc 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>>  # Compile Rust sources (.rs)
>>  # ---------------------------------------------------------------------------
>>  
>> -rust_allowed_features := core_ffi_c
>> +rust_allowed_features := core_ffi_c,new_uninit
> 
> What is the purpose of adding the feature here? The kernel crate seems
> to compile fine without this.

It's for the upcoming DRM abstractions, as I mentioned in the commit
message. There's so many dependencies that I'm trying to get as much as
I can early to avoid having to review very big patchsets down the line ^^

~~ Lina
