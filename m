Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47E68012B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjA2Tch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjA2Tcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:32:36 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DFF1A49D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 11:32:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so2859255ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=731c7w/fO+KMHGo0w8O/rvDRhDiYETDvCd48ycqNrIY=;
        b=U6OH8YqWvPH8uv2AxM2xB52mih92LQ7Afl+E2hHmSDXDqLOLgW5OulvgkmnZuIpU+k
         Pjzj/Xq45PGuLPJqJVAH0IxNpST/xk98h2JKXncEiOO7zAmzeE1sIZOUrgLXVO3ZL2tX
         PX8vjC98zcRUeZ/sp0spcJVMd2QMrQSnpF/2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=731c7w/fO+KMHGo0w8O/rvDRhDiYETDvCd48ycqNrIY=;
        b=izNP1PrJTcr5B2X3/V6M2dL3kTQ/wsUIBPg2rvkhGvR/ASKdpKp3gEy8yau/pzNRJH
         uIn+qyEENci5a9cSz2gu32MLiSA13El6ynN7AMNtrZo4Udv812Dqbwg7rkIIV8qx7HER
         F/dMwILkLHXqAVRHUcu5FqV/sTNNSiDHS+8hraNvIQ2pZa7QQzc0V/8Hx92x7VhFPME1
         smquYfv0aKAR7QJ9MVrrkALBpxDYU0q+RV1oqZhLWZ6LqDj0y+vsduPKlpGcKLoTmPNz
         Yuo+hc8lrUaa3vENKTSouIZcVjJ/rnA0gFkt6IqODgsp42KnvDn0/ADe+ZBh23yQzfrF
         lg8g==
X-Gm-Message-State: AO0yUKUHgeWtJyrlarVIpfnWSDVVf1eupYir0kzqqDX6F3Mh6wRfPD39
        aYoxcWEvv4g00O5ksY4Kxm7p2rRf/vY/IknbYDE=
X-Google-Smtp-Source: AK7set+UPXn9rReyK/g/Qkb9d/3uVjlL7zTd167edKxtZHEtX24Ll/l86DwDOuVto9fEeKSlpmStXA==
X-Received: by 2002:a17:906:5d09:b0:886:221b:44de with SMTP id g9-20020a1709065d0900b00886221b44demr5015678ejt.0.1675020753346;
        Sun, 29 Jan 2023 11:32:33 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ke8-20020a17090798e800b0084d4cb00f0csm5783385ejc.99.2023.01.29.11.32.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 11:32:32 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id me3so26397920ejb.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 11:32:32 -0800 (PST)
X-Received: by 2002:a17:906:1e94:b0:889:2908:a9c8 with SMTP id
 e20-20020a1709061e9400b008892908a9c8mr81182ejj.82.1675020752273; Sun, 29 Jan
 2023 11:32:32 -0800 (PST)
MIME-Version: 1.0
References: <167501403214.1314424.14370223374691112185@leemhuis.info>
In-Reply-To: <167501403214.1314424.14370223374691112185@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Jan 2023 11:32:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnBBJ7hDSz5T+2FMF0JhE1Jmf6=tZEytQ6n1jZ4m2s=w@mail.gmail.com>
Message-ID: <CAHk-=wgnBBJ7hDSz5T+2FMF0JhE1Jmf6=tZEytQ6n1jZ4m2s=w@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-01-29]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
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

On Sun, Jan 29, 2023 at 9:42 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> * Andrew afaics didn=E2=80=99t sent a revert[1] from Vlastimir your way

Ok, I applied this one as tiny and clear and hitting actual user loads.

> * A fix[1] for a stack_depot/kmemleak issue is in next for a while alread=
y too[2]

This one I left alone, since it's a bit more involved and the use-case
is more esoteric too.

> * a fix for a spi issue[1] is also sitting in next for two weeks now :-( =
#sigh

Leaving this alone too for now.

And in other news, the input regression revert you mentioned earlier
got pulled this morning.

               Linus
