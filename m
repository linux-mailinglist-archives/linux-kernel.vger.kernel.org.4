Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB973251F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFPCRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjFPCRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:17:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF12683
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:17:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977ed383b8aso20383166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686881848; x=1689473848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRMbq2VvSqK0Urjp22PwUm17As2BrZ4veHF95ybZPJ0=;
        b=bovBaQF8JKXet/eDzUBjdG1a68cWfRtaYnJSeJrz4RnISnZ94Z0sUZp5O/yC0dlpEV
         kwzbllsU2r+GfoUhVKhBrp84l4BJJ69jQi6LaBNIJZe6kEo+aqvmjzdwQrogOYqiHFqC
         6In4C/POAngZkjnCgcv94h1LCyqnTtkdzG878=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686881848; x=1689473848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRMbq2VvSqK0Urjp22PwUm17As2BrZ4veHF95ybZPJ0=;
        b=XZ0XAixXD2EZeLRgtpMiWjg3FRGYekVf6Jprr1fZygGopgSub844XNFjYvrg3cJ46u
         dHyIwZcy1TC4ts+e+sQIns8nTkmxcGToxkTL0pMkmoCr1r86u4xIW6a6ys9/R3S+3iV5
         xRRHyRlQwYgZFnQYXGSaieqDNxPuREvVkTosy84cIO6+9SFjb0uv09i+0B8RvOoVZg/x
         +mZ0iRgAtPs4TIgWgQgfGAL/QzESiA27sc0qBrH4azY2z6QCFWx4UrN54JWWfgoaGe3B
         SVsx8H8C80K7C3c9GCJxsCE2B2oY2t1n7m4QuUGv9AIhqrU3fUz/hEwdYKiTGdAZvBd9
         D2Fg==
X-Gm-Message-State: AC+VfDyeJK7J3aotTSgeXJvyn9AFbd7UvnbyRfa/pbfEeNYE4GNjh0AG
        wqMTTJtNmOk2MlnT60n+f53voyuGaCPWlxFZ4NpeJxMr
X-Google-Smtp-Source: ACHHUZ5kXbRnpDmgUz6iHq224/1n/heAk+gvM7ofXe/12Ur3Gw15A/hrjG9ESGJYF8UxCpdaK+BSZA==
X-Received: by 2002:a17:906:974d:b0:953:37eb:7727 with SMTP id o13-20020a170906974d00b0095337eb7727mr677695ejy.43.1686881848373;
        Thu, 15 Jun 2023 19:17:28 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id gu24-20020a170906f29800b00982afe5190csm1298394ejb.117.2023.06.15.19.17.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 19:17:27 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso230347a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:17:27 -0700 (PDT)
X-Received: by 2002:a50:fb03:0:b0:51a:2f22:6564 with SMTP id
 d3-20020a50fb03000000b0051a2f226564mr279108edq.39.1686881847426; Thu, 15 Jun
 2023 19:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615121721.1f901ebb@sal.lan>
In-Reply-To: <20230615121721.1f901ebb@sal.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Jun 2023 19:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiL88k26bmOXwkRojVUwkcGdXHBm2-+PwtXUja88+tEA@mail.gmail.com>
Message-ID: <CAHk-=wgiL88k26bmOXwkRojVUwkcGdXHBm2-+PwtXUja88+tEA@mail.gmail.com>
Subject: Re: [GIT PULL for v6.4-rc7] media fixes
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 at 04:17, Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> Mauro Carvalho Chehab (3):
>       Merge tag 'v6.4-rc4' into v4l_for_linus
>       Merge tag 'v6.4-rc5' into v4l_for_linus
>       Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend"

Please don't do those back-merges. Particularly the *pointless* ones
with bad commit messages.

I've pulled this, bnut your tree literally had three commits, two of
which were WRONG. Their commit messages were pure garbage.

Don't do this. Seriously. It's garbage.

If you can't do proper merges with proper commit messages, just don't
merge things. It's that easy.

              Linus
