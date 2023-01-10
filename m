Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946A7664399
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjAJOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbjAJOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:48:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3A4FD7F;
        Tue, 10 Jan 2023 06:48:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54A266175A;
        Tue, 10 Jan 2023 14:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5491AC433D2;
        Tue, 10 Jan 2023 14:48:16 +0000 (UTC)
Date:   Tue, 10 Jan 2023 09:48:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/rtla: Explicitly list libtraceevent dependency
Message-ID: <20230110094814.4af966a4@gandalf.local.home>
In-Reply-To: <20230110131805.16242-1-dwagner@suse.de>
References: <20230110131805.16242-1-dwagner@suse.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 14:18:05 +0100
Daniel Wagner <dwagner@suse.de> wrote:

> The current libtracefs.pkg file lists the dependency on
> libtraceevent ("pkg-config --libs libtracefs" -> "-ltracefs
> -ltraceevent").
> 
> Dan Nicholson's Guide to pkg-config[1] stats that "Libs: The link
> flags specific to this package and any required libraries that don't
> support pkg-config". Thus the current libtracefs.pkg is not correct.
> 
> rtla is depending on libtraceevent but it doesn't express this in
> 'pkg-config' part to retrieve the correct build flags.
> 
> In order to be able to update the "Libs:" section in the libtracefs
> project we need to list the dependency explicitly to avoid future linker
> failures.
> 
> [1] https://people.freedesktop.org/~dbn/pkg-config-guide.html

The Libs: field in tracefs only shows the -ltracefs and not -ltraceevent.
It follows this rule. It's the "Requires:" tag that pulls in -ltraceevent,
correctly.

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> I've got this fallout with because I am using libtraceevent and libtracefs build
> with Meson. Meson generates different pkg files which seems to align with Dan's
> Guide.
> 
>  tools/tracing/rtla/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 22e28b76f800..0664e2db22c1 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -32,7 +32,7 @@ TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
>  
>  CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS)
>  LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
> -LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
> +LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs libtraceevent)

I'm still confused as to why this is needed.

According to Dan's document:

Requires: A list of packages required by this package. The versions of these packages may be specified using the comparison operators =, <, >, <= or >=.
Requires.private: A list of private packages required by this package but not exposed to applications. The version specific rules from the Requires field also apply here.

The "Requires" is exported to other applications. It's the private that is
not.

What is this trying to fix?

-- Steve


>  
>  SRC	:=	$(wildcard src/*.c)
>  HDR	:=	$(wildcard src/*.h)

