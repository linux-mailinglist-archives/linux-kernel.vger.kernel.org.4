Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5396BE1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCQHbp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCQHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:31:43 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7D5DED0;
        Fri, 17 Mar 2023 00:31:42 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id nf5so2937546qvb.5;
        Fri, 17 Mar 2023 00:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679038301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMB3J7B4hlrT9mhXUscO5sBBCJxNzjig1/uX/KDTJCk=;
        b=zi+z7eUCNqEYwaqhJnqjiWQsbXq/8c2jdvguIlrksUhR9qAVFzAuD3JTD8ZaiW3OJ0
         N/jxC/ujag0ffYIewXvoPnAw7uIAm0IaiLgOZYIPb+oDF4PjOf95Catz68qBtQ+FGVo6
         b1lRYiYv9GLrz5/wDyQop/DcpTu2Kodq99OFI1XfcFvE/ucuX202gsVGjmmV0c9HbNry
         X3kbnjNwqOFSoVTNXqh/vtA9Rtv1OpYU7Tk76VdoAmaSv1gyEksCUOFZSHE3lfBzwIoC
         7izsoPC7w4Z3TV9Foavqxg37dNnX9RwPYUU/mBaZw4gIbHQwIpJEdhypkzYLRyrOej94
         PMXw==
X-Gm-Message-State: AO0yUKWGhybxysU5d0wSf//lK04oZMrfQubPUsguhzDP2/lPzFNgcl29
        o0VQAERKzun6E4l9Zu6aJWd0CLXztpjz2uLp
X-Google-Smtp-Source: AK7set94XjcG7Vm2yCU5BSZSSpWszOZeke66tzcDrKLtLEOIm7WxNNOhi6zxplrzT1beRwIHUWGWcA==
X-Received: by 2002:a05:6214:c65:b0:5a9:3882:f4c9 with SMTP id t5-20020a0562140c6500b005a93882f4c9mr3563804qvj.5.1679038301257;
        Fri, 17 Mar 2023 00:31:41 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id t184-20020ae9dfc1000000b007424239e4casm1144841qkf.117.2023.03.17.00.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 00:31:41 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id v196so4622680ybe.9;
        Fri, 17 Mar 2023 00:31:40 -0700 (PDT)
X-Received: by 2002:a25:f507:0:b0:b3b:6576:b22b with SMTP id
 a7-20020a25f507000000b00b3b6576b22bmr11552491ybe.12.1679038300479; Fri, 17
 Mar 2023 00:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <ef8fbda8-cace-1db3-9161-abd2e75dcf13@infradead.org>
 <A8D501D3-68ED-4112-BDA7-EE67357A2E28@physik.fu-berlin.de>
 <ca94954e-88ea-6707-d2a5-722e589d0c87@infradead.org> <50863bc8642d52f1533ad5809ae2dcd690e2493b.camel@physik.fu-berlin.de>
In-Reply-To: <50863bc8642d52f1533ad5809ae2dcd690e2493b.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Mar 2023 08:31:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaZEWxB9Opgt2wcD2xAqF9Jv4r4KY9RGaR7vVVFXs5NQ@mail.gmail.com>
Message-ID: <CAMuHMdXaZEWxB9Opgt2wcD2xAqF9Jv4r4KY9RGaR7vVVFXs5NQ@mail.gmail.com>
Subject: Re: [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Mar 16, 2023 at 9:46 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-03-16 at 13:43 -0700, Randy Dunlap wrote:
> > > Oops, sorry. My bad. I will use the proper tree.
> >
> > Just let me know if you want me to resend it.
> > Thanks.
>
> No, that's fine. I will rebase my for-next tree.

Rebase on top of what? Commit 49deed336ef9a409 ("parisc:
update kbuild doc. aliases for parisc64") is in the parisc tree.
You must not base the SH tree on the parisc tree.

Don't care about the simple conflict, Stephen and Linus can
handle that fine.

FTR, if the conflict was more complex, an immutable branch to be
merged by all parties would be appropriate.  But that's overkill and
thus not needed for simple conflicts like this.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
