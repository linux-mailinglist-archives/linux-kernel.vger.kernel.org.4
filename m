Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2954B61DFB9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 00:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiKEXjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 19:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKEXjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 19:39:43 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039FC11812;
        Sat,  5 Nov 2022 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667691581; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQiKfRULmK1hj+zlGpiThAJN9Uxdpi3uc4dM1+9bipo=;
        b=iqSAaf0aowSzmeyVPxe2oKONAr15pthW+n6zNr12B1OYjg/FDoi+Pvne5AWc+6sEPRkIdC
        a0ZTs3440jYB1w1+uvsKiHBSTz11jPvpPc7nmRz5QGLcE+y4OybG/ghmNUMpe7EAhp4HBP
        GgoO42T5bxdjQDEF4QphI/w9VoVPCF4=
Date:   Sat, 05 Nov 2022 23:39:32 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RFC PATCH 0/2] Input: adc-joystick: add detachable devices
 support
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <W1FWKR.P26T1W42X3ND@crapouillou.net>
In-Reply-To: <20221031190159.1341027-1-lis8215@gmail.com>
References: <20221031190159.1341027-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siarhei,

Le lun. 31 oct. 2022 =E0 22:01:57 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =E9crit :
> For detachable or lock-able joysticks the ADC lanes might
> be biased to GND or AVDD when the joystick is detached/locked.
>=20
> One such kind of joystick is found in the Ritmix RZX-50 handheld.
> The joystick is non-detachable, although ADC lane biased to power
> supply when the "Hold" switch is activated.

But the RZX-50 has no joystick...
Or is the d-pad actually wired to the ADC instead of GPIOs?

> To avoid reporting old/broken measurements valid-range is introduced.
> When measured value is outside valid-range the driver reports
> safe center position for corresponding axis.

First of all, you already have a "valid range", it is called=20
"abs-range"; no need for a new one.

Then, the driver has no business doing events filtering. Notice that=20
when you activate the "hold" button and your joystick values go way=20
off-range, you still get input events in userspace: that's because the=20
kernel is not responsible for enforcing the deadzone, the userspace is.

In your case, you need to update your userspace applications/libraries=20
so that when the joystick values are way off-range, the assumed=20
position is the center.

Cheers,
-Paul


