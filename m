Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AD734C32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjFSHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFSHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576071A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687158946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpOKy137UOdxxz61biF46fSeY49E4HdHA4JMVS1NKBg=;
        b=FFtup4KTLnAJYjpz03otSNHEOjc4uQ7Ny8XfcFXaOnkc3rwiZnoRrG4JgsaTc9Jdm8fVBA
        cwgEmL2M7M0zE/czRzNDGz3/kwYDdMYGyfXa/h7d7+0XzKrCTOVt9DQERGUWPg+ZHOJ/GY
        9tu0yYH0Jf/fe+qfbHHa3Xj9Ib0GKUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-VU_7nSh9NQW2iMr7elRSkw-1; Mon, 19 Jun 2023 03:15:42 -0400
X-MC-Unique: VU_7nSh9NQW2iMr7elRSkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60B44185A7AF;
        Mon, 19 Jun 2023 07:15:41 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A934E492C1B;
        Mon, 19 Jun 2023 07:15:39 +0000 (UTC)
Date:   Mon, 19 Jun 2023 09:15:37 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20230619071537.GA153131@samus.usersys.redhat.com>
References: <20230608084407.140323-1-asavkov@redhat.com>
 <CAM9d7cgvtuqMeQx8ehLCLw_Ur9Ju-VzDrakzFJxnxvFjdsWk_g@mail.gmail.com>
 <20230609083731.GA168559@samus.usersys.redhat.com>
 <ZIoJK66ZrKZblkJN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIoJK66ZrKZblkJN@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:38:35PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 09, 2023 at 10:37:31AM +0200, Artem Savkov escreveu:
> > On Thu, Jun 08, 2023 at 02:09:06PM -0700, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > On Thu, Jun 8, 2023 at 1:44 AM Artem Savkov <asavkov@redhat.com> wrote:
> > > >
> > > > These patches add ability to start annotation browser from c2c report
> > > > tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].
> > > 
> > > I was thinking about how it works and realized that it didn't collect
> > > samples by symbol.  Then I'm not sure if the result is meaningful.
> > > I think it'd show a random symbol that touched the cache line
> > > first.  The same cache line can be accessed from other locations
> > > but it cannot know where they are.
> > > 
> > > Also different instructions in a function (symbol) would access a
> > > different cache line.  The annotate output just shows any memory
> > > access.  So it might be good to check the instruction at the point
> > > but others should not be considered related.
> > > 
> > > Hmm.. I suspect even the same instruction will hit the different
> > > cache lines at different times.  Then probably the annotation
> > > won't work well in terms of correlating cache lines.
> > 
> > The annotation hotkey is only added to the cacheline detailed view where
> > we do have symbol instruction information. The idea is to give the user
> > ability to quickly jump to source code/disassembly directly from c2c
> > TUI.
> > 
> > The hit percentages in annotation view don't make much sense in this
> > case though, so maybe it is better to use dummy evsel so that none are
> > shown.
> 
> Yes, the point is just to reuse the source browser, if there is no
> annotation data applicable, don't use any.
> 

Ok, should be as easy as the following diff. I'll include it in v3 if
there si more feedback.

---

diff --git b/tools/perf/builtin-c2c.c a/tools/perf/builtin-c2c.c
index dce8604837aec..c856ce7a50740 100644
--- b/tools/perf/builtin-c2c.c
+++ a/tools/perf/builtin-c2c.c
@@ -2701,7 +2701,11 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)

                switch (key) {
                case 'a':
-                       do_annotate(browser, evlist__first(c2c.evlist));
+                       /*
+                        * We don't need percentage info so use 'dummy:HG'
+                        * evsel which is last in evlist.
+                        */
+                       do_annotate(browser, evlist__last(c2c.evlist));
                        break;
                case 's':
                        c2c.symbol_full = !c2c.symbol_full;

