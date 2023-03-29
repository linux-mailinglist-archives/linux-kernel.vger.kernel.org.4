Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E06CF323
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC2T21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2T20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:28:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50A5131;
        Wed, 29 Mar 2023 12:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81D8AB82421;
        Wed, 29 Mar 2023 19:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21567C433EF;
        Wed, 29 Mar 2023 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680118102;
        bh=n2gnevI6MCSN/675S6T68W/22XOQH2Cm/6VpZQ7bCMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHlXk9lQvYavvnzWQF7OgR0SKuJB+4dMv71r773TQhCun82s5T54EpLQyluHNx20+
         fEEmcyIELVY9xo4i0GCBuBWUkWagY6jUypmp1oyvukgBXpxBCrhlKEH8xbp7xBxX8t
         3lVq5OmY5TBu0k+FgbGhJ1Vn8Q2R8S6w5ARlh0gVYWPXKoIKlz4uU1VaAPhA13lQvu
         OGHADxSCyhcsESH3uFZyraLPuTfikJN0QhuLQ6T37BEX1LU/vHEME28/8zDG3ZobJm
         NciIVegdfXMYxQo753c7ynsNpfbNfIdQaNVhukKUyAx5AjCPg9kTOGHYpoP1LKBh93
         nvKYHhvN93B4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 542734052D; Wed, 29 Mar 2023 16:28:19 -0300 (-03)
Date:   Wed, 29 Mar 2023 16:28:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
Message-ID: <ZCSRU8zvjjBHhq+x@kernel.org>
References: <20230329111422.3693-1-mike.leach@linaro.org>
 <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org>
 <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
 <ZCQ7nhrISA+jCfnI@kernel.org>
 <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 29, 2023 at 03:47:25PM +0100, Mike Leach escreveu:
> On Wed, 29 Mar 2023 at 14:22, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Wed, Mar 29, 2023 at 01:59:10PM +0100, Mike Leach escreveu:
> > > Sorry - my error.
> > >
> > > The same change is made in patch 3/3 of this set.
> > >
> > > Looks like I didn't do a patch by patch build check when I was testing yesterday
> >
> > np, its fixed now and pushed to tmp.perf-tools-next, please check, will
> > go to perf-tools-next later today after passing thru my set of container
> > build tests.
> >
> > - Arnaldo
> 
> tmp.perf-tools-next - Builds and tests OK

Not here, I'll check after a call:

  50     9.90 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
    arch/arm/util/cs-etm.c: In function 'cs_etm_save_ete_header':
    arch/arm/util/cs-etm.c:720:29: error: implicit declaration of function 'coresight_get_trace_id' [-Werror=implicit-function-declaration]
      data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
                                 ^~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-6.3.0-rc1/tools/build/Makefile.build:140: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-6.3.0-rc1/tools/build/Makefile.build:140: recipe for target 'arm' failed
    make[4]: *** [arm] Error 2
    /git/perf-6.3.0-rc1/tools/build/Makefile.build:140: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  51     9.50 ubuntu:18.04-x-arm64          : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
    arch/arm64/util/../../arm/util/cs-etm.c: In function 'cs_etm_save_ete_header':
    arch/arm64/util/../../arm/util/cs-etm.c:720:29: error: implicit declaration of function 'coresight_get_trace_id' [-Werror=implicit-function-declaration]
      data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
                                 ^~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-6.3.0-rc1/tools/build/Makefile.build:140: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-6.3.0-rc1/tools/build/Makefile.build:140: recipe for target 'arm64' failed
    make[4]: *** [arm64] Error 2
    /git/perf-6.3.0-rc1/tools/build/Makefile.build:140: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  52    19.34 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
