Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA769FE71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjBVWZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjBVWZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:25:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A61EFE1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:25:07 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2277A1EC068E;
        Wed, 22 Feb 2023 23:25:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677104706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rqGuUfYzE+6s5Qo15bNdnzyu2OPEKbVmumKdBGdNFOo=;
        b=Kuj0hV6gT7zw+6q2hzz4LCbXJ3ETg1TiYkKvUJgwh3Hb9H3vgIaVutSbIa3UGUlRCNNqyz
        PUaTKe8CEoCOZLZ6uBTMmEBDiPnIcBv1Mxv1Ch1e7soQdoSqONTC42Z2A+FU5eKe9EoF3c
        C6Di4UeBMPHFqdqVGMi4u/WHmaqzJc8=
Date:   Wed, 22 Feb 2023 23:25:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tavis Ormandy <taviso@gmail.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/aWPuo2MNrl7RXB@zn.tnic>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic>
 <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
 <Y/Xp73KJe3c/1jrn@zn.tnic>
 <Y/aIjUr78yd9U+wl@thinkstation.cmpxchg8b.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/aIjUr78yd9U+wl@thinkstation.cmpxchg8b.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:26:37PM -0800, Tavis Ormandy wrote:
> Thanks - confirmed, it *doesn't* repro with 0x8301055, but does repro
> with 0x830104d.

Good.

> Annoyingly, I thought I was using the most recent microcode, but it seems
> like there is some bug and debian wasn't applying it at boot.

Well, actually, microcode loading is so simple - you don't absolutely
need to rely on the distros to do it for ya.

You simply get it from

git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

and copy all the bin files from amd-ucode/ into /lib/firmware/amd-ucode/

Technically, you'd need only the one for your family but the tools can
deal with multiple files in there.

And then you're all set - dracut or whatever creates your initrd will
add it. You can even add it by hand, see

Documentation/x86/microcode.rst

> That seems like a scary errata :-/

Yeah, modern x86 hardware is crazy complex. And we've had worse. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
