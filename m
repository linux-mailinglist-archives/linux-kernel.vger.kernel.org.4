Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8B6F5F10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjECTYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjECTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:24:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8CF559A
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:24:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so10028380a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683141848; x=1685733848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnk0azjKtvGmutcc0sPTCISsVHec16NyojRU9ojJrvg=;
        b=YlhkUv7SObfAaRnJ7XfbPdseLmuLZeaBqb8t1qGSK4Mn1z/quP8XfCCUQbPKEmguM+
         SPx0HGQBOFZlOlHqyNwY+/GvkHv9G9CiRs+Rkd9j/4URGfBLVO4x8/0O8VEA+QHZWN+O
         HEykXtLO+DMYdnFT4AE1ETzt+yKvBXm/VlKxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141848; x=1685733848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnk0azjKtvGmutcc0sPTCISsVHec16NyojRU9ojJrvg=;
        b=fHct/Z5cP7FabzP7z6ALVDK/CBk6EBCQ1laPxlHkyRtj39SsCdCeQU04s/y5nrUEKF
         fIC5LJfg+ZanwsmY6LD67VVA+qakNtr6wLcLvTeh+Sw7jyHId0zRzNashiDjIkzdlwi2
         vxC9m7pBkqga3oB2wB986FJbJ9ffVsNyzQqjVyXMgA18e/YgCanc+w4cG4wLFgKWAVPY
         Ul3Aa0y4NPIOWalerDCaiag0v/cjZ/sqbzAYRhJ44dMhvP6ZpkFAKYIAvrH1Lw1io0qY
         1aVXd/zwtlA7fTkBdC+piC+Y47Pv5qMN0abq0p02c1J57mYkXBUAmsgLc7iwc3HR5sTo
         aJZA==
X-Gm-Message-State: AC+VfDyJ+xEhAdw9aacSXFg4l2b7oyHbuiwfmV+japXzolwm6AP2K7bh
        bkLCSkEz5Uvn9luqViTbQAow2V2DUQFmoNPOaVDxZw==
X-Google-Smtp-Source: ACHHUZ4Bna/CD0ncURHSKaixdWe85Ga57lYkqKqaPAwnG6ykZ/Cb3iSEup3INHxgzUwX3ScGHeIILw==
X-Received: by 2002:a17:907:3e8f:b0:959:c6cb:8546 with SMTP id hs15-20020a1709073e8f00b00959c6cb8546mr3202671ejc.28.1683141848026;
        Wed, 03 May 2023 12:24:08 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id bp23-20020a170907919700b0094f44bdf7acsm17829732ejb.57.2023.05.03.12.24.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 12:24:07 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so10028125a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 12:24:07 -0700 (PDT)
X-Received: by 2002:a17:907:98c:b0:95f:969e:dc5a with SMTP id
 bf12-20020a170907098c00b0095f969edc5amr2502183ejc.30.1683141846992; Wed, 03
 May 2023 12:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230503023329.752123-1-mcgrof@kernel.org> <ZFKKpQdx4nO8gWUT@bombadil.infradead.org>
 <CAHk-=whGT-jpLRH_W+k-WP=VghAVa7wRfULg=KWhpxiVofsn0Q@mail.gmail.com> <ZFKxl2d+kqYN0ohG@bombadil.infradead.org>
In-Reply-To: <ZFKxl2d+kqYN0ohG@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 12:23:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUizDLEhvHdM=7yUmdGMB--CGV1ynMSQrd0r7C06ALUA@mail.gmail.com>
Message-ID: <CAHk-=wgUizDLEhvHdM=7yUmdGMB--CGV1ynMSQrd0r7C06ALUA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sysctl: death to register_sysctl_paths()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 12:10=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> Sorry thought you don't mind a few patches, so ditched the formalities
> for the pull.

So I don't mind patches per se, and when there's a reason for them I
have no problem at all taking them.

The reason is typically something like "let's short-circuit the normal
channels just to get this trivial thing sorted out and we can forget
about it", but it can also be just a practical thing like "I'm
traveling so it would be easier if you'd just pick up this patch
directly from the mailing list".

Or it could be "I don't have a git tree since I'm not a main
developer, so I just send patches".

All of those are situations where I'll happily take patches directly.

But on the whole, when there isn't any real reason to avoid a pull
request, I'd much rather have the full thing with signature and
everything...

               Linus
