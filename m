Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43C5F6530
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiJFL0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiJFL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:26:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E17D1C0;
        Thu,  6 Oct 2022 04:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04BCCCE16A5;
        Thu,  6 Oct 2022 11:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA20CC433C1;
        Thu,  6 Oct 2022 11:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665055563;
        bh=zc50yCglQ5v11FScYzVrQ541pEZf51f++rX2ZgsKapI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcDBethSKqvFG/hBWKt0i1EqH3oZB5M6rwVc+jjkQDDBaV7RBTjE9qBZ+ye+JVNZ9
         dPAKVe4hNtChyPnkzJ76s9C9UCevJifl2iHIoCZvKe6ieR3xkIPAd7WNfIYgpzcQNZ
         /jBABis+7hhrXJukA2WN98YCPgpa+hoSTtEHs7TT3mUoI27FpmK/sz5dPLeVTEU2nB
         ERz7pAe8RQQgV0rOu7UgdmYTEbP9YE6aosj8tr1XAH0poxg8z5tvD6/bHWhqfPhS+Z
         uLbw2VT4WdQvoeZcpJ2XjUDVhNzzPnxqpmqpON0+Wv7Fv4cKwHx4MbL9Z4cfBUZ/Jc
         gKRR8XHMwN+XA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BCC2A4062C; Thu,  6 Oct 2022 08:26:00 -0300 (-03)
Date:   Thu, 6 Oct 2022 08:26:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     carsten.haitzler@foss.arm.com
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yz67SHpIN5NggKEk@kernel.org>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 09, 2022 at 04:27:52PM +0100, carsten.haitzler@foss.arm.com escreveu:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> This adds the initial build infrastructure (makefiles maintainers
> information) for adding follow-on tests for CoreSight.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  MAINTAINERS                                   |  1 +
>  tools/perf/Makefile.config                    |  2 ++
>  tools/perf/Makefile.perf                      | 15 +++++++++--
>  tools/perf/tests/shell/coresight/Makefile     | 25 +++++++++++++++++++
>  .../tests/shell/coresight/Makefile.miniconfig | 14 +++++++++++
>  5 files changed, 55 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/tests/shell/coresight/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..c8ae5a6638b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2029,6 +2029,7 @@ F:	drivers/hwtracing/coresight/*
>  F:	include/dt-bindings/arm/coresight-cti-dt.h
>  F:	include/linux/coresight*
>  F:	samples/coresight/*
> +F:	tools/perf/tests/shell/coresight/*
>  F:	tools/perf/arch/arm/util/auxtrace.c
>  F:	tools/perf/arch/arm/util/cs-etm.c
>  F:	tools/perf/arch/arm/util/cs-etm.h
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0661a1cf9855..e3e28b3481f9 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1291,6 +1291,8 @@ perf_examples_instdir_SQ = $(subst ','\'',$(perf_examples_instdir))
>  STRACE_GROUPS_INSTDIR_SQ = $(subst ','\'',$(STRACE_GROUPS_INSTDIR))
>  tip_instdir_SQ = $(subst ','\'',$(tip_instdir))
>  
> +export perfexec_instdir_SQ
> +
>  # If we install to $(HOME) we keep the traceevent default:
>  # $(HOME)/.traceevent/plugins
>  # Otherwise we install plugins into the global $(libdir).
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e5921b347153..cef2a06c8f54 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -629,7 +629,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
>  $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
>  	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
>  
> -all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> +TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
> +
> +tests-coresight-targets: FORCE
> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
> +
> +tests-coresight-targets-clean:
> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
> +
> +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
>  
>  # Create python binding output directory if not already present
>  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> @@ -1007,6 +1015,9 @@ install-tests: all install-gtk
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>  		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>  		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> +		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> +	$(Q)$(MAKE) -C tests/shell/coresight install-tests

Added a missing ;\ on the line installing the *.py and adjusted use -m
644 for the .sh files to follow what was done in:

  0a9eaf616f29ca32 ("perf tools: Don't install data files with x permissions")

@@ -1006,7 +1014,10 @@ install-tests: all install-gtk
                $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
                $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
                $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
+               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
+               $(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
+       $(Q)$(MAKE) -C tests/shell/coresight install-tests

  
>  install-bin: install-tools install-tests install-traceevent-plugins
>  
> @@ -1077,7 +1088,7 @@ endif # BUILD_BPF_SKEL
>  bpf-skel-clean:
>  	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
>  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>  	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)$(RM) $(OUTPUT).config-detected
> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
> new file mode 100644
> index 000000000000..3fee05cfcb0e
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../../../../../tools/scripts/Makefile.include
> +include ../../../../../tools/scripts/Makefile.arch
> +include ../../../../../tools/scripts/utilities.mak
> +
> +SUBDIRS =
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +	$(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
> +
> +.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> diff --git a/tools/perf/tests/shell/coresight/Makefile.miniconfig b/tools/perf/tests/shell/coresight/Makefile.miniconfig
> new file mode 100644
> index 000000000000..5f72a9cb43f3
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/Makefile.miniconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +ifndef DESTDIR
> +prefix ?= $(HOME)
> +endif
> +
> +DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
> +INSTALL = install
> +INSTDIR_SUB = tests/shell/coresight
> +
> +include ../../../../../scripts/Makefile.include
> +include ../../../../../scripts/Makefile.arch
> +include ../../../../../scripts/utilities.mak
> -- 
> 2.32.0

-- 

- Arnaldo
