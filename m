Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E96B52E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCJVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCJVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:32:33 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727315274
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:32:28 -0800 (PST)
Date:   Fri, 10 Mar 2023 21:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678483946;
        bh=7hAJiM6noMr+smt6CDR6XGldx7t8Em38BXnhIS/N0Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9X2oRa8VNh9FN3z8e3aF650xQLSMQfXsVlMBdjhHi1gpZpeWGD4q3x5SMe7hWYWZ
         yisXlXF1iAYt+Kmxz7lw0nM7iZZ3xuCJojP1cKqLox8GHP93EZ8uiIbrtSLIAPBSip
         gDXk+33Rimqk2fAoNGup6Fv3Nah8GrxGtmjBaeZA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Storm Dragon <stormdragon2976@gmail.com>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <e152e3ad-9485-4f9b-979f-eaabfe074aa1@t-8ch.de>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
> default, is there a way to turn it back on? I tried the following:
> 
> [storm@mjollnir ~] $ sudo sysctl dev.tty.legacy_tiocsti=1
> sysctl: setting key "dev.tty.legacy_tiocsti": Invalid argument

The sysctl to enable the ioctl should be fixed in 6.2.3:

pacman -U https://mirrors.edge.kernel.org/archlinux/testing/os/x86_64/linux-6.2.3.arch1-1-x86_64.pkg.tar.zst

Thomas
