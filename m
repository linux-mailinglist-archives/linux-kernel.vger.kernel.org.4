Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E916D35AA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 07:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDBFvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 01:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBFvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 01:51:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1AFF0A;
        Sat,  1 Apr 2023 22:51:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so27488447pjl.4;
        Sat, 01 Apr 2023 22:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680414673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioqX/+yVEIXU3d6d/36shXJp6gmpkhNyRGnBaYRSPfI=;
        b=lgbI9oh8iY/Kubtg2gwmeHkvaooPXJn0TRcAUdB8UpoqALG88Jupv7nZuaepHUNlLd
         IXdm6wjUPzKVv/cOL3uXscYVBV6TRZKSecb5wBV+ZykpTpYaLpp9FHFbnQfr8U4m0DOX
         U49f+Ug/jyp9HTgeTFhBPWYd7lugZUPeHEH1cHxUOZz48nCjptNdYKVlE3fpyYY9PEmz
         v7r4sUAVQAZZCa2go7kHsioTfC1tDEx42VF985xtaowfKmWwuplvbvUmeIcj4i2Bu+4W
         1ahuiSgcBJaSMA/zi8rqs4IqdwX7OZ2nSiuT2FCFiP27T9booDpGsHYc1xlQNRfGgW6B
         HzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680414673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioqX/+yVEIXU3d6d/36shXJp6gmpkhNyRGnBaYRSPfI=;
        b=73sSmrj9Xuz1ZemDVRGrI0sKqm88/+VYnjZZz+W34E64O0etFqfrS/AZUe2vT11VLe
         EypfO0NLNiGrG6xFL3DdjagoYpxSUYvAhR8VagRu+7+yL7ftuXrlllHYFTji7WGIKPgL
         Z2Z30bEfMNENP9PX12bItvILssxlQmKJILe0mXloMjKUUaIyk3irSYdgtfxWu1uOd/jF
         aaUHwPQotW1lHLzCN5rfwHuDmhfG5CsYays2rtIbIJZLWZ6wmUbZxPub8QASnWJvBn00
         Inw+Dme7KyXk2Byl0Psb7sd/jelSe2pgpAGjrb2nSyzvOpAHHDqZmpT2PHZI8tYwF77x
         a6fQ==
X-Gm-Message-State: AAQBX9dSq03qvswj4/s9fUWtuBYy8iJ4NqZsKCY3dDS1mdMyKgph8CoU
        68jT2cN1P82yvU01svKMQhQ=
X-Google-Smtp-Source: AKy350bsQz0+JUQ+kISa5Ldkmd+jCPIZn5GQ+FoyGYzGlSXe/b8ImMJUsKJEYLT73CidzTSKAwWK9w==
X-Received: by 2002:a17:902:d4c8:b0:1a1:ce05:9ba with SMTP id o8-20020a170902d4c800b001a1ce0509bamr42625577plg.52.1680414673012;
        Sat, 01 Apr 2023 22:51:13 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9a1d:5e0:d8f3:bc01])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b00198b01b412csm4158999plq.303.2023.04.01.22.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 22:51:12 -0700 (PDT)
Date:   Sat, 1 Apr 2023 22:51:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     hns@goldelico.com, richard.leitner@linux.dev,
        christophe.jaillet@wanadoo.fr, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v4] Input: tsc2007 - enable cansleep pendown GPIO
Message-ID: <ZCkXzQ38N44Y7H+I@google.com>
References: <20230328-tsc2007-sleep-v4-1-2ede92ec9b71@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328-tsc2007-sleep-v4-1-2ede92ec9b71@skidata.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Mar 30, 2023 at 09:10:37PM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> When a hard IRQ is triggered, the soft IRQ, which decides if an actual
> pen down happened, should always be triggered. This enables the usage of
> "can_sleep" GPIO chips as "pen down" GPIO, as the value is not read
> during the hard IRQ anymore. This might be the case if the GPIO chip is
> an expander behind i2c.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
> Hi!
> 
> I found a different approach to my problem:
> If the primary IRQ handler is set to NULL, the default primary IRQ
> handler simply triggers a soft IRQ handler wake up. As the hard IRQ is
> only triggered when a pen down is detected, the gpiod_get_value() inside
> tsc2007_is_pen_down() always returns true and therefore can be
> neglected.

Don't you need to switch to gpio_get_valued_cansleep() in
tsc2007_is_pen_down() to actually allow sleeping gpios?

Thanks.

-- 
Dmitry
