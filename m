Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F904641FFB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLDWPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDWPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:15:44 -0500
Received: from mail.cock.li (unknown [37.120.193.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D24F589
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 14:15:40 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tfwno.gf; s=mail;
        t=1670192137; bh=3oqF4dzN41HMYjT9vl0o2CmZ5wATpqP5E46+SXGrtJE=;
        h=Date:From:To:Subject:From;
        b=l+dh3uB0wLBCF4bU2St/fj/lQDCeup/hJYgMddgSpTk2EgVvBo5vKxZ2D2zfrr6/z
         98+Y7nCSkRgmWFlQnvy0yXViCiFlJ2oKUhw9cpgg4vmgbUkAFr036UctTFumQiiql7
         YA2c1Uq1SXSPrgovEmztnUHZfTRmMZNUxFMCjt0bxGK4KGH1V/NpKtCTkk21AMNWpK
         qAAxIaqlv2r5huUArJ8eyBZrSK8e2tm2P3Cdx1wmLGd/ptBwmPX1H5/0wTHa/Pe3Ij
         VB1OsHQAZwOCmLJktInSW4fYdLDMjeM0+21sV+F+wA8rI8XQmkFgYAy+9u3MQyEjEy
         xgh+4BhYmtPQQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 04 Dec 2022 22:15:37 +0000
From:   ns@tfwno.gf
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Bug: atkbd partially stops working after using raw input
Message-ID: <e37a43eb03aca34b8ea3e8755f6b46b9@tfwno.gf>
X-Sender: ns@tfwno.gf
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The builtin keyboard on my laptop (a ThinkPad T480), which is driven by
the atkbd driver, can occasionally stop working after I use the
application prboom-plus[1] for a few minutes. As the title suggests, it
doesn't entirely stop working, but rather some keys like g, h, the up
arrow, & Escape (on ANSI QWERTY, & might be worth mentioning that it is
these keys specifically that get screwed up every time; maybe some
others I'm not aware of, but it's always the same ones) simply do not do
anything. The problem persists after I exit prboom-plus, in all
applications, including Wayland but also even fbcon & kmscon[2].

Sometimes the keys start working again practically randomly after some
30 minutes (average) of continued use of the machine after I have closed
prboom-plus. Why this happens is utterly beyond me. When it starts
working again I sometimes hold the key, & this results in my (very fast)
autorepeat being much slower than usual, which I think is an indication
of randomly dropped inputs. Whether I rapidly press a key or just give
it a single press every 5 seconds, it doesn't seem to make a difference
(basically just starts working again whenever it feels like it).

I use this machine for many hours at a time under Wayland (so libinput
for the input stuff), & I was not able to reproduce this without running
prboom-plus, ever. A reboot always fixes this issue, which is the only
consistent way of fixing it I've found; IOW if you run prboom-plus on
that boot, your keyboard is screwed the entire time until you reboot,
or if the keyboard is feeling in the mood to fix itself up (as detailed
in the last paragraph). So I'm somewhat convinced this is

  - a kernel issue
  - a problem that occurs when using raw input, which I imagine
    prboom-plus, an SDL2-based application, does.

Also, do note that evdev access is still mediated. Maybe I'm not using
the right terms for this, so what I mean is:

  % cat /dev/input/event4 # my keyboard
  coreutils: /dev/input/event4: Permission denied

Despite this, I don't think it's a problem with my userspace, because
again, it affects fbcon too, even when you kill any other userspace
using the input device.

Other notes:
  - I cannot trigger the bug immediately; you've gotta keep using
    prboom-plus for (AFAIK) at least 2m up to potentially 7m before it
    happens.
  - prboom-plus suffers from the bug just as much as every application,
    made very obvious when it becomes impossible to pause the game (yup,
    that's Escape not delivering any inputs)
  - other inputs like USB HID devices (USB keyboards, as well as USB mice
    & so on) are not affected by this at all; I cannot reproduce this bug
    with them even if I follow the reproducer entirely on the USB
    keyboard instead of the builtin keyboard. Well, precisely, the bug
    will still hit the builtin keyboard even though I didn't use it,
    but the USB keyboard's inputs will still be unaffected.
  - I have not been able to find a simpler reproducer yet; part of it is
    that it takes so long to hit the bug to begin with

Kernel version is c2bf05db6c78f53ca5cd4b48f3b9b71f78d215f1 on
torvalds/linux.git, but I can reproduce this bug even on mainline 5.19.

I can patch my kernel & tweak its configuration pretty easily, so I am
very much open to experimental patches & using testing subsystems to
obtain any information you might need.

[1]: https://github.com/coelckers/prboom-plus
[2]: https://github.com/Aetf/kmscon

Regards,
