Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4770AF71
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjEUSJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjEUSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:06:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00CF1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:06:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f5d651170so559994566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684692396; x=1687284396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMadGmvjqp8xzF2NAhfvAfuBYa9KMMmlXCO3kEDZwAM=;
        b=gn/sLYZphidGrvrDMOxCRbNY8HB6uvZE1TDJyvj5zI1D4eu0GDCGAL1Ax7ihd1UxZV
         BfFKctjP5JYxO2a80fJoAhXhijFT+xt92v1Nna7mMBwlRGO0CwZh+tFyiUQOL6RfIxPS
         uRXgQ94R/JckRuiW0G27YJj1L48k+tXNmv4AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684692396; x=1687284396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMadGmvjqp8xzF2NAhfvAfuBYa9KMMmlXCO3kEDZwAM=;
        b=bVFxML8xVXoXc7qZqUa2MItkUpvQKn9FuRX0YGmpLV/suMfRW5DUEZcP4aMsU6+3hM
         3yGxmceNsixDGJKA+ccVDg4D5dkrZxzXZyeskTqng3BfHLkF6SOawKoFwobYdwsUfI5W
         PAnsAq1C4Rtd6vL7LzXlQ4CtbB6gpmMRquhf8M138imw8aR/DSCEYXCRpKs7rwDqcQHs
         YNl/6AWjJQqycs+ndrDem3Vsny8iz6cje+FZIpLzuRbD8ejXHQUtCo2cenIxRJz+s0UK
         c1KILfi6hg239h63sS/9WROR4ggKe1sZfDLax/kO0lwI/uVvmGIvL7vuwavmjthETkRN
         SB6Q==
X-Gm-Message-State: AC+VfDyUAfLm1CIYV+OdnP1nG0+2vKdX328IADxEjQGqcYIjcs9K2f9Q
        0sGPaoGUheEkRhKfMWGYM1oa2jXGBqNVOXaDsi3pPA==
X-Google-Smtp-Source: ACHHUZ7e3Dk7sVCuQHUsN0UEmLiF4hstZHQP68FO6Q5NOQco4swCmOa7GHDSkRrTexv2sahCfTEoSw==
X-Received: by 2002:a17:907:7ea3:b0:966:399e:a5a5 with SMTP id qb35-20020a1709077ea300b00966399ea5a5mr7279018ejc.35.1684692395727;
        Sun, 21 May 2023 11:06:35 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090680ca00b0096616adc0d5sm2108668ejx.104.2023.05.21.11.06.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 11:06:35 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so5527928a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:06:34 -0700 (PDT)
X-Received: by 2002:a05:6402:3593:b0:513:62de:768a with SMTP id
 y19-20020a056402359300b0051362de768amr2856862edc.19.1684692394687; Sun, 21
 May 2023 11:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
In-Reply-To: <CAH2r5msxkE5cPJ-nQCAibJ+x+hO7uSLpasGm81i6DknQ8M5zWg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 May 2023 11:06:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiStOAKntvgzZ79aA=Xc0Zz7byoBxBW_As5cmn5cgkuoQ@mail.gmail.com>
Message-ID: <CAHk-=wiStOAKntvgzZ79aA=Xc0Zz7byoBxBW_As5cmn5cgkuoQ@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server fixes
To:     Steve French <smfrench@gmail.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 10:14=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> Four ksmbd server fixes:

This reply is not really directly related to this pull (which I just
did), but more of a reaction to getting the cifs and ksmbd pulls next
to each other again.

We talked about directory layout issues some time ago, and there's
kind of beginnings of it, but it never happened, and the parts that
*did* happen I'm not super-happy about. That "fs/smbfs_common/"
subdirectory is just fairly ugly.

Would you mind horribly to just bite the bullet, and rename things,
and put it all under "smbfs". Something like

    mkdir fs/smbfs
    git mv fs/cifs fs/smbfs/client
    git mv fs/ksmbd fs/smbfs/server
    git mv fs/smbfs_common fs/smbfs/common

plus the required Makefile editing to just make it all build right?

And if you prefer just "fs/smb" over "fs/smbfs", that sounds fine to
me too, but I guess this all really does just the filesystem part
(rather than all the printing and whatever other stuff that smb also
contains).

I dunno. I just feel like the current organization and naming is this
odd half-way state, and we could just fairly easily do the above.

I could do it myself, of course, and git will sort out any rename
issues. But me doing it seems silly when you maintain all three
pieces.

                 Linus
