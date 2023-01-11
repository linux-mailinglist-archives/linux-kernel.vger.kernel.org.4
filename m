Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCE6654FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjAKHFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjAKHFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:05:08 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE528FCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:05:06 -0800 (PST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 78E2B3F769
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1673420700;
        bh=gi72aY1DlVU3picdZhHkv2z+u2P81TiekouM7JWEQCE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IYs+Zjz1aNhWY7usPRvveKgtrV5SftE1qzNsCDOrliIP+LFx2Ko24BbeDPAer/pev
         zUCPGwyvkSsF7AjhTvv6cnmPQwkCUuk2s6sH3fHsTHNWTiZb2f8Jlt7rVHR0fS9TL+
         bVI0a9ZLZd0Y3zecYuv0HUL7fUATwsR83DpMDVU/78nr50lssei22Zq0IA2hhKXdG9
         sdBcT6hNcBtf/kV1BenWBrrUhBbazGCsa2OnQjiAUwPE0o7fxyi1lyCOWQaO2S73Sp
         udi8gbnlRt0Zk9FD9YjTouSpQYEeHbD78uuAuNA+8RxvMXqpWuvV3JCvM/jBKoCDVZ
         6rK92V5BnWsgQ==
Received: by mail-pf1-f197.google.com with SMTP id y19-20020a056a00191300b0058217bbc6ceso6437628pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gi72aY1DlVU3picdZhHkv2z+u2P81TiekouM7JWEQCE=;
        b=Kap40gVt0winjg9570JtuMA/sHSoRHLrJHDXqJs88DQDtqjyUUnpODbw7wVXDPthrY
         ZZI2PZJgC7Pzpl9px0Erxu7t8Q1QplnhoGSgmQL1zU4VPfIRR0c/GgqaSNecj92Gdt7z
         CR+xkThOP0CQEq5LwfU3n2RlpYUgpTesNbNODyYvx9t+v3H1XIDyrRkVv013i5HrpAki
         a+vsMFGlvhH1QNj5DyGtK0snzEeUe2YGOK2f6L5xHHAPwWJev60e3EbpyOMxl0fj2YwA
         G40blss9wE3Yk2Ly2IGvRZ3X2UJfzUdRkxwIbJVyaJqqvmRO8lI0XM301DE7Max6o5mB
         HFdQ==
X-Gm-Message-State: AFqh2krRNxsNrbxTx7NnxHCRSf/bCoBbNhXJdk4F7v8PRQZD6OxvAQDO
        AjLNfS4hsp0aV50j4FkRngHXLUn9VUgTlgOuUWsceKTxGp1m94Jtr+G6+m1Ovfa4mymIhHPVgjW
        zYal8e6F/y6XA3qvJ9mDRNneGVIe1s5TCXmPMKyYGJCzVLqZzD2YjuMKw4w==
X-Received: by 2002:a63:d050:0:b0:484:55ce:2577 with SMTP id s16-20020a63d050000000b0048455ce2577mr3634248pgi.172.1673420698794;
        Tue, 10 Jan 2023 23:04:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXunCBGBXUEqW3ABN38bY/IFoGVtl65JjufpI/koQ1K5VS+zWb6gRO1SlpLihN8lmXNXmTsXHmcF+4aBm0ieEnQ=
X-Received: by 2002:a63:d050:0:b0:484:55ce:2577 with SMTP id
 s16-20020a63d050000000b0048455ce2577mr3634238pgi.172.1673420698421; Tue, 10
 Jan 2023 23:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20230110081938.30308-1-yangyinglu@loongson.cn>
 <CAAd53p6eUNJf7aNkiXcTKAfhL_cM1Ki7JnW7s4oP7BeFQkP6ag@mail.gmail.com> <e684e8d7-6fc9-3331-868c-6cc4122f2cef@loongson.cn>
In-Reply-To: <e684e8d7-6fc9-3331-868c-6cc4122f2cef@loongson.cn>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 11 Jan 2023 15:04:47 +0800
Message-ID: <CAAd53p7_dQc0z_2Bw29xxnxMx6rSdJE7hj-MvH3HszSyE0uWCQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: handle warm-reset port requests on hub_init
To:     yangyinglu <yangyinglu@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi yangyinglu,

On Wed, Jan 11, 2023 at 11:32 AM yangyinglu <yangyinglu@loongson.cn> wrote:
>
>
>
> =E5=9C=A8 2023/1/11 =E4=B8=8A=E5=8D=8810:33, Kai-Heng Feng =E5=86=99=E9=
=81=93:
> > Hi yangyinglu,
> >
> > On Tue, Jan 10, 2023 at 4:20 PM yangyinglu <yangyinglu@loongson.cn> wro=
te:
> >>
> >> USB-C storage device not detected on USB 3.0 host when
> >> plugged in after boot, so need to warm-reset port
> >
> > Is it possible to enable USB dyndbg, plug a USB 3.0 device, then paste
> > the relevant dmesg here? Thanks!
> >
> > Kai-Heng
>
>   hi,
>      After entering the system, directly plug and unplug the USB flash
> disk. usb control is  etron Technology Inc.The log is as follows:
>   [   10.354484] radeon 0000:04:00.0: vgaarb: changed VGA decodes:
> olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
>   [   10.484794] bridge: filtering via arp/ip/ip6tables is no longer
> available by default. Update your scripts to load br_netfilter if you
> need this.
>   [   10.506968] tun: Universal TUN/TAP device driver, 1.6
>   [   10.514128] virbr0: port 1(virbr0-nic) entered blocking state
>   [   10.519858] virbr0: port 1(virbr0-nic) entered disabled state
>   [   10.525646] device virbr0-nic entered promiscuous mode
>   [   10.666536] virbr0: port 1(virbr0-nic) entered blocking state
>   [   10.672268] virbr0: port 1(virbr0-nic) entered listening state
>   [   10.748564] virbr0: port 1(virbr0-nic) entered disabled state
>
>   Loongnix GNU/Linux 20 Release 3 loongson-pc ttyS0
>
>
>   loongson-pc login: [  147.701011] usb usb4-port1: Cannot enable. Maybe
> the USB cable is bad?
>   [  151.793206] usb usb4-port1: Cannot enable. Maybe the USB cable is ba=
d?
>   [  151.799726] usb usb4-port1: attempt power cycle
>   [  157.465465] usb usb4-port1: Cannot enable. Maybe the USB cable is ba=
d?
>   [  161.557649] usb usb4-port1: Cannot enable. Maybe the USB cable is ba=
d?
>   [  161.564167] usb usb4-port1: unable to enumerate USB device
>   [  165.641834] usb usb4-port1: Cannot enable. Maybe the USB cable is ba=
d?

Is it possible to enable USB dyndbg by adding kernel parameter
"usbcore.dyndbg" so we can see the portsc?

Kai-Heng

>
> >
> >>
> >> Signed-off-by: yangyinglu <yangyinglu@loongson.cn>
> >> ---
> >>   drivers/usb/core/hub.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> >> index 77e73fc8d673..bd4496b80c2d 100644
> >> --- a/drivers/usb/core/hub.c
> >> +++ b/drivers/usb/core/hub.c
> >> @@ -1159,7 +1159,7 @@ static void hub_activate(struct usb_hub *hub, en=
um hub_activation_type type)
> >>                  }
> >>
> >>                  /* Make sure a warm-reset request is handled by port_=
event */
> >> -               if (type =3D=3D HUB_RESUME &&
> >> +               if ((type =3D=3D HUB_RESUME || type =3D=3D HUB_INIT2) =
&&
> >>                      hub_port_warm_reset_required(hub, port1, portstat=
us))
> >>                          set_bit(port1, hub->event_bits);
> >>
> >> --
> >> 2.20.1
> >>
>
