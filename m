Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC674F508
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGKQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGKQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E910FD;
        Tue, 11 Jul 2023 09:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E516155B;
        Tue, 11 Jul 2023 16:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FB7C433C7;
        Tue, 11 Jul 2023 16:22:09 +0000 (UTC)
Date:   Tue, 11 Jul 2023 12:22:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] tracing/probes: Fix to record 0-length data_loc
 in fetch_store_string*() if fails
Message-ID: <20230711122206.531a6504@gandalf.local.home>
In-Reply-To: <168908496683.123124.4761206188794205601.stgit@devnote2>
References: <168908491977.123124.16583481716284477889.stgit@devnote2>
        <168908496683.123124.4761206188794205601.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 23:16:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to record 0-length data to data_loc in fetch_store_string*() if it fails
> to get the string data.
> Currently those expect that the data_loc is updated by store_trace_args() if
> it returns the error code. However, that does not work correctly if the
> argument is an array of strings. In that case, store_trace_args() only clears
> the first entry of the array (which may have no error) and leaves other
> entries. So it should be cleared by fetch_store_string*() itself.
> Also, 'dyndata' and 'maxlen' in store_trace_args() should be updated
> only if it is used (ret > 0 and argument is a dynamic data.)
> 
> Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v4:
>   - Simplify the updating data_loc code with set_data_loc().
>  Changes in v5:
>   - Move out arg->dynamic check from unlikely() and use likely().
> ---
>  kernel/trace/trace_probe_kernel.h |   13 +++++++++----
>  kernel/trace/trace_probe_tmpl.h   |   10 +++-------
>  kernel/trace/trace_uprobe.c       |    3 ++-
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 


Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

