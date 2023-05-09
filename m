Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B386FC3C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjEIKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjEIKXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:23:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6FD2FB;
        Tue,  9 May 2023 03:23:31 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3499ZKv2032362;
        Tue, 9 May 2023 05:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=0JvJpUJ9dRrnYJVytoM9aKMhJp8YkGJATnN/Hyyw2Zo=;
 b=CPSu+MZurAbpLvDiLnsdgMQ/cqG2R9gjr+Wx8b5/pEIB5+ITEMLX8ag5SBou91VoaJal
 6obfPTTXzQKoxS0n/b3TKvnR3t3TvM/ndZjf+u/LcN2ALTpNArXdSX/bsBN1rFJlpPDV
 LOAAEfBlVJU4GXjVtvcu6iSNHrvV6OYGLSVh3FPbca8Mnzlnk5BqxzTSh2+ThoJMoZkC
 9Kd1y2JTvkNqlIuMXwnZOokS0/EDzjYCUrF48JNP7T7w4VaQ385kDFO9Tj18TMyyb5FE
 GHyJy3bZVZkcJ3aPEW2WtE8CI4MM4ka5X1Kp2wSTFrejRzMLIfCPmU3u0C0Y+1S/Lxpf Ig== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s40syg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 05:22:59 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 9 May
 2023 05:22:57 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 05:22:57 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2FBF311DC;
        Tue,  9 May 2023 10:22:57 +0000 (UTC)
Date:   Tue, 9 May 2023 10:22:57 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Fred Treven <Fred.Treven@cirrus.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "James Ogletree" <James.Ogletree@cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Message-ID: <20230509102257.GG68926@ediswmail.ad.cirrus.com>
References: <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71>
 <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71>
 <20230411092708.GX68926@ediswmail.ad.cirrus.com>
 <ZDYakQMOPsPTbGe0@nixie71>
 <6ABC85BA-AF2D-4D2E-8CA8-32E372570DA0@cirrus.com>
 <ZDsPGYJjCNmtizKk@nixie71>
 <7E101F4B-782A-4B8B-B6AB-3E7E282C9A9C@cirrus.com>
 <ZFa42bBbX+SDuoXg@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFa42bBbX+SDuoXg@nixie71>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: up4xPDE9ghuWs_jh5EB8sSq13S1O9tvR
X-Proofpoint-GUID: up4xPDE9ghuWs_jh5EB8sSq13S1O9tvR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 03:30:17PM -0500, Jeff LaBundy wrote:
> On Thu, May 04, 2023 at 09:51:37PM +0000, Fred Treven wrote:
> > >> +const struct dev_pm_ops cs40l26_pm_ops = {
> > >> + SET_RUNTIME_PM_OPS(cs40l26_suspend, cs40l26_resume, NULL)
> > >> + SET_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend, cs40l26_sys_resume)
> > >> + SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cs40l26_sys_suspend_noirq, cs40l26_sys_resume_noirq)
> > >> +};
> > >> +EXPORT_SYMBOL_GPL(cs40l26_pm_ops);
> > > 
> > > Please use latest macros (e.g. DEFINE_SIMPLE_DEV_PM_OPS).
> > 
> > When looking at these *_PM_OPS* macros that replace the deprecated versions,
> > it is unclear to me how to maintain support for *_sys_* and
> > *_sys_*_noirq* functions. Would these all need to be separately defined
> > via DEFINE_SIMPLE_DEV_PM_OPS?
> > Would the *_sys_* definitions still be defined through a struct i.e.
> > const struct dev_pm_ops cs40l26_sys_pm_ops which is then exported as it
> > is in my initial submission? 
> > I’m unsure how to handle these cases with the latest macros.
> 
> I don't happen to see macros for suspend_noirq and resume_noirq, so maybe you
> cannot use macros here after all and will instead have to fall back to tacking
> on __maybe_unused to these callbacks to accommodate the !CONFIG_PM case.
> 

Correct this device can not presently use the simple macros.

> That being said, what are you ultimately trying to accomplish here with these
> noirq variants? For example the print statement says "early resume" when in
> fact a different callback exists for that (resume_early).
> 
> On that note, why to disable interrupts during system suspend? I can imagine a
> use-case where a customer ties the output of a force sensor to a CS40L26 GPIO
> for low-latency haptic trigger, and then the CS40L26 interrupt output to the
> SoC as a wake-up trigger. Does the part not support this use-case? I vaguely
> seem to remember an issue with this on L25.
> 
> Also, why is the logic inverted for the noirq variants? These are simply meant
> to accommodate additional tasks that need a guarantee the device's interrupt
> handler is not running (for example, clear or acknowledge a pending interrupt).
> In case I have misunderstood the intent, please let me know.
> 

This is a generic issue with devices that use PM runtime, but
also have IRQs. The system suspend process re-enables IRQs before it
re-enables the PM runtime. This means if your IRQ handler uses PM
runtime and you get an IRQ in that window things don't work. The
simplest solution is to disable IRQs across the window. Ideally
one day this would probably get fixed in the PM core, but that is
likely a massively non-trivial amount of work.

To be clear the code allows IRQs whilst in system suspend (aka wakes)
and whilst resumed. As the IRQ output of the chip is level based, the
temporary disable only causes a slight delay in handling the IRQ.

> One last gripe, then I promise to stop bringing it up :) But the mental gymnastics
> required to explain the no-fewer-than-six PM callbacks used here, as well as how
> to support the !CONFIG_PM case, are in some ways additional nudges toward getting
> rid of this massive amount of PM overhead and relying on the device's internal
> power management as so many modern input devices now do. As a rule of thumb, if
> you're having to jump through a lot of hoops to do simple things that others seem
> to be doing with less work, something is wrong.
> 

I am not sure there are significant issues supporting the
!CONFIG_PM case, you need a couple __maybe_unused's. What issues
are you expecting here? Yeah ok you get worse power consumption
in that case, but you did turn off power management, presumably
you were not that concerned about power consumption.

> In your defense, however, you are unlikely to come across many devices that do
> not enable CONFIG_PM given this device's target application. That being said, it
> is not unheard of for OEMs building wall-powered devices to enable CONFIG_PM but
> inhibit system suspend using a wake_lock because of some HW bug.
> 

Again remember the system vs runtime suspend here. Holding a
system wake lock will have no effect on the runtime PM.

> Therefore, it seems a bit unfortunate that those use-cases wouldn't get to enjoy
> the power savings this devices offers. That's just my $.02; I also understand
> the reasons behind the current implementation and won't push you to change it.

The power savings from not blocking suspend are tiny, at least
outwith the !CONFIG_PM case. The driver is only blocking hibernate
when it is actively talking to the device, during which time the
device will very likely not be hibernating anyway.

I think really it is up to Fred and Ben who are supporting the
driver. If they feel the device will work reliably that way,
I certainly won't stand in the way. But I would be keen to avoid
a situation where all the downstream implementations (ie. most
of the testing) use PM runtime and the upstream code is full of
corner cases that haven't been ironed out, so I would like to
know they are going to be moving our customers over to this new
mode of operation if they decide to switch to it. Certainly you
are not wrong that it would save a fair amount of code from the
driver and make it look a lot cleaner.

Thanks,
Charles
