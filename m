Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09D368DFF3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjBGSZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjBGSZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:25:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A81AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:25:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id sa10so14489725ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pizbVdzIu8iuBwFy6mvT//fygI8uGhRT/vJXKJ1LaVY=;
        b=Cbdf46oletXuJOCJFIQa/rXoWMh2VweqM3WV0BdriyXCVvt01UIAIUTfYvqvj42FI2
         dGIfD10JkRckky68XPz+miwRmw315N2EVOwurVjhjAEG1ALANVLXtxKLg2HenyvlPIf3
         BQ+5TFXwBlTTO9jEL5tKFIsun1OjHvxjw507I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pizbVdzIu8iuBwFy6mvT//fygI8uGhRT/vJXKJ1LaVY=;
        b=Pvq7DpL0PQLTQuCWyCzeh3edrCHycbH85nMQmpWoz4wj9BgVd5A30gRksyWHqsi0id
         +rf1lLhm0y0FfrPwAOvIA6Rtrtwbu0FfoOf3qgsmJjx0GEF4Izx1xjbDKXnup4qHxR1j
         xnQlGZ5z4tDWZtcz+j7OWoFIonU7KnyztqnkZW07LQJHRjkbXqm4bDvWauEdszkHLIp1
         2EvBIL8lXWjEWcsaIAKRda5Za03nebTHqP7immmH56evu133mEVLG6BdS0LbJQ99GupB
         zI2JLXXvBqMPznxaosy5alam3OApKDy53G6VlSc/gVCewm3p2b1sgWSI7x68jC4NffaX
         mzEA==
X-Gm-Message-State: AO0yUKVXyIojxEBTgmL8bHhDyFY5ERtxe02R3wCG1PlHwIhUAifRyAx0
        /jf3tglVpxdT//82pyeLJ5ir6qWDZ5HAe7JOkXutCA==
X-Google-Smtp-Source: AK7set/zCijcP03eTMU+2PhxffdAXyPf3oFS3VHfWoeL1IaY8vYSg0WqeOjtMaD3pqHkwRuwpUhl2g==
X-Received: by 2002:a17:907:2c54:b0:882:82b3:58bc with SMTP id hf20-20020a1709072c5400b0088282b358bcmr4492008ejc.65.1675794303620;
        Tue, 07 Feb 2023 10:25:03 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id sa21-20020a170906edb500b0088957f66018sm7245480ejb.142.2023.02.07.10.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:25:02 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id sa10so14489376ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:25:02 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr970336ejw.78.1675794302170; Tue, 07 Feb
 2023 10:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com>
In-Reply-To: <Y+KP/fAQjawSofL1@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 10:24:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
Message-ID: <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, linux-block@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
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

On Tue, Feb 7, 2023 at 9:53 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> It's a false positive.  See the comment above fscrypt_destroy_keyring()

Hmm. Ok. Unfortunate.

>  If the filesystem has not been mounted, then the call from __put_super()
> is needed, but blk_crypto_evict_key() can never be executed in that case.

It's not all that clear that some *other* error might not have
happened to keep the mount from actually succeeding, but after the
keys have been instantiated?

IOW, what's the thing that makes "blk_crypto_evict_key() can never be
executed in that case" be obvious?

I think _that_ is what might want a comment, about how we always call
generic_shutdown_super() before the last put_super() happens.

It does seem like Dan's automated checks could be useful, but if
there's no sane way to avoid the false positives, it's always going to
be a lot of noise ;(

           Linus
