Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB2B6D35DE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDBGwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDBGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 02:52:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA601BD8;
        Sat,  1 Apr 2023 23:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BE9DB80D9D;
        Sun,  2 Apr 2023 06:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172F1C433EF;
        Sun,  2 Apr 2023 06:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680418330;
        bh=a/EFMMyTJLmdvL39oZFGsprYDxcAb3c4B++/AP48aI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pqQ8UGR2W/sRFjxT8DARJF1gEKMVmWBdp+qDC9PGt0i4TRAg0xAwoG7YQQxAtDcdi
         4Pb253Uxof3u9uF71S5Xrs095QXIy4AdVj3153ZRySY7w6oib4sTzQ8CqAmyQSRayG
         2EAT/e6m3unLAUSKk8zn/YhBr3R6k1eBeKiApm9beA6GV7oD5h7f9NbOa+/z/XcUUq
         Wo1iHf9vVkeyRvdktceSDmuJx7kOOEGZtUZ6DOOxmfVTUgf0Rrb6I9FB+HQBZqNZ1B
         jIzLWCQM2V8D9tYxUPIRptyXw28M0O5YuIe+Fd2OoUguwXFRn6X5yntmmRZtkvx66T
         3696IoVFPDlHA==
Message-ID: <2b298e8c-e6fc-a973-9f42-b6a88e92838a@kernel.org>
Date:   Sun, 2 Apr 2023 12:22:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 13/21] arc: dma-mapping: skip invalidating before
 bidirectional DMA
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-14-arnd@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230327121317.4081816-14-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Shahab

On 3/27/23 17:43, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
>
> Some architectures that need to invalidate buffers after bidirectional
> DMA because of speculative prefetching only do a simpler writeback
> before that DMA, while architectures that don't need to do the second
> invalidate tend to have a combined writeback+invalidate before the
> DMA.
>
> arc is one of the architectures that does both, which seems unnecessary.
>
> Change it to behave like arm/arm64/xtensa instead, and use just a
> writeback before the DMA when we do the invalidate afterwards.
>
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

Reviewed-by: Vineet Gupta <vgupta@kernel.org>

Shahab can you give this a spin on hsdk - run glibc testsuite over ssh 
and make sure nothing strange happens.

Thx,
-Vineet
