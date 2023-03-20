Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319936C2408
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCTVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCTVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:43:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AD524BF2;
        Mon, 20 Mar 2023 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gzQ0IRamnabVhoWBY7vcKUhwOr44R6rpO7XXkU2CMqw=; b=WIqpGufgrnpO14KtvYsvaMDF1y
        gqW6Z0Q33pfwYf6gMZXEVPmcVkrz0EwzSRYbBJsfq8x6XRthCD8Xf2twg5JfahBAkwTuWnAnPdGgb
        aiHATtQwvmG+xlvY8X26x4/S+69qpbdb23wvTuKrZSY/BzNMJuB/W2WN0DoSKML+quyObNACTWx08
        sMiurTfwjz7qNdWy3YOREbe71U5G2oPNikQgc0jJ/D5EPvjpjqfyqxOfFCX/xgwm2xajxcwgvjOnt
        mpEgQYK14xFZsbEoVbm9HBAB+Ck1H7VmmaFJQ6qx7AVy6C7Li3Xdl4K9YxLOjgZpzqODZmoiz32Hi
        nnagA1Uw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peNGW-00AZ3O-0H;
        Mon, 20 Mar 2023 21:42:04 +0000
Date:   Mon, 20 Mar 2023 14:42:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 14/24] kbuild, firmware: imx: remove MODULE_LICENSE in
 non-modules
Message-ID: <ZBjTLGhohFlbO4xr@bombadil.infradead.org>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-15-nick.alcock@oracle.com>
 <20230314013539.GA143566@dragon>
 <874jqfvheo.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jqfvheo.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:36:15AM +0000, Nick Alcock wrote:
> On 14 Mar 2023, Shawn Guo verbalised:
> 
> > On Fri, Feb 17, 2023 at 02:10:49PM +0000, Nick Alcock wrote:
> >> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> >> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> >> are used to identify modules. As a consequence, uses of the macro
> >> in non-modules will cause modprobe to misidentify their containing
> >> object file as a module when it is not (false positives), and modprobe
> >> might succeed rather than failing with a suitable error message.
> >> 
> >> So remove it in the files in this commit, none of which can be built as
> >> modules.
> >> 
> >> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> >> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> >
> > Should I apply it as a fix for 6.3-rc with Cc stable tag, or can it be
> > a material for -next?

These are not stable critical patches.

> This is currently built against -next, but Luis has indicated an intent
> to pull the lot in via -rc3 (hence my scrambling to get the series
> polished up for him, tags attached etc now). So, er... yes? :)

Those patches which don't get this simply can't benefit from future
tooling enhancements which Nick is working on which will leverage
correct mapping.

So yes, my goal is to pull up straggler patches except where some
maintainer explicitly don't want them. For instance, I will not be
taking in the patches for trees that Greg KH maintains as he would
prefer an alternative, but yet hasn't recommended an alternative
strategy to help with Nick's work.

  Luis
