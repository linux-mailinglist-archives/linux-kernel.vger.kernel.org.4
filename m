Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1E673492
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjASJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjASJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:38:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3005D931
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674121064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nr0X4pF4tNp65HLbR/NR58efcTL+y2gHqNLglglxxZQ=;
        b=L6X1nbvKIdm5udhKhJ0sGAHoYRnmEKYLB14gGdt9z1XH7RD9CyYIFZSirLi4M1kWCcKerr
        qj6pASErRm+ypgRoVsZnNSmAdzjlzQT/c5BcCWFcVOF53UrfkqeOh2WNEcnU4+Sn190x26
        uTCUDhVWgfly0u9wFbuLIPY7eLcmnM0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-1mTcIE6HPmWtqXwAWvFd0g-1; Thu, 19 Jan 2023 04:37:43 -0500
X-MC-Unique: 1mTcIE6HPmWtqXwAWvFd0g-1
Received: by mail-qt1-f197.google.com with SMTP id w2-20020ac84d02000000b003b63cd590dfso667034qtv.14
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nr0X4pF4tNp65HLbR/NR58efcTL+y2gHqNLglglxxZQ=;
        b=NwGHhj1QY1U99FjO9F8Mnc+1d5CRGp/EK6pOmFxsQalfipXDB44lx7afBunLfQUGj4
         EyJLl8bOgNC+XVElVZyDPRNBqt5WSYlehmKHVvwfH5a0wQzDQaMdIc08lhvACOZxOo6G
         18n/YKclvYfZmMNXw/0lF6/znlbOPwBwJ7iAzmKcH/6MSle4MjhsPu+ioh9DbYirCjpt
         sBy5T/NpJNK0MyxEE6Se0Z5KTTQ2iOJn/2XfnGJzJbu/9cw/vXyT896Kr0bfWMAwsccT
         c1PeFFoa52hc7etKsVsuqYYQXazuQkV3WvOcgHZRITYnmdYt8jvofHtm7jel8rex8W1h
         6BtA==
X-Gm-Message-State: AFqh2kqTUrbVRn8ov6QluFTDjHe3zGSG0hNSNopHT8Y8vI/fR1e4b2JN
        1ogfJmpvuixTBqIGUzaZ+Cze9y1Q9INs88auhKkBp5dYFtEPGOgj9MCCgUsM2HYhGMnFPa2+enR
        sT5hzv3UepfbvhpKHtCCFUgJX
X-Received: by 2002:ad4:4591:0:b0:532:1870:b95c with SMTP id x17-20020ad44591000000b005321870b95cmr16345256qvu.17.1674121062837;
        Thu, 19 Jan 2023 01:37:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu3VECouFhHpnQdfc3lk1Wfn0B13sAUWhC1gY+Pkt7leW+CU8W1B904hMQzhJp6fBF6TyJvkQ==
X-Received: by 2002:ad4:4591:0:b0:532:1870:b95c with SMTP id x17-20020ad44591000000b005321870b95cmr16345229qvu.17.1674121062532;
        Thu, 19 Jan 2023 01:37:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-124-97.dyn.eolo.it. [146.241.124.97])
        by smtp.gmail.com with ESMTPSA id bs14-20020a05620a470e00b006b95b0a714esm3152468qkb.17.2023.01.19.01.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 01:37:42 -0800 (PST)
Message-ID: <0dfd9deea3497500ce55027a2308bdd823d587b5.camel@redhat.com>
Subject: Re: [Patch net-next 1/2] net: dsa: microchip: enable port queues
 for tc mqprio
From:   Paolo Abeni <pabeni@redhat.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux@armlinux.org.uk, Tristram.Ha@microchip.com
Date:   Thu, 19 Jan 2023 10:37:37 +0100
In-Reply-To: <20230117143252.8339-2-arun.ramadoss@microchip.com>
References: <20230117143252.8339-1-arun.ramadoss@microchip.com>
         <20230117143252.8339-2-arun.ramadoss@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 20:02 +0530, Arun Ramadoss wrote:
> LAN937x family of switches has 8 queues per port where the KSZ switches
> has 4 queues per port. By default, only one queue per port is enabled.
> The queues are configurable in 2, 4 or 8. This patch add 8 number of
> queues for LAN937x and 4 for other switches.
> In the tag_ksz.c file, prioirty of the packet is queried using the skb
> buffer and the corresponding value is updated in the tag.
>=20
> Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz9477.c      |  4 ++++
>  drivers/net/dsa/microchip/ksz9477_reg.h  |  5 ++++-
>  drivers/net/dsa/microchip/ksz_common.c   | 18 ++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.h   |  1 +
>  drivers/net/dsa/microchip/lan937x_main.c |  4 ++++
>  drivers/net/dsa/microchip/lan937x_reg.h  |  6 +++++-
>  net/dsa/tag_ksz.c                        | 15 +++++++++++++++
>  7 files changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
> index 47b54ecf2c6f..5a66d0be2876 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -991,6 +991,10 @@ void ksz9477_port_setup(struct ksz_device *dev, int =
port, bool cpu_port)
>  		ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_TAIL_TAG_ENABLE,
>  			     true);
> =20
> +	/* Enable the Port Queue split */
> +	ksz_prmw8(dev, port, REG_PORT_CTRL_0, PORT_QUEUE_SPLIT_MASK,
> +		  PORT_FOUR_QUEUE);

I think it would be nice here (and in lan937x_port_setup below)
explicitly checking that the owning ksz_device->num_tx_queues matches
the configured value.=20

Cheers,

Paolo

