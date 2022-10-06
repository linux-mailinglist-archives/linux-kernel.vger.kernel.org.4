Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B105F6C92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiJFRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiJFRMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559E1A99E6;
        Thu,  6 Oct 2022 10:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F12761A28;
        Thu,  6 Oct 2022 17:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A683C433D7;
        Thu,  6 Oct 2022 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665076334;
        bh=Gn5zOWGaE6XQOhS5ErhjY6nBvkD9SK3m7/8nOkO5BF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgGwmfCan9BHqyjIsGwXzwuc+iXNGXDi9iTStPGyEByT9/wwxA8SpFhpUWj6CzIi7
         j+mJhL+baZT+JzdVwYsB6y1wyI66dbsKK0MvVdhmyuhlXz612EtQkjbslubHm73su/
         LZZgbPCBCQ8n1e9hBD00jFS45q6LcA6yE8wHK3cdyRfA3KXikMaiPghrjFi8EB7fNH
         jKvEhel0ojmYWHK9XksNBaUwxAh2EvNHsLYkcA1NAufjnLxsq9KZDHn8fSxefHkXgy
         5z8nUxURkuC7wZx6EtuzMT8EWKi3u9wvuqCSpm5he615r/kZuVsnH4w65cdllsvKG+
         fN2YK8RM/UZKw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72BB74062C; Thu,  6 Oct 2022 14:12:11 -0300 (-03)
Date:   Thu, 6 Oct 2022 14:12:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yz8Ma75+RgGVYqBN@kernel.org>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <Yz7klV3h+JJ+ilAp@kernel.org>
 <Yz7vJ9Wy0zCTwp1t@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yz7vJ9Wy0zCTwp1t@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 11:07:19PM +0800, Leo Yan escreveu:
> On Thu, Oct 06, 2022 at 11:22:13AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> > > @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
> > >                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
> > >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > >                 $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > > -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > > +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> > > +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > > +               $(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > > +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> > > 
> > > It's deliberately to not add '-m 644' when install coresight test
> > > shell scripts under the folder tests/shell/coresight/ so that we can
> > > keep the executable permission for these scripts.  On the other flip,
> > > we set 644 mode for the scripts under tests/shell/lib/ so these
> > > scripts will not be executed directly by perf test framework.
> > > 
> > > @Carsten, if have chance could you confirm for above change?
> > 
> > If you need for some .sh, coresight test's to have x set while all of
> > the others don't have, and you have a good reason for that, ok, we just
> > add a comment.
> 
> Simply to say, all lib scripts are not needed for execute permission.
> Yes, it's good to add a comment for the installation steps.
> 
> > > >   DESCEND plugins
> > > >   GEN     /tmp/build/perf/python/perf.so
> > > >   INSTALL trace_plugins
> > > >   INSTALL binaries
> > > >   INSTALL tests
> > > > install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
> > > > make[2]: *** [Makefile.perf:1007: install-tests] Error 1
> > > > make[2]: *** Waiting for unfinished jobs....
> > > > 
> > > > I'll add it back when the first .sh gets added to tests/shell/coresight/
> > > 
> > > Sorry for introducing extra efforts for you and thanks!
> > 
> > This also has to go, I'll check and fix this loop that doesn't follow
> > the existing output style, happens with ´make install', etc too:
> > 
> > ⬢[acme@toolbox perf]$ make -C tools/perf clean
> > make: Entering directory '/var/home/acme/git/perf/tools/perf'
> >   CLEAN   x86
> >   CLEAN   libtraceevent
> >   CLEAN   libapi
> >   CLEAN   libbpf
> >   CLEAN   libsubcmd
> >   CLEAN   libperf
> >   CLEAN   fixdep
> >   CLEAN   feature-detect
> >   CLEAN   python
> >   CLEAN   bpf-skel
> > make -C asm_pure_loop clean >/dev/null        <-------------------
> > make -C memcpy_thread clean >/dev/null        <-------------------
> > make -C thread_loop clean >/dev/null          <-------------------
> > make -C unroll_loop_thread clean >/dev/null   <-------------------
> 
> Ouch, if we can update the file tests/shell/coresight/Makefile as below:
> 
> $(CLEANDIRS):
>         $(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null

I had to do it, so far, at the time that the above line is first added
as:

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a20b4adb5e3451f1..194e582e70c2c766 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -635,7 +635,8 @@ tests-coresight-targets: FORCE
 	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
 
 tests-coresight-targets-clean:
-	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
+	$(call QUIET_CLEAN, coresight)
+	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) O=$(OUTPUT) clean >/dev/null
 
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
 
diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
index 3fee05cfcb0e73f6..6baab5cbaa9aa3b1 100644
--- a/tools/perf/tests/shell/coresight/Makefile
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -20,6 +20,6 @@ CLEANDIRS = $(SUBDIRS:%=clean-%)
 
 clean: $(CLEANDIRS)
 $(CLEANDIRS):
-	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
+	$(call QUIET_CLEAN, test-$(@:clean-%=%)) $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
 
 .PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
 
> Then we can get output as:
> 
>   # make clean
>   CLEAN   arm64
>   CLEAN   libtraceevent
>   CLEAN   libapi
>   CLEAN   libbpf
>   CLEAN   libsubcmd
>   CLEAN   libperf
>   CLEAN   fixdep
>   CLEAN   feature-detect
>   CLEAN   python
>   CLEAN   bpf-skel
>   CLEAN   test-asm_pure_loop
>   CLEAN   test-memcpy_thread
>   CLEAN   test-thread_loop
>   CLEAN   test-unroll_loop_thread
>   CLEAN   core-objs
>   CLEAN   core-progs
>   CLEAN   core-gen
>   CLEAN   Documentation
> 
> Sorry for inconvenience.
> 
> Thanks,
> Leo

-- 

- Arnaldo
