Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559786A11C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBWVOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBWVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:14:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3E524E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:14:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 631146179A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 21:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5107DC433D2;
        Thu, 23 Feb 2023 21:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677186843;
        bh=MUhUqx7vVGAnxY5zruGpqZ5Pgz60Ct8/k1u12vDjbB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vr/NHquQcar3bzTBEBn18RM6nlYOT2OfmkLSV0rpGdT9H0K3qFFFTstH8jfO1Xfor
         PP4ypsuevUPYWyWM5cW9FBu9DMxOKMIgyoGRTBoJCzTfhiQ+UwWEr/ar88eAaAVfw9
         E2HQa7TJiVTR84KhzRqvyO3sQ6NnIhZgCZQmXwWE=
Date:   Thu, 23 Feb 2023 13:14:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Glenn Washburn <development@efficientek.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-Id: <20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 19:11:52 -0600 Glenn Washburn <development@efficientek.com> wrote:

> Added suggestions from Jan.
> 
> Glenn
> 
> Glenn Washburn (2):
>   scripts/gdb: Correct indentation in get_current_task
>   scripts/gdb: Support getting current task struct in UML
> 

For some reason I get a bunch of rejects when applying these on top of
the latest patchpile.  Please check my end result:

def get_current_task(cpu):
    task_ptr_type = task_type.get_type().pointer()

    if utils.is_target_arch("x86"):
        if gdb.lookup_global_symbol("cpu_tasks"):
            # This is a UML kernel, which stores the current task
            # differently than other x86 sub architectures
            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
            return var_ptr.dereference()
        else:
            var_ptr = gdb.parse_and_eval("&current_task")
            return per_cpu(var_ptr, cpu).dereference()
    elif utils.is_target_arch("aarch64"):
        current_task_addr = gdb.parse_and_eval("$SP_EL0")
        if((current_task_addr >> 63) != 0):
            current_task = current_task_addr.cast(task_ptr_type)
            return current_task.dereference()
        else:
            raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                "while running in userspace(EL0)")
    else:
        raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                           "supported with this arch")



