Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E55F35D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJCSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJCSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:47:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5634C43304
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:47:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so17885403lfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date;
        bh=sNHqaLvh9j7PQaVZTiLvLFSUg+LSJYbTo2qeLVIoD3Y=;
        b=deotAUsUURWwRjphlZdfLNEaHjwUp+MLHRyXZw6CM0D9vc1Gp7uh/G3Yx//Zp1hr0n
         yJAUSt8ogxQkJUcjJcSd3qvdQz+UK0behCYUSt8UTQFCS+rbRd9n9M0BN+AoaVPd2rFL
         N6sq+GD5SjED8LzF6f3J+8kU6mIVhjZdY9rWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sNHqaLvh9j7PQaVZTiLvLFSUg+LSJYbTo2qeLVIoD3Y=;
        b=NGbkKsZekA6nvKYLpIgt96mbzrTURHNGcdHanTzcWwVy0U7mMsgP7iDAj7uBxjgiZq
         f+FxXYe7aQFbhDetDXUEjfNtBbvuuyTre26ZTZsqMW0yfkq6mXkTcTpBNiFOLeabEkju
         tiinr7p9rti26gzBy+h5dNbYYE3GxkZIK/RBSmfrLmhuDnY4w2ElYUlKOk2VA+c78Yt3
         0iCamQWGrvwL0M5QOocKff3/OyTZ3eN4vgnfrs8JZQRIiRwwJyCUMTNO6uNFUrrdUaAe
         yg9O+b2ceG/VmixSdnbB9eUPOnSglXWziSRWIv3b4oJnL1CoBVLMTAKvfbbNu73QGYDD
         Ixsg==
X-Gm-Message-State: ACrzQf0FnVihuIiFVdxOlIlxSsBdqdwgpKd4JyAeOCOrte/f1we5Dhq/
        jzhKRtBMqkjne7ypFwUOXLPoOEXhz0H2UGkqJ/AX7w==
X-Google-Smtp-Source: AMsMyM4Egg8t2NfbF9XrWUC3S5gmlEK1LZAho5qwWLHUfSisoykyIi/tyV7UdyDv/HxJkTxuD+6qZ3eCOHOx+TYUOOA=
X-Received: by 2002:a19:7518:0:b0:4a2:4593:6e14 with SMTP id
 y24-20020a197518000000b004a245936e14mr1461955lfe.82.1664822822563; Mon, 03
 Oct 2022 11:47:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Oct 2022 11:47:01 -0700
MIME-Version: 1.0
In-Reply-To: <YzXdhVN/Zp7DDIzB@google.com>
References: <YsLhxx+L3+GJDRyO@google.com> <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com> <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com> <Yuz2O+lZ5W7RviuA@google.com>
 <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
 <YzQf7hf15vvLeGse@google.com> <CAE-0n50cX5ky3By976RTecKkpeMoAjoBA4tYuWSZ150JfS9wiQ@mail.gmail.com>
 <YzXdhVN/Zp7DDIzB@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 3 Oct 2022 11:47:01 -0700
Message-ID: <CAE-0n53q-8u16_7KGZ0jbm9ES=dsSJL7rbGdz6hzLWf3xvm=bQ@mail.gmail.com>
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Lee Jones <lee@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2022-09-29 11:01:41)
> On Wed, 28 Sep 2022, Stephen Boyd wrote:
>
> > Quoting Lee Jones (2022-09-28 03:20:30)
> > > Wouldn't it make more sense to simply separate the instantiation of
> > > the 2 I2C devices?  Similar to what you suggested [0] in v9.  That way
> > > they can handle their own resources and we can avoid all of the I2C
> > > dummy / shared Regmap passing faff.
> > >
> > > [0] https://lore.kernel.org/all/CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com/
> > >
> >
> > You can continue reading the thread[1]. My understanding is it's one
> > chip that responds on two i2c addresses, thus we don't describe that as
> > two i2c device nodes in DT. Instead we describe one node and use the
> > dummy API to make the second i2c device.
> >
> > [1] https://lore.kernel.org/all/Yk3NkNK3e+fgj4eG@sirena.org.uk/
>
> As Mark says, it's probably 2 separate dies that have been encased in
> the same IC and are otherwise unconnected.  Not sure I understand the
> comment about not requiring another 'struct device'.  It will still
> require that whether it's a platform device or an I2C device, right?
>

Yes a 'struct device' will be required for each i2c address no matter
what happens.

It is also useful to describe the hardware as one device node in case
there is a shared reset signal or power supply. That allows us to have
one driver probe the DT node and deassert the reset/power the chip on. I
think this device has one reset signal, so we really need to do this and
not treat them as completely independent i2c devices (the 0x8 and 0x9
addresses).

Can we move forward with my plan to have another i2c device made for
'pm8008-regulators' and have that driver be an i2c driver that probes an
i2c device manually created in the pm8008 driver? I think that would
handle the reset ordering problem because the pm8008 driver can deassert
the reset and also handle the regmap passing stuff by letting the i2c
device at 0x9 make its own regmap.
