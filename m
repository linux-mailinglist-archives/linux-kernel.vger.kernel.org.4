Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA06F996A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjEGPkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEGPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:40:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95946A79
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:40:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso5541987a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1683474009; x=1686066009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5Pp7plOXKov3HGN3A57TzbkMhjOejQetUlM+mZ2KPA=;
        b=H9B6ObqHh+7v0vLYifvsDy4ssZ2kW9pF8G+91JdtkDQja6uX1QfeQe2tGfxl0FbIzL
         s5xZ7s3dLjcDvjym1+TSkBt/xcKlccBO0a1udA/hEV9DP2K65JfHA7aAxIiR46sQHAxf
         XDp7QJnLtmXQoypdYxm+/oLrIkyzDVSIAVmULuL3+wJ90z7NsFZdxgIrWDkbWIUljbH7
         csPVS+5rYdO3RGj1kTx80Zo9SgeybNN/zpbWfx2ccVqgkw1hdIwqyCrobkKWvfGinBzA
         pSucBod1cpAuYp0UPHtn+XS4fUjoFL5jj9cJl2VlDRpGWVviMc8HPGbmln3SxoBLvAMd
         0Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474009; x=1686066009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5Pp7plOXKov3HGN3A57TzbkMhjOejQetUlM+mZ2KPA=;
        b=UZbYAoKCTmWQ7ipxoO0N0PMOmymn6OLrVd+hesST/GecmEbNgUKw5LnT1R9Wqqjr9J
         2LzSHH5xa6ECRUcVUPRWEJxhjjkvUCGO5QrAdUwt9BfBVUMi0tcN2rqES2Jex2w2LDvE
         f5IqithoWjXxVP8YrQKO78Vo9bDsT7DADngUgEL18560mK9Q7HikgSuxaIBI3Ckdwx2M
         o+o/jWCmPSToUj6RdGy2f6Awrh79TpPEBhfbEDoVGSoYJobbNjoueP2zFbhMhNsBlX7v
         2xG2iH7xpHtoPzbmQrVoRxfOXkNQ63i8Ifd/rVgXG6uzwPa686GwZTZbL6IE7LH1Vng0
         ZVmQ==
X-Gm-Message-State: AC+VfDxLkOIJAWtbJLE2S4JrwmzH/uWFz7ywUFLVWkvSJKlpBFINnF6o
        I72yf+KdheALznyicOwW0sqq5/Ggh9cW2zQ99vhfMQ==
X-Google-Smtp-Source: ACHHUZ6bkFYh4m/GEp+qUFWxV6rN57l8XbRSNZJ7xxL5HglrhlV+/GXGcEpby4YAmQL6/KbQAvkAK8y0Uo0XKMN5+u8=
X-Received: by 2002:a17:907:7f25:b0:94a:937a:58f1 with SMTP id
 qf37-20020a1709077f2500b0094a937a58f1mr8422433ejc.1.1683474009148; Sun, 07
 May 2023 08:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <202305061711417142802@zte.com.cn>
In-Reply-To: <202305061711417142802@zte.com.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 7 May 2023 21:09:57 +0530
Message-ID: <CAAhSdy0xBiyXz903xmK4e4n4tknjW4aBTjuGe4-v1xat5hqFmA@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: use bitmap_zero() API
To:     ye.xingchen@zte.com.cn
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org,
        sergey.matyukevich@syntacore.com, dylan@andestech.com,
        ajones@ventanamicro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 2:42=E2=80=AFPM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> bitmap_zero() is faster than bitmap_clear(), so use bitmap_zero()
> instead of bitmap_clear().
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/mm/context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 12e22e7330e7..217fd4de6134 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -67,7 +67,7 @@ static void __flush_context(void)
>         lockdep_assert_held(&context_lock);
>
>         /* Update the list of reserved ASIDs and the ASID bitmap. */
> -       bitmap_clear(context_asid_map, 0, num_asids);
> +       bitmap_zero(context_asid_map, num_asids);
>
>         /* Mark already active ASIDs as used */
>         for_each_possible_cpu(i) {
> --
> 2.25.1
