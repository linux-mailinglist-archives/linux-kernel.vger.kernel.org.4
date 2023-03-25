Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006ED6C8F54
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCYQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:08:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA6FF17;
        Sat, 25 Mar 2023 09:08:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1DBCA1C0AB2; Sat, 25 Mar 2023 17:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679760504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEKEwD7Om+RRexV9hRNFNILZ/Gg7SAFeSqwc3blzYCY=;
        b=EhyOiiPKGIaPrIe94NKHyhbH7z0eHrzaaLi6I8V1Q6MYqQFo8d4EqWuhEdYKUwSVoPsuIt
        W351Bu+oVUrgOCVORWS6EwRLEyf29Fse8GsHtpN0uwLb5DYOAoG4DTlIxpWex2kqomzDyy
        FIql+UfuPo5yQywImANnfCjx9DkQWxU=
Date:   Sat, 25 Mar 2023 17:08:20 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 00/10] Add RT5033 charger device driver
Message-ID: <20230325160819.GA1820@bug>
References: <cover.1677620677.git.jahau.ref@rocketmail.com>
 <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Some comments on the end-of-charge behavior. The rt5033 chip offers three
> options. In the Android driver, a forth option was implemented.

Hmm. I'm working on that on motorola-cpcap driver, and I guess this is going
to be common problem for many drivers.

> - By default, the rt5033 chip charges indefinitely. The current goes down=
 but
>   there is always a charge voltage to the battery, which might not be too=
 good
>   for the battery lifetime.
> - There is the possibility to enable a fast charge timer. The timer can be
>   set to 4, 6, 8... 16 hours. After that time has elapsed, charging stops
>   and the battery gets discharged. This option with a timer of 4 hours was
>   chosen by Beomho Seo in the patchset of March 2015. However, that option
>   is confusing to the user. It doesn't initiate a re-charge cycle. So when
>   keeping plugged in the device over night, I find it discharging on the
>   next morning.
> - The third option of the rt5033 chip is enabling charging termination. T=
his
>   also enables a re-charge cycle. When the charging current sinks below t=
he
>   end-of-charge current, the chip stops charging. The sysfs state changes=
 to
>   "not charging". When the voltage gets 0.1 V below the end-of-charge con=
stant
>   voltage, re-charging starts. Then again, when charging current sinks be=
low
>   the end-of-charge current, the chip stops charging. And so on, going up=
 and
>   down in re-charge cycles. In case the power consumption is high (e.g. t=
uning
>   on the display of the mobile device), the current goes into an equilibr=
ium.
>   The downside of this charging termination option: When reaching the end=
-of-
>   charge current, the capacity might not have reached 100 % yet. The capa=
city
>   to reach probably depends on power consumption and battery wear. On my =
mobile
>   device, capacity reaches 98 %, drops to 96 % until re-charging kicks in,
>   climbs to 98 %, drops to 96 %, and so on. Not reaching 100 % is a bit
>   confusing to the user, too.

Is the system powered from the battery in the not-charging case?

Anyway, we should teach userspace that "full battery" does not neccessary m=
ean 100%,
as keeping battery at 4.3V wears it down quickly.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
