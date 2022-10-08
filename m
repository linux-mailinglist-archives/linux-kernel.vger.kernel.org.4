Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BCF5F8674
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiJHSIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 14:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiJHSIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:08:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D7D3FEF3;
        Sat,  8 Oct 2022 11:08:32 -0700 (PDT)
X-QQ-mid: bizesmtp80t1665252455teb5lj67
Received: from [192.168.0.179] ( [113.85.219.225])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 09 Oct 2022 02:07:32 +0800 (CST)
X-QQ-SSF: 0100000000000070B000B00A0000000
X-QQ-FEAT: jbaoaN/hLKIC5Yj0V619849HMTLVRPFKWybSzNavB7OliimAOyl1ZwZtGg9e8
        qwWewiQWj4ugjzP4iZ12K1krk/nn6bbb+Ux+60fHDpHJM/NUhqM+kKexBclIBdU89f1f3OE
        73escGs/FVIiTvhkD34943Am9PYMQz3B6NZViXJ4ZhpmLBLK6tOUXEtKoTIHQnfE/cKuZZS
        r38BoyBxUZeLJ3PtCiJTg718u3cK0WWXtfO6zmuj/OCuzK8BaSuD3IFd4znibi33aAM7tzz
        uEb7iiBfn6JzoYVED9oKy4CqhzNzlsFDdF84vKrNmOlDX8CyCz70DLtbLIYfZ02W355lSGY
        v9s88bVWo1NYpOWs8N/yQAA+I+C6SXNGXBsIdx/
X-QQ-GoodBg: 0
Message-ID: <D431E7AF8892354C+5445265a-92e0-59eb-b0ab-98c053543015@linux.starfivetech.com>
Date:   Sun, 9 Oct 2022 02:07:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 05/30] soc: sifive: l2 cache: Convert to platform
 driver
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Ben Dooks <ben.dooks@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-6-hal.feng@linux.starfivetech.com>
 <40d0abb6-88dc-d315-f768-27a623f60986@sifive.com>
 <CAJM55Z-PzvM_-_6jTWX+Jyy2FQ3TJdh4uYj0evpktnEENHL6WA@mail.gmail.com>
 <4d8a199b-f22a-a421-aae4-64e538cb97f4@codethink.co.uk>
 <CAJM55Z8QN1CeknrP9nyh9ei4EFQT_VKfTTi6uH5ssE3rqW5OdA@mail.gmail.com>
 <Yz2PDy9dkuwqyrR4@spud>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <Yz2PDy9dkuwqyrR4@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 15:05:03 +0100, Conor Dooley wrote:
> On Wed, Oct 05, 2022 at 03:55:17PM +0200, Emil Renner Berthing wrote:
> > On Wed, 5 Oct 2022 at 15:48, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > >
> > > On 05/10/2022 14:44, Emil Renner Berthing wrote:
> > > > On Thu, 29 Sept 2022 at 19:59, Ben Dooks <ben.dooks@sifive.com> wrote:
> > > >>
> > > >> On 29/09/2022 15:32, Hal Feng wrote:
> > > >>> From: Emil Renner Berthing <kernel@esmil.dk>
> > > >>>
> > > >>> This converts the driver to use the builtin_platform_driver_probe macro
> > > >>> to initialize the driver. This macro ends up calling device_initcall as
> > > >>> was used previously, but also allocates a platform device which gives us
> > > >>> access to much nicer APIs such as platform_ioremap_resource,
> > > >>> platform_get_irq and dev_err_probe.
> > > >>
> > > >> This is useful, but also there are other changes currently being sorted
> > > >> out by Zong Li (cc'd into this message) which have already been reviewed
> > > >> and are hopefully queued for the next kernel release.
> > > >>
> > > >>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > >>> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > > >
> > > > I'm ok with something like this being merged, but please note that if
> > > > we ever want to support the JH7100 which uses registers in this
> > > > peripheral to flush the cache for its non-coherent DMAs then this
> > > > driver needs to be loaded before other peripherals or we will trigger
> > > > the 2nd warning in arch/riscv/mm/dma-noncoherent.c. I'm not sure we
> > > > can do that when it's a platform driver. See this patch for an
> > > > alternative to support the JH71x0s:
> > > > https://github.com/esmil/linux/commit/9c5b29da56ae29159c9572c5bb195fe3a1b535c5
> > > >
> > > > /Emil
> > >
> > > Are you replying to your own patch that does the conversion to
> > > platform driver and then saying that it could actually cause
> > > issues?
> > 
> > Yes, I can see it seems odd, but this patch lived for a while in the
> > kernel repo for the JH7100 until I rebased on 6.0-rc1 and realized the
> > above.
> > Hal Feng must have based his patches on a version of the code before
> > that when preparing this series.
> > 
> > > I'm all for dropping this for the moment and keeping the old
> > > early init for the ccache.
> > 
> > Cool.
> 
> FWIW, if converting to a platform driver will inhibit using the driver
> for doing non-coherent stuff I would like to NAK the patch :)
> 

Yeah, I agree, and this patch will be dropped on the next version.

