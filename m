Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD274F4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGKQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGKQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD1EE7E;
        Tue, 11 Jul 2023 09:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E39D61549;
        Tue, 11 Jul 2023 16:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A382FC433C8;
        Tue, 11 Jul 2023 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689092131;
        bh=bJhJ5ldqh1RC4u2ucoivoNiS+23oP96DkhoEyS6UazY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2nW+rWmftosc01WmZ8NJ7bttTZcZT8YyUX5AcF1p9XE2oDkFijgHysYyRzuO8wR8
         k0qrpc+Xt4OrMhqkjpzvNe8ic6CKy1KEDa9GS7o12lStT8qoaDRmYq2803uU5Rg4G2
         Ni42N1f8UlbNkD30Z8AS82rj1A6RI2I3V2EVATkpAGKxm7gzXyhDoYYICoWxdF/XHA
         hwRx5q9WqnbmZYCoA3aOYnpa7HuzU/81/pH7xdLYhh50S+n5l3w7G+e2Tck3VCfK89
         1I/SjU+Dh5mrHaoaWWiWXv4lw9DoQXqwqVTiRwDww+isTaunx8rUIs/l9HMkRuwXER
         bIMC52Fnjz1Ug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 550DE40516; Tue, 11 Jul 2023 13:15:29 -0300 (-03)
Date:   Tue, 11 Jul 2023 13:15:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, rostedt@goodmis.org, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2] perf/build: fix broken dependency check for libtracefs
Message-ID: <ZK2AISIWZX5GlOZv@kernel.org>
References: <20230711135338.397473-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711135338.397473-1-tmricht@linux.ibm.com>
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

Em Tue, Jul 11, 2023 at 03:53:38PM +0200, Thomas Richter escreveu:
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
>  #
> 
> With this patch the compile succeeds.
> 
> Output after:
>  # rm -f test-libtracefs.bin; make test-libtracefs.bin
>  gcc  -MD -Wall -Werror -o test-libtracefs.bin test-libtracefs.c \
> 	 > test-libtracefs.make.output 2>&1 -I/usr/include/traceevent -ltracefs
>  #

Thanks! I test it like this:

Committer testing:

  $ make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools -C tools/perf install-bin

Before:

  $ cat /tmp/build/perf-tools/feature/test-libtracefs.make.output
  In file included from test-libtracefs.c:2:
  /usr/include/tracefs/tracefs.h:11:10: fatal error: event-parse.h: No such file or directory
     11 | #include <event-parse.h>
        |          ^~~~~~~~~~~~~~~
  compilation terminated.
  $
  $ grep -i tracefs /tmp/build/perf-tools/FEATURE-DUMP
  feature-libtracefs=0
  $

After:

  $ cat /tmp/build/perf-tools/feature/test-libtracefs.make.output
  $
  $ grep -i tracefs /tmp/build/perf-tools/FEATURE-DUMP
  feature-libtracefs=1
  $

Applied to perf-tools, for v6.5.

- Arnaldo
