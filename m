Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1AB62454A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiKJPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiKJPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:14:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DCC1FCF3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:14:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u24so3509631edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsQlpkhdgjoA/X5gtb5fhKMeMkf7Cp+/JUdRA+xD300=;
        b=AWBQ/Lk+9Z0VtGMU2ft5p9+bz1v7t1R8/QgNao+rXcWJUGcYB0Ov5ugk36ejJ9Ku7/
         Cw8U4yhp2ByRxc6McLCHK/TZixljABaUxNoKLgPVsHeZEnNbhs9mSW60ZV8j5djhB5Gm
         n1v6lqQaaxRdOXZdaU31DJKACREv+RJf7A/6mgM1ckeOH59NgAUQq161I5WiCStnl+wa
         JgWJNOHHprQvQ44WcNBOoeMj83wOLPkYyxAgu0LWbsQ6z8SMkH6BMj/UNMAXJ7+KuZXP
         bNKGkxSvT25Vt0M7CgrTP59V4UCo2DY0CX1D8F9MyPUmuoQ4+4thq8flUYtKNZXGlXJt
         yPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsQlpkhdgjoA/X5gtb5fhKMeMkf7Cp+/JUdRA+xD300=;
        b=2cPy9La2K4lEpNorxKlz+Zj8GmkQm3TNLn+Mecmt9jnWG6WHtIvwvJfO1Z5y97bPB1
         /+fpzAsKf7fF+/Mfab9gHGp/4n3j1sa0GtkcyyX0A2vBdgQEv5T3fw57Gd1eQwtHTj/g
         Bs9LgFZeu2s8d0jHxJ29msSe7xB/CC/W/iHjtWvRRmNCMYBjBkRYv9R8xwCceSkoab6C
         meID2Mwy8zyQDseUVSS9x3eipqz9vrzEBITqkaXPvtFfCGcJ7y/mWCvVIYKPZZNxWCHN
         TDFAcih5URUuefNcet3kpXctWfrQRBD7iSl2y9N47qFeRASb6C7uizA0aPU64ZNrKw4O
         rX5g==
X-Gm-Message-State: ACrzQf01DNdX5zbfRsL5XFN0HXv87fggeRI95aUZYkqWKEfvgJddi0f8
        XEJsnMhQMEF/JSmDjZ8MftzeDQ==
X-Google-Smtp-Source: AMsMyM6BwrXBOgANnwuXMwExKxwVm0Qv5qKIyu1ujzsqFwrJkYGQLcB/jdoZ7Ccg3mgqIc+GikfcIQ==
X-Received: by 2002:aa7:c612:0:b0:461:2915:e41d with SMTP id h18-20020aa7c612000000b004612915e41dmr2405122edq.184.1668093242341;
        Thu, 10 Nov 2022 07:14:02 -0800 (PST)
Received: from frostfish ([82.132.184.39])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7db4f000000b00456d2721d93sm8460868edt.64.2022.11.10.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:14:01 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:13:56 +0000
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
Subject: Re: [PATCH printk v3 37/40] tty: serial: kgdboc: synchronize
 tty_find_polling_driver() and register_console()
Message-ID: <Y20VNMu1VCW2qP13@frostfish>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-38-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-38-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:35PM +0106, John Ogness wrote:
> Calling tty_find_polling_driver() can lead to uart_set_options() being
> called (via the poll_init() callback of tty_operations) to configure the
> uart. But uart_set_options() can also be called by register_console()
> (via the setup() callback of console).
>
> Take the console_list_lock to synchronize against register_console() and
> also use it for console list traversal. This also ensures the console list
> cannot change until the polling console has been chosen.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
