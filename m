Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C788961E704
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiKFWwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiKFWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:52:14 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB310044
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 14:52:13 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13bd2aea61bso11053021fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 14:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0ydKSnTIyWx0S1Q3BoBxyZVcUZEIG3/6GqQGMFVTmw=;
        b=o4U9+nFjsC8V78QKRojdVnejQj3nf/6FFOpizO4ntpJr9zYJui8jWbm/D905kJS75A
         jmD0K5x9rK4rjG8zcj0KeBBuz/C10UxuSGFIs+lhwoaQap1FrbLvzZtcIdpjeBsXng+a
         dVMnWPg+xqcrQiMiQzLIOh+ZB9cDPe7lT4hu4xyu69IraSEGV48S9pU3oB+zdKiON08f
         ViOuLcNYW4F++h1sWrqtsy3lSRso+qF6zqieS567VMqV0IJ/SOG2NUsmov2hh9V37pFr
         SMCYXVaRbJvRIiI3FVgAoAxHs5GlcuYSKQVb4cQ7LWb7TGp2RZnIWdKc+9I8hVdrWA8l
         c15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0ydKSnTIyWx0S1Q3BoBxyZVcUZEIG3/6GqQGMFVTmw=;
        b=xtqRXCzUVRDTs9cBGDKR96GCI4Li7zxE7mit1yNMsQFwOd6ktf/dQP8pNjq5DinE+R
         sR++aAqCAtoFFK6qK8GycG4d9crfvxV2LFLVLnca/4TPIwJ7u2Ab9mm1ZoCARpZgPuNX
         2wHzXbf3nE9asmzzxrIaqD9xyJkhioTAzKKIiwIf9b5tm8PlNEgkmg8fAbg5CFY45MUr
         D2i92F1x9mDLab1gX25y0rN2Her0wnckwDQPQQn3G0B1a+/cO5/wyeGoPvf8bnOapU9a
         6d6y0/ZrYVpVn4YsNb5JWxwdZyU+LgtGrB9WiPxPVGmUSWPgheBVWwJbE/NrpPbJZczT
         uCKg==
X-Gm-Message-State: ACrzQf1KR4LnqAMFNMn4DNOvwh7CAaVTwFN6JgAcGTA3dpmyQCF6MPeb
        /Nsc0RbJBTVBNX8UuhJqN0g=
X-Google-Smtp-Source: AMsMyM5mnh/T8kJBeyCEztSlAhbfFV1Jc4H4f0IT6lVYZCnzRYHZcyegQ5BffSeK4l2ATQlGOrTJMQ==
X-Received: by 2002:a05:6870:3510:b0:13d:9666:b884 with SMTP id k16-20020a056870351000b0013d9666b884mr11871863oah.138.1667775133127;
        Sun, 06 Nov 2022 14:52:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s26-20020a9d759a000000b00667d9a866b0sm2259473otk.59.2022.11.06.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 14:52:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Nov 2022 14:52:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to
 timer_shutdown*()
Message-ID: <20221106225211.GB805009@roeck-us.net>
References: <20221106054535.709068702@goodmis.org>
 <20221106054649.099333291@goodmis.org>
 <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
 <20221106160956.2414d73f@rorschach.local.home>
 <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
 <20221106165220.4d7e5dac@rorschach.local.home>
 <CAHk-=whO5PXEzWwf=4=fvdqim6cGTczVoN4KJ5H+dabHo-OTHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whO5PXEzWwf=4=fvdqim6cGTczVoN4KJ5H+dabHo-OTHw@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 02:40:14PM -0800, Linus Torvalds wrote:
> On Sun, Nov 6, 2022 at 1:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I can update the change log to include:
> 
> Yup, full running instructions for coccinelle patches is probably a good idea.
> 
> I've done them semi-occasionally, but it's rare enough that I always
> have to look it up anyway, and I suspect many others have never done
> it, so having it in the commit message is probably a good idea.
> 
> >       when != ptr->timer.function = E;
> 
> I do think that you should just remove that E expression and the
> "function = E" part.
> 

Agreed. Removing this line does not make a difference. It looks like the
"when strict" takes care of the condition.

Guenter
