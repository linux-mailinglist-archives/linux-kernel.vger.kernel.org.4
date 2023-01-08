Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9628661439
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjAHJBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 04:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjAHJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 04:01:47 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46527BC26;
        Sun,  8 Jan 2023 01:01:46 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a01:e0a:a6a:5f90:5959:63b1:9783:3e26])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 1B45A13F87E;
        Sun,  8 Jan 2023 10:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1673168504;
        bh=jN07y0o4PEKT+hhbGgEcvZdsd+ibKgA08wW81JoUNZc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=ifwFeaaqAL0DtcSDhmdxYoKbxgn7RL5akTq+jbOkcYPa63wTJpMeFU6rtLu35fH19
         Z87Mt/9UuWXDpcY4dHlXP6E8YZSaRRIo/lFdceyVxXJ+2sQGfHP3kXxHaY1zS/1w/8
         c+wfslIBoPsit+xrsR61Z1SeeqE6weDcHoBv2kOe7SuMcEWHd2jPYGWEqljsj6n8TR
         7wFQb7NpB+6S4r3Zxf5izc4bkESQwLua6rpX4q80OGW5iHsc6h3qZWyYjWNY9mALuh
         Azwl0H3U5ucIylDrJW09TAFFmeE1rQIKEytClw4kgPoiSrobm+yfWSs5ILoACwQl55
         PLjDeBmsZFbhw==
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-5-arnd@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 04/27] ARM: pxa: drop pxa310/pxa320/pxa93x support
Date:   Sun, 08 Jan 2023 09:49:17 +0100
In-reply-to: <20230105134622.254560-5-arnd@kernel.org>
Message-ID: <m2sfglh02h.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd Bergmann <arnd@kernel.org> writes:
> There is currently no devicetree support for any of these three
> SoCs, and no board files remain. As it seems unlikely that 
> anyone
> is going to add DT support soon, let's drop the SoC specific 
> code
> now.

Hi Arnd,

Here you're dropping pxa variant support. For the currently 
"partly" working
boards in devicetree, such a zylonite, this will break their 
current support.

For example the zylonite I have which is working on DT has a 
pxa310 variant.
The cm-x300, which also works in DT, has a pxa320 variant.

What these boards need is their IO mappings and cpufreq to still 
work after
your serie in DT. What bothers me are the changes to :
 - drivers/clk/pxa/clk-pxa3xx.c
 - drivers/cpufreq/pxa3xx-cpufreq.c

Here the clock changes will probably remove the clock provided to 
specific
pxa310/pxa320 drivers for example.

I don't know how you want to proceed, yet this change will break 
some pxa3xx
platforms.

Cheers.

--
Robert
