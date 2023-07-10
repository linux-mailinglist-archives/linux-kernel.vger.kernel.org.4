Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF58474E188
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGJWoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGJWn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EABF9C;
        Mon, 10 Jul 2023 15:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A666123D;
        Mon, 10 Jul 2023 22:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330DEC433C7;
        Mon, 10 Jul 2023 22:43:56 +0000 (UTC)
Date:   Mon, 10 Jul 2023 18:43:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 1/1] f2fs: Use return value of strreplace()
Message-ID: <20230710184353.09640aee@gandalf.local.home>
In-Reply-To: <20230628150243.17771-1-andriy.shevchenko@linux.intel.com>
References: <20230628150243.17771-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 18:02:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since strreplace() returns the pointer to the string itself,
> we may use it directly in the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/trace/events/f2fs.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 793f82cc1515..f5994515290c 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -2234,13 +2234,11 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
>  		 * because this screws up the tooling that parses
>  		 * the traces.
>  		 */
> -		__assign_str(pathbuf, pathname);
> -		(void)strreplace(__get_str(pathbuf), ' ', '_');
> +		__assign_str(pathbuf, strreplace(pathname, ' ', '_'));

But this modifies the pathname that is passed into the trace event, which
is something that a trace point should never do! In fact, the char
*pathname, really should be a const char * (for which this would fail to
build).

Note, I went to look for these events and I can not find where they are
used. Should these events just be deleted?

-- Steve


>  		__entry->offset = offset;
>  		__entry->bytes = bytes;
>  		__entry->i_size = i_size_read(inode);
> -		__assign_str(cmdline, command);
> -		(void)strreplace(__get_str(cmdline), ' ', '_');
> +		__assign_str(cmdline, strreplace(command, ' ', '_'));
>  		__entry->pid = pid;
>  		__entry->ino = inode->i_ino;
>  	),

