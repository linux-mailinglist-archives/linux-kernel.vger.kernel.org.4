Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DABC733F38
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346137AbjFQHcM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Jun 2023 03:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346145AbjFQHcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:32:10 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB3D297E;
        Sat, 17 Jun 2023 00:32:07 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qAQPe-003tCZ-W0; Sat, 17 Jun 2023 09:31:59 +0200
Received: from p57bd9486.dip0.t-ipconnect.de ([87.189.148.134] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qAQPe-002qqX-KS; Sat, 17 Jun 2023 09:31:58 +0200
Message-ID: <d5667e9675bf8be35b1a5414d443b8f371b1bd9e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in
 SH7709
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 17 Jun 2023 09:31:57 +0200
In-Reply-To: <8205bc2cb9f983914ff6920deed3f54893713ba0.camel@physik.fu-berlin.de>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
         <20230527164452.64797-4-contact@artur-rojek.eu>
         <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
         <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
         <CAMuHMdVFBo+KMNQ6gzh3rZrZ+_Wfg=UJ4XOW4Uqibnjm6T7CdA@mail.gmail.com>
         <8205bc2cb9f983914ff6920deed3f54893713ba0.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.134
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Thu, 2023-06-08 at 12:03 +0200, John Paul Adrian Glaubitz wrote:
> > > > That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
> > > > when configuring his kernel, thus breaking DMA  due to an incorrect
> > > > value of SH_DMAC_NR_MD_CH.
> > > > 
> > > > Unfortunately we cannot protect against that when using a single DMAC,
> > > > as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.
> > > > 
> > > > Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
> > > > to protect against a user overriding this value?
> > > 
> > > Isn't SH_DMAC_NR_MD_CH already hardwired to the SoC being used?
> > 
> > It depends on CONFIG_NR_ONCHIP_DMA_CHANNELS, while it
> > should be fixed based on the SoC.
> 
> I agree. However, I would be fine with merging this patch set first and fixing
> this particular issue in a follow-up series.

So, my suggestion is to take this series as-is for 6.5, then get the other issues
you mentioned fixed for 6.6. I think it's already a gain when these issues are
fixed and the kernel boots on the HP Journada 680 again.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
