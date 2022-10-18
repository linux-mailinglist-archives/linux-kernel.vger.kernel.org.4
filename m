Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5C60317D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJRRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJRRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:20:02 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534A564E1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:19:57 -0700 (PDT)
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 6E4992006CA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:19:54 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D2A108062D; Tue, 18 Oct 2022 19:10:06 +0200 (CEST)
Date:   Tue, 18 Oct 2022 19:10:06 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org
Subject: [RFC] PCMCIA socket and device drivers - status and way forward
Message-ID: <Y07d7rMvd5++85BJ@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCMCIA -- an astonishing 16-bit technology -- is clearly no longer of high
relevance. Yet it is, as of today, quite well supported in the Linux kernel,
and some recent activity shows that PCMCIA cards are still in use
(in particular by 'hobbyists'). For instance, in 2021, the serial_cs driver
got a bugfix indicative of active use of that driver (11b1d881a90fc), in
2020, the pata_pcmcia driver gained support for another CF card
(73e4eab0a8da), and in 2019, a new PCMCIA SCSI device driver (fdomain_cs.c)
got added.

However, since 2018, the PCMCIA core ( drivers/pcmcia/ ) is in 'odd fixes'
maintenance mode; various devices drivers haven't seen a real update in
ages. Therefore, I'd like to get feedback on how to proceed with PCMCIA
support in the future, with basically three options on the table for v6.2 or
v6.3:

	(a) proceed 'as is': keep most socket and card drivers, and
	    continue in 'odd fixes' mode.

	(b) keep socket and card drivers whenever there are indications
	    that such devices are still in use; remove likely unused socket
	    and card drivers in the next releases. Below is a list of PCMCIA
	    socket and card drivers with a few random notes on recent
	    activity (if any). The drivers marked with '[-]' are candidates
	    for removal. For each driver, I will send out individual RFCs
	    and Cc all relevant parties; this message is about the 'big
	    picture' instead.

	(c) remove PCMCIA support altogether.

Personally, I have not really used PCMCIA cards regularly in ages -- yet I
still own one device with PCMCIA support, and therefore can continue with
the 'odd fixes' mode for the time being. At present (and pending your
feedback!), I prefer option 'b' to option 'a', as it's unclear whether a
number of drivers (still) work. Moreover, this allows to focus maintainence
activities on the remaining drivers.

What is your opinion on this question? Do you still use PCMCIA cards - in
particular, devices which are marked with '[-]'? If so, please let me know!
And what do the maintainers of affected architectures (and of other, related
subsystems, such as bluetooth, networking, and SCSI) think?

Thanks,
	Dominik


socket drivers
**************
[-] PCMCIA_BCM63XX - bcm63xx_pcmcia.c bcm63xx_pcmcia.h : no specific activity since driver was added in 2009
[+] PCMCIA_ALCHEMY_DEVBOARD - db1xxx_ss.c : improvement in 2017
[-] ELECTRA_CF - electra_cf.c : no specific activity since driver was added in 2007
[-] I82092 - i82092.c i82092aa.h : bugfix in 2010
[-] I82365 - i82365.c i82365.h : some activity in 2009 (?)
[+] PCMCIA_MAX1600 - max1600.c max1600.h : added in 2018
[-] OMAP_CF - omap_cf.c : some activity in 2007
[-] PD6729 - pd6729.c pd6729.h : bugfix in 2010
[+] PCMCIA_PXA2XX - pxa2xx_base.c pxa2xx_base.h pxa2xx_mainstone.c pxa2xx_sharpsl.c : bugfix in 2016
[+] SA1100 - sa1100_generic.c sa1100_generic.h pxa2xx_sharpsl.c sa1100_h3600.c sa1100_simpad.c : activity in 2016
[+] SA1111 - sa1111_generic.c sa1111_generic.h sa1111_jornada720.c sa1111_lubbock.c sa1111_neponset.c sa1111_badge4.c : activity in 2018
[-] TCIC - tcic.c tcic.h : no specific activity since Linux-2.6.12-rc2
[-] PCMCIA_XXS1500 - xxs1500_ss.c : bugfix in 2010
[+] YENTA -  yenta_socket.c yenta_socket.h : required for 32-bit CARDBUS

device drivers
**************
[+] drivers/ata/pata_pcmcia.c					in-use patch in 2020
[+] drivers/bluetooth/bluecard_cs.c				in-use patch in 2017
[-] drivers/bluetooth/bt3c_cs.c					some activity in 2006
[-] drivers/bluetooth/dtl1_cs.c					some activity in 2006
[-] drivers/char/pcmcia/cm4000_cs.c				see https://lore.kernel.org/lkml/f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com/
[-] drivers/char/pcmcia/cm4040_cs.c				see https://lore.kernel.org/lkml/f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com/
[+] drivers/char/pcmcia/scr24x_cs.c				added in 2016
[-] drivers/char/pcmcia/synclink_cs.c				see https://lore.kernel.org/lkml/f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com/
[+] drivers/comedi/comedi_pcmcia.c				moved out of staging in 2021
[+] drivers/comedi/drivers/cb_das16_cs.c			moved out of staging in 2021
[+] drivers/comedi/drivers/das08_cs.c				moved out of staging in 2021
[+] drivers/comedi/drivers/ni_daq_700.c				moved out of staging in 2021
[+] drivers/comedi/drivers/ni_daq_dio24.c			moved out of staging in 2021
[+] drivers/comedi/drivers/ni_labpc_cs.c			moved out of staging in 2021
[+] drivers/comedi/drivers/ni_mio_cs.c				moved out of staging in 2021
[+] drivers/comedi/drivers/quatech_daqp_cs.c			moved out of staging in 2021
[+] drivers/mmc/host/sdricoh_cs.c				some activity in 2020
[+] drivers/mtd/maps/pcmciamtd.c
[+] drivers/net/arcnet/com20020_cs.c				continuous cleanup activity
[+] drivers/net/can/sja1000/ems_pcmcia.c			bugfix in 2021
[+] drivers/net/can/sja1000/peak_pcmcia.c			bugfix in 2019
[+] drivers/net/can/softing/softing_cs.c			bugfix in 2021
[+] drivers/net/ethernet/3com/3c574_cs.c			bugfix in 2013
[-] drivers/net/ethernet/3com/3c589_cs.c			no specific activity since 2011
[+] drivers/net/ethernet/8390/apne.c				some activity in 2021
[-] drivers/net/ethernet/8390/axnet_cs.c			no specific activity since 2011
[+] drivers/net/ethernet/8390/pcnet_cs.c			bugfix in 2019
[+] drivers/net/ethernet/amd/nmclan_cs.c			some activity in 2014/2015
[-] drivers/net/ethernet/fujitsu/fmvj18x_cs.c			no specific activity since 2011
[-] drivers/net/ethernet/smsc/smc91c92_cs.c			no specific activity since 2011
[-] drivers/net/ethernet/xircom/xirc2ps_cs.c			no specific activity since 2011
[-] drivers/net/wireless/atmel/atmel_cs.c			no specific activity since tree reorganization 2015
[-] drivers/net/wireless/cisco/airo_cs.c			no specific activity since tree reorganization 2015
[-] drivers/net/wireless/intersil/hostap/hostap_cs.c		no specific activity since tree reorganization 2015
[-] drivers/net/wireless/intersil/orinoco/orinoco_cs.c		no specific activity since tree reorganization 2015
[-] drivers/net/wireless/intersil/orinoco/spectrum_cs.c		no specific activity since tree reorganization 2015
[-] drivers/net/wireless/marvell/libertas/if_cs.c		no specific activity since tree reorganization 2015
[+] drivers/net/wireless/ray_cs.c				some activity in 2022
[+] drivers/net/wireless/wl3501_cs.c				bugfix in 2021
[-] drivers/parport/parport_cs.c				no specific activity since Linux-2.6.12-rc2
[-] drivers/scsi/pcmcia/aha152x_stub.c				bugfix in 2009
[+] drivers/scsi/pcmcia/fdomain_cs.c				added in 2019
[+] drivers/scsi/pcmcia/nsp_cs.c				bugfix in 2021
[-] drivers/scsi/pcmcia/qlogic_stub.c				no specific activity since Linux-2.6.12-rc2
[+] drivers/scsi/pcmcia/sym53c500_cs.c				activity in 2021
[+] drivers/ssb/bridge_pcmcia_80211.c | drivers/ssb/pcmcia.c	some activity in 2015
[+] drivers/tty/ipwireless/main.c				some activity in 2021
[+] drivers/tty/serial/8250/serial_cs.c				in-use patch in 2021
[-] drivers/usb/host/sl811_cs.c					added in 2005
[-] sound/pcmcia/pdaudiocf/pdaudiocf.c				some activity in 2006
[-] sound/pcmcia/vx/vxpocket.c					some activity in 2006
