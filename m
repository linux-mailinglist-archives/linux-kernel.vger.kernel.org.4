Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919AA633360
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKVCeL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 21:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiKVCeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:34:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC1BF5BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:34:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2907BB81603
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A06C433C1;
        Tue, 22 Nov 2022 02:34:04 +0000 (UTC)
Date:   Mon, 21 Nov 2022 21:34:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: avoid replacing the list func with itself
Message-ID: <20221121213402.154adf09@rorschach.local.home>
In-Reply-To: <CAAYs2=iOvP-TxLs+_QFMLQHG86xi2PYK_CN_rXUWHBx=kY+1aw@mail.gmail.com>
References: <20221026132039.2236233-1-suagrfillet@gmail.com>
        <CAAYs2=iOvP-TxLs+_QFMLQHG86xi2PYK_CN_rXUWHBx=kY+1aw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 02:28:25 +0000
Song Shuai <suagrfillet@gmail.com> wrote:

> Song Shuai <suagrfillet@gmail.com> 于2022年10月26日周三 13:20写道：
> >
> > The list func (ftrace_ops_list_func) will be patched first
> > before the transition between old and new calls are set,
> > which fixed the race described in this commit `59338f75`.
> >
> > While ftrace_trace_function changes from the list func to a
> > ftrace_ops func, like unregistering the klp_ops to leave the only
> > global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
> > replaced with the list func although it already exists. So there
> > should be a condition to avoid this.
> >
> > This patch backups saved_ftrace_func by saved_ftrace_func_old
> > which will be compared with the list func before trying to patch it.
> >  
> Ping...

Thanks for the ping. I had thought I had replied to this, but I don't
see it in my sent folder. I may have been distracted, and lost the
message.

I'll take a look at it tomorrow.

-- Steve
