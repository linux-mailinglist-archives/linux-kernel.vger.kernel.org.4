Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A761545A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiKAViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKAViG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3E1E73F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C114461730
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030F1C433C1;
        Tue,  1 Nov 2022 21:38:03 +0000 (UTC)
Date:   Tue, 1 Nov 2022 17:38:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Roland Ruckerbauer <roland.rucky@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        regressions@lists.linux.dev,
        Steven Noonan <steven.noonan@gmail.com>
Subject: Re: [BUG] NULL pointer dereference probably caused by
 kernel/trace/ring_buffer.c
Message-ID: <20221101173802.7a476a04@rorschach.local.home>
In-Reply-To: <CAM6WdxfYU1Dc6dkMQMSGjgiggrziLvfwVPJV5OC02_AQO8YkVw@mail.gmail.com>
References: <CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com>
        <20221031145046.2a7f9d32@rorschach.local.home>
        <CAM6WdxeZbGmRopXqLtDNTwPOahnyC6GrCfv4H1m=mF41-J=VbA@mail.gmail.com>
        <20221101153135.5345c748@rorschach.local.home>
        <CAM6WdxfYU1Dc6dkMQMSGjgiggrziLvfwVPJV5OC02_AQO8YkVw@mail.gmail.com>
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

On Tue, 1 Nov 2022 21:07:20 +0100
Roland Ruckerbauer <roland.rucky@gmail.com> wrote:

> Meaning the rbwork pointer is not null, but also not a valid pointer.
> Subtracting offset of the wait_index gives me address 0x178, which
> sure seems wrong.

Hmm, I wonder if the buffer got freed somehow. Not sure how that would
happen, as you can't free the buffer if something is opened on it.

> 
> I think I will try a gdb session with this kernel (but I have not done
> this for a long time, might take me a while to get it working).

If this is fully reproducible, could you run strace -f on rasdaemon to
see what it is doing before it crashed?

That could be very useful. At least I may be able to create a
reproducer, as my rasdaemon is working fine.

-- Steve
