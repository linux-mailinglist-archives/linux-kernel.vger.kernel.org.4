Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC375725F57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbjFGM2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjFGM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A113CE65;
        Wed,  7 Jun 2023 05:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA9163706;
        Wed,  7 Jun 2023 12:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E73C4339E;
        Wed,  7 Jun 2023 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686140881;
        bh=Qz6crH1/lu7QrUiSsXrIu8DjMRSudtd/6XGjQPwOYPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YTvigh4q1ri4O4/J+XsDTg1Ew6QeO6/yA8s8DbHCFyT8fv6IC05mYdRNbEZCcIlow
         co1P7LExNUF8kTW4hIAHJVQmzBf8JYUwrbGWKhX9DKI0b6Cu1JvGrDwcspRJjipoEA
         gNZE37ntwkIyA3lkQk1WWXIQ3CrOrU5He14h7lGNSmygfVHnZJeE3pYtqGWAP0+6bR
         S5ap4LlXF98lFx0opGLJ5cQqMOJuQBsuPQM5Qn0WJDW7TMMMdB4lsqcSRMZVjYWV/3
         pB6rckGWTacDvd3SeCwHg2IMuSwu0kAqdUus9G1Ak/785jRPu0Q4VCXAQ9P4OK+ttt
         Wak5XaGqwY1Uw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-19e7008a20aso6619682fac.1;
        Wed, 07 Jun 2023 05:28:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDxhq8xRxRoP+Tp8xnPGSX/8QzwHBSvRgTUKCcR25RsrWpCtx6kv
        ynyg5KvU8dV0FCKlwUurIJqp0aoP+syCJ/Dw5bU=
X-Google-Smtp-Source: ACHHUZ720mjkzxcRx7Sj3r+kQPHquXZBh6ezdgblKHI+slS1YG8wfJ69KUR2pex7sjydJPjXqxSvnNQWOSMLu4LlrUc=
X-Received: by 2002:a05:6870:3844:b0:19f:7312:79f2 with SMTP id
 z4-20020a056870384400b0019f731279f2mr4179931oal.36.1686140880935; Wed, 07 Jun
 2023 05:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230606181936.bw62oyqswo7jomra@google.com>
In-Reply-To: <20230606181936.bw62oyqswo7jomra@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Jun 2023 21:27:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-0P7VwKknX5j=WKhrxXK0uz81srUHnrDO70zmM_O8eg@mail.gmail.com>
Message-ID: <CAK7LNAQ-0P7VwKknX5j=WKhrxXK0uz81srUHnrDO70zmM_O8eg@mail.gmail.com>
Subject: Re: [PATCH] scripts/mksysmap: Ignore __pi_ local arm64 symbols
To:     =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 3:19=E2=80=AFAM Pierre-Cl=C3=A9ment Tosi <ptosi@goog=
le.com> wrote:
>
> Similarly to "__kvm_nvhe_", filter out any local symbol that was
> prefixed with "__pi_" (generated when CONFIG_RANDOMIZE_BASE=3Dy) when
> compiling System.map and in kallsyms.
>
> Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>
> ---


Applied to linux-kbuild. Thanks.



>  scripts/mksysmap | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index cb3b1fff3eee..a7de0f637cc7 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -40,6 +40,10 @@ ${NM} -n ${1} | sed >${2} -e "
>  # arm64 EFI stub namespace
>  / __efistub_/d
>
> +# arm64 local symbols in PIE namespace
> +/ __pi_\\$/d
> +/ __pi_\.L/d
> +
>  # arm64 local symbols in non-VHE KVM namespace
>  / __kvm_nvhe_\$/d
>  / __kvm_nvhe_\.L/d
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
>
> --
> Pierre



--=20
Best Regards
Masahiro Yamada
