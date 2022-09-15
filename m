Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA55B9F98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiIOQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIOQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA2E8FD7A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663259130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRNaAPJIxfa3ZuIvB7F/07ny/tmf9pDcXpC1rsM9po8=;
        b=jG3/WdR0Or4OEotOD8a20XSUXXVUOIg32gTCuDm0BGIBgsnN/mDOhx/DU6ZAHpRIkLamcr
        EPO9MIIBeFzs+FFMvLcrvEdDVqcVzSKsar9S80tLQVV83pTYRnt4kPwdjB2MGGABTOTPr/
        bEYH5Xt89pFnY7K/4E2LasAwOOHXf7A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-tro2moaDM8i6EQy_deunEg-1; Thu, 15 Sep 2022 12:25:29 -0400
X-MC-Unique: tro2moaDM8i6EQy_deunEg-1
Received: by mail-wm1-f69.google.com with SMTP id q10-20020a1ce90a000000b003a60123678aso6756973wmc.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=PRNaAPJIxfa3ZuIvB7F/07ny/tmf9pDcXpC1rsM9po8=;
        b=dQWdFsh5AF04cQT1dt7ifwd7Qz3yHsoTnwPxHLkv/HPe9BwErKaElRjPcTx0cLq3jT
         Smt8R0qCJXBTWTVLEg2MAKpNXZJVzCSO2wCr70TSxt7TOhDvxG47G9eUzYaFNqv4cbez
         yiot97d88JZjXHsR0gPnBx7Pm3s99+ozTC0/xz4y2/4oosolE34HdCinRfHlruq8tKBY
         U8wTmPmMWrkFVAlViCN3eFUen/IJmMaqNfudyNVJ8RAp0czM/CYzSY45SJ7N8crR2EkG
         XC3BCwZdeDizz4+sBeB0Od//8HUW3EMx51V5zF6teZCiuMSPlHUcudqHW72oo/PLz00+
         aN3Q==
X-Gm-Message-State: ACrzQf2Y6UkcrhhN+gbPDKLR/fUMpx6zJo1IzlTMRG2jyqDm5ZUim+Xg
        LwD8BYeJVQzPnN2PUX5tQn6BkiFq77lwob/0YLgSsAbusYs9ZWXuuXVUs1s/oAygPh0zAHLj3pm
        GJaBztkffDJsFW/zO2QMN0iCj
X-Received: by 2002:a5d:45c6:0:b0:228:8bda:f345 with SMTP id b6-20020a5d45c6000000b002288bdaf345mr315197wrs.584.1663259126282;
        Thu, 15 Sep 2022 09:25:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6lUQAgEYH9/F1HyO/R87gjwIw48+YfWmx1o91l/7+67diRahVlALJZtRWZYCeqquzFiucdwg==
X-Received: by 2002:a5d:45c6:0:b0:228:8bda:f345 with SMTP id b6-20020a5d45c6000000b002288bdaf345mr315180wrs.584.1663259126081;
        Thu, 15 Sep 2022 09:25:26 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id v13-20020adfebcd000000b0022a403954c3sm3154289wrn.42.2022.09.15.09.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:25:25 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 3/4] lib/find_bit: optimize find_next_bit() functions
In-Reply-To: <20220915020730.852234-4-yury.norov@gmail.com>
References: <20220915020730.852234-1-yury.norov@gmail.com>
 <20220915020730.852234-4-yury.norov@gmail.com>
Date:   Thu, 15 Sep 2022 17:25:24 +0100
Message-ID: <xhsmh4jx8bo5n.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/22 19:07, Yury Norov wrote:
> Over the past couple years, the function _find_next_bit() was extended
> with parameters that modify its behavior to implement and- zero- and le-
> flavors. The parameters are passed at compile time, but current design
> prevents a compiler from optimizing out the conditionals.
>
> As find_next_bit() API grows, I expect that more parameters will be added.
> Current design would require more conditional code in _find_next_bit(),
> which would bloat the helper even more and make it barely readable.
>
> This patch replaces _find_next_bit() with a macro FIND_NEXT_BIT, and adds
> a set of wrappers, so that the compile-time optimizations become possible.
>
> The common logic is moved to the new macro, and all flavors may be
> generated by providing a FETCH macro parameter, like in this example:
>
>   #define FIND_NEXT_BIT(FETCH, MUNGE, size, start) ...
>
>   find_next_xornot_and_bit(addr1, addr2, addr3, size, start)
>   {
>       return FIND_NEXT_BIT(addr1[idx] ^ ~addr2[idx] & addr3[idx],
>                               /* nop */, size, start);
>   }
>
> The FETCH may be of any complexity, as soon as it only refers the bitmap(s)
> and an iterator idx.
>
> MUNGE is here to support _le code generation for BE builds. May be
> empty.
>
> I ran find_bit_benchmark 16 times on top of 6.0-rc2 and 16 times on top
> of 6.0-rc2 + this series. The results for kvm/x86_64 are:
>
>                       v6.0-rc2  Optimized       Difference  Z-score
> Random dense bitmap         ns         ns        ns      %
> find_next_bit:          787735     670546    117189   14.9     3.97
> find_next_zero_bit:     777492     664208    113284   14.6    10.51
> find_last_bit:          830925     687573    143352   17.3     2.35
> find_first_bit:        3874366    3306635    567731   14.7     1.84
> find_first_and_bit:   40677125   37739887   2937238    7.2     1.36
> find_next_and_bit:      347865     304456     43409   12.5     1.35
>
> Random sparse bitmap
> find_next_bit:           19816      14021      5795   29.2     6.10
> find_next_zero_bit:    1318901    1223794     95107    7.2     1.41
> find_last_bit:           14573      13514      1059    7.3     6.92
> find_first_bit:        1313321    1249024     64297    4.9     1.53
> find_first_and_bit:       8921       8098       823    9.2     4.56
> find_next_and_bit:        9796       7176      2620   26.7     5.39
>
> Where the statistics is significant (z-score > 3), the improvement
> is ~15%.
>
> According to the bloat-o-meter, the Image size is 10-11K less:
>
> x86_64/defconfig:
> add/remove: 32/14 grow/shrink: 61/782 up/down: 6344/-16521 (-10177)
>
> arm64/defconfig:
> add/remove: 3/2 grow/shrink: 50/714 up/down: 608/-11556 (-10948)
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

