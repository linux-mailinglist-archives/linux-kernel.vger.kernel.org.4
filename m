Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD86AACF9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 23:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCDWdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 17:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDWdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 17:33:45 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9C1025C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 14:33:42 -0800 (PST)
Date:   Sat, 4 Mar 2023 22:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677969220;
        bh=KFyhLwQsTeEVsLuUHKYhCEX6M3NsGkyXVzG3z+JFODQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfgODp01ZW/Klcjt7alZ6ap2h4emrVHDOI9TRqDhNiB1Wmivc/aJcVeA7FgYNi57f
         RP8oTBHt59Nb6SBHHT6cY2WwAsZxam0wx4CInzvlhgfREM0G4+2xJ4vyoDRRIzi589
         kocwygdURYvtOn6F9lm95TWhqOV82/FdHuUqzq9k=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Storm Dragon <stormdragon2976@gmail.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <58af4510-13cd-4f4c-9199-b6b59b2f2bff@t-8ch.de>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <Y/OacHw6nL/ZtrH3@hotmail.com>
 <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
 <ZAJqrfcfoM2eO5VL@mjollnir>
 <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
 <ZAOi9hDBTYqoAZuI@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAOi9hDBTYqoAZuI@hotmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 02:58:46PM -0500, Storm Dragon wrote:
> On Fri, Mar 03, 2023 at 11:25:00PM +0000, Thomas Weißschuh wrote:
> 
> > Does this mean the screenreader now works correctly or is it still
> > broken somehow?
> > 
> > Thomas
> 
> I have still been testing this kernel. Most things work as expected, but
> the pasting functionality for Fenrir's clipboard is broken. After
> checking into the problem, it seems that tiocsti is disabled, and that
> is causing the problem. Was that something done in this test kernel
> only, or will that be the default for all new Arch kernels? If it is the
> default, is there a way to turn it back on?

By now this package has been promoted to [core] so it is in fact the
default ArchLinux kernel.

As a workaround you can use the "linux-lts" package that now also
carries the fix for your original problem but not the code responsible
for the new issue.

pacman -Sy linux-lts

> I tried the following:
> 
> [storm@mjollnir ~] $ sudo sysctl dev.tty.legacy_tiocsti=1
> sysctl: setting key "dev.tty.legacy_tiocsti": Invalid argument

This is indeed the correct way to enable the feature again.

It seems that the commit that introduced this sysctl[0] depends on
another commit [1] to be applied. But the 6.2.2 stable kernel is missing
the requirement.

I'll validate that this indeed is the issue and will then send a formal
request for backporting.

[0] 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
[1] f1aa2eb5ea05 ("sysctl: fix proc_dobool() usability")
