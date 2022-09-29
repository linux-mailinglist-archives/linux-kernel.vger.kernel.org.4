Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BBB5EF20A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiI2Ja3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiI2J3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:29:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5F3145C95
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664443770; x=1695979770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iylFL7DsPH8a98R74kyfLSpOkEvs/H7jxH/ajrGWmWg=;
  b=dV7lcDOg27cxW7PRO4qr3IAA7H9YopCU/7C45MH74EuC2ZbTMLu/kckm
   9ZVLW7ovDEB6pXaVK7LDXucjyOqTB2PS+Jx77JZAhxTErLJHrn4F8nKGY
   Ct91gFEF8DqbaOWqfOlf0hACS2LGi0+c+MGQmbsSadHmnwBYCXAmkioug
   2AsHjZFtE4rCsv/dUaJSLaxgdZ4mCxF3UwQ/BdD8DcQ6e+xSxWBAQ47Hc
   GQ3y7MfLR/q1pZ2LyuzvTC/J2CUzYHd/VmIAi2B1bxwZeZJNCfwH2maoB
   TDXn9JW+aEtvQJDrwUt1c2O61FOrA24TFCU7WSc9WmKWUVAa/IVwY/UqQ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="182561233"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2022 02:29:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 29 Sep 2022 02:29:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 29 Sep 2022 02:29:26 -0700
Date:   Thu, 29 Sep 2022 10:29:05 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Conor Dooley <conor@kernel.org>, <pmladek@suse.com>,
        <senozhatsky@chromium.org>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <regressions@lists.linux.dev>
Subject: Re: [resend][bug] low-probability console lockups since 5.19
Message-ID: <YzVlYaUPcRmlfE7c@wendy>
References: <Yy3dsSgpDnovBdEn@spud>
 <YzR8fzyjhggO+/tT@spud>
 <98f62903-3d6f-30b4-82ef-3b0460824907@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <98f62903-3d6f-30b4-82ef-3b0460824907@leemhuis.info>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:06:01AM +0200, Thorsten Leemhuis wrote:
> Hi Conor
> 
> On 28.09.22 18:55, Conor Dooley wrote:
> > On Fri, Sep 23, 2022 at 05:24:17PM +0100, Conor Dooley wrote:
> >>
> >> Been bisecting a bug that is causing a boot failure in my CI & have
> >> ended up here.. The bug in question is a low(ish) probability lock up
> >> of the serial console, I would estimate about 1-in-5 chance on the
> >> boards I could actually trigger it on which it has taken me so long
> >> to realise that this was an actual problem. Thinking back on it, there
> >> were other failures that I would retroactively attribute to this
> >> problem too, but I had earlycon disabled
> > [...]
> > #regzbot introduced: 5831788afb17b89c5b531fb60cbd798613ccbb63 ^
> > Hopefully I did this correctly...
> 
> Yes, you did, thx for this. I already had been watching this thread
> manually and was a bit unsure what to do with it.

Great, thanks.

> 
> > I picked that commit as that's where things start going haywire.
> 
> There is one thing I wonder when skimming this thread: was there maybe
> some other change somewhere in the kernel between the introduction and
> the revert of the printk console kthreads patches that is the real
> culprit here that makes existing, older races easier to hit? But I guess
> in the end that would be very hard to find and it's easier to fix the
> problem in the console driver... :-/

Entirely possible that something arrived in the middle, yeah. I've done
100s of reboots on that interim section, albeit with the threaded
printers enabled, as I restarted the bisection several times & never hit
this failure then.

I don't know anything about console/printk/serial drivers unfortunately
so I will almost certainly not be able to find the problem by
inspection. I'd rather submit patches than send reports, but I really
really need some help here. I looked at the two patterns Petr suggested,
but the former I am not sure applies since the issue is present even
when earlycon is disabled & the latter appears (to my untrained eye) to
be accounted for in the 8250 driver.

Thanks,
Conor.

