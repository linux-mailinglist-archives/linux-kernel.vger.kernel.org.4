Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661307489DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGERJL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGERJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:09:09 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC1F198A;
        Wed,  5 Jul 2023 10:09:05 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qH5zv-003HyG-2X; Wed, 05 Jul 2023 19:08:59 +0200
Received: from p5b13aeb4.dip0.t-ipconnect.de ([91.19.174.180] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qH5zu-000XZI-Nl; Wed, 05 Jul 2023 19:08:59 +0200
Message-ID: <a62f53c1e643f94f3f047c112ffdf14545191d88.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/3] SuperH DMAC fixes
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Jul 2023 19:08:57 +0200
In-Reply-To: <20230527164452.64797-1-contact@artur-rojek.eu>
References: <20230527164452.64797-1-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.174.180
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-27 at 18:44 +0200, Artur Rojek wrote:
> Hi all,
> 
> This is v2 of the DMAC fixes.
> 
> Patch [1/3] now also addresses varying numbers of DMAC modules and
> channels.
> 
> Patch [2/3] removes SH_DMAC_BASE1 for SH4 family. To my knowledge, none
> of these SoCs feature two DMAC modules.
> 
> Patch [3/3] now also sorts all the targets and the description stays
> within 80 characters per line.
> 
> Tested on Jornada 680 (SH7709 compatible).
> 
> I went ahead and verified the above changes against datasheets of all
> the SoCs that are currently supported. Only SoCs found in defconfigs
> which enable CONFIG_SH_DMA/CONFIG_SH_DMA_API have been surveyed.
> 
> ---------+--------+--------+--------------+------------------+----------
>  SoC     | Family | Refs.  | DMAC modules | Chans per module | Notes  
> ---------+--------+--------+--------------+------------------+----------
>  SH7724  | SH4A   | [1]    | 2            | 6                |
>  SH7780  | SH4A   | [2]    | 2            | 6                |
>  SH7786  | SH4A   | [3]    | 1 (+ 1)      | 6 (+ 4)          | #1
>  SH7091  | SH4    | [4][5] | 1            | 4                | #2
>  SH7751R | SH4    | [6]    | 1            | 8                |
>  SH7760  | SH4    | [7]    | 1            | 8                |
>  SH4-202 | SH4    | n/a    | ?            | ?                | #3
>  SH7709  | SH3    | [8]    | 1            | 4                |
>  SH7720  | SH3    | [9]    | 1            | 6                |
> ---------+--------+--------+--------------+------------------+----------
> 
> Note #1:
> Technically, SH7786 features 2 DMAC modules, for a total of 10 channels.
> However, only DMAC0 (6 channels) is hw register compatible with the
> existing dma-sh driver.
> 
> Note #2:
> This SoC, used in SEGA Dreamcast, has no publicly available datasheet.
> Apparently it's an SH7750 [5] derivative. Number of modules/channels
> has been cross-referenced with the KallistiOS project's source code [4].
> 
> Note #3:
> No publicly available datasheet for this SoC. Apparently this CPU is
> used in an FPGA-based board [10], so perhaps the DMAC properties are
> synthesized in FPGA bitstream? As this is SH4, it could potentially
> impact patch [2/3].
> 
> [1] https://www.renesas.com/us/en/document/mat/sh7724-users-manual-hardware p. 537
> [2] https://www.renesas.com/us/en/document/mah/sh7780-hardware-manual p. 609
> [3] https://www.renesas.com/us/en/document/mah/sh7786-group-users-manual-hardware p. 1081
> [4] https://github.com/KallistiOS/KallistiOS/blob/ebf8d528cd8d1909150f60bef98e1a68318cbb95/kernel/arch/dreamcast/include/dc/asic.h#L91-L94
> [5] https://www.renesas.com/us/en/document/mah/sh7750-sh7750s-sh7750r-group-users-manual-hardware p. 597
> [6] https://www.renesas.com/us/en/document/mah/sh7751-group-sh7751r-group-users-manual-hardware p. 551
> [7] https://www.renesas.com/us/en/document/mah/sh7760-group-hardware-manual p. 463
> [8] https://www.renesas.com/us/en/document/mah/sh7709s-group-hardware-manual p. 373
> [9] https://www.renesas.com/us/en/document/mah/sh7720-group-sh7721-group-users-manual-hardware p. 467
> [10] https://web.archive.org/web/20050405021907/http://www.superh.com/products/microdev.htm
> 
> Cheers,
> Artur
> 
> Artur Rojek (3):
>   sh: dma: Fix dma channel offset calculation
>   sh: dma: Drop incorrect SH_DMAC_BASE1 for SH4
>   sh: dma: Correct the number of DMA channels in SH7709
> 
>  arch/sh/drivers/dma/Kconfig       | 14 +++++++-----
>  arch/sh/drivers/dma/dma-sh.c      | 37 ++++++++++++++++++++-----------
>  arch/sh/include/cpu-sh4/cpu/dma.h |  1 -
>  3 files changed, 32 insertions(+), 20 deletions(-)
> 

Applied to my for-next tree for 6.5. PR will be sent tomorrow.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
