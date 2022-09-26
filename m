Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215BC5EA7D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiIZOBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiIZOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:01:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278146DAC;
        Mon, 26 Sep 2022 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ejE6IXHMsmMDdxnD5959e9TnKubLT7CerN02Zwf5J4=; b=XAuv0lr+RMSckyM/dkw/5MaDON
        FMJCrB6/V+FQ3BqSRYEqeeVy8wdHqGIOxPoVKxbX0Z6/6uoY0cH60CZIlzhhsLrg5gJr8jC2Em9Jr
        eM8UJlBgmVKtEuo4C8z9FrXz26NPzz8CGlxcQx5wHc/PDFP7q3vgdCasd/Tf5cPFA0AKxkG0Jb1lM
        egkGw8v+3tKOvL/gSlHwmrynTxfGPc4/E4nJcrv6AE7udvyvB13zXxZ6JR2AWB6RTJ8RgY+v2rbep
        wdMPpSf7YH+J7QGhsjFvM0UGCR3Z6KxQTIzj/GvzaqJlvsqhoMbO4a9Z+N2Ke/I2sqVmyd3JenIbg
        s3VZPxaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocmzj-00G1GD-7d; Mon, 26 Sep 2022 12:13:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C9813002F1;
        Mon, 26 Sep 2022 14:13:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8261D29A13691; Mon, 26 Sep 2022 14:13:53 +0200 (CEST)
Date:   Mon, 26 Sep 2022 14:13:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>, amit@kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzGXgbfRngNfDhoC@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 12:55:21PM +0200, Christian Borntraeger wrote:
> 
> 
> Am 26.09.22 um 10:06 schrieb Christian Borntraeger:
> > 
> > 
> > Am 23.09.22 um 09:53 schrieb Christian Borntraeger:
> > > Am 23.09.22 um 09:21 schrieb Christian Borntraeger:
> > > > Peter,
> > > > 
> > > > as a heads-up. This commit (bisected and verified) triggers a
> > > > regression in our KVM on s390x CI. The symptom is that a specific
> > > > testcase (start a guest with next kernel and a poky ramdisk,
> > > > then ssh via vsock into the guest and run the reboot command) now
> > > > takes much longer (300 instead of 20 seconds). From a first look
> > > > it seems that the sshd takes very long to end during shutdown
> > > > but I have not looked into that yet.
> > > > Any quick idea?
> > > > 
> > > > Christian
> > > 
> > > the sshd seems to hang in virtio-serial (not vsock).
> > 
> > FWIW, sshd does not seem to hang, instead it seems to busy loop in
> > wait_port_writable calling into the scheduler over and over again.
> 
> -#define TASK_FREEZABLE                 0x00002000
> +#define TASK_FREEZABLE                 0x00000000
> 
> "Fixes" the issue. Just have to find out which of users is responsible.

Since it's not the wait_port_writable() one -- we already tested that by
virtue of 's/wait_event_freezable/wait_event/' there, it must be on the
producing side of that port. But I'm having a wee bit of trouble
following that code.

Is there a task stuck in FROZEN state? -- then again, I thought you said
there was no actual suspend involved, so that should not be it either.

I'm curious though -- how far does it get into the scheduler? It should
call schedule() with __state == TASK_INTERRUPTIBLE|TASK_FREEZABLE, which
is quite sufficient to get it off the runqueue, who then puts it back?
Or is it bailing early in the wait_event loop?
