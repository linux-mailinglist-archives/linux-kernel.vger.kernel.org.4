Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0D60B62A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiJXStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiJXSsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:48:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9B8BB99
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:29:47 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1omxzm-0001Lg-Qs; Mon, 24 Oct 2022 16:00:02 +0200
Message-ID: <ed50cdff-8fd2-6714-9b0b-1ce47a5c9d37@pengutronix.de>
Date:   Mon, 24 Oct 2022 16:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <814496ae-4007-9a4e-0466-a0386aec6316@rasmusvillemoes.dk>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <814496ae-4007-9a4e-0466-a0386aec6316@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rasmus,

On 24.10.22 15:48, Rasmus Villemoes wrote:
> On 28/09/2022 14.41, Rasmus Villemoes wrote:
>> We have an imx8mp-based board with an external gpio-triggered
>> watchdog. Currently, we don't get to handle that in time before it
>> resets the board.
>>
>> The probe of the watchdog device gets deferred because the SOC's GPIO
>> controller is not yet ready, and the probe of that in turn gets deferred
>> because its clock provider (namely, this driver) is not yet
>> ready. Altogether, the watchdog does not get handled until the late
>> initcall deferred_probe_initcall has made sure all leftover devices
>> have been probed, and that's way too late.
>>
>> Aside from being necessary for our board, this also reduces total boot
>> time because fewer device probes get deferred.
> 
> ping

Module build is unaffected, because arch_initcall expands to module_init
if it's built as a module, right? Noting that in the commit message would
be good I think.

Also, did you try booting with fw_devlink=on? This should have resolved
your issue too. Not sure what other issues it may cause on i.MX8MP.

Cheers,
Ahmad

> 
> Rasmus
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
