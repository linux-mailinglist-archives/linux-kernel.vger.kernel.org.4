Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61E874D7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGJNoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGJNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:44:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA6BA;
        Mon, 10 Jul 2023 06:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E642460FC6;
        Mon, 10 Jul 2023 13:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECCEC433C8;
        Mon, 10 Jul 2023 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688996652;
        bh=f8+Tgjr82BQ+lwzbHHg9u/aqPVDfaD8lbBwoguIlk+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9aUbDe2rXRBAMG0lbwa91r24ByoD38mxzaGazqadyRo4c0gTzwwTBMnSbJidaiVc
         3VdBn6sx6m1JR2rQNJDd5P5aTFDO5+oRg9aRD9wQ0YSBEk6A6GWMo7wO2vjUiw1orY
         tmLGIgMOq75VHbkxAVkNC67l6/3PeacJSrtuV+oTaXSXsQN10yx/nUDEGY9Gkx/rWN
         a9CKWZggWo0CEQ74Lx6LxRuvaiTlT/qfgPvSgqE3NGsYEWUMvm4pd1VC1BFMdMBV8P
         Nuh+qygzLfkuj1iDco31uWVbX8H74SmwR2pWMhTUqDyjCM3l8VDLviQY/w7wcEPAHI
         E/vjXhuylIFSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C8E140516; Mon, 10 Jul 2023 10:44:09 -0300 (-03)
Date:   Mon, 10 Jul 2023 10:44:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf probe: fix regression introduced by switch
 to die_get_decl_file
Message-ID: <ZKwLKXL6rkoShDNc@kernel.org>
References: <20230628084551.1860532-3-georgmueller@gmx.net>
 <1c85c4d6-7097-bc0a-d0ca-ebe234d63ece@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c85c4d6-7097-bc0a-d0ca-ebe234d63ece@leemhuis.info>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 10, 2023 at 02:32:28PM +0200, Linux regression tracking (Thorsten Leemhuis) escreveu:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Masami, Arnaldo, what's up here? Georg (who is not a regular
> contributor) afaics found a regression in a commit you
> authored/committed and even provided a patch-set to fix it (the first
> one nearly four weeks ago, e.g. before the merge window started), but
> hasn't received much support from your side to get this in. Could you
> please look into this to get this cleared up? Or am I missing something
> and progress to fix this has been made?

I'm back from a 2 week vacation, going thru the pile, probably fell thru
the cracks and Namyung, that processed patches while I was away didn't
notice it either.

I'm checking,

- Arnaldo
 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> 
> On 28.06.23 10:45, Georg Müller wrote:
> > When switching from dwarf_decl_file() to die_get_decl_file(), a regression
> > was introduced when having a binary where the DWARF info is split to
> > multiple CUs. It is not possible to add probes to certain functions.
> > 
> > These patches introduce a testcase which shows the current regression
> > and a fix for the issue
> > 
> > Signed-off-by: Georg Müller <georgmueller@gmx.net>
> > Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net/
> > 
> > ---
> > Changes in v2:
> >  - Add testcase
> > 
> > Changes in v3:
> >  - start new thread
> >  - add stable to cc
> > 
> > Georg Müller (2):
> >   perf probe: add test for regression introduced by switch to
> >     die_get_decl_file
> >   perf probe: read DWARF files from the correct CU
> > 
> >  .../shell/test_uprobe_from_different_cu.sh    | 77 +++++++++++++++++++
> >  tools/perf/util/dwarf-aux.c                   |  4 +-
> >  2 files changed, 80 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> > 
> > --
> > 2.41.0
> > 
> > 
> > 

-- 

- Arnaldo
