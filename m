Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9362D269
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiKQExP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiKQExK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:53:10 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5811E27FF7;
        Wed, 16 Nov 2022 20:53:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 40EEB80A6;
        Thu, 17 Nov 2022 04:43:05 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:53:07 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        philipp@uvos.xyz, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Fix battery
 identification
Message-ID: <Y3W+M3/7zOutygEZ@atomide.com>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
 <715a60b5-2f3c-caf7-2b24-61ec92bda9be@gmail.com>
 <Y3OY/l2ZBX+WbRR4@atomide.com>
 <90314373-de30-019a-dc0c-f5cab57a48c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90314373-de30-019a-dc0c-f5cab57a48c6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221115 15:31]:
> Hi,
> 
> On 15.11.22 г. 15:49 ч., Tony Lindgren wrote:
> > Hi,
> > 
> > * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221110 16:40]:
> > > On 10.11.22 г. 18:05 ч., Sebastian Reichel wrote:
> > > > Why do we care?
> > > > 
> > > Because if we know the battery is genuine (or at least pretends to be :) ),
> > > then we can read battery parameters from nvram, see patch 3/3. This will
> > > allow us to charge HV LiPo batteries to 4.35V, using the full capacity.
> > 
> > Let's not enable charge voltages above 4.2V automatically at all unless
> > the user chooses to set a higher charge voltage via sysfs manually.
> > 
> > We have had reports of bloated batteries if left connected to the charger
> > at higher voltage than 4.2V. This seems to happen after connected for some
> > weeks or months. AFAIK this happens both with Android and mainline kernel
> > at higher voltages.
> > 
> 
> Not that I sent such patch yet, but still, thinking about it, we should be
> able to easily prevent such damage by not restarting the charging after
> battery is full and voltage has dropped by 50mV or so. There can be a
> threshold (lets say 4.25 or 4.2) above which charging shall not be
> re-enabled unless the user reconnects the charger. Even if default stays 4.2
> and it is the user that has enabled 4.35. Just an idea.

Sure the logic to handle max charge voltage and maintenance charge voltage
could be there. With commit d4ee021c410f we now just wait for the charge
to come down to 4.2V if charged at 4.35V with Android.

We still should not enable higher charge voltages by default though. It
still needs to be enabled by the user via sysfs. It's possible that also
shorter peaks of higher charge voltage accelerate the battery degration.
It just may happen slower than what we've seen earlier. To test this,
multiple devices would need to be left connected to a charger for several
months :)

Regards,

Tony
