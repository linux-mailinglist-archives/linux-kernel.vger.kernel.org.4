Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2DC640E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiLBTMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiLBTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:11:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A3ED696
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:11:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22922B81C27
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FB4C433C1;
        Fri,  2 Dec 2022 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670008311;
        bh=/YWp12/zO8HCL56IKOBE1UYgV0tmxlQbG3n/E3erD/M=;
        h=Date:From:To:Cc:Subject:From;
        b=jnO98y+JmE63/zYnDTE9JNR9yhE6Bn6GxcBhQ8TUyszo5+QEEclgwrojoBZs+zmZt
         omeh5YwX+npHzEWrv8L3RvKJFzA3AVklRfV2R8iwADxBlPz+VgLimhz8weOXPMoia3
         pYhAXJj8drYCoZ4W63dINAqdhV/XL6L70zB2+wT8wC6tIS6V0SYeufY5zQ3ofJ90pZ
         vjN6QhETWCqjlFqnELsvVaXIog4dJvAS/P+zLk7AmATsh7JulxYHR6Ez/IylfLUa1Y
         tOoB+9rlTssqvPZBAbMh8/uNXFHeO78WFKjQA2wGe8i2CARvsEeJXL8fjkRDmjc5jS
         N2azBOphp9aqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82B7B4034E; Fri,  2 Dec 2022 16:11:48 -0300 (-03)
Date:   Fri, 2 Dec 2022 16:11:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: tmp.perf/core segfaulting on metrics test
Message-ID: <Y4pN9MbSuANbn68W@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to get back at processing patches for Linux 6.2, what I
have at tmp.perf/core branch is failing like below, can someone try to
help in diagnosing this?

People really should try to run 'perf test' before pushing things
upstream, but maybe this is related to a recent merge with
torvalds/master, I'll check, but as a heads up and if someone wants to
help...

[root@quaco ~]# perf test 99
 99: perf all metricgroups test                                      : FAILED!
[root@quaco ~]# perf test -v 99
 99: perf all metricgroups test                                      :
--- start ---
test child forked, pid 1494614
Testing Backend

 Performance counter stats for 'system wide':

         9,978,757      CPU_CLK_UNHALTED.THREAD_ANY      #     56.7 %  tma_core_bound
/home/acme/libexec/perf-core/tests/shell/stat_all_metricgroups.sh: line 7: 1494617 Segmentation fault      (core dumped) perf stat -M "$m" -a true
test child finished with -1
---- end ----
perf all metricgroups test: FAILED!
[root@quaco ~]#


-- 

- Arnaldo
