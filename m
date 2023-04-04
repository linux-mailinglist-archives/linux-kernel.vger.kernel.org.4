Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF666D5B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjDDIrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjDDIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629EB1BFE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680598017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G99E3diY62ZpH4JZ1b4pZ2Ts787AInV4dhcYUQ8Vmz8=;
        b=AJb6H1Y63PWX5b4IVqjFG07GIH83/swVhQjLknWUuiCSKvkvikIqzBX0i0lseRgNBBf/sK
        DZtgdePYj9xTOSfWVj6Ubybz842gmdMM4by9Cguq6iXl0UOVPcHXrDUdPnO6jKk9q5Unwv
        5rSLm//X2vl3Gt5R1pxfcWWal6Mm788=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-FF-Yh6L9ML6818PFtx3qiQ-1; Tue, 04 Apr 2023 04:46:56 -0400
X-MC-Unique: FF-Yh6L9ML6818PFtx3qiQ-1
Received: by mail-wm1-f70.google.com with SMTP id z20-20020a05600c0a1400b003edcff41678so294505wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 01:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680598015;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G99E3diY62ZpH4JZ1b4pZ2Ts787AInV4dhcYUQ8Vmz8=;
        b=e0523OE1Q/apg6aigvtyh3MK+MNttrPRknKaUOn2NHnaknvg9OhSfj3Y1aDr3NlXYl
         hbPlf58zvtzNXbYCwm94TRgLISwibz02LZGyriZWJBIm8/jdD/Q1oJBOFERBED4RQ2vj
         eOr/apG/6OknBinjoOE9/vZlrQijhe7bh1wyoiPtlnxVvkZjbJum6kopPyj5F66ahYxx
         kceOBvXgI8dQrcgyzzgyfP8O6eb2Pw5cRogln9nh/ja4Qxh8xZNPWWem6ickvdBCefDE
         cHMVBf7ZE1Toa42BR4lgCprMDeoYL/3MVEZuLqYCvAjYMOvry9+P1U+TbOXsQkZdUf2F
         gn9Q==
X-Gm-Message-State: AAQBX9eA6WG0IjTmPMAso5xAUhN7OZug2U439QoIFPubm3T/RbnTiCMY
        muigpMUFbVIxIs0EGrHRS481XJHbTyHeY0vXDDNZoREQLZXGviDFimCTfTQ96RRC4kkSQSBB8Tw
        exxQFsV2zBums694N4WnLXa1m
X-Received: by 2002:adf:f005:0:b0:2d6:cc82:3c49 with SMTP id j5-20020adff005000000b002d6cc823c49mr931479wro.13.1680598015276;
        Tue, 04 Apr 2023 01:46:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8i51Ygry+zzbcD2bOKjp+1nQQ1biyfzppPWMmvxDvdWIJCYlOOMGrJyFI4cevmr2NBMZoWw==
X-Received: by 2002:adf:f005:0:b0:2d6:cc82:3c49 with SMTP id j5-20020adff005000000b002d6cc823c49mr931458wro.13.1680598014942;
        Tue, 04 Apr 2023 01:46:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g6-20020adfe406000000b002d743eeab39sm11753376wrm.58.2023.04.04.01.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:46:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     Jarrah <kernel@undef.tools>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, Caleb Connolly <kc@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <CALeDE9M4eNq1sfQ-UcNZr8naYThmLFxDpt=zj8WkCSzHPUY8ug@mail.gmail.com>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
 <d7efebcc-5b5b-185e-bec8-b6b9d5d27d93@undef.tools>
 <87h6twdpi7.fsf@minerva.mail-host-address-is-not-set>
 <CALeDE9M4eNq1sfQ-UcNZr8naYThmLFxDpt=zj8WkCSzHPUY8ug@mail.gmail.com>
Date:   Tue, 04 Apr 2023 10:46:53 +0200
Message-ID: <87bkk4dog2.fsf@minerva.mail-host-address-is-not-set>
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

Peter Robinson <pbrobinson@gmail.com> writes:

> On Tue, Apr 4, 2023 at 9:24=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[...]

>> > At least for me it's been convenient to have both the PP and PPP use t=
he
>> > same settings while debugging.
>> >
>>
>> Agreed, all my other boards use 115200 as well, the only exceptions are
>> the Rockpro64 and PinePhone Pro for me.
>
> All Rockchips devices use 1.5m except a chromebook and the Puma, and
> this device.
>

Yes, I meant all the other non-rockchip boards I have. So I understood the
appeal of what Jarrah mentioned about using 115200 for everything.

Having said that, my vote would be to change the PinePhone Pro to 1.5 MB
given that it is what all the rockchip (but two) boards use in mainline.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

