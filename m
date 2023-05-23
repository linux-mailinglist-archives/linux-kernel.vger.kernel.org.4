Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3056C70D7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjEWIjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjEWIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:38:28 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E418D;
        Tue, 23 May 2023 01:37:01 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A250020008;
        Tue, 23 May 2023 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684831020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zevkAxEFUIWHgePsyHXq++lV+3/FgwN1EoqQjaNsGYw=;
        b=A+xGy2Alx3eEr4XwOFoj85MKrHUxnShJ7PbD5l+i5CxWsj9I3En/qPoytVHDuht3llcImN
        rNOoQAPOFwrZX3ZVSr4i4WQoq+Cqd60Aoj4c7twUjoNpidJhBgug/S1m5ap+gW+UC6UA5w
        zuFMseTy7m8VIHhAKrNLrkS/WWvtL3pniVafsqWL3WNGcTFpiQ6CHB7+u3bqQyvU+yb432
        J0qVwiDja6KpQ0SjyRoNpKUUWWytwhb79zAULgtd/wUeHkisw0gLrym5++rn1GL+mnDTe8
        rb3MPiy4U9J+HJ6O0LrNfXBw1+LeOGPRDS3XfAkz+TpcBrhi3BjqAUwQjrIEFw==
Date:   Tue, 23 May 2023 10:36:56 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] serial: cpm_uart: Fix a COMPILE_TEST dependency
Message-ID: <20230523103656.550c9585@bootlin.com>
In-Reply-To: <d65bb452-80ca-7644-c38c-1bc0566661f0@kernel.org>
References: <20230522082048.21216-1-herve.codina@bootlin.com>
        <20230522082048.21216-3-herve.codina@bootlin.com>
        <d65bb452-80ca-7644-c38c-1bc0566661f0@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 09:52:00 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 22. 05. 23, 10:20, Herve Codina wrote:
> > In a COMPILE_TEST configuration, the cpm_uart driver uses symbols from
> > the cpm_uart_cpm2.c file. This file is compiled only when CONFIG_CPM2 is
> > set.
> > 
> > Without this dependency, the linker fails with some missing symbols for
> > COMPILE_TEST configuration that needs SERIAL_CPM without enabling CPM2.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
> > Fixes: e3e7b13bffae ("serial: allow COMPILE_TEST for some drivers")
> > ---
> >   drivers/tty/serial/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 625358f44419..68a9d9db9144 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -769,7 +769,7 @@ config SERIAL_PMACZILOG_CONSOLE
> >   
> >   config SERIAL_CPM
> >   	tristate "CPM SCC/SMC serial port support"
> > -	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
> > +	depends on CPM2 || CPM1 || (PPC32 && CPM2 && COMPILE_TEST)  
> 
> Actually, does this makes sense? I mean, the last part after "||" is now 
> superfluous and doesn't help anything, right?

Indeed, I will remove all the (PPC32 && CPM2 && COMPILE_TEST) in the next
iteration.
I will also remove the '#elif defined(CONFIG_COMPILE_TEST)' case in the
cpm_uart.h file.

Best regards,
Hervé

> 
> >   	select SERIAL_CORE
> >   	help
> >   	  This driver supports the SCC and SMC serial ports on Motorola  
> 
