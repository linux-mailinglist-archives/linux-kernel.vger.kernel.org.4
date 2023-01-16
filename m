Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494CA66CFD2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjAPTyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjAPTyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:54:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C962BF2D;
        Mon, 16 Jan 2023 11:54:01 -0800 (PST)
Date:   Mon, 16 Jan 2023 19:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673898839;
        bh=ARGvl2m1NNtgaymWZQKNEjlSTSb7He8V1DW2TX+nKWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLG8DVv40GlzM3yfscsq4KGw/6Tv7qQeFn+Ww+xw0MqDj98G+uNsM4SzU3az6ZdEk
         lqlZCw0I2Y5drOAaYTauxrUpdIvSH8rvdI3A3THq30+qOSfGHdgv4LLkwigv71qLH8
         fVtLT2FSvgbW6ECl0h/kQxnB4KkYBeyALrIxcqGw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Amy Parker <apark0006@student.cerritos.edu>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: Kernel builds now failing
Message-ID: <20230116195357.2jq7q262tongxw52@t-8ch.de>
References: <CAPOgqxFva=tOuh1UitCSN38+28q3BNXKq19rEsVNPRzRqKqZ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPOgqxFva=tOuh1UitCSN38+28q3BNXKq19rEsVNPRzRqKqZ+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amy,

On Mon, Jan 16, 2023 at 11:24:19AM -0800, Amy Parker wrote:
> As of recent, my kernel builds have started failing. The error is consistently:
> 
> find: 'standard output': Broken pipe
> find: write error
> make[2]: *** [kernel/Makefile:157: kernel/kheaders_data.tar.xz] Error 127
> make[1]: *** [scripts/Makefile.build:504: kernel] Error 2
> 
> This fails on the default Arch configuration (6.1.5-arch2-1, defaults
> for all new features) as well as with allmodconfig.
> 
> Everything was building fine before - this may be a regression, or
> just may be a problem with something in my toolchain updating and
> causing it to break. In that case, any assistance with getting my
> toolchains back to being able to compile would be appreciated.

I expect this to be due to a change in make 4.4 that ignores SIGPIPEs [0].
So programs called from make will not receive a SIGPIPE when writing to
a closed pipe but instead an EPIPE write error.
`find` does not seem to handle this.

This behavior in make is new and I can't find a reasoning for it.
It also breaks other softwares builds.

For now you can disable CONFIG_IKHEADERS and the build should work
again.

Thomas

[0] make 4.4 was packaged for ArchLinux on 5th of January, so it would
fit the timeline.
