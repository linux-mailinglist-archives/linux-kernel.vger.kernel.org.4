Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AAB68AC3D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 21:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjBDUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 15:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:15:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C3225E00
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 12:15:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qw12so24187569ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f4ywijtaY02FSmYMelb7donp08M4aMndocGVk6yD46s=;
        b=hOYfD5fYC3t7tC4Fr6BctVAvniUmd0wk4IJsNnlxxBOs+a/xNu85oNtAQvHEs8TbXO
         Mmvvj/Vh/22A+H0DmUQk8+0yGr7bUroC8Ovn5XbIP4itrLpV32+QRQKpKT+V/nIceL+4
         k+AuuoDFi3XIrwKnj9fynXZyLNTOdL4uzwhUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4ywijtaY02FSmYMelb7donp08M4aMndocGVk6yD46s=;
        b=B33mgXuOBv0MYmNL1tAVFiCqMAKipBGfAYLGozJnRdBvek8bQXLIlb3kX6VRUfd6ob
         AiUBm18isGydYHU/ibaloH7JNoVfBs47nIPH7rCEr7AgC99cptUjbwSh6PdI3XO30UDX
         kf0/5+KeIz8jLJ/naaOiHREoz6rUcM1V8sMK37wa0iwwcouMpkYK+RQw99O4lzSLdEHN
         2mUQ1wsfjcKYiSDgMup0gal12NCFBC/9lZIE5sQc4kLNJY4kMnWBzJuhW4/n1kq8q/Hf
         POq3TCxFrpwPllAnGTTR0SuT9rVLmek2e9jm4cOf4qP0Qayh3KjnZ5m/eh5JbiP4h+aQ
         HVFw==
X-Gm-Message-State: AO0yUKUyWo+FwV6nEipDym5+j5ojJxR+NJtoxJ73Zver+6sGhm+NI0M8
        YryPs4Zw/bFvNVB5cDExhKy0BbFKFzfejt7p7KQ=
X-Google-Smtp-Source: AK7set/OKb/Ui+ERn8IhTHjpUj3F6LN/BlntB9yVW9xUeFiJGeXCFknnTeEToLs2b7uM9EhDzf1ODQ==
X-Received: by 2002:a17:906:a01a:b0:889:8b6c:abf8 with SMTP id p26-20020a170906a01a00b008898b6cabf8mr13027809ejy.10.1675541712853;
        Sat, 04 Feb 2023 12:15:12 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm3205263ejx.183.2023.02.04.12.15.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 12:15:12 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id bk15so24098268ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 12:15:11 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr3773254eje.78.1675541711686; Sat, 04
 Feb 2023 12:15:11 -0800 (PST)
MIME-Version: 1.0
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com> <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu> <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu> <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
In-Reply-To: <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Feb 2023 12:14:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
Message-ID: <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
Subject: Re: Converting dev->mutex into dev->spinlock ?
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023 at 12:01 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> I'm sorry, but that simply is not feasible.  It doesn't matter how much
> you want to do it or feel it is needed; there is no reasonable way to do
> it.  To take just one example, what you are saying implies that when a
> driver is probed for a device, it would not be allowed to register a
> child device.  That's a ridiculous restriction.

Well, we've worked around that in other places by making the lockdep
classes for different locks of the same type be different.

So this *could* possibly be solved by lockdep being smarter about
dev->mutex than just "disable checking entirely".

So maybe the lock_set_novalidate_class() could be something better. It
_is_ kind of disgusting.

That said, maybe people tried to subclass the locks and failed, and
that "no validation" is the best that can be done.

But other areas *do* end up spending extra effort to separate out the
locks (and the different uses of the locks), and I think the
dev->mutex is one of the few cases that just gives up and says "no
validation at all".

The other case seems to be the md bcache code.

                  Linus
