Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3121B6552D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiLWQ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiLWQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:28:13 -0500
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E1F05FFF;
        Fri, 23 Dec 2022 08:28:11 -0800 (PST)
Received: from localhost.localdomain (unknown [10.81.81.211])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gw.red-soft.ru (Postfix) with ESMTPSA id E02CA3E1BC4;
        Fri, 23 Dec 2022 19:28:08 +0300 (MSK)
Date:   Fri, 23 Dec 2022 19:28:07 +0300
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Michael Ira Krufky <mkrufky@linuxtv.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lvc-project@linuxtesting.org
Subject: Re: [PATCH] [media] mxl111sf: Check return value in
 mxl111sf_config_mpeg_in
Message-ID: <Y6XXF6gffL9aHTuw@localhost.localdomain>
References: <20221222214607.39737-1-artem.chernyshev@red-soft.ru>
 <CAOcJUby8i=vRu5-cSe6iBKrnLG8ucmatpiPT=VaMS9etwHH_uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcJUby8i=vRu5-cSe6iBKrnLG8ucmatpiPT=VaMS9etwHH_uw@mail.gmail.com>
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 174378 [Dec 23 2022]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;red-soft.ru:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2022/12/23 14:48:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2022/12/23 12:54:00 #20700750
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Dec 23, 2022 at 07:28:47AM -0500, Michael Ira Krufky wrote:
> On Thu, Dec 22, 2022, 4:46 PM Artem Chernyshev <artem.chernyshev@red-soft.ru>
> wrote:
> 
> > Error check after mxl111sf_read_reg
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 4c66c9205c07 ("[media] dvb-usb: add ATSC support for the Hauppauge
> > WinTV-Aero-M")
> > Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> > ---
> >  drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
> > b/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
> > index 40b26712ba4c..ad1888514bd0 100644
> > --- a/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
> > +++ b/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
> > @@ -121,7 +121,8 @@ int mxl111sf_config_mpeg_in(struct mxl111sf_state
> > *state,
> >         mxl_fail(ret);
> >
> >         /* Configure MPEG Clock phase */
> > -       mxl111sf_read_reg(state, V6_MPEG_IN_CLK_INV_REG, &mode);
> > +       ret = mxl111sf_read_reg(state, V6_MPEG_IN_CLK_INV_REG, &mode);
> > +       mxl_fail(ret);
> >
> >         if (clock_phase == TSIF_NORMAL)
> >                 mode &= ~V6_INVERTED_CLK_PHASE;
> > --
> > 2.30.3
> >
> 
> Artem,
> 
> Thank you for this.  If I recall correctly, the read from that particular
> register often returns a failure despite the correct value being read into
> memory. This needs to be tested before being merged, and if my memory is
> correct about this we should add a comment about it. Unfortunately, I'm out
> of town at the moment, I won't be able to test this for some time. Can we
> hold off on this one for a bit? If you don't hear from me after a few
> weeks, please feel free to ping me again. Thanks.
> 
> Best,
> Michael Krufky
> 
> >

Thanks for reply. I'll be waiting for your decision

Best regards,
Artem
