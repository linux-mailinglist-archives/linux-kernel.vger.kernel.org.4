Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898FB6A8545
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCBPfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCBPfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:35:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FC3431B;
        Thu,  2 Mar 2023 07:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F83B615B3;
        Thu,  2 Mar 2023 15:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B1C433EF;
        Thu,  2 Mar 2023 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677771349;
        bh=pc7zBjw7UfGXRZI0stjXTMByutXTDJN9+Po9UIw9cSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQFQtsF/TcfbZwLaqNsvKrHPZ2wh7TNPvCa0FVcn2JeVSAZoiZeqZEI9T7YWU7LaE
         HKEAVa58pC0+itOG+LFfFzEVwPMrtOeIdbzeI9XkSI5CcruhVYV2WTbVAoO7yt8XGr
         UUfnf7SJvzYBE9qc8TK41IBpKWJQV8f0TI5Iodr/Zu3MgNw05QiVLHaCfbBfGIJBnz
         KsLLB/GqF8VUMelEmIjX6u5bELRlz9TAjP+HmazVKn65heFY5bdYoGzZ/wiCTnAG7+
         Ghfj63jVNgEW8xiB9Qjsa+Q+CrldZlazxdQOK3WXz0Q/f53MGt7q3atS/p8TDzkSYG
         EN62iyA+5ngqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C82B4049F; Thu,  2 Mar 2023 12:35:46 -0300 (-03)
Date:   Thu, 2 Mar 2023 12:35:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Derek Barbosa <debarbos@redhat.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
Message-ID: <ZADCUvbeZrbjz8QR@kernel.org>
References: <ZACvxNOuuyifQ9Nx@kernel.org>
 <37578649-c696-f3b5-a216-196e210929e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37578649-c696-f3b5-a216-196e210929e5@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 02, 2023 at 11:59:00AM -0300, Martin Rodriguez Reboredo escreveu:
> On 3/2/23 11:16, Arnaldo Carvalho de Melo wrote:
> > To address this build error:
> > 
> >     BINDGEN rust/bindings/bindings_generated.rs
> >     BINDGEN rust/bindings/bindings_helpers_generated.rs
> >     EXPORTS rust/exports_core_generated.h
> >     RUSTC P rust/libmacros.so
> >     RUSTC L rust/compiler_builtins.o
> >     RUSTC L rust/alloc.o
> >     RUSTC L rust/bindings.o
> >     RUSTC L rust/build_error.o
> >     EXPORTS rust/exports_alloc_generated.h
> >   error[E0588]: packed type cannot transitively contain a `#[repr(align)]` type
> >        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10094:1
> >         |
> >   10094 | / pub struct alt_instr {
> >   10095 | |     pub instr_offset: s32,
> >   10096 | |     pub repl_offset: s32,
> >   10097 | |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
> >   10098 | |     pub instrlen: u8_,
> >   10099 | |     pub replacementlen: u8_,
> >   10100 | | }
> >         | |_^
> >         |
> >   note: `alt_instr__bindgen_ty_1__bindgen_ty_1` has a `#[repr(align)]` attribute
> >        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10111:1
> >         |
> >   10111 | / pub struct alt_instr__bindgen_ty_1__bindgen_ty_1 {
> >   10112 | |     pub _bitfield_1: __BindgenBitfieldUnit<[u8; 4usize], u16>,
> >   10113 | | }
> >         | |_^
> >   note: `alt_instr` contains a field of type `alt_instr__bindgen_ty_1`
> >        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10097:9
> >         |
> >   10097 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
> >         |         ^^^^^^^^^^^^^^^^
> >   note: ...which contains a field of type `alt_instr__bindgen_ty_1__bindgen_ty_1`
> >        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10104:9
> >         |
> >   10104 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1__bindgen_ty_1,
> >         |         ^^^^^^^^^^^^^^^^
> > 
> 
> Reading the kernel sources this field corresponds to an u16 which indeed
> represents a bit set and it says so in a comment on the field. I
> couldn't replicate this issue, though, because this struct is used only
> inside arch pretty much internally, then there's no problem to make it
> opaque. Still, we have to be careful if these kind of things appear in
> the future.

ok
 
> And I notice that You haven't mentioned the version of Bindgen that
> You've used, including its linked libclang too. Otherwise I think this
> could be accepted.

⬢[acme@toolbox linux]$ bindgen --version
bindgen 0.56.0
⬢[acme@toolbox linux]$ which bindgen
/var/home/acme/.cargo/bin/bindgen
⬢[acme@toolbox linux]$ ldd /var/home/acme/.cargo/bin/bindgen
	linux-vdso.so.1 (0x00007ffe543be000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f7b69e94000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f7b69db4000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f7b69bd7000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f7b6a235000)
⬢[acme@toolbox linux]$ clang --version &| head -2
bash: syntax error near unexpected token `|'
⬢[acme@toolbox linux]$ clang --version |& head -2
clang version 15.0.7 (Fedora 15.0.7-1.fc37)
Target: x86_64-redhat-linux-gnu
⬢[acme@toolbox linux]$
 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> 
> >   error: aborting due to previous error
> > 
> >   For more information about this error, try `rustc --explain E0588`.
> >   make[1]: *** [rust/Makefile:389: rust/bindings.o] Error 1
> >   make: *** [Makefile:1293: prepare] Error 2
> > 
> > Cc: Derek Barbosa <debarbos@redhat.com>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  rust/bindgen_parameters | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> > index be4963bf720304da..552d9a85925b9945 100644
> > --- a/rust/bindgen_parameters
> > +++ b/rust/bindgen_parameters
> > @@ -6,6 +6,7 @@
> >  --opaque-type local_apic
> >  
> >  # Packed type cannot transitively contain a `#[repr(align)]` type.
> > +--opaque-type alt_instr
> >  --opaque-type x86_msi_data
> >  --opaque-type x86_msi_addr_lo
> >  

-- 

- Arnaldo
