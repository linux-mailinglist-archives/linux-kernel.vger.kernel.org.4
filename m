Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46A6F93B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEFSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:53:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E039160BC
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 11:53:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso5780506a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683399214; x=1685991214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEGG4ECcZAyCqo1XIgGFB1QnJid3wS71S4I77W9mGF8=;
        b=cocDxGs6XB/b6nzG0IMXjMDF+UbL4smAz+yZrfei93lzQCkURr2D+nlzkSqVTvyv/0
         c+vx8jIgdVJ1p+EagHaE2Eybeu133yWHRvhqNfnkXlSFlZ+EomI6553XsHyYaF4EXP43
         2JgdggDt9FtI3JKFogbBT4ANHA/Bir0Qh92qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683399214; x=1685991214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEGG4ECcZAyCqo1XIgGFB1QnJid3wS71S4I77W9mGF8=;
        b=bM9+LFWVkK8wiW9v8vpFD40hwQpmjio38He98seY3UIFl1Ay/u19yF67+VVA0vZdOy
         kbt566E4lBiuqBb+8ezKKRsx0YAv+rZ0rToYMDZjep1Ypr+Gy5Ps4lKLQp9ewIf9VR4/
         EXXljiN5BgmSVNmfm1RPZafeAd0xd8E51pbn9sUbf3Od/ugmFeufExrVPCp7bOZMMjAn
         NxIr/oRayFPFqj97OffV0ZW0Q+pxEfUbOunfTNI7eUUZtNFKkHGLVkL28QaslV5KMpJ9
         FZ+pQ2crKoRT8ptW5s4XhoRjeA7Vkh01GAVsrE3wAYybcqnXiclA25aCwc3Bxfe6/Zpx
         cA9g==
X-Gm-Message-State: AC+VfDwd1PfsqfKbOS31nwB8PE7xGGF0yXb8GCoQV2ErHW4Sy5RIMB9d
        UhF12UOFd2dbv4ZWfzAoXci6Iy/j4tEckA6cVI2t3Q==
X-Google-Smtp-Source: ACHHUZ4NIB37PAubvLzwGx66j866ESGeZ0eX5qiAFnyiUIJzscz3zXSIrmjQzwHdX7Yju7cBxRlf2w==
X-Received: by 2002:a17:907:6088:b0:949:cb6a:b6f7 with SMTP id ht8-20020a170907608800b00949cb6ab6f7mr4683264ejc.56.1683399214620;
        Sat, 06 May 2023 11:53:34 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906560b00b009662b4230cesm625612ejq.148.2023.05.06.11.53.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 11:53:34 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9659e9bbff5so540967366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 11:53:33 -0700 (PDT)
X-Received: by 2002:a17:907:60d2:b0:966:1284:e3e with SMTP id
 hv18-20020a17090760d200b0096612840e3emr2378640ejc.9.1683399213047; Sat, 06
 May 2023 11:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230506105054.0155139b3d3a7f249ead37be@linux-foundation.org>
In-Reply-To: <20230506105054.0155139b3d3a7f249ead37be@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 11:53:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheZHs+15jtg68=Fjf0==xvfZ5rvTE00ii+MDUhWzxfgw@mail.gmail.com>
Message-ID: <CAHk-=wheZHs+15jtg68=Fjf0==xvfZ5rvTE00ii+MDUhWzxfgw@mail.gmail.com>
Subject: Re: [GIT PULL] dmapool updates for 6.4-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>
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

On Sat, May 6, 2023 at 10:50=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> Reinstate the dmapool changes which were accidentally removed by
> 2d55c16c0c54 ("dmapool: create/destroy cleanup").

Hmm. So this series is exactly the same as def8574308ed..2d55c16c0c54,
except for not having that last broken one.

Which is fine, but I'm a bit surprised. Why?

Because it's also missing the _real_ "dmapool: create/destroy cleanup"
patch, ie this one:

   https://lore.kernel.org/linux-mm/20230126215125.4069751-13-kbusch@meta.c=
om/

and I realize you somehow corrupted it last time, but I did expect it
to show up (perhaps folded into another patch, but in _some_ form).

Anyway, I've pulled this, but I think the end result of all this
confusion was still a tad broken.

                   Linus
