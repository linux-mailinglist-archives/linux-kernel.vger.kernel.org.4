Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9AC6EE4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjDYP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjDYP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:28:05 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13850D318
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dwGVDk4SHkWtL6mEgKRTfzCqiaeVftMHAPn2KJIhs3o=; b=u9SRVK4UgPL0Om0axTL1hg3QbM
        wikwgYI2R6uMvDlXJtN10qBPoGBm2qh29WD+7GwLQthXvrNA/RdsJ6ifHUfOzgxFgUKDRBiAcYJwh
        EfPY7TaJooXZkdUVrHl8VvYSvkQDQjT0lGkfjDcL7jz4EN6Vi8P0ZERrWqeC350BKL+I=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.96)
        (envelope-from <kilobyte@angband.pl>)
        id 1prKZc-00HSA0-20;
        Tue, 25 Apr 2023 17:27:20 +0200
Date:   Tue, 25 Apr 2023 17:27:20 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: Re: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Message-ID: <20230425152720.GA4155584@angband.pl>
References: <20230423135124.55196-1-kilobyte@angband.pl>
 <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
 <20230425115210.GA4151911@angband.pl>
 <2023042502-resolute-divisible-fbff@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023042502-resolute-divisible-fbff@gregkh>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 03:40:10PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 25, 2023 at 01:52:10PM +0200, Adam Borowski wrote:
> > On Tue, Apr 25, 2023 at 04:39:23AM +0000, Winkler, Tomas wrote:
> > > What is the exact issue you are experiencing, can you add the error message this fixes? 
> > 
> > The problem doesn't trigger in mainline
> 
> Then it's nothing we need to worry about in mainline.  If/when other
> changes ever happen to need it here in mainline, we will gladly take the
> change.
> 
> For obvious reasons, we can't take patches for issues outside of our
> codebase.  Nor do you want us to, as that way lies madness and an
> unmaintainable mess.

The problem in mainline is inconsistency: out of 6 config items, 4 repeat
the "depends on X86 && PCI" line, the other 2 do not.  There's indeed no
immediate functional issue, but I'd argue that a dormant bug is still a bug.

So we can fix the cosmetic (currently) issue on its own, or as part of the
large patchset -- the latter having a side effect of stuffing your mailboxes
more than needed (neither Greg, Arnd, nor Tomas are involved in other bits).

But do the selects really require so much duplication?  Perhaps I'm trying
to fix the underlying issue wrong? 


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Only flat-earthers have a problem folding a fitted sheet.
⢿⡄⠘⠷⠚⠋⠀ I instead shape it into a ball.
⠈⠳⣄⠀⠀⠀⠀
