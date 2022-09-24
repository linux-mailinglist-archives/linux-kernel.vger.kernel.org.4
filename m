Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302735E8C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIXMG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiIXMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:06:20 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BA5D9083F;
        Sat, 24 Sep 2022 05:06:20 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oc3vH-0007UC-00; Sat, 24 Sep 2022 14:06:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8CDC1C053E; Sat, 24 Sep 2022 12:45:57 +0200 (CEST)
Date:   Sat, 24 Sep 2022 12:45:57 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     john@phrozen.org, martin.blumenstingl@googlemail.com,
        hauke@hauke-m.de, maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: lantiq: enable all hardware interrupts on
 second VPE
Message-ID: <20220924104557.GA10628@alpha.franken.de>
References: <20220921205944.466745-1-olek2@wp.pl>
 <20220921205944.466745-2-olek2@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921205944.466745-2-olek2@wp.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:59:44PM +0200, Aleksander Jan Bajkowski wrote:
> This patch is needed to handle interrupts by the second VPE on the Lantiq
> ARX100, xRX200, xRX300 and xRX330 SoCs. Switching some ICU interrupts to
> the second VPE results in a hang. Currently, the vsmp_init_secondary()
> function is responsible for enabling these interrupts. It only enables
> Malta-specific interrupts (SW0, SW1, HW4 and HW5).
> 
> The MIPS core has 8 interrupts defined. On Lantiq SoCs, hardware
> interrupts are wired to an ICU instance. Each VPE has an independent
> instance of the ICU. The mapping of the ICU interrupts is shown below:
> SW0(IP0) - IPI call,
> SW1(IP1) - IPI resched,
> HW0(IP2) - ICU 0-31,
> HW1(IP3) - ICU 32-63,
> HW2(IP4) - ICU 64-95,
> HW3(IP5) - ICU 96-127,
> HW4(IP6) - ICU 128-159,
> HW5(IP7) - timer.
> 
> This patch enables all interrupt lines on the second VPE.
> 
> This problem affects multithreaded SoCs with a custom interrupt controller.
> SOCs with 1004Kc core and newer use the MIPS GIC. At this point, I am aware
> that the Realtek RTL839x and RTL930x SoCs may need a similar fix. In the
> future, this may be replaced with some generic solution.
> 
> Tested on Lantiq xRX200.
> 
> Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  arch/mips/lantiq/prom.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
