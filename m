Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142276A23B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjBXVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBXVYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:24:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966584608A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:24:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec43so2491835edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z7FL2J01+S1brZJhkSmrAVHSbND/ljBuG/iYSX39T/M=;
        b=FqYqL229nQFsdT8zagqSYUMC8fLl9jL1yBbVwID9qj6Af/qat8UsxUyPUbVHQpJ7+T
         SJ+IpE7G2Dxp0LqEdrRQIHMRFrAGpcpX6LdLMzlANx2xVHKvm/d88opMaHNpgQBBTE9D
         EsQYuqWJVIcKvbzccwf/F+ujbtwgB68lPVm1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7FL2J01+S1brZJhkSmrAVHSbND/ljBuG/iYSX39T/M=;
        b=vtVw47DGe73Wii/8HUkqeA8Bxw6asWWXKicL+1rTANmALLMqtp9zzHzRO+r8m7A4DG
         qqYbpzHPJEmkLXeWWLyDy7bvfAMyahfQV9wTM7PMxNHw+bxvdmA1+9V1FeT2i3592UJ4
         DE69OplYFLAZXm7dDfp//c/fks7pylbOHTNllZpfotUeM24fO6sso72s+PkRdgNMwYGd
         ZOL5q69ouu8bM+JAYNOXW+4urUMCmDof9DqKqG/AB+jAQIP0MUSS8Km2FSfqglC1waDM
         7xFfG9x2WpJ9AkqsUppWJMTUhiaIC1N91sjucPVKke015kWlHqrlUwXr1Jc5LZqg7A//
         pqXw==
X-Gm-Message-State: AO0yUKUParPp4JjSg8DQulFqnyc/DZYaZjEBKNo3f3zg4AvEwybF5/0w
        c4sB54nD2kl+QQgcQDmQut7aejxzwH47b3BosYBLAw==
X-Google-Smtp-Source: AK7set+37mUo6NoDRZdv8Axb+grytAisuh1jjDBtTFrqIv726j7YXf0uIKl1HrpVoUyFWoXq/um+WA==
X-Received: by 2002:a17:906:4fd2:b0:8d9:c3d:91d8 with SMTP id i18-20020a1709064fd200b008d90c3d91d8mr25211844ejw.31.1677273863842;
        Fri, 24 Feb 2023 13:24:23 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090611c500b008b907006d5dsm8437eja.173.2023.02.24.13.24.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:24:23 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id o15so58288edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:24:22 -0800 (PST)
X-Received: by 2002:a17:906:b55:b0:8f1:4cc5:f14c with SMTP id
 v21-20020a1709060b5500b008f14cc5f14cmr2756517ejg.0.1677273862668; Fri, 24 Feb
 2023 13:24:22 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com>
In-Reply-To: <Y/iywbFbiUAA6ZD3@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 13:24:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
Message-ID: <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
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

On Fri, Feb 24, 2023 at 4:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>   - more 8250 device support added

Bah. I didn't notice this while merging, so it's in my tree now, but
that SERIAL_8250_PCI1XXXX shouldn't default to on.

The Kconfig file has

    config SERIAL_8250_PCI1XXXX
        tristate "Microchip 8250 based serial port"
        depends on SERIAL_8250 && PCI
        select SERIAL_8250_PCILIB
        default SERIAL_8250
        ...

and I don't think that "default" line should exist. It's not like this
is some super-common board that everybody should enable.

When I notice things in time, I tend to just fix this up in the merge
itself, but this time I had already done a couple of other of your
pulls before I noticed this thing.

            Linus
