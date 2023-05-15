Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19860703D04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244518AbjEOSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244019AbjEOSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:50:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C86C186E4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:50:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so2207338766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684176620; x=1686768620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ws6NzIXMgc6mtuL0Ev2TC7sDhpQ3niamKuQOa97Pto=;
        b=dNQf4mNQJGstaRt5HFm9NY1Z9cFlJtDx4rn4A6O1o9q2ytyz8Di4tln28hmXeMJjmY
         /OSWZHH37cvw1IJpldtRT00/l2c6li4yWoexs2ZIVXdBQAZf9y0tHdEXylJTYYngWuZ3
         8Lbewy36CG0002QuQawB1vuA0fRdseLywhGBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684176620; x=1686768620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ws6NzIXMgc6mtuL0Ev2TC7sDhpQ3niamKuQOa97Pto=;
        b=Z+QUs/krnhwixBBAp/bfBIpMn6pYwvmxtDbfYYBAevv9Swc0p9CgoLbvaUAz8Rik2N
         VcvlhizOr4h3TNHSRRp3OO68RhwEOuLOa7zrHHFL8j2Eu1MK1EILGbdVf53lvTh2+nD3
         RdTZHUEshKtDl9ycn6jojiOwyoDl6Dq9yvXAGnD8wwL29rA9NgRVA/t/efve7y/DDJoE
         Rn9QPxGLlBRpgFw8s7mTwXCd1kI3aTsz/eTnZVFcpSxAf06vjRS7IBNPdQfYMO55zmur
         5nfH0sgcgtigvxRBT8O6KJ8ubrdTljeC0yT7ifzKJ9h3TWEkXctZ09nBGiLTPcTZH/eh
         4w0g==
X-Gm-Message-State: AC+VfDwlmp4ZDur4l9g4ZPf+X1W/fybt5Ptxecha7y0dGsuqso6dSsnf
        UNhVdi/dPIaVXTeaidofIpDG+XJZeqRlb4Xd2P8hJR3i
X-Google-Smtp-Source: ACHHUZ78oA4gFMon+hTl1dQXbLCiEHudhT0RaZuDZZnHLI7xePZWgkBWw3HAspw+826I5lLBZPatBQ==
X-Received: by 2002:a17:907:d1e:b0:965:66dd:78f8 with SMTP id gn30-20020a1709070d1e00b0096566dd78f8mr34017380ejc.56.1684176620220;
        Mon, 15 May 2023 11:50:20 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id fh3-20020a1709073a8300b009666523d52dsm9969473ejc.156.2023.05.15.11.50.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 11:50:19 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso19366435a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:50:19 -0700 (PDT)
X-Received: by 2002:a17:907:7251:b0:969:cbf4:98fa with SMTP id
 ds17-20020a170907725100b00969cbf498famr24087257ejc.65.1684176619210; Mon, 15
 May 2023 11:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230420120409.602576-1-vsementsov@yandex-team.ru>
 <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru> <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
In-Reply-To: <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 15 May 2023 11:50:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
Message-ID: <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
To:     Christian Brauner <brauner@kernel.org>
Cc:     Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 10:55=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> So that open-coded 2 added in commit 9cb9f18b5d26 ("[PATCH]
> Linux-0.99.10 (June 7, 1993)") survived for 23 years until it was
> replaced by Jan in 378c6520e7d2 ("fs/coredump: prevent fsuid=3D0 dumps
> into user-controlled directories").

Hmm.

I can *not* for the life of me remember anything that far back, and
our mail archives don't go that far back either.

It's strange, because the "O_WRONLY" -> "2" change that changes to a
magic raw number is right next to changing "(unsigned short) 0x10" to
"KERNEL_DS", so we're getting *rid* of a magic raw number there.

Which makes me think it was intentional, but I don't know why it
wouldn't have used O_RDWR instead of "2".

Back then we did *not* have O_EXCL in the core file creation flags, so
I'm wondering if it was some half-arsed thing as in "do not allow
core-files to overwrite non-readable files in-place".

They'd still have to be *writable*, though, so that still seems more
than a bit odd.

I have this *dim* memory of us having had filesystems that required
readability for over-writing existing file data (because we'd do a
read-modify-write for the page cache, kind of like how you can't have
write-only pages on many architectures).  But while we didn't have
O_EXCL, we *did* have O_TRUNC, so that should be a non-issue.

I don't see a problem with making it O_WRONLY. Like it was 30 years
ago. But that unexplained "O_WRONLY" -> "2" annoys me. It does feel
like there was some reason for it.

                Linus
