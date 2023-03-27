Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81E06CACD6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjC0SQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjC0SQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DF30D3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679940956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UK/vUrhHuqntUFN+BgSrVc4SUZdQT7VSDoiLy/b5Axs=;
        b=EY6uhTSueeEahosF6tSWQUoT/1qn4belNrDu3QdL7iv2G7KafOsZKWNGSxcVx6f2aXu7ud
        9rmfijrtjLUYzXmYha7oQmHP3UHfc5R2GFcp18Uehlqt5bSxdx1x1PBX3oyvJPtuqgf+uV
        uCg/IO9u3chECOfRNR/tVZ8VRA/MSA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-xMloD1eCN6K0v2uhBBa7XA-1; Mon, 27 Mar 2023 14:15:55 -0400
X-MC-Unique: xMloD1eCN6K0v2uhBBa7XA-1
Received: by mail-wm1-f69.google.com with SMTP id m7-20020a05600c4f4700b003ee7e120bdfso5114644wmq.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 11:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940954;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK/vUrhHuqntUFN+BgSrVc4SUZdQT7VSDoiLy/b5Axs=;
        b=wP1tYGYqeRv9xzYwbn24DGcGxkjnIPANil5PdI6ZhCO01ui3Yu2dFU7sMhjGf1U3qg
         iwkCKnNjflNayuSJItJk/Cj3G2tYqDeMI8QuUhSDqrp05rhYJ6burcvWyVC/LLkc1rBS
         /VBw9NWbD7KZKtBerlrh4X69tScgkfvfVQxJYLMW/8XFJLLgHcGhesMQMpYitnvXj69v
         rndFpAhZxgp+YeAPJP49xrEUj1DrChFvMFsKxcbKkBmYJp0e+PqwhES6l6P1E89vAWxw
         nMGwQtIibsem77NeNxjLTgv/qSparc//L/bNuQU707oZSA1DpdYrSn6oIZq51Ff05FtL
         4P0A==
X-Gm-Message-State: AAQBX9erB1yFbae20HAZRwHaK+HlPJwf59FNQF+ipfGmVRcSOD8wa0f7
        pd9mwKmOwvNhU/yW+ShFYZHUC0Tc69A9ctiAa/My85HO6TQCgk4MOZkMeo39pWpQLD1zWbzmzWU
        0qY1evv8MJhhGdkgsQHrLw1Mm
X-Received: by 2002:adf:e98b:0:b0:2c5:4ffb:b5d4 with SMTP id h11-20020adfe98b000000b002c54ffbb5d4mr10067894wrm.19.1679940953968;
        Mon, 27 Mar 2023 11:15:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZaT6ahYHthFl0PUIe9zMPk4lKHZv5UbJklHs82pkUCUN/DtNmeerfQ+58giM6OUYgp3Y5NMA==
X-Received: by 2002:adf:e98b:0:b0:2c5:4ffb:b5d4 with SMTP id h11-20020adfe98b000000b002c54ffbb5d4mr10067876wrm.19.1679940953689;
        Mon, 27 Mar 2023 11:15:53 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p17-20020adfcc91000000b002c71dd1109fsm25758248wrj.47.2023.03.27.11.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:15:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
In-Reply-To: <20230327174855.xpxrdfldqcxk463r@core>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <20230327130147.wgxl2qayhzsi2xak@core>
 <87wn32rynm.fsf@minerva.mail-host-address-is-not-set>
 <1924921.PYKUYFuaPT@diego>
 <87mt3yrwzo.fsf@minerva.mail-host-address-is-not-set>
 <20230327174855.xpxrdfldqcxk463r@core>
Date:   Mon, 27 Mar 2023 20:15:52 +0200
Message-ID: <87jzz2rrfr.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ond=C5=99ej Jirman <megi@xff.cz> writes:

> On Mon, Mar 27, 2023 at 06:15:55PM +0200, Javier Martinez Canillas wrote:

[...]

>>=20
>> It is broken though? This is what is in Ondrej downstream tree and I see
>> no issues on my Pinephone Pro. He mentioned some flicker when looking at
>> the signals with a scope and hooking a photoresistor.
>
> LED regulator is driven out of spec by a frequency that's 20x lower than
> recommended, if you want short version of what's broken about the DT patc=
h.
>
>> But that's fair. I'll let Ondrej then post a v3 if he wants to address t=
he
>> issues he pointed out, since is his patch after all.
>
> It's not my patch. Original author of the DT is Martijn or Kamil. I just =
carry
> their DT work in split-up patches in my tree, and I sometimes try to find=
 solutions
> to bugs I find when using PPP. That's the story of these DT changes you'r=
e posting.
>
> Since you posted this DT patch for upstreaming, I wanted to help you by r=
eviewed
> it more completely, so I opened the schematic and datasheets for the comp=
onents
> that are described in this patch, and discovered these new issues I comme=
nted
> about. And I also tested it on top of linus/master.
>
> Just because something is in my tree doesn't mean it's mine, or that I re=
viewed
> it in detail and prepared it for upstreaming, or that I'm interested in

Thanks for the clarification. Because the patch had your authorship I
wrongly assumed that came from you. Sorry about the confusion.

> upstreaming it. I'm just trying to help you with your upstreaming effort =
by
> testing and review since I got to know the hardware quite well over the l=
ast
> years and can check the schematics and datasheets quickly, and I like to =
think
> upstream code is held to higher standard. That's all.
>

Appreciate your help and I agree that upstream code should be held to a
high standard. But since the DTS in mainline is pretty basic anyways (you
can only boot to serial right now), is not really usable for other thing
than development and keep adding the missing support.

So I thought that we could do it in steps without creating that much work
for the people trying to post the downstream patches and having to re-spin
too many times.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

