Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5884870C257
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjEVP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjEVP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:27:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635EF9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:27:52 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-772ac011955so250057739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684769270; x=1687361270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STtYLVHbrxls9+TET2taw4/CcCJWytrlGIrbAGYi3j8=;
        b=Wm5xp0auZZJXnhpPCvpFKewrPiJesbAsPKcgbBu6wpQ66rrb30CoW0C54QjKGUEtoA
         65gh9SVj6mAO8ZDtmUv8mccIUCh+J2xzkwRL/HX9PG3+jDJiPXny0g9Mzeu8TUl22jnk
         ucQEqI8OqmrOZUDhf9X+7gfb/Aa/mge1WGuTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684769270; x=1687361270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STtYLVHbrxls9+TET2taw4/CcCJWytrlGIrbAGYi3j8=;
        b=NeCF/xRpwTEBXXlRFDBh6bOOGqlJP6bXAGQFvAkQsxEXl1ePa9wfgvb87gsgoEANn6
         40QyUDXfPrLwwqbO3grUBsx/KWXgjojHDexYAeHx9L8F+rjWoUf3lFckew49kiuH6PD0
         c71BNVD32m0kD/dDY1qRWBrIf6hRu7diaYc4diPCWH/ZyeSeMe1wXOBkw4qb0E8JdVuz
         VWHrBZSxU3mv8KHbuoHCiMERrke3n+EL1VeMKNlsxNaY4ZmfrASG+LDBhTpZr2nWdphM
         VoOaXD0dd9MFKu1SuCz/H23vn6mDbKrkajScLJ4o7SVJ7kwb/BdhiD+SJS+emJEezVbr
         +l+g==
X-Gm-Message-State: AC+VfDxwPcQfN8uqeKd1p3gIMUfqyX7SPQ4eqrIOHJIGo36twT5/TMoN
        kl9Q2SJdIR9pS2nmIEbUf+IZwIvUonlqEI12H0A=
X-Google-Smtp-Source: ACHHUZ5lxQeyIjtZIc8IVVyyIU6gHgDABogZnyeYZUZENyRa5LxSBLGcVQVCQJXr6Dje9wi12ifevg==
X-Received: by 2002:a6b:db19:0:b0:769:82a4:4419 with SMTP id t25-20020a6bdb19000000b0076982a44419mr7089586ioc.14.1684769270655;
        Mon, 22 May 2023 08:27:50 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id c18-20020a6bfd12000000b00763bc18ded3sm2069932ioi.28.2023.05.22.08.27.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 08:27:50 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33164ec77ccso286895ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:27:49 -0700 (PDT)
X-Received: by 2002:a05:6e02:2189:b0:337:c9ec:4ca with SMTP id
 j9-20020a056e02218900b00337c9ec04camr449049ila.2.1684769269411; Mon, 22 May
 2023 08:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com> <20230520050649.2494497-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230520050649.2494497-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 May 2023 08:27:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xpe=zOeq2pG17Q0n_SZZHAFmaE+6C=SnuHqnHN6uObog@mail.gmail.com>
Message-ID: <CAD=FV=Xpe=zOeq2pG17Q0n_SZZHAFmaE+6C=SnuHqnHN6uObog@mail.gmail.com>
Subject: Re: [v2 1/2] HID: i2c-hid: elan: Add ili9882t timing
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> The ili9882t is a TDDI IC ((Touch with Display Driver)). It requires the
> panel reset gpio to be high before i2c commands. Use a longer delay in
> post_power_delay_ms to ensure the poweron sequence.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 7 +++++++
>  1 file changed, 7 insertions(+)

This seems OK to me. The one thing I'd also do is to update the
Kconfig description to say that this driver is also used for Ilitek. I
think it's fine to keep the symbol name as I2C_HID_OF_ELAN but just
change the description.

-Doug
