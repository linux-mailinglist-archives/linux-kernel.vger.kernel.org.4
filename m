Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15670C274
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjEVPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjEVPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:33:30 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4333611A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:33:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-76c8dc21998so69822939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684769604; x=1687361604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOzOnUMPvM9TM8xcy1xez8VKe5P8M6GDNKqNZwK7fcM=;
        b=oP2UO/3zaPdNHoMGo2bN6Y0AKsdYaVfGWRHpOcRZlg6HExSLv9jZ3ulWI1RHg+rcRF
         2nogfXF2H64DjSzxEnej0DXZwkbXsVRPyiELpJCY2vs4yYyoNVsMvwAkBup0Xh0KqUxD
         V9KrRGxMKVC6sbXhgc/Tqn9hP8+ITgIVI04v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684769604; x=1687361604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOzOnUMPvM9TM8xcy1xez8VKe5P8M6GDNKqNZwK7fcM=;
        b=hSFY31WN0sRdTwDv+LLIv6dP2G8uJ9zl9tt5z9OqQdau0DJRpt6b1ShudvuVn6Q0+2
         Fnk9ft2a4WP2Jen0ouVmj1+Wpnzadp8OPkVbmu7jPabE+zf6AnUq+iCs726FBWrUP/hM
         q/kITqId5ZgP6+9rQpG/FUR1pHPdo8wSMpLsgfOfe2PU4QshObGoe7QfyjUEV22Bfcvk
         GhklJMS4FF++kOwD2lNXFkOfVoyIqGcuI7NbX2Br+rqZaJTCJcBuUPGeggNY60vvmOY4
         draH069bigMmNJhFUIIDqvXbpkeEt5kTBM4cN/lWhrYsA1tNxCLrrFhaE9rpm0emzDJl
         /7tg==
X-Gm-Message-State: AC+VfDwrO56DrioSVhKu7Y3yasrCPCRBF421e0wno9Ty1d/c+7u7riPu
        MzN/f3ZaYKTr2ncHfxzakdK2eerA4z125iJDhRQ=
X-Google-Smtp-Source: ACHHUZ5ZTpV6OkQLVr4eurkwL7v5y7E/9vrqO8air73ocPOWGL5zw+Fn1wlZHMYROT0szKAy//3qjA==
X-Received: by 2002:a5d:8582:0:b0:76c:5641:136 with SMTP id f2-20020a5d8582000000b0076c56410136mr6493338ioj.0.1684769603961;
        Mon, 22 May 2023 08:33:23 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id e19-20020a0566380cd300b004183d110f0dsm1888281jak.86.2023.05.22.08.33.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 08:33:22 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-335d6260e9bso306355ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:33:22 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c2d:b0:32f:7715:4482 with SMTP id
 m13-20020a056e021c2d00b0032f77154482mr807557ilh.4.1684769601699; Mon, 22 May
 2023 08:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com> <20230520050649.2494497-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230520050649.2494497-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 May 2023 08:33:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wm_SK0V6WJUkuvu8yFfiP60JBuOdw9cy=0Ck2Jbn-X2A@mail.gmail.com>
Message-ID: <CAD=FV=Wm_SK0V6WJUkuvu8yFfiP60JBuOdw9cy=0Ck2Jbn-X2A@mail.gmail.com>
Subject: Re: [v2 2/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
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

Hi,

On Fri, May 19, 2023 at 10:07=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Add an ilitek touch screen chip ili9882t.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/input/elan,ekth6915.yaml         | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

I'm curious about the DT maintainers opinion here. Should this be a
new bindings file, or should it be together in the elan file. If
nothing else, I think the secondary voltage rail name is wrong. I took
a quick peek at a datasheet I found and I don't even see a 3.3V rail
going to the ili9882t. That makes it weird to reuse "vcc33-supply" for
a second supply...

-Doug
