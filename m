Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E85C6B631D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 05:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCLEOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 23:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLEOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 23:14:35 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Mar 2023 20:14:33 PST
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A142BDF;
        Sat, 11 Mar 2023 20:14:33 -0800 (PST)
Received: from brak.codesynthesis.com (unknown [105.186.89.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id BDF8F60A50;
        Sun, 12 Mar 2023 04:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1678594095;
        bh=HUX6NiMs9PrhTbVq5VNF8nLaHuCM5SJJF1HzkUDIUTk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=gYn1bjKmaqhylYoZJ6XpkqbJYShUe8SO6Qgs3IvkRqN/SO+I5P0F1Y34zqePwFFFV
         7ZVNz7Vpl4+bh+nwDJXIEFs3XXGG1o8pNCAjhW+cU669LTV2H7eFwtXAjoomKpF5d7
         P3dS5pOVAZctGq46G3Yz0kUKc+F0zc/fs93SRk69X/zPez6QYDhVflPCxY1G/EwB8M
         FvvhEKfQHGeMhCz+fY7CybtuE7nwfWMa5xaUTLXpDPuuXHLGHpdjGrCd2qmvyXePb0
         AMc47S3mlcVbClTg6XD/mWRqxGpy3EDac2PO8E6sg73wspZs/RNtn98sC9wp2gcRxt
         w4NsCSQNcbJtA==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id DF294142BD9; Sun, 12 Mar 2023 06:08:09 +0200 (SAST)
Date:   Sun, 12 Mar 2023 06:08:09 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Tom Rini <trini@konsulko.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Simon Glass <sjg@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        U-Boot Custodians <u-boot-custodians@lists.denx.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        barebox@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [RESEND PATCH] kconfig: Proposed language extension for multiple
 builds
Message-ID: <boris.20230312054230@codesynthesis.com>
References: <20230310183717.RESEND.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <bae2702e-3570-f461-b86f-e56ce82a636e@infradead.org>
 <20230311165507.GN3041508@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311165507.GN3041508@bill-the-cat>
Organization: Code Synthesis
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@konsulko.com> writes:

> On Fri, Mar 10, 2023 at 09:39:15PM -0800, Randy Dunlap wrote:
> > Hi--
> > 
> > On 3/10/23 18:37, Simon Glass wrote:
> > > (I am sending this again to get more feedback)
> > > 
> > > In the case of Linux, only one build is produced so there is only a
> > > single configuration. For other projects, such as U-Boot and Zephyr, the
> > > same code is used to produce multiple builds, each with related (but
> > > different) options enabled.
> > > 
> > > This can be handled with the existing kconfig language, but it is quite
> > > verbose, somewhat tedious and very error-prone, since there is a lot of
> > > duplication. The result is hard to maintain.
> > > 
> > > Describe an extension to the Kconfig language to support easier handling
> > > of this use case.
> > > 
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > 
> > IMO Masahiro has already answered this multiple times and I agree with his answers.
> > 
> > For others, the full previous thread is at
> >   https://lore.kernel.org/all/20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid/
> 
> So what level of interest is there in this?

Unlike Masahiro & co I am interested in generalizing Kconfig to be usable
outside of the Linux kernel (for example, I've integrated it into the
build2 build system[1]). However, in this case, I tend to agree with Randy
and Masahiro: this feels like a very niche use-case (which I am still not
100% clear on, after reading the description 3 times) that would add
quite a bit of complexity.

One thing that did cross my mind during those 3 reads is that maybe the
essence of the feature you are looking for here is to be able to use a
value from the previous phase as "initial" (i.e., stronger than Kconfig
default but weaker than user-specified) when configuring the next phase.
It probably won't allow you to solve your problem in an auto-magical way
like your proposal, but perhaps you could get close enough while not
complicating the Kconfig language significantly.


> And as Simon asked in the thread, what about code refactoring that makes
> further maintenance easier?

From my experience, there is little interest in patches that make Kconfig
more general or improve the compatibility of the implementation. As a
result, I am maintaining my patch set[2] out of tree.


[1] https://build2.org/libbuild2-kconfig/doc/build2-kconfig-manual.xhtml
[2] https://github.com/build2-packaging/kconfig/tree/upstream-5.15-rc7
