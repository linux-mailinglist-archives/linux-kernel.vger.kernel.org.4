Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D762D04F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiKQA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbiKQA7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:59:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11BA6A6B9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l11so401806edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=457d9iQgit+Z1EJB0nqQekgVdEZwOgAEMvvOEWPkupI=;
        b=Bh70kUdShhAGETdykikAQJOKTnFptoZPW3kSYZE+AGERi5jQgkT24kHTMqNAWR10tU
         BuAeJQu/Oi7S5Fcd6875vVxSldt7DeCbJfaCEzyokpntEoPmNCfgg0zYiuf//Cx60LbX
         eL07Ybiq3UPZ7/QNaNsuVClF+LzfF5L0ZCzFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=457d9iQgit+Z1EJB0nqQekgVdEZwOgAEMvvOEWPkupI=;
        b=BAaX2D7/i+jounNEz0RG0mMNFTDaD/kCklSdTXpMEHhcTEipwkz6OmWY1AWSpL0ay0
         cf3iDumuqvMqvXyhtI9fnbIuKURTAYMNdaayWDkV6EsFQ3T4fCv6j4yMj0byfuaW4qnL
         Tkue/RSuR0Zk+i8upCH5wVDvddRvTPXJMDEs5g7awCrUFhUj3ZuLiAN9OFdsrTgaPmrP
         VhO/V06XRUruYcIknbwTYlgsoKPEPXOnf7ysZ+6Vb+xU73I5iF037SssFkHlhfOkx+7y
         whONvjRC4guiZ38Xwsl5rmtp9CjGSgiiP6YVz/Jfq04r0GKus8Zxt+2rqblHN2RRQM+9
         GqKA==
X-Gm-Message-State: ANoB5pkwbOgzl3dS8+iQoX5uPJ+F4OxQYeEqGk8mA+imEk3Y+APorMM5
        dh7iTn9xUM9EVM8OtovIKt7hpBoVIV4D3KK8
X-Google-Smtp-Source: AA0mqf6FnKr/gyatQWtdyHZPQ5yap1QIdKDvb60E42qK32wWZrTNHFvXaeodM3eQaFDUgeavskM6EA==
X-Received: by 2002:a05:6402:1386:b0:458:d7b5:9793 with SMTP id b6-20020a056402138600b00458d7b59793mr174803edv.377.1668646778757;
        Wed, 16 Nov 2022 16:59:38 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id ga22-20020a1709070c1600b007aee947ce9esm5932987ejc.138.2022.11.16.16.59.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:59:36 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5so146996wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:35 -0800 (PST)
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id
 ay18-20020a05600c1e1200b003cf9ad3a20emr110075wmb.151.1668646775488; Wed, 16
 Nov 2022 16:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-37-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-37-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:59:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XhkmOLXnfc0YQyUN-FvNeoF1+=zvp56ttaYvsoKESMdA@mail.gmail.com>
Message-ID: <CAD=FV=XhkmOLXnfc0YQyUN-FvNeoF1+=zvp56ttaYvsoKESMdA@mail.gmail.com>
Subject: Re: [PATCH printk v5 36/40] tty: serial: kgdboc: use
 console_list_lock for list traversal
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 8:22 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> configure_kgdboc() uses the console_lock for console list iteration. Use
> the console_list_lock instead because list synchronization responsibility
> will be removed from the console_lock in a later change.
>
> The SRCU iterator could have been used here, but a later change will
> relocate the locking of the console_list_lock to also provide
> synchronization against register_console().
>
> Note, the console_lock is still needed to serialize the device()
> callback with other console operations.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
