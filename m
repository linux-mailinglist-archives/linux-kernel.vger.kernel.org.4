Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ADE71547C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjE3EXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjE3EXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D0E4;
        Mon, 29 May 2023 21:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B057F619B9;
        Tue, 30 May 2023 04:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03344C433D2;
        Tue, 30 May 2023 04:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685420621;
        bh=GqutkF5MXsruCTwXr5ie/PdJ0e98ztYdsBZec7CiqHU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=rCXiIQImQZ3BZIQhrr/E5IEfYFqR5NxJfeOT8IxJgsA+pjekgz9LJuZkeCVCGeM1o
         SdiNRcgHSFViZtDOoOp4lJiLBxkZaRyg9eedKnkE5zF4t7nq0vG1GE8K2a9hU7HARh
         wR+TqyQyiQLKTvCq3q/fg0j8AuijHn4MSeSlft9aICNsks8yuNeLNE0hya0l3lHhm/
         bo8AqCJ2d13Ic3b4cvBQWr/FMKUlKYc397oCWMI3cNXjg3p2vKbCNXebQajn9AK5Hi
         VnyQtA2EUlI3PrqJW1we6wf/D9OUydQ7bsH9jJJyqkThZZOeScps2umkRJULhM4Z5W
         97OLLRGPTH80g==
Date:   Mon, 29 May 2023 21:23:39 -0700
From:   Kees Cook <kees@kernel.org>
To:     =?ISO-8859-1?Q?Joan_Bruguera_Mic=F3?= <joanbrugueram@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_build_error_while_building_arch/x86/purgatory/sha256?= =?US-ASCII?Q?=2Eo=3A_invalid_=27asm=27=3A_operand_i?= =?US-ASCII?Q?s_not_a_condition_code_=5B=2E=2E=2E=5D?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230528164031.266590-1-joanbrugueram@gmail.com>
References: <175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info> <20230528164031.266590-1-joanbrugueram@gmail.com>
Message-ID: <EE2A76DE-973F-4FCD-AEC8-C24D9FFCC3F1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 28, 2023 9:40:31 AM PDT, "Joan Bruguera Mic=C3=B3" <joanbrugueram@gm=
ail=2Ecom> wrote:
>I can also reproduce the problem with Arch's linux-next-git, see config:
>https://aur=2Earchlinux=2Eorg/cgit/aur=2Egit/tree/config?h=3Dlinux-next-g=
it&id=3Df9a384e1c582321651fb613782ebc5a581146af0
>
>I've bisected it to df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3D=
3"),
>which explains why it only happens on GCC13=2E
>
>The problematic expansion that causes the error seems to be this fragment
>from `_BUG_FLAGS` in `arch/x86/include/asm/bug=2Eh`:
>    asm("=2Elong %c0 - =2E\n": : "i" (__FILE__));
>
>Along with the fact that this file is built with `-mcmodel=3Dlarge`
>(see `PURGATORY_CFLAGS` in `arch/x86/purgatory/Makefile`)=2E

I haven't reproduced this yet, but the error implies that the asm input "i=
"mmediate value of the __FILE__ string address cannot be used with the asm =
template format "%c0" (a constant value)=2E

https://gcc=2Egnu=2Eorg/onlinedocs/gcc/Extended-Asm=2Ehtml#Generic-Operand=
-Modifiers

I cannot fathom why struct flex array logic would change that=2E=2E=2E

I'll take a closer look in the morning=2E

-Kees


--=20
Kees Cook
