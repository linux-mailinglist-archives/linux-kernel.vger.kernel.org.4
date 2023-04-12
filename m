Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD18A6DFDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDLSvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDLSvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:51:23 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72B6E9B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:51:11 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PxWy64scTzDns;
        Wed, 12 Apr 2023 14:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1681325471; bh=1zojjQh2KHF4lxw3AQTN3IiyhnTTFBbmKUEaatf8U9M=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=emdc5cCZiwjrEVmxWuvmxiL+UP9dn31dc54FOebWZzQlFMFSj5mAw1a+3wj7woIca
         PqIRVnwKT73ttNl5B2Y/Hud/8zmt2DD8br4Ub4bHMA9Au+jjs56BCJKe8KnOKkSGlg
         dt/3PD3YMFYED7+D4j5FknzLaboVlSAYSgQGrSkM=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Wed, 12 Apr 2023 14:51:10 -0400
Message-ID: <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
In-Reply-To: <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
References: <20230412150225.3757223-1-javierm@redhat.com>
    <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
    <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
    <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
    <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
Date:   Wed, 12 Apr 2023 14:51:10 -0400
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
From:   "Pierre Asselin" <pa@panix.com>
To:     "Javier Martinez Canillas" <javierm@redhat.com>
Cc:     "Pierre Asselin" <pa@panix.com>,
        "Jocelyn Falempe" <jfalempe@redhat.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Ard Biesheuvel" <ardb@kernel.org>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And can you share the "linelength=" print out from simplefb ?

Okay.  Three cases, see below.

Your patch tries to fix the stride, but what if it's the _depth_
that's wrong ?  Grub sets the mode, the pre-regression kernel picks this:
    format=x8r8g8b8, mode=1024x768x32, linelength=4096

========== Good ======================================================
grub: gfxpayload=1024x768x24
[    0.003333] Console: colour dummy device 128x48
[    0.003333] printk: console [tty0] enabled
[    0.417054] fbcon: Taking over console
[    0.513399] pci 0000:01:05.0: vgaarb: setting as boot VGA device
[    0.513431] pci 0000:01:05.0: vgaarb: bridge control possible
[    0.513455] pci 0000:01:05.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.513490] vgaarb: loaded
[    3.337529] simple-framebuffer simple-framebuffer.0: framebuffer at
0xd8000000, 0x240000 bytes
[    3.337567] simple-framebuffer simple-framebuffer.0: format=r8g8b8,
mode=1024x768x24, linelength=3072
[    3.338000] Console: switching to colour frame buffer device 128x48
[    3.566490] simple-framebuffer simple-framebuffer.0: fb0: simplefb
registered!

========== Bad after patch, typing blind to log in !==================
grub: gfxpayload=keep
[    0.003333] Console: colour dummy device 128x48
[    0.003333] printk: console [tty0] enabled
[    0.423925] fbcon: Taking over console
[    0.520030] pci 0000:01:05.0: vgaarb: setting as boot VGA device
[    0.520061] pci 0000:01:05.0: vgaarb: bridge control possible
[    0.520085] pci 0000:01:05.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.520120] vgaarb: loaded
[    3.290444] simple-framebuffer simple-framebuffer.0: framebuffer at
0xd8000000, 0x240000 bytes
[    3.290483] simple-framebuffer simple-framebuffer.0: format=r8g8b8,
mode=1024x768x24, linelength=3072
[    3.290916] Console: switching to colour frame buffer device 128x48
[    3.519523] simple-framebuffer simple-framebuffer.0: fb0: simplefb
registered!

========== Good, earlier kernel before regression ====================
grub: gfxpayload=keep
[    0.226675] Console: colour dummy device 128x48
[    0.228643] printk: console [tty0] enabled
[    0.429214] fbcon: Taking over console
[    0.524994] pci 0000:01:05.0: vgaarb: setting as boot VGA device
[    0.525025] pci 0000:01:05.0: vgaarb: bridge control possible
[    0.525049] pci 0000:01:05.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.525082] vgaarb: loaded
[    3.320474] simple-framebuffer simple-framebuffer.0: framebuffer at
0xd8000000, 0x300000 bytes
[    3.320513] simple-framebuffer simple-framebuffer.0: format=x8r8g8b8,
mode=1024x768x32, linelength=4096
[    3.320983] Console: switching to colour frame buffer device 128x48
[    3.415643] simple-framebuffer simple-framebuffer.0: fb0: simplefb
registered!


