Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF6603001
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJRPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJRPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:48:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7272C821C;
        Tue, 18 Oct 2022 08:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA76B81BE1;
        Tue, 18 Oct 2022 15:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EE7C433D7;
        Tue, 18 Oct 2022 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666108117;
        bh=pO0jFVJ4UO7ZMjfoTjgr0/MJjcpLWwBFEgsVsAQtQjE=;
        h=From:To:Cc:Subject:Date:From;
        b=fPZSljBM9iYf3pgxYCNFfyVkWi59Cnv2wImor1EPqKCQi1WvvrtFsWGH2VlxbD3sD
         HWOoOjSdd8lrrCibDjc8mJDFnytFQuyqFFGWHZM9g0i0y7OaPKUWZ6ZFMsec9H3EJT
         TkQYDzchWY8p9DRwRktmi+hiXugDMa2u3InZUqWylP28H6VSy9K9UytB7dmXChR2Pf
         HObrUxsCYNw58YBz8TyfmjdwxvHrzYTdUyaxXN5LkiQ0zeh8gPPxR9R65dmPDJIr8s
         uD2RrfyZmacLL1eBdgyFnD2+WthgKrpDxPB0CtcRAAaFYbsLJXWkTHNKeDKmLNd1zP
         VFdn8hxoU840w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] tracing/hist: Add percentage histogram suffixes
Date:   Wed, 19 Oct 2022 00:48:33 +0900
Message-Id: <166610811353.56030.10023036046735082272.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I forgot to update this series.
Here is the 6th version of .percent and .graph suffixes for histogram
trigger to show the value in percentage and in bar-graph respectively.
The previous version is here;

 https://lore.kernel.org/all/166226473132.223837.9011128463174539022.stgit@devnote2

This is just fixing to add my signed-off-by and Tom's reviewed/tested-by.
No functional changes.

Here shows an example of the percentage and the bar graph of
the runtime of the running tasks without raw hitcount field.

  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid:NOHC > \
        events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount.percent,hitcount.graph:sort=pid:size=2048:nohitcount [active]
 #
 
 { pid:         14 }  hitcount (%):   6.91  hitcount: ##                  
 { pid:         16 }  hitcount (%):   1.13  hitcount:                     
 { pid:         57 }  hitcount (%):   6.99  hitcount: ##                  
 { pid:         61 }  hitcount (%):  55.28  hitcount: ####################
 { pid:         67 }  hitcount (%):   5.52  hitcount: ##                  
 { pid:         69 }  hitcount (%):  20.08  hitcount: #######             
 { pid:         71 }  hitcount (%):   0.40  hitcount:                     
 { pid:         77 }  hitcount (%):   0.97  hitcount:                     
 { pid:         78 }  hitcount (%):   0.56  hitcount:                     
 { pid:        145 }  hitcount (%):   1.13  hitcount:                     
 { pid:        153 }  hitcount (%):   0.48  hitcount:                     
 { pid:        154 }  hitcount (%):   0.48  hitcount:                     
 
 Totals:
     Hits: 1230
     Entries: 12
     Dropped: 0


With the NOHC (or nohitcount) option, the histogram will skip
display of raw hitcount, but it will allow to display percent
and graph of hitcount.

Trigger                      Result
val=runtime               -> Show hitcount and runtime
val=runtime:NOHC          -> Show runtime
val=hitcount:NOHC         -> Error
(noval)                   -> show hitcount
(noval):NOHC              -> Error
val=hitcount.parcent      -> show hitcount and hitcount%
val=hitcount.parcent:NOHC -> show hitcount%

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing: Add .percent suffix option to histogram values
      tracing: Add .graph suffix option to histogram value
      tracing: Add nohitcount option for suppressing display of raw hitcount
      tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'

Tom Zanussi (1):
      tracing: Allow multiple hitcount values in histograms


 Documentation/trace/histogram.rst |   10 ++
 kernel/trace/trace.c              |    7 +
 kernel/trace/trace_events_hist.c  |  177 ++++++++++++++++++++++++++++++++-----
 3 files changed, 169 insertions(+), 25 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
