Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242896D618F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjDDMsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjDDMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:48:28 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91A3586;
        Tue,  4 Apr 2023 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1680611806; bh=5FjolS6OmiyNi3Dzbu2WcgmbPn9JvTWmxSdnDWKiKWQ=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=ekYLNbm4eIMpAS/2QpV2eXW1eLcINLpi0sYHFXrqmJpHL9JDeStckypjFhusNmFjO
         dNaOyaUhPx5+HAEjMbueIreyWQd0chPLZtqnu2+pn0143cXUOJBiqKUo4HiG72zq1L
         +VS4wNkcANEH1vpPfgM82qM9M91Qb1ThqqEn5oYI=
Date:   Tue, 4 Apr 2023 14:36:46 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
Message-ID: <20230404123646.5iiznbhnyoama5pp@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3738011.44csPzL39Z@diego>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:51:11AM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
> > This baud rate is set for the device by mainline u-boot and is also what
> > is set in the Pinebook Pro Device Tree, which is a device similar to the
> > PinePhone Pro but with a different form factor.
> > 
> > Otherwise, the baud rate of the firmware and Linux don't match by default
> > and a 'console=ttyS2,1500000n8' kernel command line parameter is required
> > to have proper output for both.
> 
> The interesting question is always if this will break someone else's setup.
> I've never really understood the strange setting of 1.5MBps, but on the
> other hand it _is_ a reality on most boards.

Normal users of the phone probably run with UART console disabled, because
UART is muxed with audio jack output and to enable it they have to add
console=ttyS2 to the kernel command line and flip a physical switch inside
the phone.

Fortunately, not sepcifying stdout-path baud rate in the options part
of the string, will make the serial driver probe for the baud rate from
the previous boot stage and make the user happy by keeping whatever was
already set in the bootloader.

  https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_port.c#L3496

So we can make the kernel just keep the baudrate setup from the previous
boot stage by:

	stdout-path = "serial2";

regards,
	o.

> Personally I don't care that much either way, but would like a comment
> from the other people working on that device - if possible.
> 
> I guess if we don't hear anything, I'll apply it nevertheless at some point
> 
> 
> Heiko
> 
> 
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > 
> > I tried to instead get rid of the baud rate altogether, as suggested by
> > Peter Robinson. AFAIU that should just pick whatever bad rate has been
> > using by the early console.
> > 
> > But neither using 'stdout-path = "serial2" nor 'stdout-path = &uart2'
> > worked for me.
> > 
> > In both cases I didn't have any output unless setting a baud rate using
> > the 'console='param.
> > 
> >  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > index a0795a2b1cb1..6bbe65bd5bd4 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > @@ -26,7 +26,7 @@ aliases {
> >  	};
> >  
> >  	chosen {
> > -		stdout-path = "serial2:115200n8";
> > +		stdout-path = "serial2:1500000n8";
> >  	};
> >  
> >  	gpio-keys {
> > 
> > base-commit: 3adf89324a2b2a9dbc2c12d8895021e7e34e3346
> > 
> 
> 
> 
> 
