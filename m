Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3964A716
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiLLS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiLLS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:27:00 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8516FD3C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:26:58 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id o136so364104vka.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xEeQjfOgxbzzuaCvVlasz+hixVSsIOY5Hq7uOvYrjTw=;
        b=G/lMCGnwSgD2+sFVg10enKajkr8vBOrkI8HGGYzC+7tFr+yNjLAXYB+AROvSybglDN
         L2S66nnGmj59HcxJFOg5xBV5CTxSOE76KQUQkMiaajTd6cAZRHZ0c0oqz59kck42LTCT
         obxUBb4la276ogjOC/Vg6+xoJSO2uChD5M/mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEeQjfOgxbzzuaCvVlasz+hixVSsIOY5Hq7uOvYrjTw=;
        b=fuHOh9HKkg5eACWp4DW5q3nowcU1Xfyrf9/0INgyA6ol/pJpojpJnhah210elqcC7f
         xghH1yOFHimcDzqxRlT5SoHivm2iCHMK+kymMZNZ5D68TovkXPiqPHoCPwP0XS4UYq1q
         kYuNhOdaH4pMh6x3PE0fQ2gNn0F2NQm91rcDsH0GkxjcKUCobcDpcD0qXrjPgt6vUM5q
         anJuWPE7fIuAZ4di2SHgnc3wbxV0r3x79m5L6FiV835qH0Fpi2K+N5rFmY3IuknehwoI
         R/U+Q6pNkKCtbneiQacz8QeG045VgttaEBdX63af6YdITw4qqP5zthKad1lzG+dy4Ams
         6kMg==
X-Gm-Message-State: ANoB5pnh6rvfBEyjDtvDcJulu3xwA114oyiaQeUZKaQ0ynKNr/9UW3je
        SmcpGOgNoq0rOECtdXoiHb4jjJo+YgAbk/Uz
X-Google-Smtp-Source: AA0mqf4orucDyY7RYQy955z0swBsAcoV/Hyfjnl6mhPrGTCIUIHRXKqi8gIbcgLauz7OB7ukgMhVyQ==
X-Received: by 2002:a1f:4343:0:b0:3bd:90ef:d63f with SMTP id q64-20020a1f4343000000b003bd90efd63fmr7592108vka.15.1670869617346;
        Mon, 12 Dec 2022 10:26:57 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm6252985qkb.77.2022.12.12.10.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 10:26:56 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id a16so9701120qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:26:56 -0800 (PST)
X-Received: by 2002:a05:622a:5a87:b0:3a5:47de:a214 with SMTP id
 fz7-20020a05622a5a8700b003a547dea214mr70877944qtb.304.1670869616205; Mon, 12
 Dec 2022 10:26:56 -0800 (PST)
MIME-Version: 1.0
References: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com> <02be69ef-cfae-4455-a428-f95517d374cb@app.fastmail.com>
In-Reply-To: <02be69ef-cfae-4455-a428-f95517d374cb@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 10:26:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgy2kMzPGturhFGethpnzWBX8Guzna98tSOorNpM0ZEEQ@mail.gmail.com>
Message-ID: <CAHk-=wgy2kMzPGturhFGethpnzWBX8Guzna98tSOorNpM0ZEEQ@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] SoC: DT changes for 6.2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 9:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>  - The Apple T6000 (M1 Pro), T6001 (M1 Max) and T6002 (M2 Ultra)
>    chips now have initial support.

That T6002 is M1 Ultra, not M2 Ultra.

                Linus
