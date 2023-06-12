Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1303572C472
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjFLMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjFLMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:37:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7023E4A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:37:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f81b449357so9697485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686573467; x=1689165467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HYFV0fs2unx0YwlWnT8y6A5i2r7XXpcGElqyKsNkTI=;
        b=hyObgmEqArBRn2iowP3bAlDM73zmzp4lo0ldNMHo9QttY0sup1fzMNnakHOjwMMYsi
         8vR7rkaAboWwchzhpSAKaPYlLo31MsEpaHghk5MPfh4D9grMmBnOSL5Xyb8C7QF4+ZCw
         EUS/w5LI3LYHijKHJnzTy5GmeB7e5kirPauOlWVqm13lb3Wt5jk3rICaClW27FHXqAze
         LHOMIm9CnwYhq6NbeHEV+mg3+GhSju1AW8yWLbfB0/sjgRYMf7HOHx64H9T8DgL7nV7t
         XqN2Cog9OD3/GB0LWHrwXxMCf1T7/ONuO3Ve7RiYe4GS6TU6FAgZCjPIg5FvRW7AjlIM
         /dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686573467; x=1689165467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HYFV0fs2unx0YwlWnT8y6A5i2r7XXpcGElqyKsNkTI=;
        b=e334PsU5jQaVApbSE13gX6rvOIdBitMcBGbJZes4I0dY3jdmvzAQ4bv1qB5EdXtqje
         0zAQpyu5aTpuZEafUA3Gf9G9BSEIbHaCuGNcWMi8uVIIhpu0gWb8yGEnLoOJW6PcfJmf
         YicCe8Hvm+2kDLOciILlxCR73DoTfjSOqBGho4E0YjlbvXgJ7kgifCGEtibDLwn6grhi
         OaD1cpzxgDd4R2XwXAbxOgNfBiiL+kBoF07yg8sOnVEk8Zt6Tr4hxPsKZBclpQ6Edk0H
         ICzZq1KV6nUeBSO9rOdvalaIlBL7nURp94UtDidhTAfWefCeHcaQsgMGzBHrchJ1cUOP
         q6yw==
X-Gm-Message-State: AC+VfDzhLGu7IkrzlDH7YWSOd9yYhl3zhSegm8JHxh0xgE52ITXmg3hg
        sTAZX2qSqpzCYVlYlOm00USijETbhfaK0Xp4ZZIgW63jp24ywyoB
X-Google-Smtp-Source: ACHHUZ6zMagKJKpdgZAj1RJ5tv9Uv6sLTi8MQzdpL81Zbtb8ycqQND5DUJI+le846M3NV+do0J12vPmMLWNTFMzX1eQ=
X-Received: by 2002:a7b:c4cd:0:b0:3f7:f8d1:122 with SMTP id
 g13-20020a7bc4cd000000b003f7f8d10122mr6910805wmk.20.1686573467057; Mon, 12
 Jun 2023 05:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230609071455.120995-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230609071455.120995-1-jiapeng.chong@linux.alibaba.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 12 Jun 2023 14:37:36 +0200
Message-ID: <CAHUa44E8CoELCPr6EXRf+CgcfK7Jj6sJA061QGQgkGMiOL7A1A@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Use kmemdup() to replace kmalloc + memcpy
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 9:15=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> ./drivers/tee/optee/smc_abi.c:1542:12-19: WARNING opportunity for kmemdup=
.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5480
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/tee/optee/smc_abi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Looks good, but would you mind elaborating a little in the commit
message? A sentence explaining what's going on should be enough.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 3861ae06d902..d5b28fd35d66 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1541,12 +1541,11 @@ static int optee_load_fw(struct platform_device *=
pdev,
>          * This uses the GFP_DMA flag to ensure we are allocated memory i=
n the
>          * 32-bit space since TF-A cannot map memory beyond the 32-bit bo=
undary.
>          */
> -       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +       data_buf =3D kmemdup(fw->data, fw->size, GFP_KERNEL | GFP_DMA);
>         if (!data_buf) {
>                 rc =3D -ENOMEM;
>                 goto fw_err;
>         }
> -       memcpy(data_buf, fw->data, fw->size);
>         data_pa =3D virt_to_phys(data_buf);
>         reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
>         reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> --
> 2.20.1.7.g153144c
>
