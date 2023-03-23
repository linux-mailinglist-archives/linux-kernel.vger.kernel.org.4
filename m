Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869D66C6B90
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjCWOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCWOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:51:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3F28D3D;
        Thu, 23 Mar 2023 07:51:11 -0700 (PDT)
Date:   Thu, 23 Mar 2023 15:50:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679583058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5o2MPXJCgFIgnNJKhtXeeNCN/6hD2P+cFhnX3GBZmc=;
        b=OWWXL3V4K1U7BYpFn2T+xGugKbT3cIzYhRDF0dAzTbZhF+pcCjOIlpsnqtYYewDR1TA8Io
        P7yQ5ULX6x2E8dqtySjAEz1xw6uXh+9hjsHwFZjOQY96mZRPBax5HXxdNP7jjtxyo1CIpB
        bBM0lAHTnzqDadg6trHyu5LtS1YrJICTr8GX7WLA6OxshoVdJpJEf/dZo7zYLgazB7bXkU
        tTqWbVnao6CSYLi5eRORYhOLmtPLeJcrQrvfwvpjNIyb/7y/8zJU0xNJ3/Uwb90BpDxP+p
        mCCcfzmSOKLrv0dvY7dFzz44GpoMMYh26oWlwIDAMWV32mhPuIhwymN3oGMnBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679583058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5o2MPXJCgFIgnNJKhtXeeNCN/6hD2P+cFhnX3GBZmc=;
        b=AeXjS6AH+AICM0G/kBylrFf3FGaWq5lZLafjGPDlHHklwTBNCVD30KIXy+ECkZOYTX0Dic
        hwr0pG61UwMYs7CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Crystal Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
Message-ID: <20230323145057.CNQ_eJce@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
 <Y+47FVJ+hI+NA2In@linutronix.de>
 <87k00cr7ix.ffs@tglx>
 <Y/NT1/ynarp9cDlS@linutronix.de>
 <Y/NcnrwKr2u6tamQ@linutronix.de>
 <874jrgqjsw.ffs@tglx>
 <84c1de84ac129de7c7597c48d3ec19ccc0672492.camel@redhat.com>
 <20230322164130.CmC_J49n@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322164130.CmC_J49n@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-22 17:41:31 [+0100], To Crystal Wood wrote:
> On 2023-03-04 23:39:57 [-0600], Crystal Wood wrote:
> > Are there any workloads I could run to stress out that path (with my
> > asserts in place)?
> 
> None that I can think of. Maybe something from the io-ring test suite.
> But then you may need to bend to code to get the task_add() to fail.
> Maybe Jens knows something.

quick question: Can you throw your testing on the patch I sent checking
if this really cures the problem you see?

> > -Scott

Sebastian
