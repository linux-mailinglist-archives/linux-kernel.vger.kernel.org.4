Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7844725F53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbjFGM1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbjFGM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:27:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76CBE65;
        Wed,  7 Jun 2023 05:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7283B6365F;
        Wed,  7 Jun 2023 12:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F4DC433EF;
        Wed,  7 Jun 2023 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686140848;
        bh=rYNeihmRmo69wMB7UeZnTSVlzTtJvq708KV1rnsqrnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oXpCoGGid7jdVikkcxY8xeJ8jiCYaQZLC7F9dsWF6CpSKh0F7QkkurvIXSzvs6cul
         ajTuYf4R+Hy09iqgG1QfHkpqa5RklWs2dPYutlVgtD4hS2rBGQvG4uo5LooDFRMeR6
         zQUEy0g1iqn5m/VMFXqpm6AWwBmMLnAXAHaEc93S/KaQYfyyKxWclSmu/C8eNB4vC8
         M6da9LjJVcSg+xKXw/apxsw3Uq0omXvpsmBLARrKXv6/Ro8EVTJq4kmOZE/x9q9UJ6
         Gj+W4mYpvMbF4/MCcSqaX4xpnPIyYRIs2Qag2qPmuG7dX5ObIODB2qu8SYZTw2i6AQ
         CXvNcs0oBoxmg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-39aa825c299so354669b6e.0;
        Wed, 07 Jun 2023 05:27:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDzk7Emxm5L2xoTlU1sKAgSTS9CtewTOeU21+xIkSb6sbP5UL5ox
        I47gtiBbZ9dWTwF3O5YQfwh05cmcu6D0n5LGbSk=
X-Google-Smtp-Source: ACHHUZ6rwcFeBDf7wzuX6Rk34HUD7lebnW50R4mMJFC7FCEH4jrP3g0mg5xOjnQsBRZfttj9cIIuHhpDyRmkQHNWrxs=
X-Received: by 2002:aca:b5c2:0:b0:39a:1ceb:3ec4 with SMTP id
 e185-20020acab5c2000000b0039a1ceb3ec4mr7264308oif.29.1686140848154; Wed, 07
 Jun 2023 05:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230606173553.v7lckyxrcsotanm5@google.com>
In-Reply-To: <20230606173553.v7lckyxrcsotanm5@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Jun 2023 21:26:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNTaTA8x-nNAGSOnYhZZUks_QY2VVNB-W1LJ2EnjUDDg@mail.gmail.com>
Message-ID: <CAK7LNAQNTaTA8x-nNAGSOnYhZZUks_QY2VVNB-W1LJ2EnjUDDg@mail.gmail.com>
Subject: Re: [PATCH] scripts/mksysmap: Fix badly escaped '$'
To:     =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 2:36=E2=80=AFAM Pierre-Cl=C3=A9ment Tosi <ptosi@goog=
le.com> wrote:
>
> The backslash characters escaping '$' in the command to sed (intended to
> prevent it from interpreting '$' as "end-of-line") are currently being
> consumed by the Shell (where they mean that sh should not evaluate what
> follows '$' as a variable name). This means that
>
>     sed -e "/ \$/d"
>
> executes the script
>
>     / $/d
>
> instead of the intended
>
>     / \$/d
>
> So escape twice in mksysmap any '$' that actually needs to reach sed
> escaped so that the backslash survives the Shell.



You are right. Thanks for catching this bug.

Applied to linux-kbuild. Thanks.




>
> Fixes: c4802044a0a7 ("scripts/mksysmap: use sed with in-line comments")
> Fixes: 320e7c9d4494 ("scripts/kallsyms: move compiler-generated symbol pa=
tterns to mksysmap")
> Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>
> ---
>  scripts/mksysmap | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index cb3b1fff3eee..ec3338526102 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -32,7 +32,7 @@ ${NM} -n ${1} | sed >${2} -e "
>  #  (do not forget a space before each pattern)
>
>  # local symbols for ARM, MIPS, etc.
> -/ \$/d
> +/ \\$/d
>
>  # local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
>  / \.L/d
> @@ -41,7 +41,7 @@ ${NM} -n ${1} | sed >${2} -e "
>  / __efistub_/d
>
>  # arm64 local symbols in non-VHE KVM namespace
> -/ __kvm_nvhe_\$/d
> +/ __kvm_nvhe_\\$/d
>  / __kvm_nvhe_\.L/d
>
>  # arm64 lld
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
>
> --
> Pierre



--=20
Best Regards
Masahiro Yamada
