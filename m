Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC46E9C40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjDTTKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTTKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6AC10D1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E442864B59
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFF8C433D2;
        Thu, 20 Apr 2023 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682017833;
        bh=6LIfiZLP8v5+kEKJVX54943XWTP67E9t/PlL9UGfUYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSl96hJ56lclu4hPj5vVG/D+te7ZSYD5WwiQxPavSf8gZpxgdJr7779yOaDq58Wv/
         emc/XsPS9CGLMvOzYDD/9fgD2kurSfY897HJBQrCAJ++74hplU5i+etw0DqfO0FoK/
         DA92sR2HzKfiFW3inyD2jHrzcrfIbWr79syUn2VyaqdW4MVoMe6xmmo4bBEDpxvNV4
         IrVfGMo+aMeKwG7qjG499q0GgXa5tBYfqS8+oCyp6rBQzo1UueIiOfCxAgC6OTZ2Ma
         pFVmhSrW8+7xLrdPps27pXSSeClYvYLXRsYVgWTdcLpkCQTUFnywVcEDQHJodZcpaW
         W2C/5EtcuDIkQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 742DB403C5; Thu, 20 Apr 2023 16:10:30 -0300 (-03)
Date:   Thu, 20 Apr 2023 16:10:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] perf evsel: Introduce evsel__name_is() method to
 check if the evsel name is equal to a given string
Message-ID: <ZEGOJuJd4uLS2392@kernel.org>
References: <ZEGLM8VehJbS0gP2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGLM8VehJbS0gP2@kernel.org>
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

Em Thu, Apr 20, 2023 at 03:57:55PM -0300, Arnaldo Carvalho de Melo escreveu:
> This makes the logic a bit clear by avoiding the !strcmp() pattern and
> also a way to intercept the pointer if we need to do extra validation on
> it or to do lazy setting of evsel->name via evsel__name(evsel).

+ this, looking if there are others...

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d3cbee7460fcc48e..e95a545f2c600810 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2169,10 +2169,8 @@ static void setup_system_wide(int forks)
 		struct evsel *counter;
 
 		evlist__for_each_entry(evsel_list, counter) {
-			if (!counter->core.requires_cpu &&
-			    strcmp(counter->name, "duration_time")) {
+			if (!counter->core.requires_cpu && evsel__name_is(counter, "duration_time"))
 				return;
-			}
 		}
 
 		if (evsel_list->core.nr_entries)
