Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC66D12B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjC3XAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjC3XAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54FDBE2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680217170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6OjiitjPwr2q3+VgtTu4P0B7q8Y0XJ2G6/rSSRxlds=;
        b=YT3+wtgaCO+FZD5dfbpA/ZxwktWNdnriGZTMm7ALPQHDl9ekdD9kZW2MbMCZW+R2+fbsOW
        eCuupExqLmy3++LYPdquPyKAfnZ7lyX1ThUTuDMuARORCpzF77KchKgqmQspRity9KvZX0
        Fc7W3hVv+n5/0qo8r0TytCj6e3DYyKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-eT7sWWoROWSvlBhUifVycQ-1; Thu, 30 Mar 2023 18:59:28 -0400
X-MC-Unique: eT7sWWoROWSvlBhUifVycQ-1
Received: by mail-wm1-f71.google.com with SMTP id bg33-20020a05600c3ca100b003ef6d684105so6788288wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680217166;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6OjiitjPwr2q3+VgtTu4P0B7q8Y0XJ2G6/rSSRxlds=;
        b=G73/4LhrTvUXM6fOY3mmT1DSdAx3nBNf3AeLBASj8TerXNiKzSqwr83JSM7mVILt5s
         tM20h4PVbKEFXdPNUUHRoGkdlNbSQQMPL7jox97lXtb+0AlLn0Qgn2zbrUwiLb44mFui
         YeISnesihTVArXpGDNyJZXz+68O6y7U7EZ9dJ+N9uDCnEKOnT9bMIAGOxCT08Hm1m6h9
         KWMxOtH837u3+yfZWT/0px83RPvJVtzMy2cYQupeuEn7nnxhbgYAoDv6ArQ6ZKfJwc9l
         0oJl2dcx5dgmkxNpwJ02QiN4FVEtZW2mi9Y/2O5SoXZ35MtAoLTx27/lJAKamjwtlKlr
         Jg0A==
X-Gm-Message-State: AAQBX9e4kzY81zS/EQR+z01GlYj18Rl3laVkDY5qSNAtA+mT19tAwhC+
        6AWhPlcSuxbzQxANz01c7hEsIT93/g1Ubx8nRJg56xxBWkTCG6sGIyHwxIbuObWYe6m20r67idB
        mI0Cej6AGDQIrkk37bf2Ahz+MrNrwsW4F
X-Received: by 2002:a1c:7714:0:b0:3ee:1084:aa79 with SMTP id t20-20020a1c7714000000b003ee1084aa79mr4645663wmi.20.1680217166718;
        Thu, 30 Mar 2023 15:59:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yecu73nIBzSwX6n9VC0rj75gvI4cfYDMCQVY5s6zogWVJi/S5ieqmyC8RCCI2B/05FAE9b9w==
X-Received: by 2002:a1c:7714:0:b0:3ee:1084:aa79 with SMTP id t20-20020a1c7714000000b003ee1084aa79mr4645652wmi.20.1680217166385;
        Thu, 30 Mar 2023 15:59:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003ee8ab8d6cfsm7846029wmn.21.2023.03.30.15.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:59:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <eballetbo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lin Huang <hl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, zain wang <wzz@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove non-existing pwm-delay-us
 DT property
In-Reply-To: <CA+ASDXOtyBgr0o+bhjOScjs2h3oUKdouoAi4m+Z=R=Bho=iRFA@mail.gmail.com>
References: <20230330220251.2388494-1-javierm@redhat.com>
 <CA+ASDXOtyBgr0o+bhjOScjs2h3oUKdouoAi4m+Z=R=Bho=iRFA@mail.gmail.com>
Date:   Fri, 31 Mar 2023 00:59:24 +0200
Message-ID: <87355lg81f.fsf@minerva.mail-host-address-is-not-set>
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

Brian Norris <briannorris@chromium.org> writes:

Hello Brian,

> On Thu, Mar 30, 2023 at 3:03=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> There is no neither a driver that parses this nor a DT binding schema th=
at

Ups, I noticed now that there's an unnecessary "no" and it should be instea=
d:

"There is neither a driver..."

>> documents it so let's remove it from the DTS files that make use of this.
>>
>> The properties that exist are post-pwm-on-delay-ms and pwm-off-delay-ms,
>> defined in the pwm-backlight DT binding. So probably what these DTS want
>> is something like following:
>>
>>         backlight: backlight {
>>                 compatible =3D "pwm-backlight";
>>                 enable-gpios =3D <&gpio4 21 GPIO_ACTIVE_HIGH>;
>>                 pinctrl-names =3D "default";
>>                 pinctrl-0 =3D <&bl_en>;
>>                 pwms =3D <&pwm1 0 1000000 0>;
>>                 post-pwm-on-delay-ms =3D <10>;
>>                 pwm-off-delay-ms =3D <10>;
>>         };
>>
>> But that should be follow-up change if that is the case. Because otherwi=
se
>> it would be change in behaviour, since currently pwm-delay-us is a no-op.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> pwm-delay-us seems to have been a downstream-only ("CHROMIUM", if
> you're familiar with ChromiumOS kernel parlance) change that seems
> like a combination of the two now-upstream properties you point at. I

Yes, that's what I found too. So it seems that this was an oversight when
the DTS for these Chromebooks were upstreamed.

> looked through the first use of pwm-delay-us on RK3399 Gru systems,
> and I can't find a spec reference that said it was needed; perhaps it
> was needless copy/paste imitation?
>
> So, simple deletion is probably fine:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
>

Thanks for the confirmation and review!

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

