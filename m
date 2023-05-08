Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8C6FB50B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjEHQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjEHQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:27:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74E4C0C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:27:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso856631666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683563267; x=1686155267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVAb8RwSaMOd+9poMiDAevwfkVDh6+GTnWJJXhYlKlU=;
        b=YygbuWtNNJDGGTerxd1XY58zcRT8L+jhp2xHX2PSueoIB3Ny3YlOCIl/xU7trGiGqE
         YEpymOVxo4hEirocz0sCTP4XTn2gsHAYRHgucTxQCGYHvSgWr3lncMSuSDnTA0SkgFq8
         iDIVvGrQ2E0NdKPmBKA6GEo8qraxogjKCMmNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563267; x=1686155267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVAb8RwSaMOd+9poMiDAevwfkVDh6+GTnWJJXhYlKlU=;
        b=it9NHcg+Rj6jXYTRppg9mAD0TqhJTyW9GVR6rCHAVo5yxe5oE+p/338aP+VcjMQogC
         lRzNzBkOfR82VlLZ0gKO1i0lmddi+23DnnEjTwLZONXOWJKRq6RC2JwzS+aCRehi9ki0
         iheVYz4kliebMaNj5iPyIv9u8z8orNzEswKoCkk0aau2hsPrwB+Gq13gsNcqv1nKZreU
         +nlLcB1ZU6usZTTYysxKGB9OmqZ9V82wvBT28R0EN+GlStCs0XYzyZmOnfAa+y5dQRuL
         X0NTSjwdXT7TD8AykJIqcd2uOrhg5paYlgnooUF9xSHoQbS9KmifLBkGLEBozpJOv1Lq
         JUXw==
X-Gm-Message-State: AC+VfDw7bb62DsQbS7rmGsL0KBO9kXi3SjV5Nx625+ID5uue0K5kCRtx
        +Wfi2Br6beVb1GCalbqyjN1QodVC9WKGC22W2D5ngQ==
X-Google-Smtp-Source: ACHHUZ4mWgpXxnwqilWjrAmKC2P5SohsvIv3C1E+D/V3POadHyodsjElKr9+HMRL9b7QjuUR3/vRmw==
X-Received: by 2002:a17:906:ee84:b0:94a:549c:4731 with SMTP id wt4-20020a170906ee8400b0094a549c4731mr7723942ejb.57.1683563267250;
        Mon, 08 May 2023 09:27:47 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906195000b0094e96e46cc0sm166276eje.69.2023.05.08.09.27.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:27:46 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9659e9bbff5so857858966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:27:45 -0700 (PDT)
X-Received: by 2002:a17:907:8692:b0:967:142b:ff07 with SMTP id
 qa18-20020a170907869200b00967142bff07mr3121227ejc.21.1683563265068; Mon, 08
 May 2023 09:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZElaVmxDsOkZj2DK@debian> <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
In-Reply-To: <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 May 2023 09:27:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
Message-ID: <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
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

On Mon, May 8, 2023 at 3:55=E2=80=AFAM Linux regression tracking #adding
(Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>
> Thanks for the report. The fixes (see the mail from Laurent) apparently
> are still not mainlined (or am I missing something?), so let me add this
> report to the tracking to ensure this is not forgotten:

Gaah. I was intending to apply the patch directly before rc1, but then
I forgot about this issue.

Mauro: I'm currently really *really* fed up with the media tree. This
exact same thing happened last merge window, where the media tree
caused pointless build errors, and it took way too long to get the
fixes the proper ways.

If something doesn't even build, it should damn well be fixed ASAP.

Last release it was imx290.c and PM support being disabled, and I had
to apply the fix manually because it continued to not come in the
proper way.

See commit 7b50567bdcad ("media: i2c: imx290: fix conditional function
defintions").

But also see commit b928db940448 ("media: i2c: imx290: fix conditional
function definitions"), which you *did* commit, but note this on that
commit:

    AuthorDate: Tue Feb 7 17:13
    CommitDate: Sat Mar 18 08:44

so it took you a MONTH AND A HALF to react to a build failure.

And see this:

    git name-rev b928db940448
    b928db940448 tags/v6.4-rc1~161^2~458

ie that build fix that you finally committed came in *AFTER* the 6.3
release, even though the bug it fixes was introduced in the 6.3 merge
window:

    git name-rev 02852c01f654
    02852c01f654 tags/v6.3-rc1~72^2~2^2~193

and now we're in the *EXACT*SAME* situation, with me applying a build
fix directly, because you couldn't get it fixed in a timely manner.

End result: you and the media tree is on my shit-list, and I will not
take any pull requests from you that aren't just fixes.

Not just this release, but the next one.

Because I'm completely and utterly fed up with you ignoring
fundamental "it doesn't even build" issues.

If you can't be bothered fix the build issues that get introduced
during the merge window, then I'm not going to merge new stuff from
you.

It's *that* simple.

                  Linus
