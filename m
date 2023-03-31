Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E576D1FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjCaMN1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCaMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:13:25 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779271D91C;
        Fri, 31 Mar 2023 05:13:24 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id r187so27127767ybr.6;
        Fri, 31 Mar 2023 05:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680264803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irpSu+IzrzZsL05oxfBVtE5Yij4YVLH4jY0USOdOGRg=;
        b=XvO4F68pKkaoPW7tk+PwLIzkBm1uvYotKT8Owhq1e3FB0Xmfd5vnN5kjprXOvkBNS+
         7hcseTz3jKIUMPttx5fPGD5PLCHdMcH2tiEiExKvMyHgReMiHspRi0PBfLBwMwfvEmYq
         DTDdqwaPBewRaTG1pG8V5F4kuNGHvizUxQkcQFmQbscJvMGfVi0EKlO9ZQIfDV0rNpri
         RNyXtE278NhNE+SjA+ElKTF3q+6JL+JkxzJ6ldbrAetotO4ZcbpAA4TaLFWwQGGLMj7+
         rvZEEeTNswjdrlj+Yylmn34dhIWmHjdt2oTsynPW1aQXKT4Mt2pOi7Kt6bECjIkLtkns
         8E2w==
X-Gm-Message-State: AAQBX9cj+3SpRj0otsva65N8w/r3OIYs3di2M53wFA4Kbawc+YIwx8nh
        KJpMYkFmV9z31v1kNeA5RVQJNTLATnFffZ1i
X-Google-Smtp-Source: AKy350ZYmb4WNdSW5o4WD1YN8nAJUNS84uIcOgqmEQzvOj2Aefcc+par1Q7tAzpcduC3uC/W0YgvCQ==
X-Received: by 2002:a25:ad05:0:b0:b53:c037:1081 with SMTP id y5-20020a25ad05000000b00b53c0371081mr23702289ybi.9.1680264803361;
        Fri, 31 Mar 2023 05:13:23 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w193-20020a25dfca000000b00b7767ca7472sm538670ybg.15.2023.03.31.05.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 05:13:22 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id j7so27148899ybg.4;
        Fri, 31 Mar 2023 05:13:22 -0700 (PDT)
X-Received: by 2002:a25:24c3:0:b0:a02:a3a6:78fa with SMTP id
 k186-20020a2524c3000000b00a02a3a678famr13829192ybk.12.1680264802288; Fri, 31
 Mar 2023 05:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230331095545.31823-1-lidaxian@hust.edu.cn>
In-Reply-To: <20230331095545.31823-1-lidaxian@hust.edu.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Mar 2023 14:13:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5guFbo76nq27aZjWsYqneOfGNf0Ozyh0C53+VgnXgXw@mail.gmail.com>
Message-ID: <CAMuHMdV5guFbo76nq27aZjWsYqneOfGNf0Ozyh0C53+VgnXgXw@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: renesas-soc: release 'chipid' from ioremap()
To:     Li Yang <lidaxian@hust.edu.cn>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dan Carpenter <error27@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On Fri, Mar 31, 2023 at 12:14 PM Li Yang <lidaxian@hust.edu.cn> wrote:
> Smatch reports:
>
> drivers/soc/renesas/renesas-soc.c:536 renesas_soc_init() warn:
> 'chipid' from ioremap() not released on lines: 475.
>
> If soc_dev_atrr allocation is failed, function renesas_soc_init()
> will return without releasing 'chipid' from ioremap().
>
> Fix this by adding function iounmap().
>
> Fixes: cb5508e47e60 ("soc: renesas: Add support for reading product revision for RZ/G2L family")
> Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
> Reviewed-by: Dan Carpenter <error27@gmail.com>

Thanks for your patch!

> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -471,8 +471,11 @@ static int __init renesas_soc_init(void)
>         }
>
>         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> -       if (!soc_dev_attr)
> +       if (!soc_dev_attr) {
> +               if (chipid)
> +                       iounmap(chipid);

We don't really care, as the system is dead at this point anyway.

>                 return -ENOMEM;
> +       }
>
>         np = of_find_node_by_path("/");
>         of_property_read_string(np, "model", &soc_dev_attr->machine);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
