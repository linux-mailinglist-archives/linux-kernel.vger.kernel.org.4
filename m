Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812D97486B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjGEOoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGEOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:44:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30C019A8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:44:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso69288795e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688568248; x=1691160248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YmKtwavW1ZM/DLIGe88sJoG8P4s5K1xjWW1lgqiHqhQ=;
        b=HkDAkMRTNguX2wXY4lgtObUg9/ZDiVk/Hh0kwMJgW750mtz7FOMz57PUAdEidiL3za
         ivETv74tTqWsMsLSV5ZRqGo8t8KsVSbpywm4Y/E+ivFyuX1aldL9Bl3Kz3zADntgqP5u
         5h870+j/MdaEV6PH5hXFshz/8rGc4ESaoGaNkvVpWw0jyoilr4mWSvfJpPjcwR79rByb
         XlOFmOni5Lh7WIeB9VZygBojFlTM0lDMztRa+8+AqQNznGCxqhiYvUZxgmUq1dIB+7n6
         gUBti9EXH2uBmK+kHF9ZssGbIZ+C4IOYEXyB4Il7McJkEr7V6qPDoehmmu8t0G4T7+LR
         qMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568248; x=1691160248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmKtwavW1ZM/DLIGe88sJoG8P4s5K1xjWW1lgqiHqhQ=;
        b=lMLaSS/jWo904B0XkxyOazp/p65Rf0Ug6mKYSd8PPhUVG4OIxtQDSYXrpFtS55+000
         i3g3sj0hOWdWYyR2NeZV4rd/pYKDv5P2S5c1DPiEuIhib5hxGyGUuMTvwqjbuLtzwcgv
         sDWOlevh+2Ed5hLV0rU2M3bQAvDUcBVxlVSVY4JD/gyzrvCQh//D3WMhpv0AyJcNX5Jc
         h5bE29cT5R/5vpUZcdl0YTPClCy4PenJ87tRhDE1HbZ56KQDdHqzJmoMg0De86uM81bo
         ZqrIdeysOYbKr5g4gGyobdZAWdNo8QsqcQ9z4SeSyN5nHgz+f6QuFd1+4nghgkoly4Qg
         Ii2g==
X-Gm-Message-State: ABy/qLbxkz8suK0m402nDMkF+E0QKOT7RtOAgIQ3If5BzXGMO6nFmrNc
        osyglxi67NMyVZZs35HSp7ZWCg==
X-Google-Smtp-Source: APBJJlECxIHZ1/nuhSbjtKSOWFbIVTOW/tFGCk0wGrvxbMvkpR32UFyVPy1XTc9iu8ZGmCrUUpXLIA==
X-Received: by 2002:a05:600c:3785:b0:3fb:dd9c:72d2 with SMTP id o5-20020a05600c378500b003fbdd9c72d2mr5832003wmr.31.1688568248299;
        Wed, 05 Jul 2023 07:44:08 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003fbd04ecdc6sm2370816wml.5.2023.07.05.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:44:07 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:44:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
Message-ID: <20230705144406.GA9021@aspen.lan>
References: <20230705142447.15546-1-mans@mansr.com>
 <20230705143320.GE6265@aspen.lan>
 <yw1xjzvezapt.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xjzvezapt.fsf@mansr.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:36:46PM +0100, Måns Rullgård wrote:
> Daniel Thompson <daniel.thompson@linaro.org> writes:
>
> > On Wed, Jul 05, 2023 at 03:24:14PM +0100, Mans Rullgard wrote:
> >> The condition for the initial power state based on the default
> >> brightness value is reversed.  Fix it.
> >>
> >> Furthermore, use the actual state of the LEDs rather than the default
> >> brightness specified in the devicetree as the latter should not cause
> >> the backlight to be automatically turned on.
> >>
> >> If the backlight device is not linked to any display, set the initial
> >> power to on unconditionally.
> >>
> >> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> ---
> >> Changes in v3:
> >> - Add comment
> >
> > This mismatches the subject line ;-) but I can live with that if Lee
> > and Jingoo can!
>
> Does it not fix it?  If you think the subject is misleading, feel free
> to change it.

The bit that goes into version control is fine!

However without '[PATCH v3]' on the subject line for the initial patch
there is a risk this thread will get overlooked and not queued[1].


Daniel.


[1] Just to be clear, Lee J. typically hoovers up the backlight patches
    and sends the PR. I only queue backlight patches myself as holiday
    cover...
