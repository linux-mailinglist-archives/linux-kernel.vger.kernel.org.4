Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF96B48EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjCJPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjCJPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C770E134837;
        Fri, 10 Mar 2023 07:00:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 715C261982;
        Fri, 10 Mar 2023 14:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B072C433A4;
        Fri, 10 Mar 2023 14:59:58 +0000 (UTC)
Date:   Fri, 10 Mar 2023 09:59:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        oe-kbuild-all@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Error if a trace event has an array for a
 __field()
Message-ID: <20230310095956.0bab1790@gandalf.local.home>
In-Reply-To: <202303101645.28bnQoH2-lkp@intel.com>
References: <20230309221302.642e82d9@gandalf.local.home>
        <202303101645.28bnQoH2-lkp@intel.com>
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

On Fri, 10 Mar 2023 16:37:09 +0800
kernel test robot <lkp@intel.com> wrote:

>    include/trace/events/rcu.h:771:17: note: in expansion of macro '__field'
>      771 |                 __field(char, rcutorturename[RCUTORTURENAME_LEN])
>          |                 ^~~~~~~

Awesome, it found the bug that this patch is suppose to find! :-)

The above needs to be changed to:

		__array(char, rcutorturename, RCUTORTURENAME_LEN)

And my patch will fail builds that have arrays in __field() macros.

Yes, I'm not going to apply this patch until the current bugs in the kernel
are fixed, because this patch will cause the kernel not to build if it has
this type of bug.

-- Steve
