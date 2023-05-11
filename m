Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF47B6FF4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjEKOuS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjEKOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:49:22 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4257011D99;
        Thu, 11 May 2023 07:47:39 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1px7Zq-004C7A-Eu; Thu, 11 May 2023 16:47:30 +0200
Received: from p5b13addc.dip0.t-ipconnect.de ([91.19.173.220] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1px7Zq-0013pG-7p; Thu, 11 May 2023 16:47:30 +0200
Message-ID: <5f5ac2ac5c6e8cd2034e17282eec00b4c88f23b6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ
 descriptors
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
Date:   Thu, 11 May 2023 16:47:29 +0200
In-Reply-To: <CAMuHMdXmtfCir4dt6CKe2YxDN53nNAcE=i5oyMkOsPavJ-p0Tw@mail.gmail.com>
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
         <CAMuHMdXmtfCir4dt6CKe2YxDN53nNAcE=i5oyMkOsPavJ-p0Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.220
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

On Thu, 2023-05-11 at 16:35 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Wed, May 10, 2023 at 6:36 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > The initialization function for the J-Core AIC aic_irq_of_init() is
> > currently missing the call to irq_alloc_descs() which allocates and
> > initializes all the IRQ descriptors. Add missing function call and
> > return the error code from irq_alloc_descs() in case the allocation
> > fails.
> > 
> > Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Thanks for your patch!
> 
> I am not an IRQ expert, so I'd like to leave the technical parts for
> e.g. Marc.  But I think you should add to the description that this
> is based on a patch by Rich.

Will do! Thanks for the suggestions! I read through the IRQ source code
and checked what other architectures do and I think the first parameter
should be "-1" not 0.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
