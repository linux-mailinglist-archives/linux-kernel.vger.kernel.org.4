Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1B6B6360
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 06:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCLFli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 00:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCLFlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 00:41:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146125BCA7;
        Sat, 11 Mar 2023 21:41:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D18360EA5;
        Sun, 12 Mar 2023 05:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FE5C433D2;
        Sun, 12 Mar 2023 05:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678599693;
        bh=QaFFgd2cnWDQnuLdGTtcv3x5c/kAzwH/MKx0hlXNgZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mlr0Dn55uGHe5nDjvfnHXXUxyYML1BKODykRxiKq8QhAz+4N9GuBirbVRuaJ0jPyi
         ONcZ+XAp2r22FZZ8iu7EbywYRn+puKZ4oCJPdfVtpcMtIZFWdcKyiyxZBPmlN2ABDd
         R8wVKOZdVoqFoo7BfyZuKozaAoMtWlRHQniGc4l+NzzWWCZj9vMXiPC95cBTh+hG3+
         ilPjy+PvdiYaSMw+Y1T2YkxRIrIDstuM/r8CW4WZH2FgiBa7gVt7tntpvRBVL2cLCl
         NnwSp7+tcUAOSjfH4Vr1cRWy9RH6yhuMOQa/NtmjKpD15HdRQau4/0t074HplmOLiL
         tdzJBodg1h0BQ==
Received: by mail-oi1-f172.google.com with SMTP id c11so7339359oiw.2;
        Sat, 11 Mar 2023 21:41:32 -0800 (PST)
X-Gm-Message-State: AO0yUKVOAS+g8SjMK2KhWwgfjdUpc3VJh6uOU90J3MiC88vy84qkinHf
        jVyAHXCoidSU6+Wp3fofPpR+LTDsxk0KqSjIQEo=
X-Google-Smtp-Source: AK7set/zcE73h0tlnIkJ11cYC/oC8mxS0fxTa2HZr8i4hr3bWbSsrxYj/MH7ble7ct6yZ7xfNwwmjGdKc0Q0HlCbGTY=
X-Received: by 2002:aca:240d:0:b0:384:22aa:f4cf with SMTP id
 n13-20020aca240d000000b0038422aaf4cfmr8805119oic.8.1678599692283; Sat, 11 Mar
 2023 21:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20230306223208.6277-1-bage@linutronix.de> <20230306223208.6277-2-bage@linutronix.de>
In-Reply-To: <20230306223208.6277-2-bage@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Mar 2023 14:40:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJ2FqtRGhwYkUoi1cbqsK16jaGGLiBHWb0G_Mq3kcQdA@mail.gmail.com>
Message-ID: <CAK7LNASJ2FqtRGhwYkUoi1cbqsK16jaGGLiBHWb0G_Mq3kcQdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] builddeb: introduce profile excluding the dbg pkg
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 7:32=E2=80=AFAM Bastian Germann <bage@linutronix.de>=
 wrote:
>
> Enabling CONFIG_DEBUG_INFO implies building the binary linux-image-*-dbg.
> As this increases package build time significantly, one might want to
> exclude it from being built.


Did you confirm if this patch saved the build time in any way?
If so, please provide me with the steps to test it.


>
> Add build profile pkg.$sourcename.nokerneldbg for that package
> so it can be excluded via e.g.
> `make DPKG_FLAGS=3D"-P=3Dpkg.linux-upstream.nokerneldbg" deb-pkg`

The correct command is:

 `make DPKG_FLAGS=3D"-Ppkg.linux-upstream.nokerneldbg" deb-pkg`


-P<profile>                         (without '=3D' for the short option)
       or
--build-profiles=3D<profile>    (with '=3D' for the long option)



I will postpone this because just adding Build-Profiles does nothing.




>
> The name is the same that is used in Debian's linux package since version
> 5.17~rc4-1~exp1.
>
> Link: https://wiki.debian.org/BuildProfileSpec
> Link: https://salsa.debian.org/kernel-team/linux/-/commit/140798ec2789
> Signed-off-by: Bastian Germann <bage@linutronix.de>
> ---
>  scripts/package/mkdebian | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index f74380036bb5..8a7969926e53 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -227,6 +227,7 @@ if is_enabled CONFIG_DEBUG_INFO; then
>  cat <<EOF >> debian/control
>
>  Package: linux-image-$version-dbg
> +Build-Profiles: <!pkg.$sourcename.nokerneldbg>
>  Section: debug
>  Architecture: $debarch
>  Description: Linux kernel debugging symbols for $version
> --
> 2.39.2
>


--
Best Regards
Masahiro Yamada
