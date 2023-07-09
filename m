Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74874C638
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjGIPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjGIPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:31:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B341BDB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 08:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8389060BCC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 15:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD09C433CA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688916670;
        bh=sJQ626PfB3mNnXp3+jOn70AE5kQgiQFZoWeqyBTfR5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HYkcapqJ1hUrPmtEVi8ILMANPAhf0Z9h3xTi8Hvg5JRI7AXTI4FfNVd059sWMRwNL
         /9mkhVXdurtS5OKvy9bzkeAyGy/bm0aHVGdDrNTCWEeMABqhDM3N/IVR+YaMHVoEG+
         ctskZ/FVDfh+BXmN/d39hEttkahCmuLuw59DCW3atyPN0y5f4NdH+4TxgCYfsBJL+s
         MEo20PnMer/0vJ3M5nbEjhLrhZJAuLGxaIImoyUqWmRR4jNBFqiGUQujR/BxKNlJ7D
         zk0tDIfOEHKKRmfV3h5HIwqGpcmKPjNEiSbPZ3+2IXRCnlpQa7zhy2kseOl1SUIA2F
         wSBLbYLCI1g3Q==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so3918127f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 08:31:10 -0700 (PDT)
X-Gm-Message-State: ABy/qLYVuxIaBPlTZqjRMr6Paii8oXBAzvgIWyB/l7ch5sc8tefY5AZk
        yhGygAHxPW0Ys4G1a5bTr+HaStURlEZ8mpjFhj8=
X-Google-Smtp-Source: APBJJlEYmFhvnAuchoWHaiYQQ6v9RXtZhF0CprZCfzIiQe88fn/aqQylldopjq5cdoOm8yuKLEEj4TbZ8ximqK+hB5I=
X-Received: by 2002:a5d:6b49:0:b0:314:327:2ece with SMTP id
 x9-20020a5d6b49000000b0031403272ecemr8688188wrw.61.1688916669116; Sun, 09 Jul
 2023 08:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 9 Jul 2023 23:30:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5P_NgJ5kTQ1iO-eL577D=-COjEZ6u9_OgvrHpWJLqsXw@mail.gmail.com>
Message-ID: <CAAhV-H5P_NgJ5kTQ1iO-eL577D=-COjEZ6u9_OgvrHpWJLqsXw@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
To:     Dong Zhihong <donmor3000@hotmail.com>
Cc:     kernel@xen0n.name, ardb@kernel.org, tangyouling@loongson.cn,
        zhoubinbin@loongson.cn, yangtiezhu@loongson.cn, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 9, 2023 at 9:33=E2=80=AFPM Dong Zhihong <donmor3000@hotmail.com=
> wrote:
>
> This patch tends to fix broken CONFIG_CMDLINE, which is not working with
> CONFIG_CMDLINE_EXTEND or CONFIG_CMDLINE_BOOTLOADER. Some code is absent i=
n
> arch/loongarch/kernel/setup.c, which should handle built-in command lines
> in CONFIG_CMDLINE. The absence of such code causes CONFIG_CMDLINE not
> working if CONFIG_CMDLINE_EXTEND or CONFIG_CMDLINE_BOOTLOADER is set to Y=
.
> CONFIG_CMDLINE_FORCE is not affected.
How to reproduce? If you use UEFI firmware, this is handled in
drivers/firmware/efi/libstub/efi-stub.c; if you use non-UEFI firmware,
this is handled in drivers/of/fdt.c.

Huacai
>
> Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
> ---
>  arch/loongarch/kernel/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 78a00359bde3..504218b94879 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -335,6 +335,22 @@ static void __init bootcmdline_init(char **cmdline_p=
)
>         }
>  #endif
>
> +#ifdef CONFIG_CMDLINE
> +       /*
> +        * If CONFIG_CMDLINE_BOOTLOADER is enabled then we use thei built=
-in
> +        * command line if no command line given, or we append given comm=
and
> +        * line to the built-in one if CONFIG_CMDLINE_EXTEND is enabled.
> +        */
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
> +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> +               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +               strlcat(boot_command_line, init_command_line, COMMAND_LIN=
E_SIZE);
> +       }
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0=
])
> +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> +#endif
> +
>  out:
>         *cmdline_p =3D boot_command_line;
>  }
> --
> 2.25.1
>
>
