Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441935B37BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIIMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIIMXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:23:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E6E48EB0;
        Fri,  9 Sep 2022 05:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3533B822A8;
        Fri,  9 Sep 2022 12:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F001C433D7;
        Fri,  9 Sep 2022 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662726181;
        bh=f/MBk4DuV+ezF4qXmdCJCjmryA6nTjeI9XVb4sRPRn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fl65HRPASBnRey7QziwpTTh++x1s075YBaImqSA2XFii2ys0KOSOxu4LXRJFmue+1
         zTNQlcg2Lt35tZzXHX7tQ6aCugsDvKfnidzQTkiahJbbTuaH3KTyOQKDDquC6Ip2i0
         iCb0nhC/Jj5sFUJwMt9VGnBtVdgP1EQRzEtoh8HSutp930G7nb67pu5jUDyqjGA16I
         37jw3n60ubTVjXuRmLbu1hDiZr3QDo7rtNUjFPdvpY1nshUWOAwnNEcz9rgvQa4jg4
         a3gzW9x1+BxRdV4h67haa3Et9KQK0qoEXOjYc6YR64IoEYdMcVPgddxHnjmDlv8TZq
         wVLmEcCXIDehA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oWd2M-0001Xo-Nt; Fri, 09 Sep 2022 14:23:10 +0200
Date:   Fri, 9 Sep 2022 14:23:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Message-ID: <YxswLiOaHQ5ajeOi@hovoldconsulting.com>
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
 <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
 <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 01:16:23PM +0300, Ilpo Järvinen wrote:

> Also, I don't understand why you see it unreadable when the actual code is 
> out in the open in that macro. It's formatted much better than e.g. 
> read_poll_timeout() if you want an example of something that is hardly 
> readable ;-). I agree though there's a learning-curve, albeit small, that 
> it actually creates a function but that doesn't seem to me as big of an 
> obstacle you seem to think.

There's a huge difference between the proposed macro with its
I-lost-count-of-how-many arguments and levels of indirection and
something like wait_event() which take one condition and has a
descriptive name:

	wait_event(device->misc_wait, atomic_read(&device->ap_pending_cnt) == 0);

vs

	static DEFINE_UART_PORT_TX_HELPER_LIMITED(altera_jtaguart_do_tx_chars,
		true,
		writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
		({}));

In the former case, you just need to look at the code to understand what
is going on, very much unlike in the latter case.

Johan
