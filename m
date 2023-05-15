Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69DB702971
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbjEOJqI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbjEOJpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:45:19 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF37E79
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:44:50 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-b9dea9d0360so16584071276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143889; x=1686735889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfFE/qiRkN557/2I5XaanSNXOAZ3eFVDGQ65E3a+VhY=;
        b=eOGFHz1BY67FKSOAw16kbFMRbsbm8dY5Izlh7ngGUIJ2MhmcpOavU6qfaE9VU/W36v
         MV6mRRBlljqxEflu4pqI6F7xU0FRXNFWtBY/8XFqrvrUq5kLOv4Qvb+VrE5Ofqjppl4z
         7jEL60rSnORm71LK4NuVmrJ4D/P9J+khOuyhxitdsu+iG+WHx4HHDq07QKkHgXAHuNj1
         lnxfU8IJXnQ6Jlxmj1aRnA8MiqlUU3JgsqyS3Pk1/dQ8QkHTmLdpFXbLeEmSUD0Kdmyz
         Awy5mnSdLpRwo/4WKC+wmP8EHO+kfhNn5stY3jM+aAq71YYzSiR4L0pDEwhMnsdNGANQ
         AWvA==
X-Gm-Message-State: AC+VfDzllWFzJvQ2wcR3ttJYC+eEFt2AthThV0cvgKyxI5uUDyt19YVV
        ncvbPmAbgZSFaJ2o6ujzwA6M/fFx7u4ujg==
X-Google-Smtp-Source: ACHHUZ42QFb5GpRA2P/oLJrUAZzZNpLdoaisSUJUWBDz8TmwrDvv155otu3wPr5pmJgHzA639RRLNA==
X-Received: by 2002:a25:c7c3:0:b0:ba7:86c2:d95c with SMTP id w186-20020a25c7c3000000b00ba786c2d95cmr3869710ybe.64.1684143889180;
        Mon, 15 May 2023 02:44:49 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id z14-20020a25bb0e000000b00b96a0d1a0a7sm6771287ybg.11.2023.05.15.02.44.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:44:48 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-559debdedb5so186439787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:44:48 -0700 (PDT)
X-Received: by 2002:a81:9c10:0:b0:559:e974:82 with SMTP id m16-20020a819c10000000b00559e9740082mr33480420ywa.20.1684143888518;
 Mon, 15 May 2023 02:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <1296c4d691bba057291246f067c191ef8a88531c.1680667933.git.fthain@linux-m68k.org>
In-Reply-To: <1296c4d691bba057291246f067c191ef8a88531c.1680667933.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 May 2023 11:44:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLsnfQ4XhJiuE54BjGaCMAxvzOR+GGB9iFD8pYXprfxQ@mail.gmail.com>
Message-ID: <CAMuHMdXLsnfQ4XhJiuE54BjGaCMAxvzOR+GGB9iFD8pYXprfxQ@mail.gmail.com>
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

On Wed, Apr 5, 2023 at 6:19 AM Finn Thain <fthain@linux-m68k.org> wrote:
> Some Nubus card ROMs contain many slot resources. A single Radius video
> card produced well over a thousand entries under /proc/bus/nubus/.
> Populating /proc/bus/nubus/ on a slow machine with several such cards
> installed takes long enough that the user may think that the system is
> wedged. All those procfs entries also consume significant RAM though
> they are not normally needed (except by developers).
> Omit these resources from /proc/bus/nubus/ by default and add a kernel
> parameter to enable them when needed.
> On the test machine, this saved 300 kB and 10 seconds.
>
> Cc: Brad Boyer <flar@allandria.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Changed since v3:
>  - Better commentary.
> Changed since v2:
>  - Added commentary.
>  - Moved declaration to nubus.h.
> Changed since v1:
>  - Expanded to cover all slot resources in procfs.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.5 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
