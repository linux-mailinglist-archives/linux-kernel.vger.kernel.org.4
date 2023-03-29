Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874A66CD91F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjC2MIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC2MIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:08:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054553C0F;
        Wed, 29 Mar 2023 05:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA7F5B822E4;
        Wed, 29 Mar 2023 12:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AC6C433D2;
        Wed, 29 Mar 2023 12:08:07 +0000 (UTC)
Date:   Wed, 29 Mar 2023 08:07:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329080758.0e730796@rorschach.local.home>
In-Reply-To: <20230329070353.1e1b443b@gandalf.local.home>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
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

On Wed, 29 Mar 2023 07:03:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> struct ring_buffer_meta_page_header {
> #if __BITS_PER_LONG == 64
> 	__u64	entries;
> 	__u64	overrun;
> #else
> 	__u32	entries;
> 	__u32	overrun;
> #endif
> 	__u32	pages_touched;
> 	__u32	meta_page_size;
> 	__u32	reader_page;	/* page ID for the reader page */
> 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> };
> 
> BTW, shouldn't the nr_data_pages take into account the reader page? As it
> is part of the array we traverse isn't it?

Ah, I guess nr_data_pages is the length of the index mapping, not the
array of pages mapped?

-- Steve
