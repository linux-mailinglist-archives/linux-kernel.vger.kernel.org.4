Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234986831BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjAaPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjAaPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:40:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3272653574;
        Tue, 31 Jan 2023 07:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1375EB81D63;
        Tue, 31 Jan 2023 15:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD43C433D2;
        Tue, 31 Jan 2023 15:39:38 +0000 (UTC)
Date:   Tue, 31 Jan 2023 10:39:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Tom Rix <trix@redhat.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: ftrace: make some global variables static
Message-ID: <20230131103935.4966c46e@gandalf.local.home>
In-Reply-To: <Y9jo1SJpsBRTb2M5@FVFF77S0Q05N>
References: <20230130193708.1378108-1-trix@redhat.com>
        <Y9jo1SJpsBRTb2M5@FVFF77S0Q05N>
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

On Tue, 31 Jan 2023 10:09:25 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Jan 30, 2023 at 11:37:08AM -0800, Tom Rix wrote:
> > smatch reports this representative issue
> > samples/ftrace/ftrace-ops.c:15:14: warning: symbol 'nr_function_calls' was not declared. Should it be static?
> > 
> > The nr_functions_calls and several other global variables are only
> > used in ftrace-ops.c, so they should be static.  
> 
> This makes sense to me.
> 
> > Remove the instances of initializing static int to 0.  
> 
> I appreciate that static variables get implicitly zero initialized, but
> dropping the initialization is inconsistent with the other control variables,
> and IMO it's quite confusing, so I'd prefer to keep that for clarity. I note
> you've also dropped the initialization of a bool to false, whereas the above
> just mentions int.
> 
> I'd prefer to keep the initialization, but I'll defre to Steve if he thinks
> differently. :)

Yeah, I'm fine with dropping the initialization of even bool (I don't
initialize bool to false either). Everything in the BSS section is always
initialized to zero, and in C, false is the same as zero.

> 
> > Signed-off-by: Tom Rix <trix@redhat.com>  
> 
> With the above taken into account:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,

-- Steve

