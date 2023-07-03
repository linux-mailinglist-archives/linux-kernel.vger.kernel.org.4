Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828BF746378
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGCTnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGCTnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:43:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B3CE76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:43:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-66872d4a141so2865080b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688413397; x=1691005397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySGQb63McKAnHAtTV4YnIT1osW5j3ZzjlUXCtpyAk60=;
        b=duVOIzc9ItKwtD4olGEWyaG0IZNcOfgysto8rnoAotgH/JPKXC2pKbZk5yrUweFloB
         0ieStjkohOJZcbL0D4nbiGWZQ1yEifLKqbwsGy+MLaoj5ddR7LMatWVLluiyqgK6nmFP
         +9S13j9+5FuJK62iqs6y0OxJ1hAYJe45SdBis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688413397; x=1691005397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySGQb63McKAnHAtTV4YnIT1osW5j3ZzjlUXCtpyAk60=;
        b=D1CzMdgJPNfmkeX4vFxJBChvuD4a3Ztm5i+VaBAewZerAnB7rhUhg378NjrxU4mvV2
         q7BoR2wskXHfC0N4wmHtNnD2LiMHyY+3dk3eICReI2w5Z6EevpTVNIduoVr4dLYYygMx
         D8xm/XE5hc19CCRtfZ5oGJcrJFKynE107zZ1MrPZs8p+uS42et+cm1TAiPBkYqQvwNgT
         bh8Xi5k2GiXabJpl+bxB36cwCj7kNg7NGdoQwOHpkWz6ic5v0+n+768LQv/MlYckqp0y
         juyTj1OeUTum+sZVA1tHKpqEUSuF59VbHF5jgL3+NZJquvA2hvhJ527Uul0XxbViQeZr
         fZiQ==
X-Gm-Message-State: ABy/qLYWuQVLQq97xO8z4uR16mrA0dyy+eOWYRzp7pvyAVNPvS6JqxTO
        7P9Tjg6Z0VJ5Wuo0ltsw4AtQVg==
X-Google-Smtp-Source: APBJJlFMfAY1KDOtIdrla5dpxwEcVA8Y4IsZ0EJSS662iPGIBtnRIpBBFo1pU1hOYhJVfCXP6h2FNg==
X-Received: by 2002:a05:6a00:99f:b0:62d:8376:3712 with SMTP id u31-20020a056a00099f00b0062d83763712mr9777195pfg.28.1688413396784;
        Mon, 03 Jul 2023 12:43:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b006666699be98sm12345534pfo.34.2023.07.03.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:43:16 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:43:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH] TIOCSTI: always enable for CAP_SYS_ADMIN
Message-ID: <202307031241.C7286A7B2@keescook>
References: <20230701235918.kwfathbdklkyrbde@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701235918.kwfathbdklkyrbde@begin>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 01:59:18AM +0200, Samuel Thibault wrote:
> 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") broke BRLTTY's
> ability to simulate keypresses on the console, thus effectively breaking
> braille keyboards of blind users.
> 
> This restores the TIOCSTI feature for CAP_SYS_ADMIN processes, which
> BRLTTY is, thus fixing braille keyboards without re-opening the security
> issue.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")

Based on the design of brltty, this appears to be the only solution. I
remain surprised that FreeBSD had no brltty support, which is why they
didn't run into this problem.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Index: linux-6.4/drivers/tty/tty_io.c
> ===================================================================
> --- linux-6.4.orig/drivers/tty/tty_io.c
> +++ linux-6.4/drivers/tty/tty_io.c
> @@ -2276,7 +2276,7 @@ static int tiocsti(struct tty_struct *tt
>  	char ch, mbz = 0;
>  	struct tty_ldisc *ld;
>  
> -	if (!tty_legacy_tiocsti)
> +	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
>  		return -EIO;
>  
>  	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))

-- 
Kees Cook
