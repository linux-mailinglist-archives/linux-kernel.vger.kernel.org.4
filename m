Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48C67C28E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjAZBqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZBqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:46:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB214B1B2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:46:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CA37B81B99
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED66C433EF;
        Thu, 26 Jan 2023 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674697569;
        bh=ISaeOmOM3kCAsLFU8We6f/ym3iORXFNgcC3FJNjdmqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJTNu+nrrVNBzgOjAFb3LlVB4tHkZepX6M6UQywzI1lX5JGkv5w4hRkqxZdTJ+sAu
         Z84GYk0Pg7ESQrPhU6NKs2Q6lRg4tMXRYE/xZW3rxdBxuFas+uENHVAPPiOCdgZLD5
         qwEK8F6aiZJug59mZw9oKHVZf2iq0c1FSPlEVbjdNSnJgY8X6fRfP1BCnZ8f+OYQ4D
         SujNUxiISOc7+0/CYggdeaMOeU/dV/sK/Kbeal3AoXbmKLi7FhCix9wppmrACVPjYZ
         iabYBqzmO0eP3c7FBFM57WWrN286Rr7nZEwuD7XzSCHktj49OqmVehYoLpqmBYWnni
         lI9QxUcZxVBJA==
Date:   Wed, 25 Jan 2023 17:46:06 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 1/3] objtool: Install libsubcmd in build
Message-ID: <20230126014606.idgutoohowyel6ei@treble>
References: <20230105090155.357604-1-irogers@google.com>
 <20230105090155.357604-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105090155.357604-2-irogers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:01:53AM -0800, Ian Rogers wrote:
> Including from tools/lib can create inadvertent dependencies. Install
> libsubcmd in the objtool build and then include the headers from
> there.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

After a make, "git status" shows:

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	tools/objtool/libsubcmd/

So tools/objtool/.gitignore needs an update.

> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -12,9 +12,15 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>  endif
>  
> -SUBCMD_SRCDIR		= $(srctree)/tools/lib/subcmd/
> -LIBSUBCMD_OUTPUT	= $(or $(OUTPUT),$(CURDIR)/)
> -LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
> +LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
> +ifneq ($(OUTPUT),)
> +  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> +else
> +  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
> +endif
> +LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)

Similar to Nicolas' comment, it's confusing to have two variables with
the same value.  Please s/LIBSUBCMD_DESTDIR/LIBSUBCMD_OUTPUT/

> +LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
> +CFLAGS += -I$(LIBSUBCMD_OUTPUT)/include

As far as I can tell, this CFLAGS addition is both ineffective (it's
overwritten later) and unnecessary (it's made redundant by the same
addition to the INCLUDES variable).

-- 
Josh
