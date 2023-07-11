Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188CC74EFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjGKNGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjGKNGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEA195;
        Tue, 11 Jul 2023 06:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06728614D3;
        Tue, 11 Jul 2023 13:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427CFC433C8;
        Tue, 11 Jul 2023 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689080763;
        bh=0FOzZUJARmHg6QgAZ+V4eCa4CFli5RZZAm98amnNfdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkNwFpNPD846052yBlmCVvd5vti4sjhiYnY2CkYsUzkl5HU6pCUAYZnPvKc7VZe3n
         aW1zEEEtNWgKxUbvk7VqA6LgOxF2+rR6QwNkZnsj3ixmWbjkd3QTI7ZvZFTwkg5dht
         jF7qvWsBdGSvUSHQ09do5RP3OMGk/eP5PsYhKK4OcyiPE/e0fr5DkE0NuHM00/xy1z
         NWs26vMUbRKkOCRNTRVO40u2swxCtAbNFa8WR4Za+D5NiyPLxkudvQrouJ5A9epgMH
         /PGmSFydkuwgqqaGIEn9NaT4TNux8b3yjEIeKWuE8BmyTjTegv3OT0rd+7UqYcFso4
         f+R5eSD9Lab2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC11F40516; Tue, 11 Jul 2023 10:06:00 -0300 (-03)
Date:   Tue, 11 Jul 2023 10:06:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, rostedt@goodmis.org, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf/build: fix broken dependency check for libtracefs
Message-ID: <ZK1TuFAK0VL5vfR5@kernel.org>
References: <20230711124019.3167321-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711124019.3167321-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 11, 2023 at 02:40:19PM +0200, Thomas Richter escreveu:
> Perf build auto-detects features and packages already installed
> for its build. This is done in directory tools/build/feature. This
> directory contains small sample programs. When they successfully
> compile the necessary prereqs in form of libraries and header
> files are present.
> 
> Such a check is also done for libtracefs. And this check fails:
> 
> Output before:
>  # rm -f test-libtracefs.bin; make test-libtracefs.bin
>  gcc  -MD -Wall -Werror -o test-libtracefs.bin test-libtracefs.c \
> 	 > test-libtracefs.make.output 2>&1 -ltracefs
>  make: *** [Makefile:211: test-libtracefs.bin] Error 1
>  # cat test-libtracefs.make.output
>  In file included from test-libtracefs.c:2:
>  /usr/include/tracefs/tracefs.h:11:10: fatal error: \
> 	 event-parse.h: No such file or directory
>    11 | #include <event-parse.h>
>       |          ^~~~~~~~~~~~~~~
>  compilation terminated.
>  #
> 
> The root cause of this compile error is
> commit 880885d9c22e ("libtracefs: Remove "traceevent/" from referencing libtraceevent headers")
> in the libtracefs project hosted here:
>  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
> 
> That mentioned patch removes the traceevent/ directory name from
> the include statement, causing the file not to be included even
> when the libtraceevent-devel package is installed. This package contains
> the file referred to in tracefs/tracefs.h:
>  # rpm -ql libtraceevent-devel
>  /usr/include/traceevent
>  /usr/include/traceevent/event-parse.h  <----- here
>  /usr/include/traceevent/event-utils.h
>  /usr/include/traceevent/kbuffer.h
>  /usr/include/traceevent/trace-seq.h
>  /usr/lib64/libtraceevent.so
>  /usr/lib64/pkgconfig/libtraceevent.pc

Ok, but since libtraceevent comes with a pkgconfig file, shouldn't we
use it instead?

Something like:

⬢[acme@toolbox perf-tools]$ pkgconf --cflags libtraceevent
-I/usr/include/traceevent

look for PKG_CONFIG in the perf makefiles, I see things like:

  FLAGS_GTK2=$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)

etc.

- Arnaldo

>  #
> 
> With this patch the compile succeeds.
> 
> Output after:
>  # rm -f test-libtracefs.bin; make test-libtracefs.bin
>  gcc  -MD -Wall -Werror -o test-libtracefs.bin test-libtracefs.c \
> 	 > test-libtracefs.make.output 2>&1 -I/usr/include/traceevent -ltracefs
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: jolsa@kernel.org
> Cc: rostedt@goodmis.org
> ---
>  tools/build/feature/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 0f0aa9b7d7b5..764b0234161f 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -208,7 +208,7 @@ $(OUTPUT)test-libtraceevent.bin:
>  	$(BUILD) -ltraceevent
>  
>  $(OUTPUT)test-libtracefs.bin:
> -	$(BUILD) -ltracefs
> +	 $(BUILD) -I/usr/include/traceevent -ltracefs
>  
>  $(OUTPUT)test-libcrypto.bin:
>  	$(BUILD) -lcrypto
> -- 
> 2.41.0
> 

-- 

- Arnaldo
