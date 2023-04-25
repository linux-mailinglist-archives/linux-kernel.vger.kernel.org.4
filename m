Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101AD6EE94B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjDYU5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjDYU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:57:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F15F16181
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:57:44 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4BD603F229
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682456261;
        bh=vgRVIXe+P2Wjfmla/rXAZJKk1sI+D1ImKYegwRHDTks=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Ig8rGX6PV8bg6ln9oVlnGLEjc14RtxwSxXHhHg8U+eZxHrb9VIjkUuj+RVPN6H7MM
         ho313fl6EwSl+i7PdzJLFmhqHiZZGmjcONnSSXN4RJ3oqSoiU8Dh3uhV2Yar4KxW5U
         Ol97OVb5nLl/3xxYqrWLfQeUSwqstegUObWnYoCtGHW9CNWVcXAsCvQVwjNPikPwCy
         UECH8u5deFwgeM5+psatjnH53b4FZRbYXuYnkr7I8UPgAPc723YJAoQ8oa33oHfbeM
         ixkbzzAkTGkz/P7vdZU760tX4MSXAuIu2vWz+OxKdkQquiAe5KCHq5MDNvq231Aevn
         gaKU60kRNdoKg==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f0a65d5a1dso27774341cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456260; x=1685048260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgRVIXe+P2Wjfmla/rXAZJKk1sI+D1ImKYegwRHDTks=;
        b=eDJyFR2HDt9Au0MMQytnj+g4r5OAN7rp86VM0/fZ2brn6hqqktfiVB9IxmDtsVZiLD
         rEy8kYTJdVuVUl9LaBAhPbGJNIHDdsXyqhpq4HAFhFAFxGbvzCIOa5U0WGY2Mw2gq8NM
         FVTj/iF/LzNrqgk2QDeihLkw+DJvVHqu9tdGWnahYrPmrZPVN01BNEdBOUuRTEVf9/dl
         t7ix91GRfuLMUeKwodWvfdWFdCN9SMOUbPGLsba8ZIrImrpejZKxPd9Dt3UHplsKzHIT
         M96xFYzXfe5X9ocsKycXB5MaYwrkIoiOFqvdgiz7BFDfnUFHxubmiTNUZs8zCtTxlYlZ
         vsZg==
X-Gm-Message-State: AAQBX9cRJcFwOCgn8gWSo87YGJZpyyHN/T0F0l5clmfFFJ7CyT2vxNvF
        SjPmeL44T4VokLOf+TXwRZ2EI7zVCifOQVKHJuvoDhjrCK3X6Cn3dkztOThv/uqeuKi7FmF1dfE
        VKVeZX81rn9n/JzUZGBPOezMC51TtLsBn8dniWbkkIPrnPnzY5aywpOKtzw==
X-Received: by 2002:ac8:5d8d:0:b0:3ef:46b0:80e8 with SMTP id d13-20020ac85d8d000000b003ef46b080e8mr30845692qtx.19.1682456260305;
        Tue, 25 Apr 2023 13:57:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YgJcj8NBwRby79492evbEUfuqxK9Zf4fKQdwy3HHL1ByJh+2fexc3h8J5/zzoJIvi71pUHyKLn9qmewz+xjS8=
X-Received: by 2002:ac8:5d8d:0:b0:3ef:46b0:80e8 with SMTP id
 d13-20020ac85d8d000000b003ef46b080e8mr30845680qtx.19.1682456260117; Tue, 25
 Apr 2023 13:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-5-walker.chen@starfivetech.com> <20230421-dropper-upstage-200ae7e47092@spud>
 <607f3604-056c-6f3a-b154-0f298b870811@starfivetech.com> <20230424-roundness-everybody-659599d44963@spud>
In-Reply-To: <20230424-roundness-everybody-659599d44963@spud>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 25 Apr 2023 22:57:23 +0200
Message-ID: <CAJM55Z9a9N8Zm2cuh8gzZNcYBENO5WE6GmRXOsaYbOcv0srz-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: add tdm node and sound card
To:     Conor Dooley <conor@kernel.org>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 at 18:27, Conor Dooley <conor@kernel.org> wrote:
> On Mon, Apr 24, 2023 at 11:21:11AM +0800, Walker Chen wrote:
> >
> >
> > On 2023/4/22 0:50, Conor Dooley wrote:
> > > Hey Walker,
> > >
> > > On Thu, Apr 20, 2023 at 10:41:18AM +0800, Walker Chen wrote:
> > >> Add the tdm controller node and sound card for the StarFive JH7110 SoC.
> > >
> > > Is this one of these waveshare things + a visionfive 2?
> > > https://www.waveshare.com/wm8960-audio-hat.htm
> >
> > Hey Conor,
> > I'm glad to receive your comments.
> >
> > Now we are using this board + VisionFive2 :
> > https://wiki.seeedstudio.com/ReSpeaker_2_Mics_Pi_HAT/
> >
> > >
> > > I'm a bit lost as to why this needs a whole new board, should it not
> > > just be an overlay that you can apply to the existing dts?
> > >
> > > Taking this to an extreme, should I expect to see a new devicetree for
> > > everything RPi hat that you decide to use with a VisionFive 2?
> >
> > For your response, I did some thinking. Because wm8960 codec is not integrated
> >  on the VisionFive2 board, perhaps using overlay is a better way.
>
> Aye. I think so too. From my PoV, if this particular seeed audio board
> is something you're bundling with VisionFive 2 boards on your storefront
> etc, then I'm fine with taking it as an in-tree overlay.
> If it is just a "random" RPi hat (that happens to be exactly what you
> need for testing the audio drivers), then I don't know where to draw a
> line for what is & what is not acceptable for inclusion.
>
> In both cases, it's Emil's call.

I'm not aware of any shop bundling the VF2 with an audio board. I
agree: please don't add device trees for combinations of VF2s and
hats. That should be an overlay.

/Emil

> > > Also, it'd be nice to provide a Link: to where someone can find more
> > > info on this combination of items. Google for "wm8960 visionfive 2"
> > > gives me nothing, nor does "starfive audio card" etc.
>
