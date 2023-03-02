Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F26E6A8400
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCBOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:16:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845333252E;
        Thu,  2 Mar 2023 06:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3AA1615B3;
        Thu,  2 Mar 2023 14:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFE4C433EF;
        Thu,  2 Mar 2023 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677766598;
        bh=OEBZAjntrzt45cN/wrw8P1FyBTzRzs8XJnWRa3aAwdE=;
        h=Date:From:To:Cc:Subject:From;
        b=HIGFwEaq+JSHzpiCLw0ppfq/bRH0TUocrrYcfarwp1zZoLiKOg+jbK7DzkVxZPDbE
         Ppg4UbmdGv676SLkMShGKkW69hc1X8nJdt35oWnb/7dMKt3KwEkRXa1/xYJeItP7M4
         E7YP7YMqwd/gQPTcuPAEh+ahTN1YmFcZzUr0dwTTyg2/N0ryQlUykxCr0V3USF3O3C
         eaO9kfUjrkU8F4Seq6Lt2ZP2BxL1mNjpmFIuetfw4aBvjp0y9LmaYkTTJuPrJLeETx
         O7Ho6Ok3lMOao9W/DSCpImoiLceHqs6V08aD4O/5hCCV2OPa3CjSjwesB/0N/51wZA
         /Tb9Gi5DLJ0VQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19ABA4049F; Thu,  2 Mar 2023 11:16:36 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:16:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Derek Barbosa <debarbos@redhat.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
Message-ID: <ZACvxNOuuyifQ9Nx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address this build error:

    BINDGEN rust/bindings/bindings_generated.rs
    BINDGEN rust/bindings/bindings_helpers_generated.rs
    EXPORTS rust/exports_core_generated.h
    RUSTC P rust/libmacros.so
    RUSTC L rust/compiler_builtins.o
    RUSTC L rust/alloc.o
    RUSTC L rust/bindings.o
    RUSTC L rust/build_error.o
    EXPORTS rust/exports_alloc_generated.h
  error[E0588]: packed type cannot transitively contain a `#[repr(align)]` type
       --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10094:1
        |
  10094 | / pub struct alt_instr {
  10095 | |     pub instr_offset: s32,
  10096 | |     pub repl_offset: s32,
  10097 | |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
  10098 | |     pub instrlen: u8_,
  10099 | |     pub replacementlen: u8_,
  10100 | | }
        | |_^
        |
  note: `alt_instr__bindgen_ty_1__bindgen_ty_1` has a `#[repr(align)]` attribute
       --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10111:1
        |
  10111 | / pub struct alt_instr__bindgen_ty_1__bindgen_ty_1 {
  10112 | |     pub _bitfield_1: __BindgenBitfieldUnit<[u8; 4usize], u16>,
  10113 | | }
        | |_^
  note: `alt_instr` contains a field of type `alt_instr__bindgen_ty_1`
       --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10097:9
        |
  10097 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
        |         ^^^^^^^^^^^^^^^^
  note: ...which contains a field of type `alt_instr__bindgen_ty_1__bindgen_ty_1`
       --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10104:9
        |
  10104 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1__bindgen_ty_1,
        |         ^^^^^^^^^^^^^^^^

  error: aborting due to previous error

  For more information about this error, try `rustc --explain E0588`.
  make[1]: *** [rust/Makefile:389: rust/bindings.o] Error 1
  make: *** [Makefile:1293: prepare] Error 2

Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 rust/bindgen_parameters | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index be4963bf720304da..552d9a85925b9945 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -6,6 +6,7 @@
 --opaque-type local_apic
 
 # Packed type cannot transitively contain a `#[repr(align)]` type.
+--opaque-type alt_instr
 --opaque-type x86_msi_data
 --opaque-type x86_msi_addr_lo
 
-- 
2.39.2

