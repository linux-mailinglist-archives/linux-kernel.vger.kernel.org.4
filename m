Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3E6E3627
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDPIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1678CC;
        Sun, 16 Apr 2023 01:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E76160B1B;
        Sun, 16 Apr 2023 08:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20DBC433D2;
        Sun, 16 Apr 2023 08:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681634796;
        bh=Cz2IboxZAwC0INW1nTo5GwwwzRwKMpn2elK8ol7BpTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jx1XSUUMm2hxZcDDmE3al8pYgobwzjN3uAxDE/pe1fkxazF2W/aiJkhzRrexfO6Au
         RKlH3NdbKvr3Sm7LGUMHiWUuFffIXrzCrEn0GSmvAOle1JNFT5/Izy9aLbiikiJfKq
         sX0Ak6Dg6sHLqeBCdPcmnJlrdEbD7IdfVeNHB1lTnvvv6Zx9FaHPl72oxv92G5d9bQ
         TrgOzNxOcWlakTwDhOIM7u+hxCLonqlPfyaW5BW4c1tR8GOzvWybkif3h9g4IdSuZ+
         3JtBx937lLy6A/i5lsTg63f7xIZo8IymrqE4IaZe1LSUg2yEMSmJABaKmXeQJIp9uD
         +tbl443DcRz3w==
Received: by mail-oo1-f51.google.com with SMTP id bv13-20020a0568201b0d00b0053e3ccf739cso2775145oob.10;
        Sun, 16 Apr 2023 01:46:36 -0700 (PDT)
X-Gm-Message-State: AAQBX9drOyYTqwNVf/W3CE60P/MIWKt8KsXfK6s3kQJChCYJHU2a9zyV
        RUupAgxKiNa3uJaQwwxGEQOPFDzHl8C71OLXZBo=
X-Google-Smtp-Source: AKy350acBA0ur9ls26nmcJikvelL4bOWFBVWl9xRLubZrOtMDm9a9sju3wd+HktZJLRFo8nCHlMwIuCBztiDRzXUWb4=
X-Received: by 2002:a4a:be15:0:b0:546:34fb:da95 with SMTP id
 l21-20020a4abe15000000b0054634fbda95mr294073oop.1.1681634795909; Sun, 16 Apr
 2023 01:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230320230534.50174-1-bgray@linux.ibm.com>
In-Reply-To: <20230320230534.50174-1-bgray@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 16 Apr 2023 17:45:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARH-xrxFz0Y8BZPa=xE9DFkUevWM3XZTN1DioCGJzeJcg@mail.gmail.com>
Message-ID: <CAK7LNARH-xrxFz0Y8BZPa=xE9DFkUevWM3XZTN1DioCGJzeJcg@mail.gmail.com>
Subject: Re: [PATCH] init/initramfs: Fix argument forwarding to panic() in panic_show_mem()
To:     Benjamin Gray <bgray@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 8:06=E2=80=AFAM Benjamin Gray <bgray@linux.ibm.com>=
 wrote:
>
> Forwarding variadic argument lists can't be done by passing a va_list
> to a function with signature foo(...) (as panic() has). It ends up
> interpreting the va_list itself as a single argument instead of
> iterating it. printf() happily accepts it of course, leading to corrupt
> output.
>
> Convert panic_show_mem() to a macro to allow forwarding the arguments.
> The function is trivial enough that it's easier than trying to introduce
> a vpanic() variant.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>


Applied to linux-kbuild.
Thanks.




>
> ---
>
> After sending these patches [1] I wondered why the kernel accepted a
> corrupt archive. The streaming parser makes it difficult to see
> where to add a completeness check (possibly can assert the state is
> Start or Reset at the end?), but adding an error() to cover my issue
> revealed that the error message was never printed.
>
> [1]: https://lore.kernel.org/all/20230320040839.660475-1-bgray@linux.ibm.=
com/
> ---
>  init/initramfs.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/init/initramfs.c b/init/initramfs.c
> index f6c112e30bd4..e7a01c2ccd1b 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -60,15 +60,8 @@ static void __init error(char *x)
>                 message =3D x;
>  }
>
> -static void panic_show_mem(const char *fmt, ...)
> -{
> -       va_list args;
> -
> -       show_mem(0, NULL);
> -       va_start(args, fmt);
> -       panic(fmt, args);
> -       va_end(args);
> -}
> +#define panic_show_mem(fmt, ...) \
> +       ({ show_mem(0, NULL); panic(fmt, ##__VA_ARGS__); })
>
>  /* link hash */
>
>
> base-commit: 065ffaee73892e8a3629b4cfbe635697807a3c6f
> prerequisite-patch-id: 6e3cfc6bf9c5686ad29c7feed8e283d30b1957fd
> prerequisite-patch-id: 933a7bd2f29223dba7f2cac7e9aa72aae730292d
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
