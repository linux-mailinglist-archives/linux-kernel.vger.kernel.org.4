Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD486609442
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJWPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJWPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:16:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2416556C;
        Sun, 23 Oct 2022 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666538169; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76gz1YSbuUIA+tLdwL/4i5a5zfRt4Nv9mdTm/uPed3w=;
        b=UlzyMNfvxSOmsLFTbpmCgLzlm2t9lt6VDAnPrCvAKxKuPoUcNOKhtEwnaboUeHB4d5tTfe
        C9xIxNS1OEVeLBs8lNjsFdpeW0L+Zd1F04C8HQinUJl2Fl0S/RoInmia/68XJaTXapOIXb
        tinDxuX0iCncdtoF63UIOpSF9qTqA30=
Date:   Sun, 23 Oct 2022 16:15:58 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] serial: 8250/ingenic: Add support for the
 JZ4750/JZ4755
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <M2P7KR.MNWZYPK0OB5B@crapouillou.net>
In-Reply-To: <CAKNVLfbJaGd0t==AzxyT5Q7fVD7PwK75-S5dbb+G9GZUPpagZQ@mail.gmail.com>
References: <20221022165047.4020785-1-lis8215@gmail.com>
        <20221022165047.4020785-3-lis8215@gmail.com>
        <9W76KR.NVDSVG4IWZ3A3@crapouillou.net>
        <CAKNVLfZmUpFzKsdzY1e_mUTVsM-jnL65Fi6EXYcF80-oNV+DGQ@mail.gmail.com>
        <YE87KR.VC65A15U1PH41@crapouillou.net>
        <CAKNVLfbJaGd0t==AzxyT5Q7fVD7PwK75-S5dbb+G9GZUPpagZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 23 oct. 2022 =C3=A0 17:04:49 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D0=B2=D1=81, 23 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:16, Paul Cerc=
ueil=20
> <paul@crapouillou.net>:
>>  Do you have such hardware?
>=20
> No
>=20
>>  Don't add support for cases you can't test.
>=20
> It's just a side effect of that approach.
>=20
>>  For what we know - all JZ475x use a 24 MHz crystal and all JZ4760(B)
>>  use a 12 MHz crystal, until proven otherwise.
>=20
> Ouf course it just confirms the rule but I found one exception:=20
> JZ4750 & 12MHz
> Link:=20
> https://github.com/carlos-wong/uboot_jz4755/blob/master/include/configs/l=
ib4750.h

Then when this board is upstreamed it will declare a 12 MHz oscillator=20
in its DT, and the ingenic init code won't have to enable the /2=20
divider for that particular board.

> Regarding your proposal:
> In my opinion enabling the divisor unconditionally is a bad practice,
> as it's already enabled (or not) by the bootloader, with respect to=20
> the
> hardware capabilities.I think it's better to keep the driver as it is=20
> than
> adding such things.

Well, I disagree. Linux should not depend on whatever the bootloader=20
configures.

-Paul


