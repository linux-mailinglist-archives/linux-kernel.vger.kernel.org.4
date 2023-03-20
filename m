Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D36C1064
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCTLLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCTLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:11:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031E6198
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:07:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m15so3502987qkn.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679310462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nhhh3ZAx0xZch5t5NtSJYd3fI/Bc023/J/5SBijWjM=;
        b=UWb/p11JlyjTRspUh9LLV29UvG4RRfmZMQkZt/vWq+FGLIsHlgyjrZ/2Cgn+yxNOgX
         3KdcFXpbnZfOZJwbiD4r1J/zESQRvrAQS/ZLxvPYc/QXiWazfYeSuMxXHq83I5ykTwZp
         rTk0AeQUy6RZtagfmPEuLkUOUNQXvsyxeACws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679310462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nhhh3ZAx0xZch5t5NtSJYd3fI/Bc023/J/5SBijWjM=;
        b=CMWTiuHrZPU/FziIe9yqoSoX7rcXJ1rUS86VhOGjiI6VivJkv4zBkHaX+F3UbiMpVd
         FMt8vAc0B7caLRyFJ/VaAxDa8HmJPFNOPL9UKrloMYJsxAr4OVnT9pvc6Gy/LS64lPJ9
         MU7ZN8vsM038yooj+FzWsnrD0la84aJlnyPXPtDvhH7u/xGDzBgunyh7m4x90JYtkM+0
         YRDBdJcUzKG5oUmO3HUZBJ7qAmH3OQlwZQan2EtqpDmLFMjWA2KIw9+y77/aM3JK3N1/
         wgc5zir+idzeKvhuA2ob6gHM09fLc8ahxPH06RjHLRzygUzhJy55FRpHavP75+0yooI2
         74ig==
X-Gm-Message-State: AO0yUKV5MoElotpvISxXAdEdhmduDN9wD5aIMEuC51s6s/scnecO9vEa
        2aeAQb26VwbLbciNX2IPKNomt2rwYJsDr9ND7oxQj04GVX56H2ntbB6BeiLU
X-Google-Smtp-Source: AK7set8cb9/s4D03g/8LJ0LA4+vl/0316AdPNeF6DMM8RwcazkcFYHdLNsSwoFGJC+C2MkiQGnQpuJ8FObIZiCkQPPc=
X-Received: by 2002:a05:620a:b44:b0:746:9174:3d3c with SMTP id
 x4-20020a05620a0b4400b0074691743d3cmr159611qkg.13.1679310461788; Mon, 20 Mar
 2023 04:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230320093259.845178-1-korneld@chromium.org> <CACRpkdbhV1qE+Kx4cqAKiv4Zacv6tQ8wKF8C6+0kZ-Dw=0cx7Q@mail.gmail.com>
In-Reply-To: <CACRpkdbhV1qE+Kx4cqAKiv4Zacv6tQ8wKF8C6+0kZ-Dw=0cx7Q@mail.gmail.com>
From:   =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Date:   Mon, 20 Mar 2023 12:07:31 +0100
Message-ID: <CAD=Nsqwc2YwoEvvAFJd-QBKsP75vjqbCcAjB=k2s5=oYL7AtgA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Disable and mask interrupts on resume
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        upstream@semihalf.com, rad@semihalf.com, mattedavis@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:05=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Mon, Mar 20, 2023 at 10:33=E2=80=AFAM Kornel Dul=C4=99ba <korneld@chro=
mium.org> wrote:
>
> > This fixes a similar problem to the one observed in:
> > commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on prob=
e").
> >
> > On some systems, during suspend/resume cycle firmware leaves
> > an interrupt enabled on a pin that is not used by the kernel.
> > This confuses the AMD pinctrl driver and causes spurious interrupts.
> >
> > The driver already has logic to detect if a pin is used by the kernel.
> > Leverage it to re-initialize interrupt fields of a pin only if it's not
> > used by us.
> >
> > Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
>
> Uh oh this looks serious.
> Do we need a Fixes: tag and Cc: stable on this patch?

I suppose so.
I didn't add them since I'm not sure what commit Fixes: should point to.
This issue seems to have always been there, so probably the first
commit of this driver?

Regards
Kornel Dul=C4=99ba
