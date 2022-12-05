Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD16E64212A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiLEBno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiLEBnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:43:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FCA11A0D;
        Sun,  4 Dec 2022 17:43:40 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 62so9166546pgb.13;
        Sun, 04 Dec 2022 17:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CNMafDYB6fFOhMeLCFBhocV85I901cqUWy+zYzgU/+A=;
        b=CcKYdzH9sH1aup47JAWXgTTzOSCAXuOQIOTXwgCDADvT6pELae63ql1xb8GxQcdhmp
         FMvFd955pItJ1noIOEF2MRDq78O+eh07dYd6E9SAlW+vi+UuWhwvWY/WLQWP9SHSXgVm
         /Sp1a3qVcf+uCB8ICu+lEoNiU1rME/1YuuOKgcYGeFVmFtxQqHFeM5FyK1KLZA6qrIjI
         w+ZRblKqlt5DaZPsG0vZaiOoAsl/IDqp0zp5tM8o29sc4EJPCUD0lRzi3yLqsCx2CgwB
         Uk1ZSf99NmpvO7D7X45+O/AY1qm6ccMWAgh6c3edjEVVq4pAK4siyImVHD6jJnKcylBo
         S0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNMafDYB6fFOhMeLCFBhocV85I901cqUWy+zYzgU/+A=;
        b=3+BeysnQBT1s2WDfthcrMFJJpOSaERpw4BULrObKs7koNUZCeAtX9xEGqBLTI3NNsR
         cMyTLYXOEOTBVWT1yAwtWsHqWPtHjeQoCK4EN+fR8AqTW61PFglICJpDWbkxo0nx3Ijo
         yBnrQFEGm4y9XsHzK38dO6zbOc8HK+glpYo/ch5lKIJKI6Zl6EpLvtDNQ20Ztj/B8VU9
         IiMyY834dmeKQdpM9vDLkWr9cpE44jCmduL3I2XsIbXzt5pALQ3zkAvUH1yyajjn1Hu0
         RrQKugpaPaQcm2c9D540C37OUGIF4PwFRQH7Pf5jFvIPX2SmX2UtJ5vq0lnUEzRX5ApQ
         RbGw==
X-Gm-Message-State: ANoB5pm1oBw7fr4fBTpmF9f3bW30mFDg1XJXHv5JlvCctRvf7ImEoeiD
        mqLYWXEIwoMAm7YitlODEHc=
X-Google-Smtp-Source: AA0mqf4v14Ev65Y4uH0oqDEhOh8gjfDQqOjIRgj0b1FJvkJb7iB5hHurHGblso4ZBldrYbGEzLYL5Q==
X-Received: by 2002:a05:6a00:2908:b0:56b:d738:9b with SMTP id cg8-20020a056a00290800b0056bd738009bmr62308196pfb.61.1670204619863;
        Sun, 04 Dec 2022 17:43:39 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79849000000b005769ccca18csm3049702pfq.85.2022.12.04.17.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:43:39 -0800 (PST)
Date:   Mon, 5 Dec 2022 09:43:32 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Message-ID: <Y41MxPthLjitvzEl@sol>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 10:38:45AM +0100, Linus Walleij wrote:
> On Wed, Nov 30, 2022 at 4:55 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > +The below table gathered the most used cases.
> > +
> > +==========  ==========  ===============  =======================
> > +  Input       Output         State        What value to return?
> > +==========  ==========  ===============  =======================
> > + Disabled    Disabled    Hi-Z             input buffer
> > + Disabled    OS/OD/etc   Single ended     [cached] output buffer
> > +    x        Push-Pull   Out              [cached] output buffer
> > + Enabled     Disabled    In               input buffer
> > + Enabled     OS/OD/etc   Bidirectional    input buffer
> > +==========  ==========  ===============  =======================
> 
> This looks about right to me, but we need more input, Kent?
> 

Firstly, I'm all for tightening up the driver contract, and hope that
whatever is decided will also be updated in driver.h itself.

I can also understand Andy wanting to add support for Bidirectional
using the existing API.

But, and please correct me if I'm wrong, the user has no control over
whether an open drain output is single ended or bidirectional, and
no visibility as to which the driver supports or chooses.
So the contract is still vague.

My preference would be for the driver API to be extended with a new
callback for the output buffer, say get_output(), and have the existing
get() always return the input buffer.  Both would return an error if the
buffer is unavailable or disconnected, e.g. in the Hi-Z case.
As per Hans' suggestions, this would keep the drivers simple.

Then cdev could determine the approriate buffer to return, depending
on the mode.  Or, better yet, we extend that through the uAPI and
handball that decision to the user.

Cheers,
Kent.

