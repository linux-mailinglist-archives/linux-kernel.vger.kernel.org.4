Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3675B60C0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiJYBSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJYBRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:17:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626851DDE2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:37:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y69so15020123ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPe/RMLbUY4CuSM7GCQGLirlVS+xcFvAA0teuuPRF5Q=;
        b=OyZEHkKgw9pJonxe/apcVlx8t/OatQWcG++lFP2RH/sgR7udHA3ave3qg6yhSyv8ts
         9P8tWQVY3ZO99ez5CIYNXXDcSjK4+nWK+99p8jGTGisyAe1UeAfrqntujEiWBP+HSzUR
         mUl37+uoGw+MhlNyTQ55QbmuDGjT/rVhABIkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPe/RMLbUY4CuSM7GCQGLirlVS+xcFvAA0teuuPRF5Q=;
        b=LLL3r0YwJ0pV7O7kusi2GMIFPzFnqC16v9U2kjWhzFvPwQo6sWuTU33zSZHLEiuKyH
         S+vwz1de5DU6cc70OPlEY8zdpvNobgwWjR8ynOV86M0Iq98mKcabGJOsA+O0D4belNo6
         u1NeqmniMMOwZ+LIjZ47jIbX3DYAFNy6FiPTA2nwnFncPIPvuy9WwtaGjm1ZFr0s86nQ
         M6gp0mZyfWH2K9d5VefWmBhF8cqFdlXXnZ0MILje9HihFJHPfi8qbeJ2s0xgDYi/r1Sk
         vrFAHkVBxgHtGxo8Wj88TMdB44364LMRnetZZ5lKCYqw91npMKuec69MPfFv1rhAU4h0
         0u2w==
X-Gm-Message-State: ACrzQf3/KJbkK51toZDo7Gz5qkEYOJprBIre5Ger6FRZI+LwRDZyaAHw
        QjckgtDIM8EFn3x2eLLS9BzBElYRSi756dhm
X-Google-Smtp-Source: AMsMyM73sAFoUCdkWMy5w/nUdNsD+pqpk2/uOyzkJUI+VsOB6Wbv8kmrXDJ2Q7j++XkEKY89ns1s4A==
X-Received: by 2002:a05:6402:f1e:b0:461:cfd3:48c2 with SMTP id i30-20020a0564020f1e00b00461cfd348c2mr6186698eda.294.1666658232758;
        Mon, 24 Oct 2022 17:37:12 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7c415000000b00461a98a2128sm638330edq.26.2022.10.24.17.37.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:37:12 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id a14so15690934wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:37:11 -0700 (PDT)
X-Received: by 2002:adf:f641:0:b0:236:737f:8e00 with SMTP id
 x1-20020adff641000000b00236737f8e00mr4375266wrp.659.1666658231649; Mon, 24
 Oct 2022 17:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-23-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-23-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:36:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYa2SEFkARyHqJFLt4vBfC9zzdnRZeaXGoa-aGtPVRiQ@mail.gmail.com>
Message-ID: <CAD=FV=WYa2SEFkARyHqJFLt4vBfC9zzdnRZeaXGoa-aGtPVRiQ@mail.gmail.com>
Subject: Re: [PATCH printk v2 22/38] serial: kgdboc: document console_lock usage
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. This is necessary
> because the trapping of the exit() callback assumes that the exit()
> callback is not called before the trap is setup.
>
> Explicitly document this non-typical console_lock usage.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/kgdboc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
