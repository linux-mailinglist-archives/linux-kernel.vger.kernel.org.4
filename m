Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66ED74F28D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGKOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGKOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED99BC;
        Tue, 11 Jul 2023 07:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B095D61516;
        Tue, 11 Jul 2023 14:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5FFC433C8;
        Tue, 11 Jul 2023 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689086791;
        bh=3WlG9NIJ9IJ14F4KJ6TLUGvBBU5GtmsGOlO1DrBuxq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oINXfCrvcaBirhpikeSfDD/oMCD4/pqb52pznbD3fbcLQLZcorp2Gk2NR/eVufmVE
         pNBJLt/autK22HGtSeCTrcjEiJGGNDWHvaDZ/zu2gxiSqytxjKtbc+l6gL7nTDe9cQ
         UDs1OY4LN52kWXlLs4G/66Bo1Y9Q+5n1RlLas8yx6L+JeNRI/GLGDutSvMONICt0v/
         lZ6sYY9zVT7LUh81lfRPzKTPFWBHVy/T+RhGSPa31S2OHUNXYzwnviEBz/RSwRzRX9
         UlbGH+RDL5HmZTspYp49R4CjDOLN3vXlg5nQMrbXfhcbdr7rEiIRoIakmH/q3Xwtlr
         N2guxncJsgGNA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 508A740516; Tue, 11 Jul 2023 11:46:28 -0300 (-03)
Date:   Tue, 11 Jul 2023 11:46:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     James Clark <james.clark@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Subject: Re: [PATCH] perf build: Fix library not found error when using CSLIBS
Message-ID: <ZK1rRFO3VagSybPT@kernel.org>
References: <20230707154546.456720-1-james.clark@arm.com>
 <MN0PR12MB5953B9D303746370D9E3AB98B731A@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN0PR12MB5953B9D303746370D9E3AB98B731A@MN0PR12MB5953.namprd12.prod.outlook.com>
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

Em Tue, Jul 11, 2023 at 08:28:31AM +0000, Pandey, Radhey Shyam escreveu:
> > -----Original Message-----
> > From: James Clark <james.clark@arm.com>
> > Sent: Friday, July 7, 2023 9:16 PM
> > To: linux-perf-users@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>
> > Cc: coresight@lists.linaro.org; James Clark <james.clark@arm.com>; Peter
> > Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> > Arnaldo Carvalho de Melo <acme@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>;
> > Namhyung Kim <namhyung@kernel.org>; Ian Rogers <irogers@google.com>;
> > Adrian Hunter <adrian.hunter@intel.com>; Uwe Kleine-König <uwe@kleine-
> > koenig.org>; linux-kernel@vger.kernel.org
> > Subject: [PATCH] perf build: Fix library not found error when using CSLIBS
> > 
> > -L only specifies the search path for libraries directly provided in the link line
> > with -l. Because -lopencsd isn't specified, it's only linked because it's a
> > dependency of -lopencsd_c_api. Dependencies like this are resolved using
> > the default system search paths or -rpath-link=... rather than -L. This means
> > that compilation only works if OpenCSD is installed to the system rather than
> > provided with the CSLIBS (-L) option.
> > 
> > This could be fixed by adding -Wl,-rpath-link=$(CSLIBS) but that is less
> > conventional than just adding -lopencsd to the link line so that it uses -L. -
> > lopencsd seems to have been removed in commit ed17b1914978 ("perf
> > tools: Drop requirement for libstdc++.so for libopencsd check") because it
> > was thought that there was a chance compilation would work even if it didn't
> > exist, but I think that only applies to libstdc++ so there is no harm to add it
> > back. libopencsd.so and libopencsd_c_api.so would always exist together.
> > 
> > Testing
> > =======
> > 
> > The following scenarios now all work:
> > 
> >  * Cross build with OpenCSD installed
> >  * Cross build using CSLIBS=...
> >  * Native build with OpenCSD installed
> >  * Native build using CSLIBS=...
> >  * Static cross build with OpenCSD installed
> >  * Static cross build with CSLIBS=...
> > 
> > Reported-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > Closes: https://lore.kernel.org/linux-arm-kernel/56905d7a-a91e-883a-b707-
> > 9d5f686ba5f1@arm.com/
> > Link: https://lore.kernel.org/all/36cc4dc6-bf4b-1093-1c0a-
> > 876e368af183@kleine-koenig.org/
> > Fixes: ed17b1914978 ("perf tools: Drop requirement for libstdc++.so for
> > libopencsd check")
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/Makefile.config | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config index
> > 0609c19caabd..c5db0de49868 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -155,9 +155,9 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto  ifdef
> > CSINCLUDES
> >    LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
> >  endif
> > -OPENCSDLIBS := -lopencsd_c_api
> > +OPENCSDLIBS := -lopencsd_c_api -lopencsd
> >  ifeq ($(findstring -static,${LDFLAGS}),-static)
> > -  OPENCSDLIBS += -lopencsd -lstdc++
> > +  OPENCSDLIBS += -lstdc++
> >  endif
> >  ifdef CSLIBS
> >    LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
> > --
> > 2.34.1
> 
> Tested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Cross compiled for aarch64 on x86_64.
> 
> make ARCH=arm64 NO_LIBELF=1 NO_JVMTI=1 VF=1 CORESIGHT=1 -C  tools/perf
> 
> file <snip>/linux-xlnx/tools/perf/perf
> perf: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), 
> dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, 
> BuildID[sha1]=ef7c524338577b14e7c0f914d882dec4d26e93a2, 
> for GNU/Linux 3.14.0, with debug_info, not stripped

Thanks for reporting and testing, applied to perf-tools. I see no
problems in my common case which is:

⬢[acme@toolbox perf-tools]$ alias m='make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools -C tools/perf install-bin && git status && perf test python ;  perf record -o /dev/null sleep 0.01 ; perf stat --null sleep 0.01'
⬢[acme@toolbox perf-tools]$

⬢[acme@toolbox perf-tools]$ ldd ~/bin/perf | grep csd
	libopencsd_c_api.so.1 => /lib64/libopencsd_c_api.so.1 (0x00007f9c012ea000)
	libopencsd.so.1 => /lib64/libopencsd.so.1 (0x00007f9c00556000)
⬢[acme@toolbox perf-tools]$

- Arnaldo
