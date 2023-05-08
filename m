Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C01F6FACDE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjEHL2p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjEHL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:28:18 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43F53CD84;
        Mon,  8 May 2023 04:28:04 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pvz25-003pxx-VQ; Mon, 08 May 2023 13:27:57 +0200
Received: from p57bd9c27.dip0.t-ipconnect.de ([87.189.156.39] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pvz25-0032kt-OJ; Mon, 08 May 2023 13:27:57 +0200
Message-ID: <3687ad9134f6869a479b94f821f92aefd41bd449.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 May 2023 13:27:57 +0200
In-Reply-To: <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-2-contact@artur-rojek.eu>
         <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
         <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
         <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.156.39
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

On Mon, 2023-05-08 at 13:20 +0200, Geert Uytterhoeven wrote:
> Looks like this is still broken on e.g. SH7751R, which has 8 channels,
> both handled by a single DMAOR register at offset 0x40...
> 
> While e.g. dma_base_addr() seems to have some provision for this
> (cfr. the "chan >= 9" (not "8") check), dma_find_base() will fail, as
> arch/sh/include/cpu-sh4/cpu/dma.h defines SH_DMAC_BASE1.
> Anyway, that's not new, so I have no objection to your patch.

Was SH7751R broken by 7f47c7189b3e8f19 as well?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
