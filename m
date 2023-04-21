Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581026EA4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjDUH35 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjDUH3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:29:53 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE12132;
        Fri, 21 Apr 2023 00:29:51 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b8f549d36e8so2246155276.3;
        Fri, 21 Apr 2023 00:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062190; x=1684654190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtuOdz7tU5+YoOdrdSdLBBwOK8V97jXWFycy5r6znBE=;
        b=GEWJdIxw4/jDX6EbMvYnk48qkdY4wPdPWBOvxV5bMIlQNd/SuSkLGJt26fjJegzgF3
         jnUXAPlABEVLqDbrGPd9GQMr3CgIbnACRIsRwg6rMgF/NYxX6mBJhtmxiZoSJmjOjvkU
         krwSRePaA9gZxR5VKKIFHuT6sIYFrCHs29rbKAz84t/DhMDPpJomY0s6aoBlJVC2CTKf
         XGqswM2nHPmwLzG+Zw+zA2rYdt0f8CcA5CtKlj38IDpgqOi6SKzAWgLwErgyqxDCvFj4
         NpbiuGSROfhZzvAi55L6PK1ECFQLdtLGlo2AR1NIY/YFSFs3LyGgqXI9MJryZEkgmeQQ
         EJ2Q==
X-Gm-Message-State: AAQBX9exw/O4rruUgkeFkeszUF1qWqe3twDdWnvfFa1FwUsvv6QWwxgK
        RSQScvmtz9L8sXbbTg28SEog8fKFtFlIVXMl
X-Google-Smtp-Source: AKy350Y9ehpan2PHH1CyBB9KHWFQIvC4H/B/ypkMUdyZAmybOatR+niH6Dl1gOreOlA6H5Ea3/lj6Q==
X-Received: by 2002:a25:c094:0:b0:b8f:4c0a:b28d with SMTP id c142-20020a25c094000000b00b8f4c0ab28dmr1390167ybf.46.1682062190524;
        Fri, 21 Apr 2023 00:29:50 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id a3-20020a256603000000b00b8ed4bee6absm793002ybc.48.2023.04.21.00.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:29:50 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-54fe25c2765so20675667b3.3;
        Fri, 21 Apr 2023 00:29:50 -0700 (PDT)
X-Received: by 2002:a0d:fec5:0:b0:555:c5d2:1647 with SMTP id
 o188-20020a0dfec5000000b00555c5d21647mr1040236ywf.31.1682062189819; Fri, 21
 Apr 2023 00:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <a51e9f32c19a007f4922943282cb12c89064440d.1681671848.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a51e9f32c19a007f4922943282cb12c89064440d.1681671848.git.christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Apr 2023 09:29:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXN2Lv_O1cRqUofDrn-4Xe9o-ex81KmojDWBqyiBVwGmw@mail.gmail.com>
Message-ID: <CAMuHMdXN2Lv_O1cRqUofDrn-4Xe9o-ex81KmojDWBqyiBVwGmw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: sq: Use the bitmap API when applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-sh@vger.kernel.org
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

On Thu, Apr 20, 2023 at 9:41 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Using the bitmap API is less verbose than hand writing it.
> It also improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2:
>    - synch with latest linux-next because of 80f746e2bd0e which fixes a bug

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
