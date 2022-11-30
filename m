Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0063D78C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiK3OFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiK3OFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:05:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B51286DC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:05:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 228CDB81B72
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B21DC433D7;
        Wed, 30 Nov 2022 14:05:32 +0000 (UTC)
Date:   Wed, 30 Nov 2022 09:05:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <zhang.songyi@zte.com.cn>
Cc:     <zhangqing@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next] recordmcount: use "!P" instead of "P == 0"
Message-ID: <20221130090530.3e7ec88e@gandalf.local.home>
In-Reply-To: <202211301547353578204@zte.com.cn>
References: <202211301547353578204@zte.com.cn>
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

On Wed, 30 Nov 2022 15:47:35 +0800 (CST)
<zhang.songyi@zte.com.cn> wrote:

> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> comparing pointer to 0, use !P instead of it.

Both are correct. No need for useless churn like this.

-- Steve

> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  scripts/recordmcount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index cce12e1971d8..8d01decd12e9 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -139,7 +139,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
>  static void * umalloc(size_t size)
>  {
>         void *const addr = malloc(size);
> -       if (addr == 0) {
> +       if (!addr) {
>                 fprintf(stderr, "malloc failed: %zu bytes\n", size);
>                 file_append_cleanup();
>                 mmap_cleanup();
> --
> 2.15.2

