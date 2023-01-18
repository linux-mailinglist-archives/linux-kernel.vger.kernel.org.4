Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1EB672820
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjART1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjART1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:27:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D873854113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:27:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so2154255wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gw2OqH8svh6Y9ZQ3ZoPeYoQ8UKFhnjhW8PRKbQptBoM=;
        b=TMiWMlpwLUVOrMAwJfpLSxTLSfISTZxQuoH1QDmbORP0znWZukAADiab8gbClB7yVp
         rQL+JQtw3269VSA1h/D520aDAeYyuj1F5Y8vKPco5GLPm5YNDKZ1aPTMcIQgm1UJ+2Nb
         SNZLL9ay6CfI0O10nRLxLocTSD4uCfEkPGQ/Np2tvHG27LDhqqEGdXQ8uMD5pUvTEvCx
         jHPTPBKcUtO4yiseDDXvitbc1p6SxSxbNARzCdiUmibEBYpyfAn8YwDg8Z0ix53rdEjG
         8XKisRtVxGToANgKFGvoIUiLSVzUhQ51n+E7shy43/ClDvFH7Jkk0cjQUOy7k7jJaVxE
         hdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gw2OqH8svh6Y9ZQ3ZoPeYoQ8UKFhnjhW8PRKbQptBoM=;
        b=6AhCm7Ao6vUw8cCys1P2TDyOC4jLQ8W+4YQPm7WV94SQW+jsszQ/ZE3aFcBb7ozgIc
         8G2RiMSkTsyw1wWrsgU7rJwQtWJKKOhBZPJKXoVjfXuLi+EvWCrrATz4Zkck5/Mr4iWi
         GePGoYU5QgrihAxGayffC68wu+1sZ4+IjfFdsYZtfHOmKTdPz75jAGi+FSGuxakx5l/z
         sVKoDGjmiidQFYFg+7/pcITd/kdjc3xeywudEhXZEh3CZOJFodfir9aSIXHVNo7Ub0q7
         sl+JDbhgecAorz8BsUL2TZba4EIiFFblspY+lkNCMPkVJ4dzn4yee2H/oXaJZVAWIFbd
         XTZQ==
X-Gm-Message-State: AFqh2koIUTXlOpUlJllqO0L1wSIicgZjfSEt4f/6JY8UG4D233pbjCVB
        7ZBBtx389QiGydd2YfAeW+vSuNxIpp0BMUuwQQfxpZyssh9RLw==
X-Google-Smtp-Source: AMrXdXvwK9wnyf69VXXDyY6HPihPRTo5mvUcTmHeoqMoqEkPU5X+Nr4vJQQ7zxMC0AkZfCJrxKLSd/PPlC5rcxanE9s=
X-Received: by 2002:a05:600c:a686:b0:3db:104:7821 with SMTP id
 ip6-20020a05600ca68600b003db01047821mr436651wmb.77.1674070052343; Wed, 18 Jan
 2023 11:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20230117170507.2651972-1-arnd@kernel.org>
In-Reply-To: <20230117170507.2651972-1-arnd@kernel.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 18 Jan 2023 11:27:21 -0800
Message-ID: <CAKEwX=OTpY9Wg6YPfADDqeu7FFzciY9o_nNE5dRR3cu_-2ntaw@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: avoid unused-function warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 17, 2023 at 9:05 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> obj_allocated() can be called from two places that are each
> inside of an #ifdef. When both are disabled, the compiler warns:
>
> mm/zsmalloc.c:900:13: error: 'obj_allocated' defined but not used [-Werror=unused-function]
>
> Rather than trying to figure out the correct #ifdef, mark the
> trivial function as 'inline', which implies __maybe_unused and
> shuts up the warning.
>
> Fixes: 796c71ac728e ("zsmalloc: fix a race with deferred_handles storing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 723ed56d3fbb..9d27d9b00bce 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -937,7 +937,7 @@ static bool obj_tagged(struct page *page, void *obj, unsigned long *phandle,
>         return true;
>  }
>
> -static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
> +static inline bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
>  {
>         return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
>  }
> --
> 2.39.0
>
Tricky one indeed - I definitely missed that. Thanks for the fix!
