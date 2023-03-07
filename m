Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5FF6AD454
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCGB60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCGB6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:58:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC330B15
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:58:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0080160F52
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277FCC433EF;
        Tue,  7 Mar 2023 01:58:20 +0000 (UTC)
Date:   Mon, 6 Mar 2023 20:58:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        "Chunhui Li (=?UTF-8?B?5p2O5pil6L6J?=)" <chunhui.li@mediatek.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230306205818.5a2bc51a@gandalf.local.home>
In-Reply-To: <20230307003106.1768-1-hdanton@sina.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230304031029.3037914-1-jstultz@google.com>
        <20230306010323.2909-1-hdanton@sina.com>
        <20230307003106.1768-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Mar 2023 08:31:06 +0800
Hillf Danton <hdanton@sina.com> wrote:

> On Mon, 6 Mar 2023 10:28:44 -0500 Steven Rostedt <rostedt@goodmis.org>
> > On Mon, 6 Mar 2023 09:03:23 +0800 Hillf Danton <hdanton@sina.com> wrote:  
> > >
> > > PS what sense made by spinning on owner until need_resched() with preempt
> > > disabled in the non-rt context?  
> > 
> > Not sure what the question you have here is? If need_resched() is set, we
> > want to schedule out.  
> 
> Given the critical section under mutex could be preempted, what is hard to
> understand is the wakeup of a ten-minute sleeper could not preempt a nice-10
> mutex spinner for instance.

But it can. Most wakeups are done by interrupts or softirqs. Both of which
will happen even if a task is running with preemption disabled.

-- Steve
