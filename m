Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3562C8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiKPTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKPTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:07:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4422F6316A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:07:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so4329461pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5/L9gx7uHlkg6YvQqykA2KOy2JRTFm3MWwwROT0O+M=;
        b=qmsaZBsJQK2yABkO2BV73dp+CBmYwcdsg3ddxCxsumfdNAkXPkdXO5BIUQJuGzY4XC
         8VH1kPmwWqCK7BlD1OYgbBC9xoJnrXcdRUvZWC3XGqtK0dJ2OsH9ctEryLi2fq/v3Arj
         asmnkttcNzPtDXYU36nYEeo3sBK0wP+3sa18sTp1NpNptQ0iDm0hYwOlKeMq5q6C4XHu
         dgbY0oBxpbvRzjXzMM8YVThPQIbZl9ZydL+E4celtTvupzjMUHCpcVRkSxxRf1JBtCSU
         a5pUMM6CSOKgaYhBfuXzpo2vFz9oESDNJatJITLchdKKyPZ7+faH9ugwHqUFSOel+LSW
         V5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5/L9gx7uHlkg6YvQqykA2KOy2JRTFm3MWwwROT0O+M=;
        b=tQl1wKheEymF3tBB4e/+z7ffuKXvqyinC9iF6lgMcmWwrsqW5nV57GC05E4kLeQmJF
         EmWHDw7qck30nihIgg3Jb/CG/2YugQE/bgeszspIFk9Y+O5yCTBWVo/Oa1FRn9rdaWIQ
         Ag3vtH6URnwXfmVz6LP+yE7Q6OKFMwezOZJoVqBMljgmrsnDgg5oS81RfeDZWIqGsOMO
         3MrLf3orPl1s35u3hQFUAB/THWEEpDWxwZAdz7Fen9pxx04cNY+mzTIO+Q9ZEHyOlsWZ
         rbepxWoEnOlUvVmaKFOEW6M51QoNaKyEZSfVYDGYQwSRBcF4ylU71hV231wJDqgN8JGp
         cZHQ==
X-Gm-Message-State: ANoB5pkQ7AK2wvudPnaqmPPnrCj/Y8IylnkRWhqvWL4D1vByOH0PNlHk
        joWe/hOLye/fhzCsyEpaLyA=
X-Google-Smtp-Source: AA0mqf5+bG9sEnMKP+9HajB56aaLXTQEP1UCjd6GRZbgnz6tt4861Uimqb2SYZgf0JkD6zXcvXK6Wg==
X-Received: by 2002:a17:902:8608:b0:186:61a7:ae94 with SMTP id f8-20020a170902860800b0018661a7ae94mr10206904plo.2.1668625672521;
        Wed, 16 Nov 2022 11:07:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb51:2ecd:7287:8649])
        by smtp.gmail.com with ESMTPSA id o1-20020aa79781000000b0056ba02feda1sm11513152pfp.94.2022.11.16.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:07:51 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:07:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/11] ASoC: ak5386: switch to using gpiod API
Message-ID: <Y3U1BJAPOJTLw/Zb@google.com>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
 <Y3S9KzTE1/UQDmJl@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3S9KzTE1/UQDmJl@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:36:27AM +0000, Mark Brown wrote:
> On Tue, Nov 15, 2022 at 09:38:07PM -0800, Dmitry Torokhov wrote:
> 
> > Switch the driver from legacy gpio API that is deprecated to the newer
> > gpiod API that respects line polarities described in ACPI/DT.
> 
> > -	if (gpio_is_valid(priv->reset_gpio))
> > -		gpio_set_value(priv->reset_gpio, 1);
> > +	if (priv->reset_gpio)
> > +		gpiod_set_value(priv->reset_gpio, 0);
> 
> How are we ensuring that people have described signals as active
> low/high in existing DTs, and are we positive that the signal is
> described as active low for all devices?  In particular if the
> signal is described as a reset signal then it's active high even
> if we want it low while the device is actually in use.

I have been going through in-kernel DTSes and adjusting ones that are
incorrect. For external ones I think we should take a pragmatic approach
and say that if driver has last non-mechanical update in 2014 and there
are no users submitted to mainline since then (as this one), then it is
highly unlikely that devices currently using this component/codec will
be updated to the 6.2+ kernel even if they are still in service. And if
this does happen the breakage will be immediately obvious as we'll keep
the codec in reset state.

But if you really want to I can add quirk(s) to gpiolib forcing this
line to be treated as active-low regardless of what specified in DTS.
This kind of negates benefit of going to gpiod though.

Please let me know.

-- 
Dmitry
