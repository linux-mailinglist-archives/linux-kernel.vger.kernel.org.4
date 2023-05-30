Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A4715CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjE3LK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjE3LKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:10:23 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F95E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:10:22 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 90076a58-feda-11ed-b972-005056bdfda7;
        Tue, 30 May 2023 14:10:19 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 14:10:19 +0300
To:     andy.shevchenko@gmail.com
Cc:     "xingtong.wu" <xingtong_wu@163.com>, simon.guinot@sequanux.org,
        Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        henning.schild@siemens.com, xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Message-ID: <ZHXZmzvE8tWE1J3y@surfacebook>
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost>
 <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
 <ZHSunJyh2AU1eb0H@localhost>
 <ZHUmHkbM-l_pRaY3@surfacebook>
 <5428dcc3-bcaf-2fff-59db-62d3b3b45d17@163.com>
 <ZHXVu-oARZKVOyzm@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHXVu-oARZKVOyzm@surfacebook>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 01:53:47PM +0300, andy.shevchenko@gmail.com kirjoitti:
> Tue, May 30, 2023 at 02:27:09PM +0800, xingtong.wu kirjoitti:
> > On 2023/5/30 06:24, andy.shevchenko@gmail.com wrote:
> > > Mon, May 29, 2023 at 03:54:36PM +0200, simon.guinot@sequanux.org kirjoitti:
> > >> On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
> > >>> On Mon, May 29, 2023 at 2:27 PM <simon.guinot@sequanux.org> wrote:
> > >>>
> > >>>> It would be nice if a pin number found in the device datasheet could
> > >>>> still be converted into a Linux GPIO number by adding the base of the
> > >>>> first bank.
> > >>>
> > >>> We actively discourage this kind of mapping because of reasons stated
> > >>> in drivers/gpio/TODO: we want dynamic number allocation to be the
> > >>> norm.
> > >>
> > >> Sure but it would be nice to have a dynamic base applied to a controller
> > >> (and not to each chip of this controller), and to respect the interval
> > >> between the chips (as stated in the controllers datasheets).
> > > 
> > > What you want is against the architecture. To fix this, you might change
> > > the architecture of the driver to have one chip for the controller, but
> > > it's quite questionable change. Also how can you guarantee ordering of
> > > the enumeration? You probably need to *disable* SMP on the boot time.
> > > This will still be fragile as long as GPIO chip can be unbound at run
> > > time. Order can be changed.
> > > 
> > > So, the patch is good and the correct way to go.
> > > 
> > > P.S. The root cause is that hardware engineers and documentation writers
> > > do not consider their hardware in the multi-tasking, multi-user general
> > > purpose operating system, such as Linux. I believe the ideal fix is to fix the
> > > documentation (datasheet).
> > 
> > Thanks for your review.
> > 
> > The direct reason of this patch

Oh, It seems I misread this as the cause of the patch, please ignore my
previous reply.

> > is that when "modprobe gpio-f7188x",
> > it conflicts with INT34C6. I met this issue on an older kernel, but
> > could not remember which version exactly.
> 
> This is interesting. But what I have noticed the v6.3.2 missing this
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpio/gpiolib.c?id=7dd3d9bd873f138675cb727eaa51a498d99f0e89
> change. Can you apply and retest?
> 
> If this does not help, please share more details, exact steps of reproducing
> the issue, including respective `dmesg` output, etc. (maybe via creating a
> kernel bugzilla report).
> 
> > The error message is as the link below:
> > https://elixir.bootlin.com/linux/v6.3.2/source/drivers/gpio/gpiolib.c#L798

-- 
With Best Regards,
Andy Shevchenko


