Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB76A2D1B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBZCJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZCJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:09:37 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE5113DC;
        Sat, 25 Feb 2023 18:09:34 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q6so1222543iot.2;
        Sat, 25 Feb 2023 18:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gyUjGjkIXklTpf2KG+KR10rtJGIH5WJU4Esx1os/A6o=;
        b=YpOg2waX8HSrZDHDyMnE6wt6tCpelTayVZ0V8EiNJX2akfTzAiP3ZfOqfhSrJ+/FOk
         VX77h/3HF3DVdbVt2MiLwOdxxhsZj0VUaEQry6vrt/w4P/jgbUPuKSOIrXBkmfbuLA/Z
         yR2dagznRbtS6xZAnO4mbyj/3dOs0D58Irr2fSWzgZrPx0iWXfHoe4Zy40I4iDoOQjfP
         4qcSWOvoNTW4xTO+kbIZSJbAgeifp+sxm1kRpw+qAl4TN2TMXKLr5WKSoBg6agyv8S2i
         RcaShoKBczIP7FKSAmJt6B0CmIgKqHHuDcS+L74MtW1adn53yDjNLUM5/NmRaZ4nLxlo
         S9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyUjGjkIXklTpf2KG+KR10rtJGIH5WJU4Esx1os/A6o=;
        b=wybAIJcGSuAC2wKIPFlAElIP0Apy7BgfkFGowlqhkoOYTUBozXGS0uREXVxxTy1Vht
         kJ3CCZJm/EMV62QuEN4uJTlmqpNjGwcwsKh23xV8z54m5//EI2fVU4b+SVjwo7Y1vxGB
         HmD4UI2mfPfkgOuAXGJ6DzF3pRxijEWCMnV2pa6fx4iBDvzCUnNGUSMCaKacROzPDNGw
         AVsMGxWI0jQ+9e+FPpnGVeiFBZg2SvYqgU3SZB8USWGQqhyPjxYGKsibw7tWYY+VXHpA
         sz0RPmKV5UBv53edAKYQOHtb8MgOAx3pp9xVZiiovDgc4hYROvTMzZJ+FA5eC4x5yeIh
         KoLQ==
X-Gm-Message-State: AO0yUKV92Er71/BX/l41ZWI3L5yYHe0HEa5zSg3FuU7MRh1SjIsQ4cPz
        5qykWQCteYlwC5jfkeVDIaNBLzfS8EZe1WBHcIMIDm41Shfuymik
X-Google-Smtp-Source: AK7set/jcnMPJWGTwtKqKvuIWLEEdXyl8hgA+OUyYGRfw++LAFhKa39m40JadR3RnaUhKrwyB5psQD3xo+R0xrk5298=
X-Received: by 2002:a05:6638:13d0:b0:3c4:cf94:54a7 with SMTP id
 i16-20020a05663813d000b003c4cf9454a7mr2367135jaj.0.1677377373950; Sat, 25 Feb
 2023 18:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20210814010103.3929-1-changbin.du@gmail.com>
In-Reply-To: <20210814010103.3929-1-changbin.du@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:09:22 -0500
Message-ID: <CAEdQ38EHwaP-=jwuWwFyftc6yya0tzV6+LL7NoEdZpEVj_kGuw@mail.gmail.com>
Subject: Re: [PATCH] alpha: in_irq() cleanup
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 9:01 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/alpha/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
> index a5123ea426ce..a524de9f1c98 100644
> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -134,7 +134,7 @@ common_shutdown_1(void *generic_ptr)
>  #ifdef CONFIG_DUMMY_CONSOLE
>                 /* If we've gotten here after SysRq-b, leave interrupt
>                    context before taking over the console. */
> -               if (in_irq())
> +               if (in_hardirq())
>                         irq_exit();
>                 /* This has the effect of resetting the VGA video origin.  */
>                 console_lock();
> --
> 2.30.2
>

Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
