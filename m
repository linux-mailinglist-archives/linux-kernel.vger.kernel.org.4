Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D905BB75A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIQI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIQI7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:59:39 -0400
X-Greylist: delayed 276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Sep 2022 01:59:35 PDT
Received: from tulikuusama2.dnainternet.net (tulikuusama2.dnainternet.net [83.102.40.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13AABC1;
        Sat, 17 Sep 2022 01:59:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id 7C5D2286EB;
        Sat, 17 Sep 2022 11:59:30 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 2.975
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
Received: from tulikuusama2.dnainternet.net ([83.102.40.151])
        by localhost (tulikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id Auole-u3B_-5; Sat, 17 Sep 2022 11:59:30 +0300 (EEST)
Received: from omenapuu2.dnainternet.net (omenapuu2.dnainternet.net [83.102.40.54])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id 5390E25E71;
        Sat, 17 Sep 2022 11:59:30 +0300 (EEST)
Received: from localhost (87-95-96-237.bb.dnainternet.fi [87.95.96.237])
        by omenapuu2.dnainternet.net (Postfix) with ESMTP id 923AF1BF;
        Sat, 17 Sep 2022 11:59:23 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 17 Sep 2022 11:59:22 +0300
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>, brgl@bgdev.pl,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: idio-16: Introduce the ACCES IDIO-16 GPIO
 library module
Message-ID: <YyWMai1UZPaBbsOx@surfacebook>
References: <cover.1662927941.git.william.gray@linaro.org>
 <6b28fb497c35def57c1920362c82402bed4bd23f.1662927941.git.william.gray@linaro.org>
 <YyCs1/HgOG31MX1N@smile.fi.intel.com>
 <YyNIxWS0sneUKas0@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyNIxWS0sneUKas0@fedora>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Sep 15, 2022 at 11:46:13AM -0400, William Breathitt Gray kirjoitti:
> On Tue, Sep 13, 2022 at 07:16:23PM +0300, Andy Shevchenko wrote:
> > On Sun, Sep 11, 2022 at 04:34:38PM -0400, William Breathitt Gray wrote:

...

> > > +	if (value)
> > > +		set_bit(offset, state->out_state);
> > > +	else
> > > +		clear_bit(offset, state->out_state);
> > 
> > assign_bit()
> > 
> > But I'm wondering why do you need the atomic bitops under the lock?
> 
> I don't think atomic bitops are necessary in this case because of the
> lock as you pointedly out, but I felt using these made the intention of
> the code clearer. Is there a non-atomic version of assign_bit(), or do
> you recommend I use bitwise operations directly here instead?

__assign_bit()

Hint: All __ prefixed bitops (for a single bit operation!) are considered
non-atomic. There are exceptions when no __-variant of op is present, but
it not the case here AFAICS. 

-- 
With Best Regards,
Andy Shevchenko


