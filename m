Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCC6A11D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBWVS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBWVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:18:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694218B0A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:18:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x10so46441982edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o5EaUMxUu98mAPL68+dXX7WmuwtBVQHznLgjebwlQ4I=;
        b=Pl3dZ9xTbzURMJzx/eGGIQXnmfoYM03pN0WhMPpwPgnrLPDyz+genkT2s+ds1BpkV6
         twgQRI8jT/MQAGxLGHvJ8M2g8/XP/ZqA8moBtTkD1S/r7vQSfaSuRiHAxK/lkLQc1hyl
         4pyuSAjtf+qu+jr1Ej+LvtHyHtN7af3Z5Hg1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5EaUMxUu98mAPL68+dXX7WmuwtBVQHznLgjebwlQ4I=;
        b=PpGsn3tZSLLsZObTP0oKiCrwIeBx6AMwCdNqhGmnx0Q+Ayxh+alkwgYwSjjmGNgtXZ
         q+K/cBiaX/K9YM7f7AjyaCMTXyt2WK1KcdbvdCFO7UWz6dYFScecbe9zTkHqeY4JOJQB
         OL1mCpkbchxERJlO9FBsnyWroAN0vbjOpY1X4/LqpfxwgJ+W8Hi+4K+9cEDLqTNtsGOO
         rsl+sdZYiIewgbmU0s4iit4mCKAabD6GDzPp5MEJjOTBl5ZeuMNRy89GSB7wjRlOjR0W
         dCK0p6naQfh7/X286y+v84egp144taQnMtfctUhzH2YI7DkC7yYBcXT3MbgAwqTbsmP4
         z5Hw==
X-Gm-Message-State: AO0yUKVcU/xhxj14dvRxBGX2ndk/PZmHzNK6sl6KIjODM6C23qE5zXwq
        G+l159/Ir5qfz3AipY1uRav9dqWXZD45KgCvbUxyXg==
X-Google-Smtp-Source: AK7set//pIpic6Wb8kn185AOWPIUI34sPAlAZA//XbRsW5xTl92otKG7wpWW/o7Py7ZVEM6VIi/sFw==
X-Received: by 2002:a17:907:a801:b0:8a9:e031:c4ae with SMTP id vo1-20020a170907a80100b008a9e031c4aemr21861998ejc.2.1677187130909;
        Thu, 23 Feb 2023 13:18:50 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170907760e00b008cc920469b5sm6313976ejc.18.2023.02.23.13.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 13:18:50 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id f13so46706081edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:18:49 -0800 (PST)
X-Received: by 2002:a17:906:8508:b0:8d0:2c55:1aa with SMTP id
 i8-20020a170906850800b008d02c5501aamr7232357ejx.0.1677187129340; Thu, 23 Feb
 2023 13:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20230223141542.672463796@linuxfoundation.org> <adc1b0b7-f837-fbb4-332b-4ce18fc55709@roeck-us.net>
 <Y/eVSi4ZTcOmPBTv@kroah.com> <cfd03ee0-b47a-644d-4364-79601025f35f@roeck-us.net>
 <CAHk-=whCG1zudvDsqdFo89pHARvDv4=r6vaZ8GWc_Q9amxBM6Q@mail.gmail.com> <Y/fC3d3RqoeawG0Y@dev-arch.thelio-3990X>
In-Reply-To: <Y/fC3d3RqoeawG0Y@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2023 13:18:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkNnShBugM01Kzcypkp+f-uHeBWuAgtUiMpiSZuW+QDQ@mail.gmail.com>
Message-ID: <CAHk-=whkNnShBugM01Kzcypkp+f-uHeBWuAgtUiMpiSZuW+QDQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.96-rc2 review
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
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

On Thu, Feb 23, 2023 at 11:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> I can send a patch unless you want to take those changes directly, you
> have half a commit message there already I think :)

Not being one of those old fogeys myself, I don't feel hugely motivated to care.

In fact, I think GNU patch implemented the git patch format extensions
more than a decade ago, so we might even simply decide that it's past
time to even worry about this at all.

In fact, with all the base infrastructure supporting git patches, I'm
not quite sure just _how_ quilt is able to apply patches without
dealing with mode bits.

Does quilt parse the patches and actively remove those lines before
applying them? Or does quilt have some actual built-in patch
application code that doesn't depend on GNU patch?

(Side note: GNU patch may support git patches, but I don't think GNU
diffutils will generate them, so I guess not all base infrastructure
supports that fancy new "mode" line)

             Linus
