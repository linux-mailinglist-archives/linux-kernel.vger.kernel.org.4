Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209906D0969
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjC3PXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjC3PXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50280D31D;
        Thu, 30 Mar 2023 08:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AAE5620D0;
        Thu, 30 Mar 2023 15:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AD1C4339B;
        Thu, 30 Mar 2023 15:21:05 +0000 (UTC)
Date:   Thu, 30 Mar 2023 11:21:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230330112103.00c3f422@gandalf.local.home>
In-Reply-To: <ZCVk26InuXhy+Lmg@google.com>
References: <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
        <20230329085106.046a8991@rorschach.local.home>
        <ZCQ2jW5Jl/cWCG7s@google.com>
        <20230329091107.408d63a8@rorschach.local.home>
        <ZCQ9m5K34Qa9ZkUd@google.com>
        <20230329093602.2b3243f0@rorschach.local.home>
        <ZCRDXaTVfNwxdRJZ@google.com>
        <20230329113234.3285209c@gandalf.local.home>
        <ZCVk26InuXhy+Lmg@google.com>
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

On Thu, 30 Mar 2023 11:30:51 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> How about?
> 
> userspace:
> 
>   prev_read = meta->read;
>   ioctl(TRACE_MMAP_IOCTL_GET_READER_PAGE)
> 
> kernel:
>     ring_buffer_get_reader_page()
>       rb_get_reader_page(cpu_buffer);
>       cpu_buffer->reader_page->read = rb_page_size(reader);
>       meta->read = cpu_buffer->reader_page->read;
> 
> userspace:
>    /* if new page prev_read = 0 */
>    /* read between prev_read and meta->read */
> 
> If the writer does anything in-between, wouldn't rb_get_reader_page() handle it
> nicely by returning the same reader as more would be there to read?
> 
> It is similar to rb_advance_reader() except we'd be moving several events at
> once?

Yeah, I think that can work. So we just need to make sure that the meta
page has the "read" variable passed through.

-- Steve
