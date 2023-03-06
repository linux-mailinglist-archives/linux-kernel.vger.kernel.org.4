Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8BB6AC7C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCFQXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCFQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:22:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590A83D1;
        Mon,  6 Mar 2023 08:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9855561028;
        Mon,  6 Mar 2023 16:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EACCC433A0;
        Mon,  6 Mar 2023 16:15:14 +0000 (UTC)
Date:   Mon, 6 Mar 2023 11:15:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
Message-ID: <20230306111513.2aa49b1a@gandalf.local.home>
In-Reply-To: <20230306122549.236561-1-douglas.raillard@arm.com>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Mar 2023 12:25:49 +0000
Douglas RAILLARD <douglas.raillard@arm.com> wrote:

> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 31d994e6b4ca..8d053838d6cf 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -512,7 +512,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(ino_t,	ino)
> -		__field(nid_t,	nid[3])

That should not have even compiled. I'll see if I can add some tricks to
make that fail.

Thanks,

-- Steve


> +		__array(nid_t,	nid, 3)
>  		__field(int,	depth)
>  		__field(int,	err)
>  	),
