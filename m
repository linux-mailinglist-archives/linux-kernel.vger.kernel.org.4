Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446CF68ABFE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjBDSzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjBDSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:55:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B0C2312D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:55:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id pj3so8070873pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fX7us3l8FECNvFyFfGHvQqGFyYX20qpBy5DRl3hNUXY=;
        b=d106EQ+VZvXlrM9a5iCtuHUP+tqenpG8j5BxKlne1/KcNjgCw2bugD0dK4RC7E21WC
         OggXZtB0EARUxTv4zwHIUq3thGCvwV4RPn+s8FOEhYMnb091+GGaFwRKUooWhF9I7eS0
         8hLse0ghlAEwzk0rSMnCT3dZPWACEdWGlFT04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX7us3l8FECNvFyFfGHvQqGFyYX20qpBy5DRl3hNUXY=;
        b=D+LHppDkUrNqWeIH6Z4CUjA4Xoc5hlA+nQmFPC3j/J9thHepmJueE1ikt+9Aq3xj7A
         u1BcOzq2bWHFZQcnj9z95RTW0ufxcD1uUs2VHfmHzIegP4f2M4SzFFBOArwd0vtriEF9
         lC/jIPhGWewLMlZJghPBrK04+6BEybcG8MfAENcgJcfYBG/Hb+19D5adOz5a2VCeL1I6
         JwlpSMI2/DkBzDpwggMgQ7/5sRGQI9qWVgLppzqWgd1nOqAHRByTlGN+yoHXitCKM407
         Zrw6ThR3FCpIA5Si62tMPmEH4/E2Hr87sCvu5hF76gcQarAZpJIdVpcCulUsHZWvhCec
         DldA==
X-Gm-Message-State: AO0yUKW/MN+LorQnBF2tKQliiDPY6uFQ0Xi0U9ltcKFcIYaQquApZ3bg
        uy77CXNfFyWdAYAuNIt8NdrxrcR4D/0IlfJ6
X-Google-Smtp-Source: AK7set9qD29nbI/0c7dYZ1BiIhgUrRU4fqxxG8GVvvoPBpF54w86fWg9d4LtiP/b8dDJHEkdmcBTQQ==
X-Received: by 2002:a05:6a20:9381:b0:be:c217:9580 with SMTP id x1-20020a056a20938100b000bec2179580mr17463212pzh.49.1675536908014;
        Sat, 04 Feb 2023 10:55:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a00228e00b0058d54960eccsm4028869pfe.151.2023.02.04.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:55:07 -0800 (PST)
Message-ID: <63deaa0b.050a0220.bf1e1.6c26@mx.google.com>
X-Google-Original-Message-ID: <202302041050.@keescook>
Date:   Sat, 4 Feb 2023 10:55:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lm85: Bounds check to_sensor_dev_attr()->index usage
References: <20230127223744.never.113-kees@kernel.org>
 <20230128131319.GA4173006@roeck-us.net>
 <63dd8c1a.170a0220.d3456.3451@mx.google.com>
 <20230204015700.GG3089769@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204015700.GG3089769@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 05:57:00PM -0800, Guenter Roeck wrote:
> That line of argument would suggest that we should perform parameter checks
> on each function entry all over the place, no matter if the range is known
> to be valid or not. Maybe that is the way things are going, but I don't
> like it at all. I have seen that kind of code before, in the telco space,
> where it typically at least doubled code size and resulted in mediocre
> performance, just because of a rule that mandated checking all parameters
> at the beginning of each function.

Well, I doubt I'll be able to change your opinion of telco code, but I
do think robustness is not an unreasonable default state for software,
and that GCC and Clang do a pretty good job with optimization, etc.

> I assume this is just one of many many patches you plan to send to add
> parameter checks to similar hwmon code ? I _really_ don't want to have
> the hwmon code cluttered with such unnecessary checks.

I was trying to provide complete coverage inspired by the specific
complaint GCC had, but this would also silence the warning:

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 8d33c2484755..87d2455e721f 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1106,6 +1106,7 @@ static ssize_t pwm_auto_pwm_minctl_store(struct device *dev,
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_off = val;
 	tmp = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
+	nr = clamp_t(int, nr, 0, ARRAY_SIZE(data->autofan) - 1);
 	tmp &= ~(0x20 << nr);
 	if (data->autofan[nr].min_off)
 		tmp |= 0x20 << nr;

What's happening is GCC see that "nr" is used as a shift argument, so it
believes (not unreasonably) that this otherwise unknown value could be
up to 32. Here we can give it the bounded range ahead of time, keeping
it happy.

-- 
Kees Cook
