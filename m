Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD93606B33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJTWW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJTWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:22:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065B21F969;
        Thu, 20 Oct 2022 15:22:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so3068850ejd.0;
        Thu, 20 Oct 2022 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUtLr3Jbo7GZnvgJzANF6jQHbIVhzQh3y6ixKOvAPXo=;
        b=DttN9psdbpPYErN6YXalwrsrRXAUdqLf1tTiEiv3aHR7hwUPNsJ3XpMnOJ7i++3wcb
         +VYSg2HJYCHP72n63x+61Ojj/9BuNgJcDwD4Mr0gIFwh4iQ8i2tf1/LqjvTu88RQqR4q
         V0OkrDF7UApLKboL7A0NnXO8kJoZzjZILZpSiPZOck+DgU1tDCtFqVnzofPvv17utcFT
         bhRpJlCR33i+AbX4+wfDAUoyY+5lKCSFYzWefLwNtoXOQAEkx8MiWnmXNaN5EjEs8012
         ZGACeEBSUMsWBDi4LNc6wR82/flbymaAalE0AiyXeiXEN82o7o6Sq80NUN7Y27c7x1Kr
         /ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUtLr3Jbo7GZnvgJzANF6jQHbIVhzQh3y6ixKOvAPXo=;
        b=NMRrflXZ6GVEnuQvcry8OFy2JxBaKLSbkjuchDnmSfcrvY4xenVaHz/IOLqF1JDzTK
         zY8po7cZhgE2t98aMWelnD4PbH7GBigJjY89RUq4ui9vuN8JL8XadFypW7ENad+QAuFU
         YsIFc7APGp7Hi2ObLVaglCIFGoVuz7NZJaDRfZMR/HnECCesAMYPAOoFvzq+2M5OcIC6
         0Ew/VGT7tz2g9beFoqLmN4w9Mk7W99sKcnexl205xjGvFKYhF80Efw6HC8+ddWUy9xDo
         pE2v1/IbrfkW/upknYFQ9atCUbbSDqJ5Hr9ONBbvvHlpypDVO6FGNVZH9+0u5FlZWjci
         147w==
X-Gm-Message-State: ACrzQf2Q0jUK5ZrIsQcvU0PVH5z48Us/cvD1CAxXBi+DJWFkjm84il6S
        FlZhlp7AbemQ7IRuZoe6ZmsRAPvZnQTOill/mbU=
X-Google-Smtp-Source: AMsMyM7MYQWSBn3LPpLc4FJzQnBm2+2XSQ6lgUoRkr3mZI0Bj4peiRJtW5vWWw/LYsT2AOkC2VPHX1h7yg0pfC33feY=
X-Received: by 2002:a17:907:3c81:b0:77a:327a:815f with SMTP id
 gl1-20020a1709073c8100b0077a327a815fmr13052324ejc.422.1666304540539; Thu, 20
 Oct 2022 15:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
 <20221020210320.1624617-5-martin.blumenstingl@googlemail.com> <20221020221417.GG4035307@roeck-us.net>
In-Reply-To: <20221020221417.GG4035307@roeck-us.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 21 Oct 2022 00:22:09 +0200
Message-ID: <CAFBinCB3oKxdCNbjAtO+tw+yGrb1oBJwtHxCh_ptTPB6MTw5uA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] hwmon: (jc42) Don't cache the temperature register
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Fri, Oct 21, 2022 at 12:14 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Oct 20, 2022 at 11:03:20PM +0200, Martin Blumenstingl wrote:
> > Now that we're utilizing regmap and it's regcache for the
> > minimum/maximum/critical temperature registers the only cached register
> > that's left is the actual temperature register. Drop the custom cache
> > implementation as it just complicates things.
> >
>
> Ah, you got there eventually. Just combine this patch into the first
> patch of the series. No need to keep separate patches, especially since
> a lot of the code changed in patch 1 and 2 is just thrown away here.
Thanks again for the quick response and for the great feedback. I'll
combine the patches tomorrow and send a v3!

> That reminds me, though: Make sure that the alarm bits are not dropped
> after reading the temperature (running the 'sensors' command with
> alarms active should do). I have some JC42 chips here and will do the
> same.
I configured below ambient high and crit temperatures:
  jc42-i2c-0-1a
  Adapter: SMBus PIIX4 adapter port 0 at 0b00
  temp1:        +35.0=C2=B0C  (low  =3D  +0.0=C2=B0C)                  ALAR=
M (HIGH, CRIT)
                        (high =3D +25.0=C2=B0C, hyst =3D +25.0=C2=B0C)
                        (crit =3D +30.0=C2=B0C, hyst =3D +30.0=C2=B0C)

Then I ran "sensors" three times in a row.
The output of all "sensors" commands is the same, meaning all of them
show the ALARM (HIGH, CRIT) part.

Do you want me to mention this somewhere (for example in the
cover-letter or the new patch #1)?


Best regards,
Martin
