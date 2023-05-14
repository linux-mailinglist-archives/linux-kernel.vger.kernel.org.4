Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C564701B52
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjENDJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENDJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D51BDC
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 20:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 987C860989
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 03:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CECEC433D2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 03:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684033742;
        bh=tn/b5nGJCsepGZi2dbYA45zwbk8oczOejMOPqJtpC7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VOBOZyxJKKyHOmtkUljxhyfXvdzH3+SezeVJLpK1eKjgqkAkkvynaEhr+2qQ/8mTF
         8M+JXtwOT2gC5DaOU/y2AAQDlMh28y7PH7D9atCL2HntpStS5RZY0Az/WJZXyFixYi
         zAPDPwUz3MT+kXmO1yoAxnh18Uxv8k9G4Jk+jn/LF0y9Umb05pTTnaHUMCGe4UaaKq
         nxFMMfk6vaJ1ZfQ7KHvN2OeMa+WtJwe4gLX6srNRl+psJ5uPdanm7kmLAuGJbAPU3Q
         C+ro9LPv+zGvhotpdLvrO4Xajq00vSQsix8yX1vudaMZ2+4xG1XdRVc4rkF+MMsTC0
         t7hevlSNfe8YQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9659443fb56so1793227966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 20:09:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDxN6+DXAeiwNjJfs9EMhDqALIIk/awZj6wCGveH0pzluPed70Dn
        b1VKbt3d1tcJwJ27OmCtDILhhI3NDrdji84Fw1E=
X-Google-Smtp-Source: ACHHUZ6E4Jt1x4ZkdyPgRQks/D1qMhCbmJDBp7GH1/QQSJgaRyNJOwWuuJ3cDuT6TWOQryBV1SvkOcQcTlNxKjfDj0I=
X-Received: by 2002:a17:907:97d0:b0:969:7739:2eb7 with SMTP id
 js16-20020a17090797d000b0096977392eb7mr20654208ejc.4.1684033740317; Sat, 13
 May 2023 20:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <CY5PR12MB64557005ECDAFFC89FC8C7B3C67A9@CY5PR12MB6455.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB64557005ECDAFFC89FC8C7B3C67A9@CY5PR12MB6455.namprd12.prod.outlook.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 14 May 2023 11:08:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H48t8tDmWoZOSqx06HwwXKY1CR=X+hi0o_ok6gSu6dQSg@mail.gmail.com>
Message-ID: <CAAhV-H48t8tDmWoZOSqx06HwwXKY1CR=X+hi0o_ok6gSu6dQSg@mail.gmail.com>
Subject: Re: [PATCH] loongarch: fix debugfs_create_dir error checking
To:     mirimmad@outlook.com
Cc:     skhan@linuxfoundation.org, Immad Mir <mirimmad17@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Hi, Immad,

On Sat, May 13, 2023 at 10:46=E2=80=AFPM <mirimmad@outlook.com> wrote:
>
> From: Immad Mir <mirimmad17@gmail.com>
>
> The debugfs_create_dir returns ERR_PTR incase of an error and the
> correct way of checking it by using the IS_ERR inline function, and
> not the simple null comparision. This patch fixes this.
>
> Suggested-By: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
>  arch/loongarch/kernel/unaligned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/un=
aligned.c
> index bdff825d2..be2a5bdc5 100644
> --- a/arch/loongarch/kernel/unaligned.c
> +++ b/arch/loongarch/kernel/unaligned.c
> @@ -485,7 +485,7 @@ static int __init debugfs_unaligned(void)
>         struct dentry *d;
>
>         d =3D debugfs_create_dir("loongarch", NULL);
> -       if (!d)
> +       if (IS_ERR(d))
Maybe we need IS_ERR_OR_NULL() here?

Huacai
>                 return -ENOMEM;
>
>         debugfs_create_u32("unaligned_instructions_user",
> --
> 2.40.0
>
