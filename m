Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB0647FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiLII6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLII6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:58:11 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D382C4876E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:58:09 -0800 (PST)
Received: from sopl295-1.home (unknown [IPv6:2a01:cb19:8d70:d500:6d47:7868:523:4848])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 7925FB0055A;
        Fri,  9 Dec 2022 09:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1670576288;
        bh=oRefIkAOXaxlM+bT0sR8pPl0+u4qpNREsz38vn7WHa8=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=RPv/uX2dNIKGvFFvNU6I1/8oSaOePqh3z0IbJxv/rb73w+y5q4/X/6i0SXkPqYeG0
         2ziZ7pyEbWDaiKuo6DKB9Or04quHsdFyni60J4W4+uLN0MnderyhXgLJWDfYqm9/97
         mUwicQIzh5IuA+wA/MryWxAOrPciElB72FY7s62Ig7NqfYnePSkJ4Sl1BHe33MT86g
         HMprOaXwkvQ3rOHgDT5DbOKsu1pNTB2qv91DfRgBJmT65D5Xow/aK6TPGZEmhBko4U
         RgmG1oa7oYZq46o1UmQ4ZpLX82yk1FdR34u6f8WY2K2xfqbKxaRMi1ncWR0gcevpYc
         g0+bTV+wJsJiw==
References: <Y5B4QeNMNboJ42n4@probook> <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk> <Y5DDCmXnamC6Zikx@probook>
 <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk> <Y5IulKoRctcrWBzl@probook>
 <m2wn71emze.fsf@sopl295-1.home> <Y5I2oQexHNdlIbsQ@shell.armlinux.org.uk>
 <m2pmcteilg.fsf@sopl295-1.home> <Y5JlQLe+3la2XPZw@shell.armlinux.org.uk>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Jonathan =?utf-8?Q?Neusch?= =?utf-8?Q?=C3=A4fer?= 
        <j.neuschaefer@gmx.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Date:   Fri, 09 Dec 2022 09:55:41 +0100
In-reply-to: <Y5JlQLe+3la2XPZw@shell.armlinux.org.uk>
Message-ID: <m2lenhdkdk.fsf@sopl295-1.home>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> Does the GPIO driver talk to the pinctrl driver to switch GPIOs 
> between
> input and output mode? If it does, that's fine. If not, that can 
> cause
> regressions, as GPIOs may need to be switched between input and 
> output
> mode at runtime (e.g. for I2C gpio-based bitbang).

It does.
Basically it tries pinctrl first, and falls back to direct 
registers
access. Here is a small extract of the gpio direction manipulation 
in
gpio-pxa.c :
	if (pxa_gpio_has_pinctrl()) {
		ret = pinctrl_gpio_direction_output(chip->base + 
		offset);
		if (ret)
			return ret;
	}

	spin_lock_irqsave(&gpio_lock, flags);

	tmp = readl_relaxed(base + GPDR_OFFSET);
        ... blablabal we set the bit, and write back the register.

Cheers.

--
Robert
