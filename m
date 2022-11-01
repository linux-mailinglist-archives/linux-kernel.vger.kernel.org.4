Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4C6150C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKAReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKARcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:32:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD31C416;
        Tue,  1 Nov 2022 10:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41BB0B81EA8;
        Tue,  1 Nov 2022 17:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF8EC433D6;
        Tue,  1 Nov 2022 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667323936;
        bh=eOjxTt1qzXYpd+vexpbm9/lLy1/vQDQwdcCuCWSj0Kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J0HsDOslmUL61WbPEA56amtuHWxp+nZ1i1E6yiLPJeZblYnRKfC0i9ZpOIdmQNtb3
         jWruSl4BgReiqOHRbzVIk9r3KGePf0Tt/EM6NR6gm++9wTfCr9R8F+SpZUN/VCWmLg
         o8anPKsN8cf/zQ+hb9VVeTTejuUPXtHqb6N6dQnCUzPzbbuP8TUxMM4rciWWUsQ5gd
         THyo84rpDPnZZdlXALPdpT7KVi3t8GMW2H6MjxfKDgPAlrgsolxEdgxXBfVZUtj99P
         zMri+hT6IOAqi2ZKCGBsFnFQ+ZFgGXz6WtHFxvblsBJ8Z0ocNwtviKj+UQrZ4EW6jG
         kLwxE3lnp+phw==
Received: by mail-lf1-f50.google.com with SMTP id g12so24448660lfh.3;
        Tue, 01 Nov 2022 10:32:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf3rOh6px4PBH6DcenVPghp/rmRNYrGhp0uatEopQyHaf/dfzDbD
        AwWRY6cCzzRaDFdeodNHHpyrY8GgV4GdgTfNOA==
X-Google-Smtp-Source: AMsMyM55ZQx6ERNnT2ewevQAIODBodrEpIuNlVPuqGNhSoa1jfV7LFjGf9SbOgrxVTM/C2na9B1/Xga8hv/kvtwUcbk=
X-Received: by 2002:a05:6512:3e10:b0:4a2:48c1:8794 with SMTP id
 i16-20020a0565123e1000b004a248c18794mr7390625lfv.17.1667323934009; Tue, 01
 Nov 2022 10:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028225519.89210-1-paul@crapouillou.net> <20221028225519.89210-2-paul@crapouillou.net>
 <20221031192341.GA3270129-robh@kernel.org> <WNUMKR.BWKAZLU4SGE52@crapouillou.net>
In-Reply-To: <WNUMKR.BWKAZLU4SGE52@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Nov 2022 12:32:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLOdnm8XNrEbeVtQeq4qtTyqUs_uGyhwzmUKha43ijTuw@mail.gmail.com>
Message-ID: <CAL_JsqLOdnm8XNrEbeVtQeq4qtTyqUs_uGyhwzmUKha43ijTuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: ingenic: Rework compatible
 strings and add #clock-cells
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 2:41 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
> Le lun. 31 oct. 2022 =C3=A0 14:23:41 -0500, Rob Herring <robh@kernel.org>=
 a
> =C3=A9crit :
> > On Fri, Oct 28, 2022 at 11:55:16PM +0100, Paul Cercueil wrote:
> >>  The RTC in the JZ4770 is compatible with the JZ4760, but has an
> >> extra
> >>  register that permits to configure the behaviour of the CLK32K pin.
> >> The
> >>  same goes for the RTC in the JZ4780.
> >>
> >>  Therefore, the ingenic,jz4770-rtc and ingenic,jz4780-rtc strings do
> >> not
> >>  fall back anymore to ingenic,jz4760-rtc. The ingenic,jz4780-rtc
> >> string
> >>  now falls back to the ingenic,jz4770-rtc string.
> >
> > This is a compatibility mess. There is no driver support in v6.1-rc
> > for
> > ingenic,jz4770-rtc, so a new DT would not work with existing kernels.
> > It
> > sounds like you need 3 compatibles for 4780.
>
> Do newer DTs need to work with older kernels? I always assumed the
> compatibility was only enforced for the other way around.

For a stable platform, yes. Would you want a firmware update carrying
the DT to break an existing OS install?

Compatibility either way ultimately is up to the platform whether you
care or not. I just ask that the commit msg spell that out. In this
case, it is easily avoided.

Rob
