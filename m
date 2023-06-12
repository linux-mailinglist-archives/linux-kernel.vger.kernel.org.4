Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0936972C636
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjFLNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFLNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:40:46 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73552F1;
        Mon, 12 Jun 2023 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kNf+uzMQZD8+1AoV3+R+vFlgRuzS6yncC97/lo8/oiU=; b=gKeT4CrJeiH7MTC978DlfTZAkm
        DZMNaBWXy0r13VRlEiuKzB44TJ5T0minvCVBADSxCuje8CddpLk3oiD9Ong3lVyEUAStuNEpjRAzw
        s0votYcbwFuNzffSSc42zbb9CSGZtuZhhF6DUr5A5ApXBQFZyRcca7ISjMBQgYR2SX1w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:58460 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q8hmY-0003Gh-M9; Mon, 12 Jun 2023 09:40:31 -0400
Date:   Mon, 12 Jun 2023 09:40:29 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Lech Perczak <lech.perczak@camlingroup.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        jesse.sung@canonical.com, isaac.true@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230612094029.ca1c993a7094c6e6e72254d3@hugovil.com>
In-Reply-To: <c76607ce-c75e-760e-9920-abf197bb0a88@camlingroup.com>
References: <20230607140525.833982-1-hugo@hugovil.com>
        <c76607ce-c75e-760e-9920-abf197bb0a88@camlingroup.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v8 00/10] serial: sc16is7xx: fix GPIO regression and
 rs485 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 14:10:20 +0200
Lech Perczak <lech.perczak@camlingroup.com> wrote:

> W dniu 7.06.2023 o=A016:05, Hugo Villeneuve pisze:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Hello,
> > this patch series mainly fixes a GPIO regression and improve RS485 flag=
s and
> > properties detection from DT.
> >
> > It now also includes various small fixes and improvements that were pre=
viously
> > sent as separate patches, but that made testing everything difficult.
> >
> > Patch 1 fixes an issue with init of first port during probing.
> >
> > Patch 2 fixes an issue when debugging IOcontrol register, but it is also
> > necessary for patch "fix regression with GPIO configuration" to work.
> >
> > Patch 3 fixes an incorrect label in sc16is7xx_probe() cleanup code.
> >
> > Patch 4 is a refactor of GPIO registration code in preparation for patc=
h 5.
> >
> > Patches 5 and 6 fix a GPIO regression by (re)allowing to choose GPIO fu=
nction
> > for GPIO pins shared with modem status lines.
> >
> > Patch 7 fixes a bug with the output value when first setting the GPIO d=
irection.
> >
> > Patch 8 allows to read common rs485 device-tree flags and properties.
> >
> > Patch 9 introduces a delay after a reset operation to respect datasheet
> > timing recommandations.
> >
> > Patch 10 improves comments about chip variants.
> >
> > I have tested the changes on a custom board with two SC16IS752 DUART us=
ing a
> > Variscite IMX8MN NANO SOM.
> >
> > Thank you.
> >
> > Link: [v1] https://lkml.org/lkml/2023/5/17/967 <https://lkml.org/lkml/2=
023/5/17/967>
> > [v1] https://lkml.org/lkml/2023/5/17/777 <https://lkml.org/lkml/2023/5/=
17/777>
> > [v1] https://lkml.org/lkml/2023/5/17/780 <https://lkml.org/lkml/2023/5/=
17/780>
> > [v1] https://lkml.org/lkml/2023/5/17/785 <https://lkml.org/lkml/2023/5/=
17/785>
> > [v1] https://lkml.org/lkml/2023/5/17/1311 <https://lkml.org/lkml/2023/5=
/17/1311>
> > [v2] https://lkml.org/lkml/2023/5/18/516 <https://lkml.org/lkml/2023/5/=
18/516>
> > [v3] https://lkml.org/lkml/2023/5/25/7 <https://lkml.org/lkml/2023/5/25=
/7>
> > [v4] https://lkml.org/lkml/2023/5/29/656 <https://lkml.org/lkml/2023/5/=
29/656>
> > [v5] https://lkml.org/lkml/2023/6/1/1046 <https://lkml.org/lkml/2023/6/=
1/1046>
> > [v6] https://lkml.org/lkml/2023/6/1/1328 <https://lkml.org/lkml/2023/6/=
1/1328>
> > [v7] https://lkml.org/lkml/2023/6/2/861 <https://lkml.org/lkml/2023/6/2=
/861>
> >
> > Changes for V3:
> > - Integrated all patches into single serie to facilitate debugging and =
tests.
> > - Reduce number of exported GPIOs depending on new property
> > nxp,modem-control-line-ports
> > - Added additional example in DT bindings
> >
> > Changes for V4:
> > - Increase reset post delay to relax scheduler.
> > - Put comments patches at the end.
> > - Remove Fixes tag for patch "mark IOCONTROL register as volatile".
> > - Improve commit messages after reviews.
> > - Fix coding style issues after reviews.
> > - Change GPIO registration to always register the maximum number of GPI=
Os
> > supported by the chip, but maks-out GPIOs declared as modem control lin=
es.
> > - Add patch to refactor GPIO registration.
> > - Remove patch "serial: sc16is7xx: fix syntax error in comments".
> > - Remove patch "add dump registers function"
> >
> > Changes for V5:
> > - Change patch order to facilitate stable backport(s).
> > - Change duplicate device addresses in DT binding examples.
> > - Use GENMASK for bit masks.
> > - Replace of_property_for_each_u32() with device_property_read_u32_array
> > - Add "Cc: stable..." tags
> >
> > Changes for V6:
> > - Fix compilation bug introduced by patch 3
> >
> > Changes for V7:
> > - Minor changes and coding style fixes after review for
> > patch 5 "fix regression with GPIO configuration".
> >
> > Changes for V8:
> > - Move mctrl_mask to "struct sc16is7xx_port" to avoid compiler warning =
when
> > CONFIG_GPIOLIB is undefined.
> > - Add "struct device" member to "struct sc16is7xx_port", in order to av=
oid
> > passing a raw "struct device" to called functions from sc16is7xx_probe(=
).
> > - Add new patch "serial: sc16is7xx: remove obsolete out_thread label"
> >
> > Hugo Villeneuve (10):
> > serial: sc16is7xx: fix broken port 0 uart init
> > serial: sc16is7xx: mark IOCONTROL register as volatile
> > serial: sc16is7xx: remove obsolete out_thread label
> > serial: sc16is7xx: refactor GPIO controller registration
> > dt-bindings: sc16is7xx: Add property to change GPIO function
> > serial: sc16is7xx: fix regression with GPIO configuration
> > serial: sc16is7xx: fix bug when first setting GPIO direction
> > serial: sc16is7xx: add call to get rs485 DT flags and properties
> > serial: sc16is7xx: add post reset delay
> > serial: sc16is7xx: improve comments about variants
> >
> > .../bindings/serial/nxp,sc16is7xx.txt | 46 +++++
> > drivers/tty/serial/sc16is7xx.c | 177 +++++++++++++-----
> > 2 files changed, 181 insertions(+), 42 deletions(-)
> >
> >
> > base-commit: a4d7d701121981e3c3fe69ade376fe9f26324161
> > --=20
> > 2.30.2
> >
> Hello Hugo,
>=20
> I had a chance to retest and re-review everything, including setting stat=
e at direction change.
> So if the pending changes to v9 are only the conversion of dt-bindings to=
 YAML and fixups to them, then:
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>

Hi Lech,
thank you for testing this again.

By the way, conversion of dt-bindings to YAML and fixups to them will
be done in a new serie, after we finish/close this one.

If all goes well, I do not intend to publish a v9, depending on feedback
from Andy and Greg.

Hugo.


> Pozdrawiam/With kind regards,
> Lech Perczak
>=20
> Sr. Software Engineer
> Camlin Technologies Poland Limited Sp. z o.o.
> Strzegomska 54,
> 53-611 Wroclaw
> Tel:     (+48) 71 75 000 16
> Email:   lech.perczak@camlingroup.com
> Website: http://www.camlingroup.com
>=20
>=20
