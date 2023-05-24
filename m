Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1270FFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjEXVNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjEXVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:13:19 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0AB1BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:13:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-338458a9304so17265ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684962791; x=1687554791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYUYf+N7n/RZ7xlXddX7wNd0LbOcdLHs3IxcHa82qlo=;
        b=4JAsb3Sq8eYnNptcyhuiR93ia3f1K0xKdNBjprpWrE5qliQAJXglHYyW3atv7s77B/
         DefLbBv5NMlKXTvmsIR4oi4kCZuuiCrKM/AfEbvJGi+DhN0XW+AWDnoL+A8KT/w5QmG0
         Dduyku8/9uL1vByLm1/VXsBz/2hfnH6kn4/kVi7f/0KPl0pU0ZECFIci2NvIZ3VWaC0j
         7mui8/OJTkvY13CMIm3LSNImLAMXDNxwK3kM5aYk2dPRnu3sDw/x+wU2oPHKVM4EJBQm
         rqnjs2DgodJw4Et8WPvWkQeYTnJOX0/9Z8F48sa2SnTAZYjxDbBUGMSC/m9dDYZDUZFc
         U7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684962791; x=1687554791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYUYf+N7n/RZ7xlXddX7wNd0LbOcdLHs3IxcHa82qlo=;
        b=LP/0+nm6dO3EPuD2DLJPT4AR0mThxdxav90NSRWdAgNVf1SLDdQFRjh06k2Doa1fgf
         dJEWzm80gaM5MGwAde1vYwZEswZ95Hqxqk3LzSd9o2/xazKdoQUE0P7xmtS9tj5/LEAl
         oVgLvq7IuieFRrPNb/h2zdEZIiqC9rlXmh1esuY8xZ9plzCskY2eMkEId2yReE2sbLew
         CqR/HvmqAqH4meiH6D6HgxGphQcPpgfpHUxtsi+irlOOuVG6NMW3zRW5NfBrM+kJdvrx
         e0SNOB7hWTUBosxBsEzH4AMYSYvKYFCv7QBuBEB6EETp9EeN+l3SqK5fe0DzeDj/BFzK
         TbvA==
X-Gm-Message-State: AC+VfDwoOqqpaB8oJc/eAKJ51MEb0a0SgHpAWTR8Cz/FXCjXTVYUO35z
        W5F26TT9TRuKZxDe84hfBYb8fmhQHugKkMoNbEzSxQ==
X-Google-Smtp-Source: ACHHUZ4rKi36fvG7ashFJnQT9G8kZS2ONK9sJ+HfcAMU13wMJoqPvrtULzbE6RXkxl+wNc2IhTHUmkoG9V47OwdbgBU=
X-Received: by 2002:a05:6e02:1bc6:b0:337:c28c:3d0f with SMTP id
 x6-20020a056e021bc600b00337c28c3d0fmr60287ilv.6.1684962791070; Wed, 24 May
 2023 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
 <20230524074455.1172064-1-yangcong5@huaqin.corp-partner.google.com> <20230524074455.1172064-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230524074455.1172064-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 24 May 2023 14:12:59 -0700
Message-ID: <CAD=FV=VmBAbZ9itTSugwsYownu09XPLiW75N68Vvu=cVq8bRxA@mail.gmail.com>
Subject: Re: [v2 3/4] drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     daniel@ffwll.ch, neil.armstrong@linaro.org, sam@ravnborg.org,
        airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 24, 2023 at 12:45=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The Starry-ili9882 is a 10.51" WUXGA TFT panel. which fits in nicely with
> the existing panel-boe-tv101wum-nl6 driver. From the datasheet,MIPI need
> to keep the LP11 state before the lcm_reset pin is pulled high. So add
> lp11_before_reset flag.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 371 ++++++++++++++++++
>  1 file changed, 371 insertions(+)

Assuming you order the table in the proper place like I requested for
("drm/panel: Support for Starry-himax83102-j02 TDDI MIPI-DSI panel"),
then:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
