Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6235B656545
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiLZWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZWK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:10:58 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D9EA3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:10:57 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-144bd860fdbso13838820fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNDSLgzAWMyKm1B2Ru82U5Y+ProfcfDEihjnTp0Xp+I=;
        b=gjF8V1rbZkjCk/70jX5AoBt1Vp2ptjCicA6/WoL+PmdAXzkKHcOOmaHP26PyzDnUby
         ZszRpgUA3XDbvRy0N6KHgbh2A2AvemzyOGwvJIQJMfnPKxQLHNoQyz/9CScYFnGR1uM7
         xrqZHMdT8oPp5gQm0knMzBsO3zkltw2IHj4F02GpQYmU2hlNHwpDyGHpnnoa1d5VgipJ
         DVmlkowun60QfJ1Y0as1lERFJChsQtTIy+hqsWQrIU2p2g3uB0fRnitadAKB0faJKQg3
         VQrWaoFNdwr9X8BzWa1Mvt4frdCrqh6KbljHVw6js1/49T7OM8ok2rJgqCKNkWFellTs
         1GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNDSLgzAWMyKm1B2Ru82U5Y+ProfcfDEihjnTp0Xp+I=;
        b=B9l4967OaaHNv5IqBKi0B1OgUm6bx7OLFGOaHNUXPKJG8lopSjYud9RGmWu3ig1aFc
         Nwek0xX3kaulQdag10xzLjEDvV9RYlgly+HYwngJUjSqQj+14Yt5E7zWUSrQRYeZ08oH
         foIQIxOWJiY0Fhrrzr5sjfFD3mDOn1z4559op55WGdk/yFqE2YUWvwb/iTBfpRuBXTjH
         z5Q4Vd15uVxUq87dhZl3kaEIY0qKaT0jSX0EIQDwYaRroNiiv+W6zmKTj1T7J2dcqoav
         tSGp8nFnJsfwDBuq6Gf0WRDg1vubzrtteLdAOe3kgs0RrxBBL6jS/e4NmJq+f4y4u+gw
         QF/g==
X-Gm-Message-State: AFqh2kooBjagyPM/hzcXp1097hgkSIXS6bwmfYX3w6Gc8FXDPHlP5hhZ
        0tZXynuj6R0U/vIWWr408Iw=
X-Google-Smtp-Source: AMrXdXv+jjBWA/FGjJLxZ42EKz90NTZFum83Y5hSOUEbReaoF/xqixHYvK1Hh2XqSz6WCqAO5YniBg==
X-Received: by 2002:a05:6870:7d0a:b0:148:53c7:c51b with SMTP id os10-20020a0568707d0a00b0014853c7c51bmr16556846oab.34.1672092656678;
        Mon, 26 Dec 2022 14:10:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15-20020a05687073cf00b00144bb1013e6sm5443749oan.4.2022.12.26.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:10:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Dec 2022 14:10:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <kees@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20221226221054.GB2629353@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
 <CAHk-=whD1zMyt4c7g6-+tWvVweyb-6oHMT_+ZVHqe1EXwtFpCQ@mail.gmail.com>
 <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA632860-284E-4923-8863-9D2745DD289E@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 01:03:59PM -0800, Kees Cook wrote:
> >>
> >> ...
> >> [   18.494320]     ok 2 memcpy_test
> >> [   52.969037]     ok 3 memcpy_large_test
> >> ...
> >> [   52.974505]     ok 4 memmove_test
> >> [   87.325400]     ok 5 memmove_large_test
> >> [  143.562760] INFO: task swapper/0:1 blocked for more than 46 seconds.
[ ... ]
> >>
> >> That is too much for my test bed. I dropped this test as result. This means
> >> that extending the tests has, at least in the context of my testing, the
> >> opposite effect.
> >
> >Kees? This indeed seems counter-productive..
> 
> Hrm, that is not supposed to take THAT long... But yes a cross-arxh qemu run would be slow. :(
> 
> The changes there were to help find any future memcpy problem (like seen while porting the i386 memcpy asm...) I'll try to get this reduced. Dropping the test isn't so great. :)
> 

Would it be possible to hide the expensive tests behind an extra Kconfig
option ?

Thanks,
Guenter
