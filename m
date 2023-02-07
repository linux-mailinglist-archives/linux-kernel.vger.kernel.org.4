Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CEA68E0E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBGTJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjBGTJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:09:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC682298DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:09:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so14316161wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/n3a3WEivcW8sAV5wyEILdqLrkNxDcEUpLKGmNfk7jI=;
        b=ddasHqAa0E9yK1S96YnKAu6/DAT3yiPo7GUsTdjv4nlES2M324WvvK4RdM5FvBOeBF
         stIuAYlv2yI9HqAJiXfvu1WsRHgHIQc4S72EmoX9Nez5Ly2YF3iVgnui4xYg9Yl5+mQ1
         730miCTKjFS7JO9J1qlY81YoTNLTqKxXga97s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n3a3WEivcW8sAV5wyEILdqLrkNxDcEUpLKGmNfk7jI=;
        b=embGr0gFFIa/GgSy8HupyYhOpG8gsg4E2GQDy/7nJ1XPEWvOcEiQFdSBZDuFQTf+Yp
         lsnNWdipS0u639r1KmPMLKeTxVzpPmGBHaJxgIFHD/OJW+altQ30L9oVBNVR07FcDKtA
         LbufD+1UbnccWb02rQUUQd34A8/N2GLdnhc0HCg6MqTflyLFu7800pNrYPABxT2LrsJk
         lRT8AkNsJ6zclfd7+AmBSYIz0MekjCKdSoWTbm5+j3d57DoxqHp3vg+P1s7rFdZcBw0x
         gvjphotgR+juLFJTJwDyKLXSnYGaC+R+PLMviAL3kRXiTkvTFMHMdHkTXlJ6+c31gKvv
         w6qw==
X-Gm-Message-State: AO0yUKWV+aW8OvXTpBLs67RrO+zvMVfMNtPCJudbPAPU1hd2lgwN3o71
        O73JH1iCO/lhrHePl3guZABiFHKI6xjTARq7WoKx5g==
X-Google-Smtp-Source: AK7set8hYSjYkoFY4AJJ0rFlzYYDb5WNZ07QKwN60DSlCfXznz4D8eZ0Imn4SxGaOB2tHNg/eeztmg==
X-Received: by 2002:a5d:4cc6:0:b0:242:800:9a7f with SMTP id c6-20020a5d4cc6000000b0024208009a7fmr3859791wrt.65.1675796990300;
        Tue, 07 Feb 2023 11:09:50 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id f17-20020a5d4dd1000000b002bfad438811sm11864593wru.74.2023.02.07.11.09.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 11:09:49 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id v10so17402893edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:09:48 -0800 (PST)
X-Received: by 2002:a50:f604:0:b0:4aa:9bd9:d81b with SMTP id
 c4-20020a50f604000000b004aa9bd9d81bmr1162081edn.70.1675796988297; Tue, 07 Feb
 2023 11:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com> <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com> <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
In-Reply-To: <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 11:09:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdr07iKGF2+9yPyW3SQN9qry_R0R45XYmdHHK1iFWNAQ@mail.gmail.com>
Message-ID: <CAHk-=wgdr07iKGF2+9yPyW3SQN9qry_R0R45XYmdHHK1iFWNAQ@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 10:57 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looking at Jens' reply to the other cases, Dan's tool seems to be on
> the money here except for this self-inflicted bogus crypto key thing.

Oh, except you probably wouldn't have seen it, because Jens replied to
the original message where you weren't cc'd.

So here's the context for you wrt the other parts of the report:

  https://lore.kernel.org/all/4321724d-9a24-926c-5d2d-5d5d902bda72@kernel.dk/

where there isn't that same indirection through the super-block, but
more of a clear-cut "this is all in the block layer".

           Linus
