Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC36645B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjAJQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjAJQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:12:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590EC53729
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:12:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 149C0B81178
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1831C433EF;
        Tue, 10 Jan 2023 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673367150;
        bh=BHR15KV7j/mY6DkIeo7xOuawAwemaEc/pZ+yDqH89rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVFp8Erub9/6Z2hg1mpXGwPhgS5X08t85PQ1pkQkCVYK+HsdVCOAcPm1t5MR7jooc
         YCKYE72SZTNpscwPf5m1bEmMZJN5ix+AXHxnQV+Pp9XPIwLGO9WSwSKz1Td0oUqp1s
         +Yj6fDpn0e7ATw45dQp2hrlFbnsabKpFlQyefvxiiqegOrZXEbtnOMTmuexIQzi/sy
         6baqh5jodXMEk7HZZ8A66b90gWnOLFvljN6eUZjCOXaO0m3l+v2GRA2/JJtoAWOgkY
         qAwwdkUtDEkNaWU3bTM/t7+7OsLZBRdo1heIx8unFSmunA1ISl4iIGgQUT0Ir0UVGi
         dcGDyCd7JaIOw==
Date:   Tue, 10 Jan 2023 17:12:22 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 3/6] mm/vmstat: manage per-CPU stats from CPU context
 when NOHZ full
Message-ID: <Y72OZn6mULPX4xk8@lothringen>
References: <20230105125218.031928326@redhat.com>
 <20230106001244.4463-1-hdanton@sina.com>
 <20230106150154.4560-1-hdanton@sina.com>
 <20230107001529.4617-1-hdanton@sina.com>
 <20230110024356.336-1-hdanton@sina.com>
 <20230110151901.402-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110151901.402-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:19:01PM +0800, Hillf Danton wrote:
> On Tue, 10 Jan 2023 08:50:28 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > On Tue, Jan 10, 2023 at 10:43:56AM +0800, Hillf Danton wrote:
> > > On 9 Jan 2023 11:12:49 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > > > 
> > > > Yes, but if you do not return to userspace, then the per-CPU vm
> > > > statistics can be dirty indefinitely.
> > > 
> > > Could you specify the reasons for failing to return to userspace,
> > > given it is undesired intereference for the shepherd to queue work
> > > on the isolated CPUs.
> > 
> > Any system call that takes longer than the threshold to sync vmstats.
> 
> Which ones?
> 
> If schedule() occurs during syscall because of acquiring mutex for instance
> then anything on the isolated runqueue, including workqueue worker shepherd
> wakes up, can burn CPU cycles without undesired intereference produced.

The above confuses me. How others tasks would help with syscalls that take too long too
service?

> > 
> > Or a long running kernel thread, for example:
> 
> It is a buggyyyy example.
> > 
> > https://stackoverflow.com/questions/65111483/long-running-kthread-and-synchronize-net

I can imagine a CPU spending most of its time processing networking packets
through interrupts/softirq within ksoftirqd/NAPI while another CPU process
these packets in userspace.

In this case the CPU handling the kernel part can theoretically never go to
idle/user. nohz_full isn't optimized toward such job but there is nothing
to prevent it from doing such job.

Thanks.

