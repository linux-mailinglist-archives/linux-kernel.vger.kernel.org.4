Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1605A6CD04A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjC2CoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC2CoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:44:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696AA2139;
        Tue, 28 Mar 2023 19:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18842B81EA9;
        Wed, 29 Mar 2023 02:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F9EC433EF;
        Wed, 29 Mar 2023 02:44:13 +0000 (UTC)
Date:   Tue, 28 Mar 2023 22:44:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230328224411.0d69e272@gandalf.local.home>
In-Reply-To: <20230322102244.3239740-2-vdonnefort@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 10:22:43 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> +#include <linux/types.h>
> +
> +struct ring_buffer_meta_page_header {
> +#if __BITS_PER_LONG == 64
> +	__u64	entries;
> +	__u64	overrun;
> +#else
> +	__u32	entries;
> +	__u32	overrun;
> +#endif
> +	__u32	pages_touched;
> +	__u32	meta_page_size;
> +	__u32	reader_page;	/* page ID for the reader page */
> +	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> +	__u32	data_page_head;	/* ring-buffer head as an offset from data_start */
> +	__u32	data_start;	/* offset within the meta page */
> +};
> +

I've been playing with this a bit, and I'm thinking, do we need the
data_pages[] array on the meta page?

I noticed that I'm not even using it.

Currently, we need to do a ioctl every time we finish with the reader page,
and that updates the reader_page in the meta data to point to the next page
to read. When do we need to look at the data_start section?

-- Steve
