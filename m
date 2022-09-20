Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D35BE73A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiITNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiITNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52D71409A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663681032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NiunG5lEgRx8uHT88ywFmLswiLdw2crA4TZVvGnjdB4=;
        b=bIb2aohfRxp1fngIKQOzMp5A2JCbPvZLiVbJYJsgkmVOYweyoVmerYJCcH2SYSzGz5dTyG
        REOvpCDqVLfba0RXSBPeHMk0lYmGDeVMbSRZE8m/RxIRc8KKt8n5bFhSibI+CW1cGJGYeE
        uW69WDKsjnYjnCvVFsuNNVG8Aoe0M54=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-Jr9D0D2UMJGIKzKc3AGJkA-1; Tue, 20 Sep 2022 09:37:08 -0400
X-MC-Unique: Jr9D0D2UMJGIKzKc3AGJkA-1
Received: by mail-pl1-f197.google.com with SMTP id k2-20020a170902c40200b001782bd6c416so1745285plk.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NiunG5lEgRx8uHT88ywFmLswiLdw2crA4TZVvGnjdB4=;
        b=EIi4MUKxxdRIZsjRZA9sOuMQ0kNG3vUxdq+6+ZFi6Yhz/XaM/21bGaryi14p1kFmTs
         7JpLG6DfRkxjgG+Lxj11C5rkHXNP80TbVN9/+L6ID2qqNgt2N1ic48a0cKQjtwPU1hs9
         y4DYQA+56c+r77k8D4VOwKwCFg3wuTH2VAgzKuH4/QDXKhIg0+Jyd65UlYIoBrLsibEu
         +/fOip2VPVuYsc/moTcS5zM7506ps1HplnD+EfzNhTruAnLlwjfA9onWoBqG8Gi4Plw8
         lRJcQcwFiFlN+2NqMjXijTXzfUB/cHCdoQ66uExQ4NmfvavFU4dzLASecDDWVnO95o84
         U0zA==
X-Gm-Message-State: ACrzQf11bi47k5v5uto8IYA2F40APc6EzqDy3A7Z23smV6k6QNQCwX6g
        /HdEfW2WYa1VvPmXuqW3WOpWaQGjUgXZgV1NMt83TVO0KbwEF3iM4ZOaMip4K4oWUAtqwd1JBvs
        /qTutX4jmfha2J6RVePw8hLWHAnPfAES15aEHEOOH
X-Received: by 2002:a17:90a:f28b:b0:203:627c:7ba1 with SMTP id fs11-20020a17090af28b00b00203627c7ba1mr4032705pjb.191.1663681027574;
        Tue, 20 Sep 2022 06:37:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kMhfi76feh/hNQhtyWADpBYP7hufD9cecKuFH43iHfOrZvurhATyy/+PgJMQM5SfCjnp/hTqbqfbVg18Bbto=
X-Received: by 2002:a17:90a:f28b:b0:203:627c:7ba1 with SMTP id
 fs11-20020a17090af28b00b00203627c7ba1mr4032672pjb.191.1663681027340; Tue, 20
 Sep 2022 06:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220812025515.19467-1-hbh25y@gmail.com> <64a3bd41-1184-e65b-e70f-01ef8daadb53@gmail.com>
In-Reply-To: <64a3bd41-1184-e65b-e70f-01ef8daadb53@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 20 Sep 2022 15:36:55 +0200
Message-ID: <CAO-hwJ+ct4UF6yEx0BPf6dHuw=sbMoo13oxPEoeEqdz6ut07ew@mail.gmail.com>
Subject: Re: [PATCH] hid: hid-logitech-hidpp: avoid unnecessary assignments in hidpp_connect_event
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 9:57 AM Hangyu Hua <hbh25y@gmail.com> wrote:
>
> On 12/8/2022 10:55, Hangyu Hua wrote:
> > hidpp->delayed_input can't be assigned to an object that already call
> > input_free_device when input_register_device fails.
> >
> > Fixes: c39e3d5fc9dd ("HID: logitech-hidpp: late bind the input device on wireless connection")
> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > ---
> >   drivers/hid/hid-logitech-hidpp.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index 68f9e9d207f4..c3602bf8f9b9 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -3959,8 +3959,10 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
> >       hidpp_populate_input(hidpp, input);
> >
> >       ret = input_register_device(input);
> > -     if (ret)
> > +     if (ret) {
> >               input_free_device(input);
> > +             return;
> > +     }
> >
> >       hidpp->delayed_input = input;
> >   }
> Gentel ping.
>

Applied to for-6.1/logitech in hid.git

Sorry for the delay

Cheers,
Benjamin

