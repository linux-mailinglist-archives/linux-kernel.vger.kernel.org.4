Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F27724CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjFFTW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFFTWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47671E54;
        Tue,  6 Jun 2023 12:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D811E60B40;
        Tue,  6 Jun 2023 19:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15264C433D2;
        Tue,  6 Jun 2023 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686079341;
        bh=DBYmzHuPHkwucG5VoIBnkboHLXA2sieirXXZYE1UaM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMpsTmE/cCRvt2ECAvZHSxi7nrJZALDVlWhJTLSU0NrAJTY0rxuy74QrBvPD0HAom
         h8Y1yUG+k6GmbokswUR41wuW/X7lqVNCjwgjbJz+Iw6bJ9gq66qKf7Jzj9xdcFC5tE
         pn4EsaukqLly2hbGEuOReP0YHNLME345jfG+mXJy8riRKyFkL6eP+PLLfiK9Jynhxr
         7+7tBGrzSlB9bm5SUVKpt2bqtN6RTp7qBPUB1hNMPFW7ci8+HLDoymP0bAIOzBhBiU
         wJI7hWoNYg1YLiBrk7BunN2VpGaC6TkhNB2b4IOLXn4hvP1GY1uMav6TyvHudhzS0m
         ibQ3DOb9GNcnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4BB6740692; Tue,  6 Jun 2023 16:22:18 -0300 (-03)
Date:   Tue, 6 Jun 2023 16:22:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V3 0/1] perf tools: Allow config terms with breakpoints
Message-ID: <ZH+Havh+xRIfwa4n@kernel.org>
References: <20230525082902.25332-1-adrian.hunter@intel.com>
 <afe1c05a-2b77-c3d8-aacf-b4c7bebb8bf8@intel.com>
 <ZH933yJMYTr0cC+N@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZH933yJMYTr0cC+N@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 06, 2023 at 03:15:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jun 06, 2023 at 08:00:33AM +0300, Adrian Hunter escreveu:
> > On 25/05/23 11:29, Adrian Hunter wrote:
> > > Hi
> > > 
> > > Here is a patch (V3) to the event parser for breakpoint events.
> > > I am not that familiar with flex / bison, but it seemed to
> > > need trailing context to stop the mem event colon and slash
> > > delimiters from getting mixed up with delimiters for config
> > > terms or event modifiers.  Please look closely at that.
> > > 
> > > 
> > > Changes in V3:
> > > 
> > >       Add Ian's Reviewed-by
> > >       Re-base
> > 
> > Still applies.  Any more comments?
> 
> Tried it now, twice, once after removing the O= build dir:
> 
>   CC      /tmp/build/perf-tools-next/tests/event-times.o
>   CC      /tmp/build/perf-tools-next/tests/expr.o
>   BISON   /tmp/build/perf-tools-next/util/parse-events-bison.c
> util/parse-events.y:508.24-34: warning: unused value: $3 [-Wother]
>   508 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>       |                        ^~~~~~~~~~~
> util/parse-events.y:508.45-55: warning: unused value: $5 [-Wother]
>   508 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>       |                                             ^~~~~~~~~~~
> util/parse-events.y:526.24-34: warning: unused value: $3 [-Wother]
>   526 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
>       |                        ^~~~~~~~~~~
> util/parse-events.y:543.24-34: warning: unused value: $3 [-Wother]
>   543 | PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>       |                        ^~~~~~~~~~~
>   CC      /tmp/build/perf-tools-next/tests/backward-ring-buffer.o

But it doesn't _break_ the build, just warns thiis when generating the
.c file, the next build it notices it is already generated, no warnings.

- Arnaldo
 
> 
> ⬢[acme@toolbox perf-tools-next]$ cat /etc/redhat-release
> Fedora release 36 (Thirty Six)
> 
> ⬢[acme@toolbox perf-tools-next]$ rpm -q bison
> bison-3.8.2-2.fc36.x86_64
> ⬢[acme@toolbox perf-tools-next]$ rpm -q flex
> flex-2.6.4-10.fc36.x86_64
> ⬢[acme@toolbox perf-tools-next]$
> 
> 
> - Arnaldo
>  
> > > 
> > > Changes in V2:
> > > 
> > >       Add comments to tools/perf/util/parse-events.l
> > >       Add a test for 2 mem events back to back with config terms
> > > 
> > > 
> > > Adrian Hunter (1):
> > >       perf tools: Allow config terms with breakpoints
> > > 
> > >  tools/perf/tests/parse-events.c | 157 ++++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/parse-events.c  |  23 +++++-
> > >  tools/perf/util/parse-events.h  |   6 +-
> > >  tools/perf/util/parse-events.l  |  23 +++++-
> > >  tools/perf/util/parse-events.y  |  42 ++++++-----
> > >  5 files changed, 224 insertions(+), 27 deletions(-)
> > > 
> > > 
> > > Regards
> > > Adrian
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
