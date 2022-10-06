Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A263E5F655E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJFLp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJFLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF12ED57;
        Thu,  6 Oct 2022 04:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523CD61913;
        Thu,  6 Oct 2022 11:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86430C433D6;
        Thu,  6 Oct 2022 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665056721;
        bh=Q1eZazJ5RxfOSUkA0Gm/LTBZPqBKWabbaJQay1sX0gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuib0PxM7Ad/imn7FUYlsTSVAK0BmQQmFZbxEpQOA2pRhjmS/Z1KmP8p3DQqlSmT4
         vWH3OdKtKsGmbCyB3y0q8gC0LjtGTYFVLF9Tt+BXX9mJwGAXbzyOsy0qsLTpGpTqzJ
         CTz/tmR6rOuc9eyp0dpLZqYDaIZfcMSImQ2OgzZaZTljmCZPu6iz0uStfWhnz4Jf5s
         ql8KNth1zbfAaIUv212fEZzGcGzbnqMkfVLQRSLovOrvjoQqA/FpwKs3RjEMSXpjjU
         AH4iKfPcN3eV/5ir8QFLyZPvjNNud3Z79mr3Ti3Ge2Vs/+RC+uYlcNmW9DgRUFDpxj
         TaSMiSmbkGnaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C244D4062C; Thu,  6 Oct 2022 08:45:18 -0300 (-03)
Date:   Thu, 6 Oct 2022 08:45:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     carsten.haitzler@foss.arm.com
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Yz6/zlchVnNsVlzJ@kernel.org>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz67SHpIN5NggKEk@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 08:26:00AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Sep 09, 2022 at 04:27:52PM +0100, carsten.haitzler@foss.arm.com escreveu:
> > +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
> >  
> >  # Create python binding output directory if not already present
> >  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> > @@ -1007,6 +1015,9 @@ install-tests: all install-gtk
> >  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> >  		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> >  		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> > +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> > +		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> > +	$(Q)$(MAKE) -C tests/shell/coresight install-tests
> 
> Added a missing ;\ on the line installing the *.py and adjusted use -m
> 644 for the .sh files to follow what was done in:
> 
>   0a9eaf616f29ca32 ("perf tools: Don't install data files with x permissions")
> 
> @@ -1006,7 +1014,10 @@ install-tests: all install-gtk
>                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>                 $(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> -               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +               $(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> +               $(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> +       $(Q)$(MAKE) -C tests/shell/coresight install-tests
> 

Also had to remove:

		$(INSTALL) tests/shell/coresight/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'

from this patch, as it makes install fail at this point in the patchset:

  DESCEND plugins
  GEN     /tmp/build/perf/python/perf.so
  INSTALL trace_plugins
  INSTALL binaries
  INSTALL tests
install: cannot stat 'tests/shell/coresight/*.sh': No such file or directory
make[2]: *** [Makefile.perf:1007: install-tests] Error 1
make[2]: *** Waiting for unfinished jobs....

I'll add it back when the first .sh gets added to tests/shell/coresight/

- Arnaldo
