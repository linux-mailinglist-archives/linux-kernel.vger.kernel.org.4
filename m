Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F760145D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJQRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJQRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:11:09 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B936566A46;
        Mon, 17 Oct 2022 10:11:08 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id q18so6132174ils.12;
        Mon, 17 Oct 2022 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R50tDa31QheH9PegEd+bVdQ3X/I4pMIoJ98xHZVENU=;
        b=gbhcWFmvoOoHlrSw7fwphKzkgX4hOti+XwRW5+LaeaV09djLDTNgfQKCLEOakbXiUh
         6f502qo/Bl7lANxZjkoEIkS7L5KK6Qf5i/U6ptkvGFke7HF/tAEqYL+qYQHS7OYkEdyh
         ltYiMuLS+7IfdQmAVOErtTPxsRart4tGjR/3CZXAMPJws1qPEmu3zgtiZLljDS3tgRJQ
         5Z2QHUPebEzye+DfcfYK0s2UQQ7Cx/NhjjpcFlsOd+MXD1ugiTuHb4teeP9eyac+Ja3n
         MN1WcJoWDF8NdJ7J40fHi/+l1sfti3ibT4DKferFq6osjrScVwcR2ySvdivCjJixyzRO
         qxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R50tDa31QheH9PegEd+bVdQ3X/I4pMIoJ98xHZVENU=;
        b=kYdynQVBm5Yha0A/2HWC6K82gYtvp9XZkZRSBsmbFouUm09r3Bfo+Z7+r69+atFo5A
         VLYtMzsTqaq88KJaA9Pq0I9ymJhlNSLl+X9cVKDP0s5RVWb/VOhalb1EpfmtF0qYCFI4
         YkbCxBPabbIbI+g2G9uzsuZupOEhOYm2IO6D01I1I6IBtJsWtSeOSXicenJ+Vg6atBBP
         gArNicynLmSAGbUKhVbQq9ovThUR0kW0wk1i3sjlW3YsiVWu59uV+QE4pkX4uZ0h2klT
         ebUWPUyD+hzh7a0kcwfITUfKy2rxXeUOokYllQ6w03I6mjCcd+H4xo4RWfSiD3xCeIF/
         fIgA==
X-Gm-Message-State: ACrzQf2LD03iRkgN6P/4hFeg+kNaCsonoQzNl/cdztNifmDCXIAtR8Px
        EMjMzBz5CKrYGGFZo818dv9LaqjaV5SURuocFNk=
X-Google-Smtp-Source: AMsMyM5/Jdn558aL2rhxtSZ2OiG2HQGSp5Yfh5ExHu+Z1RngoeO5tlE0YXRAp2g3o24MQ3WEV+KDly8jDeAa2vFPnAs=
X-Received: by 2002:a05:6e02:20ea:b0:2fc:318b:a952 with SMTP id
 q10-20020a056e0220ea00b002fc318ba952mr5121906ilv.236.1666026668164; Mon, 17
 Oct 2022 10:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221016150110.3020451-1-lis8215@gmail.com> <20221016150110.3020451-5-lis8215@gmail.com>
 <0S4WJR.4KB18PR21S9K1@crapouillou.net>
In-Reply-To: <0S4WJR.4KB18PR21S9K1@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 17 Oct 2022 20:10:56 +0300
Message-ID: <CAKNVLfYEMwRC+4VuGcaENd1eTvbhWD9=uFDAhaz+1Fd8Aaqg_w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clk: Add Ingenic JZ4755 CGU driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:24, Paul Cercue=
il <paul@crapouillou.net>:

> > +     [JZ4755_CLK_AIC] =3D {
> > +             "aic", CGU_CLK_GATE,
> > +             .parents =3D { JZ4755_CLK_I2S, -1, -1, -1 },
>
> Wrong parent here, should be JZ4755_CLK_EXT_HALF.

I don't  agree, see Figure 20-13 in the JZ4755 PM.

> Well it would be good to know...

Indeed, I will try to figure it out.
