Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046B70D8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjEWJ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjEWJ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:27:36 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E2133;
        Tue, 23 May 2023 02:27:32 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CBD502000C;
        Tue, 23 May 2023 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684834051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWmP+K0uuA6jsYPFxeIuaz/mxhobE31RozhJ+QuYoSM=;
        b=MLkNf5XJX5xupRjTys0zCJsfk4CyCnGchIZJhXDIN9UveOQS+bjXcKHkw0FkgFdzI/2Fcu
        U1v6aa8rCqWKAdykDjVKmeMCkOBRwcNNdrPyl2jsqrZvwV63jvo0yxbigG0eegZVxeHZEF
        aJ4r8+RfJ81gjc5Zt5j4vUeS+NnZ4GIzco1gFar9fJtORIe4dhqldqKGdGmjORPlhesl+l
        lIJpKxxhXPulS3qCMUJQKquSUY3UVeaWRQHidxrESNYqFSmUsBxfH/iQbVSt4ewKQchVlC
        3m3KcKuZbhGtlmz3IVO5hHXkbQcIWw+HN+ftUwgW8Y6ImTwI2/Gao9GrwgSFTA==
Date:   Tue, 23 May 2023 11:27:28 +0200
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
Subject: Re: [PATCH v2 2/2] serial: cpm_uart: Fix a COMPILE_TEST dependency
Message-ID: <20230523112728.00dd5268@bootlin.com>
In-Reply-To: <012b7c3d-1411-e5e1-662a-33369bfca610@kernel.org>
References: <20230523085902.75837-1-herve.codina@bootlin.com>
        <20230523085902.75837-3-herve.codina@bootlin.com>
        <012b7c3d-1411-e5e1-662a-33369bfca610@kernel.org>
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

On Tue, 23 May 2023 11:13:02 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 23. 05. 23, 10:59, Herve Codina wrote:
> > In a COMPILE_TEST configuration, the cpm_uart driver uses symbols from
> > the cpm_uart_cpm2.c file. This file is compiled only when CONFIG_CPM2 is
> > set.
> > 
> > Without this dependency, the linker fails with some missing symbols for
> > COMPILE_TEST configuration that needs SERIAL_CPM without enabling CPM2.
> > 
> > This lead to:
> >    depends on CPM2 || CPM1 || (PPC32 && CPM2 && COMPILE_TEST)
> > 
> > This dependency does not make sense anymore and can be simplified
> > removing all the COMPILE_TEST part.  
> 
> Then it's the same as my revert:
> https://lore.kernel.org/all/20230518055620.29957-1-jirislaby@kernel.org/
> 
> :D
> 
> But nevermind.

Sorry, I didn't look at your revert.

Do you want a new iteration adding (same as your revert) ?
  Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
  Reported-by: Randy Dunlap <rdunlap@infradead.org>
  Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Best regards,
Hervé

> 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
> > Fixes: e3e7b13bffae ("serial: allow COMPILE_TEST for some drivers")
> > ---
> >   drivers/tty/serial/Kconfig             | 2 +-
> >   drivers/tty/serial/cpm_uart/cpm_uart.h | 2 --
> >   2 files changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 625358f44419..de092bc1289e 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -769,7 +769,7 @@ config SERIAL_PMACZILOG_CONSOLE
> >   
> >   config SERIAL_CPM
> >   	tristate "CPM SCC/SMC serial port support"
> > -	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
> > +	depends on CPM2 || CPM1
> >   	select SERIAL_CORE
> >   	help
> >   	  This driver supports the SCC and SMC serial ports on Motorola
> > diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
> > index 0577618e78c0..46c03ed71c31 100644
> > --- a/drivers/tty/serial/cpm_uart/cpm_uart.h
> > +++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
> > @@ -19,8 +19,6 @@ struct gpio_desc;
> >   #include "cpm_uart_cpm2.h"
> >   #elif defined(CONFIG_CPM1)
> >   #include "cpm_uart_cpm1.h"
> > -#elif defined(CONFIG_COMPILE_TEST)
> > -#include "cpm_uart_cpm2.h"
> >   #endif
> >   
> >   #define SERIAL_CPM_MAJOR	204  
> 

