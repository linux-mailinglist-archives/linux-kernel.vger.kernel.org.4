Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC539675059
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjATJMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjATJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:12:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127CC8B75A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E97B820F9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEEEC433EF;
        Fri, 20 Jan 2023 09:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674205862;
        bh=Mv5PObAoc48ze2kh0bFVcGcaXQtmiKxGW/EeoZ9ALcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GmMGFP2BNoyT+HEdYa2dNmVtC5WNYvfQt7k2udB9OvHQt6qCdrZreig7ddItBnyir
         +wIXIhkQowwO2wyUGG9k6xsVfNog1Qn+8bU1MOOxAEXX7fdhxvYcVEnEv/eyTLut2G
         L6ggQ7x8AERp91zG/RMfIqPoYSh1O9cRjdoEOQpD4PeUm+OYTyThOZEwdMiGNIamKr
         98N9IepgPo/HXPZQgOlpm+th+5xbqxdKFiI00Ru/IQJUKFrPayRfiTcwcW3Mm0ytgT
         cvGUcydPC6z/sCOxTxWQ8Az7/uoJFO9SCg3C5is3dNP0jBpY3RpnQ432HD3PtvNdUf
         FI7iV5n0lgkag==
Date:   Fri, 20 Jan 2023 18:10:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-linus][PATCH 0/3] ktest.pl: Fix ssh hanging and reseting
 of console
Message-Id: <20230120181059.98a4094eb4267b77f156bc39@kernel.org>
In-Reply-To: <20230118215435.016435760@goodmis.org>
References: <20230118215435.016435760@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 16:54:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I've noticed that my ssh sessions would hang during test runs, which
> is really frustrating when you kick off a 13 hour test before going to
> bed, and the second test (1 hour into it) hangs, and you need to kick
> it off again in the morning (wasting all that time over night).
> 
> I finally figured out the cause. There is a disconnect between
> the run_command that executes the test, and the "wait_for_input" that
> monitors the test. The wait_for_input has a default of 2 minute timeout
> if it doesn't see any output it returns. The run_command takes the
> empty string from wait_for_input as the test is finished, and then
> stops monitoring it, and calls waitpid() waiting for the test to
> exit.
> 
> The problem is that if the test has a lot of output, it will continue
> writing into the pipe that was suppose to go to the monitor, which has
> now exited the loop. When the pipe fills up, it will not finish.
> When the test is over, it just hangs waiting for the pipe to flush
> (which never happens).
> 
> To fix this, change the run_command to by default have an infinite
> run (which can be overridden by the new RUN_TIMEOUT option), and
> make the wait_for_input also wait indefinitely in this case. It now
> Now the tests will have its content continuously read and will exit
> normally.
> 
> While debugging this, I also found out why you can lose stdout on
> the terminal sometimes. Especially if you hit Ctrl^C while the monitor
> is running. It was due to missing "end_monitor" which gives back the
> tty to the terminal. The first two patches fix that.
> 
> 

Thanks for updating. I ran the test and confirmed that the terminal
setting is recovered :)

Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, I found another issue that if I didn't set up sendmail,
it doesn't recover stty. Let me send a fix.

> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
> devel

Also, this devel branch seems not pushed yet.

Thank you,

> 
> Head SHA1: aa9aba9382884554fe6a303744884866d137422d
> 
> 
> Steven Rostedt (3):
>       ktest.pl: Fix missing "end_monitor" when machine check fails
>       ktest.pl: Give back console on Ctrt^C on monitor
>       ktest.pl: Add RUN_TIMEOUT option with default unlimited
> 
> ----
>  tools/testing/ktest/ktest.pl    | 26 +++++++++++++++++++++-----
>  tools/testing/ktest/sample.conf |  5 +++++
>  2 files changed, 26 insertions(+), 5 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
