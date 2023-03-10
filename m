Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343DF6B33DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCJBzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCJBy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:54:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5339FD2B1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:54:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id ky4so4094191plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 17:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678413294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sH+VuLuZz3cI1+L2r8Kcc68lHGtUOiwVb06rM6k7FFs=;
        b=baNgmA7jd12BnU2ALV5TnTTDWM+e33idxILuxcMN419SzcPM0UpbSjsnGKklcsPqsj
         Hg/nah++U9fAoZeHVxxq3vHqdUr5GYoGGqLLXZcBu2HOJtVNIGwge84J+7aYyYXWfmMv
         nkuJWW5gTySZOwPNuzKU9xdeAW1dr3uqG5l/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678413294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH+VuLuZz3cI1+L2r8Kcc68lHGtUOiwVb06rM6k7FFs=;
        b=AcEoFo0HVAJgzjPkyKincgHtck/JJABg8X/fEwnh51rWFcfF8LXhOLikJFLHOJs7tD
         s5wlVyIUfm2NlY4mENtCKjf+7VQS9ekbvGDKj6fCTfNpe8eAaVRTioSye5Y891/G05gR
         zMS2lZtVSCKPIB/wSKbOzoahpvKrCj9HFpjsO8iOWMU2JvmXGf9KKbhBfFwPcY11pbcN
         ailK6msUR9voT2qV3O2UJvqA9b7upe/7RENjOH/3m5Do5SbKCphkUAhF+rL8PZmU9NAk
         96Bcx1I2HHpqnzbB7tW8c7eZHp3v55tpqjkEpkZ6vZa+vJKVPH0gYzN1TlBSHR9UVJo+
         LidQ==
X-Gm-Message-State: AO0yUKVw07owF6Islukse46t7gZfjzRAuqwOOt+vnskg4GsmB68yyrOP
        EqdVvuqgzl5GPikbea8scRxLTA==
X-Google-Smtp-Source: AK7set9c3LjzF8O9fI1I1dsjNXmBi8mFvknYT0jXLOigp+MrV2PclybwLRmykMeVxsT//3BIc/L+Zg==
X-Received: by 2002:a05:6a20:7f8c:b0:d0:360c:eaa9 with SMTP id d12-20020a056a207f8c00b000d0360ceaa9mr15238062pzj.62.1678413294348;
        Thu, 09 Mar 2023 17:54:54 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78c14000000b0058d9058fe8asm217330pfd.103.2023.03.09.17.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:54:53 -0800 (PST)
Date:   Fri, 10 Mar 2023 10:54:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/serial-console: Document the behavior when
 the last console= parameter is not used
Message-ID: <20230310015448.GD1045797@google.com>
References: <20230308112433.24292-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308112433.24292-1-pmladek@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/08 12:24), Petr Mladek wrote:
> 
> The console= kernel command-line parameter defines where the kernel
> messages appear. It can be used multiple times to make the kernel log
> visible on more devices.
> 
> The ordering of the console= parameters is important. In particular,
> the last one defines which device can be accessed also via /dev/console.
> 
> The behavior is more complicated when the last console= parameter is
> ignored by kernel. It might be surprising because it was not intentional.
> The kernel just works this way historically.
> 
> There were few attempts to change the behavior. Unfortunately, it can't
> be done because it would break existing users. Document the historical
> behavior at least.
> 
> Link: https://lore.kernel.org/r/20170606143149.GB7604@pathway.suse.cz
> Link: https://lore.kernel.org/r/20230213113912.1237943-1-rkanwal@rivosinc.com
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Looks good!

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
