Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFEF693565
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 01:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBLAlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 19:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 19:41:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15588F767
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 16:41:01 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lu11so24200217ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 16:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+Yc5GEsj58XNQLYGh7tO2KtoPIPeJSL4iGRvP+Kg7M=;
        b=QaAd/PnW9D1eu/UXRg5FHeqrBR+5di7X7KJ1JV5+vX5qTyjKY+FsiH3amYLsdVcO1Q
         4TD+eJDwRvZQbNd87zWLmyN9VcWv/1Zc/4bgRmPIdePpYnNSyKKvWpCtizveCrrd36Xk
         n+zeKuQbOD+axb/3nj0x9bWzWxwJuJYwIZQxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+Yc5GEsj58XNQLYGh7tO2KtoPIPeJSL4iGRvP+Kg7M=;
        b=KcHej+SpVfPEGtW5XFuTp2pvbBq+aLniO5PzsHXWenmHaQDoxlo6Lz58llTZvOpDjt
         fnXccNdwscqcZgVV2zKXwS8b/2UPqOU6RMSWDleZB+sJ1SAf1p4SSeOe6xUTiMkNG6PB
         ezpgcTw65HBu0aI4j8EyDR1LZSiJKOluTJZri8TuAoD4YplqHB04Q/1Y7AFv/YgZbzrF
         TRZXrUMRVjRTHqXN3EHU+aHxnKhJ27HlicsBKTLrD1+kVHQZrBk6md+GTIY2gvhdS5L9
         3nIXcrLFwOgcTE197sdRoJgW51YjPL/p78YmW464idM//0mG0vh1+R7sSJALtGoEumS+
         dp6A==
X-Gm-Message-State: AO0yUKVQsFTnQJWEe0TwPZftXERAoV7tBcj/WjwD9YiV2rzKUge5vJM/
        Mbu0PnD/M1YUNWkdkGr9yspvXLNWt1Wgi1qsiPbxpw==
X-Google-Smtp-Source: AK7set+Uk5KNZ0oeHwtwWAHjBS3xUi4yqbjqylhKTYdlP6OaKeenye9lnLsb6vGRla1+1LJv+nuWCw==
X-Received: by 2002:a17:907:6d06:b0:8ae:3200:a107 with SMTP id sa6-20020a1709076d0600b008ae3200a107mr18210127ejc.23.1676162459370;
        Sat, 11 Feb 2023 16:40:59 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id mb20-20020a170906eb1400b0087bdb44bbc0sm4514005ejb.32.2023.02.11.16.40.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 16:40:58 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id c26so19383404ejz.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 16:40:58 -0800 (PST)
X-Received: by 2002:a17:906:16c2:b0:8af:4100:28e5 with SMTP id
 t2-20020a17090616c200b008af410028e5mr2539793ejd.0.1676162458573; Sat, 11 Feb
 2023 16:40:58 -0800 (PST)
MIME-Version: 1.0
References: <167613641114.2124708.9785978428796571420@leemhuis.info>
In-Reply-To: <167613641114.2124708.9785978428796571420@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Feb 2023 16:40:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4-LenywoHYw9W5QZeG8RaV+9htGhR02QAe_LDSA5pgA@mail.gmail.com>
Message-ID: <CAHk-=wi4-LenywoHYw9W5QZeG8RaV+9htGhR02QAe_LDSA5pgA@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-02-11]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 9:28 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> * the fix for a SPI issue I already mentioned two weeks ago is still
> sitting in next;

It's now in my tree.

               Linus
