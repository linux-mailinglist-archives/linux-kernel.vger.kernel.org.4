Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7880702A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbjEOKLw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 06:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjEOKLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:11:50 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8717B13A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:11:49 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ba7854ff5abso2635298276.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684145508; x=1686737508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RSc3ehTcfUtTwTGi8/DXlWstgHILWkp+xdTMczEuPw=;
        b=ROlKWKsU7jw7wFBe5rkYyccyGWgKcnHgBRWPWTFCC3fPVkE6AeO0xEAfbROtRCpJfg
         dhQv9VyVQDqacCRgRghA1hUh0kxh6u1rjySMFPuBLruIGp2wvRchwLe3CFTrOJ/QTpvw
         Fxl+I5xGhxmHeIrwmNyoYudQxoe14KBF8D+s8rFgvqRoptS2DnDv9+1twNklQNm1s1mR
         B6d99JqrIu5fZCX1BRw9sNhsCLQZ7zG1bJFU0Nw5DA9fYDE3ADyvfhQvlFkzcEr7B9Ga
         pqCdjtspMug4AE6CHo0VYTxvPeZLTi0drGpeByTepOYEg+VR92f/ZDDTi/2fQIY8LEKl
         8ixQ==
X-Gm-Message-State: AC+VfDzt4x0NvaCWchb4/SpiJjeBWiSXFfefretcYVtKPnY0DFMWqm0k
        h+zYDhYyMTLhgPAX+UoGq3EaNFPZdFhhkw==
X-Google-Smtp-Source: ACHHUZ6eu3YZXJQ2FeGU/QDRPCK4ffJaDDr6mpIslYOpOt4krzYRP/1+n6oR23Zz4juW/xay2m0KRw==
X-Received: by 2002:a81:8490:0:b0:560:e0ce:ac7c with SMTP id u138-20020a818490000000b00560e0ceac7cmr14043032ywf.43.1684145508511;
        Mon, 15 May 2023 03:11:48 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h123-20020a0df781000000b0055a382ae26fsm6807510ywf.49.2023.05.15.03.11.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 03:11:48 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ba7bf25a010so1518507276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:11:47 -0700 (PDT)
X-Received: by 2002:a81:6689:0:b0:55a:8c02:bfea with SMTP id
 a131-20020a816689000000b0055a8c02bfeamr32799250ywc.19.1684145507540; Mon, 15
 May 2023 03:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <1296c4d691bba057291246f067c191ef8a88531c.1680667933.git.fthain@linux-m68k.org>
 <CAMuHMdXLsnfQ4XhJiuE54BjGaCMAxvzOR+GGB9iFD8pYXprfxQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXLsnfQ4XhJiuE54BjGaCMAxvzOR+GGB9iFD8pYXprfxQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 May 2023 12:11:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSYDUOy0CSrRcv5-R8rg6EdXMaG5SHiTcYuaNa7K5e1Q@mail.gmail.com>
Message-ID: <CAMuHMdWSYDUOy0CSrRcv5-R8rg6EdXMaG5SHiTcYuaNa7K5e1Q@mail.gmail.com>
Subject: Re: [PATCH v4] nubus: Don't list slot resources by default
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Brad Boyer <flar@allandria.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Mon, May 15, 2023 at 11:44 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Apr 5, 2023 at 6:19 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > Some Nubus card ROMs contain many slot resources. A single Radius video
> > card produced well over a thousand entries under /proc/bus/nubus/.
> > Populating /proc/bus/nubus/ on a slow machine with several such cards
> > installed takes long enough that the user may think that the system is
> > wedged. All those procfs entries also consume significant RAM though
> > they are not normally needed (except by developers).
> > Omit these resources from /proc/bus/nubus/ by default and add a kernel
> > parameter to enable them when needed.
> > On the test machine, this saved 300 kB and 10 seconds.
> >
> > Cc: Brad Boyer <flar@allandria.com>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> > Changed since v3:
> >  - Better commentary.
> > Changed since v2:
> >  - Added commentary.
> >  - Moved declaration to nubus.h.
> > Changed since v1:
> >  - Expanded to cover all slot resources in procfs.
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k for-v6.5 branch.

Upon second look, "populate_procfs" is too generic for a global
variable.  Please add a "nubus_"-prefix, and use module_param_named()
instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
