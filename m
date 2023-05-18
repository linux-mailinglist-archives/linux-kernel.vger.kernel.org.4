Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39527087D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjERSdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA7E43;
        Thu, 18 May 2023 11:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D286435A;
        Thu, 18 May 2023 18:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25805C433D2;
        Thu, 18 May 2023 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684434776;
        bh=7euHCdGOjx0kBVuWVRW14MmIjkqImiYgKz8h0vBD0LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4MZxPqq+UT7KdC5pSUEdJ4NOzMf6JaIpb73abPYQ5lv+dUoPnFB1CJZzgD5N8uj1
         rJiT+XkQ6G8MXH77qPLGAGGmIDPz+urLDOXE3eurBEQgp43syzXZ/yK/BRVTeSiBLc
         9KTuQs08Nih35rtA7p/GvyqlQBuSVjhfZ2k8ACrQU09mJ23xru2D6mvj5HZnwZvqLB
         bTou09fzKdSPdjd2Wr6QfE7SWfeM3WIT1A3dF6s0lH0SVuaHpr/IhpUb8/7OwhoQd/
         0USOoK5RnZrnB45UTG5w6/DSIjlgu0i2eJfCb09RPEKoB39iMcDww6wF9UdiuSC9hZ
         bQ+Iy34yH9Bzw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 May 2023 21:32:52 +0300
Message-Id: <CSPMAK0GJFK8.4C6UL9RXL3OX@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <ndesaulniers@google.com>, "David Howells" <dhowells@redhat.com>,
        "David Woodhouse" <dwmw2@infradead.org>
Cc:     "Ard Biesheuvel" <ardb@kernel.org>, <keyrings@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] certs: buffer stderr from openssl unless error
X-Mailer: aerc 0.14.0
References: <20230517-genkey-v1-1-b887424da4a8@google.com>
In-Reply-To: <20230517-genkey-v1-1-b887424da4a8@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 17, 2023 at 7:23 PM EEST,  wrote:
> Running `openssl req` prints a progress meter consisting of `.`, `*`,
> and `+` characters to stderr which we redirect to stdout. During a build
> with `make -j`, the output from this command becomes interspersed
> throughout the rest of the quiet_cmd_* output, messing up the
> indentation.
>
> Suppress the output from this command unless the return code is
> non-zero. If `openssl req` prints additional information to stderr
> without setting a non-zero return code, it will be missed.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  certs/Makefile   | 4 +---
>  certs/gen_key.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/certs/Makefile b/certs/Makefile
> index 799ad7b9e68a..9b4fee56780d 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -45,9 +45,7 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),certs/signing_key.pem)
>  keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) :=3D -newkey ec -pkeyopt ec_=
paramgen_curve:secp384r1
> =20
>  quiet_cmd_gen_key =3D GENKEY  $@
> -      cmd_gen_key =3D openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG=
_HASH) -days 36500 \
> -		-batch -x509 -config $< \
> -		-outform PEM -out $@ -keyout $@ $(keytype-y) 2>&1
> +      cmd_gen_key =3D $(srctree)/$(src)/gen_key.sh $(CONFIG_MODULE_SIG_H=
ASH) $< $@ $(keytype-y)
> =20
>  $(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
>  	$(call if_changed,gen_key)
> diff --git a/certs/gen_key.sh b/certs/gen_key.sh
> new file mode 100755
> index 000000000000..1de1f22be484
> --- /dev/null
> +++ b/certs/gen_key.sh
> @@ -0,0 +1,7 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +OUT=3D$(openssl req -new -nodes -utf8 -"$1" -days 36500 -batch -x509 \
> +	-config "$2" -outform PEM -out "$3" -keyout "$3" $4 2>&1)
> +if [[ $? -ne 0 ]]; then
> +	echo "$OUT"
> +fi
>
> ---
> base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> change-id: 20230517-genkey-24a835572835
>
> Best regards,
> --=20
> Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
