Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9292464533A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLGFEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:04:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460065133A;
        Tue,  6 Dec 2022 21:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xBOynPlFMRVXHrZbltIiIs3+eUjeKTYRLQ8vKsVHLL0=; b=wnUIajY0Ex8709cgC4fa5Tj8TC
        By/5u/pj9KIABTn6UyjsKbfCdzWI70uDH9lTx56ynaSSsCaBJ0oM5ncoEYMPUc6KjbOAk5Z4B32Gd
        pAs/bEuBOjvrO5EzCy1dPWqeP8U0PQKci5wQ9KivAuqGaJJxZz4cxAdOxE3nl+S0tPI68XreYgQ7I
        +9/+oBUdmLLG4YgxczhiIB3icUuW/2oM/GCvjq6P1xa9WVoIVaHiOTeFJZ3c186uNlzSpsH5YhES4
        Sn80X1aRfP0+P+/S3+5/ObjMwqiTOaIrxwGmzP0+MbHZkhPtfdzBV6W4w5gu+Y3vLT7FGl1GeE5ow
        uuZS01Zg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2mb2-00BBoJ-DF; Wed, 07 Dec 2022 05:03:52 +0000
Date:   Tue, 6 Dec 2022 21:03:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v10 05/13] kbuild: remove
 MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
Message-ID: <Y5AeuI4RD0tpzlp5@bombadil.infradead.org>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
 <20221205163157.269335-6-nick.alcock@oracle.com>
 <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
 <87mt80l2py.fsf@esperi.org.uk>
 <5f0a5ea7-2d48-435f-aaa0-82b6ef8cfcc5@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0a5ea7-2d48-435f-aaa0-82b6ef8cfcc5@app.fastmail.com>
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

On Tue, Dec 06, 2022 at 10:02:30PM +0100, Arnd Bergmann wrote:
> On Tue, Dec 6, 2022, at 21:03, Nick Alcock wrote:
> > On 6 Dec 2022, Geert Uytterhoeven uttered the following:
> > Only MODULE_LICENSE invokes MODULE_FILE and thus ends up introducing a
> > KBUILD_MODOBJS entry that triggers things going wrong iff not a module:
> > so only it needs to go out (or be replaced with a variant that doesn't
> > invoke MODULE_FILE, if you want to keep the license in too --
> 
> That sounds like a better alternative
> 
> > but if the thing is no longer a standalone entity at all I'm not sure
> > what meaning it could possibly have).
> 
> As far as I can tell, the general trend is to make more things modules,
> so there is a good chance that these come back eventually. If the
> information in the MODULE_LICENSE field isn't wrong, I would just
> leave it in there.

Tooling today uses it though to make a deterministic call on if something
*can* be a module. In particular after commit 8b41fc4454e ("kbuild: create
modules.builtin without Makefile.modbuiltin or tristate.conf") we rely on
the module license tag to generate the modules.builtin file. This in
turn is used to allow modprobe to *not* fail when trying to load a module
which is built-in.

So we can't just disable the tag for when the code is built-in as *want*
to carry it when modules are built-in, that is the point, to help
userspace with this determination.

I don't think we want to revert 8b41fc4454e as it means we'd force Kbuild to
traverse the source tree twice.

Geert's point was not keeping MODULE_LICENSE() but instead the other
MODULE_*() crap for things which are not modules in case in the future
code becomes a module...

But I don't see the point in keeping things around just in case, if we
want to keep things simple. Just use the SPDX license tag for the license.

  Luis
