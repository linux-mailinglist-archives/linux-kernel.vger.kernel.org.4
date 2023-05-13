Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6D7012CB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbjELXzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbjELXzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685F43C06
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C919865981
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 23:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC03FC433EF;
        Fri, 12 May 2023 23:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683935590;
        bh=oNd4rIsgZiLO/9Cj35qM5IbRKtbqyKD8d3pntY+r+Ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Prs2tz3m3l3wAyiP8xmeZZELo5kUKr0o1whcsmkAGiI2/e6YcFHcLpyHbRPxLW0oV
         YKw8FRejpbKWlndFvAruL1HtN0v/GKgmxfQn/Dhh48NzQtuDXgOfDp/ryPXI0p/LoB
         jhNU8M1rhNdvbnAbgwCXG4ceNH3jM48XfBppdEhE=
Date:   Fri, 12 May 2023 16:53:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, chenhuacai@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] kthread: Unify kernel_thread() and
 user_mode_thread()
Message-Id: <20230512165309.896e063a9398639250eab264@linux-foundation.org>
In-Reply-To: <20230509104127.1997562-1-chenhuacai@loongson.cn>
References: <20230509104127.1997562-1-chenhuacai@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 May 2023 18:41:27 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:

> Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
> and umh") introduces a new function user_mode_thread() for init and umh.
> But the name is a bit confusing because init and umh are indeed kernel
> threads at creation time, the real difference is "they will become user
> processes". So let's unify the kernel_thread() and user_mode_thread() to
> kernel_thread() again, and add a new 'user' parameter for init and umh.
> 
> ...
>
>  5 files changed, 9 insertions(+), 26 deletions(-)
>

Less code is nice.

> -extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
> +			    unsigned long flags, int user);

`bool user'?


