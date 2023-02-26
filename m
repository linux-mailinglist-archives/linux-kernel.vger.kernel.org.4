Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7576A3389
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBZS6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBZS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:58:50 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABD58A7E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:58:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h16so17245998edz.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euEYr+aEqxi2MZsla4irIlbr81F8Y/rQgPcXv2JYmC4=;
        b=OMV2yy5/qDnAk5uxG4huXHzGZGDFql6n50QxVL5U8Tf9HbCJJ+fDVaFdlQqBLQG0aW
         MK2yau+Bn7qF+ptc8Q4mxzJKDAfjTNLgZThoM6iY9mvmHSUlFppqmOBef/qfQcu9sYit
         MMu08voc5G9enl9MMPKCGwVn3eDEUk67DyEmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euEYr+aEqxi2MZsla4irIlbr81F8Y/rQgPcXv2JYmC4=;
        b=WhUV64cFoKiEJ42zngo2yALAnikmWbVMOiH9W6Y4xgZaQUGQGN5htyO0RNO0aouosF
         uxEMLOWIgdP5n94H7je7PF48GXNJ91M9PlYwuDYDDj9/kHtykN9+nAuyG5qKLkjG0CyZ
         PKluQUInXQdOOKkxRKceYxWMJaQFqDySgjsXjkGdfMwX4GlWox8AbCcNGUY04dBqr0+1
         iv2ZQUTXranzeWuaQAFIVByTY9zIZNjoERvG89ZuLfQ3rs2AwWbO+oHjD0aRBWv44trF
         vKZHzpxK/kX3DukVmmt4M8/EikyfuSuwVQ6RkSX5fNajnoT6Am9V7932cVc5FdqJfJBW
         42Rw==
X-Gm-Message-State: AO0yUKURSOCLdg5l2cOOpjPKkJWAEB0BICZrEeoUNiACUbRCKjzPsea3
        CjOcp0MKMPFjEmZQJ6fwaQr0gUkDdu3tkfkAYzpSmA==
X-Google-Smtp-Source: AK7set/5dwYaXgPCl/9ZoGS1ebxgXTdPlju7xW5V9A2NPhe1nzaVI/LAPnKdIMzYdX6zTP//ViknYg==
X-Received: by 2002:a17:906:34da:b0:8b1:3a91:73ec with SMTP id h26-20020a17090634da00b008b13a9173ecmr32407691ejb.68.1677437926862;
        Sun, 26 Feb 2023 10:58:46 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090652c100b008cc920469b5sm2279247ejn.18.2023.02.26.10.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 10:58:46 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id ck15so17569243edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:58:46 -0800 (PST)
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr14342318ejk.0.1677437926047; Sun, 26
 Feb 2023 10:58:46 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
In-Reply-To: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Feb 2023 10:58:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com>
Message-ID: <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.3-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 8:34=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Masahiro Yamada (46):
>       kbuild: add a tool to list files ignored by git
>       kbuild: make perf-tar*-src-pkg work without relying on git

I've pulled this, but I really object to these kinds of silly games.

That whole list-gitignored thing should go away, and silly
work-arounds for "I don't use git" should likewise just be killed.

There's absolutely _zero_ exzcuse for making our build tools more
complicated for bad reasons. The "I don't have git" may have been a
reason a decade ago. It's *not* a valid reason today.

People who insist on using quilt etc should just realize that then
they don't get the featrues that git offers.

You can't have your cake and eat it too.

I do *not* want to see git functionality basically duplicated in some
kernel C helper script just because somebody can't be bothered to just
use git.

              Linus
