Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC24C6CDAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjC2NhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjC2NhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:37:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D664EF5;
        Wed, 29 Mar 2023 06:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E85ABB819BA;
        Wed, 29 Mar 2023 13:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC3DC433D2;
        Wed, 29 Mar 2023 13:36:53 +0000 (UTC)
Date:   Wed, 29 Mar 2023 09:36:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329093602.2b3243f0@rorschach.local.home>
In-Reply-To: <ZCQ9m5K34Qa9ZkUd@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
        <20230329085106.046a8991@rorschach.local.home>
        <ZCQ2jW5Jl/cWCG7s@google.com>
        <20230329091107.408d63a8@rorschach.local.home>
        <ZCQ9m5K34Qa9ZkUd@google.com>
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

On Wed, 29 Mar 2023 14:31:07 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> We can say we update cpu_buffer->reader_page->read on the get_reader_page ioctl,
> to the most recent value possible, which will have the consequence of actually
> "flushing" those events?

Yes. It should be no different than doing a normal read of the
trace_pipe_raw file, which does the same.

> 
> If the reader decides to read events past this value then it just can't expect
> them to not be duplicated?
> 
> I suppose it'd be down the reader to store meta->read somehwere?
> 
>    prev_read = meta->read
>    ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE)
>    /* read events from prev_read to meta->read */

Yes, in fact it shouldn't need to call the ioctl until after it read it.

Maybe, we should have the ioctl take a parameter of how much was read?
To prevent races?

That is, it should pass in the page->commit that it used to to read the
pages.

-- Steve
