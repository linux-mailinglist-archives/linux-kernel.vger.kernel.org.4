Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC8647B95
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiLIBso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLIBsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:48:41 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2231DF1;
        Thu,  8 Dec 2022 17:48:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k7so3345742pll.6;
        Thu, 08 Dec 2022 17:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpjUITsP3izvwVyTbD/APNjnztZs1xEJI8Ir6lrflVU=;
        b=oROwjNNYtG2PxlGe0lB8WKs7sy7mntxHy1KlkC9HCwIXQzO0DHtgzunfhWDnZkzf62
         rKjNj+u4bLz+UcQOz44tIWqvuA+2T0lnHXU5HevZ+es290YV7goh4CyssCH3yhSj3T5C
         lX25Gvejj+7zbWoWgkqfgYFf2lqviHEhCEkd1ERuVaGaXtoVnlH4OSNwAuR4+aw8tcm7
         jBkfA3OFBkzxYi9P2q7CQ101SkW3RghxO6dvj4om16ixWTkNSljgrnSLVgZW3Ou1k12N
         8KccypNiCPfMDUAM4uzwLRRS0xUAPZU7tNhmCTR0mUlHrHCUTx2VyVZGHI6dvV10G2Qa
         LlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpjUITsP3izvwVyTbD/APNjnztZs1xEJI8Ir6lrflVU=;
        b=Q9HylAd5RMuznNUZzENfdFgGYLboCTPBVmnwIrgCjC4jReGzXGliVadrYXRi02Chmz
         ivVOFpgSdo4AEraNlAH3VtlXY8hnn+OYhHfLKmf1KMpPnGCwOHBNjkQzLaE1kLH8Bj4a
         +JmohPxwCc2JUVdaasguNWE8rtN5wkgo0XeLe/IJ4tsc5cLDswYUbPicvfxB8XRFXRTi
         yOx7CLhkwCKklqfS/T7NOK5n6I8qBel0gu3Yz0alpc8V3gOwWcifkTYPaoGw9oDVG0hQ
         a8prji0UizdEcS3edFCMUzw9gw37uO29ZRocNG5PEZAWumVzAlM/iQMp8wzD6OlFSPfg
         Wkig==
X-Gm-Message-State: ANoB5pm1CAL7g25pbuiLrjhvbfIDr/h8FiiYRrJXTpmZro2SZI8raTBj
        uA3Tg4a+98dnwDr8PJMQ2d1VM3KDdzU=
X-Google-Smtp-Source: AA0mqf5WjgALqdkNZ76Zc0h+ASzhCjtY87QuNJySucX96pI7ZHSnQvKVKl2WcvrXLso5pvOTY1aH0A==
X-Received: by 2002:a17:902:b494:b0:188:635d:4ca9 with SMTP id y20-20020a170902b49400b00188635d4ca9mr4188341plr.2.1670550516406;
        Thu, 08 Dec 2022 17:48:36 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5853:f1e8:694c:1488])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902eb8d00b00189548573a2sm81875plg.161.2022.12.08.17.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:48:35 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:48:32 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, mka@chromium.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: elants_i2c: Delay longer with reset asserted
Message-ID: <Y5KT8EXRC/i+lBRe@google.com>
References: <20221208192006.1070898-1-dianders@chromium.org>
 <20221208111910.5.I6edfb3f459662c041563a54e5b7df727c27caaba@changeid>
 <Y5KRlNvoVo6ZWV24@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5KRlNvoVo6ZWV24@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 05:38:28PM -0800, Dmitry Torokhov wrote:
> On Thu, Dec 08, 2022 at 11:20:06AM -0800, Douglas Anderson wrote:
> > The elan touchscreen datasheet says that the reset GPIO only needs to
> > be asserted for 500us in order to reset the regulator. The problem is
> > that some boards need a level shifter between the signals on the GPIO
> > controller and the signals on the touchscreen. All of these extra
> > components on the line can slow the transition of the signals. On one
> > board, we measured the reset line and saw that it took almost 1.8ms to
> > go low. Even after we bumped up the "drive strength" of the signal
> > from the default 2mA to 8mA we still saw it take 421us for the signal
> > to go low.
> > 
> > In order to account for this we let's lengthen the amount of time that
> > we keep the reset asserted. Let's bump it up from 500us to 5000us.
> > That's still a relatively short amount of time and is much safer.
> > 
> > It should be noted that this fixes real problems. Case in point:
> > 1. The touchscreen power rail may be shared with another device (like
> >    an eDP panel). That means that at probe time power might already be
> >    on.
> > 2. In probe we grab the reset GPIO and assert it (make it low).
> > 3. We turn on power (a noop since it was already on).
> > 4. We wait 500us.
> > 5. We deassert the reset GPIO.
> > 
> > With the above case and only a 500us delay we saw only a partial reset
> > asserted, which is bad. Giving it 5ms is overkill but feels safer in
> > case someone else has a different level shifter setup.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Applied, thank you.

Unapplied ;) I guess we should follow kernel test robot's advise and
switch to using usleep_range().

-- 
Dmitry
