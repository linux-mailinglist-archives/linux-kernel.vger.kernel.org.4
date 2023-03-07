Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380B6AD921
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCGIUQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 03:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCGITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:19:30 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB48509B7;
        Tue,  7 Mar 2023 00:19:09 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pZSXF-001LdO-QQ; Tue, 07 Mar 2023 09:19:01 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pZSXF-000GYP-JQ; Tue, 07 Mar 2023 09:19:01 +0100
Message-ID: <c85990e892571ae5da7a9c4b0e86897ee34286a7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch: sh: remove references to config USB_OHCI_SH
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Mar 2023 09:19:00 +0100
In-Reply-To: <CAMuHMdV1eYWhDKwTAxC32Qp0CcxrWxgu=uRNTdu_G8K=gHS9Yw@mail.gmail.com>
References: <20230307075923.28821-1-lukas.bulwahn@gmail.com>
         <CAMuHMdV1eYWhDKwTAxC32Qp0CcxrWxgu=uRNTdu_G8K=gHS9Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.155.194
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Tue, 2023-03-07 at 09:16 +0100, Geert Uytterhoeven wrote:
> Hi Lukas,
> 
> On Tue, Mar 7, 2023 at 9:02 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") left some
> > references to the config USB_OHCI_SH in ./arch/sh/ around, expecting those
> > to be removed with the whole SH architecture deletion.
> > 
> > As that did not happen, do minor clean-up instead and remove the references
> > to the removed config USB_OHCI_SH instead.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -326,7 +326,6 @@ config CPU_SUBTYPE_SH7720
> >         select CPU_SH3
> >         select CPU_HAS_DSP
> >         select SYS_SUPPORTS_SH_CMT
> > -       select USB_OHCI_SH if USB_OHCI_HCD
> 
> Shouldn't this select USB_OHCI_HCD_PLATFORM instead, as the (now
> removed) Kconfig help text for USB_OHCI_SH used to say?
> 
>     +       select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> 
> I completely forgot I already made that comment before, cfr.
> https://lore.kernel.org/all/CAMuHMdVM3BpvVD3c4gp1OidnwF5zFd4MJecij7zWBnahzNaSNw@mail.gmail.com
> 
> The same is true for the three selects below.
> As USB is now broken, the proper solution will need
> Fixes: 4f6dfc2136fb2e8d ("usb: remove the dead USB_OHCI_SH option")

Thanks a lot for catching this!

@Lukas: Can you send a new patch with the suggested changes?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
