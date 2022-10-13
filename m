Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644AB5FDD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJMPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:37:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C9BE2C8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:37:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y205so2454296yby.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gFTFokgNHTGaQylOsGEna9aC1ySQtkamEeN27nYYtMo=;
        b=ZfLz0QdiG9JBjp7/wEbV0kPjVt5hjZm/ZfmjnY7krnW3YJ51i4IZNCm/42GSkTLfsi
         96OYRIV113x7VnJuK0maHfWcnG8QFdVZIjHe/0PNePOvzphvuxlgmYwqSAd+Sb5FUOSd
         XpcqG7xnc/ayC4mGz7aPyPDM+koPWVNEfndV/AQr7XoatkXvw/DbdiOOgPATeZWELPch
         loJ5aCEYuTaZiSCH6eohOgmCB3LoCp7/MYBx/4P4+x8XF+v3ZK/nY38AoaHpgIP8aHMz
         241UX7NA0+zvmIw4JsTmNUbAurwfxxl+Vn8spwjRfKusHAORCRndam+Fh33IAn3iSh0w
         nOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFTFokgNHTGaQylOsGEna9aC1ySQtkamEeN27nYYtMo=;
        b=Ayh3heMZRbBYb8OZTfrIXuJyR7dKPhcL1SWcNcxi69Xc2/5iGYOadFwf84JNoS0YSm
         DYFzjLrqn6x2oJptYJQpMfQLb77exQUJwQWYA0QnKAny6dfcEX8yNYPi7GheTUxB3u8M
         QocPzsq1+UKjGLOYkBqV6TX2ki7E0553fhOYaVH5N0f7ogPpfF5NsIYbYXX4NEa3c3BV
         XLNqpizzFsgq1R08wwN1aA73fe13UY4VLYeo4zMOcr9wjboEhzVqT1tY5AlNRQvS2tZl
         CLho1G+Ah7DXvHJC+/mHQybRdjd+3XFG4++/y6NGSgarzXGeRrlJ5eT128kHZ3dnU4YU
         rwWw==
X-Gm-Message-State: ACrzQf16ygC13rbDTDkcfLtOjD3VQZfcTRurszQ9vXyz6glePYk1YyBl
        FAan+g05+oBphqfE7x7MBv2Xac7u3WqlnXbBBkmdtQ==
X-Google-Smtp-Source: AMsMyM6rJSajVfrXSduoobUcD898rHe8tr9JXQscVFW1kDtIR1T+kP3FtiVCYE63367gGKceFY3ty5zTsJzzc9y3p54=
X-Received: by 2002:a25:ccd0:0:b0:6bf:d596:72ff with SMTP id
 l199-20020a25ccd0000000b006bfd59672ffmr542750ybf.598.1665675439989; Thu, 13
 Oct 2022 08:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221013151901.29368-1-cppcoffee@gmail.com>
In-Reply-To: <20221013151901.29368-1-cppcoffee@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 13 Oct 2022 08:37:08 -0700
Message-ID: <CANn89iKJQCmEPxf=296_dGt9Wb3MD=0mp0vP6X4exWUPML=UUw@mail.gmail.com>
Subject: Re: [PATCH] net/atm: fix proc_mpc_write 1 byte less calculated
To:     Xiaobo Liu <cppcoffee@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 8:19 AM Xiaobo Liu <cppcoffee@gmail.com> wrote:
>
> Then the input contains '\0' or '\n', proc_mpc_write has read them,
> so the return value needs +1.
>
> Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
> ---
>  net/atm/mpoa_proc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/atm/mpoa_proc.c b/net/atm/mpoa_proc.c
> index 829db9eba..444ceda60 100755
> --- a/net/atm/mpoa_proc.c
> +++ b/net/atm/mpoa_proc.c
> @@ -224,8 +224,11 @@ static ssize_t proc_mpc_write(struct file *file, const char __user *buff,
>                         free_page((unsigned long)page);
>                         return -EFAULT;
>                 }
> -               if (*p == '\0' || *p == '\n')
> +
> +               if (*p == '\0' || *p == '\n') {
> +                       len += 1
>                         break;
> +               }
>         }
>
>         *p = '\0';
> --
> 2.21.0 (Apple Git-122.2)
>

Hi Xiaobo

Can you submit a v2, with this added tag ?

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Also, I would switch to something cleaner like

diff --git a/net/atm/mpoa_proc.c b/net/atm/mpoa_proc.c
index 829db9eba0cb95ac9cfe775e8eaad712943a8dbe..df530e9725fa63820a7adcd44e750db0733f9d94
100644
--- a/net/atm/mpoa_proc.c
+++ b/net/atm/mpoa_proc.c
@@ -219,11 +219,12 @@ static ssize_t proc_mpc_write(struct file *file,
const char __user *buff,
        if (!page)
                return -ENOMEM;

-       for (p = page, len = 0; len < nbytes; p++, len++) {
+       for (p = page, len = 0; len < nbytes; p++) {
                if (get_user(*p, buff++)) {
                        free_page((unsigned long)page);
                        return -EFAULT;
                }
+               len++;
                if (*p == '\0' || *p == '\n')
                        break;
        }
