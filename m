Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989560C0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiJYB1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiJYB0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6F12761;
        Mon, 24 Oct 2022 18:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3983616D5;
        Tue, 25 Oct 2022 01:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8835AC433D6;
        Tue, 25 Oct 2022 01:00:20 +0000 (UTC)
Date:   Mon, 24 Oct 2022 21:00:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [kbuild-all] Re: include/trace/trace_events.h:261:16: error:
 function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for
 'gnu_printf' format attribute
Message-ID: <20221024210031.3747fe18@gandalf.local.home>
In-Reply-To: <b612432e-7f21-4c79-5553-35ad7bdc6fd2@intel.com>
References: <202210212134.QTpb11ug-lkp@intel.com>
        <20221021101026.1708a426@gandalf.local.home>
        <ed665ca3-fa87-fee6-7284-9aed257264e4@intel.com>
        <20221024103524.43e13ab3@gandalf.local.home>
        <b612432e-7f21-4c79-5553-35ad7bdc6fd2@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 08:49:41 +0800
"Chen, Rong A" <rong.a.chen@intel.com> wrote:

> > For any build that fails on warnings, that specific warning needs to be
> > silenced.
> > 
> > I mean, "-Werror=suggest-attribute=format", really?  
> 
> yes, it's compiled with -Werror if using 'W=1' option:
> 
>  >>>>>> include/trace/trace_events.h:261:16: error: function   
> 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for 
> 'gnu_printf' format attribute [-Werror=suggest-attribute=format]

Is there a way we can silent this particular error when W=1?

Ooh! Doing a search of this I found:

include/trace/events/qla.h:#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"

Perhaps I should just make that part of trace_events.h ?

-- Steve

(untested)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cabf154d..63db95559647 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -18,6 +18,11 @@
  * in the structure.
  */
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 #include <linux/trace_events.h>
 
 #ifndef TRACE_SYSTEM_VAR
@@ -467,3 +472,5 @@ static struct trace_event_call __used					\
 __section("_ftrace_events") *__event_##call = &event_##call
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+#pragma GCC diagnostic pop
