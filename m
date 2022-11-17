Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7458C62D510
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiKQIbZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 03:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:31:23 -0500
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 00:31:22 PST
Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F105F97;
        Thu, 17 Nov 2022 00:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668672967; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=gKBkJc6GTRkb+6rhh5I/c4VXIbERbvAfPuFYx5lFVdmeEPrYTadYLssEpNBknNfbNKj8RXIWT+9BY7qfydn2rufuYtJ86GGyOG8qTl24oDX3dyLSk5R01pmqUXfoqYY8g0yDunVWmHiceXIVb2ZY51uXhJy64QwI0CswF2n/K7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1668672967; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Pa1GyuFssygNW031okYw8FQUTpsDaU4ApKY8oeGmQ8Q=; 
        b=HXhJHhxLnjd4pejwRbqVXRPhT/RqDbrVXJ408l0bqkLGKclMwwhdy4mZjSXT9GuqsJCBcM72btE6fds0t1lRMX/z8m9QZGxzp9eGWBvrjVSvE0sMZ3Hw/KICKwaGDWMVg91s/l80kEkFEmAmGFrNG9xUN6SGPEavHPhtyt1TR+E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=carl@uvos.xyz;
        dmarc=pass header.from=<carl@uvos.xyz>
Received: from [10.8.0.4] (185.53.129.145 [185.53.129.145]) by mx.zoho.eu
        with SMTPS id 1668672964345220.00348153398488; Thu, 17 Nov 2022 09:16:04 +0100 (CET)
Message-ID: <a04a2c13d21d3f381fcd525e5f47c217543d2c18.camel@uvos.xyz>
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Fix battery
 identification
From:   Carl Klemm <carl@uvos.xyz>
To:     Tony Lindgren <tony@atomide.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        philipp@uvos.xyz, Pavel Machek <pavel@ucw.cz>
Date:   Thu, 17 Nov 2022 09:15:55 +0100
In-Reply-To: <Y3W+M3/7zOutygEZ@atomide.com>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
         <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
         <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
         <715a60b5-2f3c-caf7-2b24-61ec92bda9be@gmail.com>
         <Y3OY/l2ZBX+WbRR4@atomide.com>
         <90314373-de30-019a-dc0c-f5cab57a48c6@gmail.com>
         <Y3W+M3/7zOutygEZ@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

We also have a pretty good case having the battery on 4.35V for regular
amounts of time at a time is not damageing:

1. For one thing this corroborated by literature about hvlipos.
2. Personally i used the d4 for manny years with andorid without issue,
giveing the battery manny cycles
3. I think so far we have found very few, if any, devices whos batteris
where replaced by thair previous owners, judgeing by the condition of
the stickers and the battery production dates. Even though maemo leste
has access to manny manny devices.

It is true the hvlipos have a lower cycle lifetime than regular 4.35V
lipos when charged to 4.35 than regular lipos when charged to 4.2V,
however it this effect is not as large as you might think.
It is also true that leaving a Lithium cell of any chemistry on Vmax
for long periods of time siginifcantly accelerates degradion, if this
is sufficant cause to drop the "full" soc a couple of percent is a
debateable and reasonable trade off and would be something we should
then apply to all batteries if chosen, not just hvlipos as it affects
regular lipos just the same.

Regards,

Philipp

On Thu, 2022-11-17 at 06:53 +0200, Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221115 15:31]:
> > Hi,
> > 
> > On 15.11.22 г. 15:49 ч., Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221110 16:40]:
> > > > On 10.11.22 г. 18:05 ч., Sebastian Reichel wrote:
> > > > > Why do we care?
> > > > > 
> > > > Because if we know the battery is genuine (or at least pretends
> > > > to be :) ),
> > > > then we can read battery parameters from nvram, see patch 3/3.
> > > > This will
> > > > allow us to charge HV LiPo batteries to 4.35V, using the full
> > > > capacity.
> > > 
> > > Let's not enable charge voltages above 4.2V automatically at all
> > > unless
> > > the user chooses to set a higher charge voltage via sysfs
> > > manually.
> > > 
> > > We have had reports of bloated batteries if left connected to the
> > > charger
> > > at higher voltage than 4.2V. This seems to happen after connected
> > > for some
> > > weeks or months. AFAIK this happens both with Android and
> > > mainline kernel
> > > at higher voltages.
> > > 
> > 
> > Not that I sent such patch yet, but still, thinking about it, we
> > should be
> > able to easily prevent such damage by not restarting the charging
> > after
> > battery is full and voltage has dropped by 50mV or so. There can be
> > a
> > threshold (lets say 4.25 or 4.2) above which charging shall not be
> > re-enabled unless the user reconnects the charger. Even if default
> > stays 4.2
> > and it is the user that has enabled 4.35. Just an idea.
> 
> Sure the logic to handle max charge voltage and maintenance charge
> voltage
> could be there. With commit d4ee021c410f we now just wait for the
> charge
> to come down to 4.2V if charged at 4.35V with Android.
> 
> We still should not enable higher charge voltages by default though.
> It
> still needs to be enabled by the user via sysfs. It's possible that
> also
> shorter peaks of higher charge voltage accelerate the battery
> degration.
> It just may happen slower than what we've seen earlier. To test this,
> multiple devices would need to be left connected to a charger for
> several
> months :)
> 
> Regards,
> 
> Tony

