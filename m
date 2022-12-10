Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13FE648F40
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLJOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 09:54:07 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E222C1A053;
        Sat, 10 Dec 2022 06:54:06 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3b5d9050e48so88240417b3.2;
        Sat, 10 Dec 2022 06:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nwNMp0YAJGSQ7QKo5n56cmMH5UND+SgKbR3yvLQLo2E=;
        b=NES8jTbwBCd6vpzlC4z4+szxha9oaVY0zluEA5jek8x6wxfyr8/6LXllc3mdXa4RAD
         4+SBu38pXcD45beSY2tIFKophRRBB+Cy4j3VSxn7fPC7cmsCBtCza+uApZuap2f7CDiJ
         pP0Hu5pZeUM2Ac+4cL+AoguM3nktWEOgCtt6JYcXFVkWcznp/lBGKgefTGSQ3/793dkg
         p4mrQbWdTx/2jo0NtjbNZmQNvaCFOwCYUapzQeF6IMw8ZSrgqDmSfBIxkA9GikZ4t7cX
         +nWRwST/1Gb6Ctb3yHG5hgGf42UX5qpRL+C9l2A+Idfr6EFL8SSlK+9UzQbEh7SDWt7t
         h4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwNMp0YAJGSQ7QKo5n56cmMH5UND+SgKbR3yvLQLo2E=;
        b=5RcMgsimDC6VLCOPmFurngasv8ENoEzySPOJ651k+bdhE/KcY6tFUBZQekVqQewBq+
         +n7KygRoXJE3ius+ljv53pcJOC3ngYPnFo0yR6M+989pRqm5ftThSrC71STDGLK7VDFL
         shsrK4xZDtj7Ae+meR11aQoNzktoKcWK1FKahIcuM2XjqlZ8bno/WXwDG9XAS+8wbp9w
         treEQ7v0zWx8agHMfdAbwOoZIBOgJpME3b4tyg6xtWozfWJjod4ZcxJaL2wWQLPR2P5t
         z7JfqqaXE86U8I3kC/YssaNYY3LCNvPvkl4smxXN+Ft+htkBuxRm97Jm4j3gImrOUgbF
         uKfw==
X-Gm-Message-State: ANoB5pl9TYXu8DdYF4CY56HEljFcMWE7ac0vjh++pokyTSNKbRO9b0il
        d08OGJZoWCBFdp4T9agrkzkX6VRj7M8RRV1EviF5/ZDu0Gk=
X-Google-Smtp-Source: AA0mqf4ZN2tQdTdKKPfosPY967se21wGX1Ji/RelVipfjmWvRseo/aPjtgausjHGD/b9gSLcQE4NyP9Qkpfr6NerwBw=
X-Received: by 2002:a81:94f:0:b0:3da:3a9a:ef5d with SMTP id
 76-20020a81094f000000b003da3a9aef5dmr33020129ywj.504.1670683693882; Sat, 10
 Dec 2022 06:48:13 -0800 (PST)
MIME-Version: 1.0
References: <7946a26c6e53a4158f0f5bad5276d8654fd59415.1670673147.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7946a26c6e53a4158f0f5bad5276d8654fd59415.1670673147.git.christophe.jaillet@wanadoo.fr>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 10 Dec 2022 06:48:02 -0800
Message-ID: <CAMo8BfKCv9j-ftKWU+B27g1oHBB_=EZhGBH7qymyVAeF10JcnQ@mail.gmail.com>
Subject: Re: [PATCH v1] spi: xtensa-xtfpga: Fix a double put() in xtfpga_spi_remove()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Dec 10, 2022 at 3:52 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'master' is allocated with devm_spi_alloc_master(), there is no need to
> put it explicitly in the remove function.
>
> Fixes: 478cc2fc3dd7 ("spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/spi/spi-xtensa-xtfpga.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
> index 2fa7608f94cd..271ae98f441c 100644
> --- a/drivers/spi/spi-xtensa-xtfpga.c
> +++ b/drivers/spi/spi-xtensa-xtfpga.c
> @@ -123,7 +123,6 @@ static int xtfpga_spi_remove(struct platform_device *pdev)
>         struct xtfpga_spi *xspi = spi_master_get_devdata(master);
>
>         spi_bitbang_stop(&xspi->bitbang);
> -       spi_master_put(master);

This put is matching the get in the spi_bitbang_start.
It was discussed here:
https://lore.kernel.org/linux-spi/CAMo8BfJaD7pG_iutY8jordysjChyzhTpVSqpxXh3QoZsj2QmaQ@mail.gmail.com/

-- 
Thanks.
-- Max
