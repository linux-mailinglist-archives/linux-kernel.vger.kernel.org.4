Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFA5E7C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiIWNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiIWNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:48:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300571401A5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:48:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so798349wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BUzRP0p1X0Mnqesdqq2xF7++oYvstTmhDzD4eVSQyhg=;
        b=SiXdDxqx+GDrm/8ZjlHEFRVwUyC85IYk9Z52voujerHdnBdPfwJRaa0DdiJC8rWP15
         sUCnMhWfYEbAJYF7Qx8vajCwQUsb8Ct2cAD5j/MYwFoODzUfy5JNawruf401Zte0BoOD
         hvXmcrMPnjdqLor2pwoCfb5LUL7E13Zfe/YuQwtkhR0W2PiqAGLeuqnmwP6iSE1JGfaf
         JnR1U8BEvLK0JG4iDvZVzXm2N+lyfkcmmK2kppo9HAE9zxwMqeZwXf4jLV66B+O8rGpO
         o+MCnTSiWe9fz1L36E/vB9UKlSBrzY6LEqvdgIKKTLzUTKmrQsSHwcDTq9LVbGxb3/Yu
         uVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BUzRP0p1X0Mnqesdqq2xF7++oYvstTmhDzD4eVSQyhg=;
        b=hoiLN0vRVSt0u/QVh91Gd2BR1FvIng2ur+T/QH5Kfn4x/LGcFYKNEkmjfuMjIrqOB7
         nMM+wbF3JEoQWnAjSVOOysvT4RkGNOpFDxfxjApSQqvSFXOHW5K5gIeE3K/rRhqfOBu4
         LNrV2hkpkwuXPCPM8tfmcNIOSmff6xUnMEBSryB+jAgjULQuLKp90WplSthT3KeQDP9K
         DwviAt6AHO9tBIG83rfEQ/DNh2UkNDu21zvbkdMfX7fNcX+tcOdlf2CyCXZ37OYGRWrr
         5Nb8uZjcYV7rDL3EeGyLx1YlD38ABXpf8vPdLFUPuzhTaEyvYP7wHky3zDxIZVneN+p+
         onrQ==
X-Gm-Message-State: ACrzQf2rznMAcQUPV4aSUSF7iwUxWwQoHLf5Cg8bOuZNc4Rzj0Cyseta
        7rwxu9sHaRpysVPB/GXOcM++ZyrpReY7rNjRaOfP4A==
X-Google-Smtp-Source: AMsMyM7PJMK82vyl7ByS7j2Vrx7R/4LVO8mCaCKa5Y2qghQqx/YeAnEjZWnj+fmXqsQ6LcGtZMyUbfqS+mvspNukOkw=
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933c with SMTP id
 fc13-20020a05600c524d00b003b491ee933cmr12517071wmb.100.1663940930533; Fri, 23
 Sep 2022 06:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220923124904.1373936-1-victor.liu@nxp.com>
In-Reply-To: <20220923124904.1373936-1-victor.liu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Sep 2022 15:48:13 +0200
Message-ID: <CAPDyKFqdHX=o4V4K8GdCr4wQ5sjr=JMG6CFAy1849=CtfoSgRQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Return properly from rpm_resume() if
 dev->power.needs_force_resume flag is set
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sept 2022 at 14:47, Liu Ying <victor.liu@nxp.com> wrote:
>
> After a device transitions to sleep state through it's system suspend
> callback pm_runtime_force_suspend(), the device's driver may still try
> to do runtime PM for the device(runtime suspend first and then runtime
> resume) although runtime PM is disabled by that callback.  The runtime
> PM operations would not touch the device effectively and the device is
> assumed to be resumed through it's system resume callback
> pm_runtime_force_resume().

This sounds like a fragile use case to me. In principle you want to
allow the device to be runtime resumed/suspended, after the device has
already been put into a low power state through the regular system
suspend callback. Normally it seems better to prevent this from
happening, completely.

That said, in this case, I wonder if a better option would be to point
->suspend_late() to pm_runtime_force_suspend() and ->resume_early() to
pm_runtime_force_resume(), rather than using the regular
->suspend|resume() callbacks. This should avoid the problem, I think,
no?

Note that, the PM core also disables runtime PM for the device in
__device_suspend_late(). For good reasons.

[...]

Kind regards
Uffe
