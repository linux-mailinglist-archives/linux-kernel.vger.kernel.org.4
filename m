Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153FB66400B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjAJMOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjAJMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:13:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF055689F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:12:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD73D6164B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB573C433D2;
        Tue, 10 Jan 2023 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673352732;
        bh=IwWkvSRf3Gwtk3/2fKB8W1LEqyUfjSb4cgN/1aunrQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIvNCBCQeSJAb0ufgFn2X7p6SO0YRwIfLXnoYtIe+CernyIifOQT6NpABFLGqn+xR
         UyPXcKmi1oX7mrFO/7JBEkKgtqgfxrQ1Dxk98crXX98ZkfwpEvS+OTSpaO60+8Yu9e
         8D6EKNs2bXFEyTWA2iZipQIb8vbHt7UXjWm2+fm3YeKeOcRSwgYdwQK0bmT8du/QFS
         4bNqzXOTjKc2hf94w/WzSP3hZ06fCMOKgPWETpkDhoJsBz5Ntnlh8eba4KYprcw/MG
         p78LxzkJT22wgQftVlJGdCChOy3VQ/TyJ6ChLTOw6OKODOGYZM9Tbv6NhWvmNheteq
         Ajox8DEAuPslg==
Date:   Tue, 10 Jan 2023 13:12:09 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 1/6] mm/vmstat: Add CPU-specific variable to track a
 vmstat discrepancy
Message-ID: <Y71WGeT2+6s4ewfv@lothringen>
References: <20230105125218.031928326@redhat.com>
 <20230105125248.772766288@redhat.com>
 <e9673684-ef3-4070-18bd-2f20fbfe8d5@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9673684-ef3-4070-18bd-2f20fbfe8d5@gentwo.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:58:32PM +0100, Christoph Lameter wrote:
> On Thu, 5 Jan 2023, Marcelo Tosatti wrote:
> 
> > +static inline void vmstat_mark_dirty(void)
> > +{
> > +	this_cpu_write(vmstat_dirty, true);
> > +}
> 
> this_cpu_write() is intended for an per cpu atomic context. You are not
> using it in that way. The processor may have changed before or after and
> thus vmstat_dirty for another CPU may  have been marked dirty.
> 
> I guess this would have to be called __vmstat_mark_dirty() and be using
> __this_cpu_write(*) with a requirement that preemption be disabled before
> using this function.

You're right. So this patchset also arranges for these vmstat functions to be
called with preemption disabled. I'm converting the this_cpu operations
to __this_cpu versions to make sure of that. And I believe the __this_cpu
WARN if preemptible().


> 
> > +static inline void vmstat_clear_dirty(void)
> > +{
> > +	this_cpu_write(vmstat_dirty, false);
> > +}
> 
> Same
> 
> > +static inline bool is_vmstat_dirty(void)
> > +{
> > +	return this_cpu_read(vmstat_dirty);
> > +}
> 
> This function would only work correctly if preemption is disabled.
> Otherwise the processor may change.

Indeed that should apply as __this_cpu_read() as well.

Thanks!

