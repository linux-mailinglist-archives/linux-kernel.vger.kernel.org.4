Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1A66AB51
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjANMSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjANMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:18:02 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750946591
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 04:18:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mp20so11411214ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9YuksUftZM7Mr4U6pqPjOciGDwe5IYDlYl6UJ9PPnk=;
        b=synd+Iggo1DQo5udzPz0uQKpvVSlRqvBUZi2YQV/McwbYALis2UlgTDQDUR6izBCC2
         l1bZPDxHIVWe9BlDJugSUyRI2tB8w+sHRdISa8ozgnxqwNFMCIzMgif57A4S+wEYoIRn
         sBDlRAINr7z8unXoQgqiE3xTPECg3H1Zt6zBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9YuksUftZM7Mr4U6pqPjOciGDwe5IYDlYl6UJ9PPnk=;
        b=jQjWFSHtHlgKd4PHaHcmzrGrb8bfD3uhyPwZis54z3WLyY+yPhbOhlzudUi8Z0UuBI
         EMY2M+bxirk6BZzpaYDwkwrm1f3SkgPWQOQM29pX+ihw8ExbzR4reP6VhUIFwzabgzM5
         UC79Iuhis1ghyXw7GMBAdADWKq/FFYf72ZyhJLMFcymQHiezxzfgsm411xzdVhmCjago
         WDrJW/eU3AxbjwQuWkdnb63WTBI8gT3fuL6ecABzS1G78xi7o371ifiyWLO0MvecUUFs
         kZDeTzW7ljL9hgVoKZ/2VU+btNCYHmTE8eVdGI19D5hD0HRro/mDvIYVRGmkyVmwlTXK
         MxiA==
X-Gm-Message-State: AFqh2kpAHJm4mafFITulwHheuWwCr+5uTGJMGR/C+sxOo+F7E1XWgRn0
        wEo2Fksg2dhVTM0EVIN8VEWGY9ChI3ReUr1vRqfRrA==
X-Google-Smtp-Source: AMrXdXvOei0aOBB3VZW2CgQOSb70AyAl1/B9kFZ6iYcyI2Yi7BxLttLgs8zTqS4nD1yrRe//DV3jMt5l4sDPgo+VyYc=
X-Received: by 2002:a17:906:3186:b0:84c:4d1:5e9a with SMTP id
 6-20020a170906318600b0084c04d15e9amr4237385ejy.297.1673698678984; Sat, 14 Jan
 2023 04:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20230112-inet_hash_connect_bind_head-v2-1-5ec926ddd985@diag.uniroma1.it>
 <CANn89iJekPT_HsJ6vfQf=Vk8AXqgQjoU=FscBHGVSRcvdfaKDA@mail.gmail.com>
In-Reply-To: <CANn89iJekPT_HsJ6vfQf=Vk8AXqgQjoU=FscBHGVSRcvdfaKDA@mail.gmail.com>
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sat, 14 Jan 2023 13:17:48 +0100
Message-ID: <CAEih1qWQf1JK4vbdzcTb1yXADxTV4+AqtJkvnK1T895obUTtOQ@mail.gmail.com>
Subject: Re: [PATCH v2] inet: fix fast path in __inet_hash_connect()
To:     Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 at 13:16, Eric Dumazet <edumazet@google.com> wrote:
> 1) Given this path was never really used, we have no coverage.
>
> 2) Given that we do not check inet_ehash_nolisten() return code here.

It seems there are a bunch of call sites where inet_ehash_nolisten() return
code is not checked, thus I didn't think of it to be a problem.

>
> I would recommend _not_ adding the Fixes: tag, and target net-next tree
>
> In fact, I would remove this dead code, and reduce complexity.
>

This makes a lot of sense. I can post a v3 patch completely removing
the fast path.

However, this patch's v1 was already reviewed by
Kuniyuki Iwashima <kuniyu@amazon.com>, v2 is a nit, if posting a v3
I think I should remove the Reviewed-by: since it would completely
change the patch, but what is the preferred fix?

Best regards,
Pietro
