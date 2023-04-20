Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629076E8D91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjDTJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjDTJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:06:38 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC5F558A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:02:57 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4403aef7f1fso110186e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681981376; x=1684573376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LMsZwiXCynop9/V5hNzee8yBH9znRbpYlq3tpZhLHnY=;
        b=EY6EGG9UUTyXMb6NcpciMcbuWDv1tDu3ZMooFOdSMnXBZpuhqFWzvtN/niShgB8Clo
         FmIqqi9buQGIEkUu1Y5NOewDHr4Xn8QwWPaEs690DhXKghZVdi1ezfmj3/9zoK6T2J2X
         TvTbJQA+Cp726IvI4cFsXKkbwyBpWQKMM9yRxFvXQneW1J1Og6LbZOS7Wb18rPXkV4Ry
         p1nijeg6YeujAgxCoc7g888oOzEbkk24b/m55qLEfm25SEpaXcrazRyvAMLjeXZZcMW2
         7TekrFY+q1ivMMlRbol44RNEI1ceks+Q7bddM8Pq05SdnupOOQhCrc6M0HIZZKf4l51B
         7xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681981376; x=1684573376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMsZwiXCynop9/V5hNzee8yBH9znRbpYlq3tpZhLHnY=;
        b=AXaJu4YW2qct9MjviVmnvmkt7XGWckAWHzQWzCuP8OT0y7PeW0miYEcLHW8m+JNCGH
         dBF4Xez+2UIL13E7MuvLMSNiexrqYySqalyIf6XUPfchL+58jZ+0Y6dkPk5DMONkN1D6
         jRBgJSMTNQ1mTfjHhsrSUdZ8K5KHzLXNEEol/53flccvFajYC6Y8HQxwmgEsXpRgwjKz
         Y5x7Nz8vuGpO+aNXWlD+MGvOJv/eZxqg1xR77Dt0frfRXIuvvWw2W2GfwRrcjwO4vKGe
         FCG5ptSBwjK/kTRgV0y0HoJZdxAud3U6pXYqnaBdeYgNu1IAeCLquwap2m57s1YT4/G+
         Ca7Q==
X-Gm-Message-State: AAQBX9ftvvRmu0yL7kN6aYbnncypcHLM7aj3+tmvPR7QcD9YW+JJ1do5
        cfAVjtwL6fUwEIUGxa3+yf1dHP73h8DQpf8aiSL3fw==
X-Google-Smtp-Source: AKy350bqsKR+AybgMaWoeCUhFumMbGUSbur79i9uSsOY1oi22AQYWG0V081IysCcZHU0iNATRnGeI5pAYQExdlIxBXo=
X-Received: by 2002:a67:ae47:0:b0:42d:bb69:668d with SMTP id
 u7-20020a67ae47000000b0042dbb69668dmr584291vsh.4.1681981376399; Thu, 20 Apr
 2023 02:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230420074923.2281303-1-etienne.carriere@linaro.org>
In-Reply-To: <20230420074923.2281303-1-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 20 Apr 2023 14:32:45 +0530
Message-ID: <CAFA6WYM6E_8nnH_v8O4EROdGQ0mY+Bw=ZT_a-y92bh654UozZg@mail.gmail.com>
Subject: Re: [PATCH] optee: fix uninited async notif value
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        op-tee@lists.trustedfirmware.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 at 13:43, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Fixes an uninitialized variable in irq_handler() that could lead to
> unpredictable behavior in case OP-TEE fails to handle SMC function ID
> OPTEE_SMC_GET_ASYNC_NOTIF_VALUE. This change ensures that in that case
> get_async_notif_value() properly reports there are no notification
> event.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202304200755.OoiuclDZ-lkp@intel.com/
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/all/d9b7f69b-c737-4cb3-8e74-79fe00c934f9@kili.mountain/
> Fixes: 6749e69c4dad ("optee: add asynchronous notifications")
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/tee/optee/smc_abi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index de7ac9a46354..6d3705770755 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1001,8 +1001,10 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
>
>         invoke_fn(OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &res);
>
> -       if (res.a0)
> +       if (res.a0) {
> +               *value_valid = false;
>                 return 0;
> +       }
>         *value_valid = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_VALID);
>         *value_pending = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_PENDING);
>         return res.a1;
> --
> 2.25.1
>
