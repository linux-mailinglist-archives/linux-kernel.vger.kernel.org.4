Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCCC606A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJTVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJTVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9EB198986
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD77361CD3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B61C433D6;
        Thu, 20 Oct 2022 21:23:19 +0000 (UTC)
Date:   Thu, 20 Oct 2022 17:23:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     <acme@redhat.com>, <linux-kernel@vger.kernel.org>,
        <namhyung@kernel.org>
Subject: Re: [PATCH] tools lib traceevent: Fix double free in
 event_read_fields()
Message-ID: <20221020172324.66c6927f@gandalf.local.home>
In-Reply-To: <20221017085937.8583-1-shangxiaojing@huawei.com>
References: <20221017085937.8583-1-shangxiaojing@huawei.com>
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

On Mon, 17 Oct 2022 16:59:37 +0800
Shang XiaoJing <shangxiaojing@huawei.com> wrote:

> There is a double free in event_read_fields(). After calling free_token()
> to free the token, if append() failed, then goto fail, which will call
> free_token() again. Triggered by compiling with perf and run "perf sched
> record". Fix the double free by goto fail_expect instead of fail while
> append() failed, which won't call redundant free_token().
> 
> BUG: double free
> free(): double free detected in tcache 2
> Aborted
> 
> Fixes: d286447f23cd ("tools lib traceevent: Handle realloc() failure path")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  tools/lib/traceevent/event-parse.c | 2 +-

tool/lib/traceevent is deprecated.

Can you send this patch to linux-trace-devel@vger.kernel.org against

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

Thanks!

-- Steve


>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 8e24c4c78c7f..e0a5a22fe702 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -1594,7 +1594,7 @@ static int event_read_fields(struct tep_event *event, struct tep_format_field **
>  			ret = append(&brackets, "", "]");
>  			if (ret < 0) {
>  				free(brackets);
> -				goto fail;
> +				goto fail_expect;
>  			}
>  
>  			/* add brackets to type */

