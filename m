Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC06A460B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjB0P2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjB0P2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30A7DBC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:28:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6514060EB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C35C433EF;
        Mon, 27 Feb 2023 15:28:10 +0000 (UTC)
Date:   Mon, 27 Feb 2023 10:28:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Schspa Shi <schspa@gmail.com>, linux-kernel@vger.kernel.org,
        cocci@inria.fr, mcgrof@kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        buytenh@wantstofly.org, johannes.berg@intel.com,
        gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch
Subject: Re: [RFC PATCH] cocci: cpi: add complete api check script
Message-ID: <20230227102808.2cea9705@gandalf.local.home>
In-Reply-To: <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
        <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
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

On Mon, 27 Feb 2023 12:20:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 27, 2023 at 03:53:47PM +0800, Schspa Shi wrote:
> > When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
> > process won't reference the completion variable on stack. For a
> > killable/interruptiable version, we need extra code(add locks/use xchg) to
> > ensure this.
> > 
> > This patch provide a SmPL script to detect bad
> > DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.  
> 
> Documentation/process/submitting-patches.rst:instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> 
> But also, wth is SmPL, the actual thing included is a coccinelle script.
> 
> > This is a common problem, and a lot of drivers have simpler problem. The
> > fellowing is a list of problems find by this SmPL patch, due to the complex
> > use of wait_for_complete* API, there will still be some false negatives and
> > false positives. This RFC patch is mainly used to discuss improvement
> > methods. If we introduce the wait_for_complete*_onstack API, it will be
> > easier to modify these problems, and the patch rules of SmPL will be very
> > easy. In the process of trying to write SmPL scripts, I strongly recommend
> > introducing two onstack APIs to complete this operation.
> > 
> > file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack  
> 
> What's with this retarded file path? Are you running on Windows or
> something daft like that?
> 
> Please, make them relative to srctree.

Also, you want to state what sha1 or tag you ran this on. The one file I
looked at didn't match line numbers.

I looked at:

drivers/ufs/core/ufshcd.c

Which has (what I'm assuming is the issue that was detected?)

        /* wait until the task management command is completed */
        err = wait_for_completion_io_timeout(&wait,
                        msecs_to_jiffies(TM_CMD_TIMEOUT));
        if (!err) { 
                ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_ERR);
                dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
                                __func__, tm_function);
                if (ufshcd_clear_tm_cmd(hba, task_tag))
                        dev_WARN(hba->dev, "%s: unable to clear tm cmd (slot %d) after timeout\n",
                                        __func__, task_tag);
                err = -ETIMEDOUT;
        } else {        
                err = 0;        
                memcpy(treq, hba->utmrdl_base_addr + task_tag, sizeof(*treq));
                
                ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_COMP);
        }       
   
        spin_lock_irqsave(hba->host->host_lock, flags);
        hba->tmf_rqs[req->tag] = NULL;
        __clear_bit(task_tag, &hba->outstanding_tasks);
        spin_unlock_irqrestore(hba->host->host_lock, flags);

IIUC, the above spin lock protection will prevent the use after free of the
completion. As the completion still exists between the timedout wait, and
the start of the spinlock. And the spinlock will keep the complete from
being visible if that were to run after the spinlock.

So what exact race are you trying to catch here?

-- Steve

