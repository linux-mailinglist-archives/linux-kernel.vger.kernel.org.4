Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230E6647C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLICVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLICVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:21:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A85F6DE;
        Thu,  8 Dec 2022 18:21:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p24so3432318plw.1;
        Thu, 08 Dec 2022 18:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjq9vciiOmT8U0O21oJh6IG0VmTosJ4vqGULUOvAJ2g=;
        b=HYpKOfCT6sXosRkwxCGTloHcAANLnx/i8HDeMJ24UvVAvJGmvBIeamkoF7t5aiCjr2
         m9dOJxz85jbpGNDcR2Sk9P4in1W8Y0mthTkbNt/wVIL4bWGMCCaacpyqGttVyViPa/cN
         hjJzIrIUh88IC5DXjYsQdOYXZc5krIUNYU5/dmcY9nOOclAEM+EClczluYfXRspcV1AK
         Xi39z5T2f2gFRpciiwE2qgDYS4UND5QtBLKfVtT29yqScDqOJkthHdpnyTXHmsAko6T5
         qC7Q1knnTZvxFwyy7sPcFJmt3JyybPJ6tZFamI2t2ArIbj+t16QkMgKgBfCOblu6GsHH
         m4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjq9vciiOmT8U0O21oJh6IG0VmTosJ4vqGULUOvAJ2g=;
        b=k0NFKDqvtCXambCud2Deb/SIonFB0UvqIu3WJmPF8+7XT+vNODgHWacCrwOGaAPk+9
         Uk/bvoDuZJZpdfZV0tllS+AsRVOpTMbmA6phSeGKiDMkgFWJoM4FNZOoGYWM3Roi7Ock
         0GQAB2+cDpamEVKJyVfi2tLbRNmBaDqZ7f8BOt8ujaOtArafq+Tms079DFGi+CyLOoZD
         EL/7K6ErNRTWRhVNDAptlUdlwUkCKpWg83CN/65lQALxyVvEyld/hIWoXYwA92YJUCXb
         5akpgh2NboyLTWQQls8Z/mSq4yB1uEmeVUWjIjZRbxRYW+ulfhVxvhsPsWTB8Bq/4Cfb
         7UXg==
X-Gm-Message-State: ANoB5pk76frPHNvUU1agT4vJNYEOgz5n9NsNPMqvtlGmrwveCUj4NYVv
        Enl1s+i4jPz7cbfeQ4G2z90=
X-Google-Smtp-Source: AA0mqf7D/puUwuRoA7wOsjs4jgRjntMXeJLkdj1SonLMPBzZ44nXsQbeCmQIVqC7aYuOy3Rat1x5PA==
X-Received: by 2002:a17:902:8494:b0:186:5f5a:5842 with SMTP id c20-20020a170902849400b001865f5a5842mr4997008plo.11.1670552462750;
        Thu, 08 Dec 2022 18:21:02 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5853:f1e8:694c:1488])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b0018869119e37sm111868plk.142.2022.12.08.18.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:21:02 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:20:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org, swboyd@chromium.org,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] Input: elants_i2c: Delay longer with reset
 asserted
Message-ID: <Y5Kbiy4r1wyN5PBD@google.com>
References: <20221209020612.1303267-1-dianders@chromium.org>
 <20221208180603.v2.5.I6edfb3f459662c041563a54e5b7df727c27caaba@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208180603.v2.5.I6edfb3f459662c041563a54e5b7df727c27caaba@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 06:06:12PM -0800, Douglas Anderson wrote:
> The elan touchscreen datasheet says that the reset GPIO only needs to
> be asserted for 500us in order to reset the regulator. The problem is
> that some boards need a level shifter between the signals on the GPIO
> controller and the signals on the touchscreen. All of these extra
> components on the line can slow the transition of the signals. On one
> board, we measured the reset line and saw that it took almost 1.8ms to
> go low. Even after we bumped up the "drive strength" of the signal
> from the default 2mA to 8mA we still saw it take 421us for the signal
> to go low.
> 
> In order to account for this let's lengthen the amount of time that we
> keep the reset asserted. Let's bump it up from 500us to 5000us.
> That's still a relatively short amount of time and is much safer.
> 
> It should be noted that this fixes real problems. Case in point:
> 1. The touchscreen power rail may be shared with another device (like
>    an eDP panel). That means that at probe time power might already be
>    on.
> 2. In probe we grab the reset GPIO and assert it (make it low).
> 3. We turn on power (a noop since it was already on).
> 4. We wait 500us.
> 5. We deassert the reset GPIO.
> 
> With the above case and only a 500us delay we saw only a partial reset
> asserted, which is bad. Giving it 5ms is overkill but feels safer in
> case someone else has a different level shifter setup.
> 
> Note that bumping up the delay to 5000 means that some configs yell
> about using udelay(). We'll change to using usleep_range(). We give a
> small range here because:
> - This isn't a delay that happens very often so we don't need to worry
>   about giving a big range to allow for power efficiency.
> - usleep_range() is known to almost always pick the upper bound and
>   delay that long and we really don't want to slow down the power on
>   of the touchscreen that much.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2:
> - Fix typo in commit message (Matthias)
> - udelay -> usleep_range (Patches Robot, Dmitry)
> 
>  drivers/input/touchscreen/elants_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 879a4d984c90..192d543e5aa9 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -114,7 +114,7 @@
>  /* calibration timeout definition */
>  #define ELAN_CALI_TIMEOUT_MSEC	12000
>  
> -#define ELAN_POWERON_DELAY_USEC	500
> +#define ELAN_POWERON_DELAY_USEC	5000
>  #define ELAN_RESET_DELAY_MSEC	20
>  
>  /* FW boot code version */
> @@ -1352,7 +1352,7 @@ static int elants_i2c_power_on(struct elants_data *ts)
>  	 * We need to wait a bit after powering on controller before
>  	 * we are allowed to release reset GPIO.
>  	 */
> -	udelay(ELAN_POWERON_DELAY_USEC);
> +	usleep_range(ELAN_POWERON_DELAY_USEC, ELAN_POWERON_DELAY_USEC + 100);
>  
>  release_reset_gpio:
>  	gpiod_set_value_cansleep(ts->reset_gpio, 0);

This gives me conflict because this label is gone in my tree, so I
adjusted for context and applied.

Thanks.

-- 
Dmitry
