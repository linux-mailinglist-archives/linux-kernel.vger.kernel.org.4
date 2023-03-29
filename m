Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E376CF14A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjC2Rnj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Rni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:43:38 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760B5254;
        Wed, 29 Mar 2023 10:43:36 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id aafa1b008520eda2; Wed, 29 Mar 2023 19:43:35 +0200
Received: from kreacher.localnet (unknown [213.134.183.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 859211FA13B8;
        Wed, 29 Mar 2023 19:43:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL pointer dereference
Date:   Wed, 29 Mar 2023 19:43:33 +0200
Message-ID: <12190090.O9o76ZdvQC@kreacher>
In-Reply-To: <5b084360-898b-aad0-0b8e-33acc585d71d@linaro.org>
References: <20230329090055.7537-1-rui.zhang@intel.com> <CAJZ5v0iMAT_1cQorTqK4xRTjD3a_s=Vf3OJYy3hi7=pAekLv+g@mail.gmail.com> <5b084360-898b-aad0-0b8e-33acc585d71d@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.20
X-CLIENT-HOSTNAME: 213.134.183.20
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeekieelheffleefgffgtdejvdektedtjeefveeugeefvdfhgfduueetiefgieelteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukeefrddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeefrddvtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
 pdhrtghpthhtoheprhgrfhgrvghlrdhjrdifhihsohgtkhhisehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 29, 2023 6:18:31 PM CEST Daniel Lezcano wrote:
> On 29/03/2023 18:03, Rafael J. Wysocki wrote:
> > On Wed, Mar 29, 2023 at 5:59 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 29/03/2023 16:38, Rafael J. Wysocki wrote:
> >>> On Wed, Mar 29, 2023 at 4:16 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 29/03/2023 14:06, Rafael J. Wysocki wrote:
> >>>>> On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
> >>>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>>
> >>>>>> On 29/03/2023 11:00, Zhang Rui wrote:
> >>>>>>> When the hwmon device node of a thermal zone device is not found,
> >>>>>>> using hwmon->device causes a kernel NULL pointer dereference.
> >>>>>>>
> >>>>>>> Reported-by: Preble Adam C <adam.c.preble@intel.com>
> >>>>>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >>>>>>> ---
> >>>>>>> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> >>>>>>> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> >>>>>>> I'm not sure if the Fix tag applies to such commit or not.
> >>>>>>
> >>>>>> Actually it reverts the work done to encapsulate the thermal zone device
> >>>>>> structure.
> >>>>>
> >>>>> So maybe instead of the wholesale switch to using "driver-specific"
> >>>>> device pointers for printing messages, something like
> >>>>> thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
> >>>>> the first argument can be defined?
> >>>>>
> >>>>> At least this particular bug could be avoided this way.
> >>>>
> >>>> Actually we previously said the thermal_hwmon can be considered as part
> >>>> of the thermal core code, so we can keep using tz->device.
> >>>>
> >>>> I'll drop this change from the series.
> >>>
> >>> But it's there in my thermal branch already.
> >>>
> >>> Do you want to revert the thermal_hwmon.c part of commit dec07d399cc8?
> >>
> >> Oh, right. Fair enough.
> >>
> >> I think Rui's patch is fine then.
> > 
> > I guess you mean the $subject one, that is:
> > 
> > https://patchwork.kernel.org/project/linux-pm/patch/20230329090055.7537-1-rui.zhang@intel.com
> 
> Correct
> 
> > What about the message printed when temp is NULL.  Should the original
> > form of it be restored too?
> 
> Yes, you are right, for the sake of consistency we should restore also 
> this one.

So I'm going to apply the appended patch.

Please let me know if there are any concerns regarding it.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] thermal: thermal_hwmon: Revert recent message adjustment

For the sake of consistency, revert the second part of the
thermal_hwmon.c hunk from commit dec07d399cc8 ("thermal: Don't use
'device' internal thermal zone structure field") after the first
part of it has been reverted.

Link: https://lore.kernel.org/linux-pm/5b084360-898b-aad0-0b8e-33acc585d71d@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_hwmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_hwmon.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_hwmon.c
+++ linux-pm/drivers/thermal/thermal_hwmon.c
@@ -236,7 +236,7 @@ void thermal_remove_hwmon_sysfs(struct t
 	temp = thermal_hwmon_lookup_temp(hwmon, tz);
 	if (unlikely(!temp)) {
 		/* Should never happen... */
-		dev_dbg(hwmon->device, "temperature input lookup failed!\n");
+		dev_dbg(&tz->device, "temperature input lookup failed!\n");
 		return;
 	}
 



