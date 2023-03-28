Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261606CB488
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjC1DJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjC1DJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C62129
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679972908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DF8xiGEDG2aydgSMMjZ0jG6716l6RkLPMVKpPTgA1LU=;
        b=DcqN28mJz68llqd8XZbgbb6+qX1IjOgg5VaYOC+h/EMg6pNDDToxRZQ86nDLvLH01MnoQ2
        UMg+5P79n3X302TRJ/F0uRQv93J4Gv9xGkZkvVt5Iv965njHZNNcXjXb9wvu4lU55DXXqm
        jaHIqbVCeyLOf0dDF1l9OkfUN/mnCzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-oK-R1aiKMEuZQJUt4Hs61Q-1; Mon, 27 Mar 2023 23:08:24 -0400
X-MC-Unique: oK-R1aiKMEuZQJUt4Hs61Q-1
Received: by mail-wm1-f69.google.com with SMTP id l16-20020a05600c4f1000b003ef6ed5f645so2289156wmq.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972903;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF8xiGEDG2aydgSMMjZ0jG6716l6RkLPMVKpPTgA1LU=;
        b=eRUltcJI0BH3rf74BcYB9zccBvojZN6/suHhpgnCnhxHnVHl+53JAVnBkX3b+a9JFV
         fud3qTnCJTzO181KdRM5Ls8fjLm2CQSK/5fvuhArT3LUNw9IP1+ifV4XH9m3Z8taAIXr
         YjfJ6VrD9j4juedcwcLetjEM3oYGbbNGnEm2cyHMv53ZKmRtEiVYiA6tc9itZxzIsNbE
         UuvfV6GHhDAZXIuqKcTz237T/r0RzK4Jc5CQFayF2rERiZWz2ESvDFotGuYENuddPNl7
         bA/mU/jzYwxE1978y1R+U6SYpGQRItOblW9nOxeTSyCA48T/kSA0mjB4n8AdkvT8Zsvx
         mPfA==
X-Gm-Message-State: AAQBX9cmev+oYzACzawzj8ZS4NzzexiuFqWMrmFB/v1YmSPiSsk4ANA0
        nR7P/CBVsIqwrYB1iTWAb+iVteB5UhMrbQI9fJ/Ym8bc+P8wdvyuw0HVzUzikqGFu67B5CXZ+mV
        JaLaY3ecRwncCNPS2nv+QDq69
X-Received: by 2002:adf:f1c3:0:b0:2ce:adbf:cb14 with SMTP id z3-20020adff1c3000000b002ceadbfcb14mr11653877wro.28.1679972903648;
        Mon, 27 Mar 2023 20:08:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZKIAjbXHGpog35RyWxzgmMXVcD6mNpoeRHryb054olGh4cgVbvxNpHT37A2iqHNRx4L23JiQ==
X-Received: by 2002:adf:f1c3:0:b0:2ce:adbf:cb14 with SMTP id z3-20020adff1c3000000b002ceadbfcb14mr11653856wro.28.1679972903250;
        Mon, 27 Mar 2023 20:08:23 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d10-20020adfe88a000000b002c70e60abd4sm26534411wrm.2.2023.03.27.20.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:08:22 -0700 (PDT)
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
In-Reply-To: <20230327194518.qkm5qgap6vkivpeg@core>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <20230327130147.wgxl2qayhzsi2xak@core>
 <87wn32rynm.fsf@minerva.mail-host-address-is-not-set>
 <1924921.PYKUYFuaPT@diego>
 <87mt3yrwzo.fsf@minerva.mail-host-address-is-not-set>
 <20230327174855.xpxrdfldqcxk463r@core>
 <87jzz2rrfr.fsf@minerva.mail-host-address-is-not-set>
 <20230327194518.qkm5qgap6vkivpeg@core>
Date:   Tue, 28 Mar 2023 05:08:21 +0200
Message-ID: <87a5zxshcq.fsf@minerva.mail-host-address-is-not-set>
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

> On Mon, Mar 27, 2023 at 08:15:52PM +0200, Javier Martinez Canillas wrote:
>> Ond=C5=99ej Jirman <megi@xff.cz> writes:

[...]

>> > Just because something is in my tree doesn't mean it's mine, or that I=
 reviewed
>> > it in detail and prepared it for upstreaming, or that I'm interested in
>>=20
>> Thanks for the clarification. Because the patch had your authorship I
>> wrongly assumed that came from you. Sorry about the confusion.
>
> Ever since base DT support for Pinephone Pro was merged, none of the DT p=
atches
> in my tree are in the original form as prepared by the authors + fixes I'=
ve
> added. That's simply impossible anymore.
>
> To look up who did what, you'd have to look at older branches, pre-merge.
>
> Patches after the merge just came from squashing everything into one patc=
h,
> cleaning it up, and re-splitting along some vague functionality boundarie=
s,
> while trying to keep best-effort original SoBs as faithfully as possible,=
 so
> that I can keep maintaining the PPP support in a sane manner.
>

Go it.

> Anyway, SoB's are added in chronological order. So:
>
> https://github.com/megous/linux/commit/471c5f33ba74c3d498ccc1eb69c098623b=
193926
>
> Means the author of the changes is Martijn + Kamil (roughly) and I may ha=
ve
> a line of code in there too, since my SoB is last. For some reason, the o=
rder is
> inverted in the patch you posted, making it seem I developed these changes
> originally.
>

Since the patch had your authorship I changed the order so that your S-o-B
was first but I'll then change the author in v3 and make it match the
first S-o-B entry in your tree (Martijn) then.

>> > upstreaming it. I'm just trying to help you with your upstreaming effo=
rt by
>> > testing and review since I got to know the hardware quite well over th=
e last
>> > years and can check the schematics and datasheets quickly, and I like =
to think
>> > upstream code is held to higher standard. That's all.
>> >
>>=20
>> Appreciate your help and I agree that upstream code should be held to a
>> high standard. But since the DTS in mainline is pretty basic anyways (you
>> can only boot to serial right now), is not really usable for other thing
>> than development and keep adding the missing support.
>
> Having wrong frequency used is not a missing support for something. Sorry=
 it's
> too bothersome to get the review piecemeal, but sometimes people have mor=
e time to
> look at patches in-depth, and at other times they don't and you just get =
surface
> level or no review.
>

Ok.

> One point of posting patches to the mailing list is to get review. And it=
's not
> that great to do in-depth review for you, up to going through schematics =
and
> datasheets, testing, and even proposing and testing solutions for found i=
ssues,
> just to be dismissed without technical reason.
>
> The thing is this review will most likely happen just once, and noone wil=
l go
> back, read through the entire huge DT along with a schematic, to look at =
whether
> this or that pullup is really necessary, whether some parameter is out of=
 spec
> from the datasheet for each part, or things like that. That's just not
> pragmatic.
>

That's fair.

> Instead, people will happily attribute non-obvious issues caused by these
> omissions of manual review to shoddy or slow or power-inefficient HW. "1k=
Hz
> + harmonics interference in codec because high power backlight DC-DC regu=
lator
> basically spews off 1kHz of 1-2W load + harmonics because it's driven
> incorrectly? Ah, the phone just has a shitty audio codec!"
>
> So, don't take it as some perfectionism. Upstreaming just seems like the =
best
> time to look at things that were overlooked in the past in more detail an=
d get
> these little things right, because the DT additions are done piecemal and
> slowly/gradually, so it's more manageable to review and fix right away. T=
his
> will just not happen later on for these obscure devices like Pinephone Pr=
o,
> where the whole effort that goes into it is like one half of a fulltime
> developer time split over 4 mildly interested real persons, slowly taperi=
ng off
> over time as the device ages.
>

Makes sense. I'll address your comments in v3 then and also include a
separate patch (again with Martijn as author and the S-o-B as ordered in
your tree), that includes the touchscreen DT nodes as well. Since Jarrah
pointed out that there's already the correct compatible string in the
driver's OF device ID table.

> regards,
> 	o.
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

