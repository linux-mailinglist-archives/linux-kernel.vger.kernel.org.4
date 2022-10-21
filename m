Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A6606FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJUGDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJUGDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:03:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F8238251
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:03:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id be13so3339902lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDsbTrV7BOgBVoj1XA71mqSGkbWCJDrHS/cchibub80=;
        b=lAg6/c7U1UfYC19I4ddmFOeynIJe2/+2wkSXOv45eDCCSeQn4KGZzpZwFoxhEqyYPe
         x98y29xv5fDigIhs12g5m+YynABTkn56UZ4gy0gX44xa4/CbuiBSBN9rtHPbkWF8NsLW
         GgUrCb4VAv8s2ueHyNgErJEoginree7E+4B/5FkQPlz/SlSfpoJ08OTcTgzQA/+7yJtI
         Mlp4GzcRCR8THakGFCNd6MSlfjQDqSn1DeujfHQ3M1NTeeDnM8JELUa3DAtGnUe1mxxZ
         4s7a5dAYi6b+vY1auOcZRQ47djUnMN4yxaEqsALZGdeWX0TQ6hRZOg5mPbl+Qmfo9LIJ
         pphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDsbTrV7BOgBVoj1XA71mqSGkbWCJDrHS/cchibub80=;
        b=UWPxGlFgQpfv76WOLy+jlzdCm+PnCsm9ClkU85EOzwTr18ST00fv0GkUDlfCMunHHK
         Oe9ahkwqM3vkTohM9K/UuvKrfxG8zO8+HraPIZM5A55hTeDYXGwU4XW6JtpKvGtYmrtf
         FzwB8avzbqaPglfACgZUgoKJiQNJlOwMIbMxBuQmPBeQriW7JxhiOqUt6ZsOGufqDCaQ
         myqQEwDzdTeXwnhSdmEvv03eJ/qHXWwtK4sKxzkku+FUfaf+8KFanIswA2D9pWaibpXc
         T/EKkK1BkW9R0MgI/Fg9VKEAA3kru9es7ik4zvRIzJKQRHFeM3Y+J3g1jzYJhkRWhm/S
         hLfw==
X-Gm-Message-State: ACrzQf0CEZ2yaV/waZbXPeZOqZ7dQYuaUCf7rDGedg+euk2EmOcau3gs
        tAgRu+2cTRzo4P3NXtT683gpwpd4T6qitGQZuz1kwg==
X-Google-Smtp-Source: AMsMyM5g7JkRqs7cUFUeK4Yi9ikjg5qG2F+pAECdeB2Sn+a54NXO+8Rii8AXNl9T6+qf0Lhw6VS9usUeP224YTKT56Q=
X-Received: by 2002:a19:c214:0:b0:4a2:34f3:602e with SMTP id
 l20-20020a19c214000000b004a234f3602emr5744043lfc.447.1666332192101; Thu, 20
 Oct 2022 23:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221021025822.64381-1-linyunsheng@huawei.com>
In-Reply-To: <20221021025822.64381-1-linyunsheng@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Fri, 21 Oct 2022 09:02:36 +0300
Message-ID: <CAC_iWj+oKwHkQRKZhELB=5FOj8n-0ZRC7B0uc9F4vF2h7bncHg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: move skb_pp_recycle() to skbuff.c
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        pabeni@redhat.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yungsheng

On Fri, 21 Oct 2022 at 05:58, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> skb_pp_recycle() is only used by skb_free_head() in
> skbuff.c, so move it to skbuff.c.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/skbuff.h | 7 -------
>  net/core/skbuff.c      | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 9fcf534f2d92..28a7b5fbc7b7 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5048,12 +5048,5 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
>  }
>  #endif
>
> -static inline bool skb_pp_recycle(struct sk_buff *skb, void *data)
> -{
> -       if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
> -               return false;
> -       return page_pool_return_skb_page(virt_to_page(data));
> -}
> -
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_SKBUFF_H */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 1d9719e72f9d..9b3b19816d2d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -748,6 +748,13 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>                 skb_get(list);
>  }
>
> +static bool skb_pp_recycle(struct sk_buff *skb, void *data)
> +{
> +       if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
> +               return false;
> +       return page_pool_return_skb_page(virt_to_page(data));
> +}
> +

Any particular reason you are removing the inline hint here?  Doing it
like this will add an extra function call for every packet (assuming
the compiler decided to inline the previous version)

Thanks
/Ilias
>  static void skb_free_head(struct sk_buff *skb)
>  {
>         unsigned char *head = skb->head;
> --
> 2.33.0
>
