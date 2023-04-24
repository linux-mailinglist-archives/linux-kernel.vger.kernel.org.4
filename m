Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FB76ED510
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjDXTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:06:48 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9749B4C23;
        Mon, 24 Apr 2023 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aAn9rXMqpNAZs59f3LwTjTTgFucy7y+Rat1wzItlz5Q=; b=cRh4ul1IZkTyKWihk4scTzVRFa
        pY9ZyeJM5k1ytq7l8qnbplLDP/F5pQHXnZvbL2w7oL3kK9uHfvxYf8Jj4P07bufduJxPsDXS2wuXc
        W963PyoMAr7UoGQRBvHNK72GSyWIc/DFbI/+j4KsKaVeMyXFBuC0AusAa/thiiV0jrnNvLh71Lxso
        hmdIlqtBfBCH5WqkmoBX2hHLDfs5qB4ME6nc/fYoN/hUuEY2PaX8nF8T/SDV02221KcuoD9CFRtQD
        LopEWvlgnX7l9RP/xgyg0Nn8ZVRNLhuARM3YpWeu4qz7XxE/UmkgFsc/SUL5BKQBCd979BxMJRIf8
        UD2S9UZw==;
Received: from p200300ccff08b5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:b500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pr1WG-0003Sc-7E; Mon, 24 Apr 2023 21:06:36 +0200
Date:   Mon, 24 Apr 2023 21:06:34 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee@kernel.org>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <20230424210634.70c26688@aktux>
In-Reply-To: <20230424131740.GE50521@google.com>
References: <20230419111806.1100437-1-andreas@kemnade.info>
        <20230419111806.1100437-3-andreas@kemnade.info>
        <20230424131740.GE50521@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 14:17:40 +0100
Lee Jones <lee@kernel.org> wrote:

> On Wed, 19 Apr 2023, Andreas Kemnade wrote:
> 
> > The device provides 6 channels which can be individually
> > turned off and on but groups of two channels share a common brightness
> > register.
> > 
> > Limitation: The GPIO to enable the device is not used yet.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > ---
> >  drivers/leds/Kconfig          |  14 +++
> >  drivers/leds/Makefile         |   1 +
> >  drivers/leds/leds-bd2606mvv.c | 160 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 175 insertions(+)
> >  create mode 100644 drivers/leds/leds-bd2606mvv.c  
> 
> Applied, thanks
> 
contrary to the binding doc, it does not appear on
https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=for-leds-next

Any problems with applying it?

Regards,
Andreas
