Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051895F7B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJGQTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJGQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:19:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056D12BB82;
        Fri,  7 Oct 2022 09:19:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id h10so3362940qvq.7;
        Fri, 07 Oct 2022 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9cdGYVpBBAAKU3yol2FW15QDNHv3yCmJl4fQ+xSV9nc=;
        b=nLpYCuORWPCCcxWfmPrbQFT4nbvFPF3TjcIxwzr39H9a/3yN9yoCvHNFSRhfxmIUx3
         SsRv09da1cL7GXJLCeZNXa8jIBXuz7AVGywfRawnrte7l4hBnGVVGbKhAUuQlmbr+Ln+
         rSESapqZAbaTyaj9Xg8bOH/1r0EE48oMR2RmbpbcGQIdeYguilqj7gtIGJ4xNdvzjONE
         TeK/A4pZqMrSvHdLL5LoNkGOqZtIORcVcJCp5/CbUM52kRNOTLkJCO16oMlj3Ti37O1x
         +cF6A4V0A1CCDcocTbyuT3qTBN+lEww92wKI4JjwYxs8EJxKVhX1qfiL8rzIoSoT5w8j
         cnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cdGYVpBBAAKU3yol2FW15QDNHv3yCmJl4fQ+xSV9nc=;
        b=mhUpR27Knjpdgl7NjRN1gLUwt63AcFtGHPzGLlEnOkCJpBkRirgq/tplNudQtCeiYv
         OQMm1kTbbe9y88JxNFXpUlijSA6FRYeM5rfG2EhrmHmGAmQ/vzNw+E2WhXsGX9VeBTjx
         5RIngiMci6fPptayTwJsFmgKsBgV8uPQ/PWeFpcTvRGP8gFkUqBQgdbnIbs28C4NRTDF
         ZikH2FleABBdnn5Lffr/Tqc/Q914GkY7lbC8r9LLyDn9IEDCqzgAmaV/YYiXOdFJ/pk0
         AF95ALrnkFhpT1/vA+QbxnL378s80N//GnIU8V7sTGYFRu1y5aRepgAQIdi0QQhBlQBH
         fbmg==
X-Gm-Message-State: ACrzQf0CAeV5nSK9Jd4xf+BWlh7mFWMRMcyaJlEJ/HHL6go9JJDcnylA
        xaB3ZgyKYacnrOGZy4Vx3SyRQnCPF3v1D3BmyVA=
X-Google-Smtp-Source: AMsMyM4Ju1950+Z9zyLZfIH/QsbQR+2btaoDRS7GsUsEdI/K6rxj+uL0EdYp3XA9YypqsNIE+lj4XJaNFJzZimTtdcM=
X-Received: by 2002:a05:6214:29ee:b0:4b1:c1d2:6635 with SMTP id
 jv14-20020a05621429ee00b004b1c1d26635mr4911427qvb.82.1665159560213; Fri, 07
 Oct 2022 09:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221007145641.3307075-1-jjhiblot@traphandler.com> <20221007145641.3307075-2-jjhiblot@traphandler.com>
In-Reply-To: <20221007145641.3307075-2-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Oct 2022 19:18:44 +0300
Message-ID: <CAHp75VcX2w9mdzbKtfRpc-4zrz8tp33Q5uHyBfds8MJfyeVYvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] devres: provide devm_krealloc_array()
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Bart who learnt realloc() specifics hard way

Thanks for doing this!

On Fri, Oct 7, 2022 at 6:13 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Implement the managed variant of krealloc_array().
> This internally uses devm_krealloc() and as such is usable with all memory
> allocated by devm_kmalloc() (or devres functions using it implicitly like
> devm_kmemdup(), devm_kstrdup() etc.)

Missed grammatical period at the end.

> Managed realloc'ed chunks can be manually released with devm_kfree().

...

>  {
>         return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>  }

Missed blank line?

> +static inline void *devm_krealloc_array(struct device *dev,
> +                                       void *p,
> +                                       size_t new_n,
> +                                       size_t new_size,
> +                                       gfp_t flags)
> +{
> +       size_t bytes;
> +
> +       if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> +               return NULL;

I'm not sure it is what we want, but I have read the man realloc and found this:

      ... reallocarray() fails safely in the case where the multiplication
      would overflow.  If such an overflow occurs, reallocarray() returns NULL,
      sets  errno  to  ENOMEM,  and leaves the original block of memory
      unchanged.

So, perhaps you can add that this behaviour mimics reallocarray()?

> +       return devm_krealloc(dev, p, bytes, flags);
> +}

...

All comments are minor, feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
