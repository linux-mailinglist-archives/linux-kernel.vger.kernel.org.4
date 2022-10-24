Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC760ACB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiJXOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiJXOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:09:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B5B2C4D90;
        Mon, 24 Oct 2022 05:51:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C6D3ED1;
        Mon, 24 Oct 2022 05:21:07 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2D8A3F7B4;
        Mon, 24 Oct 2022 05:20:59 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:20:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [BUG] possible deadlock in __rcu_irq_enter_check_tick
Message-ID: <Y1aDKeFzYNrpt7ww@FVFF77S0Q05N>
References: <e015e32d-d068-2d17-1ca5-c584c30ffebb@huawei.com>
 <20221012064911.GN4221@paulmck-ThinkPad-P17-Gen-1>
 <Y063MGk3oVg6ney0@lakrids>
 <Y1AGWuwZsq/NW1U3@FVFF77S0Q05N>
 <97cfec0d-a24b-9917-2bd1-404e344eaa36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97cfec0d-a24b-9917-2bd1-404e344eaa36@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:32:35PM +0800, Yu Liao wrote:
> On 2022/10/19 22:14, Mark Rutland wrote:
> > On Tue, Oct 18, 2022 at 03:24:48PM +0100, Mark Rutland wrote:

> > Having a go with v6.1-rc1, placing a kprobe on __rcu_irq_enter_check_tick()
> > causes a recursive exception which triggers the stack overflow detection, so
> > there are bigger problems here, and we'll need to do some further rework of the
> > arm64 entry code. FWIW, x86-64 seems fine.
> > 
> > I have a vague recollection that that there was something (some part kprobes,
> > perhaps) that didn't like being called in NMI context, which is why debug
> > exceptions aren't accounted as true NMIs (but get most of the same treatment).
> > 
> > I'll have to dig into this a bit more; there are a bunch of subtle interactions
> > in this area, and I don't want to put a band-aid over this without fully
> > understanding the implications.
> > 
> > Once we've figured that out for mainline, we can figure out what needs to go to
> > stable.
> > 
> > Yu, were you particularly interested in tracing __rcu_irq_enter_check_tick(),
> > or did you stumble upon this by other means?

> Oh，This was found with the help of the kernel fuzzer syzkaller.

Thanks for confirming!

I've also been testing with Syzkaller, but it looks like I haven't had KPROBES
enabled due to deselecting MODULE support, which explains how I've missed this
until now. :/

I'll go fiddle with moy configs.

Thanks,
Mark.
