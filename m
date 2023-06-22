Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0173A179
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFVNHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFVNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:07:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669391BD3;
        Thu, 22 Jun 2023 06:06:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so9597261e87.2;
        Thu, 22 Jun 2023 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687439216; x=1690031216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkS0bkiTSM4WlvNnlr04wJKtI8k63E3pjAwvMsZPIZ8=;
        b=TCdc/KDQCgMrHFMeNGZgenb2wph2UKoZLril9SNfd2qT/VkUgmoQg1gX123L/MVa1Z
         QrHJmvil4MoTfQ97MmK4wW2AexbqP2UCJerVd9KVexvyQ0lq6WbRj+TdAqgBQuVjiBsJ
         T9cj4r/pIlndUvoDePItk3/YLgjBF8YmIb3pXf1k7KNy/NM7DqIeDunt+ay1L0FDxV8g
         HwkYLY3s8Quxz5bIQxQa5EfKD6Zeub2iMeC+ch9Ga8SpxLb4ozovCL3FMsCXz8rZtr+P
         /uLCgwUr/J2dqu6aSVzIQvsJFVeSgXoG9fPOlbcxRyUB8DUCI8i0MJ2XXZ8NMm/iDk+f
         o0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439216; x=1690031216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkS0bkiTSM4WlvNnlr04wJKtI8k63E3pjAwvMsZPIZ8=;
        b=D2cPr2vdv5UgQLd3cTnXYFMu0RtqkgD9GISOf//0c0CxSIeG298ziPyHB5v5rzstk6
         rTkHO35IRVt/xPhYJMOZEy+E9ymeF399R+duhUMP+ENa3uzp3z9jshYw8b4l1FrVtNMl
         HouTLHKTOMBmkRS/Yj7BzAKOijOZWUfROVmOKrGWuj9POrtWsH7+djkwbFDaS+RMxI/8
         VBG7zLI21kgoFAb79QXjdAphmt6lSEiqbulruJxXuBrv53KcAXK2KlVmylUVEgTbwVp+
         WIp2q7gKX6QavDKwwvv4kbJ2I19kHOv76etHpKH5RZR/HbTCxvJwo1/7d1BHJ7x0B13k
         angw==
X-Gm-Message-State: AC+VfDyfyA7mNDljJNoaMiYHNlyfhWredlHA2CN1SUHGAyg0HDmbGNn8
        iTYIS2fafcmD6fEI7PKvCePFHJAeJ2X0UQ==
X-Google-Smtp-Source: ACHHUZ4RRqdU2sBzfj7vWFZaEmlMfvlqMYJPXHB+JxX5HGFycK++RNBtDKWzq07yFfkRr1I9OyrCUQ==
X-Received: by 2002:a05:6512:3292:b0:4f8:5bbf:d195 with SMTP id p18-20020a056512329200b004f85bbfd195mr9848564lfe.20.1687439216191;
        Thu, 22 Jun 2023 06:06:56 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id f11-20020a056402068b00b0051a5fe585dcsm3940511edy.97.2023.06.22.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:06:55 -0700 (PDT)
Date:   Thu, 22 Jun 2023 16:06:53 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>,
        netdev@vger.kernel.org, linus.walleij@linaro.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set
 function
Message-ID: <20230622130653.52jirv45b3oh2d72@skbuf>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-2-paweldembicki@gmail.com>
 <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
 <CAJN1KkxGNZgzSA2_gVmMRg-LsZmZC2hQEvEjQQ3RSTT9ddGcAQ@mail.gmail.com>
 <70f3b45f-7c57-4394-b96e-20a014718f5f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70f3b45f-7c57-4394-b96e-20a014718f5f@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 03:01:02PM +0200, Andrew Lunn wrote:
> On Wed, Jun 21, 2023 at 10:38:22PM +0200, Paweł Dembicki wrote:
> > śr., 21 cze 2023 o 21:33 Andrew Lunn <andrew@lunn.ch> napisał(a):
> > >
> > > > +     struct vsc73xx *vsc = ds->priv;
> > > > +     /* FIXME: STP frames isn't forwarded at this moment. BPDU frames are
> > > > +      * forwarded only from to PI/SI interface. For more info see chapter
> > > > +      * 2.7.1 (CPU Forwarding) in datasheet.
> > >
> > > Do you mean the CPU never gets to see the BPDU frames?
> > >
> > > Does the hardware have any sort of packet matching to trap frames to
> > > the CPU? Can you match on the destination MAC address
> > > 01:80:C2:00:00:00 ?
> > >
> > 
> > Analyzer in VSC73XX switches can send some kind of packages to (and
> > from) processor via registers available from SPI/Platform BUS (for
> > some external analysis).  In some cases it's possible to configure: if
> > packet will be copied or forwarded to this special CPU queue.  But
> > BPDU frames could be sent to processor via CPU queue only. So It's
> > impossible to forward bridge control data via rgmii interface.
> 
> So am i correct in saying, if you actually enable STP, and it decides
> to block a port, the BPDUs are also blocked. After a while it will
> decide the peer has gone, and unblock the port. A broadcast storm will
> then happen for a while, until a BPDU is received, at which point it
> will block the port again.
> 
>      Andrew

This is pretty much the expected behavior from a tag_8021q based
implementation with no hardware assist for control packets. tag_8021q
can provide port identification, but it cannot transform a data packet
into a control packet and it cannot force the switch to accept packets
from ports whose data plane is disabled by STP.

I am also going to review this series in the following days, but I don't
have the required amount of time right now. Perhaps during the weekend.
