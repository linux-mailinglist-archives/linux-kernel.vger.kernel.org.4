Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3974664F160
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiLPTFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiLPTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:05:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F065987
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:05:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FFD0B81DE3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 19:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C45DC433EF;
        Fri, 16 Dec 2022 19:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671217506;
        bh=shfUHq2wGxReUzcQjKTZ7wMKOWDadGVEZARJx4hBfEY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Oyx/7DRgUXL6tei+4m/5+Sf71ppVqYmBeWF4YhQRl6G/JlVL8P0jMBr0xakVRF0AQ
         4zBAPFEAAqlYepxOQ1UmM9qM6lBTbgxgb2i7IqnqFHhwj9932MO+HWwS9HBG6a1hmT
         zCVB4IRJqibX98wvumDM/IpqpA/IdPzjJ9iA5Ev/UTJaVDSRuFqaHWAlDVaHNBkoko
         TlfOHYkMT3shjWD9iLmw6+RdUzBV4HHbA+15t2PnQDWtRaYvgXvbBgqIYmaJLQw4xb
         F6mWQ2Xs/I+4Cprx6vHOXzvD1SfiHS6EVGZHuR6tvXef74J0HbOb0mqQKMOksS5sh+
         WGrEpu5Fy7g/A==
Date:   Fri, 16 Dec 2022 11:05:05 -0800
From:   Conor Dooley <conor@kernel.org>
To:     Saleem Abdulrasool <abdulras@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
User-Agent: K-9 Mail for Android
In-Reply-To: <20221216185012.2342675-1-abdulras@google.com>
References: <20221216185012.2342675-1-abdulras@google.com>
Message-ID: <D734C5A0-5FE1-4287-BF7B-A1DE97C00D55@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Saleem,

On 16 December 2022 10:50:12 GMT-08:00, Saleem Abdulrasool <abdulras@googl=
e=2Ecom> wrote:
>The compiler is free to generate vectorized operations for zero'ing
>memory=2E  The kernel does not use the vector unit on RISCV, similar to
>architectures such as x86 where we use `-mno-mmx` et al to prevent the
>implicit vectorization=2E  Perform a similar check for
>`-mno-implicit-float` to avoid this on RISC-V targets=2E
>
>Signed-off-by: Saleem Abdulrasool <abdulras@google=2Ecom>
>---
> arch/riscv/Makefile | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>index 0d13b597cb55=2E=2E68433476a96e 100644
>--- a/arch/riscv/Makefile
>+++ b/arch/riscv/Makefile
>@@ -89,6 +89,10 @@ KBUILD_AFLAGS_MODULE +=3D $(call as-option,-Wa$(comma)=
-mno-relax)
> # architectures=2E  It's faster to have GCC emit only aligned accesses=
=2E
> KBUILD_CFLAGS +=3D $(call cc-option,-mstrict-align)
>=20
>+# Ensure that we do not vectorize the kernel code when the `v` extension=
 is
>+# enabled=2E  This mirrors the `-mno-mmx` et al on x86=2E

The v extension should not be enabled at all though, right?
Excuse my naivity here, but what am I missing?
The vector support thread is here:
https://lore=2Ekernel=2Eorg/linux-riscv/20220921214439=2E1491510-1-stillso=
n@rivosinc=2Ecom/

What have I missed that causes a problem without that patchset?
And if I have missed something, this patch needs to be cc: stable?

Thanks,
Conor=2E

>+KBUILD_CFLAGS +=3D $(call cc-option,-mno-implicit-float)
>+
> ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> prepare: stack_protector_prepare
> stack_protector_prepare: prepare0
