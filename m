Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A009730770
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjFNSkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjFNSk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CCA137;
        Wed, 14 Jun 2023 11:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E5E63F09;
        Wed, 14 Jun 2023 18:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CF8C433C0;
        Wed, 14 Jun 2023 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686768027;
        bh=WXHRTF+WzBkYJvzlkvsxv8Qx115ir+Jf7QPO9fuOuuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+WnV60e7YW+KvmS/7ZoyjRlsXp6P4+CpN83QmXl+Ib78QXl2MxR3SQVdekTPDiPM
         jbHhYL0iqPaI/VMJLCZKCpMlS1JQhEFQL0XDfZ//lZZBZKfsBnU9fatwy4z56HM/8C
         wmyF2ES0X0i6jyAkQC25tjQZgK6qzVTyjLqhkuoyy4up98ZXGQCFnHxU9RS/DQnlO0
         QMKt6f5wXU0nXx2scEiKbivzljme8P6l8Di3KpcE/gN4Jjyyn0B2hsfo+EMLXlBIaQ
         TerF5bRyxlJIy71A+MgufH1VSAeqz5DmyAFqGqssbuxP3wg4Gfzy9ggyFOVX+jweAY
         l+WR3GO83iAQw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E4F640692; Wed, 14 Jun 2023 15:40:24 -0300 (-03)
Date:   Wed, 14 Jun 2023 15:40:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf tools: annotation browser from c2c tui
Message-ID: <ZIoJmKvE62jGXIE7@kernel.org>
References: <20230608084407.140323-1-asavkov@redhat.com>
 <CAM9d7cgvtuqMeQx8ehLCLw_Ur9Ju-VzDrakzFJxnxvFjdsWk_g@mail.gmail.com>
 <20230609083731.GA168559@samus.usersys.redhat.com>
 <ZIoJK66ZrKZblkJN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIoJK66ZrKZblkJN@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 14, 2023 at 03:38:35PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jun 09, 2023 at 10:37:31AM +0200, Artem Savkov escreveu:
> > On Thu, Jun 08, 2023 at 02:09:06PM -0700, Namhyung Kim wrote:
> > > On Thu, Jun 8, 2023 at 1:44 AM Artem Savkov <asavkov@redhat.com> wrote:
> > > > These patches add ability to start annotation browser from c2c report
> > > > tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].

> > > I was thinking about how it works and realized that it didn't collect
> > > samples by symbol.  Then I'm not sure if the result is meaningful.
> > > I think it'd show a random symbol that touched the cache line
> > > first.  The same cache line can be accessed from other locations
> > > but it cannot know where they are.

> > > Also different instructions in a function (symbol) would access a
> > > different cache line.  The annotate output just shows any memory
> > > access.  So it might be good to check the instruction at the point
> > > but others should not be considered related.

> > > Hmm.. I suspect even the same instruction will hit the different
> > > cache lines at different times.  Then probably the annotation
> > > won't work well in terms of correlating cache lines.

> > The annotation hotkey is only added to the cacheline detailed view where
> > we do have symbol instruction information. The idea is to give the user
> > ability to quickly jump to source code/disassembly directly from c2c
> > TUI.

> > The hit percentages in annotation view don't make much sense in this
> > case though, so maybe it is better to use dummy evsel so that none are
> > shown.

> Yes, the point is just to reuse the source browser, if there is no
> annotation data applicable, don't use any.

I tried to work on having the annotation browser, both --stdio2 and the
TUI to work with evsels without annotation data, just so that we could
simply navigate source code or disassembly functions using the more
compact form we have in perf than the original one from objdump.

- Arnaldo

