Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548BD7151D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjE2WYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2WYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:24:36 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548FA92
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:24:35 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 94902ba4-fe6f-11ed-abf4-005056bdd08f;
        Tue, 30 May 2023 01:24:31 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 01:24:30 +0300
To:     simon.guinot@sequanux.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, xingtong_wu@163.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, henning.schild@siemens.com,
        xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Message-ID: <ZHUmHkbM-l_pRaY3@surfacebook>
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost>
 <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
 <ZHSunJyh2AU1eb0H@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHSunJyh2AU1eb0H@localhost>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 29, 2023 at 03:54:36PM +0200, simon.guinot@sequanux.org kirjoitti:
> On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
> > On Mon, May 29, 2023 at 2:27 PM <simon.guinot@sequanux.org> wrote:
> > 
> > > It would be nice if a pin number found in the device datasheet could
> > > still be converted into a Linux GPIO number by adding the base of the
> > > first bank.
> > 
> > We actively discourage this kind of mapping because of reasons stated
> > in drivers/gpio/TODO: we want dynamic number allocation to be the
> > norm.
> 
> Sure but it would be nice to have a dynamic base applied to a controller
> (and not to each chip of this controller), and to respect the interval
> between the chips (as stated in the controllers datasheets).

What you want is against the architecture. To fix this, you might change
the architecture of the driver to have one chip for the controller, but
it's quite questionable change. Also how can you guarantee ordering of
the enumeration? You probably need to *disable* SMP on the boot time.
This will still be fragile as long as GPIO chip can be unbound at run
time. Order can be changed.

So, the patch is good and the correct way to go.

P.S. The root cause is that hardware engineers and documentation writers
do not consider their hardware in the multi-tasking, multi-user general
purpose operating system, such as Linux. I believe the ideal fix is to fix the
documentation (datasheet).

-- 
With Best Regards,
Andy Shevchenko


