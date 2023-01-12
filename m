Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44929667DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjALSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbjALSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:17:53 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B9D7148A;
        Thu, 12 Jan 2023 09:47:13 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a02:8440:d20f:6de0:6125:d027:2017:9d97])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 0B0F519F59E;
        Thu, 12 Jan 2023 18:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1673545631;
        bh=KRTPZlKd33p2jA5AfUXMRlfCbedKs4GMu6pgnM4y4Qo=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=LctVqhCykYrI8EvXeqUmUdArGNK/b6sZcJ0gtvgPgfxfckye4plPdcS9NoAVKI7ya
         +OuDsuuF1zEN2T6xCaKeWWVNYOB0hsY5QWeDseR4wMcwypp6ocReR+eShxR7Tn5nAZ
         Ufw1bfs5KavS1JtsBALOpAasZvUcCYSVZBr5CRr/gIpWIYd1aDgoywyutwO3O20sH5
         /0Nwd4W/cm8SSndULierf0N+0aujwJO0K/OH7wn8eJtMgEnMJffLWHTvy94+7kx3Ie
         RDFaxi9Ee4NeCA6M3Qk5O/EZiFYqWMlnc3k/vIrnGVtjWeFF1dX/rXG9L9x5gqdwv/
         qwjMqYBvKHKJA==
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-5-arnd@kernel.org> <m2sfglh02h.fsf@free.fr>
 <2d085660-41a2-492c-a343-7df80d510a59@app.fastmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 04/27] ARM: pxa: drop pxa310/pxa320/pxa93x support
Date:   Thu, 12 Jan 2023 18:37:32 +0100
In-reply-to: <2d085660-41a2-492c-a343-7df80d510a59@app.fastmail.com>
Message-ID: <m2k01rhchf.fsf@free.fr>
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


"Arnd Bergmann" <arnd@arndb.de> writes:

> Hi Robert,
Hi Arnd,

> Thanks for pointing this out, I thought that I had caught
> all the missing dependencies ones after you pointed out
> the AC97_BUS_NEW that I fixed in patch 14.
Sorry I've not seen this one in my previous review.

> From what I can tell, commit b5aaaa666a85 ("ARM: pxa: add
> Kconfig dependencies for ATAGS based boards"), the
> PXA310/PXA320 DT support became dead code because
> MACH_PXA3XX_DT only selects CPU_PXA300, so if it worked
> before that commit, it now needs CONFIG_UNUSED_BOARD_FILES
> and CONFIG_EXPERT as well as enabling one of the legacy
> board files with the corresponding chip support.
>
> If that's all you think is missing, I can add this
> trivial patch as well and rework the series to not
> drop code that depends on PXA310/PXA320:
Yes, that would be great !

> Can you have a look at the other patches to see if there
> are more removed drivers or platform bits that are currently
> dead code but are actually required?
Yes, I've been through your whole serie and that's the
last thing I have identified. I've read carefully all the
patches now, and the whole serie looks good to me.

So with this patch and keeping the clocks and cpufreq
parts for pxa3*0, you can add everywhere my :

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
