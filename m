Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24E2693148
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBKNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:44:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0926848;
        Sat, 11 Feb 2023 05:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B2DACE262F;
        Sat, 11 Feb 2023 13:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7077EC433D2;
        Sat, 11 Feb 2023 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676123073;
        bh=ywQ9/3H+EEIHXfZNA5Ru1VdHYsUU+ziQI/aPSHLW8VQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=NFTEywILYBOvsatq+yUuQgmFuPzctj1OCXOYgHTghJEy1kurUDe6+AyDsWVXCL+7H
         HRH0ZgHf7+7DHj7jK6qF21eFa1ptQ/Ysz9oH0qtTAImins4x602NZwdeSPuqLRP2nL
         azAM876CxQDbIU/qtsLIrRESOmp1vwIswESzJm/ke4OmFxpAEjG9Af+JVK8rqqxoeA
         WRk3kDMoRACBIeWWpASSppvg54tDLU1ZIPW9w4U1EibvvGa4QHOGvvHxIh7pjJ49VQ
         qTA4eWIQuseoslLahUFQMNHNUbgRKBhaYlmLwzFL31uHj5dXcVeIsN6BTrZxBhowoi
         A96+RlqiB6b9g==
Date:   Sat, 11 Feb 2023 05:44:33 -0800
From:   Kees Cook <kees@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
CC:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
User-Agent: K-9 Mail for Android
In-Reply-To: <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
References: <20230210215141.108958-1-andrea.righi@canonical.com> <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org> <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
Message-ID: <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 11, 2023 1:04:16 AM PST, Andrea Righi <andrea=2Erighi@canonical=
=2Ecom> wrote:
>On Fri, Feb 10, 2023 at 02:43:56PM -0800, Kees Cook wrote:
>> On February 10, 2023 1:51:41 PM PST, Andrea Righi <andrea=2Erighi@canon=
ical=2Ecom> wrote:
>> >With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen passes
>> >-ftrivial-auto-var-init=3Dzero to clang, that triggers the following
>> >error:
>> >
>> > error: '-ftrivial-auto-var-init=3Dzero' hasn't been enabled; enable i=
t at your own peril for benchmarking purpose only with '-enable-trivial-aut=
o-var-init-zero-knowing-it-will-be-removed-from-clang'
>> >
>> >However, this additional option that is currently required by clang is
>> >going to be removed in the future (as the name of the option suggests)=
,
>> >likely with clang-17=2E
>> >
>> >So, make sure bindgen is using this extra option if the major version =
of
>> >the libclang used by bindgen is < 17=2E
>> >
>> >In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
>> >without triggering any build error=2E
>> >
>> >Link: https://github=2Ecom/llvm/llvm-project/issues/44842
>> >Signed-off-by: Andrea Righi <andrea=2Erighi@canonical=2Ecom>
>> >---
>> >
>> >Changes in v2:
>> > - check the version of libclang used by bindgen to determine if we ne=
ed
>> >   to pass the additional clang option
>> >
>> > rust/Makefile | 13 +++++++++++++
>> > 1 file changed, 13 insertions(+)
>> >
>> >diff --git a/rust/Makefile b/rust/Makefile
>> >index ff70c4c916f8=2E=2Ec77d7ce96a85 100644
>> >--- a/rust/Makefile
>> >+++ b/rust/Makefile
>> >@@ -269,6 +269,19 @@ BINDGEN_TARGET		:=3D $(BINDGEN_TARGET_$(SRCARCH))
>> > # some configurations, with new GCC versions, etc=2E
>> > bindgen_extra_c_flags =3D -w --target=3D$(BINDGEN_TARGET)
>> >=20
>> >+# Auto variable zero-initialization requires an additional special op=
tion with
>> >+# clang that is going to be removed sometimes in the future (likely i=
n
>> >+# clang-17), so make sure to pass this option only if clang supports =
it
>> >+# (libclang major version < 17)=2E
>> >+#
>> >+# https://github=2Ecom/llvm/llvm-project/issues/44842
>> >+ifdef CONFIG_INIT_STACK_ALL_ZERO
>> >+libclang_maj_ver=3D$(shell $(BINDGEN) $(srctree)/scripts/rust_is_avai=
lable_bindgen_libclang=2Eh 2>&1 | sed -ne 's/=2E*clang version \([0-9]*\)=
=2E*/\1/p')
>> >+ifeq ($(shell expr $(libclang_maj_ver) \< 17), 1)
>> >+bindgen_extra_c_flags +=3D -enable-trivial-auto-var-init-zero-knowing=
-it-will-be-removed-from-clang
>> >+endif
>> >+endif
>>=20
>> This logic already exists in the top-level Makefile=2E How does -ftrivi=
al-auto-var-init=3Dzero make it into bindgen_c_flags normally? (I=2Ee=2E wh=
y does the legacy -enable=2E=2E=2E option not?)
>
>If we're using gcc, the top-level Makefile doesn't set the clang
>options, so in this case CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER is
>undefined=2E  But then bindgen always relies on libclang to parse C, even
>if gcc is used globally, therefore it needs the extra clang flag=2E

Ah yes! Thank you, I keep forgetting about mixed compiler builds=2E

>
>Ideally it'd be nice if bindgen would support a gcc backend, but until
>then we need to do something special here, like this kind of duplicated
>logic=2E=2E=2E

Right=2E Yeah, good fix=2E One nit: the -enable=2E=2E=2E flag is removed i=
n Clang 16+:

https://github=2Ecom/llvm/llvm-project/blob/llvmorg-16=2E0=2E0-rc2/clang/d=
ocs/ReleaseNotes=2Erst#deprecated-compiler-flags

With that fixed:

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>


--=20
Kees Cook
