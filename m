Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821A462E7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiKQWMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiKQWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:11:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E1D70
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DE24B82208
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24120C433D6;
        Thu, 17 Nov 2022 22:11:48 +0000 (UTC)
Date:   Thu, 17 Nov 2022 17:11:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        yc-core@yandex-team.ru
Subject: Re: [PATCH v1] kernel/trace/ring_buffer: don't deactivate
 non-existant pages
Message-ID: <20221117171146.63ac85f2@gandalf.local.home>
In-Reply-To: <20221114143129.3534443-1-d-tatianin@yandex-team.ru>
References: <20221114143129.3534443-1-d-tatianin@yandex-team.ru>
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

On Mon, 14 Nov 2022 17:31:29 +0300
Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:

> rb_head_page_deactivate() expects cpu_buffer to contain a valid list of
> ->pages, so verify that the list is actually present before calling it.  
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  kernel/trace/ring_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a12e27815555..1e9de3d49701 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1635,9 +1635,9 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
>  
>  	free_buffer_page(cpu_buffer->reader_page);
>  
> -	rb_head_page_deactivate(cpu_buffer);
> -

Logically, this should never happen, but regardless, I consider this a fix.

Queued. Thanks Daniil!

-- Steve


>  	if (head) {
> +		rb_head_page_deactivate(cpu_buffer);
> +
>  		list_for_each_entry_safe(bpage, tmp, head, list) {
>  			list_del_init(&bpage->list);
>  			free_buffer_page(bpage);

