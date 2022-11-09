Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72988622539
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKIIVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIIVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:21:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525191CFD5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:20:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so719533wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQTh+h4wAo4t46Rl+wdOIR7scWoK1pkYjOSDztAOvMk=;
        b=Cpek1q7QSMGXU1gFGsylqWYf0SzpoFAOnziq+0yCk/hPO0U0Xq2kq0DUIJhaSedm3O
         Jol89RRWCiZVRDnFZ/3Odn+y0+oQULQZ4SZh/JYYpFmkt8YPDvvQRSPFMgWtOjxHI4rQ
         pn4K+rQ4VIE7wTJxowiODzKlxgs/+S6PdIRt9mNzyqSq9+lEK6aeyjYrK+16bpfykehg
         +Ag+15KKt5KlviWRBZQh1SC00aHih4RA1FJZ+4Ex0k0dFQsxtWGtjuCVZoLWpcsCv6yw
         4ViyYZVhGSKO/q+v/ZQ+tapEmWuBLH8xHWRfL64tgbCSDpxJeE6xqiCauPfGbW0T8A30
         sdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQTh+h4wAo4t46Rl+wdOIR7scWoK1pkYjOSDztAOvMk=;
        b=brlJXZS4X0ueyRBRitL9zl2v3u2Icu5jy3ilN4ZY01NcHEKCIsL0ej0+Le0J7TebLA
         6+8bLvl8uG9bfQVkGy9jIjzKgeEw00k3aKdb4VQe7fuNvogBrAVKdHvh9Q+gU7wi9kEb
         /L5SMJVyG3OR73iknTXy7RFSaP9BicpNMuAVGos9SJ89yeyie/F/Ai7Hq7N3Vaa1XVYe
         mKxUzwaOXJ2ll8cgjLBP2ZxzA1g0N+z5Cc/C6SDrPBQMvvdwTCuQtpFp59mcsBk6Ihjz
         t3WA6t2BmQuv0PYyRoqnES6/pwRF2/cjMScGebIUJQ8miaESxZhkhuJgfV07E6FzSKuh
         dHZQ==
X-Gm-Message-State: ACrzQf3yK3V7ja8OvBt4ZPtOZ6J5HGnBDiTcjAeP/44fWEGGl7tz+X2k
        p52Ul7KGhkbfYtpnRl0mgVn5gmfy0+PuzQ==
X-Google-Smtp-Source: AMsMyM7a3muG+xctXMNmA6t/4RK9t8xXwL/BnJxGkPaozlKTl4ulPc+VWNiTqriOd50k7tssbwBdJg==
X-Received: by 2002:a1c:7704:0:b0:3c4:bda1:7c57 with SMTP id t4-20020a1c7704000000b003c4bda17c57mr866812wmi.6.1667982057803;
        Wed, 09 Nov 2022 00:20:57 -0800 (PST)
Received: from ash.lan ([167.98.0.196])
        by smtp.gmail.com with ESMTPSA id n22-20020a1c7216000000b003a6125562e1sm699068wmc.46.2022.11.09.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:20:57 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:20:55 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 02/40] serial: kgdboc: Lock console list in
 probe function
Message-ID: <20221109082055.melzih2jwhwjztam@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:00PM +0106, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Unprotected list walks are not necessarily safe.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
