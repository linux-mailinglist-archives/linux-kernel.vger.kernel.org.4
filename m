Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE50E6D5A53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjDDIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjDDIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C521BE6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680595710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mtn5RoXP7HXa+BOr8vc5/QnnSmZkKMTt0vR1h1F5mXI=;
        b=dWCvp1dn/cS7oRYxmodU9DNYaZmlDa48mfqa45z2YzC65PvKfrQJNUUUpYsJtxRwmk7mEg
        qj2q2nRlN1kii4Phx0j23dB1FBVNhIopfwT6KcUBrl0FIIdKtXpwY4BcZobsBdG9IKYaZf
        aDntYmi53mjPqE4s8AANz+YVUXijFSc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Sd1WixYbP12rTEY9q3Kuww-1; Tue, 04 Apr 2023 04:08:28 -0400
X-MC-Unique: Sd1WixYbP12rTEY9q3Kuww-1
Received: by mail-wr1-f71.google.com with SMTP id p1-20020a5d6381000000b002cea6b2d5a9so3503232wru.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 01:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680595707;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtn5RoXP7HXa+BOr8vc5/QnnSmZkKMTt0vR1h1F5mXI=;
        b=rc5Ig0IN4i6p8VhTnf/PPgihJlLg96sjDDWwaZ5ybyp+1vkpAy1PZBJxNuty/B3yKJ
         0HigC0kkLcMWpjbPPqTw6SeaBq4+PDnrAG62DAVfZjX3RhK/gFs/N1f8uSiDmJ7dvLFh
         uDDxirj5GoHLSxq9ZqG2M0RFx9A/pXNxkFUSiIQ8yPPgchmBMXiI0seHXO6EVi+jqpqg
         Ce0PZw+km4WL9/dEmsNNuVOOkDtjwH50ADP5Qm0CHGi9FGvbD5u97JgApsMEBwhwLCvH
         V8Xvv+m7dlLmGt7dpL44uBRID4OUz5VRZQm0TICHO1d8KC4Xwy6hadfokVddcfyoqshu
         D4Qg==
X-Gm-Message-State: AAQBX9ea3VRwCuPHctqEODzz17BL/rRfDT/WLlDo1J64/44/QrEJ3Yz/
        ojakTKSFKuwqmamQRMw9HRmDDmqxtUbzxIigSKNAcZjfA43yajJXcHT1a8qzsreqex2m8YITZdm
        x0NVorFtpzgX1Yr5p3TKB4aPj
X-Received: by 2002:a5d:4847:0:b0:2cf:e956:9740 with SMTP id n7-20020a5d4847000000b002cfe9569740mr15090854wrs.6.1680595707737;
        Tue, 04 Apr 2023 01:08:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350a6DZsF9Oxz2qiQs8bPQTVCKprYDZAyS4oPgFEDW46CEfH2BaASGaZqnn1vnIayoOh1lJQS6w==
X-Received: by 2002:a5d:4847:0:b0:2cf:e956:9740 with SMTP id n7-20020a5d4847000000b002cfe9569740mr15090833wrs.6.1680595707386;
        Tue, 04 Apr 2023 01:08:27 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l18-20020adfe592000000b002c5534db60bsm11647529wrm.71.2023.04.04.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:08:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <3738011.44csPzL39Z@diego>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
Date:   Tue, 04 Apr 2023 10:08:25 +0200
Message-ID: <87jzysdq86.fsf@minerva.mail-host-address-is-not-set>
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

Heiko St=C3=BCbner <heiko@sntech.de> writes:

Hello Heiko,

Thanks for your feedback.

> Hi,
>
> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
>> This baud rate is set for the device by mainline u-boot and is also what
>> is set in the Pinebook Pro Device Tree, which is a device similar to the
>> PinePhone Pro but with a different form factor.
>>=20
>> Otherwise, the baud rate of the firmware and Linux don't match by default
>> and a 'console=3DttyS2,1500000n8' kernel command line parameter is requi=
red
>> to have proper output for both.
>
> The interesting question is always if this will break someone else's setu=
p.

Indeed.

> I've never really understood the strange setting of 1.5MBps, but on the
> other hand it _is_ a reality on most boards.
>

As far as I understand, it is just to get a faster data transmission but I
have my doubts that it is worth to divert from the more common 115200 rate
just for this.

As you said though, it is a reality and also what mainline u-boot uses for
this device.

> Personally I don't care that much either way, but would like a comment
> from the other people working on that device - if possible.
>

Same, I don't care either but just that would be good to make Linux and
u-boot to match. If this change will break other people setups, maybe I
can convince u-boot to sync with Linux and also use 115200 for the phone.

> I guess if we don't hear anything, I'll apply it nevertheless at some poi=
nt
>
>
> Heiko
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

