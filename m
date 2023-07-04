Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BD7746FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGDLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGDLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:15:38 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB9910FB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:14:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b5f362f4beso4597643a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688469264; x=1691061264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmq13IpfgnAPzEDZ3MCvqyIpf9PhLjB+MPzx2szVSfk=;
        b=b7AhtMCftt+cTeOJXwBy5ITli90/x5PMA+MyE+5atctEAz5tSz0BLHemWUOzyQcU15
         arIY+E27ZqZIe8Jofdpx5wdowWEAtVadAAUP1SZ6zv3+ow6M6by33CgrIbvZHlLGyhDm
         DkLDcQmeQs3J/P4bLLOwR6DXAkv2xDG6hZZ5NCb/bSZK65D/3iwLM4fN5XUv+yE5OT4u
         zlAYg0SJyzGtyriDQwiYWRTZGMxZ3cOKYnyR8ozA5WAGyY94jUJCXAtuPD4hQuBrjH12
         aXtiuookOoYhYNSwZNVyQ+Ksn1UBRrtgFIvwrR7CX1r+p8JHZH7VImB3jjeU0ftknJ2E
         VHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688469264; x=1691061264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmq13IpfgnAPzEDZ3MCvqyIpf9PhLjB+MPzx2szVSfk=;
        b=DlSGCBtOkW07HCQ22xuJCtDHWNKYNNcTBuogR+SPvQZzmLYm5QCNo2hl/bfniZtbCX
         qzHqLH1dVEXTTCqwWko8d3rvYLY/6K+0UVzk15HAq11ub7Zm6qbg6U6+nJy1d/qNf8w4
         Zv4pCMwWxJX53d5Ucs47sssh0kA51ksKlzeDbSg56p/AK+zD37PZ3X/XSfZHYPyLV4SU
         8fAAkhxuJ733fa+xJKpcGApvcIGy1rsB3bPxXTx9dPFoMGxiKc+nYRFhVBBlGex/dEyJ
         s3A+yPfOp/AhC9zn0T64dRCdKid62C508B4GLOtfX8PxtzoUEQnRSn5PtQ9U6bs2LZa9
         bYaw==
X-Gm-Message-State: ABy/qLZKSPXXIXoKKur7eDaXbQVmKoUVvTuM2YrC1GlcSAxgqdQuOa7t
        jFrRjhMfjT2UfwLhW0MIRVx38R/rqV6K/UH7NdSEOg==
X-Google-Smtp-Source: APBJJlFGYPsDHhZoR1DA74LBsPfA4iDEEhLPHr4gpWDC18z6mMpX2jCRqIPh9EeoZRADFggaiWSfavywya4q4oo5xvo=
X-Received: by 2002:a05:6359:21b:b0:134:ddad:2b4f with SMTP id
 ej27-20020a056359021b00b00134ddad2b4fmr10055345rwb.18.1688469264466; Tue, 04
 Jul 2023 04:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
 <CAHwB_N+F_PQaRb+BvLmJwUSsbeCCqF3rWcLYuY_9ktrFGK5_7Q@mail.gmail.com> <CACRpkdYQb6MMQ7uxPF2UK4Z6UDQs2uHgpzXaeMm8BZm5i+hofQ@mail.gmail.com>
In-Reply-To: <CACRpkdYQb6MMQ7uxPF2UK4Z6UDQs2uHgpzXaeMm8BZm5i+hofQ@mail.gmail.com>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Tue, 4 Jul 2023 19:14:12 +0800
Message-ID: <CAHwB_NKD=87cgQMpegbDEQzP00qPvzViMnDSzW7BXPE7-MtfDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 4, 2023 at 6:16=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Tue, Jul 4, 2023 at 12:04=E2=80=AFPM cong yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> > On Mon, Jul 3, 2023 at 9:21=E2=80=AFPM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
>
> > > I am surprised that contributors from manufacturers do not seem
> > > to have datasheets for the display controllers embedded in the
> > > panels of their products. Can you take a second look?
> >
> > Sorry, this panel datasheet is not open source, I can't share this data=
sheet.
>
> Perhaps not, but you can use the knowledge in the datasheet to
> name the commands and give better structure to the members of
> the driver, if you know what commands mean then provide
> #define statements to them so sequences become understandable.
> See for example patch 4/4.

Patch 4/4 LGTM, from the datasheet  0XFF is EXTC Command Set Enable .
Description: Set the register, 1 Parameter =3D 98h, 2 Parameter =3D 82h, 3
Parameter =3D Page value to enable =E2=80=9Cpage command set=E2=80=9D avail=
able.
00h =3D Page 0 ,01h =3D Page 1... 0Eh =3D Page 14.

Thank you for you patch.
>
> Yours,
> Linus Walleij
