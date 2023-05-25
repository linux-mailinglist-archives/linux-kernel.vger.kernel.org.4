Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D797117D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjEYUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjEYUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:06:20 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4DA7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:06:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af30a12e84so10961181fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1685045176; x=1687637176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3spcq+MrkOIWF4SfW0stmLuaSodhQuiQ2dFEDG11ZA=;
        b=Y2amLA3bKwVejayNzOT4S2WIDvyXw7VfW5iFKCytn5tcad8JCmmuQb9kunBGUyiN1R
         djsNvbvOhc12DL9y9u5Qm05x3ppmerrqayzEcWr2r6+Ai8goHUIRzFewdMUQ6jkPHJAv
         X2Ymz4SIrraaHvPpIPnbumHz+/QQZc+8b41uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045176; x=1687637176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3spcq+MrkOIWF4SfW0stmLuaSodhQuiQ2dFEDG11ZA=;
        b=TirJkHlIzp2uBSodWEFZ8d09D2ukyVEFYZBx8Qt3UVbToGac4q2JmI8+1ZgMQqnuth
         dz6PQwagGczRfW+XmwzvGpWCyjhjFsiM2clQB6v5zYKgYViO57KKpKwl4rDObmW96yKr
         Jk4Xr88K7wNwyI5RNai89SNUbOUZaRK8bSoHOWhO3GDGqTDhPajj+WowIWPakPeS8fZI
         qZZrixeTKT6TVALHAK8WdgtARY8BACYTe7UPNPSE0rQnb4wvFVh3IZcfjmlcTkw2Z5g2
         yuVb6L1z9JfD7lwYdjmj1LgzUdvAYsmZG0+pM3R9AvECc55W9md/P/XwYOHXhIwsY83U
         AL2g==
X-Gm-Message-State: AC+VfDwm+SGyVnh5zGZQeQcx6mK4YIgSYgso3dufYlGGGI7B76c9f6Lz
        ux5oNVWsVHPE9nY8dUtOn4ziZ1Lg27l7sLDBc2Zy
X-Google-Smtp-Source: ACHHUZ7hJ5WkNy8+TAtwUENxM1v6lnmWt2g0rRrlpenYRzRQ/0Ej7gcTYezaDZ+q1V9T2tP6MZTe5bQ4Bb2Ja436M+w=
X-Received: by 2002:a2e:7c05:0:b0:2a8:a858:a4ab with SMTP id
 x5-20020a2e7c05000000b002a8a858a4abmr1209094ljc.39.1685045176486; Thu, 25 May
 2023 13:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230525-guacamole-swimmer-68048a73baac@wendy>
 <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy> <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy> <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy> <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud> <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
 <20230525-desecrate-imposing-d97ab34e06ad@spud>
In-Reply-To: <20230525-desecrate-imposing-d97ab34e06ad@spud>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 25 May 2023 13:06:04 -0700
Message-ID: <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
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

On Thu, May 25, 2023 at 11:39=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:
>
> > Any testing of hibernation still needs to revert the patch until we
> > have the proper fix.
>
> "the patch" is what exactly? I assume you don't mean depending on
> NONPORTABLE, since that is a Kconfig option.

Nope. Sorry I meant the commit

3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")


--=20
Regards,
Atish
