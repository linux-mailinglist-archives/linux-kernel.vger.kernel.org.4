Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CC5F6709
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiJFM7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiJFM6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:58:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432F1136
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:58:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v186so1938907pfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xJSOslAEAhqhcHvY18RtL9xpSS+8ATuqme/3JBQe9W0=;
        b=F+Z8zTYwsQ4oA2iB1DT4HidsGFsxp4YvXcTAqz9WwmD0NNRaNIXGtHksUhgoV9vB0y
         9deVf0Zz2KDK6vFpGbhDs6PTdUSYgWA72zjbjEzM91zCNhbBU+ghp9gpqKX7jfCHscda
         TNMNaD2vQiKoGii+KkeZObkOaU0GjL4kPPXXguNLYM3IShYiK5Lv0CtSbUinbeHeLXti
         dcByEQ/mQJGskHF2pokgkITFW5k+m6w+FTUhwCroS+RImfxkZ0SJVQG7AZQCgxDtKpYO
         hIhznAXKt4gQiNGrfQ98UnLYYAgxcxrTee1Xp2eWOPh4UiXutQV9NF252WGkYweJOT4H
         djgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xJSOslAEAhqhcHvY18RtL9xpSS+8ATuqme/3JBQe9W0=;
        b=xlODPQwU/mLMWvXqCKHrbgpjmDVSMaqRoUuKBvvEP4LgsmHXjo3XAYrilZkCgpYYXp
         8pTf/9puyA+D+auBrhmDwStTedwspRjY6X+4dMs23gnmfEfHn400eTRtlY+soh9mPRFb
         i6iHWUIYwZCvgJukN7CJKS7UTMUNX9+XldrfgKrpX5PTC7b1Ky8OPEXviyIl6oUPUh7S
         0CBinmDaVZtU+3y1s3zOU2X+N27CtKSsSL9iyRrT1ekkH1ghIKcBRP9VOf1NjKFw7+M3
         zGHSxzTCziE8MGojKIqw8L+Uz5vCk4Knmw/NJOBBTCC+tE8MML2WoPNmDJFMgylbak68
         jaNw==
X-Gm-Message-State: ACrzQf1bqmMEd/fpZRPRjDE8NvE5seN2tqCQYvIJek5VdeSZDA3JzO1l
        Iz+AzmNUxCv75/0GdPnl6YpIXg==
X-Google-Smtp-Source: AMsMyM7jW1bilqEPp536XwCQi47C8NGy3+J9ufJG9f4DTOzMz4xszNRVpiggV5zA1DvpOm0bP3AI1Q==
X-Received: by 2002:a62:1791:0:b0:562:2298:b33c with SMTP id 139-20020a621791000000b005622298b33cmr4602266pfx.25.1665061129495;
        Thu, 06 Oct 2022 05:58:49 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net. [211.75.219.202])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b00178b9c997e5sm8111493plh.138.2022.10.06.05.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:58:48 -0700 (PDT)
Date:   Thu, 6 Oct 2022 20:58:42 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     carsten.haitzler@foss.arm.com, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6/zlchVnNsVlzJ@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Oct 06, 2022 at 08:45:18AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 06, 2022 at 08:26:00AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Sep 09, 2022 at 04:27:52PM +0100, carsten.haitzler@foss.arm.com escreveu:
> > > +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
> > >  
> > >  # Create python binding output directory if not already present
> > >  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> > > @@ -1007,6 +1015,9 @@ install-tests: all install-gtk
> > >  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > >  		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > >  		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > > +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > > +		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > > +	$(Q)$(MAKE) -C tests/shell/coresight install-tests
> > 
> > Added a missing ;\ on the line installing the *.py and adjusted use -m
> > 644 for the .sh files to follow what was done in:
> > 
> >   0a9eaf616f29ca32 ("perf tools: Don't install data files with x permissions")
> > 
> > @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
> >                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
> >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> >                 $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > +               $(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> > 
> 
> Also had to remove:
> 
> 		$(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> 
> from this patch, as it makes install fail at this point in the patchset:

Thanks a lot!

James and me had found the merging conflict and planned to send out
email for reminding it, the right change for above section would be:

@@ -1006,7 +1014,10 @@ install-tests: all install-gtk
                $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
                $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
+               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
+               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
+       $(Q)$(MAKE) -C tests/shell/coresight install-tests

It's deliberately to not add '-m 644' when install coresight test
shell scripts under the folder tests/shell/coresight/ so that we can
keep the executable permission for these scripts.  On the other flip,
we set 644 mode for the scripts under tests/shell/lib/ so these
scripts will not be executed directly by perf test framework.

@Carsten, if have chance could you confirm for above change?

>   DESCEND plugins
>   GEN     /tmp/build/perf/python/perf.so
>   INSTALL trace_plugins
>   INSTALL binaries
>   INSTALL tests
> install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
> make[2]: *** [Makefile.perf:1007: install-tests] Error 1
> make[2]: *** Waiting for unfinished jobs....
> 
> I'll add it back when the first .sh gets added to tests/shell/coresight/

Sorry for introducing extra efforts for you and thanks!

Leo
