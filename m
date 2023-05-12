Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274247002EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjELIoC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:44:01 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758FC4EC2;
        Fri, 12 May 2023 01:44:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pxONW-000HaH-0B; Fri, 12 May 2023 10:43:54 +0200
Received: from p5b13afa1.dip0.t-ipconnect.de ([91.19.175.161] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pxONV-000Czl-Oz; Fri, 12 May 2023 10:43:53 +0200
Message-ID: <6be49109f6ee00da175f56698332932f27779389.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: dma: Correct the number of DMA channels in
 SH7709
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 May 2023 10:43:52 +0200
In-Reply-To: <CAMuHMdVD9kDqhaZsVO8sLMAxB0NX524y8e7m-3n=Bz+PALJJ7Q@mail.gmail.com>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-3-contact@artur-rojek.eu>
         <CAMuHMdV4hDULr43_4Z=Q9EHEvbzGStMRY45d4Ja1ixqSvMd2Cg@mail.gmail.com>
         <079f78025bf0af7808951ff0b56393cff99d957b.camel@physik.fu-berlin.de>
         <CAMuHMdVD9kDqhaZsVO8sLMAxB0NX524y8e7m-3n=Bz+PALJJ7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.175.161
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-12 at 09:34 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Thu, May 11, 2023 at 10:20 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Mon, 2023-05-08 at 12:55 +0200, Geert Uytterhoeven wrote:
> > > On Sat, May 6, 2023 at 4:22 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> > > > According to the PM, the DMAC found in SH7709 features only 4 channels.
> > > > 
> > > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> > > 
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > I assume we can't find a commit for the Fixes tag? Looking at the "git blame"
> > for the Kconfig file, it seems the corresponding lines were changed before
> > the source tree was imported into git in 1da177e4c3f4.
> 
> I don't think Fixes has much relevance, as the issue is present in all
> LTS kernel versions that are still maintained.
> The stable machinery AI will just pick it up, based on the word "correct" in
> the description.

Ah, I didn't know about that. Thanks for the clarification.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
