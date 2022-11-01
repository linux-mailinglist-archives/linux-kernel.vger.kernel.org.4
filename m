Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C4615524
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKAWgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKAWgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC420F63
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA6CB61746
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1DC433C1;
        Tue,  1 Nov 2022 22:35:14 +0000 (UTC)
Date:   Tue, 1 Nov 2022 18:35:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Roland Ruckerbauer <roland.rucky@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        regressions@lists.linux.dev,
        Steven Noonan <steven.noonan@gmail.com>
Subject: Re: [BUG] NULL pointer dereference probably caused by
 kernel/trace/ring_buffer.c
Message-ID: <20221101183512.285cfd68@rorschach.local.home>
In-Reply-To: <CAM6WdxfsP13aS62=xWNTFEEzAekAuDwFTpnONP9qF3br-65KWQ@mail.gmail.com>
References: <CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com>
        <20221031145046.2a7f9d32@rorschach.local.home>
        <CAM6WdxeZbGmRopXqLtDNTwPOahnyC6GrCfv4H1m=mF41-J=VbA@mail.gmail.com>
        <20221101153135.5345c748@rorschach.local.home>
        <CAM6WdxfYU1Dc6dkMQMSGjgiggrziLvfwVPJV5OC02_AQO8YkVw@mail.gmail.com>
        <20221101173802.7a476a04@rorschach.local.home>
        <CAM6WdxdAF5X8v_tbL1LvNDXgEPY5veL_OtQv5CrADV9qH4um-g@mail.gmail.com>
        <CAM6WdxfsP13aS62=xWNTFEEzAekAuDwFTpnONP9qF3br-65KWQ@mail.gmail.com>
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

On Tue, 1 Nov 2022 23:01:38 +0100
Roland Ruckerbauer <roland.rucky@gmail.com> wrote:

> Just figured out something, the poll() errors starting at fd 29 (which
> is CPU 24).
> But I only have 24 cores. Looked at
> /sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/, and voila, it
> lists 32 cpus not 24.

Ah, and this explains why I never triggered it. There's some machines
that list nr_cpu_ids as more than what exists (I guess it is "possible
CPUs" and not "actual CPUs").

OK, this is a great clue. I'll dig deeper.

Thanks a lot for telling me this.

Takashi, can you check if the problem machines have more CPUs listed in
/sys/kernel/tracing/per_cpu/cpu* than is on the machine?

-- Steve
