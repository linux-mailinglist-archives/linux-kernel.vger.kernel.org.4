Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1910646D83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLHKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiLHKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:48:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CD862DC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:43:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m18so2879630eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDOEuiDEB7Li4oZAHPN7SJ+nSHTURoPl6KCogSzGlew=;
        b=fT5kmKTsZ3pKIjr8WMNiUOQESNCk/KrBSYsFmJixtcEZpJwBsYHonx/AvHJcJK0EPX
         rXgPZQ4Z/HlEWNCloEgV0WxvFQwlxFmbI3IBK39uPW3qPxK3xuRF8CXwGNuEXv8Xv9cO
         Und1mkah+0nDzmwToyoVU6nsZgfQagWzsZ9BlOmQxJMKxu8J0ry/IfQTa5S0KXE8j7Pz
         77iO0T3UqWoIx1leuZUUg0lPY8PPd6qawlTAAqp5clE5a+mRiz2VKwifO98eMKXEsq7O
         NOr5WzL1rdIjZDwogoJiRCk/8zX8elaQ9rGdOtZwPBdVlcSIEk4NjzyeoTbGTQCSznb+
         olTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDOEuiDEB7Li4oZAHPN7SJ+nSHTURoPl6KCogSzGlew=;
        b=cF5ds8QYowOqmkuv66dJQK4ik2z70kvzmSrBAq30MJA8iFjzX5UzoxNjDytL2ECMvK
         dk32jrDJ2GUEiC736ViqUgb2APYHa3mJ8yN1TwBUByTTN31Dwbe5T7F5y9aUUHGIKl3o
         0Q3IERoTlhbyh4IcfuaOxyG0PT8Wr/vSw0c1TU0MXHvvD9E+xHR2jIKOW2ayXPCrG4o1
         t2Wz9xyzDN9dDVnFos4cC9SW5s5UccNPlDZAuEmQa1+rPWnsq4FLb9bQjvpiHxkJcQmr
         47WbsRMR/Z9+nTy5rMS08h226v3rxwnqx7nARSfncwUt4SLDKZHighc9V8bIFhkmBJPX
         wAEQ==
X-Gm-Message-State: ANoB5pl8DfTZfTTbgNEF4PCvEcbyWVpV0vEZDrKsZCJNQP6hV+548jyp
        eP6lRmEiXMYcPzIuStxp8Ptq4w==
X-Google-Smtp-Source: AA0mqf761CdGepVoMb96PmWL/KVR7qh7NCA3gG1AKFlXOaEEW5glEiv4ZpQonX1fH94HkmjFlwrUmQ==
X-Received: by 2002:a17:907:a710:b0:7ba:fd1f:524 with SMTP id vw16-20020a170907a71000b007bafd1f0524mr18812158ejc.361.1670496216049;
        Thu, 08 Dec 2022 02:43:36 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id i3-20020a05640200c300b00461cdda400esm3260511edu.4.2022.12.08.02.43.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:43:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <9eba7529-8879-fbba-4e17-f174ef401513@opensource.wdc.com>
Date:   Thu, 8 Dec 2022 11:43:34 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41604669-2D56-4524-8FA1-527FEAD06B29@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
 <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
 <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
 <518C279B-8896-470A-9D8C-974F3BB886DB@linaro.org>
 <9eba7529-8879-fbba-4e17-f174ef401513@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 7 dic 2022, alle ore 00:34, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
>=20

[...]

>> Just, let me avoid setting the fields bfqd->sector and
>> bfqd->nr_sectors for a case where we don't use them.
>=20
> Sure. But if you do not use them thanks to "if (num_actuators =3D=3D =
1)"
> optimizations, it would still not hurt to set these fields. That =
actually
> could be helpful for debugging.
>=20

Got it. I'm about to send a V9 that applies this last suggestion of =
yours.

Thanks,
Paolo

