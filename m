Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DD5EAB87
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiIZPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiIZPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:46:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E23BA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD605B80AB8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE9C433C1;
        Mon, 26 Sep 2022 14:31:34 +0000 (UTC)
Date:   Mon, 26 Sep 2022 10:32:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Properly unset FTRACE_HASH_FL_MOD
Message-ID: <20220926103242.6d0fc1ea@gandalf.local.home>
In-Reply-To: <20220926152008.2239274-1-zhengyejian1@huawei.com>
References: <20220926152008.2239274-1-zhengyejian1@huawei.com>
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

On Mon, 26 Sep 2022 15:20:08 +0000
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> When executing following commands like what document said, but the log
> "#### all functions enabled ####" was not shown as expect:
>   1. Set a 'mod' filter:
>     $ echo 'write*:mod:ext3' > /sys/kernel/tracing/set_ftrace_filter
>   2. Invert above filter:
>     $ echo '!write*:mod:ext3' >> /sys/kernel/tracing/set_ftrace_filter
>   3. Read the file:
>     $ cat /sys/kernel/tracing/set_ftrace_filter
> 
> By some debugging, I found that flag FTRACE_HASH_FL_MOD was not unset
> after inversion like above step 2 and then result of ftrace_hash_empty()
> is incorrect.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8c08f0d5c6fb ("ftrace: Have cached module filters be an active filter")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Thanks, this definitely looks like a bug.

I'll be reviewing these patches later this week.

-- Steve
