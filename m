Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2C6A4AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjB0TfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjB0TfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:35:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC459747;
        Mon, 27 Feb 2023 11:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJRTd8Yqy+MKIbKEqfBFmfElkdB32vAftEc/jNhxynI=; b=aTPS63brIe3zos3V8Qw4c1xMpN
        /GueHkc1+Xd2bvAYL7ytH8avLiX6UDhMYdTEhVbrOiZsMENTLh/IZcdkjtD/DDeKeGn9BjqyJ4Bix
        TmLMUYPX5cOs0RZ9qaXmF+t/TeOAFMrxtxktb7rIaEntTMd6qabWGCv5r1zRiJHV6/K8RTB2htr6c
        ItQfzaELuN9gct26Yhs/UgO2iImHfN8vsfBwgCR12+tBf1A2U8HT1cOQTAfEeWVNAD+tQ/mfnkDgh
        FZZHUh0NtllwjRG9ZKrLRmInJ7Ijd61meEiQIht54EncVbuK/L7pwGanEaFgYyZxck9ePF99Wmrrx
        W2vUmpFA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWjHJ-00AyOG-IS; Mon, 27 Feb 2023 19:35:17 +0000
Date:   Mon, 27 Feb 2023 11:35:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/27] irqchip: remove MODULE_LICENSE in non-modules
Message-ID: <Y/0F9SpM1HLO4Jm/@bombadil.infradead.org>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-10-nick.alcock@oracle.com>
 <86y1onw02k.wl-maz@kernel.org>
 <Y/jyJFXqlj9DlX9z@bombadil.infradead.org>
 <86wn47vue1.wl-maz@kernel.org>
 <Y/kXDqW+7d71C4wz@bombadil.infradead.org>
 <87v8jni6ls.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8jni6ls.fsf@esperi.org.uk>
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

On Mon, Feb 27, 2023 at 01:24:31PM +0000, Nick Alcock wrote:
> On 24 Feb 2023, Luis Chamberlain spake thusly:
> > Modules that are compiled in should succeed with a modprobe call as its
> > already loaded. The construct we're looking for is a way to detect
> > things which are built-in but *could* be modules. The annotation today
> > is done at build time for something built-in using a file path using
> > modinfo.
> >
> > All of the module macros which peg .modinfo section information for
> > built-in code can be extracted from vmlinux using objcopy -j .modinfo, and
> > that's exactly how modules.builtin.modinfo is built:
> >
> > objcopy -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
> >
> > From this we grep out the "file:" and sed it with a ^kernel prefix.
> > You can look at the commit 8b41fc4454e ("kbuild: create modules.builtin
> > without Makefile.modbuiltin or tristate.conf") which did that.
> >
> > If a module is built-in then MODULE_FILE() is used we and we add a
> > MODULE_INFO(file, KBUILD_MODFILE), and so the modinfo exists for the
> > "file:" tag for it. At build time we sed for all those with a kernel prefix
> > to build the modules.builtin file. That file is used by modprobe to tell
> > us "yes your module is loaded as its built-in".
> >
> > So the thing we wish to not have present is when built-in code is being
> > compiled but *cannot possibly* be module, and we have no way to verify that.
> >
> > So one way to go about this is to simply *not* use the MODULE_LICENSE()
> > which cannot possibly be modules so to simplfy the build process.
> 
> I do wonder if I should drop this excellent description (up to the place
> where you start musing on alternatives) into the cover letters for the
> remaining two tranches in this series, to forestall further confusion.
> Any objection? (I doubt it, but it seems right to ask.)

Cover letters die, commit logs don't. So use it either as part of the
commit log or refer to this thread on the commit log. You can also try
to condense / paraphrase my description somehow too.

  Luis
