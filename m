Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9847A5FF307
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJNRfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJNRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:35:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AAC9F371;
        Fri, 14 Oct 2022 10:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4441661BCD;
        Fri, 14 Oct 2022 17:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE1C433D6;
        Fri, 14 Oct 2022 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665768937;
        bh=RYcXCpQ7kJ7wU4v0bNiDqg4UeRlasdkIA4uKm4FuAL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+0GDdgIojwEJrsZ8wkTQtvHrfR+vn5Z0oBkrZj2k1FNMU+XLfHXOUpqp/WO2DQ7h
         j8VJw+1SR8SyPEVdNj9LTnk+ICKQf5dl0qQ627schTbKfU5/8d/nWYQdcDyHR8KuYP
         amxmSSD6jPDcByPwFnc1gdbMbcGAcx0wgi779U9zWkXER1Wwebp078agXqp67dfOGT
         RCvfNXcR/uD1BEff2YQKxJjkxLKffvmTBxUoDEej/loXpUGip8JiG7hyIqfTTYP9iF
         /6aOdfgnoSIceCN00q9CNU2iZoc/lIGLc65eoiqUSgX6NLKsS5Tx5OFwNvHQwn5oGx
         5HhSpWVdzrbCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2309B4062C; Fri, 14 Oct 2022 14:35:35 -0300 (-03)
Date:   Fri, 14 Oct 2022 14:35:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/7] perf test: test_intel_pt.sh: Add jitdump test
Message-ID: <Y0md54O4FbjjKJn0@kernel.org>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
 <20221014170905.64069-6-adrian.hunter@intel.com>
 <Y0mcWpc4KaeXpU+z@kernel.org>
 <Y0mdIxx630X5zi4V@kernel.org>
 <Y0mdc9V0uBdRPcYz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0mdc9V0uBdRPcYz@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 14, 2022 at 02:33:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 14, 2022 at 02:32:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Oct 14, 2022 at 02:28:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Miscellaneous Intel PT testing: Ok
>  
> > Actually:
>  
> > --- Test tracing self-modifying code that uses jitdump ---
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.018 MB /tmp/perf-test-intel-pt-sh.GJoKOxGVFY/tmp-perf.data ]
> > 
> > Warning:
> > 1 instruction trace errors
> > /home/acme/git/perf
> > Decode failed, 1 errors
> > Warning:
> > 1 instruction trace errors
> >  instruction trace error type 1 time 494778.777081924 cpu 3 pid 309650 tid 309650 ip 0x7f0972f22009 code 5: Failed to get instruction
> > --- Cleaning up ---
> > --- Done ---
> > test child finished with -1
> > ---- end ----
> > Miscellaneous Intel PT testing: FAILED!
> > [root@quaco perf]#
> > [root@quaco perf]# pwd
> > /home/acme/git/perf
> 
> I see... nevermind, this is what is expected, failing now, then the fix,
> then stops failing, nothing to see here, move along 8-)

Just for completeness sake, after the genelf.h fix:

[root@quaco perf]# perf test "Miscellaneous Intel PT testing"
110: Miscellaneous Intel PT testing                                  : Ok
[root@quaco perf]# perf test -v "Miscellaneous Intel PT testing"
110: Miscellaneous Intel PT testing                                  :
--- start ---
test child forked, pid 314597
--- Test system-wide sideband ---
Checking for CPU-wide recording on CPU 0
OK
Checking for CPU-wide recording on CPU 1
OK
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.189 MB /tmp/perf-test-intel-pt-sh.TRr45lCVrl/test-perf.data ]
OK
--- Test per-thread recording ---
Workload PIDs are 314619 and 314620
perf PID is 314631
Waiting for "perf record has started" message
OK
pid 314619 cpu -1 fd 5 : sys_perf_event_open: pid 314619  cpu -1  group_fd -1  flags 0x8 = 5
pid 314623 cpu -1 fd 6 : sys_perf_event_open: pid 314623  cpu -1  group_fd -1  flags 0x8 = 6
pid 314620 cpu -1 fd 7 : sys_perf_event_open: pid 314620  cpu -1  group_fd -1  flags 0x8 = 7
pid 314622 cpu -1 fd 8 : sys_perf_event_open: pid 314622  cpu -1  group_fd -1  flags 0x8 = 8
pid 314619 cpu -1 fd 9 : sys_perf_event_open: pid 314619  cpu -1  group_fd -1  flags 0x8 = 9
pid 314623 cpu -1 fd 10 : sys_perf_event_open: pid 314623  cpu -1  group_fd -1  flags 0x8 = 10
pid 314620 cpu -1 fd 11 : sys_perf_event_open: pid 314620  cpu -1  group_fd -1  flags 0x8 = 11
pid 314622 cpu -1 fd 12 : sys_perf_event_open: pid 314622  cpu -1  group_fd -1  flags 0x8 = 12
fd 5 : idx 0: mmapping fd 5
fd 9 fd_to 5 : idx 0: set output fd 9 -> 5
fd 6 : idx 1: mmapping fd 6
fd 10 fd_to 6 : idx 1: set output fd 10 -> 6
fd 7 : idx 2: mmapping fd 7
fd 11 fd_to 7 : idx 2: set output fd 11 -> 7
fd 8 : idx 3: mmapping fd 8
fd 12 fd_to 8 : idx 3: set output fd 12 -> 8
Checking 8 fds
OK
--- Test per-thread (incl. kernel) recording ---
Workload PIDs are 315355 and 315356
perf PID is 315367
Waiting for "perf record has started" message
OK
pid 315355 cpu -1 fd 5 : sys_perf_event_open: pid 315355  cpu -1  group_fd -1  flags 0x8 = 5
pid 315358 cpu -1 fd 6 : sys_perf_event_open: pid 315358  cpu -1  group_fd -1  flags 0x8 = 6
pid 315356 cpu -1 fd 7 : sys_perf_event_open: pid 315356  cpu -1  group_fd -1  flags 0x8 = 7
pid 315359 cpu -1 fd 8 : sys_perf_event_open: pid 315359  cpu -1  group_fd -1  flags 0x8 = 8
pid 315355 cpu -1 fd 9 : sys_perf_event_open: pid 315355  cpu -1  group_fd -1  flags 0x8 = 9
pid 315358 cpu -1 fd 10 : sys_perf_event_open: pid 315358  cpu -1  group_fd -1  flags 0x8 = 10
pid 315356 cpu -1 fd 11 : sys_perf_event_open: pid 315356  cpu -1  group_fd -1  flags 0x8 = 11
pid 315359 cpu -1 fd 12 : sys_perf_event_open: pid 315359  cpu -1  group_fd -1  flags 0x8 = 12
pid -1 cpu 0 fd 13 : sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 13
pid -1 cpu 1 fd 14 : sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 14
pid -1 cpu 2 fd 15 : sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 15
pid -1 cpu 3 fd 16 : sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 16
pid -1 cpu 4 fd 17 : sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 17
pid -1 cpu 5 fd 18 : sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 18
pid -1 cpu 6 fd 19 : sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 19
pid -1 cpu 7 fd 20 : sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 20
fd 5 : idx 0: mmapping fd 5
fd 9 fd_to 5 : idx 0: set output fd 9 -> 5
fd 6 : idx 1: mmapping fd 6
fd 10 fd_to 6 : idx 1: set output fd 10 -> 6
fd 7 : idx 2: mmapping fd 7
fd 11 fd_to 7 : idx 2: set output fd 11 -> 7
fd 8 : idx 3: mmapping fd 8
fd 12 fd_to 8 : idx 3: set output fd 12 -> 8
fd 13 : idx 4: mmapping fd 13
fd 14 : idx 5: mmapping fd 14
fd 15 : idx 6: mmapping fd 15
fd 16 : idx 7: mmapping fd 16
fd 17 : idx 8: mmapping fd 17
fd 18 : idx 9: mmapping fd 18
fd 19 : idx 10: mmapping fd 19
fd 20 : idx 11: mmapping fd 20
Checking 16 fds
OK
--- Test tracing self-modifying code that uses jitdump ---
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.021 MB /tmp/perf-test-intel-pt-sh.TRr45lCVrl/tmp-perf.data ]
/home/acme/git/perf
OK
--- Cleaning up ---
--- Done ---
test child finished with 0
---- end ----
Miscellaneous Intel PT testing: Ok
[root@quaco perf]#
