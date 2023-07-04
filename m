Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03321746E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGDKQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:16:51 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE0101
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:16:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bff89873d34so5003004276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688465810; x=1691057810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPcHQE4tow2wDxnoKB8DgZ62T1VtFFyST4bs6MRIWiM=;
        b=QTnvZk1ulea/KAFt2g0lgQxGx+IYMMwAcOgVPC9dbhLJ8pOHgmdFUdytQEzmOYic2E
         ZxdgyJ0JdGJG4LvBLC465kkRKEh/WUt5rCKmXcobZwSxm1SFlSWRRHEOB4/fcciJoCQh
         tz5jYsgqrZt/t9LbjCR32MtM2Th/T7iCYe1ZJTDS3DVIG/iaGsut85qYKNvwqZV82SFv
         DOr3l+YqioQy9GH1/ZQl73jnz2bPCWO02N2EJ5f+eLs8MLmRwZBB0dbn4GL6UzeZfW8+
         g7r9S5WT4d8zJC8kaXoTeOsMor/dBdUF57WwsahcQn4rPDuw4brgKGp7T7Q+TDD4FfUO
         AgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688465810; x=1691057810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPcHQE4tow2wDxnoKB8DgZ62T1VtFFyST4bs6MRIWiM=;
        b=Tp/uedCQKzz5FcfeVqQXh70uIWittE8NLcpbiV/dZBq+jcfJkwM+Hh7HNou8Djqa2R
         jA6GrHUfgYMWnnKyl2q9vOnYJ7EurotU3HCI4hyDuEDTYrCj13q8PBVSr+95Y0tZen5A
         pr311iK657GOyd98ST/bMcXE1AkjZWgfvptMG3NSeXBqHncM8jP1PCUVDS6nB0h2TJ6F
         jea4J0pdBaJPHAP5vt7LjY9Zzjz8zM0YBbfl+1ScA56yPUmeSkkKRCFwVse/ZNMmoeOz
         byNBmT7pWc12eWrAgUsVNxfFlDmFryS19YgJeizmkaGUGpRHLp6tGp09xoDFj0O5jxwQ
         3sdw==
X-Gm-Message-State: ABy/qLbpk09mTRw3P2P4GADytJd8MuzBrjyePVzxhmPY1DS/iz/3seDf
        slT3y3GuVULLRPns+VqftGyaBPT93RENv80HfOniXg==
X-Google-Smtp-Source: APBJJlGT0/bgQFPpOq5DQufAfSuIX73+woCBsvQDi04U8XXeRuw+y363lATdpnzz/ZDDjibAI+7XF07yOBOmeLnp4pQ=
X-Received: by 2002:a25:784:0:b0:c12:fb0e:52a0 with SMTP id
 126-20020a250784000000b00c12fb0e52a0mr10815094ybh.19.1688465809799; Tue, 04
 Jul 2023 03:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org> <CAHwB_N+F_PQaRb+BvLmJwUSsbeCCqF3rWcLYuY_9ktrFGK5_7Q@mail.gmail.com>
In-Reply-To: <CAHwB_N+F_PQaRb+BvLmJwUSsbeCCqF3rWcLYuY_9ktrFGK5_7Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Jul 2023 12:16:38 +0200
Message-ID: <CACRpkdYQb6MMQ7uxPF2UK4Z6UDQs2uHgpzXaeMm8BZm5i+hofQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 12:04=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
> On Mon, Jul 3, 2023 at 9:21=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> > I am surprised that contributors from manufacturers do not seem
> > to have datasheets for the display controllers embedded in the
> > panels of their products. Can you take a second look?
>
> Sorry, this panel datasheet is not open source, I can't share this datash=
eet.

Perhaps not, but you can use the knowledge in the datasheet to
name the commands and give better structure to the members of
the driver, if you know what commands mean then provide
#define statements to them so sequences become understandable.
See for example patch 4/4.

Yours,
Linus Walleij
