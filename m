Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA8617795
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKCHWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKCHWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:22:49 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B482DE7;
        Thu,  3 Nov 2022 00:22:48 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so2690343wmb.2;
        Thu, 03 Nov 2022 00:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUgKQvDo/cr0JssVgCdSKS0tCR2RGSnXUbgVX1YNA8g=;
        b=ntrBLIiWzYe56Q3gD04WG5VsYsysZGvI0vfE+xb3Y7JBtoztqxLvcAcLWzC7hO4Q0i
         sgdirNmfohITZv6PUzQbJmvflznaPZRgTHaotDqk0tU1EByNS9QJcSqmci9tWUVNn+o+
         2Dr8zjp0CPDSau2gbtgUOOB8TpsqeJBdppphQMhv8ktAQeVcm3EjQpneVDvuUMLxbchg
         ekhK6SJCGorjLzD6sA9tg1QO2/vEEkDo4JqY6cRaVHz6d0MH4q0cylHureE1/Y3fCkvS
         uNeVy50BgNHyuKa2OwusHGBXAshObs8x0QbHrZvw7zBeYkgUOOjVTS99Vx5THOmaYJyo
         XE9A==
X-Gm-Message-State: ACrzQf2gJoAF54xXqC0v8hegysx3iTE+SKC+2672ZAZD7IwhKylT9ZRb
        7vKT2Ul/tIE58NM/wU0EwJI=
X-Google-Smtp-Source: AMsMyM5KpoixiXYk+OO4iEz6xP0PiqodhVQ/BEXsefqM+9sHYmcUZ6YyMlmBlFylFm3cR15HEYrGZQ==
X-Received: by 2002:a05:600c:33a5:b0:3cf:6fd1:d94b with SMTP id o37-20020a05600c33a500b003cf6fd1d94bmr14454272wmp.52.1667460166921;
        Thu, 03 Nov 2022 00:22:46 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d4e0e000000b0022cc6b8df5esm73466wrt.7.2022.11.03.00.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 00:22:46 -0700 (PDT)
Message-ID: <9fe8615c-fe31-ebf7-09bd-453fae189666@kernel.org>
Date:   Thu, 3 Nov 2022 08:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH] kbuild: pass objects instead of archives to linker
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Michael Matz <matz@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20221102091308.11568-1-masahiroy@kernel.org>
 <CAMj1kXGzFEnUGkoD_JV6=mrKQ+eXLo=SYU8823mPezHZfY_FRQ@mail.gmail.com>
 <CAK7LNASjBm=WWpkSaL1+QuLokhnepUucvhYyP3CCeZYx6nOTHA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNASjBm=WWpkSaL1+QuLokhnepUucvhYyP3CCeZYx6nOTHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 11. 22, 10:44, Masahiro Yamada wrote:
> Jiri Slaby reported that the (not-upstreamed) GCC-LTO tree got broken
> due to 321648455061 ("kbuild: use obj-y instead extra-y for objects
> placed at the head")
> 
> https://lore.kernel.org/linux-kbuild/ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org/
> 
> 
> I am not pretty sure because I did not check the downstream code.
> 
> 
> If I understood his report correctly, the reason for the breakage is
> because I put all objects into the thin archive, expecting
> the linker would preserve the object order in the archive.
> 
> By specifying the object order directly in the command line,
> GCC-LTO should get back working again.

...

> I think my patch is unneeded (hence RFC), but I just wanted to know
> if linkers (gnu ld and lld) see any difference.

Yes, including your patch (instead of vmlinux.S and /compressed/* 
changes) also fixes the issue. So the linker (gcc-ld) indeed respects 
command line, but not order of objects in .a.

thanks,
-- 
js
suse labs

