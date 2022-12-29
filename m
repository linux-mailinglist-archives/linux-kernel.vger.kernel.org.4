Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCF8658E16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiL2Ow5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiL2Owa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:52:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F635FB1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:52:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86B83B8188B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 14:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C9C433EF;
        Thu, 29 Dec 2022 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672325547;
        bh=PMjNANa9dMUyZ7Y/RbFcEx2O4VFez054Vgv8tQMtH+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uxKIm2HrR5AOej74jYrdW1cE3mZ9U1Sr6ZOt30Yoo+0vBgLDhuKwyWogc+FaVyTc+
         6TARY78QQz8GEMyplIVVOZPPAUTP6wpIAtA3r1MbI63AEkph5t98lUvwQ/c/hbqkP8
         /gqOSr3EhKSIP1zBzak+wcdehV/mJPNMxllCc2sIkrmSh7rEeqkibTGdvZLq63nz+w
         83HwMSOBSLml47IDARnuVNZEgZQTeZAukB+V+vOHowpG/3s0D5DMOTtToUzpGMjCgl
         dwCXGOZH+PpGoLKDDL20MdVA6YpWDYaX4bo1+rjgLBIEuCmqMksqZ5lsrxZ7A7UCP4
         ffs6uVMt9x2zQ==
Date:   Thu, 29 Dec 2022 23:52:20 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     wuqiang <wuqiang.matt@bytedance.com>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v8 0/5] lib,kprobes: kretprobe scalability improvement
Message-Id: <20221229235220.4044edccae7c9d39798af8e9@kernel.org>
In-Reply-To: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
References: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Sorry, I missed to commented v7 patch. Anyway, please read
my comments on previous version.

On Sun, 18 Dec 2022 13:03:05 +0800
wuqiang <wuqiang.matt@bytedance.com> wrote:

> This patch series introduces a scalable and lockless ring-array based
> object pool and replaces the original freelist (a LIFO queue based on
> singly linked list) to improve scalability of kretprobed routines.
> 
> v8:
>   1) objpool: refcount added for objpool lifecycle management

At least this update part looks good to me.
(But I think this may be useful only for kretprobe/rethook
use cases...)

Thank you,

> 
> v7:
>   1) objpool: implementation simplified as Masami advised
>   2) rethook_alloc: error codes returning supported (ERR_PTR)
>   3) MAINTAINERS: support added for objpool files
>   4) synced to latest 6.1 with x86_64/x86/aarch64 verified
> 
> wuqiang (5):
>   lib: objpool added: ring-array based lockless MPMC queue
>   lib: objpool test module added
>   kprobes: kretprobe scalability improvement with objpool
>   kprobes: freelist.h removed
>   MAINTAINERS: objpool added
> 
>  MAINTAINERS              |   7 +
>  include/linux/freelist.h | 129 --------
>  include/linux/kprobes.h  |  11 +-
>  include/linux/objpool.h  | 116 +++++++
>  include/linux/rethook.h  |  16 +-
>  kernel/kprobes.c         |  93 +++---
>  kernel/trace/fprobe.c    |  37 +--
>  kernel/trace/rethook.c   |  91 +++---
>  lib/Kconfig.debug        |  11 +
>  lib/Makefile             |   4 +-
>  lib/objpool.c            | 372 +++++++++++++++++++++
>  lib/test_objpool.c       | 682 +++++++++++++++++++++++++++++++++++++++
>  12 files changed, 1292 insertions(+), 277 deletions(-)
>  delete mode 100644 include/linux/freelist.h
>  create mode 100644 include/linux/objpool.h
>  create mode 100644 lib/objpool.c
>  create mode 100644 lib/test_objpool.c
> 
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
