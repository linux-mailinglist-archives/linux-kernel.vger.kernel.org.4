Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB926A248A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBXW6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBXW6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:58:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810018AAB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:58:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee7so3401810edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECYH+xNXgIZdg5nfy5FpWWMpLUNA2LuYDJ0eGM5JDgw=;
        b=SoSCooq75FTO7eU+0Mf28G19+EJcIDd9/RoXHXcLVbTCiBgdVussJe8sJlVdv/lfuY
         GI19OT/g/ohuTbRXOT43f88404lqC80pEOE9poB8U8hGq+AN+oFa1OWR0fF61uKXq53m
         l7FC+1nttdxXwlYaxb9D+cMPvb1zzF3SvI9aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECYH+xNXgIZdg5nfy5FpWWMpLUNA2LuYDJ0eGM5JDgw=;
        b=lrO9S6cojXHADCBWtscGqia/ftRl/RTToMLaNMY/zsdSgFpmShzmPNzI1oHswph5b3
         jN7Zi4H1Z9szZtK5dFtEIaI2AcmliLEluEjEHgLmxrKkf4bwjgtF61X57PW07oemglTG
         cPzQcOF0iYF0UlKeSK0CUMg4Y91t5AMX22nuMmln41AtbuRmeQDYN/QVevpjK7HLwl8X
         G0T/yIpCcOsnZsetLNSrOzb3UiQienPTkqJvTWJkx0au7BFlN6DKs3npZiLRnCoUeIZ5
         EFkALDHcIAbZlG8zRxJnIf7q902XlnOXdRdSpgUdjZceOaPoEmzLUaVAixWkOOeNDMmZ
         FarQ==
X-Gm-Message-State: AO0yUKUgPyChJX/hqCTPezsZRvPp75ZjvAeW9F3hC8vQChTQps2MXAVi
        CnEORR8RvYEiBmXWDLOcqNVm/YoQViGM6l0bddkJiQ==
X-Google-Smtp-Source: AK7set85gbiKM+irTubfYspY8fdZ1COsX8zQiC+AEUPI9lN2qBAYzB8AKjLIBKZ6AzPqp7mbwqLZZQ==
X-Received: by 2002:a17:906:aad6:b0:87f:a197:5666 with SMTP id kt22-20020a170906aad600b0087fa1975666mr25299786ejb.5.1677279496215;
        Fri, 24 Feb 2023 14:58:16 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id r15-20020a50d68f000000b004a9b5c957bfsm220988edi.77.2023.02.24.14.58.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 14:58:15 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id ck15so3558499edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:58:15 -0800 (PST)
X-Received: by 2002:a17:907:60cd:b0:8f5:2e0e:6dc5 with SMTP id
 hv13-20020a17090760cd00b008f52e0e6dc5mr927497ejc.0.1677279495053; Fri, 24 Feb
 2023 14:58:15 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com> <Y/k66v01i5z3kFMG@ZenIV>
In-Reply-To: <Y/k66v01i5z3kFMG@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 14:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDFKGABDe7w-=HsiUr7f=CpbmR3bPf2UL-1dPcWRYW9g@mail.gmail.com>
Message-ID: <CAHk-=wjDFKGABDe7w-=HsiUr7f=CpbmR3bPf2UL-1dPcWRYW9g@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
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

On Fri, Feb 24, 2023 at 2:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > It's probably most legacy by now - it's a long time since I saw a
> > serial port being used outside of management ports, and even those are
> > often ethernet these days.
>
> Serial console is hard to replace

Yeah, but I don't think that should make it "default on" just because
somebody picked 8250.

I may have 8250 in my old config for my own legacy reasons, that
doesn't mean that when I upgrade a kernel, it should default new
drivers to be enabled too. My old legacy 8250 history does *not*
suddenly grow new hardware.

Side note: we have *truly* legacy things like that
SERIAL_8250_DEPRECATED_OPTIONS thing, which also - for historical
reasons - is "default y".

I guess that's just another sign of the whole "this is legacy" thing.

          Linus
