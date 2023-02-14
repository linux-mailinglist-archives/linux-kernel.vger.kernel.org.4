Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497B3696EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjBNUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjBNUz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:55:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B2298CC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:55:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676408154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUOIZuJdLZ75nj03a3zeKvglfxGqzebdblZ7SweGKPY=;
        b=FCNHyRxr41HuCa/UjE2mA1iF7ZoMHxJYx00ntnQlL2shoAr6pidRP5/bB1WsI40dh64NVF
        CQ2ZIa183BNcW72WhedH/SumgCQdruBgQk6JW/C7Z1cgJHAhDUbGIHwer9PeKeoFvCGQu2
        BQrzbgmNnM33lPHf0AzetAbO6AnfT+DHUwMYWVgWgYFodShM7Jg6QKFPzY7SoLvX8lXjk2
        vx2OpSxrNpxSoAElgNlG7F1rjRyU1rsPLxZt4/QszfEHIo0l8OvLWqhK6uu0jpZv0RYmZB
        Xpy2QrJp0SDZf3jlO0Q5Ykvv9yybNOXpCV+ibxwDdGFY087esuV4tWFPOf5+2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676408154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUOIZuJdLZ75nj03a3zeKvglfxGqzebdblZ7SweGKPY=;
        b=iTtLTSUryfnTWb17wWZcxtclMcVfEAod4aGFDhvwA3ycITeDM3JKh/YzK/zdjmdHoSjfxG
        zrCHjCpY0FJL5IDw==
To:     "Liang, Kan" <kan.liang@linux.intel.com>, jstultz@google.com,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC PATCH V2 4/9] perf/x86: Enable post-processing monotonic
 raw conversion
In-Reply-To: <4372ae84-76e2-8bae-b0ad-87102973df67@linux.intel.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-5-kan.liang@linux.intel.com> <875yc4rp68.ffs@tglx>
 <4372ae84-76e2-8bae-b0ad-87102973df67@linux.intel.com>
Date:   Tue, 14 Feb 2023 21:55:53 +0100
Message-ID: <873578rmp2.ffs@tglx>
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

On Tue, Feb 14 2023 at 15:21, Kan Liang wrote:
> On 2023-02-14 3:02 p.m., Thomas Gleixner wrote:
>> 
>> What guarantees that the clocksource used by the timekeeping core is
>> actually TSC? Nothing at all. You cannot make assumptions here.
>> 
>
> Yes, you are right.
> I will add a check to make sure the clocksource is TSC when perf does
> the conversion.
>
> Could you please comment on whether the patch is in the right direction?
> This V2 patch series expose the kernel internal conversion information
> into the user space. Is it OK for you?

Making the conversion info an ABI is suboptimal at best. I'm still
trying to wrap my brain around all of this. Will reply over there once
my confusion subsides.

Thanks,

        tglx


