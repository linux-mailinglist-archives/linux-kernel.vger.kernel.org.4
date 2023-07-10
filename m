Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D919A74CF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGJHzO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 03:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGJHzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:55:10 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F63BB;
        Mon, 10 Jul 2023 00:55:09 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5728df0a7d9so54696517b3.1;
        Mon, 10 Jul 2023 00:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975708; x=1691567708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoVR0Ww3NqQWB+CsUodfgver6HRm/NVni4uz6vfXOaM=;
        b=DvvjbayuwxXBWUvWxqUTcUYEIFkEmJkA3oJzU5zv3bQUjrCJ3XCimdgBSWI3mnMG+V
         QQlD3pJBUK+/hvtRMDwEUvA2SCSdFjt9rhkVPfYrPeF0IhN3Wlht8WItQQL9nB9gWa2v
         egvifc/mCk+8lsDgZb1+E3Y1B6WQUX33xp2Ddrd4GAHZAlnWUWMa+LuBNFtXWWXI2rBJ
         e2gWf5ZNB9ms1AnwB5ZF0fQtJmRHnORXTH6l3/mTRJlqV4wZfFuUs6ujPEoLo+/xjLbs
         oVOW2A+qRwK4mGi/5QzaITj/kPzpFh3SJVxSNu/ZJuoPlb06N83vUnbzBX+3EgXDDZsY
         03rA==
X-Gm-Message-State: ABy/qLZTOM1C6lHumhrESV1WUz5hd6rvCKf8vsSWtUyb2koN+u/9ys3O
        +H3FTfabOlXMSFByFQHl0qvj3vKNC9w0tQ==
X-Google-Smtp-Source: APBJJlHxpb+mLx9F04KFHepLfDhlnPl3f2B2fwdW00P+4hU75r5eDtlIcFL79fm4+b6KCMVJN0OFlA==
X-Received: by 2002:a0d:cd81:0:b0:577:3bf2:80f0 with SMTP id p123-20020a0dcd81000000b005773bf280f0mr12617690ywd.2.1688975708424;
        Mon, 10 Jul 2023 00:55:08 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id p135-20020a0de68d000000b005707d7686ddsm2927995ywe.76.2023.07.10.00.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:55:07 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-c17534f4c63so5503876276.0;
        Mon, 10 Jul 2023 00:55:07 -0700 (PDT)
X-Received: by 2002:a25:c343:0:b0:c16:8d80:228b with SMTP id
 t64-20020a25c343000000b00c168d80228bmr10199701ybf.37.1688975707771; Mon, 10
 Jul 2023 00:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
 <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net> <CAMuHMdW=WDuqgXk_51T341vgXrcxYPO34ou=rKHZrZj8Yiw6Rw@mail.gmail.com>
 <f27872c8f374a42fb7ea313314c47cdba2473b06.camel@physik.fu-berlin.de>
In-Reply-To: <f27872c8f374a42fb7ea313314c47cdba2473b06.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 09:54:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXg1FvMCSBCvs=aFah0NWdOzEX+XdF4af0kY3kNx2bPtg@mail.gmail.com>
Message-ID: <CAMuHMdXg1FvMCSBCvs=aFah0NWdOzEX+XdF4af0kY3kNx2bPtg@mail.gmail.com>
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL demux
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Jul 10, 2023 at 9:44 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2023-07-10 at 09:03 +0200, Geert Uytterhoeven wrote:
> > Indeed, I hadn't tested that.
> > My current tree isn't based on linux-next, but did have a build
> > failure in the cdrom code, for which I had found your fix (thanks!) in
> > linux-next...
>
> So, there is a patch for this already? Is it going to be included for 6.5?

The cdrom fix is commit a587b046ce921cc1 ("cdrom/gdrom: Fix build
error") in v6.5-rc1, which builds dreamcast_defconfig fine.

That config is still broken in linux-next, but the breakage hasn't\
entered v6.5-rc1 (yet?).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
