Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030BD60748A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJUJ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJUJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:57:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61882256D15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:57:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 679EDED1;
        Fri, 21 Oct 2022 02:57:29 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.6.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E813F67D;
        Fri, 21 Oct 2022 02:57:21 -0700 (PDT)
Date:   Fri, 21 Oct 2022 10:57:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com>,
        jiebin.sun@intel.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tim.c.chen@linux.intel.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 percpu_counter_add_batch
Message-ID: <Y1Js/wNrjzTyYSwD@FVFF77S0Q05N>
References: <000000000000e528a905eb822440@google.com>
 <20221020194427.68571e92bc33d98a05c852aa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020194427.68571e92bc33d98a05c852aa@linux-foundation.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:44:27PM -0700, Andrew Morton wrote:
> On Thu, 20 Oct 2022 19:24:40 -0700 syzbot <syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com> wrote:

> Well.  freeque() messes with ns->percpu_msg_hdrs but msg_exit_ns()
> already did percpu_counter_destroy(&ns->percpu_msg_hdrs);
> 
> I'm thinking something like this?
> 
> --- a/ipc/msg.c~a
> +++ a/ipc/msg.c
> @@ -1329,11 +1329,11 @@ fail_msg_bytes:
>  #ifdef CONFIG_IPC_NS
>  void msg_exit_ns(struct ipc_namespace *ns)
>  {
> -	percpu_counter_destroy(&ns->percpu_msg_bytes);
> -	percpu_counter_destroy(&ns->percpu_msg_hdrs);
>  	free_ipcs(ns, &msg_ids(ns), freeque);
>  	idr_destroy(&ns->ids[IPC_MSG_IDS].ipcs_idr);
>  	rhashtable_destroy(&ns->ids[IPC_MSG_IDS].key_ht);
> +	percpu_counter_destroy(&ns->percpu_msg_bytes);
> +	percpu_counter_destroy(&ns->percpu_msg_hdrs);
>  }
>  #endif

That seems to fix the issue for me, testing with the reproducer in my prior
reply. Previously that would trigger within seconds, and with the above applied
I couldn't get it to trigger after 15+ minutes of repeated test runs.

FWIW:

  Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
