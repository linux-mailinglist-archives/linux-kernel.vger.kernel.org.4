Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148565F6982
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJFOW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiJFOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:22:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92426C9;
        Thu,  6 Oct 2022 07:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02F24619C9;
        Thu,  6 Oct 2022 14:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1272AC433C1;
        Thu,  6 Oct 2022 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665066136;
        bh=BM5uURa+DGhvIFtUX3xR5G28+0xFbKPQcDjpjq4DcdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSh2egTUaInEQ0WGVxYALOrCj/bgkJASHRsnOKSMU+yVtVKnBaz/WY8tz/+V9JkMU
         G4gO7MfNXi+sk98mtB5XqjY1tl0Erso1eGqwSO/I0XEucLpqf2ADDiKF0kNSUz1fOf
         +FdxGntrNKobNNt2ZfpvTwUHrNAv1WEvHko6ovksnkH7qyxT493WpMQ6Gj/HPIJqMv
         0CzddkvK/C2j7xKPUGgWa8igN1LmvRfJVPT8JWYHg3IFtsb3TYCz4GMZVLHl0F32Bm
         htmuuCLyisCR5jjhFLFzPifUd9yxzIzpNtL3vLXgXzDV1jE/ZZ83Xmw4kUZTWfsp+9
         rC7cXG04ZRI+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 686E84062C; Thu,  6 Oct 2022 11:22:13 -0300 (-03)
Date:   Thu, 6 Oct 2022 11:22:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yz7klV3h+JJ+ilAp@kernel.org>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 08:58:42PM +0800, Leo Yan escreveu:
> Hi Arnaldo,
> 
> On Thu, Oct 06, 2022 at 08:45:18AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 06, 2022 at 08:26:00AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Sep 09, 2022 at 04:27:52PM +0100, carsten.haitzler@foss.arm.com escreveu:
> > > > +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
> > > >  
> > > >  # Create python binding output directory if not already present
> > > >  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> > > > @@ -1007,6 +1015,9 @@ install-tests: all install-gtk
> > > >  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > > >  		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > > >  		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > > > +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > > > +		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > > > +	$(Q)$(MAKE) -C tests/shell/coresight install-tests
> > > 
> > > Added a missing ;\ on the line installing the *.py and adjusted use -m
> > > 644 for the .sh files to follow what was done in:
> > > 
> > >   0a9eaf616f29ca32 ("perf tools: Don't install data files with x permissions")
> > > 
> > > @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
> > >                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
> > >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > >                 $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > > -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > > +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > > +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > > +               $(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > > +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> > > 
> > 
> > Also had to remove:
> > 
> > 		$(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > 
> > from this patch, as it makes install fail at this point in the patchset:
> 
> Thanks a lot!
> 
> James and me had found the merging conflict and planned to send out
> email for reminding it, the right change for above section would be:

Not at this patch, in this patch there are no tests/shell/coresight/*.sh
which makes 'make install' to fail _at this point_, for bisectability we
can't just test at the end of the patchkit.
 
> @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
>                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>                 $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> +               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> 
> It's deliberately to not add '-m 644' when install coresight test
> shell scripts under the folder tests/shell/coresight/ so that we can
> keep the executable permission for these scripts.  On the other flip,
> we set 644 mode for the scripts under tests/shell/lib/ so these
> scripts will not be executed directly by perf test framework.
> 
> @Carsten, if have chance could you confirm for above change?

If you need for some .sh, coresight test's to have x set while all of
the others don't have, and you have a good reason for that, ok, we just
add a comment.
 
> >   DESCEND plugins
> >   GEN     /tmp/build/perf/python/perf.so
> >   INSTALL trace_plugins
> >   INSTALL binaries
> >   INSTALL tests
> > install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
> > make[2]: *** [Makefile.perf:1007: install-tests] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > 
> > I'll add it back when the first .sh gets added to tests/shell/coresight/
> 
> Sorry for introducing extra efforts for you and thanks!

This also has to go, I'll check and fix this loop that doesn't follow
the existing output style, happens with ´make install', etc too:

⬢[acme@toolbox perf]$ make -C tools/perf clean
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  CLEAN   x86
  CLEAN   libtraceevent
  CLEAN   libapi
  CLEAN   libbpf
  CLEAN   libsubcmd
  CLEAN   libperf
  CLEAN   fixdep
  CLEAN   feature-detect
  CLEAN   python
  CLEAN   bpf-skel
make -C asm_pure_loop clean >/dev/null        <-------------------
make -C memcpy_thread clean >/dev/null        <-------------------
make -C thread_loop clean >/dev/null          <-------------------
make -C unroll_loop_thread clean >/dev/null   <-------------------
  CLEAN   core-objs
  CLEAN   core-progs
  CLEAN   core-gen
  CLEAN   Documentation
make: Leaving directory '/var/home/acme/git/perf/tools/perf'
⬢[acme@toolbox perf]$
