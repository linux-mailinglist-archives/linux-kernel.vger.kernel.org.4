Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F156A2AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBYRFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBYRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:05:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D5CC30
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:05:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ee7so9474948edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxoscNZqMv4xoYF3RLqiGyx1me2ebOAvYSK+OK3ZhoY=;
        b=c6d6DuQDEwEyWOeU9gj9Xo815A7QOUCOMTCo9jq9Cq5yz6hYmwiLx0c4Fp5B4LKb75
         o9RKpwNFd3uXOtyXLhbn6NtL3WgoxgV5zyvcMWc3kUhGHYY+jL0lSNw/pHxQbGQj0MuR
         87uJf9mWtRan435KYLEgINT37dYgLVED/pPO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxoscNZqMv4xoYF3RLqiGyx1me2ebOAvYSK+OK3ZhoY=;
        b=RnoPAlLUAD7bR9nzCWGgHp0TjqqCIfURL919Yv9fHShVAgzwiagQAW49DJ0XpJE19W
         8F+dHBQF4wAYKPsSSnoEH1CFEERAa95An+Ohc5fl4jci4QrXSCq04mAv1o0Uj1e1rom8
         zQCFNNiXqfWZmuLqxAFinsuJvLlP/DmxZNdJFDmTPrsa7ZYuzrk3hN7N+vDbmn86eLdK
         bzZQrovq5wOXLOwjuXlX99qw3dsoz4bN/vqzUcdWlPzDJNOMqXSUR1WtA9/kDYhSHFVx
         WNQ44wdgAR1AkJRyro2tdHzgJ8L4gFMxucJdYklb5CORN75fhTgzr3DwS8NE/OOfP5wr
         6GSw==
X-Gm-Message-State: AO0yUKVdpO8VQaeKjRuNGKd8+CgtOUtgRXLy6YN7jjD0nQT0cnaH000R
        5kbbHOiSHFWvhpFZZKwYmaHc/eKJ2cqa5FKfKTzuBg==
X-Google-Smtp-Source: AK7set8xRf5/tHA/++Sd0wrPCm8SwaDGFFUjuRZsebgfozZHthFw4iVQjg0BQB0tjm8RhAsUJxbuKQ==
X-Received: by 2002:a17:906:2c50:b0:8af:2cf7:dd2b with SMTP id f16-20020a1709062c5000b008af2cf7dd2bmr28710463ejh.13.1677344715394;
        Sat, 25 Feb 2023 09:05:15 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906564c00b008e8e975e185sm1011565ejr.32.2023.02.25.09.05.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 09:05:14 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id o15so6898251edr.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:05:14 -0800 (PST)
X-Received: by 2002:a05:6402:500b:b0:4ad:739c:b38e with SMTP id
 p11-20020a056402500b00b004ad739cb38emr2500448eda.1.1677344714502; Sat, 25 Feb
 2023 09:05:14 -0800 (PST)
MIME-Version: 1.0
References: <Y/gxyQA+yKJECwyp@ZenIV> <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
 <Y/mEQUfLqf8m2s/G@ZenIV> <Y/mVP5EsmoCt9NwK@ZenIV>
In-Reply-To: <Y/mVP5EsmoCt9NwK@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 09:04:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQz8VDDxdaj3rk861Ucjzk72hJoCjZvfaeo8jCyVc_2w@mail.gmail.com>
Message-ID: <CAHk-=wgQz8VDDxdaj3rk861Ucjzk72hJoCjZvfaeo8jCyVc_2w@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc bits
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 8:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Let's have it sit around for at least a few days, OK?  I mean, I'm pretty
> certain that these are fixes, but they hadn't been in any public tree -
> only posted to linux-arch.  At least #fixes gets picked by linux-next...

Ack, sounds good.

               Linus
