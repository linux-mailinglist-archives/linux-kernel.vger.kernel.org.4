Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1867E6BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjA0Na0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjA0NaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:30:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044FB77524
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:30:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674826221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOq4yEH/rOwp7LST7D8Dgw1Lwguxsb+DT7aJCsnG33A=;
        b=xLKlrUJBZgPZ6HT6RPJbGdF44uE34gGO9k9bG4zEN39vsO9W+i/8N5lGJp9YweIL6ykdnN
        FSh+TvUBQd0+Bqx9RnCNaDsm0rvUa07HEdBlrIGO8FsVuZakQFHwrLUMA/cTfkmAh5Ef85
        4aUijlXlwvaWDQGgoBLe3CMxOKXp3+m7psGraoYTN7mZYScb09MPlje6ZEs/0oEnQqzHmQ
        +NDKZbAVXat/Lilmjyq05ai8JeaMF2C0WKKGzLogGBxVJ46E602TaN5tmamY80yyARvqvQ
        prOwP1wZLL7vXNl4J7Wer4NHZfw+w51/Vw7hrSG7k/aP3LxehBuwkna3RBeT8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674826221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOq4yEH/rOwp7LST7D8Dgw1Lwguxsb+DT7aJCsnG33A=;
        b=V9ZZGdKtDlNrdd3/Y/3LbHEmWZC+U1rl4CXDH2+pxnFGKFSI6J1swumLs32152y0DqFhU9
        FjJBQ6CZj4jKz1AA==
To:     Stephane Eranian <eranian@google.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time
 to monotonic
In-Reply-To: <CABPqkBSt2WH=zo0_tXNb_Q7waDazvcquXgexXqqn=70A_f4H8Q@mail.gmail.com>
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com> <87sfg0gvrk.ffs@tglx>
 <CABPqkBSt2WH=zo0_tXNb_Q7waDazvcquXgexXqqn=70A_f4H8Q@mail.gmail.com>
Date:   Fri, 27 Jan 2023 14:30:20 +0100
Message-ID: <87ilgsgl5f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24 2023 at 01:10, Stephane Eranian wrote:
> On Tue, Jan 24, 2023 at 12:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > It's useful to provide a NMI safe function to convert a given time to
>> > monotonic. For example, the perf_event subsystem wants to convert a TSC
>> > of a PEBS record to a monotonic clock in a NMI handler.
>>
>> Why? That's a postprocessing problem, really.
>>
> Because you want to correlate samples captured by PEBS with samples
> from applications timestamped with a user available clock such as
> CLOCK_MONOTONIC, for instance.

Sure. Postprocessing can do that if the kernel provides the relevant
conversion information. Absolutely no need for doing this in the kernel.

> When I create a perf_event event and I stipulate that
> event_attr.clockid=MONOTONIC, I expect all the samples from that event
> to be timestamped using the same clock source, regardless of PEBS or
> IBS.

Just because the kernel can do the conversion, there is no requirement
to actually do so. Instrumentation has to be as lightweight as possible
and a lot of instrumentation goes the extra mile of doing postprocessing
exactly for this reason.

So if we implement this conversion in the kernel then there needs to be
a compelling technical reason to do so.

So far the provided arguments are in the 'I want a pony' realm.

Thanks,

        tglx
