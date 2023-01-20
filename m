Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C167558E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjATNTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjATNSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:18:38 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B347DFAF;
        Fri, 20 Jan 2023 05:17:46 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:17:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1674220659; x=1674479859;
        bh=QhMp/bJy0FGOBVYNVHwQ4CQSJ/T8ml1Q7a0jq2CQsIE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vcRrEAPk5ltBexkrxiCPGVyRIf3cNplOwB24sChYLMOj3bb1gnLtTBlrPIAawoaLR
         16rj4lvt2zDbvXmiZU849BaeC5YSFqik0ieX157d+fE6OwRFkBJC/dKfl5AXv0vhtR
         jC9Lpvpl75pyup5PtOdbegXpOTkcsj9nEjiNF8+KHv0wZiprzHhFVBUwwv9rExHHSO
         NqVITOBL0jNN3ySQbsUhJXPkAHRLUb7rfFNV5M3Tc0zkc33V2+aV0eZCRm2Fx6G1Jd
         +ztDJKzoSrGblaXdo3F6whX3/q71i++1SlHJVwpX50p55wpx6zLF3ippjbNnt0s+L2
         719v8rYxXzgyg==
To:     Vinay Varma <varmavinaym@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] scripts: `make rust-analyzer` for out-of-tree modules
Message-ID: <MzQKRFS7tVFtse-EaI1QkIlyz1NMk56vSPdOmY0M3sgG4RHsFUMubaEffsPxSDyFG9dKfhJcBxN4pYYf3R95IuAVd1Ne0P2pMqXHC0dOTLw=@protonmail.com>
In-Reply-To: <20230118160220.776302-1-varmavinaym@gmail.com>
References: <20230118160220.776302-1-varmavinaym@gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Wednesday, January 18th, 2023 at 17:02, Vinay Varma <varmavinaym@gmail.c=
om> wrote:


> Adds support for out-of-tree rust modules to use the `rust-analyzer`
> make target to generate the rust-project.json file.
>=20
> The change involves adding an optional parameter `external_src` to the
> `generate_rust_analyzer.py` which expects the path to the out-of-tree
> module's source directory. When this parameter is passed, I have chosen
> not to add the non-core modules (samples and drivers) into the result
> since these are not expected to be used in third party modules. Related
> changes are also made to the Makefile and rust/Makefile allowing the
> `rust-analyzer` target to be used for out-of-tree modules as well.
>=20
> Signed-off-by: Vinay Varma varmavinaym@gmail.com
>=20
> ---

I tested this with https://github.com/Rust-for-Linux/rust-out-of-tree-modul=
e using "make -C ../rust-for-linux M=3D$(pwd) rust-analyzer". It produces a=
 rust-project.json file, however it misses the actual rust_out_of_tree crat=
e. This is due to the fact that generate_rust_analyzer.py only checks Makef=
ile to find the crate roots, but rust-out-of-tree-module defines it in Kbui=
ld instead.

Apart from this issue, all paths I checked in the generated rust-project.js=
on are correct.

Cheers,
Bjorn
