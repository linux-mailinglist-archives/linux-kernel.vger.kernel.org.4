Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3E63EEA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiLALBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiLALAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:00:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FA595834;
        Thu,  1 Dec 2022 03:00:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669892400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Om5N0s4B2FUVk6Ry2QAemVUJaBFa987K7pOQVeswR6k=;
        b=vWHJ8xp7Q8TBhn/eA8NGmaPQZ6QRX+mfGVgrDb+xHWWTDYmnCubxFiwqbWYjmV/3QJqnf7
        xk52pHEIwrQyYYi5Ord61xQdMeqXMqGf5hMM3ZPFHKvbeiss1EnVeDJyTaJkMjyFvVkyX9
        RslOOxr28V22oIhLEh+7ZGGwPbiDWBGmStvq0HarPWsD5bG1aslHvwYXYWU2KGtFlRGeng
        Pl7OqI789qelw90heZUDwtyJD1mDWUxPrCK8jK0784nLSwicRkn/vrXGhyV0hggc1fW6ww
        spdv249uMbQ2hsf3YIRbEd86Bg+/R+8jLuiCiOUVxMhBqc/fLCJaUAwzvKlheg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669892400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Om5N0s4B2FUVk6Ry2QAemVUJaBFa987K7pOQVeswR6k=;
        b=9x50JG1qBk6pMvZqd4CzU8ELiVR1vMkWQvm0uz9qk8vPIiKDXDKpU8zS+0bFHeaZI+YgP7
        DjrqtZ0B3cqiXTDg==
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2] clocksource: ingenic-ost: define pm functions
 properly in platform_driver struct
In-Reply-To: <20221123083159.22821-1-lukas.bulwahn@gmail.com>
References: <20221123083159.22821-1-lukas.bulwahn@gmail.com>
Date:   Thu, 01 Dec 2022 12:00:00 +0100
Message-ID: <87mt87s827.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas!

On Wed, Nov 23 2022 at 09:31, Lukas Bulwahn wrote:
> Commit ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx OST")
> adds the struct platform_driver ingenic_ost_driver, with the definition of
> pm functions under the non-existing config PM_SUSPEND, which means the
> intended pm functions were never actually included in any build.
>
> As the only callbacks are .suspend_noirq and .resume_noirq, we can assume
> that it is intended to be CONFIG_PM_SLEEP.
>
> Since commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate
> old ones"), the default pattern for platform_driver definitions
> conditional for CONFIG_PM_SLEEP is to use pm_sleep_ptr().
>
> As __maybe_unused annotations on the dev_pm_ops structure and its callbacks
> are not needed anymore, remove these as well.
>
> Suggested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

just a minor nit. The subsystem prefix should be:

     clocksource/drivers/ingenic-ost:

git log --one-line $FILE is usually a good hint for the subsystem
specific prefix choice.

Fixed it up while applying.

Thanks,

        tglx
