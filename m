Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EE622540
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKIIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKIIXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:23:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8F5FD6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:23:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p16so10277745wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aYtp8rKKFj6AMeEh8TgKPoMz3+QrQuPeMrc+lG2dC4=;
        b=CgVAeDwHGGqjX9pPwdf50j6laHJDZQEpjWOLA+xKGBUAg7h+8blHA3XYE+A4H6hy1I
         +1dKSYtKGZUuAl+U9Z0WfHgdyBZUvv9EzmvnG1ytRtExRhNWemLhbSmYN7VfeAGhepYx
         U7rN1/9hE5+K+sGZigDzLFL7ujbKcztqQxkyIAxYSeQCEq2CWvKXsIfVZ+dzQwytVxHm
         /enmgz1Fm6oegStPmknZqLuUrCtU4jyv1J+g+ubkBgU15W01xBdlc31YPr08Z+nBt3Mh
         umPmuVYBzhjNej5bjPy6kldig6wZnM02W4P2ZIMdQO5MXwK4fBQcYQSJ9CeltH8XObBN
         aWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aYtp8rKKFj6AMeEh8TgKPoMz3+QrQuPeMrc+lG2dC4=;
        b=5i1m/jtKBXjDVdFjm2AXPhjntUm8WMx9mPVOH4rblDEFzuFTQINYKzosMRvK31oOaw
         2/gjToQN3/Pu5l02Vj7ZucGmFpcWaH3iloA4b+kD9KIdB/1S+TGUM0bmEPHoWkUVhFna
         UExB3FyrNmRiCC/uYlHTBtlna+tp+kznAq7nQf/h5sMTeJe7hFJ9Oou6fZQzJR2eFlh5
         UtHriPcrylvS2/UH0EFBUssOItUf4RrQOktaSG1lbSQm9ytJ6L2kFdqqdsh05nYYgClg
         eOBHCq5+5wf8jtn6wrX/dvj26UVZw2GNHGT1CSkfA3Qb/o4XxFABmHb4ilg+L5BDp9g4
         GJOg==
X-Gm-Message-State: ACrzQf2Yhb3JGesLoYGH0ugRVWLYy0lNjzbBmqU5/TbYgaugBmJlgB8a
        K2rbyF31Xs1PWa9mJoiJXZWHTw==
X-Google-Smtp-Source: AMsMyM7BZMkF3omfYJ0Pcs634CeYkMyiilQRZafhDBqMckyxB1fq4QFZDXT0nt9VVI7CEIw/1HMRhg==
X-Received: by 2002:a7b:c7d1:0:b0:3cf:6b10:ca8d with SMTP id z17-20020a7bc7d1000000b003cf6b10ca8dmr873390wmk.44.1667982228087;
        Wed, 09 Nov 2022 00:23:48 -0800 (PST)
Received: from ash.lan ([167.98.0.196])
        by smtp.gmail.com with ESMTPSA id h1-20020adffd41000000b0022da3977ec5sm12408609wrs.113.2022.11.09.00.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:23:47 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:23:46 +0000
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
Subject: Re: [PATCH printk v3 12/40] tty: serial: kgdboc: document
 console_lock usage
Message-ID: <20221109082346.2jtw2i6asli5qohk@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-13-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:10PM +0106, John Ogness wrote:
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. This is necessary
> because the trapping of the exit() callback assumes that the exit()
> callback is not called before the trap is setup.
>
> Explicitly document this non-typical console_lock usage.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
